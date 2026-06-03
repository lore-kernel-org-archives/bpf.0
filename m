Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356239183B;
	Wed,  3 Jun 2026 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469291; cv=none; b=DjKYiXZNGu18+0YacgLmV+PGOJdfpNkl28THeWZwMN6lmII7ibGaTYzXEk4aeDioQojhMkPfG8LhzYVxLRQmSGwSu72JZc+a/AUyO4KSo7SfX7GulK3HrabmD3J1B6GCXK+qin27Ymg2QfKht7uOMAUcAE7U3mgBQRN/5t8eDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469291; c=relaxed/simple;
	bh=5paCheaSIkyb1fwEOeKz8a30e/gh8c4VLQGXNz/zPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDaiCPeml1SpjVNsf1c2wuNEo7MoYFctejo9/GP1Bd5UW4H1qhovGi1LpF7xnAFgo604zfYmzr4Afq77Rwu1pPVx5vnsD2EUjEWmvXPSFfcO8kWO9ARwoLowLPlxCB+3hi34fhz9SF1DJpNS24vskvE8rrnHPf5vGhogORd2LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYndZ5hB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYndZ5hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780469290; x=1812005290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5paCheaSIkyb1fwEOeKz8a30e/gh8c4VLQGXNz/zPP0=;
  b=lYndZ5hBocehYoxQjCkP01bGLX6dG8bZpTrF4QeRY5LbCAXd15CDKAU2
   nmG4cCaxBktEqIq+jA9ML71ITGAydhauXQCjjgNf1B2p4U4rZk7SlBc2g
   LxZymfJpMDCuk1zi18ZoVEOW04v4eXQ3UpfmfuI9jMt54HtYQAH5pnhqj
   7JI1M2ry36YuaoB50sBvBgDZCwMoKNUgotFk7CaOtHVzFl+VGaOkZnUpW
   dOee8HNMuyIJ0nyL1pYlazwTbWlHEnKPEBFxA+fDbkLd5R0Wy09RxYo2b
   XoIKVWXCxuvusz7ykPWj6J9ZNv8ncYUw3NeMFjMcvKw0LNepRS7w01pQR
   A==;
X-CSE-ConnectionGUID: 2NeFLrjlTdOdGGzyUjRgcg==
X-CSE-MsgGUID: WpFo4g5lRZeYf4AGM3a1pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81449149"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81449149"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:48:10 -0700
X-CSE-ConnectionGUID: l4C7MOWzTqm35bI0ioW5/A==
X-CSE-MsgGUID: fbnSrgLZR0CCW9far1B5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237778944"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:48:06 -0700
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
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v2 4/4] selftests/xsk: Introduce mmap_size in umem struct
Date: Wed,  3 Jun 2026 11:33:27 +0530
Message-ID: <20260603060327.298389-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603060327.298389-1-tushar.vyavahare@intel.com>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UMEM teardown currently recomputes the munmap() length from frame
geometry, shared-UMEM adjustment, and hugepage rounding. This duplicates
setup-time logic in cleanup and relies on re-deriving the mapping size
instead of using the size originally established for the mapping.

Store the final mapping length in xsk_umem_info as mmap_size when the
UMEM mapping is created, and use that value during teardown.

Also join the RX worker thread before cleanup in the single-thread
path. This establishes synchronization before reading umem->mmap_size
in teardown and avoids a potential visibility race.

This removes duplicated size arithmetic in cleanup and makes munmap()
use the canonical mapping size recorded at setup time.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 20 +++++++++----------
 .../selftests/bpf/prog_tests/test_xsk.h       |  1 +
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index f1730466ffd9..e94c38a1faf4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1581,7 +1581,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	struct xsk_umem_info *umem = ifobject->xsk->umem;
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	int mmap_flags;
-	u64 umem_sz;
+	u64 umem_sz, mmap_sz;
 	void *bufs;
 	int ret;
 	u32 i;
@@ -1595,10 +1595,15 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ifobject->shared_umem)
 		umem_sz *= 2;
 
-	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
+	mmap_sz = umem->unaligned_mode ?
+		ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE : umem_sz;
+
+	bufs = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
 	if (bufs == MAP_FAILED)
 		return -errno;
 
+	umem->mmap_size = mmap_sz;
+
 	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
 	if (ret)
 		return ret;
@@ -1706,15 +1711,9 @@ void *worker_testapp_validate_rx(void *arg)
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 {
 	struct xsk_umem_info *umem = ifobj->xsk->umem;
-	u64 umem_sz = umem_size(umem);
-
-	if (ifobj->shared_umem)
-		umem_sz *= 2;
-
-	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
 
 	xsk_umem__delete(umem->umem);
-	munmap(umem->buffer, umem_sz);
+	munmap(umem->buffer, umem->mmap_size);
 }
 
 static void handler(int signum)
@@ -1857,8 +1856,7 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 
 	if (!ifobj2)
 		pthread_kill(t0, SIGUSR1);
-	else
-		pthread_join(t0, NULL);
+	pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
 		clean_sockets(test, ifobj1);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 99003995d7c3..4313d0d87235 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -103,6 +103,7 @@ struct xsk_umem_info {
 	struct xsk_ring_cons cq;
 	struct xsk_umem *umem;
 	u64 next_buffer;
+	u64 mmap_size;
 	u32 num_frames;
 	u32 frame_headroom;
 	void *buffer;
-- 
2.43.0

