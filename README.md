# OSuRV_2025

[Prj table](https://docs.google.com/spreadsheets/d/11ApFMVwyrgWKrQ-Bx30LXNKMNhpXhl4f)

Pokretanje:

1) Raspberry Pi:
    1) Driver:
		1) kompajlirati putem "make"
		2) pokretanje modula putem "make start
		3) zaustavljanje pomocu "make stop"

    2) Test/test_app:
		1) konfigurisanje kroz "./waf configure"
		2) kompajliranje pomocu "./waf build"
		3) kompajlirani fajl je ./build/dump_log

2) Host PC:
    1) pokrenuti Juliu i pokrenuti include("plot.jl")
    2) pokrenuti organize.sh: 1. argument - direktorijum gde se cuvaju slike
			                  2. argument - broj testa
