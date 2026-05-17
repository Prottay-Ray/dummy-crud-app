# Preflight Checklist

Before committing or opening a PR, verify each of these:

## Code Quality
- [ ] No hardcoded secrets, API keys, or passwords
- [ ] No `println` or debug logging left in production code
- [ ] No commented-out code blocks (delete, don't comment)
- [ ] Functions are reasonably sized (< 50 lines preferred)

## Kotlin Specific
- [ ] No unused imports
- [ ] Data classes used where appropriate
- [ ] Nullable types handled safely (no `!!` without justification)
- [ ] No suppressed warnings without a comment explaining why

## Testing
- [ ] New/changed logic has corresponding tests
- [ ] Tests actually assert meaningful behavior (not just "doesn't crash")

## Git Hygiene
- [ ] Commit message is clear and descriptive
- [ ] No unrelated changes bundled in
- [ ] No large generated files being committed
