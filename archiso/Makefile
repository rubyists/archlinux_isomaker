all:

install: install-program install-hooks install-examples install-doc

install-program:
	# install to sbin since script only usable by root
	install -D -m 755 mkarchiso $(DESTDIR)/usr/sbin/mkarchiso
	# testiso can be used by anyone
	install -D -m 755 testiso $(DESTDIR)/usr/bin/testiso

install-hooks:
	# hooks/install are needed by mkinitcpio
	install -D -m 644 hooks/archiso $(DESTDIR)/lib/initcpio/hooks/archiso
	install -D -m 644 install/archiso $(DESTDIR)/lib/initcpio/install/archiso
	install -D -m 755 archiso_shutdown $(DESTDIR)/lib/initcpio/archiso_shutdown
	install -D -m 644 hooks/archiso_shutdown $(DESTDIR)/lib/initcpio/hooks/archiso_shutdown
	install -D -m 644 install/archiso_shutdown $(DESTDIR)/lib/initcpio/install/archiso_shutdown
	install -D -m 644 archiso_pxe_nbd $(DESTDIR)/lib/initcpio/archiso_pxe_nbd
	install -D -m 644 hooks/archiso_pxe_common $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_common
	install -D -m 644 install/archiso_pxe_common $(DESTDIR)/lib/initcpio/install/archiso_pxe_common
	install -D -m 644 hooks/archiso_pxe_nbd $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_nbd
	install -D -m 644 install/archiso_pxe_nbd $(DESTDIR)/lib/initcpio/install/archiso_pxe_nbd
	install -D -m 644 hooks/archiso_pxe_http $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_http
	install -D -m 644 install/archiso_pxe_http $(DESTDIR)/lib/initcpio/install/archiso_pxe_http
	install -D -m 644 hooks/archiso_pxe_nfs $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_nfs
	install -D -m 644 install/archiso_pxe_nfs $(DESTDIR)/lib/initcpio/install/archiso_pxe_nfs
	install -D -m 644 hooks/archiso_loop_mnt $(DESTDIR)/lib/initcpio/hooks/archiso_loop_mnt
	install -D -m 644 install/archiso_loop_mnt $(DESTDIR)/lib/initcpio/install/archiso_loop_mnt
	install -D -m 644 install/archiso_kms $(DESTDIR)/lib/initcpio/install/archiso_kms

install-examples:
	# install examples
	install -d -m 755 $(DESTDIR)/usr/share/archiso/
	cp -r ../configs $(DESTDIR)/usr/share/archiso/

install-doc:
	install -d -m 755 $(DESTDIR)/usr/share/archiso/
	install -D -m 644 ../README $(DESTDIR)/usr/share/doc/archiso/README
	
uninstall:
	rm -f $(DESTDIR)/usr/sbin/mkarchiso
	rm -f $(DESTDIR)/usr/bin/testiso
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso
	rm -f $(DESTDIR)/lib/initcpio/install/archiso
	rm -f $(DESTDIR)/lib/initcpio/archiso_shutdown
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso_shutdown
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_shutdown
	rm -f $(DESTDIR)/lib/initcpio/archiso_pxe_nbd
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_common
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_pxe_common
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_nbd
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_pxe_nbd
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_http
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_pxe_http
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso_pxe_nfs
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_pxe_nfs
	rm -f $(DESTDIR)/lib/initcpio/hooks/archiso_loop_mnt
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_loop_mnt
	rm -f $(DESTDIR)/lib/initcpio/install/archiso_kms
	rm -rf $(DESTDIR)/usr/share/archiso/

.PHONY: install install-program install-hooks install-examples install-doc uninstall
