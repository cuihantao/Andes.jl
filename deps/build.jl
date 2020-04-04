using PyCall

const PACKAGES = ["andes"]
install = []

try
    for name = PACKAGES
        pyimport(name)
    end
catch
    push!(install, name)
end

if length(install) > 0
    # import pip
    try
        pyimport("pip")
    catch
        get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
        download("https://bootstrap.pypa.io/get-pip.py", get_pip)
        run(`$(PyCall.python) $get_pip --user`)
    end

    # install packages
    pyimport("pip")
    args = UTF8String[]
    if haskey(ENV, "http_proxy")
        push!(args, "--proxy")
        push!(args, ENV["http_proxy"])
    end
    push!(args, "install")
    push!(args, "--user")
    append!(args, install)

    pip.main(args)
end

