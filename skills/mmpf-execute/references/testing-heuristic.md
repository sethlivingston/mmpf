# Testing Heuristic

## When to use TDD (test-first)

Ask: "Can I write `expect(fn(input)).toBe(output)` before writing `fn`?"

If yes, use red-green-refactor:
1. **RED** — Write a failing test first
2. **GREEN** — Implement until the test passes
3. **REFACTOR** — Clean up, tests must still pass

Good TDD candidates:
- Business logic and algorithms
- Data transformations and parsing
- Validation rules
- API contracts
- State machines
- Utility functions

## When to skip TDD

Write tests after implementation (or skip entirely) for:
- UI layout and styling
- Configuration changes
- Glue code and wiring
- Simple CRUD with no business logic
- One-off scripts
- Exploratory prototypes
- Non-code deliverables (documents, decisions)

## The rule

If the deliverable is code, unit tests are expected. The question is only whether
tests come first (TDD) or after. Use the heuristic above to decide.

If unit testing is genuinely impractical for a piece of code (heavy external
dependencies, pure integration concerns), be reasonable — document why tests
were skipped and consider integration tests instead.
