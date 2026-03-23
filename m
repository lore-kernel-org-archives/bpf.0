Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9235B64D;
	Mon, 23 Mar 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293914; cv=none; b=I2rzYFTxzaqkAAgRTw4coqCPS1thzBnRvtTVbF2PodP7xcZ6WdcnWR5F72ecU032sdo/2EKjftedfE0RVlDcpJ6G1YeRGinBb5yuYgo9qSOH522lwBfZd8dXxK28frZzMomg6WAs8hjapwsIs72EPaEut8QkpfOvt2csEbvH0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293914; c=relaxed/simple;
	bh=xC5R5MNUphmIdYDIVuEk8r8YygGU53qCKz4Rg+iTYsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiRhn7Y1Xf3DQ/SSEhQXY7a3CPon77bD0QdrJsWXTQ4aJsiBSF1SPFMmWe2yZIsW+VsyhAphRn1x3F4UiEQYwwcvoNrseM2g4ie/sscNm6GWoVFYvGbMnyxVR44OLvVz2y3mrOHZaKjvmI4y+4HD4tFeEzEvwpBqHU5CaKjMYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsMK/B4a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsMK/B4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293913; x=1805829913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xC5R5MNUphmIdYDIVuEk8r8YygGU53qCKz4Rg+iTYsk=;
  b=TsMK/B4aZ+81VoC+oC8KThtMtBqkQFzNuoeZcEaruFkGR3ttHtPa7HaS
   axa3S8Nc7HwSblz3iBJNc8QkzAzrKouBpAnsoO4mQIfBNy8eK6IHQI5Dh
   ikvbs0bBus1HHH9eZUohig+7xJBSuJlTbdP9kI119AyCTIAD4KjKxcAgp
   0JEd498XShOPYdKp4ahrQDOHKThUz/bi01jnhATng8mGsN+ExVAXkEnEA
   iT84PrYNRS0wvTuODaFa5dRMnFGa2M7E7/8IP1oqIPyeKq+cdKltarjbq
   Z23eK66YTQu80G6BiMZPABTcqXv/Y8Zuk70o7IQrbmgglG0BVzwL23Cht
   A==;
X-CSE-ConnectionGUID: oXKK1dZcQuuIz5FxZZ7l1w==
X-CSE-MsgGUID: o8cjKfmERBWQC2W+LyVTag==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013307"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013307"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:13 -0700
X-CSE-ConnectionGUID: Zre272SXR2CJHmQ+CntO1g==
X-CSE-MsgGUID: GEcKIbGGQYOundakmPOpUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187875"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:10 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v3 net 1/8] xsk: tighten UMEM headroom validation to account for tailroom and min frame
Date: Mon, 23 Mar 2026 20:24:50 +0100
Message-Id: <20260323192457.504631-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current headroom validation in xdp_umem_reg() could leave us with
insufficient space dedicated to even receive minimum-sized ethernet
frame. Furthermore if multi-buffer would come to play then
skb_shared_info stored at the end of XSK frame would be corrupted.

HW typically works with 128-aligned sizes so let us provide this value
as bare minimum.

Multi-buffer setting is known later in the configuration process so
besides accounting for 128 bytes, let us also take care of tailroom space
upfront.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom size")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xdp_umem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 066ce07c506d..98c1eacf8c40 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -203,7 +203,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!unaligned_chunks && chunks_rem)
 		return -EINVAL;
 
-	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
+	if (headroom >= chunk_size - XDP_PACKET_HEADROOM -
+			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
 		return -EINVAL;
 
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
-- 
2.43.0

