Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8292C158A;
	Tue, 10 Mar 2026 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150214; cv=none; b=ZiTyvg+LNUx7VuryVaz2vZIYq0m8kj65qKfaY3WPxOIyCZqJZK77DhHbYXvLDVkKqNrbS3Fe4V6/kfQ/xOSUQB5Nk0YZ3zdwo0O3raEAAHFTLipcDUIBQktFCbXU3SppsSEQUe4rbN84Q1BmONDdTtAbVB7L5Lhk4uYo0agj+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150214; c=relaxed/simple;
	bh=oTKX1XlpkM2qvbdT76Nx2oSfosImEtoVskphYVC0++k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qto6qZeYms8mQorfX5K+gQcZIPeLtFyGimuK2dvF7OQp0O+TnIc6KkugEuPV4APd5pCves9AFqMiygbgfSVfq7wE47wVodY+kr1oJUCYLJk3aouu7KIjRSvJAvAOkH99woniE/saMzFFLgHIncrS/F2JE0LlehzHNWUArfNyg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNDMm/cZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNDMm/cZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773150212; x=1804686212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oTKX1XlpkM2qvbdT76Nx2oSfosImEtoVskphYVC0++k=;
  b=lNDMm/cZ+JuzDoZKs3OtfHyrQO+24ZdkcuVV8L0J7M6cOsBphcb9XIqz
   Y7WkFdcaRCdh4m3iHGQVeZJdj9frVJUrnt1OmYaGhLSsRYkNto0DP1z5e
   xXcMHpO1fD4a9NicONhz8UvZDtyKLcypaSbwA963Vz2RlA6aW5ghNgNG9
   QbGsjjMapjBk8jql57kwGKFLlYErROGQoi6QeSODgtH//vyM9ylnupvVi
   Hiitd28EzOWQyEqWZXsDx4orKBHcEaR0Km4NLoYdYWv5orNZOj5P9foST
   DM1n7IJA4oMpRrGIL1rZFoSObkzIMr1LEFVRUtTO4v9f2W8UGaHZvjyoB
   g==;
X-CSE-ConnectionGUID: YJK+9DuNTemhG2hZuC818g==
X-CSE-MsgGUID: LJBebqxuRSmuIa5agiObGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74096962"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74096962"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 06:43:32 -0700
X-CSE-ConnectionGUID: iWW+GIdJRYSHu7Cgc7K+WA==
X-CSE-MsgGUID: K7a/VcTfQmWbQ17Su4rIjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220160073"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 06:43:30 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next] xsk: remove doubled defines
Date: Tue, 10 Mar 2026 14:43:27 +0100
Message-Id: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seems we have been carrying around doubled defines for unaligned mode
logic. Remove one of them.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xsk_buff_pool.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 0b1abdb99c9e..ccb3b350001f 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
 	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
 }
 
-/* Masks for xdp_umem_page flags.
- * The low 12-bits of the addr will be 0 since this is the page address, so we
- * can use them for flags.
- */
-#define XSK_NEXT_PG_CONTIG_SHIFT 0
-#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
-
 static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 						 u64 addr, u32 len)
 {
-- 
2.43.0

