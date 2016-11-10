ISE_BIN = /opt/xilinx/14.7/ISE_DS/ISE/bin/lin64
NUMATO_LOADER = /opt/numato-loader

all: saturn.bin

saturn.bin: $(wildcard *.v)
	$(ISE_BIN)/xst -intstyle ise -ifn saturn.xst -ofn saturn.syr && \
	$(ISE_BIN)/ngdbuild -intstyle ise -dd _ngo -nt timestamp -uc \
	saturn.ucf -p xc6slx16-csg324-2 saturn.ngc saturn.ngd && \
	$(ISE_BIN)/map -intstyle ise -p xc6slx16-csg324-2 -w -logic_opt off \
	-ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off \
	-mt off -ir off -pr off -lc off -power off -o saturn_map.ncd \
	saturn.ngd saturn.pcf && \
	$(ISE_BIN)/par -w -intstyle ise -ol high -mt off saturn_map.ncd \
	saturn.ncd saturn.pcf && \
	$(ISE_BIN)/trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml \
	saturn.twx saturn.ncd -o saturn.twr saturn.pcf && \
	$(ISE_BIN)/bitgen -intstyle ise -f saturn.ut saturn.ncd

flash: saturn.bin
	$(NUMATO_LOADER) saturn.bin

clean:
	$(RM) -r _ngo _xmsgs xlnx_auto_0_xdb xst
	$(RM) saturn.bgn saturn.bin saturn.bit saturn.bld saturn.drc \
	saturn.lso saturn.ncd saturn.ngc saturn.ngd saturn.ngr saturn.pad \
	saturn.par saturn.pcf saturn.ptwx saturn.syr saturn.twr saturn.twx \
	saturn.unroutes saturn.xpi saturn_bitgen.xwbt saturn_map.map \
	saturn_map.mrp saturn_map.ncd saturn_map.ngm saturn_map.xrpt \
	saturn_ngdbuild.xrpt saturn_pad.csv saturn_pad.txt saturn_par.xrpt \
	saturn_summary.xml saturn_usage.xml saturn_xst.xrpt \
	par_usage_statistics.html usage_statistics_webtalk.html webtalk.log

dist: clean
	mkdir -p saturn
	cp -R saturn.prj saturn.ucf saturn.ut saturn.xst *.v Makefile saturn
	tar -cvjf saturn.tar.bz2 saturn
	$(RM) -r saturn

.PHONY: all flash clean dist
