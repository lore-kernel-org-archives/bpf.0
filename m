Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A7490C11;
	Thu,  1 Oct 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886167; cv=none; b=lGQs6dCI7o0asVnX3FB1uGAMzsK0KjdQDkZSXZHxM+LeiuDkXRfwwYBzivgomldeLZGxzT5H0PfuXa8zZewTrT0O09zt5M49QgkXHQZdnIs1NEOL8UQ3SJ0/EzYz4izk8xSviQZiF2FD/GSIAg0LYlDBnWV1uza2NYMnfqSjWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886167; c=relaxed/simple;
	bh=cAjRInv12wrwP3ldneUHL2iw0o1agJ5sQwBlKS5zt00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw+JQDnCdevy1ECmOM/Np6rvCOHMeIKQ+lLUa7vQLM5kj7hPrrWBeUUuqgZLozNklK74mVF2be18HnsYrgA11SDjTqDePGG/BGRO46SsbgIJGtjMneRJd3CVbWoKJKNtfaUkivwGPHWnFoYrygGl4DkbPv9bETJO/d49L0v+n6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIravE2Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIravE2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886160; x=1822422160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cAjRInv12wrwP3ldneUHL2iw0o1agJ5sQwBlKS5zt00=;
  b=JIravE2QkJ4cmDIJ/fRUFP0AoIwScmnHd/ZD5nz9+RoZwe8ZSEl0/ePP
   QZ1gZmNkJUUKfhK0AFNwkjqg+oSaz1Ufr4rXSG5lUdALofnDLPjRSH7PB
   5IEie6RdyZnbLt2oWIepRi6fCqWVP82DCjJd70eFJcyW/dw+m5fnM5adq
   hrjGGsvu1127NJW1y2IzjsVGMQV+WCaMcWbMV0Cg22tNVL+5Xp6yQucsS
   ugKzdGEByram/dUGzR5Uf1iuKZ5ZQZmddMx6QG0PJYBsKeH9cmafKngb8
   C1v2F9RF6J5mWzs2XWdtGzWX0rci01+N/l//8p0f0vJpQuKOphYM/QiHm
   A==;
X-CSE-ConnectionGUID: yn8E/M1BTlOUIoR9n/3i9Q==
X-CSE-MsgGUID: 1+4rhl2lQkeP2cxAQKb8jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466813"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466813"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:35 -0700
X-CSE-ConnectionGUID: i8Ple+IDT/qxtItYYCQrDQ==
X-CSE-MsgGUID: eDZfxPrcTSecd0KjDZfMuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636708"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 05/13] selftests: xsk: move the AF_XDP test suite to selftests/net
Date: Thu,  1 Oct 2026 22:21:16 +0200
Message-Id: <20261001202124.692591-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the xskxceiver engine, the AF_XDP userspace library, the test
definitions and the XDP program to net/lib/xsk, and the veth launcher
test_xsk.sh with its prerequisites script to selftests/net. A later
patch drives the same engine against real NICs from drivers/net/hw, and
net/lib is where both suites already take shared helpers from, so the
binary does not need a second copy.

net/lib builds xskxceiver together with its XDP program and skeleton,
and skips it with a warning when bpftool is missing. selftests/net
installs test_xsk.sh, which runs lib/xskxceiver.

Like the rest of net/lib, xskxceiver builds against the installed uapi
headers rather than the tools/include/uapi copies that the bpf selftests
use. xskxceiver.c got min_t() only because the tools copy of
linux/netlink.h includes linux/kernel.h, so include linux/kernel.h
directly.

Move the two ethtool ring helpers from network_helpers into xsk.c so the
engine no longer depends on network_helpers, and point the kselftest.h
include of test_xsk.h at the net/lib include path. The XDP program moves
unchanged. Its Ethernet header bound check compares pointers of distinct
types, so net/lib builds it with -Wno-compare-distinct-pointer-types, as
the bpf selftests do.

xdp_hw_metadata and the test_progs xdp_metadata test keep using xsk.c
and xsk.h from their new location.

Point the AF_XDP entry in MAINTAINERS at the new paths.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 Documentation/networking/af_xdp.rst           |  6 +--
 MAINTAINERS                                   |  3 +-
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          | 29 +++++------
 tools/testing/selftests/bpf/network_helpers.c | 48 ------------------
 tools/testing/selftests/bpf/network_helpers.h |  2 -
 tools/testing/selftests/net/Makefile          |  2 +
 tools/testing/selftests/net/config            |  1 +
 tools/testing/selftests/net/lib/.gitignore    |  2 +
 tools/testing/selftests/net/lib/Makefile      | 32 ++++++++++++
 .../prog_tests => net/lib/xsk}/test_xsk.c     |  2 +-
 .../prog_tests => net/lib/xsk}/test_xsk.h     |  2 +-
 .../selftests/{bpf => net/lib/xsk}/xsk.c      | 49 ++++++++++++++++++-
 .../selftests/{bpf => net/lib/xsk}/xsk.h      |  4 ++
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |  0
 .../lib/xsk/xsk_xdp_progs.bpf.c}              |  0
 .../{bpf => net/lib/xsk}/xskxceiver.c         |  7 +--
 .../{bpf => net/lib/xsk}/xskxceiver.h         |  0
 .../selftests/{bpf => net}/test_xsk.sh        |  0
 .../selftests/{bpf => net}/xsk_prereqs.sh     |  2 +-
 20 files changed, 111 insertions(+), 81 deletions(-)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (99%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (99%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (95%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (97%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (100%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.c (99%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 rename tools/testing/selftests/{bpf => net}/test_xsk.sh (100%)
 rename tools/testing/selftests/{bpf => net}/xsk_prereqs.sh (98%)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index cc3f0d16b28f..538e71adb759 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -211,7 +211,7 @@ Libbpf
 
 Libbpf is a helper library for eBPF and XDP that makes using these
 technologies a lot simpler. It also contains specific helper functions
-in tools/testing/selftests/bpf/xsk.h for facilitating the use of
+in tools/testing/selftests/net/lib/xsk/xsk.h for facilitating the use of
 AF_XDP. It contains two types of functions: those that can be used to
 make the setup of AF_XDP socket easier and ones that can be used in the
 data plane to access the rings safely and quickly.
@@ -751,7 +751,7 @@ return values:
      returned number signifies the max number of frags supported.
 
 For an example on how these are used through libbpf, please take a
-look at tools/testing/selftests/bpf/xskxceiver.c.
+look at tools/testing/selftests/net/lib/xsk/xskxceiver.c.
 
 Multi-Buffer Support for Zero-Copy Drivers
 ------------------------------------------
@@ -785,7 +785,7 @@ can be displayed with "-h", as usual.
 This sample application uses libbpf to make the setup and usage of
 AF_XDP simpler. If you want to know how the raw uapi of AF_XDP is
 really used to make something more advanced, take a look at the libbpf
-code in tools/testing/selftests/bpf/xsk.[ch].
+code in tools/testing/selftests/net/lib/xsk/xsk.[ch].
 
 FAQ
 =======
diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..a3f097ba9ff1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29726,7 +29726,8 @@ F:	include/net/xsk_buff_pool.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
-F:	tools/testing/selftests/bpf/*xsk*
+F:	tools/testing/selftests/net/*xsk*
+F:	tools/testing/selftests/net/lib/xsk/
 
 XEN BLOCK SUBSYSTEM
 M:	Roger Pau Monné <roger@xenproject.org>
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 986a6389186b..3c3183ea3c83 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -37,7 +37,6 @@ test_cpp
 /uprobe_multi
 *.ko
 *.tmp
-xskxceiver
 xdp_redirect_multi
 xdp_synproxy
 xdp_hw_metadata
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 93c707116fad..a2d357781c0f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -62,7 +62,8 @@ COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
-	  -I$(CURDIR)/libarena/include
+	  -I$(CURDIR)/libarena/include					\
+	  -I$(CURDIR)/../net/lib/xsk
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
@@ -118,14 +119,13 @@ TEST_GEN_PROGS += test_progs-cpuv4
 TEST_INST_SUBDIRS += cpuv4
 endif
 
-TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
+TEST_FILES = $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_lirc_mode2.sh \
 	test_bpftool_build.sh \
 	test_doc_build.sh \
-	test_xsk.sh \
 	test_xdp_features.sh
 
 TEST_PROGS_EXTENDED := \
@@ -144,8 +144,7 @@ TEST_GEN_PROGS_EXTENDED = \
 	veristat \
 	xdp_features \
 	xdp_hw_metadata \
-	xdp_synproxy \
-	xskxceiver
+	xdp_synproxy
 
 TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -542,7 +541,6 @@ linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
 test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
 test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
-xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
@@ -769,6 +767,8 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
+$(TRUNNER_OUTPUT)/xsk.o: ../net/lib/xsk/xsk.h
+
 $(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
 	$$(call msg,LIB-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
@@ -845,6 +845,10 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
 endif
 
+# xsk.c lives in ../net/lib/xsk so it can be shared with selftests/net;
+# let make find it there instead of keeping a local copy.
+vpath %.c ../net/lib/xsk
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -931,18 +935,9 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-# Keep xskxceiver independent from test_progs object dependencies.
-$(OUTPUT)/xskxceiver: xskxceiver.c xsk.c network_helpers.c \
-			   $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c \
-			   xskxceiver.h xsk.h network_helpers.h \
-			   prog_tests/test_xsk.h test_progs.h bpf_util.h \
-			   $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
-	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-
-$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xsk.c network_helpers.c \
+$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c ../net/lib/xsk/xsk.c network_helpers.c \
 			   $(TOOLSDIR)/lib/find_bit.c xdp_metadata.h \
-			   xsk.h network_helpers.h test_progs.h bpf_util.h \
+			   ../net/lib/xsk/xsk.h network_helpers.h test_progs.h bpf_util.h \
 			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index cdf2d7d3ab32..d72d7022cc69 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -622,54 +622,6 @@ int get_socket_local_port(int sock_fd)
 	return -1;
 }
 
-int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
-{
-	struct ifreq ifr = {0};
-	int sockfd, err;
-
-	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0)
-		return -errno;
-
-	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
-
-	ring_param->cmd = ETHTOOL_GRINGPARAM;
-	ifr.ifr_data = (char *)ring_param;
-
-	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
-		err = errno;
-		close(sockfd);
-		return -err;
-	}
-
-	close(sockfd);
-	return 0;
-}
-
-int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
-{
-	struct ifreq ifr = {0};
-	int sockfd, err;
-
-	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0)
-		return -errno;
-
-	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
-
-	ring_param->cmd = ETHTOOL_SRINGPARAM;
-	ifr.ifr_data = (char *)ring_param;
-
-	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
-		err = errno;
-		close(sockfd);
-		return -err;
-	}
-
-	close(sockfd);
-	return 0;
-}
-
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 75133119c04a..e7333b769150 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -89,8 +89,6 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
-int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
-int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 int open_tuntap(const char *dev_name, bool need_mac);
 
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 517c09d60bef..80a8e34deac9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -116,6 +116,7 @@ TEST_PROGS := \
 	test_vxlan_under_vrf.sh \
 	test_vxlan_vnifilter_notify.sh \
 	test_vxlan_vnifiltering.sh \
+	test_xsk.sh \
 	tfo_passive.sh \
 	traceroute.sh \
 	txtimestamp.sh \
@@ -205,6 +206,7 @@ TEST_FILES := \
 	in_netns.sh \
 	lib.sh \
 	settings \
+	xsk_prereqs.sh \
 # end of TEST_FILES
 
 # YNL files, must be before "include ..lib.mk"
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 30d5fcb09a83..eddc8dcd7da6 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -135,5 +135,6 @@ CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VXLAN=m
+CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
index 6cd2b762af5d..1106fef3041f 100644
--- a/tools/testing/selftests/net/lib/.gitignore
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -2,3 +2,5 @@
 csum
 gro
 xdp_helper
+xsk_xdp_progs.skel.h
+xskxceiver
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index ff83603397d0..4f220748fad6 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -18,8 +18,40 @@ TEST_GEN_FILES := \
 	xdp_helper \
 # end of TEST_GEN_FILES
 
+BPFTOOL ?= bpftool
+HAS_BPFTOOL := $(shell command -v $(BPFTOOL) >/dev/null 2>&1 && echo y)
+ifeq ($(HAS_BPFTOOL),y)
+TEST_GEN_FILES += xskxceiver
+else
+$(warning excluding xskxceiver, bpftool not found)
+endif
+
 TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
 include ../../lib.mk
 
 include ../bpf.mk
+
+# AF_XDP test engine used by net/test_xsk.sh.
+XSK_DIR := xsk
+XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
+XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
+XSK_SOURCES := $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c) \
+	$(top_srcdir)/tools/lib/find_bit.c
+XSK_HEADERS := $(wildcard $(XSK_DIR)/*.h)
+
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+XSK_LDLIBS := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf) -lz
+
+$(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common.h $(BPFOBJ)
+	$(call msg,BPF_PROG,,$@)
+	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
+		-Wno-compare-distinct-pointer-types -c $< -o $@
+
+$(OUTPUT)/xskxceiver: $(XSK_SOURCES) $(XSK_HEADERS) $(XSK_SKEL) $(BPFOBJ)
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -I$(top_srcdir)/tools/include -I$(OUTPUT) \
+		-I$(SCRATCH_DIR)/include \
+		$(XSK_SOURCES) $(BPFOBJ) $(LDLIBS) $(XSK_LDLIBS) -o $@
+
+EXTRA_CLEAN += $(XSK_BPF_OBJ) $(XSK_SKEL)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
similarity index 99%
rename from tools/testing/selftests/bpf/prog_tests/test_xsk.c
rename to tools/testing/selftests/net/lib/xsk/test_xsk.c
index cee959cfe7e5..237d9e076e10 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
 #include <bpf/bpf.h>
 #include <errno.h>
 #include <linux/bitmap.h>
@@ -13,7 +14,6 @@
 #include <sys/time.h>
 #include <unistd.h>
 
-#include "network_helpers.h"
 #include "test_xsk.h"
 #include "xsk_xdp_common.h"
 #include "xsk_xdp_progs.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
similarity index 99%
rename from tools/testing/selftests/bpf/prog_tests/test_xsk.h
rename to tools/testing/selftests/net/lib/xsk/test_xsk.h
index b182a75d5705..0717d855e4df 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -5,7 +5,7 @@
 #include <linux/ethtool.h>
 #include <linux/if_xdp.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "xsk.h"
 
 #ifndef SO_PREFER_BUSY_POLL
diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
similarity index 95%
rename from tools/testing/selftests/bpf/xsk.c
rename to tools/testing/selftests/net/lib/xsk/xsk.c
index 25d568abf0f2..6bd32caf5d08 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk.c
@@ -35,7 +35,6 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "xsk.h"
-#include "bpf_util.h"
 
 #ifndef SOL_XDP
  #define SOL_XDP 283
@@ -779,3 +778,51 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 		close(xsk->fd);
 	free(xsk);
 }
+
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
+{
+	struct ifreq ifr = {0};
+	int sockfd, err;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return -errno;
+
+	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	ring_param->cmd = ETHTOOL_GRINGPARAM;
+	ifr.ifr_data = (char *)ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		err = errno;
+		close(sockfd);
+		return -err;
+	}
+
+	close(sockfd);
+	return 0;
+}
+
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
+{
+	struct ifreq ifr = {0};
+	int sockfd, err;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return -errno;
+
+	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	ring_param->cmd = ETHTOOL_SRINGPARAM;
+	ifr.ifr_data = (char *)ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		err = errno;
+		close(sockfd);
+		return -err;
+	}
+
+	close(sockfd);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/net/lib/xsk/xsk.h
similarity index 97%
rename from tools/testing/selftests/bpf/xsk.h
rename to tools/testing/selftests/net/lib/xsk/xsk.h
index 48729da142c2..3f1fea999763 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdbool.h>
+#include <linux/ethtool.h>
 #include <linux/if_xdp.h>
 
 #include <bpf/libbpf.h>
@@ -242,6 +243,9 @@ void xsk_socket__delete(struct xsk_socket *xsk);
 
 int xsk_set_mtu(int ifindex, int mtu);
 
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
similarity index 100%
rename from tools/testing/selftests/bpf/xsk_xdp_common.h
rename to tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
rename to tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
similarity index 99%
rename from tools/testing/selftests/bpf/xskxceiver.c
rename to tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 1256242959cb..f4a2f45a6752 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -81,6 +81,7 @@
 #include <linux/netdev.h>
 #include <linux/ethtool.h>
 #include <linux/align.h>
+#include <linux/kernel.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -91,7 +92,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 
-#include "prog_tests/test_xsk.h"
+#include "test_xsk.h"
 #include "xsk_xdp_progs.skel.h"
 #include "xsk.h"
 #include "xskxceiver.h"
@@ -100,14 +101,10 @@
 #include "kselftest.h"
 #include "xsk_xdp_common.h"
 
-#include <network_helpers.h>
-
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
 
-void test__fail(void) { /* for network_helpers.c */ }
-
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
 	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line,
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/net/lib/xsk/xskxceiver.h
similarity index 100%
rename from tools/testing/selftests/bpf/xskxceiver.h
rename to tools/testing/selftests/net/lib/xsk/xskxceiver.h
diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
similarity index 100%
rename from tools/testing/selftests/bpf/test_xsk.sh
rename to tools/testing/selftests/net/test_xsk.sh
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/net/xsk_prereqs.sh
similarity index 98%
rename from tools/testing/selftests/bpf/xsk_prereqs.sh
rename to tools/testing/selftests/net/xsk_prereqs.sh
index ebff0f95d14b..5e5c8ef3fff2 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/net/xsk_prereqs.sh
@@ -8,7 +8,7 @@ ksft_xfail=2
 ksft_xpass=3
 ksft_skip=4
 
-XSKOBJ=xskxceiver
+XSKOBJ=lib/xskxceiver
 
 validate_root_exec()
 {
-- 
2.43.0

