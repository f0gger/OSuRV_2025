
# Install "Plots", "PyPlot"

using Plots
#s = (1600, 800)
s = (1200, 600) # Laptop
if true
        # Does not work on Julia 1.6.5
        pyplot(size = s)
        closeall()
else
        # Does work on Julia 1.6.5, but no png
        plotly(size = s)
end
default(reuse = false)

using StatsPlots
using Distributions


subplots = []

sp = plot(
        title = "TODO",
        xlabel = "T [us]",
        ylabel = "density",
)
push!(subplots, sp)
histogram!(
        sp,
        data,
        label = "Hist",
        bins = bins,
        #linecolor = "white",
        normalize = true
)
normal_fit = fit(Distributions.Normal, data)
println('\t', "μ = ", normal_fit.μ)
println('\t', "σ = ", normal_fit.σ)
plot!(
        sp,
        pp_arr[i].normal_fit,
        label = "Normal"
)


function violin2!(args...; kwargs...)
        violin!(
                args...;
                kwargs...,
                linewidth = 0
        )
end
function boxplot2!(args...; kwargs...)
        boxplot!(
                args...;
                kwargs...,
                #fillalpha = 0.75,
                #linewidth = 2
        )
end

function dotplot2!(args...; kwargs...)
        dotplot!(
                args...;
                kwargs...,
                markersize = 3,
                markerstrokewidth = 0.3
                #marker = (3, :black, stroke(0))
        )
end

sp = plot(
        title = "boxplot",
        xlabel = "boxes",
        ylabel = "est freq. [Hz]",
)
push!(subplots, sp)
for fun in [boxplot2!]
        for i in 1:N
                fun(
                        sp,
                        fill(name_arr[i]*" box", size(data)),
                        data,
                        side = :left,
                        label = name_arr[i]
                )
        end
end

sp = plot(
        title = "violin, dotplot",
        xlabel = "density",
        ylabel = "est freq. [Hz]",
)
push!(subplots, sp)
for fun in [violin2!, dotplot2!]
        for i in 1:N
                fun(
                        sp,
                        fill("violin & dot", size(data)),
                        data,
                        side = :left,
                        label = name_arr[i]
                )
        end
end




p = plot(subplots...)
gui(p)
savefig(p, "delay.png")
