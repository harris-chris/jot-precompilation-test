import Pkg;
Pkg.add(url="https://github.com/harris-chris/Jot.jl#main");
using Jot

# Set up My Package
cd("./src/MyPackage")

Pkg.activate("./")
Pkg.instantiate()

using MyPackage

# The final argument here must be the type of the only parameter of your responder function
# So the hello function has a single parameter who::String, therefore in this case the
# final argument of get_responder is String
responder = get_responder(MyPackage, :hello, String)
local_image = create_local_image(responder; image_suffix="say_hello", package_compile=true)
run_test(local_image, "Helen", "Hello Helen!"; then_stop=true)
remote_image = push_to_ecr!(local_image)
lambda_function = create_lambda_function(remote_image)
run_test(lambda_function, "Helen", "Hello Helen!")
