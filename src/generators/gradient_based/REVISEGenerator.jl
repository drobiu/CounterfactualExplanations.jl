using LinearAlgebra

# -------- Joshi et al (2019): 
struct REVISEGenerator <: AbstractLatentSpaceGenerator
    loss::Union{Nothing,Symbol} # loss function
    complexity::Function # complexity function
    λ::AbstractFloat # strength of penalty
    opt::Any # learning rate
    τ::AbstractFloat # tolerance for convergence
end

# API streamlining:
using Parameters
@with_kw struct REVISEGeneratorParams
    opt::Any=Flux.Optimise.Descent()
    τ::AbstractFloat=1e-5
end

"""
    REVISEGenerator(
        ;
        loss::Symbol=:logitbinarycrossentropy,
        complexity::Function=norm,
        λ::AbstractFloat=0.1,
        opt::Any=Flux.Optimise.Descent(),
        τ::AbstractFloat=1e-5
    )

An outer constructor method that instantiates a REVISE generator.

# Examples
```julia-repl
generator = REVISEGenerator()
```
"""
function REVISEGenerator(;loss::Union{Nothing,Symbol}=nothing,complexity::Function=norm,λ::AbstractFloat=0.1,kwargs...)
    params = REVISEGeneratorParams(;kwargs...)
    REVISEGenerator(loss, complexity, λ, params.opt, params.τ)
end