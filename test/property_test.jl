# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# Property-based invariant tests for SMTLib.jl

using Test
using SMTLib

@testset "Property-Based Tests" begin

    @testset "Invariant: to_smtlib of integer literals is the decimal string" begin
        for _ in 1:50
            n = rand(0:999)
            @test to_smtlib(n) == string(n)
        end
    end

    @testset "Invariant: to_smtlib wraps negative integers with (- ...)" begin
        for _ in 1:50
            n = rand(1:999)
            @test to_smtlib(-n) == "(- $n)"
        end
    end

    @testset "Invariant: to_smtlib of true/false is string literal" begin
        for _ in 1:20
            @test to_smtlib(true) == "true"
            @test to_smtlib(false) == "false"
        end
    end

    @testset "Invariant: SMTContext assert! count matches calls" begin
        for _ in 1:30
            ctx = SMTContext()
            declare_const(ctx, :x, :Int)
            n = rand(1:10)
            for i in 1:n
                assert!(ctx, :(x > 0))
            end
            script = to_smtlib_script(ctx)
            # Count occurrences of "assert" in the script
            count = length(collect(eachmatch(r"\(assert", script)))
            @test count == n
        end
    end

    @testset "Invariant: to_smtlib is deterministic" begin
        exprs = [:(x + y), :(x < y), :(!x), :(x && y)]
        for expr in exprs
            for _ in 1:20
                @test to_smtlib(expr) == to_smtlib(expr)
            end
        end
    end

end
