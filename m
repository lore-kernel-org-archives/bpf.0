Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13833EEAF4;
	Fri,  7 Aug 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110267; cv=none; b=JUn7Ta0rWVU0p5sL0vVi6k/jT+Nez2NZt2Wd6QJWuImGR/lc8Vxbrre1/VH5UD+dEqV4HRoA+ix4dJddg24yN3ZeimIHlAj4MKBMLSct2yX95SiQkuJHn0h0fjp5y6aa01KkKmEyv8yCwGtZBOQXWTQXmjqtM5PH4M9jayAdUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110267; c=relaxed/simple;
	bh=FEpNjwRhT+2lbzVYI1cQ+8DLzEX7dWZD8AcLr2LM+QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XluJZ/76jMQBoAQqAuhQGB96ZQ51fZm3ryWoun1TuEUhUCm9O75Y0SxrbSeO+IfQGsXnVdXplE+Up/szZFv5lQ6ZSGIuUolrg9JKw6JWPmnRDComAAzLgaEBQxLM6ud1X8FhLOdEZXxg3EOsVPzIB93GNsq/Iafh2evjs3nL5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dINen04J; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dINen04J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786110262; x=1817646262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FEpNjwRhT+2lbzVYI1cQ+8DLzEX7dWZD8AcLr2LM+QQ=;
  b=dINen04JTMKsDUwPUeIEyXBSgMvNQbToa0fly6bLLA4LyJzOcSQcoTY9
   1o6STPZrLd7IWOinr8EsEHL22RrDXr7CWofTQWUMp2JbIa2xhyrycEa/q
   IgZSnwetIQEYrzSnPuDBumfq735I27desiPiVHM71NcBGjzSr8Tz+cw6H
   XCaSeO6DSO/uvbEEPV99otsajZTk4qhLZmK/uRjyCxVPb65OjTEK83RI6
   /+oaLGg91gX9cEUHvkNImj4d/WkpkqJtAFtq4qEEGqfUVzBDr2I6VVjTi
   8xRIeXTZsdBG1WaGtjR1JLnD7g79GwtUjTxgvqUyMLpx5eBWymsi+7qrM
   w==;
X-CSE-ConnectionGUID: a0oSL+hhScWjlytbaQuSeQ==
X-CSE-MsgGUID: 2hPHZuEGRgWQL7aaTzZwJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98079955"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98079955"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:17 -0700
X-CSE-ConnectionGUID: w4AfBVgUTsORuVnI6Mmyaw==
X-CSE-MsgGUID: tFrY7yIGTQ+bugWWL4SDqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287080077"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:13 -0700
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
Subject: [PATCH net-next 4/5] selftests/xsk: add shared-UMEM callback framework and initial test cases
Date: Fri,  7 Aug 2026 13:42:08 +0000
Message-ID: <20260807134209.3794735-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the runner callback infrastructure and the first four shared-UMEM
test cases together so every SHA in the series builds clean.

Framework:
- shared_default in __test_spec_init() derives the shared_umem flag from
  ifindex equality, matching xskxceiver startup behavior so test resets
  stay aligned with the harness invariant.
- pkt_stream_len_seq() generates per-socket streams with alternating
  short/long packet sizes.
- pkt_stream_weighted_uneven_dist_sequence() generates unequal-volume
  streams across two sockets.
- run_shared_umem_test() is a common runner: sets up the XDP program,
  validates streams are ready, runs the sequence callback, executes
  traffic, and calls an optional post-run callback.
- Callback types shared_umem_seq_fn and shared_umem_post_fn, and context
  structs shared_umem_len_ctx and shared_umem_uneven_dist_ctx are defined
  in test_xsk.h for shared use.

Tests:
- SHARED_UMEM_4_SOCKETS: runs four sockets simultaneously with an
  even/odd packet stream split across sockets.
- SHARED_UMEM_LENGTH_BASED: routes short packets to socket 0 and longer
  packets to socket 1 using the length-based XDP program.
- SHARED_UMEM_UNEVEN_DIST: generates a 1:3 volume split across two
  sockets and validates that socket 1 receives more packets.
- SHARED_UMEM_UNALIGNED: runs the even/odd split in unaligned chunk mode.

The unaligned test snapshots and restores prior alignment flags with
NULL-safe UMEM guards so it does not depend on test-order side effects
or implicit initialization assumptions in the callback.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 250 ++++++++++++++++++
 .../selftests/bpf/prog_tests/test_xsk.h       |  21 ++
 2 files changed, 271 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index de0d8f51f846..1665339844b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -219,6 +219,12 @@ int hw_ring_size_reset(struct ifobject *ifobj)
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
@@ -230,6 +236,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		ifobj->use_fill_ring = true;
 		ifobj->release_rx = true;
 		ifobj->validation_func = NULL;
+		ifobj->shared_umem = shared_default;
 		ifobj->use_metadata = false;
 
 		if (i == 0) {
@@ -612,6 +619,87 @@ static int pkt_stream_even_odd_sequence(struct test_spec *test)
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
+static int pkt_stream_weighted_uneven_dist_sequence(struct test_spec *test, u32 total_pkts,
+						    u32 pkt_len)
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
@@ -2290,6 +2378,168 @@ int testapp_xdp_shared_umem(struct test_spec *test)
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
+	return pkt_stream_weighted_uneven_dist_sequence(test, cfg->total_pkts,
+						      cfg->pkt_len) ? TEST_FAILURE : TEST_PASS;
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
index 56bc134505b3..ef9c422d7763 100644
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

