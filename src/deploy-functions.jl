import Pkg;
Pkg.add(url="https://github.com/harris-chris/Jot.jl#main");
using Jot

# Set up My Package
cd("./src/MyPackage")

Pkg.activate("./")
Pkg.instantiate()

using MyPackage

# Build the Lambda responder and image
responder = get_responder(MyPackage, :my_package, Dict)
local_image = create_local_image(responder; image_suffix="my_package", package_compile=true)
remote_image = push_to_ecr!(local_image)
lambda_function = create_lambda_function(remote_image)
