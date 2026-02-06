#!/bin/bash
# Delete an opencode-scheduler job
# Usage: ./delete_job.sh <job_name>

set -e

JOB_NAME="$1"

if [ -z "$JOB_NAME" ]; then
    echo "Usage: $0 <job_name>"
    echo "Example: $0 daily-backup"
    exit 1
fi

# Stop and disable
echo "Stopping job: $JOB_NAME"
systemctl --user stop opencode-job-${JOB_NAME}.timer 2>/dev/null || true
systemctl --user disable opencode-job-${JOB_NAME}.timer 2>/dev/null || true
systemctl --user stop opencode-job-${JOB_NAME}.service 2>/dev/null || true

# Remove files
echo "Removing files..."
rm -f ~/.config/systemd/user/opencode-job-${JOB_NAME}.timer
rm -f ~/.config/systemd/user/opencode-job-${JOB_NAME}.service
rm -f ~/.config/opencode/jobs/${JOB_NAME}.sh

# Reload
systemctl --user daemon-reload

echo "Job '${JOB_NAME}' deleted successfully"
