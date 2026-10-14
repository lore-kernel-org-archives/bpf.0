Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7D52FE34;
	Wed, 14 Oct 2026 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003559; cv=none; b=DeJNioDPoeW3UYOQEB3FAbODnQgk9L/i/bObMI4D+9JIs14pM+soO8GzlPYu6VORy0cCi8ttliy4Pxx9xOOa4XC4fWfNAQcntjmgo13N3WmlXyvLspOZ/L7U60Dn46gXO8l9/n0cj3LdeuyYYhZvKS49AYzqjNpIwG/ih4x+On4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003559; c=relaxed/simple;
	bh=si+8KLkVZtnw3CRnjDI8f1ba+3sI85ASrPU7gMLJCcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZqGEPFpZOBgza6dhP/3dvNOsg7J95XVWdiGOltW8Q2qDZtUyfMkqFM9pT1GbR6ZHKJNdLpnRBsnIhhGODnWcYoqMvA4+p453oslXgpJ5sWcJbAY8gHlCHsaxzfPhLv9GW8T0ZnbX2lYXLqevtptSdW6Ky9QtCCUcWmt6nmYr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShP8jqUd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShP8jqUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003558; x=1823539558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=si+8KLkVZtnw3CRnjDI8f1ba+3sI85ASrPU7gMLJCcU=;
  b=ShP8jqUdAin/GwsGkMb5JRe92m0G4anhcfR5FqjcbrdRxJjs+0jIq/Hb
   QEBedkrQkr39uZpRQVsRdVo8OwhppWG/2qv/ONpKDgSbevpEMtht8muM+
   yIF/QJncYdylYovFQ7vgdt7EaHY7ii53smWuVuv6zJiClFPKBBgaROPA9
   3xpleQQ03OVbWwzZuSCptt4Tli7OBT6sP5qwgvdRd0tZcsJBmjPmBRuCL
   W9YRZMCfhx2RUcwJmNXESeC+4pzOob5ytQsxKO5pMsbSfWqDuiW50Q95U
   Lvd8ElRZfOSEJaE1Jjng4GyV3Oqyeoubu4UGbqj7uz6yimZ1LL634YzZS
   A==;
X-CSE-ConnectionGUID: gqb0EwkqQ7ypwqHxgJfapA==
X-CSE-MsgGUID: CZGopLEmSyy3E947cix2xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767264"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:45:58 -0700
X-CSE-ConnectionGUID: Dv+L6bJ1QMa0xqPsNRCxsA==
X-CSE-MsgGUID: 1nCsEG0gRAq9xJWP5zSMWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420680"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:45:56 -0700
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
Subject: [PATCH v3 net-next 02/15] selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE
Date: Wed, 14 Oct 2026 20:45:26 +0200
Message-Id: <20261014184539.774708-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HW_SW_MAX_RING_SIZE gives the RX UMEM 8k frames and 8k rings, then
sends batches of 2k and of the maximum HW TX ring size minus 8. This
only works in the single-interface mode, where the TX socket uses the
RX UMEM, and veth, which cannot change its ring sizes, skips the case.
With two interfaces, TX has its own UMEM of DEFAULT_UMEM_BUFFERS (1k)
frames and 2k rings: the in-flight limit in __send_pkts() turns
negative for a 2k batch, so TX never sends and RX times out, and the
second batch would not fit in the TX ring anyway.

The next patch removes the single-interface mode, so size the TX UMEM
like the RX one. The shared UMEM setup copies the RX UMEM over the TX
one and is not affected.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 2a1362874092..16fe32e5afc0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2513,6 +2513,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	test->ifobj_rx->xsk->umem->num_frames = max_descs;
 	test->ifobj_rx->xsk->umem->fill_size = max_descs;
 	test->ifobj_rx->xsk->umem->comp_size = max_descs;
+	test->ifobj_tx->xsk->umem->num_frames = max_descs;
+	test->ifobj_tx->xsk->umem->fill_size = max_descs;
+	test->ifobj_tx->xsk->umem->comp_size = max_descs;
 	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 
-- 
2.43.0

