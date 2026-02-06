#!/bin/bash
# List all opencode-scheduler jobs

echo "=== OpenCode Scheduled Jobs ==="
echo ""

# List timers
echo "Timers:"
systemctl --user list-timers --all | grep opencode-job || echo "No jobs found"

echo ""
echo "Services:"
systemctl --user list-unit-files --type=service | grep opencode-job || echo "No services found"

echo ""
echo "Scripts:"
ls -la ~/.config/opencode/jobs/ 2>/dev/null || echo "No scripts directory"

echo ""
echo "Logs:"
ls -la ~/.config/opencode/logs/ 2>/dev/null || echo "No logs directory"
