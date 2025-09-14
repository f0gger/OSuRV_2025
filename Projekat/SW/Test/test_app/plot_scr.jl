using StatsPlots
using Distributions

timestamp_ns = []
#gpio_num = []
on_off = []

pin_num = "16"
open("log.tsv") do io
    while !eof(io)
        line = readline(io)
        s_timestamp_ns, s_gpio_num, s_on_off = split(line, "\t")
        if (s_gpio_num == pin_num)
            #append!(on_off, parse(Int, s_on_off))
            append!(timestamp_ns, parse(Int, s_timestamp_ns))
            append!(on_off, parse(Int, s_on_off))
            println(on_off)
        end
    end
end

#p1 = plot(timestamp_ns, label="timestamp[ns]")
#fit_distribution = fit(Normal{Int}, convert.(Int, timestamp_ns))
p2 = histogram(on_off, label="on_off", alpha=0.5, normed=true)
#plot!(p2, fit_distribution, formatter=:plain, label="Fitted Normal Distribution")

#comb_plot = plot(p1, p2, layout=(2, 1))
display(p2)