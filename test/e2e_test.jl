# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# E2E pipeline tests for SMTLib.jl

using Test
using SMTLib

@testset "E2E Pipeline Tests" begin

    @testset "Full SMT-LIB generation pipeline" begin
        # Nested arithmetic and logical expression round-trip through to_smtlib
        exprs = [
            (:(x + y * z),          "(+ x (* y z))"),
            (:((x > 0) && (y < 10)), "(and (> x 0) (< y 10))"),
            (:(!(x == y)),           "(not (= x y))"),
            (:(x >= 0),              "(>= x 0)"),
        ]
        for (expr, expected) in exprs
            @test to_smtlib(expr) == expected
        end
    end

    @testset "SMTContext declare → assert → check_sat pipeline (no solver)" begin
        # These operations must not error even without a solver installed
        ctx = SMTContext()
        @test ctx isa SMTContext

        declare_const(ctx, :x, :Int)
        declare_const(ctx, :y, :Int)
        assert!(ctx, :(x > 0))
        assert!(ctx, :(y < 10))
        assert!(ctx, :(x + y == 5))

        # Script should contain all three assertions
        script = to_smtlib_script(ctx)
        @test script isa String
        @test occursin("declare-const", script)
        @test occursin("assert", script)
    end

    @testset "to_smtlib_script includes check-sat and get-model" begin
        ctx = SMTContext()
        declare_const(ctx, :a, :Int)
        assert!(ctx, :(a > 100))
        script = to_smtlib_script(ctx; check_sat=true, get_model=true)
        @test occursin("check-sat", script)
        @test occursin("get-model", script)
    end

    @testset "Error handling: unknown sort raises an error" begin
        ctx = SMTContext()
        @test_throws Exception declare_const(ctx, :z, :UnknownSort123)
    end

end
