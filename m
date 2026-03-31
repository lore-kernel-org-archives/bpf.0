Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862B401A2E;
	Tue, 31 Mar 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969348; cv=none; b=M/aFBx9Q/gH/eBUYSeWW8uZ1K27umU2bNf87zsVie7X/glk197s1EI5IvM6gSQ4/yHQpzo6fn8wBATZtEePfIgaaKWQVH2dfQqyIK27UWuehu0K3Y7WrVK6hf0SwAFDjelrt9KI20R9KXDmDcwERTv2gyhxpee7HSlhIAYps3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969348; c=relaxed/simple;
	bh=fXt8TOEZIpqOJP/1QwLU0hosBkTrf2K7ozrBqwsA7Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFNwug+qR9znOkPHKBSL0zrIScD12e97krJIxDSsHXal4/CW3oSZa4MoG0bO0YlOZXxRpHoOs9LUmrfs8Idm7t9gx4/SA9dVZxw6HQiSvolb/pCuN7fi3VFM1cxFP10UVejxlY6mmzjhHncRpnTWDDX127lt3EdBHP+K13vywGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsbWklOe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsbWklOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969348; x=1806505348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fXt8TOEZIpqOJP/1QwLU0hosBkTrf2K7ozrBqwsA7Xc=;
  b=TsbWklOeb8UbHEOD5d+CzB5KF7uQjq2Za7xJA5GvvgjHNhGefjNd1Fm6
   J7eFmZ3ScioQocgguOuyTOG87AkK1qQWd6J6S2yzqg0f1BK20xR/scv0K
   62wZUZwY1f2Eblc7dexTWv/Dtm2d9VLigcEML/Fgd6ZLhMA26HJcD9s8K
   1AGN+Kx/LEVikdLGTQmEB/fjXku2wDHJL2ghghOYeLymSdflkloAO0bOe
   LKnvEskn0QlCZnHOE9ZPuKMUPUCGZEIeBO/MA3cwlm8G262SBYbvvOvKF
   SsAzWrLEuTekZ3Nd3JMjQZTeNtbTPzekNj4dxxn7nrtfWP83zwGY8DlbJ
   Q==;
X-CSE-ConnectionGUID: CKLB/yCjQWufwB6a9IShGQ==
X-CSE-MsgGUID: tLu38f1OQDmeVDEQcrnJsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046137"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046137"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:27 -0700
X-CSE-ConnectionGUID: hpdQW7CWQcqf7sEr99yPcw==
X-CSE-MsgGUID: EHGBVLAHSg6ryw0UdoyL6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735559"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:24 -0700
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
Subject: [PATCH v5 net 03/11] xsk: fix XDP_UMEM_SG_FLAG issues
Date: Tue, 31 Mar 2026 17:02:05 +0200
Message-Id: <20260331150213.550797-4-maciej.fijalkowski@intel.com>
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

Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
to flags so set it in order to preserve mtu check that is supposed to be
done only when no multi-buffer setup is in picture.

Also, this flag has the same value as XDP_UMEM_TX_SW_CSUM so we could
get unexpected SG setups for software Tx checksums. Since csum flag is
UAPI, modify value of XDP_UMEM_SG_FLAG.

Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing umem")
Reviewed-by: Björn Töpel <bjorn@kernel.org>
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
index 0f40bee606d3..d3f087fad551 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -249,6 +249,10 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
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

