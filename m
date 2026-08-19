Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340E3B2AA;
	Wed, 19 Aug 2026 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107654; cv=none; b=onSERN7rDmJbHPySoTIYcbC0cz/5Tt4EA3q94vy7t9Mb7OmnYAji/Cj2f4vpSau9p3vtcSD0SR/+AvOu+1quRvhLlL2tDosk+SWwDHlZNV/1IaKXYgIyDvbPYs1efdQB+XnrMoPqkExlZjamAa8U8kc3hvShol00IXg7+Kvlums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107654; c=relaxed/simple;
	bh=8kecuwMXa9MM3QsGlrEMss7jPKQK3xqIEl1HySkpef0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daQkHzCH0Bu0iqfEzXi4XEZG7C3FZomDu/WU6GarREsqdTOU3PnNQXHqiArCHAl/zDWvI3pigmDjgylMf0JCQupR+CzpljvDn2wIEyl2CCkqDFcNauRR/92eCQoGYmGu35y46Tn9xRGVEjmKfNK25ewt+/quLzU2AxsLk4PYrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9qPTdaf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9qPTdaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787107652; x=1818643652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kecuwMXa9MM3QsGlrEMss7jPKQK3xqIEl1HySkpef0=;
  b=J9qPTdafUVNbfGLQtjx2pOaqO1Pp+2qgEAhfufiECc0FwBHGk82Kirm2
   9jILVj2YwHjQMFNmmEHCKDere1PvzG5lblg2oabsGc/wTCdBdGtWcrrIH
   yVi5Y4zAzt4/S+L3AN2cP/eh8QCktMtscdFF0ggpX4rXW6JiMSyHJAbIU
   y4CFQDgHignKGCDrF/Yz2TXI8kM3zmShTgmoWyHAUxKPqCKa1bhvRfYq3
   t8VvI1ED7drrFKF0v6OO+HbSygcd/smoLaNjO85eQPhH148CEHJfKuKPb
   vNgdwxbR0KTBRWDSImAAlrbkv/tni/vR769zbZUJ83FfDZGQjZXDFr8aM
   A==;
X-CSE-ConnectionGUID: 39rQ/7rbRFeGU84NQmGlVw==
X-CSE-MsgGUID: ySZo836RRK22gYESa92lUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87465302"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87465302"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:32 -0700
X-CSE-ConnectionGUID: qZ1AaX5rRjiL4axO0Mgy9Q==
X-CSE-MsgGUID: WJir7BPdTtelSFVAEUeXrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264974422"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:28 -0700
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
Subject: [PATCH net-next v3 4/4] selftests/xsk: add shared-UMEM callback framework and initial test cases
Date: Wed, 19 Aug 2026 02:44:43 +0000
Message-ID: <20260819024443.781764-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
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
xskxceiver startup. Add run_shared_umem_test() as the common runner that
sets programs/maps, runs the sequence callback, and executes traffic.
Declare shared_umem_seq_fn, pkt_stream_dims_fn, shared_umem_len_ctx and
shared_umem_uneven_dist_ctx in test_xsk.h, alongside the existing test
typedefs and packet stream definitions.

Add pkt_stream_replace_seq() to regenerate every per-socket stream from
a pkt_stream_dims_fn callback that supplies the packet count and length
for a slot. The generated streams are staged in temporary arrays and
published into xsk_arr[] only after every allocation has succeeded, so a
mid-loop failure frees the new streams and leaves the socket arrays
untouched. The streams being replaced are the defaults owned by test_spec
and aliased by every slot, so they are not freed on publication. The three
sequences differ only in their dims callback: even/odd halving,
alternating short/long packet sizes, and a 1:3 packet-volume split across
two sockets.

Add SHARED_UMEM_4_SOCKETS for a 4-socket even/odd split,
SHARED_UMEM_LENGTH_BASED for short-vs-long packet steering,
SHARED_UMEM_UNEVEN_DIST for the 1:3 packet-volume distribution, and
SHARED_UMEM_UNALIGNED for even/odd sequencing in unaligned mode. The
distribution is asserted by the generic per-socket packet accounting in
receive_pkts(), which requires nb_rx_pkts to match nb_valid_entries for
every socket.

Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 199 ++++++++++++++++--
 .../selftests/bpf/prog_tests/test_xsk.h       |  22 ++
 2 files changed, 206 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 814b8325493f..5d4eb47cbfee 100644
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
@@ -593,28 +600,95 @@ static int pkt_stream_receive_half(struct test_spec *test)
 	return 0;
 }
 
-static int pkt_stream_even_odd_sequence(struct test_spec *test)
+/*
+ * Regenerate every per-socket stream, publishing into xsk_arr[]
+ * only once all allocations have succeeded. @dims supplies the
+ * per-socket packet count and length, derived from the stream
+ * currently installed in the slot.
+ *
+ * The replaced streams are the defaults owned by test_spec, which
+ * every slot aliases, so they must not be freed here.
+ */
+static int pkt_stream_replace_seq(struct test_spec *test, pkt_stream_dims_fn dims,
+				  const void *ctx)
 {
-	struct pkt_stream *pkt_stream;
-	u32 i;
+	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
+	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
+	u32 i, nb_pkts, pkt_len;
 
 	for (i = 0; i < test->nb_sockets; i++) {
-		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
-		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
-						   pkt_stream->pkts[0].len, i, 2);
-		if (!pkt_stream)
-			return -ENOMEM;
-		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
+		dims(test->ifobj_tx->xsk_arr[i].pkt_stream, i, ctx, &nb_pkts, &pkt_len);
+		tx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
+		if (!tx_streams[i])
+			goto err;
 
-		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
-		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
-						   pkt_stream->pkts[0].len, i, 2);
-		if (!pkt_stream)
-			return -ENOMEM;
-		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
+		dims(test->ifobj_rx->xsk_arr[i].pkt_stream, i, ctx, &nb_pkts, &pkt_len);
+		rx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
+		if (!rx_streams[i])
+			goto err;
+	}
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
+		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
 	}
 
 	return 0;
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
+static void even_odd_dims(struct pkt_stream *orig, u32 sock_id, const void *ctx,
+			  u32 *nb_pkts, u32 *pkt_len)
+{
+	*nb_pkts = orig->nb_pkts / 2;
+	*pkt_len = orig->pkts[0].len;
+}
+
+static void len_dims(struct pkt_stream *orig, u32 sock_id, const void *ctx,
+		     u32 *nb_pkts, u32 *pkt_len)
+{
+	const struct shared_umem_len_ctx *cfg = ctx;
+
+	*nb_pkts = orig->nb_pkts / 2;
+	*pkt_len = sock_id ? cfg->long_len : cfg->short_len;
+}
+
+static void uneven_dist_dims(struct pkt_stream *orig, u32 sock_id, const void *ctx,
+			     u32 *nb_pkts, u32 *pkt_len)
+{
+	const struct shared_umem_uneven_dist_ctx *cfg = ctx;
+	u32 pkts_sock0 = cfg->total_pkts / 4;
+
+	*nb_pkts = sock_id ? cfg->total_pkts - pkts_sock0 : pkts_sock0;
+	*pkt_len = cfg->pkt_len;
+}
+
+static int pkt_stream_even_odd_sequence(struct test_spec *test)
+{
+	return pkt_stream_replace_seq(test, even_odd_dims, NULL);
+}
+
+static int pkt_stream_len_seq(struct test_spec *test, const struct shared_umem_len_ctx *cfg)
+{
+	return pkt_stream_replace_seq(test, len_dims, cfg);
+}
+
+static int pkt_stream_uneven_dist_seq(struct test_spec *test,
+				      const struct shared_umem_uneven_dist_ctx *cfg)
+{
+	if (test->nb_sockets < 2 || cfg->total_pkts < 4)
+		return -EINVAL;
+
+	return pkt_stream_replace_seq(test, uneven_dist_dims, cfg);
 }
 
 static void release_even_odd_sequence(struct test_spec *test)
@@ -2288,6 +2362,101 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 	return ret;
 }
 
+static int shared_umem_seq_even_odd(struct test_spec *test, const void *ctx)
+{
+	return pkt_stream_even_odd_sequence(test) ? TEST_FAILURE : TEST_PASS;
+}
+
+static int shared_umem_seq_len(struct test_spec *test, const void *ctx)
+{
+	return pkt_stream_len_seq(test, ctx) ? TEST_FAILURE : TEST_PASS;
+}
+
+static int shared_umem_seq_uneven_dist(struct test_spec *test, const void *ctx)
+{
+	return pkt_stream_uneven_dist_seq(test, ctx) ? TEST_FAILURE : TEST_PASS;
+}
+
+static int run_shared_umem_test(struct test_spec *test, struct bpf_program *xdp_prog_rx,
+				struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
+				struct bpf_map *xskmap_tx, u32 nb_sockets,
+				shared_umem_seq_fn seq_fn, const void *ctx)
+{
+	int ret;
+
+	if (nb_sockets > MAX_SOCKETS) {
+		ksft_print_msg("ERROR: [%s] invalid socket count %u\n", __func__, nb_sockets);
+		return TEST_FAILURE;
+	}
+
+	test->total_steps = 1;
+	test->nb_sockets = nb_sockets;
+
+	test_spec_set_xdp_prog(test, xdp_prog_rx, xdp_prog_tx, xskmap_rx, xskmap_tx);
+
+	ret = seq_fn(test, ctx);
+	if (ret)
+		return ret;
+
+	ret = testapp_validate_traffic(test);
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
+				    skel_tx->maps.xsk, 4, shared_umem_seq_even_odd, NULL);
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
+				    &len_ctx);
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
+				    &uneven_dist_ctx);
+}
+
+int testapp_shared_umem_unaligned(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+
+	test_spec_set_unaligned(test);
+
+	return run_shared_umem_test(test, skel_rx->progs.xsk_xdp_shared_umem,
+				    skel_tx->progs.xsk_xdp_shared_umem, skel_rx->maps.xsk,
+				    skel_tx->maps.xsk, 2, shared_umem_seq_even_odd, NULL);
+}
+
 int testapp_poll_txq_tmout(struct test_spec *test)
 {
 	bool shared_umem = test->ifobj_tx->shared_umem;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 15d6fe2b9568..94c77574f4a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -77,9 +77,13 @@ enum test_mode {
 
 struct ifobject;
 struct test_spec;
+struct pkt_stream;
 typedef int (*validation_func_t)(struct ifobject *ifobj);
 typedef void *(*thread_func_t)(void *arg);
 typedef int (*test_func_t)(struct test_spec *test);
+typedef int (*shared_umem_seq_fn)(struct test_spec *test, const void *ctx);
+typedef void (*pkt_stream_dims_fn)(struct pkt_stream *orig, u32 sock_id, const void *ctx,
+				   u32 *nb_pkts, u32 *pkt_len);
 
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
@@ -182,6 +186,16 @@ struct pkt_stream {
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
@@ -271,6 +285,10 @@ int testapp_xdp_metadata(struct test_spec *test);
 int testapp_xdp_metadata_mb(struct test_spec *test);
 int testapp_xdp_prog_cleanup(struct test_spec *test);
 int testapp_xdp_shared_umem(struct test_spec *test);
+int testapp_shared_umem_4_sockets(struct test_spec *test);
+int testapp_shared_umem_length_based(struct test_spec *test);
+int testapp_shared_umem_uneven_dist(struct test_spec *test);
+int testapp_shared_umem_unaligned(struct test_spec *test);
 
 void *worker_testapp_validate_rx(void *arg);
 void *worker_testapp_validate_tx(void *arg);
@@ -294,6 +312,10 @@ static const struct test_spec tests[] = {
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

