Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C035E953;
	Thu,  2 Apr 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145034; cv=none; b=YpKwYi2c9vi8LhX7qT2CtPSpFbrakrfreIN2u+4n22M4/8B6bet02yQzY+vWLFJjKUcC89b6IdFDm1d40CAGoVQy5WNlBQVEgIC7w4Rn7N1kBXDHvpcZhn12akzbKlzdFhlzhQn/LGIhIEwGTrKKdDLZr7Wu3lIcv7rY/8I/na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145034; c=relaxed/simple;
	bh=zC9NdznL7SwECGii6q9vWpfRFEHrBpEzALMlj8xuFmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7ayjs39fVD25+oA0bjrD25go3OrEZaIav8rGigUxJWdzrVbRtCoyCwhD9db3avfeJmvySECOR1BaMQBJP0OL73vGPZjA8vC/ExFiwXhQPG6wio5Eo+aFjvehvBgokiA8mD+rNZwkMNPN0rzr4qj7H7+oW1txnAcdDlw4pcQRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlU96qds; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlU96qds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145034; x=1806681034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zC9NdznL7SwECGii6q9vWpfRFEHrBpEzALMlj8xuFmM=;
  b=BlU96qdsVyx7b23WQvpZSkz9pkftZDvHeNGq0gFIesiZP9cK/kufo07I
   D+/BORJoq9yz3Z/aoitN/aHv6Y2WFhGBK6a+Cu7p1lAM8T8ubMFk6Wg2V
   vco+z9K/cLJ74WaRkWs8Tg7uml4HpO1+buQGkIesugLhtBkOJsjT3jP1a
   ICpsz/LnsTH0MVDTGu8hbknwU6yjFzjmfgW7NOBHvRpV309b5MBv1rxQm
   FHYLKOe897uZMEDUD3XvzBQBFPZ7Ljx0qwoF6sRqc6bmX/QuYZSWPZ4We
   0hlsx1L9ZaJOp5r+PNxeXqImZZu/Rz5wGOfImulqJwQBFjE1hY8Th3Fqw
   A==;
X-CSE-ConnectionGUID: WciEjiLsSLyApjtub2TU9w==
X-CSE-MsgGUID: OYTbYKXnTpWL6ZVMb74yFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75927960"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75927960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:33 -0700
X-CSE-ConnectionGUID: J+InQzxSSVSKedTNLrkoCA==
X-CSE-MsgGUID: TUfszvUQQWmO5UXZ2Q6mOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157545"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:30 -0700
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
Subject: [PATCH v6 net 1/8] xsk: tighten UMEM headroom validation to account for tailroom and min frame
Date: Thu,  2 Apr 2026 17:49:51 +0200
Message-Id: <20260402154958.562179-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
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

