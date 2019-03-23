Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F2C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA193218E2
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCWAtR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:49:17 -0400
Received: from www62.your-server.de ([213.133.104.62]:43860 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCWAtR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 20:49:17 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7UqZ-00039y-Oe; Sat, 23 Mar 2019 01:49:15 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     sdf@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/2] bpf, libbpf: fix version info and add it to shared object
Date:   Sat, 23 Mar 2019 01:49:10 +0100
Message-Id: <20190323004911.604-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190323004911.604-1-daniel@iogearbox.net>
References: <20190323004911.604-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25396/Fri Mar 22 08:52:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Even though libbpf's versioning script for the linker (libbpf.map)
is pointing to 0.0.2, the BPF_EXTRAVERSION in the Makefile has
not been updated along with it and is therefore still on 0.0.1.

While fixing up, I also noticed that the generated shared object
versioning information is missing, typical convention is to have
a linker name (libbpf.so), soname (libbpf.so.0) and real name
(libbpf.so.0.0.2) for library management. This is based upon the
LIBBPF_VERSION as well.

The build will then produce the following bpf libraries:

  # ll libbpf*
  libbpf.a
  libbpf.so -> libbpf.so.0.0.2
  libbpf.so.0 -> libbpf.so.0.0.2
  libbpf.so.0.0.2

  # readelf -d libbpf.so.0.0.2 | grep SONAME
  0x000000000000000e (SONAME)             Library soname: [libbpf.so.0]

And install them accordingly:

  # rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=/tmp/bld install

  Auto-detecting system features:
  ...                        libelf: [ on  ]
  ...                           bpf: [ on  ]

    CC       /tmp/bld/libbpf.o
    CC       /tmp/bld/bpf.o
    CC       /tmp/bld/nlattr.o
    CC       /tmp/bld/btf.o
    CC       /tmp/bld/libbpf_errno.o
    CC       /tmp/bld/str_error.o
    CC       /tmp/bld/netlink.o
    CC       /tmp/bld/bpf_prog_linfo.o
    CC       /tmp/bld/libbpf_probes.o
    CC       /tmp/bld/xsk.o
    LD       /tmp/bld/libbpf-in.o
    LINK     /tmp/bld/libbpf.a
    LINK     /tmp/bld/libbpf.so.0.0.2
    LINK     /tmp/bld/test_libbpf
    INSTALL  /tmp/bld/libbpf.a
    INSTALL  /tmp/bld/libbpf.so.0.0.2

  # ll /usr/local/lib64/libbpf.*
  /usr/local/lib64/libbpf.a
  /usr/local/lib64/libbpf.so -> libbpf.so.0.0.2
  /usr/local/lib64/libbpf.so.0 -> libbpf.so.0.0.2
  /usr/local/lib64/libbpf.so.0.0.2

Fixes: 1bf4b05810fe ("tools: bpftool: add probes for eBPF program types")
Fixes: 1b76c13e4b36 ("bpf tools: Introduce 'bpf' library and add bpf feature check")
Reported-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/Makefile | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 61aaacf..5bf8e52 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -3,7 +3,7 @@
 
 BPF_VERSION = 0
 BPF_PATCHLEVEL = 0
-BPF_EXTRAVERSION = 1
+BPF_EXTRAVERSION = 2
 
 MAKEFLAGS += --no-print-directory
 
@@ -79,8 +79,6 @@ export prefix libdir src obj
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-LIB_FILE = libbpf.a libbpf.so
-
 VERSION		= $(BPF_VERSION)
 PATCHLEVEL	= $(BPF_PATCHLEVEL)
 EXTRAVERSION	= $(BPF_EXTRAVERSION)
@@ -88,7 +86,10 @@ EXTRAVERSION	= $(BPF_EXTRAVERSION)
 OBJ		= $@
 N		=
 
-LIBBPF_VERSION = $(BPF_VERSION).$(BPF_PATCHLEVEL).$(BPF_EXTRAVERSION)
+LIBBPF_VERSION	= $(BPF_VERSION).$(BPF_PATCHLEVEL).$(BPF_EXTRAVERSION)
+
+LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
+LIB_FILE	= libbpf.a libbpf.so*
 
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
@@ -128,16 +129,18 @@ all:
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-BPF_IN    := $(OUTPUT)libbpf-in.o
-LIB_FILE := $(addprefix $(OUTPUT),$(LIB_FILE))
-VERSION_SCRIPT := libbpf.map
+BPF_IN		:= $(OUTPUT)libbpf-in.o
+VERSION_SCRIPT	:= libbpf.map
+
+LIB_TARGET	:= $(addprefix $(OUTPUT),$(LIB_TARGET))
+LIB_FILE	:= $(addprefix $(OUTPUT),$(LIB_FILE))
 
 GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN) | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {s++} END{print s}')
 VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 
-CMD_TARGETS = $(LIB_FILE)
+CMD_TARGETS = $(LIB_TARGET)
 
 CXX_TEST_TARGET = $(OUTPUT)test_libbpf
 
@@ -170,9 +173,13 @@ $(BPF_IN): force elfdep bpfdep
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf
 
-$(OUTPUT)libbpf.so: $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,--version-script=$(VERSION_SCRIPT) \
-		$^ -o $@
+$(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
+
+$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(VERSION) \
+				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libbpf.so
+	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
 
 $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
@@ -192,6 +199,12 @@ check_abi: $(OUTPUT)libbpf.so
 		exit 1;							 \
 	fi
 
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1';	\
+	fi
+endef
+
 define do_install
 	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
@@ -200,8 +213,9 @@ define do_install
 endef
 
 install_lib: all_cmd
-	$(call QUIET_INSTALL, $(LIB_FILE)) \
-		$(call do_install,$(LIB_FILE),$(libdir_SQ))
+	$(call QUIET_INSTALL, $(LIB_TARGET)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
@@ -219,7 +233,7 @@ config-clean:
 
 clean:
 	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
-		*.o *~ *.a *.so .*.d .*.cmd LIBBPF-CFLAGS
+		*.o *~ *.a *.so *.so.$(VERSION) .*.d .*.cmd LIBBPF-CFLAGS
 	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
 
 
-- 
2.9.5

