Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1338A715;
	Thu, 19 Mar 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942956; cv=none; b=H4fVh0woV/va1DtJWu9MBa7OMY41y/3OSzHNmLvw8aLOwV2Fnr1Vv/LsOJmoC7DBzceEhQHgF6nLkUg8oIrk7RqzovJ2YCKOO684PRebmXrFr4ysM8EWDHY5M/c+Sy5wrOjLwZe4aorr3bjrY0J5DBgEIm2d2HSycLj33Dkm9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942956; c=relaxed/simple;
	bh=bHtHDW5pjWES198BSHfvJCiZIqQ7rMPOgHiSdRr0YFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWHqGfB2SC0IBd+DnxybpQpORrItjALmFu1N4Ivdfn4PJy0O9Ssniqzop8IADMQWcfpAlHEcU3q0nN2o86VBOh45lhH9ng04116rpba2ILlopiGIGAhjfQuNdvE4VgJUM6bCweZIIXkiniHE0UgfPD4r+zIiGBhrS5Gi0L1JUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3DBezuA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3DBezuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942955; x=1805478955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHtHDW5pjWES198BSHfvJCiZIqQ7rMPOgHiSdRr0YFE=;
  b=d3DBezuAQKlJLwl78OpwgAQpPjHMaez2jx5ov3FNiussOAfFMxEU1lHL
   Lk/wYSRocXr6WrUJwArY9otguXMeCc17Vjh+cJf1qSYKZyXyxpvgMIYWm
   pQZC/iu91Sl4IEx7UFlyE9t+DLf8+YpIqldBpmNtNR3svSlVVDdfZDrAO
   c6uIrP+unQsDdnmKKk+VXWXKdAtrwcXxhaMuAQ7oFEfPVjKHOH2a4belJ
   /CSFl8vJkuLIpqzID+Kx+SKdVLnc3zvA9iUsG6shCeNjJFBtRBzdUI1z2
   YHas6difF/p8PIX4bTSkO1uRdUYi/HlZQsis6jDYN1GG5c58Z30xtOwX9
   w==;
X-CSE-ConnectionGUID: k/Ht759lRdm8J/DxE5qXFg==
X-CSE-MsgGUID: kyG8RqP8TxeAv5noDkSRjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038605"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:55:54 -0700
X-CSE-ConnectionGUID: VqRWvpxvQ3qXBgdv0WJ2Qw==
X-CSE-MsgGUID: AiY/BBsGTXCXky8hD29NYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058599"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:51 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 4/8] i40e: do not round up result of dbuff calculation for xsk pool
Date: Thu, 19 Mar 2026 18:55:34 +0100
Message-Id: <20260319175538.479139-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When programming dbuff on rx queue context, avoid division round up as
it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
example based on 4k chunk size when xsk pool pointer is valid on given
rx ring:

chunk_size = 4096
headroom = 256
tailroom = 320

ring->rx_buf_len = 4096 - 256 - 320 = 3520

rx_ctx.dbuff = DIV_ROUND_UP(3520, 128) ->
3520 / 128 = 27.5 -> round up results in 28

dbuff programming unit is 128. If we give 128 * 28 = 3584. So HW will
corrupt 64 bytes from tailroom. Decrement dbuff value when xsk_pool is
present on i40e's rx ring.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 926d001b2150..9fd55145eeee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3623,6 +3623,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
+	if (ring->xsk_pool)
+		rx_ctx.dbuff--;
 
 	rx_ctx.base = (ring->dma / 128);
 	rx_ctx.qlen = ring->count;
-- 
2.43.0

