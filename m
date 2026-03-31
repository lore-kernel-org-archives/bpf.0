Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A683FFADE;
	Tue, 31 Mar 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969342; cv=none; b=iCjYX/xjmtDlu0/ineHtUTns+aKnLk8HXYda9+KGD1XU8Pznee4DcWr7f6eu+sQVKf6cW2oGMc22061rIm9Y7yMp09UEkfGuMyNC89Ow29N9WwcAX0+S+/y4vNsVadkugQfJc3Af2qkxXAdo0XaDAueEmVD47WM3/UTZmofhpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969342; c=relaxed/simple;
	bh=ByEMyKsv0FH0ECC0lkhZEXAZYinHoWdfjuRbpjYytsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fygaaly+CKT+qY+Pkv7/1Wd56weaEkUQcTzB6eR+8ZPfutU2mEMA7mLitNgkAR35s/gyDtZsaXmm1vKawiNsA/HZzy35E7fHwpSHwjPsnwrBVIgQInhaWcy6Eu7gNPwnFjjk3HPq1EdtA/S4tmARF5OGg/TZtsSjIB6X/Pp7KtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8ME+iJP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8ME+iJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969342; x=1806505342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ByEMyKsv0FH0ECC0lkhZEXAZYinHoWdfjuRbpjYytsY=;
  b=F8ME+iJP35hyuFg7588I6dw/NjhCYxD4Bh6tjBw3XFMCgzLhjt0LohB9
   b4thaRrLPDkT9ZKh2zamlwttjY/nqa3WV7Wra0Os7FrsonLAbbfgDUMNq
   Hq+TusyNadJphclIRpFhlIaGe4jhumS4cj1+Jzv/DcnVIYCINxBNUN6ar
   aowq7qEuvYe2l2JiiW2N1XS4xgccOknoFafi0V37wZb6eRjSugMdXD8nM
   XSKBzknDKzduLfBXPuq3EXM1q3+Z/B7eHMZxxxmotYkdwjKU520cnZVm8
   0PMtA4DsXipUXxgHkOp4MlMopwP4IiyKfuLEzqKRYJ6R6XD2EGvacFgi6
   g==;
X-CSE-ConnectionGUID: 5PoA35p9Q9K2nW7/DOXThQ==
X-CSE-MsgGUID: LQ+efrVnSWyQr6UtxlyHJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046098"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046098"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:22 -0700
X-CSE-ConnectionGUID: srJikSgmTCuGPFPGHntP7g==
X-CSE-MsgGUID: gyUYQ/iCQVyLFFjhyj810A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735498"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:19 -0700
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
Subject: [PATCH v5 net 01/11] xsk: tighten UMEM headroom validation to account for tailroom and min frame
Date: Tue, 31 Mar 2026 17:02:03 +0200
Message-Id: <20260331150213.550797-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
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
besides accounting for 128 bytes, take care of tailroom space upfront.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom size")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xdp_umem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 066ce07c506d..58da2f4f4397 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -203,7 +203,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!unaligned_chunks && chunks_rem)
 		return -EINVAL;
 
-	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
+	if (headroom > chunk_size - XDP_PACKET_HEADROOM -
+		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
 		return -EINVAL;
 
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
-- 
2.43.0

