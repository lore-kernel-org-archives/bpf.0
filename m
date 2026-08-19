Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE02931C7;
	Wed, 19 Aug 2026 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107644; cv=none; b=gooYG0OOL199chXr9zsPO3jChCDuuPcd4PO3An0XR+QKkWOUE4xb6Bv3Xx5xLKZJVsXDrpQxIidKi2h8mS/YkVgb+T8Iifib3bDm11sAPoIY9pLqWrilCXEwoOTQVk7aVFGYZKOJ8FJxgDl2pKgR2nkYNR/K8F9G651GYNxqFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107644; c=relaxed/simple;
	bh=K7Dj0z+OZi2Nq6IOPk7c1V8WsRpuMZ4A1LWvL0mVljA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9BJb5jph7mdZQphV8TT9kasCds8WKZKaL+iwYUYJ44Ud6yUyc+OQkr1n58X5IRzcgM2TYEmVB7Er4B/fFpuowtROvhEyIzhmG3XKmzPuhKIPhGhSjZhWsE0iC9s7BKKoCTqLf2c9JOsfPUQ6xssfBbT/HqncCoGwKzzROz4Kmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+JcqQ+r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+JcqQ+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787107642; x=1818643642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7Dj0z+OZi2Nq6IOPk7c1V8WsRpuMZ4A1LWvL0mVljA=;
  b=X+JcqQ+rtKh7f1GO9cxlXs6quW4VldtupMTRjJLO71EZ9k5rMFyt6w48
   E62+yd6F67Sz8vOOksU3MyvoFeoE7JDH8tzHnEkC0k3MmsWFDkv0I9xns
   y9RtaaulhNvxlHkxtDAKPvFlbyuNJ6bUnWQSjdSxGdT1ETOTUYxXxNFnN
   ragzN/jmSwRtPBU4J985+aHlRZEnw/gl6ycusD5ld+rQOiX9qnn29Z2lx
   FnwtMDZ150Z8lMgpGSUDzYEcO/oiVeIAlxz+q6xnJu8tpJFnGInL0RM2F
   PuYsDMkHcE370sqiItjYtlQ49xQyZ96HfrjdDbNNRbtfDLM8v28Zg8Jgm
   g==;
X-CSE-ConnectionGUID: Y0kughuFSK6fkPybMplHbw==
X-CSE-MsgGUID: ECXtxlsWRMu69NzhUzEdWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87465276"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87465276"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:21 -0700
X-CSE-ConnectionGUID: zb72JwMsRsOoMdcMGPQn5A==
X-CSE-MsgGUID: dQma+GoSR0u+gycZ6yOSYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264974406"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:17 -0700
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
Subject: [PATCH net-next v3 1/4] selftests/xsk: add UMEM users refcount and centralize socket teardown
Date: Wed, 19 Aug 2026 02:44:40 +0000
Message-ID: <20260819024443.781764-2-tushar.vyavahare@intel.com>
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

UMEM ownership is currently implicit. xsk_configure_umem() maps the
buffer, but freeing it is spread across testapp_clean_xsk_umem(),
clean_sockets() and clean_umem(), each called from a different error path.

thread_common_ops() returns without releasing the UMEM when
xsk_configure() fails after the UMEM was already mapped, leaking the
mmap()ed buffer.

The pthread_barrier_destroy() failure path in __testapp_validate_traffic()
unmaps the UMEM owned by ifobj1 while sockets belonging to ifobj2 are left
alive. With shared_umem, those sockets reference the buffer that was just
unmapped.

Make ownership explicit instead. Add a refcount_t users field to struct
xsk_umem_info and release exactly one reference per socket on teardown, so
that the last socket to go away frees the UMEM regardless of which path
tears it down. Keep shared sockets pointing to the same xsk_umem_info
instead of copying ownership state, so all users update the same reference
count.

Propagate UMEM deletion errors from xsk_delete_socket() so callers with
stack-allocated state can handle a deferred cleanup before that state goes
out of scope. The in-test teardown paths cannot retry, because
__test_spec_init() clears the UMEM state at the start of the next test and
the mapping is then unrecoverable, so xsk_delete_all_ifobj_sockets()
records the failure in test->fail instead of dropping it. A UMEM that
survives teardown now fails the test rather than leaking silently.

clean_umem() skipped ifobj2 whenever it shared the UMEM owned by ifobj1,
which was only there to avoid unmapping the same buffer twice. The
reference count makes that distinction unnecessary, so the helper and its
special case are removed along with the other ad-hoc cleanup paths.

Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 134 +++++++++++++-----
 .../selftests/bpf/prog_tests/test_xsk.h       |   5 +-
 tools/testing/selftests/bpf/xskxceiver.c      |  40 +++---
 3 files changed, 117 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 4549358cc8c2..bba5e8d4222d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -101,6 +101,7 @@ int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void
 		return ret;
 
 	umem->buffer = buffer;
+	refcount_set(&umem->users, 1);
 	if (ifobj->shared_umem && ifobj->rx_on) {
 		umem->base_addr = umem_size(umem);
 		umem->next_buffer = umem_size(umem);
@@ -154,6 +155,7 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 	struct xsk_socket_config cfg = {};
 	struct xsk_ring_cons *rxr;
 	struct xsk_ring_prod *txr;
+	int ret;
 
 	xsk->umem = umem;
 	cfg.rx_size = xsk->rxqsize;
@@ -170,7 +172,26 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	ret = xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	if (ret) {
+		/*
+		 * For shared sockets refcount_inc hasn't run yet, so clear umem to mark this slot
+		 * as having no reference. For the owner (non-shared) the reference was taken by
+		 * xsk_configure_umem; leave umem set so the caller's rollback path can release it
+		 * via umem_ref.
+		 */
+		if (shared)
+			xsk->umem = NULL;
+		xsk->xsk = NULL;
+		return ret;
+	}
+
+	if (shared) {
+		refcount_inc(&umem->users);
+		xsk->umem_ref = true;
+	}
+
+	return ret;
 }
 
 static int set_ring_size(struct ifobject *ifobj)
@@ -1508,8 +1529,15 @@ static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobjec
 	}
 
 	umem_rx = test->ifobj_rx->xsk_arr[0].umem;
+	/* Non-owning view used only for TX buffer arithmetic; the sockets below bind to
+	 * the RX-owned UMEM, so the handle, cq and refcount stay in one place.
+	 */
 	umem_tx = ifobject->xsk_arr[0].umem_real;
-	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));
+	umem_tx->num_frames = umem_rx->num_frames;
+	umem_tx->frame_headroom = umem_rx->frame_headroom;
+	umem_tx->buffer = umem_rx->buffer;
+	umem_tx->frame_size = umem_rx->frame_size;
+	umem_tx->unaligned_mode = umem_rx->unaligned_mode;
 	umem_tx->base_addr = 0;
 	umem_tx->next_buffer = 0;
 
@@ -1599,6 +1627,8 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
 	if (ret)
 		return ret;
+	/* Mark before xsk_configure so rollback can release the UMEM if it fails. */
+	ifobject->xsk->umem_ref = true;
 
 	ret = xsk_configure(test, ifobject, umem, false);
 	if (ret)
@@ -1701,12 +1731,65 @@ void *worker_testapp_validate_rx(void *arg)
 	pthread_exit(NULL);
 }
 
-static void testapp_clean_xsk_umem(struct ifobject *ifobj)
+int xsk_delete_socket(struct xsk_socket_info *xsk)
 {
-	struct xsk_umem_info *umem = ifobj->xsk->umem;
+	struct xsk_umem_info *umem = xsk->umem;
 
-	xsk_umem__delete(umem->umem);
-	munmap(umem->buffer, umem->mmap_size);
+	if (!umem)
+		return 0;
+
+	if (xsk->xsk)
+		xsk_socket__delete(xsk->xsk);
+	xsk->xsk = NULL;
+
+	/* Skip slots that never acquired a UMEM reference (pre-initialized but unconfigured). */
+	if (!xsk->umem_ref) {
+		xsk->umem = NULL;
+		return 0;
+	}
+
+	if (refcount_dec_and_test(&umem->users)) {
+		if (umem->umem) {
+			int err = xsk_umem__delete(umem->umem);
+
+			if (err) {
+				ksft_print_msg("xsk_umem__delete failed: %d (umem still busy?)\n",
+					       err);
+				/* Keep ownership explicit so a later cleanup pass can retry
+				 * delete.
+				 */
+				refcount_set(&umem->users, 1);
+				xsk->umem_ref = true;
+				xsk->umem = umem;
+				return err;
+			}
+			umem->umem = NULL;
+		}
+		if (umem->buffer && umem->mmap_size) {
+			munmap(umem->buffer, umem->mmap_size);
+			umem->buffer = NULL;
+			umem->mmap_size = 0;
+		}
+	}
+
+	xsk->umem_ref = false;
+	xsk->umem = NULL;
+	return 0;
+}
+
+static void xsk_delete_all_ifobj_sockets(struct test_spec *test, struct ifobject *ifobj)
+{
+	u32 i;
+
+	if (!ifobj)
+		return;
+
+	/* A UMEM that could not be deleted stays mapped until the process exits,
+	 * so record it rather than letting teardown drop the error.
+	 */
+	for (i = test->nb_sockets; i > 0; i--)
+		if (xsk_delete_socket(&ifobj->xsk_arr[i - 1]))
+			test->fail = true;
 }
 
 static bool xdp_prog_changed_rx(struct test_spec *test)
@@ -1768,27 +1851,6 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 	return err;
 }
 
-static void clean_sockets(struct test_spec *test, struct ifobject *ifobj)
-{
-	u32 i;
-
-	if (!ifobj || !test)
-		return;
-
-	for (i = 0; i < test->nb_sockets; i++)
-		xsk_socket__delete(ifobj->xsk_arr[i].xsk);
-}
-
-static void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct ifobject *ifobj2)
-{
-	if (!ifobj1)
-		return;
-
-	testapp_clean_xsk_umem(ifobj1);
-	if (ifobj2 && !ifobj2->shared_umem)
-		testapp_clean_xsk_umem(ifobj2);
-}
-
 static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *ifobj1,
 				      struct ifobject *ifobj2)
 {
@@ -1840,8 +1902,7 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		if (pthread_barrier_destroy(&barr)) {
 			test->use_barrier = false;
 			pthread_join(t0, NULL);
-			clean_sockets(test, ifobj1);
-			clean_umem(test, ifobj1, NULL);
+			xsk_delete_all_ifobj_sockets(test, ifobj1);
 			return TEST_FAILURE;
 		}
 	}
@@ -1855,9 +1916,8 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
-		clean_sockets(test, ifobj1);
-		clean_sockets(test, ifobj2);
-		clean_umem(test, ifobj1, ifobj2);
+		xsk_delete_all_ifobj_sockets(test, ifobj2);
+		xsk_delete_all_ifobj_sockets(test, ifobj1);
 	}
 
 	if (test->fail)
@@ -1966,9 +2026,8 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 		return TEST_FAILURE;
 
 	if (swap_xsk_resources(test)) {
-		clean_sockets(test, test->ifobj_rx);
-		clean_sockets(test, test->ifobj_tx);
-		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
+		xsk_delete_all_ifobj_sockets(test, test->ifobj_tx);
+		xsk_delete_all_ifobj_sockets(test, test->ifobj_rx);
 		return TEST_FAILURE;
 	}
 
@@ -2506,9 +2565,8 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
 	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
 	if (pkt_stream_replace(test, max_descs, MIN_PKT_SIZE)) {
-		clean_sockets(test, test->ifobj_tx);
-		clean_sockets(test, test->ifobj_rx);
-		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
+		xsk_delete_all_ifobj_sockets(test, test->ifobj_tx);
+		xsk_delete_all_ifobj_sockets(test, test->ifobj_rx);
 		return TEST_FAILURE;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 03753ddc5dcd..15d6fe2b9568 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -4,6 +4,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/if_xdp.h>
+#include <linux/refcount.h>
 
 #include "../kselftest.h"
 #include "xsk.h"
@@ -93,6 +94,7 @@ struct xsk_socket_info {
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
 	bool check_consumer;
+	bool umem_ref; /* true if this slot holds a counted UMEM reference */
 };
 
 int kick_rx(struct xsk_socket_info *xsk);
@@ -104,6 +106,7 @@ struct xsk_umem_info {
 	struct xsk_umem *umem;
 	u64 next_buffer;
 	u64 mmap_size;
+	refcount_t users;
 	u32 num_frames;
 	u32 frame_headroom;
 	void *buffer;
@@ -159,7 +162,7 @@ int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
 int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void *buffer, u64 size);
 int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
 			 struct ifobject *ifobject, bool shared);
-
+int xsk_delete_socket(struct xsk_socket_info *xsk);
 
 struct pkt {
 	int offset;
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7dad8556a722..5d8a29e7224e 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -117,12 +117,12 @@ static void __exit_with_error(int error, const char *file, const char *func, int
 
 #define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
 
-static bool ifobj_zc_avail(struct ifobject *ifobject)
+static bool ifobj_zc_avail(struct ifobject *ifobj)
 {
 	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
-	struct xsk_socket_info *xsk;
-	struct xsk_umem_info *umem;
+	struct xsk_socket_info xsk = {};
+	struct xsk_umem_info umem = {};
 	bool zc_avail = false;
 	void *bufs;
 	int ret;
@@ -131,32 +131,26 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
 	if (bufs == MAP_FAILED)
 		exit_with_error(errno);
 
-	umem = calloc(1, sizeof(struct xsk_umem_info));
-	if (!umem) {
-		munmap(bufs, umem_sz);
-		exit_with_error(ENOMEM);
-	}
-	umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
-	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
+	umem.mmap_size = umem_sz;
+	umem.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
+	ret = xsk_configure_umem(ifobj, &umem, bufs, umem_sz);
 	if (ret)
 		exit_with_error(-ret);
 
-	xsk = calloc(1, sizeof(struct xsk_socket_info));
-	if (!xsk)
-		goto out;
-	ifobject->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
-	ifobject->rx_on = true;
-	xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
-	ret = xsk_configure_socket(xsk, umem, ifobject, false);
+	xsk.umem_ref = true;
+
+	ifobj->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
+	ifobj->rx_on = true;
+	xsk.rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+	ret = xsk_configure_socket(&xsk, &umem, ifobj, false);
 	if (!ret)
 		zc_avail = true;
 
-	xsk_socket__delete(xsk->xsk);
-	free(xsk);
-out:
-	munmap(umem->buffer, umem_sz);
-	xsk_umem__delete(umem->umem);
-	free(umem);
+	/* Use the same refcount-based teardown path for both success and failure. */
+	ret = xsk_delete_socket(&xsk);
+	if (ret)
+		exit_with_error(-ret);
+
 	return zc_avail;
 }
 
-- 
2.43.0

