Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB758E2A1;
	Fri, 16 Oct 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172651; cv=none; b=Jtvm2CNAR5UbHytKMqOruzD6UIpCh9wJG/nFLrxhAlv/duJMtbBOd2WFt82hHXZmv5BKVAJQn9mMO9koIuH5X0dmGIkp/vsHt2uRWTB5wAAi+VzafZKQLwEdbZel4rCQPNevB/LLNH5GEXVXzfEyzqxKBetg8GdJsE7XEV9q3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172651; c=relaxed/simple;
	bh=PtH89gcpYQ1lIffJdLEcVje1ThEn9Fqsr0/rLQw2zaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj1PRSB1YIPYmBNW10+nR73v858k4fzPW2NGwZIf2Ob8Q+ktYpMsn1vxyjUIltjkkRXk1J33NrGLTgONKuR0+jZHuuUzap/RSrWepU1g6fGNikwzsHea7ABmC9BmJ28vA/WZ1SQzdZfx1SGj4bw3qgZhVV8yq9A3NI11oHeQpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8N9DbWi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8N9DbWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172649; x=1823708649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PtH89gcpYQ1lIffJdLEcVje1ThEn9Fqsr0/rLQw2zaY=;
  b=J8N9DbWi0rwsIdOCEOoDld/3aG/Dbrv7VXlmOkYPRCRfhzHeOfCQmx+E
   E8xyIbs+DLdfgU1ZbQtye5tMnQxiDDPoz7EuBIk0mni0GUy6UlLn8lYl7
   TzUbPx5kREJ+l/uxdmni3kcs5L+Rl2TMfCyYHBfcPlJZGr79nXqaYselg
   vXeg5XfDIBFlYiAysERg3anHz+2bA42dL5pGhHlz7eDag23XOh7vQBRlM
   id/oQTeMuz9fkyr+yZwxc9iOTiHdAFh3hwUebu/LicyJCfGpE0VCR9UDw
   sqxuQfLx/q8sv+o0ois97TQsuVq61Lr1XX9EIiwKEdag/RChPfLoQVgqv
   Q==;
X-CSE-ConnectionGUID: orldVJPNRwyboY6/+fKkhA==
X-CSE-MsgGUID: j0jLejtoRzSvml5eOBG+Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972370"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:08 -0700
X-CSE-ConnectionGUID: EAUQ7VcDRoC6TLprJaqpQQ==
X-CSE-MsgGUID: CST2rrz+QemFWrmKd727BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425208"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:06 -0700
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
Subject: [PATCH v4 net-next 08/15] selftests: xsk: split xskxceiver main() into setup, run and cleanup
Date: Fri, 16 Oct 2026 19:43:31 +0200
Message-Id: <20261016174338.787135-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prepare xskxceiver for running a single endpoint per process by
untangling main():

- bind_iface() sets up one interface from its -i argument, so that
  interfaces can get their roles after parsing; -l needs none
- detect_mode_caps() and detect_ifobj_caps() record DRV, zero-copy and
  HW ring support as XSK_CAP flags, which mode_supported() checks
- run_pkt_test() returns the result, which main() counts instead of
  test->fail, as not every failing path sets it
- cleanup_iface() detaches and unloads one interface and copes with
  partially initialized objects, as does pkt_stream_delete(NULL), so
  main() has a single exit path; it takes the XDP flags from
  mode_to_xdp_flags(), now exported, so that they match the attach

Call ksft_print_header(), which also switches stdout to line buffering,
right after parsing the command line: xskxceiver never called it, so a
launcher reading through a pipe only saw the output at exit. -l prints
no TAP header and exits with 0 instead of KSFT_XPASS, as listing the
tests is not a test result.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  |  10 +-
 .../testing/selftests/net/lib/xsk/test_xsk.h  |   3 +
 .../selftests/net/lib/xsk/xskxceiver.c        | 180 +++++++++---------
 3 files changed, 106 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index edb1feb54c54..76d079d8be23 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -64,7 +64,7 @@ static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
 	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
 }
 
-static u32 mode_to_xdp_flags(enum test_mode mode)
+u32 mode_to_xdp_flags(enum test_mode mode)
 {
 	return (mode == TEST_MODE_SKB) ? XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE;
 }
@@ -338,6 +338,9 @@ static struct pkt *pkt_stream_get_next_rx_pkt(struct pkt_stream *pkt_stream, u32
 
 void pkt_stream_delete(struct pkt_stream *pkt_stream)
 {
+	if (!pkt_stream)
+		return;
+
 	free(pkt_stream->pkts);
 	free(pkt_stream);
 }
@@ -2291,6 +2294,11 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
 		}
 	}
 
+	if (!get_hw_ring_size(ifobj->ifname, &ifobj->ring)) {
+		ifobj_set_cap(ifobj, XSK_CAP_HW_RING);
+		ifobj->caps.tx_max_pending = ifobj->ring.tx_max_pending;
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 716ea044797c..8503ef055d37 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -116,6 +116,8 @@ struct xsk_umem_info {
 #define XSK_CAP_MBUF             (1U << 1)
 #define XSK_CAP_MBUF_ZC          (1U << 2)
 #define XSK_CAP_HW_RING          (1U << 3)
+#define XSK_CAP_DRV              (1U << 4)
+#define XSK_CAP_ZC               (1U << 5)
 
 struct xsk_caps {
 	u32 flags;
@@ -164,6 +166,7 @@ static inline void ifobj_set_cap(struct ifobject *ifobj, u32 cap)
 struct ifobject *ifobject_create(void);
 void ifobject_delete(struct ifobject *ifobj);
 int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
+u32 mode_to_xdp_flags(enum test_mode mode);
 
 int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void *buffer, u64 size);
 int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index d82224a4fa4b..97eece4c57f8 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -81,7 +81,6 @@
 #include <linux/netdev.h>
 #include <linux/ethtool.h>
 #include <linux/align.h>
-#include <linux/kernel.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -101,7 +100,6 @@
 #include "kselftest.h"
 #include "xsk_xdp_common.h"
 
-static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
 
@@ -185,17 +183,40 @@ static void print_usage(char **argv)
 	ksft_exit_xfail();
 }
 
-static bool validate_interface(struct ifobject *ifobj)
+static void bind_iface(struct ifobject *ifobj, const char *ifname, thread_func_t func,
+		       char **argv)
 {
-	if (!strcmp(ifobj->ifname, ""))
-		return false;
-	return true;
+	size_t len = ifname ? strlen(ifname) : 0;
+
+	if (!len || len >= sizeof(ifobj->ifname))
+		print_usage(argv);
+
+	memcpy(ifobj->ifname, ifname, len + 1);
+	ifobj->ifindex = if_nametoindex(ifobj->ifname);
+	if (!ifobj->ifindex) {
+		ksft_print_msg("Error: cannot resolve interface %s\n", ifobj->ifname);
+		ksft_exit_fail();
+	}
+
+	if (init_iface(ifobj, func)) {
+		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifname);
+		ksft_exit_fail();
+	}
+}
+
+static void print_tests(void)
+{
+	u32 i;
+
+	printf("Tests:\n");
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		printf("%u: %s\n", i, tests[i].name);
 }
 
 static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx, int argc,
 			       char **argv)
 {
-	struct ifobject *ifobj;
+	const char *ifname[2] = {};
 	u32 interface_nb = 0;
 	int option_index, c;
 
@@ -208,21 +229,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 		switch (c) {
 		case 'i':
-			if (interface_nb == 0)
-				ifobj = ifobj_tx;
-			else if (interface_nb == 1)
-				ifobj = ifobj_rx;
-			else
+			if (interface_nb >= ARRAY_SIZE(ifname))
 				break;
 
-			memcpy(ifobj->ifname, optarg,
-			       min_t(size_t, MAX_INTERFACE_NAME_CHARS, strlen(optarg)));
-
-			ifobj->ifindex = if_nametoindex(ifobj->ifname);
-			if (!ifobj->ifindex)
-				exit_with_error(errno);
-
-			interface_nb++;
+			ifname[interface_nb++] = optarg;
 			break;
 		case 'v':
 			opt_verbose = true;
@@ -242,7 +252,8 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 				print_usage(argv);
 			break;
 		case 'l':
-			opt_print_tests = true;
+			print_tests();
+			ksft_exit_pass();
 			break;
 		case 't':
 			errno = 0;
@@ -255,6 +266,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			print_usage(argv);
 		}
 	}
+
+	bind_iface(ifobj_tx, ifname[0], worker_testapp_validate_tx, argv);
+	bind_iface(ifobj_rx, ifname[1], worker_testapp_validate_rx, argv);
 }
 
 static void xsk_unload_xdp_programs(struct ifobject *ifobj)
@@ -262,7 +276,7 @@ static void xsk_unload_xdp_programs(struct ifobject *ifobj)
 	xsk_xdp_progs__destroy(ifobj->xdp_progs);
 }
 
-static void run_pkt_test(struct test_spec *test)
+static int run_pkt_test(struct test_spec *test)
 {
 	int ret;
 
@@ -287,6 +301,7 @@ static void run_pkt_test(struct test_spec *test)
 	}
 
 	pkt_stream_restore_default(test);
+	return ret;
 }
 
 static bool is_xdp_supported(int ifindex)
@@ -317,26 +332,43 @@ static bool is_xdp_supported(int ifindex)
 	return true;
 }
 
-static void print_tests(void)
+static u32 detect_mode_caps(struct ifobject *ifobj)
 {
-	u32 i;
+	if (is_xdp_supported(ifobj->ifindex)) {
+		ifobj_set_cap(ifobj, XSK_CAP_DRV);
+		if (ifobj_zc_avail(ifobj))
+			ifobj_set_cap(ifobj, XSK_CAP_ZC);
+	}
 
-	printf("Tests:\n");
-	for (i = 0; i < ARRAY_SIZE(tests); i++)
-		printf("%u: %s\n", i, tests[i].name);
+	return ifobj->caps.flags;
+}
+
+static bool mode_supported(enum test_mode mode, u32 caps)
+{
+	if (mode == TEST_MODE_SKB)
+		return true;
+	if (mode == TEST_MODE_DRV)
+		return caps & XSK_CAP_DRV;
+	return caps & XSK_CAP_ZC;
+}
+
+static void cleanup_iface(struct ifobject *ifobj)
+{
+	if (ifobj->xdp_prog)
+		xsk_detach_xdp_program(ifobj->ifindex,
+				       mode_to_xdp_flags(ifobj->mode));
+	xsk_unload_xdp_programs(ifobj);
 }
 
 int main(int argc, char **argv)
 {
 	u32 cache_line_size, max_frags, umem_tailroom;
 	const size_t total_tests = ARRAY_SIZE(tests);
-	struct pkt_stream *rx_pkt_stream_default;
-	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
 	u32 i, j, failed_tests = 0, nb_tests;
-	int modes = TEST_MODE_SKB + 1;
-	struct test_spec test;
-	int ret;
+	struct test_spec test = {};
+	int ret = TEST_FAILURE;
+	u32 caps, modes = 0;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -350,6 +382,10 @@ int main(int argc, char **argv)
 
 	setlocale(LC_ALL, "");
 
+	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
+	/* Line-buffer stdout so verdicts reach a capturing launcher live. */
+	ksft_print_header();
+
 	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
 	if (!cache_line_size) {
 		ksft_print_msg("Can't get SMP_CACHE_BYTES from system, using default (64)\n");
@@ -371,90 +407,62 @@ int main(int argc, char **argv)
 	ifobj_tx->caps.umem_tailroom = umem_tailroom;
 	ifobj_rx->caps.umem_tailroom = umem_tailroom;
 
-	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
-
-	if (opt_print_tests) {
-		print_tests();
-		ksft_exit_xpass();
-	}
 	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
 		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
 
-	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
-		print_usage(argv);
-
-	if (is_xdp_supported(ifobj_tx->ifindex)) {
-		modes++;
-		if (ifobj_zc_avail(ifobj_tx))
-			modes++;
-	}
+	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (!test.tx_pkt_stream_default || !test.rx_pkt_stream_default)
+		goto out;
 
-	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
-	if (!ret) {
-		ifobj_set_cap(ifobj_tx, XSK_CAP_HW_RING);
-		ifobj_tx->caps.tx_max_pending = ifobj_tx->ring.tx_max_pending;
-	}
+	caps = detect_mode_caps(ifobj_tx);
 
-	if (init_iface(ifobj_rx, worker_testapp_validate_rx) ||
-	    init_iface(ifobj_tx, worker_testapp_validate_tx)) {
-		ksft_print_msg("Error : can't initialize interfaces\n");
+	if (opt_mode != TEST_MODE_ALL && !mode_supported(opt_mode, caps)) {
+		if (opt_mode == TEST_MODE_DRV)
+			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
+		else
+			ksft_print_msg("Error: zero-copy mode not supported.\n");
 		ksft_exit_xfail();
 	}
 
-	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
-	tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
-		exit_with_error(ENOMEM);
-	test.tx_pkt_stream_default = tx_pkt_stream_default;
-	test.rx_pkt_stream_default = rx_pkt_stream_default;
-
+	for (i = TEST_MODE_SKB; i <= TEST_MODE_ZC; i++)
+		if ((opt_mode == TEST_MODE_ALL || i == opt_mode) && mode_supported(i, caps))
+			modes++;
 	if (opt_run_test == RUN_ALL_TESTS)
 		nb_tests = total_tests;
 	else
 		nb_tests = 1;
-	if (opt_mode == TEST_MODE_ALL) {
-		ksft_set_plan(modes * nb_tests);
-	} else {
-		if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
-			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
-			ksft_exit_xfail();
-		}
-		if (opt_mode == TEST_MODE_ZC && modes <= TEST_MODE_ZC) {
-			ksft_print_msg("Error: zero-copy mode not supported.\n");
-			ksft_exit_xfail();
-		}
+	ksft_set_plan(modes * nb_tests);
 
-		ksft_set_plan(nb_tests);
-	}
-
-	for (i = 0; i < modes; i++) {
+	for (i = TEST_MODE_SKB; i <= TEST_MODE_ZC; i++) {
 		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
 			continue;
+		if (!mode_supported(i, caps))
+			continue;
 
 		for (j = 0; j < total_tests; j++) {
 			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
 				continue;
 
 			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
-			run_pkt_test(&test);
-			usleep(USLEEP_MAX);
-
-			if (test.fail)
+			if (run_pkt_test(&test) == TEST_FAILURE)
 				failed_tests++;
+			usleep(USLEEP_MAX);
 		}
 	}
+	ret = failed_tests ? TEST_FAILURE : TEST_PASS;
 
-	pkt_stream_delete(tx_pkt_stream_default);
-	pkt_stream_delete(rx_pkt_stream_default);
-	xsk_unload_xdp_programs(ifobj_tx);
-	xsk_unload_xdp_programs(ifobj_rx);
+out:
+	cleanup_iface(ifobj_tx);
+	cleanup_iface(ifobj_rx);
+	pkt_stream_delete(test.tx_pkt_stream_default);
+	pkt_stream_delete(test.rx_pkt_stream_default);
 	ifobject_delete(ifobj_tx);
 	ifobject_delete(ifobj_rx);
 
-	if (failed_tests)
+	if (ret)
 		ksft_exit_fail();
 	else
 		ksft_exit_pass();
-- 
2.43.0

