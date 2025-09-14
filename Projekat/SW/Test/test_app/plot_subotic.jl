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

timestamp_ns = []
on_off = []

filtered_gpio = "16"
open("log.tsv") do io
    while !eof(io)
        line = readline(io)
        s_timestamp_ns, s_gpio_num, s_on_off = split(line, "\t")
        if (s_gpio_num == filtered_gpio)
            append!(timestamp_ns, parse(Int, s_timestamp_ns))
            append!(on_off, parse(Int, s_on_off))
            #println(s_timestamp_ns, " ", s_on_off)
        end
    end
end

on_end = 0
off_end = 0
if (length(timestamp_ns) % 2 == 0)
    on_end = 1
    off_end = 2
else
    on_end = 2
    off_end = 1
end

ons = []
offs = []
periods = []

for i = 1:2:(length(timestamp_ns)-on_end)
    t = timestamp_ns[i+1] - timestamp_ns[i]
    append!(ons, t)
end

for i = 2:2:(length(timestamp_ns)-off_end)
    t = timestamp_ns[i+1] - timestamp_ns[i]
    append!(offs, t)
end

if (on_end == 1)
    periods = ons[1:1:end-1] + offs
else
    periods = ons + offs
end

subplots = []

sp = plot(
        title = "ON histogram (modified sw_pwm)",
        xlabel = "on T [us]",
        ylabel = "density",
)
#push!(subplots, sp)
ons_hist = histogram!(
        sp,
        ons,
        #bins = bins,
        #linecolor = "white",
        normalize = true
)
savefig(ons_hist, "./modified_sw_pwm/histo_ons.png")

sp = plot(
        title = "OFF histogram (modified sw_pwm)",
        xlabel = "off T [us]",
        ylabel = "density",
)
#push!(subplots, sp)
offs_hist = histogram!(
        sp,
        offs,
        #bins = bins,
        #linecolor = "white",
        normalize = true
)
savefig(offs_hist, "./modified_sw_pwm/histo_offs.png")

sp = plot(
        title = "Period histogram (modified sw_pwm)",
        xlabel = "T [us]",
        ylabel = "density",
)
#push!(subplots, sp)
periods_hist = histogram!(
        sp,
        periods,
        #bins = bins,
        #linecolor = "white",
        normalize = true
)
savefig(periods_hist, "./modified_sw_pwm/histo_periods.png")

normal_fit = fit(Distributions.Normal, periods)
println('\t', "μ = ", normal_fit.μ)
println('\t', "σ = ", normal_fit.σ)
#plot!(
#        sp,
#        p_hist.normal_fit, #pp_array[i].normal_fit
#        label = "Normal"
#)


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
        title = "on boxplot (modified sw_pwm)",
        xlabel = "boxes",
        ylabel = "est freq. [Hz]",
)
push!(subplots, sp)
data_arr = [ons, offs, periods]
name_arr = ["ons", "offs", "periods"]
#for fun in [boxplot2!]
for i in 1:length(data_arr)
    box_plot = boxplot(
                        sp,
                        fill(name_arr[i]*" box", size(data_arr[i])),
                        data_arr[i],
                        side = :left,
                        label = name_arr[i],
                        )
    savefig(box_plot, "./modified_sw_pwm/"*name_arr[i]*"_boxplot.png")
end
#end

sp = plot(
        title = "violin, dotplot",
        xlabel = "density",
        ylabel = "est freq. [Hz]",
)
push!(subplots, sp)
#for fun in [violin2!, dotplot2!]
for i in 1:length(name_arr)
    vio = violin(
        sp,
        fill("violin & dot", size(data_arr[i])),
        data_arr[i],
        side = :left,
        label = name_arr[i]
        )
    vio_dot = dotplot(
        vio,
        fill("violin & dot", size(data_arr[i])),
        data_arr[i],
        side = :left,
        label = name_arr[i]
        )
    savefig(vio_dot, "./modified_sw_pwm/"*name_arr[i]*"_violin_dotplot.png")
end
#end




#p = plot(subplots...)
#gui(p)
#savefig(p, "delay.png")
