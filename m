Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC483F87E1;
	Thu, 26 Mar 2026 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525784; cv=none; b=bc1e8FObZ7NPxc+MirmqvtCawnKtJruYDb10K9NSHTr8j0UqrqWXt3ASo7JQjmosvqsCHqiN6rhzkZ9RauwCol9w/T4HfU7ess4pOfZHLmqdoh2sBo3Y9ZDiE7/eIj0qRdB/Ne1Gf9qpexATooHGw0/0nF4YcQ/QWtGnXxbJYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525784; c=relaxed/simple;
	bh=zC9NdznL7SwECGii6q9vWpfRFEHrBpEzALMlj8xuFmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1MFsI41d8DqzKtq1DuoNhMqC+G7VefQ5z85Es4ZvAjJNsDbbwQkHeO+79/7ftrEk3iD60rlBJy0HIzwArPEhzpPQLUpv2YTW4+VvLGk9oeSHAeasJnzNvBEElj2RQz+OggXSIVLRup6k+WUo64Yx+mDw7CCDQq2QGscK1i8t8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArzXS/Mi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArzXS/Mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525775; x=1806061775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zC9NdznL7SwECGii6q9vWpfRFEHrBpEzALMlj8xuFmM=;
  b=ArzXS/MiVIHmh9HrtP3YPm0bSRFcH7iGyWCcRWa/DTmJ6y2Z5ov0AS8+
   C+nFzj5auhxEXciAdzqEDc78kewfwNdmziA1IVEzkeij0Q7jWbkrvm93z
   P+MfyzQjbesBjWtnivkHR0UCn1zn9sCQFF71f0GF5bA+7tDgh6PXvBhRe
   t0tbRFVFlUPxvU2oyuiSQj4HdZiweQdmjAR4FpieciWqxLr4VUwThE4WA
   VuHSgWkBSZy8fDIWPdXev6Vj/+2bwVaOKfgCQMDL45MRvqACOUgNA2UEn
   /0cyrU0idUjyVU4ZBi07yz5x018+iLdzfvnwDtpbAzup8IfWvIaZYLVd3
   g==;
X-CSE-ConnectionGUID: RAJfvj65QUa2EVxZmbzCLw==
X-CSE-MsgGUID: Mkn68MR2RYyCg0SWhaj/0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776230"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:34 -0700
X-CSE-ConnectionGUID: jkobp5pqTI2zsbW1AkbFWw==
X-CSE-MsgGUID: vP73laxhT2u9tjcXApMLuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029008"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:31 -0700
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
Subject: [PATCH v4 net 01/11] xsk: tighten UMEM headroom validation to account for tailroom and min frame
Date: Thu, 26 Mar 2026 12:49:09 +0100
Message-Id: <20260326114919.519456-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
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

