Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4131E842;
	Mon,  8 Jun 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924196; cv=none; b=SNOo1zndmdSGs3iakSGTYIEkJtPoArrhDjZbS9XEQLvPYnD5A2y2DUA0weFhT6iPNe3oe53FS10rktaX/NH9DG076p9yZkPkv4zjFd/xCQQ8N1e7Fcx55mf6FEx8xrF2uM/R13VzIYdpFvZFXaQ++GvZKzyQwYmymdRHVOElFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924196; c=relaxed/simple;
	bh=2D5gk7px10lKJO7Sp7qevKFiDof3/X/w+VnOjwDk2PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM4OJTg26dSbQiUzJsU9ZucvmMHePSsql7v27HnyzTZhErzo4VmaM9R+CU0jF5DGqpr+E67x6at9jZGx6eH1U3L/8fJ/hmpD/XdWALOSAflI/MXObkGAqfD/aMmb8rs26Q8Jc2NcKuj0LPG7U1tbqsKuuPanhSRzacxxJp7+riI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gri18dQ1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gri18dQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780924194; x=1812460194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2D5gk7px10lKJO7Sp7qevKFiDof3/X/w+VnOjwDk2PI=;
  b=Gri18dQ1grW3FDPOfTQ0rh1LEYW1tPC3nEiPiu4eM8Tpj1nKUpUfcTvv
   lHeFXVjCtUeU8ifRoDadv1cKDJRP6JXuTzrYPp3YewN1BJfnSc03isSfl
   xTmJLDPHAEJ6UxqvYaAwq9Wu731m4emuY2aFnVA2RJ2eAu2TFQkkrm+45
   TXIjIRGJhgY+j3NYdu5NZvdXIbY2TpaDjpP8146EgKA1ZXrMd9093lzD1
   5bxbaNKtjQRp+d4G1LzKA5jcekBKMit/pyXxG+EYBCvGuG6vf/YPZ5haA
   7BESrb3h+ymGizNI9nfIVVeibY+GmYyc8EmRuPTUwAb4BZSJ5m3ofITBO
   w==;
X-CSE-ConnectionGUID: 0zkAeH7uRv65uhQBejrhqA==
X-CSE-MsgGUID: piG88Fn4SSOGAgkUvFYeMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92223692"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92223692"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:09:54 -0700
X-CSE-ConnectionGUID: GvDTdFb2RJaZsewDa+G4Ww==
X-CSE-MsgGUID: twq7sCxZToGxDT8CAWQvGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269252927"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:09:51 -0700
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
Subject: [PATCH net-next v3 1/4] selftests/xsk: Introduce helpers for setting UMEM properties
Date: Mon,  8 Jun 2026 18:39:34 +0530
Message-ID: <20260608130938.958793-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608130938.958793-1-tushar.vyavahare@intel.com>
References: <20260608130938.958793-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UMEM properties are set via open-coded field assignments in multiple test
paths, which makes updates noisy and error-prone.

Introduce two helpers to set UMEM properties through a single interface.
This keeps setup logic consistent across tests and makes future refactoring
simpler.

No functional behavior change is intended.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7950c504ed28..3369450da974 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -303,6 +303,18 @@ static void test_spec_reset(struct test_spec *test)
 	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
 }
 
+static void test_spec_set_unaligned(struct test_spec *test)
+{
+	test->ifobj_tx->umem->unaligned_mode = true;
+	test->ifobj_rx->umem->unaligned_mode = true;
+}
+
+static void test_spec_set_frame_size(struct test_spec *test, u32 size)
+{
+	test->ifobj_tx->umem->frame_size = size;
+	test->ifobj_rx->umem->frame_size = size;
+}
+
 static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
 				   struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
 				   struct bpf_map *xskmap_tx)
@@ -2025,8 +2037,7 @@ int testapp_stats_fill_empty(struct test_spec *test)
 
 int testapp_send_receive_unaligned(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	/* Let half of the packets straddle a 4K buffer boundary */
 	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
 		return TEST_FAILURE;
@@ -2037,8 +2048,7 @@ int testapp_send_receive_unaligned(struct test_spec *test)
 int testapp_send_receive_unaligned_mb(struct test_spec *test)
 {
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
@@ -2337,8 +2347,7 @@ int testapp_send_receive(struct test_spec *test)
 
 int testapp_send_receive_2k_frame(struct test_spec *test)
 {
-	test->ifobj_tx->umem->frame_size = 2048;
-	test->ifobj_rx->umem->frame_size = 2048;
+	test_spec_set_frame_size(test, 2048);
 	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
@@ -2363,15 +2372,13 @@ int testapp_aligned_inv_desc(struct test_spec *test)
 
 int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
 {
-	test->ifobj_tx->umem->frame_size = 2048;
-	test->ifobj_rx->umem->frame_size = 2048;
+	test_spec_set_frame_size(test, 2048);
 	return testapp_invalid_desc(test);
 }
 
 int testapp_unaligned_inv_desc(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	return testapp_invalid_desc(test);
 }
 
@@ -2380,10 +2387,8 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 	u64 page_size, umem_size;
 
 	/* Odd frame size so the UMEM doesn't end near a page boundary. */
-	test->ifobj_tx->umem->frame_size = 4001;
-	test->ifobj_rx->umem->frame_size = 4001;
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_frame_size(test, 4001);
+	test_spec_set_unaligned(test);
 	/* This test exists to test descriptors that staddle the end of
 	 * the UMEM but not a page.
 	 */
@@ -2402,8 +2407,7 @@ int testapp_aligned_inv_desc_mb(struct test_spec *test)
 
 int testapp_unaligned_inv_desc_mb(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	return testapp_invalid_desc_mb(test);
 }
 
-- 
2.43.0

