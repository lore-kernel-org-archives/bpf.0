Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE23D8100;
	Thu, 19 Mar 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942950; cv=none; b=RiqmFlpjtRtq1PeuiBvwWVN6M4oZyHdSAe+FnojT88L9rae9PDA3Ex1fr8oTNVCGY5ukI2xDR8IFQeRIrhGA7JiRy3uCJv/J/EoIHHRVVgra8sE0by6MkbDgiZIIIjomM7rCUc/Rhe//Kz8D3oGvWm9PRPrvTW/+seRyZF78nQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942950; c=relaxed/simple;
	bh=asvI3C8XSDT+xctgayr3yRizIFx2fCmbmabQsqUrwjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dosdztp5Bpyp25cdxqr18RordsmEfsMqVIY3njoOHbkTLd48FA63KrfDyKXz0bKOUR4XJgZLE1+216fbuOAr3hY+lwvsPkwehPWe48kK2lWspBz0pImsannUCJikgy4rpGw3rDpsuH4FujkTiKaWKHL4zf2Md64tWsv9+hzhjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeY266Sw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeY266Sw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942947; x=1805478947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asvI3C8XSDT+xctgayr3yRizIFx2fCmbmabQsqUrwjs=;
  b=VeY266Sw0OdjYVZHq9lINHtXElloHKPjDl7GeLxlm8OLNUcAUkHl56Bf
   ZR1WsaxnEZBuyQFFz/OTy67aJ5V297b5M5SkgD0j7CkP60begdLq03Pe9
   XZcYyM7QinfcD7hB18qG0IojyXb/GToEuZl+J4WYyjSCf0dCnMcNfBOHZ
   n5YiRP1dvXA12Wp4o/2uzlqh/02j4JLoaKRbX8+2FAhES4gRHEyq8jEHy
   0T35ORYn2iMiAgxfAHtM/BSl9sqhqtBkuSO39RWHaS4YfCi/Yc+n0JGU0
   aBl4S+TB6dze2TuCCK0v9BS45iRtJHQxuk/aDjHk8Bnpcm2MZjiif9OHz
   w==;
X-CSE-ConnectionGUID: SYV6exADTKWK3WILl+yUTQ==
X-CSE-MsgGUID: Qy4BLevaSnqMQp2rX5fokw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038580"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038580"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:55:46 -0700
X-CSE-ConnectionGUID: 8Oth/5JuTH6O9e6THjEHmg==
X-CSE-MsgGUID: K3ZkZHCKTEOd/71Ho0u9Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058555"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:44 -0700
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
Subject: [PATCH v2 net 1/8] xsk: tighten UMEM headroom validation to account for tailroom and min frame
Date: Thu, 19 Mar 2026 18:55:31 +0100
Message-Id: <20260319175538.479139-2-maciej.fijalkowski@intel.com>
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

The current headroom validation in xdp_umem_reg() could leave us with
insufficient space dedicated to even receive minimum-sized ethernet
frame. Furthermore if multi-buffer would come to play then
skb_shared_info stored at the end of XSK frame would be corrupted.

Multi-buffer setting is known later in the configuration process so
besides accounting for ETH_ZLEN, let us also take care of tailroom space
upfront.

Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom size")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xdp_umem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 066ce07c506d..50963c079f85 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -203,7 +203,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!unaligned_chunks && chunks_rem)
 		return -EINVAL;
 
-	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
+	if (headroom >= chunk_size - XDP_PACKET_HEADROOM -
+			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - ETH_ZLEN)
 		return -EINVAL;
 
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
-- 
2.43.0

