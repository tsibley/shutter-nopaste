SHUTTER_ROOT = /usr/share/shutter
PLUGIN_DIR   = $(SHUTTER_ROOT)/resources/system/upload_plugins/upload
PERL         = $(shell head -n1 `which shutter`)

install: Nopaste.pm | check-nopaste
	echo "$(PERL)" > $(PLUGIN_DIR)/$<
	cat $< >> $(PLUGIN_DIR)/$<
	chmod 0755 $(PLUGIN_DIR)/$<

check-nopaste:
	$(subst #!,,$(PERL)) -MApp::Nopaste -e1
