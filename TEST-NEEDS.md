# TEST-NEEDS: SMTLib.jl

## Current State

| Category | Count | Details |
|----------|-------|---------|
| **Source modules** | 12 | 3,586 lines |
| **Test files** | 1 | 1,578 lines, 650 @test/@testset |
| **Benchmarks** | 0 | None |
| **E2E tests** | 0 | None |

## What's Missing

### E2E Tests
- [ ] No test running SMTLib against actual SMT solvers (Z3, CVC5)
- [ ] No roundtrip test (generate SMTLib2 -> parse back)

### Aspect Tests
- [ ] **Performance**: SMT solving is performance-critical, 0 benchmarks
- [ ] **Error handling**: No tests for unsatisfiable formulas, timeout, solver crashes
- [ ] **Concurrency**: No parallel solving tests

### Benchmarks Needed (CRITICAL)
- [ ] Formula generation throughput
- [ ] Solver invocation latency
- [ ] Scaling with formula complexity

### Self-Tests
- [ ] No solver availability self-check

## FLAGGED ISSUES
- **650 tests is excellent** -- second highest test count
- **Single test file for 12 modules** -- should be split
- **0 benchmarks for performance-critical SMT library** -- major gap
- **No solver integration tests** -- generates SMTLib2 but never verifies it works

## Priority: P2 (MEDIUM) -- strong unit tests, needs benchmarks and solver E2E

## FAKE-FUZZ ALERT

- `tests/fuzz/placeholder.txt` is a scorecard placeholder inherited from rsr-template-repo — it does NOT provide real fuzz testing
- Replace with an actual fuzz harness (see rsr-template-repo/tests/fuzz/README.adoc) or remove the file
- Priority: P2 — creates false impression of fuzz coverage
