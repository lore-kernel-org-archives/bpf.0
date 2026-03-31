Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AF401A2A;
	Tue, 31 Mar 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969372; cv=none; b=k6yrDP9tIIfwqygnMPOIW4G/Bba+AsobZLxhStgL3jEUbylQhgkv9UbkztFLMzlztjWb1xLY1sIMUKfccdNWgLYOTLD6yXeDzKuk0hmw8RbAlc82sjMaIGuywo4TuI6N0vyg2XkPaWTpcBn196PgwqW1IJQF30bPAjvCk+Q4y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969372; c=relaxed/simple;
	bh=VeLm4vxHSdRnkJZF6B1RLT0XaykufOd6fbmITIKKYfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPt3utA6knXV0M3pYDB/5j5wqXlM5gnuIrnm0XVluq4+a66XqstxnDxuEbu8MQVcftawHQs1fLcXOfgVZZzDyBrEMubA0gjcwP8b0Za31xGVsgAM9WuFad4j5UP+mo2bsVFJboRDB3fGYM4Ezk48WOTfUSPxajd6lCY2sW/ZlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlDA/b9r; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlDA/b9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969371; x=1806505371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VeLm4vxHSdRnkJZF6B1RLT0XaykufOd6fbmITIKKYfc=;
  b=JlDA/b9r1R2peCKsoPNOfBW1rzE+WZIICw/d5OI5gfhLHTpngYN9oi/Z
   +sNtbs+ZLY+zv/OfYcknzRx42smZiyOSZU8nZY8eYXY6eduBVc5+/ZdxC
   1ckGXD3i+pLF3Q0RDVKObbDNnw7rOOZOybOXqgbD2RqIHMj0Se3K3d2fv
   M9A/Kq2DUr3krgTzqG75099pYJw7q9pfWcdoPsB5c4J3CnkMfO8yrBuZp
   zwB4AYYAa6oBlMd7Ck6lLnNlvXUN+J2dS5TJ1p/1NKLnpAXP2zWP2DW2T
   iBG5A4oDsSX4ympnbXCW3CKpGxnLtccafp0T0i0Pi85X4dez1rvYmI+iF
   w==;
X-CSE-ConnectionGUID: 1+KcpU3VS9qIRrNypYGJBw==
X-CSE-MsgGUID: 1lm4G4sRSyeoQ5CSkKJiwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046205"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:45 -0700
X-CSE-ConnectionGUID: 5+O3Igi9RM2SmlbNGuZFBQ==
X-CSE-MsgGUID: 16AeA5nqQzC2Ebsc1PDFWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735643"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:42 -0700
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
Subject: [PATCH v5 net 09/11] idpf: remove xsk frame size check against alignment
Date: Tue, 31 Mar 2026 17:02:11 +0200
Message-Id: <20260331150213.550797-10-maciej.fijalkowski@intel.com>
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

We provide alignment within xsk_pool_get_rx_frame_size() now, so this
validation is redundant.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/idpf/xsk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..a5b6177fd44c 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -558,16 +558,6 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 	bool restart;
 	int ret;
 
-	if (pool && !IS_ALIGNED(xsk_pool_get_rx_frame_size(pool),
-				LIBETH_RX_BUF_STRIDE)) {
-		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
-				       "%s: HW doesn't support frames sizes not aligned to %u (qid %u: %u)",
-				       netdev_name(vport->netdev),
-				       LIBETH_RX_BUF_STRIDE, qid,
-				       xsk_pool_get_rx_frame_size(pool));
-		return -EINVAL;
-	}
-
 	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
 	if (!restart)
 		goto pool;
-- 
2.43.0

