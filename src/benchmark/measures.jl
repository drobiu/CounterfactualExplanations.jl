using LinearAlgebra
using Statistics

"""
    validity(counterfactual_explanation::CounterfactualExplanation)

Checks of the counterfactual search has been successful. In case multiple counterfactuals were generated, the function returns the proportion of successful counterfactuals.
"""
function validity(counterfactual_explanation::CounterfactualExplanation)
    CounterfactualExplanations.target_probs(counterfactual_explanation) .>= counterfactual_explanation.params[:γ]
end

"""
    distance(counterfactual_explanation::CounterfactualExplanation, p::Real=2)

Computes the distance of the counterfactual to the original factual.
"""
function distance(counterfactual_explanation::CounterfactualExplanation, p::Real=2)
    x = CounterfactualExplanations.factual(counterfactual_explanation)
    x′ = CounterfactualExplanations.counterfactual(counterfactual_explanation)
    Δ = mapslices(_x -> LinearAlgebra.norm(_x .- x, p), x′, dims=[1, 2])
    return Δ
end

"""
    distance_l0(counterfactual_explanaation::CounterfactualExplanation)

Computes the L0 distance of the counterfactual to the original factual.
"""
distance_l0(counterfactual_explanation::CounterfactualExplanation) = distance(counterfactual_explanation, 0)

"""
    distance_l1(counterfactual_explanation::CounterfactualExplanation)

Computes the L1 distance of the counterfactual to the original factual.
"""
distance_l1(counterfactual_explanation::CounterfactualExplanation) = distance(counterfactual_explanation, 1)

"""
    distance_l2(counterfactual_explanation::CounterfactualExplanation)

Computes the L2 (Euclidean) distance of the counterfactual to the original factual.
"""
distance_l2(counterfactual_explanation::CounterfactualExplanation) = distance(counterfactual_explanation, 2)

"""
    distance_linf(counterfactual_explanation::CounterfactualExplanation)

Computes the L-inf distance of the counterfactual to the original factual.
"""
distance_linf(counterfactual_explanation::CounterfactualExplanation) = distance(counterfactual_explanation, Inf)

"""
    redundancy(counterfactual_explanation::CounterfactualExplanation)

Computes the feature redundancy: that is, the number of features that remain unchanged from their original, factual values.
"""
function redundancy(counterfactual_explanation::CounterfactualExplanation)
    x′ = CounterfactualExplanations.counterfactual(counterfactual_explanation)
    redundant_x = mapslices(x -> sum(x .== 0) / size(x, 1), x′, dims=[1, 2])
    return redundant_x
end

