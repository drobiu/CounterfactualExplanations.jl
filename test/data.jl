ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"
@testset "Construction" begin
    for (name, loader) in merge(values(data_catalogue)...)
        @testset "$name" begin
            @test typeof(loader()) == CounterfactualData
        end
    end
end

@testset "Vision tests" begin
    # Test loading CIFAR10 dataset with default parameters
    counterfactual_data = load_cifar_10()
    @test size(counterfactual_data.X)[2] == 50000
    @test size(counterfactual_data.X)[1] == 3072
    @test size(counterfactual_data.y)[2] == 50000
    @test all(
        counterfactual_data.domain[i] == (-1.0, 1.0) for
        i in eachindex(counterfactual_data.domain)
    )
    @test counterfactual_data.standardize == false
    @test eltype(counterfactual_data.X) == Float32

    # Test loading CIFAR10 dataset with subsampled data
    counterfactual_data = load_cifar_10(1000)
    @test size(counterfactual_data.X)[2] == 1000
    @test size(counterfactual_data.X)[1] == 3072
    @test size(counterfactual_data.y)[2] == 1000
    @test all(
        counterfactual_data.domain[i] == (-1.0, 1.0) for
        i in eachindex(counterfactual_data.domain)
    )
    @test counterfactual_data.standardize == false
    @test eltype(counterfactual_data.X) == Float32

    # Test loading CIFAR10 test dataset
    counterfactual_data = load_cifar_10_test()
    @test size(counterfactual_data.X)[2] == 10000
    @test size(counterfactual_data.X)[1] == 3072
    @test size(counterfactual_data.y)[2] == 10000
    @test counterfactual_data.standardize == false
    @test eltype(counterfactual_data.X) == Float32
end
