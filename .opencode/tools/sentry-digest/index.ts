import axios from 'axios';

// --- Configuration ---
const SENTRY_ORG_SLUG = process.env.SENTRY_ORG_SLUG;
const SENTRY_PROJECT_SLUG = process.env.SENTRY_PROJECT_SLUG;
const SENTRY_AUTH_TOKEN = process.env.SENTRY_AUTH_TOKEN;

const MAX_ISSUES = 10;
const TIME_RANGE_DAYS = 7;

if (!SENTRY_ORG_SLUG || !SENTRY_PROJECT_SLUG || !SENTRY_AUTH_TOKEN) {
    console.error("Missing environment variables: SENTRY_ORG_SLUG, SENTRY_PROJECT_SLUG, and SENTRY_AUTH_TOKEN must be set.");
    process.exit(1);
}

// Sentry API Issue Type (minimal)
interface SentryIssue {
    permalink: string;
    title: string;
    count: number;
    userCount: number;
    lastSeen: string;
    firstSeen: string;
}

// Helper to get ISO date string for X days ago
function daysAgo(days: number): string {
    const d = new Date();
    d.setDate(d.getDate() - days);
    return d.toISOString();
}

// Fetches all issues for the last TIME_RANGE_DAYS
async function fetchIssues(): Promise<SentryIssue[]> {
    const since = daysAgo(TIME_RANGE_DAYS);
    // Query for unresolved issues that appeared in the last 7 days, sorted by newness
    const baseQuery = `is:unresolved firstSeen:>=${since}`;
    const apiUrl = `https://sentry.io/api/0/projects/${SENTRY_ORG_SLUG}/${SENTRY_PROJECT_SLUG}/issues/`;

    let allIssues: SentryIssue[] = [];
    let cursor: string | null = null;
    let nextPage = true;

    try {
        while (nextPage) {
            const params: Record<string, any> = {
                query: baseQuery,
                sort: 'date',
                per_page: 100,
                ...(cursor && { cursor }),
            };

            const response = await axios.get<SentryIssue[]>(apiUrl, {
                headers: {
                    Authorization: `Bearer ${SENTRY_AUTH_TOKEN}`,
                },
                params,
            });

            const linkHeader: string | undefined = response.headers.link;
            allIssues.push(...response.data);

            // Check the Link header for pagination
            const nextMatch: RegExpMatchArray | null | undefined = linkHeader?.match(/<(.*?)>; rel="next"/);
            if (nextMatch) {
                const nextUrl = new URL(nextMatch[1]);
                cursor = nextUrl.searchParams.get('cursor');
            } else {
                nextPage = false;
            }
        }
    } catch (error) {
        return [];
    }
    
    // Sentry returns results sorted by 'date', which is last seen. 
    // For a digest, we prefer to sort by frequency ('count') or the number of users affected.
    allIssues.sort((a, b) => b.count - a.count);

    return allIssues.slice(0, MAX_ISSUES);
}

function formatDigest(issues: SentryIssue[]): string {
    if (issues.length === 0) {
        return `✅ No new unresolved errors found in the last ${TIME_RANGE_DAYS} days for **${SENTRY_PROJECT_SLUG}**.\n\nTimeframe: ${daysAgo(TIME_RANGE_DAYS).substring(0, 10)} to now`;
    }

    const header = `🚨 Weekly Sentry Digest for **${SENTRY_PROJECT_SLUG}**\n\n`;
    
    const summary = `Found ${issues.length} top issues in the last ${TIME_RANGE_DAYS} days. Timeframe: ${daysAgo(TIME_RANGE_DAYS).substring(0, 10)} to now\n\n`;
    
    const issueList = issues.map((issue, index) => {
        const title = issue.title.replace(/\n/g, ' ');
        return `${index + 1}. [**${title}**] (${issue.count} events, ${issue.userCount} users)\n   🔗 ${issue.permalink}\n`;
    }).join('');

    const footer = issues.length < MAX_ISSUES ? '' : `\n...and more. See Sentry for full list.`;

    return header + summary + issueList + footer;
}

async function main() {
    const issues = await fetchIssues();
    const digest = formatDigest(issues);
    console.log(digest);
}

main();