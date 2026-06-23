Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4F2D46B3;
	Tue, 23 Jun 2026 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221608; cv=none; b=skwZw/o0wBP6+xcb1q81X1bU5OH4Q8yc5LCRnik+U0WnW9BOngqLT/m5No544JCvgqPyJpbhrpq1Dx4jdTNRsTCITiZlR5YSvTgKsQ6q80ucCCTQqYnf55VzBKdMxy0rBOn9PwEBNC8EI4OVISMgvjmhBHhvmllKQfBrgBnq0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221608; c=relaxed/simple;
	bh=z5gZ1erUU9Vbr3Q/QxiLINGfN2P2/j5wyQv9F2A2Sx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLfgSwYcytDALnX3meMMGt1RAptfOkJvPfoUXZdE6H5eUZ4HTfj/OApXFAhy+E0BuB+lKa+nrv3yCPc83V80pI1q0MErlGtNvIdDMtLb6KvUhCh0a/l+4Jc9oxnAVB3njIDX8Lq05AE0hgSvUDBcQcS1/tSBOP0+ZHQvqafBbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHWYB4EJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHWYB4EJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782221607; x=1813757607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5gZ1erUU9Vbr3Q/QxiLINGfN2P2/j5wyQv9F2A2Sx4=;
  b=CHWYB4EJYRTWeHrnIiHB/nQb56U1Po4SWTjehXSeJAZyzKkJAMMUf7T7
   x8TA9ScwCc+HrQpiDAcBP5rZhvDKyOYSV57sFZe8NiUbjGpFLiXRMqG/T
   GpjDxPGmtHPbEFsm7rrTBy7sQAnJVkK3bel3Zd1rzDsQ1s3zreNQFCe2Z
   BDVBdVPdK+aRCQ59I4IxEQdCQpjk/jY/1kXGtBqzUR0aKhQuEeMB02XqE
   1JnqzdXul3M0q9O8Npmr6kbE4sXaxyse1EhRrtj0HURhVWrqmzAAeugHD
   bMhpBmI8OPQJicW0dQb5n2cKZIYJ5zGyx91Yjf/MtqvkyMcj/+ISOzuev
   A==;
X-CSE-ConnectionGUID: VtBhGWrkR4WxcnSi+/nt2Q==
X-CSE-MsgGUID: 9s+h9YWYRgy7sRHmKg80hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83153540"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83153540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:33:25 -0700
X-CSE-ConnectionGUID: 0hDIUUtdSAqALd3mSnYjTQ==
X-CSE-MsgGUID: T2WB8pDXT1Wb3X7ccKvQRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251447500"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2026 06:33:23 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 3/7] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Tue, 23 Jun 2026 15:32:36 +0200
Message-Id: <20260623133240.1048434-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

There is one subtle case: if a subsequent continuation descriptor also
has an invalid address, xskq_cons_peek_desc() rejects it and the
while loop is never entered, so the in-loop drain path cannot clear
drain_cont. The post-loop code already handles this: it sees
xskq_has_descs() is true (the failed descriptor was read but not
released by peek), releases it, and checks its XDP_PKT_CONTD flag.
Add an else branch so that when the released descriptor is the
last fragment (no XDP_PKT_CONTD), drain_cont is cleared. This
prevents the next valid packet from being incorrectly drained.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e80c035a7af5..c489fadc3608 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1128,6 +1128,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.0

