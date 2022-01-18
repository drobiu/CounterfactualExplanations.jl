using AlgorithmicRecourse
using Documenter

DocMeta.setdocmeta!(AlgorithmicRecourse, :DocTestSetup, :(using AlgorithmicRecourse); recursive=true)

makedocs(;
    modules=[AlgorithmicRecourse],
    authors="Patrick Altmeyer",
    repo="https://github.com/pat-alt/AlgorithmicRecourse.jl/blob/{commit}{path}#{line}",
    sitename="AlgorithmicRecourse.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://pat-alt.github.io/AlgorithmicRecourse.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorials" =>
            [
                "Installation" => "tutorials/install.md",
                "Quick start" => [
                    "Binary target" => "tutorials/binary.md",
                    # "Multi-class target" => "tutorials/multi.md"
                ],
                # "Models" => "tutorial/models.md",
                # "Loss functions" => "tutorials/loss.md"
            ],
        "Reference" => "reference.md"
    ],
)

deploydocs(;
    repo="github.com/pat-alt/AlgorithmicRecourse.jl",
    devbranch="main"
)
