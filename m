Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4D41BA7A;
	Thu, 13 Aug 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602641; cv=none; b=BNS5zjAOv3VNATWPFflNxCakuXYzvoBOAl1HEqF0X4qgM7V4xBoFsb2buoBFQ591ZBWnSMbs/+pGU+dn38XYTzx/YH4azKvw0zlVv8Ns/kob2BMBsMp5DYF6ruyylQScXniHteKSB3lLrbf/1jzb/GYsfY0ok8hiOrmkzF6qOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602641; c=relaxed/simple;
	bh=wmj7H1us1fczoQVz/DWWgbVwjvU6axXzf8KlcsdTO78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKRM5Gfn/Z/noVMufnyLfPegVEoGzuaRWGbVZ0Hh0IKgoDtXu6PIHZhOGxmF3cEnKM/IURI+LUjg0RcpUoLl/S5X+TSc7NhloVe7xQz+L9sP2A/xPOsVokZ/rAIgUeZV+xG9Gw4d5WnQouKUFFQkvaKpcPf/lxecGGsfUAknxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as4CN/DC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as4CN/DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602640; x=1818138640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wmj7H1us1fczoQVz/DWWgbVwjvU6axXzf8KlcsdTO78=;
  b=as4CN/DColyNXWiOwEujqW44m3SekecV7XvssweVaPeYEQginyeqwL8U
   dXE88X1Ft5Y81qMRWxZ6csBxWITpgD4ZHuK8Xj5UoZ8eRoA8QyFOKiI1G
   3SBk4c78VnfmmbPGTB+XopArLkLpucak1y8brUwvRXC15RYoPUgJ+jYW2
   9R6bOjaHsXCDpA0xbmC+e42RJd1ji8rBRc9uQXAE1BOMNEr5Uj1VbNhuG
   xyXgoL6PIsfnmMJrAxURSy4oGk6olldsjCbJF9ka01/2cpITBRMFBjSgs
   Ta0lcR3+m0Y4pR+PVVlikSXgUhPGW+Z59wjQ1DQC8bcS21pvypUj2+8FU
   A==;
X-CSE-ConnectionGUID: LkZ06AqOQlKBtiwjnbVHUw==
X-CSE-MsgGUID: rPTIDg/oRP+aPNYNbbqpDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86933905"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86933905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:40 -0700
X-CSE-ConnectionGUID: dHjA3GdzSUqWBXh2VUR3Jg==
X-CSE-MsgGUID: qQz+JxseSn6YECyTsyD5IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260033509"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:35 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v2 4/5] selftests/xsk: add shared-UMEM callback framework and initial test cases
Date: Thu, 13 Aug 2026 06:27:53 +0000
Message-ID: <20260813062754.360131-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813062754.360131-1-tushar.vyavahare@intel.com>
References: <20260813062754.360131-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runner callback infrastructure together with the first four
shared-UMEM test cases so each commit in the series builds clean.

In __test_spec_init(), shared_default derives shared_umem from TX/RX
ifindex equality so resets follow the same baseline behavior used by
xskxceiver startup. Add pkt_stream_len_seq() for alternating
short/long per-socket packet sizes, and pkt_stream_uneven_dist_seq() for
unequal packet volume across two sockets. Add run_shared_umem_test() as
the common runner that sets programs/maps, validates stream readiness,
runs the sequence callback, executes traffic, and optionally runs
post-validation. Define shared_umem_seq_fn, shared_umem_post_fn,
shared_umem_len_ctx, and shared_umem_uneven_dist_ctx in test_xsk.h for
shared use.

Add SHARED_UMEM_4_SOCKETS for a 4-socket even/odd split,
SHARED_UMEM_LENGTH_BASED for short-vs-long packet steering,
SHARED_UMEM_UNEVEN_DIST for a 1:3 packet-volume distribution check, and
SHARED_UMEM_UNALIGNED for even/odd sequencing in unaligned mode.

The unaligned test snapshots and restores prior alignment flags with
NULL-safe UMEM guards so behavior does not depend on test order.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 249 ++++++++++++++++++
 .../selftests/bpf/prog_tests/test_xsk.h       |  21 ++
 2 files changed, 270 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 6d3b2ecc957b..54143fc757e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -224,6 +224,12 @@ int hw_ring_size_reset(struct ifobject *ifobj)
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			     struct ifobject *ifobj_rx)
 {
+	/*
+	 * Keep the same default as xskxceiver startup: when TX and RX share the same netdev,
+	 * shared UMEM is the baseline mode for this test harness. Individual tests can still
+	 * override this as needed.
+	 */
+	bool shared_default = ifobj_tx->ifindex == ifobj_rx->ifindex;
 	u32 i, j;
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
@@ -235,6 +241,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		ifobj->use_fill_ring = true;
 		ifobj->release_rx = true;
 		ifobj->validation_func = NULL;
+		ifobj->shared_umem = shared_default;
 		ifobj->use_metadata = false;
 
 		if (i == 0) {
@@ -617,6 +624,86 @@ static int pkt_stream_even_odd_sequence(struct test_spec *test)
 	return 0;
 }
 
+static int pkt_stream_len_seq(struct test_spec *test, u32 short_len, u32 long_len)
+{
+	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
+	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
+	struct pkt_stream *pkt_stream;
+	u32 i;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		u32 pkt_len = i ? long_len : short_len;
+
+		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
+		tx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2, pkt_len, i, 2);
+		if (!tx_streams[i])
+			goto err;
+
+		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
+		rx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2, pkt_len, i, 2);
+		if (!rx_streams[i])
+			goto err;
+	}
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
+		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i < test->nb_sockets; i++) {
+		if (tx_streams[i])
+			pkt_stream_delete(tx_streams[i]);
+		if (rx_streams[i])
+			pkt_stream_delete(rx_streams[i]);
+	}
+
+	return -ENOMEM;
+}
+
+static int pkt_stream_uneven_dist_seq(struct test_spec *test, u32 total_pkts, u32 pkt_len)
+{
+	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
+	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
+	u32 i, pkts_sock0;
+
+	if (test->nb_sockets < 2 || total_pkts < 4)
+		return -EINVAL;
+
+	pkts_sock0 = total_pkts / 4;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		u32 nb_pkts = (i == 0) ? pkts_sock0 : (total_pkts - pkts_sock0);
+
+		tx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
+		if (!tx_streams[i])
+			goto err;
+
+		rx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
+		if (!rx_streams[i])
+			goto err;
+	}
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
+		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i < test->nb_sockets; i++) {
+		if (tx_streams[i])
+			pkt_stream_delete(tx_streams[i]);
+		if (rx_streams[i])
+			pkt_stream_delete(rx_streams[i]);
+	}
+
+	return -ENOMEM;
+}
+
 static void release_even_odd_sequence(struct test_spec *test)
 {
 	struct pkt_stream *later_free_tx = test->ifobj_tx->xsk->pkt_stream;
@@ -2288,6 +2375,168 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 	return ret;
 }
 
+static int shared_umem_test_prepare(struct test_spec *test)
+{
+	u32 i;
+
+	if (test->nb_sockets > MAX_SOCKETS) {
+		ksft_print_msg("ERROR: [%s] invalid socket count %u\n", __func__, test->nb_sockets);
+		return TEST_FAILURE;
+	}
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		if (!test->ifobj_rx->xsk_arr[i].pkt_stream ||
+		    !test->ifobj_tx->xsk_arr[i].pkt_stream) {
+			ksft_print_msg("ERROR: [%s] missing stream for socket %u\n", __func__, i);
+			return TEST_FAILURE;
+		}
+	}
+
+	return TEST_PASS;
+}
+
+static int shared_umem_seq_even_odd(struct test_spec *test, const void *ctx)
+{
+	(void)ctx;
+
+	return pkt_stream_even_odd_sequence(test) ? TEST_FAILURE : TEST_PASS;
+}
+
+static int shared_umem_seq_len(struct test_spec *test, const void *ctx)
+{
+	const struct shared_umem_len_ctx *cfg = ctx;
+
+	return pkt_stream_len_seq(test, cfg->short_len, cfg->long_len) ? TEST_FAILURE : TEST_PASS;
+}
+
+static int shared_umem_seq_uneven_dist(struct test_spec *test, const void *ctx)
+{
+	const struct shared_umem_uneven_dist_ctx *cfg = ctx;
+
+	return pkt_stream_uneven_dist_seq(test, cfg->total_pkts,
+					 cfg->pkt_len) ? TEST_FAILURE : TEST_PASS;
+}
+
+static int shared_umem_post_uneven_dist(struct test_spec *test, int ret, const void *ctx)
+{
+	struct pkt_stream *tx_stream_0, *tx_stream_1;
+	struct pkt_stream *rx_stream_0, *rx_stream_1;
+
+	(void)ctx;
+
+	tx_stream_0 = test->ifobj_tx->xsk_arr[0].pkt_stream;
+	tx_stream_1 = test->ifobj_tx->xsk_arr[1].pkt_stream;
+	rx_stream_0 = test->ifobj_rx->xsk_arr[0].pkt_stream;
+	rx_stream_1 = test->ifobj_rx->xsk_arr[1].pkt_stream;
+
+	if (tx_stream_1->nb_valid_entries <= tx_stream_0->nb_valid_entries)
+		return TEST_FAILURE;
+
+	if (!ret && rx_stream_1->nb_rx_pkts <= rx_stream_0->nb_rx_pkts) {
+		ksft_print_msg("ERROR: socket1 rx_pkts (%u) not greater than socket0 (%u)\n",
+			       rx_stream_1->nb_rx_pkts, rx_stream_0->nb_rx_pkts);
+		ret = TEST_FAILURE;
+	}
+
+	return ret;
+}
+
+static int run_shared_umem_test(struct test_spec *test, struct bpf_program *xdp_prog_rx,
+				struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
+				struct bpf_map *xskmap_tx, u32 nb_sockets,
+				shared_umem_seq_fn seq_fn, shared_umem_post_fn post_fn,
+				const void *ctx)
+{
+	int ret;
+
+	test->total_steps = 1;
+	test->nb_sockets = nb_sockets;
+
+	test_spec_set_xdp_prog(test, xdp_prog_rx, xdp_prog_tx, xskmap_rx, xskmap_tx);
+
+	ret = shared_umem_test_prepare(test);
+	if (ret)
+		return ret;
+
+	ret = seq_fn(test, ctx);
+	if (ret)
+		return ret;
+
+	ret = testapp_validate_traffic(test);
+	if (post_fn)
+		ret = post_fn(test, ret, ctx);
+
+	release_even_odd_sequence(test);
+
+	return ret;
+}
+
+int testapp_shared_umem_4_sockets(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+
+	return run_shared_umem_test(test, skel_rx->progs.xsk_xdp_shared_umem,
+				    skel_tx->progs.xsk_xdp_shared_umem, skel_rx->maps.xsk,
+				    skel_tx->maps.xsk, 4, shared_umem_seq_even_odd, NULL, NULL);
+}
+
+int testapp_shared_umem_length_based(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	const struct shared_umem_len_ctx len_ctx = {
+		.short_len = MIN_PKT_SIZE,
+		.long_len = MIN_PKT_SIZE * 2,
+	};
+
+	return run_shared_umem_test(test, skel_rx->progs.xsk_xdp_shared_umem_length_based,
+				    skel_tx->progs.xsk_xdp_shared_umem_length_based,
+				    skel_rx->maps.xsk, skel_tx->maps.xsk, 2, shared_umem_seq_len,
+				    NULL, &len_ctx);
+}
+
+int testapp_shared_umem_uneven_dist(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	const struct shared_umem_uneven_dist_ctx uneven_dist_ctx = {
+		.total_pkts = DEFAULT_PKT_CNT * 4,
+		.pkt_len = MIN_PKT_SIZE,
+	};
+
+	return run_shared_umem_test(test, skel_rx->progs.xsk_xdp_shared_umem,
+				    skel_tx->progs.xsk_xdp_shared_umem, skel_rx->maps.xsk,
+				    skel_tx->maps.xsk, 2, shared_umem_seq_uneven_dist,
+				    shared_umem_post_uneven_dist, &uneven_dist_ctx);
+}
+
+int testapp_shared_umem_unaligned(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	struct xsk_umem_info *tx_umem = test->ifobj_tx && test->ifobj_tx->xsk ?
+		test->ifobj_tx->xsk->umem : NULL;
+	struct xsk_umem_info *rx_umem = test->ifobj_rx && test->ifobj_rx->xsk ?
+		test->ifobj_rx->xsk->umem : NULL;
+	bool tx_unaligned = tx_umem ? tx_umem->unaligned_mode : false;
+	bool rx_unaligned = rx_umem ? rx_umem->unaligned_mode : false;
+	int ret;
+
+	test_spec_set_unaligned(test);
+
+	ret = run_shared_umem_test(test, skel_rx->progs.xsk_xdp_shared_umem,
+				   skel_tx->progs.xsk_xdp_shared_umem, skel_rx->maps.xsk,
+				   skel_tx->maps.xsk, 2, shared_umem_seq_even_odd, NULL, NULL);
+
+	if (tx_umem)
+		tx_umem->unaligned_mode = tx_unaligned;
+	if (rx_umem)
+		rx_umem->unaligned_mode = rx_unaligned;
+
+	return ret;
+}
+
 int testapp_poll_txq_tmout(struct test_spec *test)
 {
 	bool shared_umem = test->ifobj_tx->shared_umem;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 5f98706ca0b5..93dcf66b4e62 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -80,6 +80,9 @@ struct test_spec;
 typedef int (*validation_func_t)(struct ifobject *ifobj);
 typedef void *(*thread_func_t)(void *arg);
 typedef int (*test_func_t)(struct test_spec *test);
+typedef int (*shared_umem_seq_fn)(struct test_spec *test, const void *ctx);
+typedef int (*shared_umem_post_fn)(struct test_spec *test, int ret,
+					   const void *ctx);
 
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
@@ -182,6 +185,16 @@ struct pkt_stream {
 	bool verbatim;
 };
 
+struct shared_umem_len_ctx {
+	u32 short_len;
+	u32 long_len;
+};
+
+struct shared_umem_uneven_dist_ctx {
+	u32 total_pkts;
+	u32 pkt_len;
+};
+
 static inline bool pkt_continues(u32 options)
 {
 	return options & XDP_PKT_CONTD;
@@ -271,6 +284,10 @@ int testapp_xdp_metadata(struct test_spec *test);
 int testapp_xdp_metadata_mb(struct test_spec *test);
 int testapp_xdp_prog_cleanup(struct test_spec *test);
 int testapp_xdp_shared_umem(struct test_spec *test);
+int testapp_shared_umem_4_sockets(struct test_spec *test);
+int testapp_shared_umem_length_based(struct test_spec *test);
+int testapp_shared_umem_uneven_dist(struct test_spec *test);
+int testapp_shared_umem_unaligned(struct test_spec *test);
 
 void *worker_testapp_validate_rx(void *arg);
 void *worker_testapp_validate_tx(void *arg);
@@ -294,6 +311,10 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
 	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
 	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
+	{.name = "SHARED_UMEM_4_SOCKETS", .test_func = testapp_shared_umem_4_sockets},
+	{.name = "SHARED_UMEM_LENGTH_BASED", .test_func = testapp_shared_umem_length_based},
+	{.name = "SHARED_UMEM_UNEVEN_DIST", .test_func = testapp_shared_umem_uneven_dist},
+	{.name = "SHARED_UMEM_UNALIGNED", .test_func = testapp_shared_umem_unaligned},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
-- 
2.43.0

