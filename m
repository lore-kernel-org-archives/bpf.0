Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC74772BB;
	Fri,  7 Aug 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110255; cv=none; b=ijN+qn3zMbA2GX6eWdJtHQgJ8tuDeIlev4Pt3G7/1pqjh3WCv+72jRzijvhx7xbCOFlJEDIXYjAp611rf6DdDTXtYZtP09hIKUaF1OdUHGkNOvXu7H13Lmd2UjkpSYZu2X7QGp2+B857rphREeNNE9+4pjAtzmTwZrGFNldm3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110255; c=relaxed/simple;
	bh=/NFO9HiwDcxCPvIsrY3LJmF4yPpcD6DHpbgkZLdq36s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN3UndfMPZQSz0RPfSn3RI0cIWlYqOJzcbvE/x1F3rPIbIEfi8gqjg0hSkbD9A2cALoYYuVbgpcj50eSSF3xtK3VV6iOPdSP1iUGk3iP/sbowuNKeXRW+D77mhvCUVkGUqqyz16DnGxbjQS6Qv+kIuA8UsaXhltDIx9/tDz78so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZTFQ1Ts; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZTFQ1Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786110250; x=1817646250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/NFO9HiwDcxCPvIsrY3LJmF4yPpcD6DHpbgkZLdq36s=;
  b=gZTFQ1Tsjy26Jm8PI3KwgW2ne5ylLdP6/3HP46J/udI/+DNISWTRf/1/
   hQt513u0nJEQOrYPECF9zzaOiVD/R7Abi9RROGzeW4pYMohK2ALlsQ1PI
   +4ynxa/ZV34nyvgXiNGvikur/sSpSlE23KJYNxvNGE8lpBsBMrU6AufOt
   X2y/DXrHiLm5gCCNYs0OOLibMUp6YDUBNVQn9MmXGqP17y1I3tYIoo6ps
   7ioBtnzToxxg8oVPGkyeQ9Pif5IKFh0bL7G26yo+XETq3RlKrvFyxXZmS
   vw4UNvrlkhbo1bKWzWSI0aKI5XWsP7GMX+Y8GFXUJzB6n8ULgdLMAQRRW
   w==;
X-CSE-ConnectionGUID: czrsC7wxRca6OvGBtfb4vw==
X-CSE-MsgGUID: 7jml/ZaXSmS/l+BZ9Ir4MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98079933"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98079933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:05 -0700
X-CSE-ConnectionGUID: 46hPmhX6S4WWq8/JXZWpAg==
X-CSE-MsgGUID: GbjiWueuR96vaS9lWXfJrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287080045"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:01 -0700
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
Subject: [PATCH net-next 1/5] selftests/xsk: add UMEM users refcount and centralize socket teardown
Date: Fri,  7 Aug 2026 13:42:05 +0000
Message-ID: <20260807134209.3794735-2-tushar.vyavahare@intel.com>
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

Shared-UMEM lifetime can be torn down from multiple setup and cleanup
paths. Mixing manual UMEM free/unmap in one path with helper-based
teardown in others makes ownership easier to violate and can leak or
double-release UMEM during error handling.

Track UMEM ownership with a refcount_t users field. Initialize it to 1
in xsk_configure_umem() and increment it for each additional shared
socket. Introduce xsk_delete_socket() as the single teardown helper: it
deletes the socket handle, clears state to prevent double-decrement, and
releases the UMEM when the last reference drops.

Replace testapp_clean_xsk_umem(), clean_sockets(), and clean_umem() with
xsk_delete_socket_batch() and xsk_delete_all_ifobj_sockets() wrappers at
all call sites. Convert ifobj_zc_avail() in xskxceiver.c to use stack
allocation and xsk_delete_socket() for uniform cleanup.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 124 ++++++++++++------
 .../selftests/bpf/prog_tests/test_xsk.h       |   3 +
 tools/testing/selftests/bpf/xskxceiver.c      |  35 ++---
 3 files changed, 103 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 477aedbb01ba..4ccdb0825130 100644
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
@@ -170,7 +172,21 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	ret = xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	if (ret) {
+		if (shared)
+			/* Shared socket failed before acquiring a UMEM reference. */
+			xsk->umem = NULL;
+
+		/* Keep failed socket state inert for later cleanup paths. */
+		xsk->xsk = NULL;
+		return ret;
+	}
+
+	if (shared)
+		refcount_inc(&umem->users);
+
+	return ret;
 }
 
 static int set_ring_size(struct ifobject *ifobj)
@@ -1702,12 +1718,71 @@ void *worker_testapp_validate_rx(void *arg)
 	pthread_exit(NULL);
 }
 
-static void testapp_clean_xsk_umem(struct ifobject *ifobj)
+void xsk_delete_socket(struct xsk_socket_info *xsk)
 {
-	struct xsk_umem_info *umem = ifobj->xsk->umem;
+	struct xsk_umem_info *umem;
+
+	/*
+	 * Callers must serialize teardown for a given xsk/umem pair.
+	 * This helper does refcount-based lifetime management only.
+	 */
+	if (!xsk)
+		return;
 
-	xsk_umem__delete(umem->umem);
-	munmap(umem->buffer, umem->mmap_size);
+	umem = xsk->umem;
+	if (!umem)
+		return;
+
+	/* Delete the socket handle when available, then drop UMEM reference. */
+	if (xsk->xsk)
+		xsk_socket__delete(xsk->xsk);
+	xsk->xsk = NULL;
+
+	/* Mark this socket as cleaned up to prevent double-decrement */
+	xsk->umem = NULL;
+
+	/*
+	 * Teardown may walk the full xsk array, including slots that never completed setup but
+	 * still carry a preinitialized umem pointer. After a partial-setup rollback, the last UMEM
+	 * ref may already be dropped.
+	 */
+	if (!refcount_read(&umem->users))
+		return;
+
+	/* Always decrement refcount for this socket's UMEM reference */
+	if (refcount_dec_and_test(&umem->users)) {
+		if (umem->umem) {
+			int err = xsk_umem__delete(umem->umem);
+
+			if (err)
+				ksft_print_msg("xsk_umem__delete failed: %d (umem still busy?)\n",
+					       err);
+		}
+		if (umem->buffer && umem->mmap_size)
+			munmap(umem->buffer, umem->mmap_size);
+		umem->umem = NULL;
+		umem->buffer = NULL;
+		umem->mmap_size = 0;
+	}
+}
+
+static void xsk_delete_socket_batch(struct ifobject *ifobject, u32 count)
+{
+	u32 i;
+
+	if (!ifobject)
+		return;
+
+	for (i = count; i > 0; i--)
+		xsk_delete_socket(&ifobject->xsk_arr[i - 1]);
+}
+
+static void xsk_delete_all_ifobj_sockets(struct test_spec *test, struct ifobject *ifobj)
+{
+	if (!ifobj)
+		return;
+
+	xsk_delete_socket_batch(ifobj, test->nb_sockets);
 }
 
 static bool xdp_prog_changed_rx(struct test_spec *test)
@@ -1769,27 +1844,6 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
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
@@ -1841,8 +1895,7 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		if (pthread_barrier_destroy(&barr)) {
 			test->use_barrier = false;
 			pthread_join(t0, NULL);
-			clean_sockets(test, ifobj1);
-			clean_umem(test, ifobj1, NULL);
+			xsk_delete_all_ifobj_sockets(test, ifobj1);
 			return TEST_FAILURE;
 		}
 	}
@@ -1856,9 +1909,8 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
-		clean_sockets(test, ifobj1);
-		clean_sockets(test, ifobj2);
-		clean_umem(test, ifobj1, ifobj2);
+		xsk_delete_all_ifobj_sockets(test, ifobj2);
+		xsk_delete_all_ifobj_sockets(test, ifobj1);
 	}
 
 	if (test->fail)
@@ -1967,9 +2019,8 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 		return TEST_FAILURE;
 
 	if (swap_xsk_resources(test)) {
-		clean_sockets(test, test->ifobj_rx);
-		clean_sockets(test, test->ifobj_tx);
-		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
+		xsk_delete_all_ifobj_sockets(test, test->ifobj_tx);
+		xsk_delete_all_ifobj_sockets(test, test->ifobj_rx);
 		return TEST_FAILURE;
 	}
 
@@ -2498,9 +2549,8 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
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
index 03753ddc5dcd..56bc134505b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -4,6 +4,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/if_xdp.h>
+#include <linux/refcount.h>
 
 #include "../kselftest.h"
 #include "xsk.h"
@@ -104,6 +105,7 @@ struct xsk_umem_info {
 	struct xsk_umem *umem;
 	u64 next_buffer;
 	u64 mmap_size;
+	refcount_t users;
 	u32 num_frames;
 	u32 frame_headroom;
 	void *buffer;
@@ -159,6 +161,7 @@ int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
 int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void *buffer, u64 size);
 int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
 			 struct ifobject *ifobject, bool shared);
+void xsk_delete_socket(struct xsk_socket_info *xsk);
 
 
 struct pkt {
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7dad8556a722..ed7716b63756 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -117,12 +117,13 @@ static void __exit_with_error(int error, const char *file, const char *func, int
 
 #define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
 
-static bool ifobj_zc_avail(struct ifobject *ifobject)
+static bool ifobj_zc_avail(struct ifobject *ifobj)
 {
 	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
-	struct xsk_socket_info *xsk;
-	struct xsk_umem_info *umem;
+	struct xsk_socket_info xsk = {};
+	struct xsk_umem_info umem_info = {};
+	struct xsk_umem_info *umem = &umem_info;
 	bool zc_avail = false;
 	void *bufs;
 	int ret;
@@ -131,32 +132,22 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
 	if (bufs == MAP_FAILED)
 		exit_with_error(errno);
 
-	umem = calloc(1, sizeof(struct xsk_umem_info));
-	if (!umem) {
-		munmap(bufs, umem_sz);
-		exit_with_error(ENOMEM);
-	}
+	umem->mmap_size = umem_sz;
 	umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
-	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
+	ret = xsk_configure_umem(ifobj, umem, bufs, umem_sz);
 	if (ret)
 		exit_with_error(-ret);
 
-	xsk = calloc(1, sizeof(struct xsk_socket_info));
-	if (!xsk)
-		goto out;
-	ifobject->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
-	ifobject->rx_on = true;
-	xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
-	ret = xsk_configure_socket(xsk, umem, ifobject, false);
+	ifobj->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
+	ifobj->rx_on = true;
+	xsk.rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+	ret = xsk_configure_socket(&xsk, umem, ifobj, false);
 	if (!ret)
 		zc_avail = true;
 
-	xsk_socket__delete(xsk->xsk);
-	free(xsk);
-out:
-	munmap(umem->buffer, umem_sz);
-	xsk_umem__delete(umem->umem);
-	free(umem);
+	/* Use the same refcount-based teardown path for both success and failure. */
+	xsk_delete_socket(&xsk);
+
 	return zc_avail;
 }
 
-- 
2.43.0

