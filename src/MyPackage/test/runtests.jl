using Pkg;
using Test;

println("Running tests...")

const package_path = abspath(joinpath(pwd(), ".."))
Pkg.develop(PackageSpec(path=package_path))
using MyPackage;

@testset "All Tests" begin
  @test MyPackage.hello("Jeremy") == "Hello Jeremy!"
end
