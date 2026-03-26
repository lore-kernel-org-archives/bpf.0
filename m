Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979F3F7E67;
	Thu, 26 Mar 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525792; cv=none; b=QOjx+SICz9uX0bVyjggOlSrOqKpPhAOTb1lpXtUKZNp02O6t999P2SBT01j4SubEdubJ71zALguH/6uBimZAdpuVUqDENsAbCWCBVwTN1Vub/ESColm/d4CrbMcB3uiDJoDNnjwGSVo6xfTIyMqRPpabFJt9QtcZ9uz8Zq968YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525792; c=relaxed/simple;
	bh=VpYczqwnmJncpyaWulNnHSoKDHNu7SSDIFJJMLI3IKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmOWtlXNXShb1wXoJgy4W928ai5PZaTjXDILQl9aJ6VGCucfXHEJnKbyaGWrAJnVZuyH6sRmUbPEIKhppBDR+O3f7+2XxOcWUM0AKpmShNHIJjqjv0dLdtLV1uCg4L1PZlAm3cj+nwvmvpGkqsc3k9nN4ozxwrApyUCR9gt7SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ax13Gi43; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ax13Gi43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525783; x=1806061783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VpYczqwnmJncpyaWulNnHSoKDHNu7SSDIFJJMLI3IKM=;
  b=ax13Gi43FvWhlPpnGXMD6TNM8GbmlwMTs0vgyeAXIRolez3cd/rtDo9U
   xZhSh89C82jsCU8mvbpope6y6+ALsUZ0qhs61oNU4wP2ZlLQNXZxEyQnt
   29eYgsPT0A2wx0ydPFxO2NxSetRTy+koWbYZnYAScLTE2NmT9hqFrjCfR
   n6SmlCiB83pjhjM8mLDuIQp+MhgaTQeUACFqBCzRu10jqN5EK72xr0p9Y
   PPHAps5ktrUiPupsc7IInJv3Z5oTOOA7BV2h+Jp22wH0+DtPq+ghxCx9M
   GxG2eI7VifR5uzcA2mQdb7yx+7QxCBiR0Kv3J4sxuWSUtk4Ci/Z3jrKP1
   A==;
X-CSE-ConnectionGUID: Bf2Eez8ATrGE0CK/otjX8A==
X-CSE-MsgGUID: JOjibenPS5aqkeMWnB9bxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776244"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:39 -0700
X-CSE-ConnectionGUID: 46bj7kW9R7S9SpyxqHarWA==
X-CSE-MsgGUID: NfcD+BIAQc67VzcJ6YfK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029022"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:37 -0700
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
Subject: [PATCH v4 net 03/11] xsk: fix XDP_UMEM_SG_FLAG issues
Date: Thu, 26 Mar 2026 12:49:11 +0100
Message-Id: <20260326114919.519456-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
to flags so set it in order to preserve mtu check that is supposed to be
done only when no multi-buffer setup is in picture.

Also, this flag has the same value as XDP_UMEM_TX_SW_CSUM so we could
get unexpected SG setups for software Tx checksums. Since csum flag is
UAPI, modify value of XDP_UMEM_SG_FLAG.

Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing umem")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock.h  | 2 +-
 net/xdp/xsk_buff_pool.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..ebac60a3d8a1 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -14,7 +14,7 @@
 #include <linux/mm.h>
 #include <net/sock.h>
 
-#define XDP_UMEM_SG_FLAG (1 << 1)
+#define XDP_UMEM_SG_FLAG BIT(3)
 
 struct net_device;
 struct xsk_queue;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..729602a3cec0 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -247,6 +247,10 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	struct xdp_umem *umem = umem_xs->umem;
 
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
+
+	if (umem->flags & XDP_UMEM_SG_FLAG)
+		flags |= XDP_USE_SG;
+
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
 
-- 
2.43.0

