using Distributions
using StatsPlots

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
println(length(timestamp_ns))
if (length(timestamp_ns) % 2 == 0)
    on_end = 1
    off_end = 2    
else
    on_end = 2
    off_end = 1
end

ons = []
offs = []
for i = 1:2:(length(on_off)-on_end)
    t_on = timestamp_ns[i+1] - timestamp_ns[i]
    append!(ons, t_on)
end

for i = 2:2:(length(on_off)-off_end)
    t_off = timestamp_ns[i+1] - timestamp_ns[i]
    append!(offs, t_off)
end

periods = []
if (on_end == 1)
    periods = ons[1:1:end-1] + offs
else
    periods = ons + offs
end

p_ons = histogram(ons, label="ons[ns]")
p_offs = histogram(offs, label="offs[ns]")
p_period = histogram(periods, label="periods[ns]")

combined_plot = plot(p_period, p_ons, p_offs)

#display(p_ons)
display(combined_plot)