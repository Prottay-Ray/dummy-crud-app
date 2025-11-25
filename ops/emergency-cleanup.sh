#!/usr/bin/env bash
# Emergency cleanup script to recover EC2 instance access
# Run this via AWS Systems Manager Session Manager if SSH is unavailable

echo "=== Emergency Cleanup Started ==="
echo "Timestamp: $(date)"

echo "Stopping all running containers..."
docker stop $(docker ps -q) 2>/dev/null || echo "No containers to stop"

echo "Removing all containers..."
docker rm $(docker ps -a -q) 2>/dev/null || echo "No containers to remove"

echo "Checking system resources..."
echo "Memory usage:"
free -h

echo ""
echo "Disk usage:"
df -h

echo ""
echo "CPU load:"
uptime

echo ""
echo "Top processes:"
ps aux --sort=-%mem | head -10

echo ""
echo "=== Cleanup Complete ==="
echo "SSH should now be accessible"
echo "Test with: ssh -i your-key.pem ec2-user@your-instance-ip"
