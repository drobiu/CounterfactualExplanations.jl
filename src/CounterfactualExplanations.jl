module CounterfactualExplanations

abstract type AbstractCounterfactualExplanation end
export AbstractCounterfactualExplanation

# Dependencies:
using Flux
import Flux.Losses

# Global constants:
include("global_utils.jl")
export RawTargetType, EncodedTargetType, RawOutputArrayType, EncodedOutputArrayType
export OutputEncoder
export get_target_index, encode_output

### Data 
# 𝒟 = {(x,y)}ₙ
###
# Generative models for latent space search:
include("generative_models/GenerativeModels.jl")
using .GenerativeModels

# Data preprocessing:
include("data_preprocessing/DataPreprocessing.jl")
using .DataPreprocessing
export CounterfactualData,
    select_factual, apply_domain_constraints, OutputEncoder, transformable_features

### Models 
# ℳ[𝒟] : x ↦ y
###

include("models/Models.jl")
using .Models
export AbstractFittedModel, AbstractDifferentiableModel
export FluxModel, FluxEnsemble, LaplaceReduxModel
export flux_training_params
export probs, logits
export model_catalogue, fit_model, model_evaluation, predict_label

### Generators
# ℓ( ℳ[𝒟](xᵢ) , target )
###
include("generators/Generators.jl")
using .Generators
export AbstractGenerator, AbstractGradientBasedGenerator
export ClaPROARGenerator, ClaPROARGeneratorParams
export GenericGenerator, GenericGeneratorParams
export GravitationalGenerator, GravitationalGeneratorParams
export GreedyGenerator, GreedyGeneratorParams
export REVISEGenerator, REVISEGeneratorParams
export DiCEGenerator, DiCEGeneratorParams
export generator_catalog
export generate_perturbations, conditions_satisified, mutability_constraints

### CounterfactualExplanation
# argmin 
###
include("counterfactuals/Counterfactuals.jl")
export CounterfactualExplanation
export initialize!, update!
export total_steps, converged, terminated, path, target_probs
export animate_path


### Other
# Example data sets:
include("data/Data.jl")
using .Data

include("generate_counterfactual.jl")
export generate_counterfactual

include("evaluation/Evaluation.jl")
using .Evaluation

end
