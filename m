Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3233F65EA;
	Wed,  5 Aug 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965765; cv=none; b=H1ulHbU5L2PsInNgJr83cAfeP8ZXauVHb+z7mtQEBmPh12Ae7W1TMzUNV/fEmkXz/m5xTbl53s7YgzKkRTL2mUZcn27yU1gbykAsRY20c2c78ZHqyuip+FqOJ1vrC6xxcDxNx1KpTvrRA1edwD8DVoxR6znlBqHN7XkPxryBUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965765; c=relaxed/simple;
	bh=l53vH96oBxDrKf3F+DaJU5jUopwYKXsTsTUvDa/ClKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTgfeN1K9xi3QD9RV3GvM9MQ1NnJCK/XaswpgPQawfWs0vvi2DVWodd+QngJKMWcp5dPSxL/wTvoh/JYLKc8jrkPSsghWiSJnNm9X1kau6DjQZnfgCoc/+B3uRQmaSk8ntDteX13Gp+zRrygwTxSk/X5Zn/2Bkprp2irA01Buy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEsLtvS/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEsLtvS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965762; x=1817501762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l53vH96oBxDrKf3F+DaJU5jUopwYKXsTsTUvDa/ClKc=;
  b=IEsLtvS/D35ik6Um3QjNH4YOlcT/k5nsDb5/o37hw50o8Km/610HpQ39
   lwgyvTm9xhTcCZLqQEX0/YdUyVmkolS3xcufZiM+u4Riz4ZK5zR66umzf
   1hN6ZBsTUuf8PluehLbRsPD2XS4RESt1EHA2/eC3bTRju0GQjaWGYTFCR
   Lr8u8uSFuJ6ip999z1yhVHTmiqJU/DkejFFomkEj0yQJSAoDNOR/SU3OL
   3FA7OKwF9jWnAiil/eEdhsCPFRqcduZeyF2E2J0iJEHUwmSN4sXRvCF/Y
   QH5ynDRvOecjDLoBCBsYYRZmVK0OQZBilrWY/bzrKmH5wF/QdvTB+R3M+
   A==;
X-CSE-ConnectionGUID: CRXDElLDRACcS7BRwl9NQw==
X-CSE-MsgGUID: lSjATBweQ2WziJ5cXDpw3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343626"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:53 -0700
X-CSE-ConnectionGUID: zfVGIdnWSaSanj4rku0dDQ==
X-CSE-MsgGUID: QXDV75CcS+Wv5DCZWTKTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576159"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net-next 12/15] i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
Date: Wed,  5 Aug 2026 14:35:37 -0700
Message-ID: <20260805213541.2281287-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <kohei@enjuk.jp>

Introduce i40e_xdp_rx_vlan_tag() which takes the same approach as
i40e_process_skb_fields() to extract the VLAN tag from the RX
descriptor.

Tested with X710 adapter using xdp_hw_metadata, and confirmed that VLAN
tags match between bpf_xdp_metadata_rx_vlan_tag() and
skb->vlan_proto/vlan_tci.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e487d697a634..719f45b5cb40 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13607,8 +13607,27 @@ static int i40e_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 	return 0;
 }
 
+static int i40e_xdp_rx_vlan_tag(const struct xdp_md *_ctx, __be16 *vlan_proto,
+				u16 *vlan_tci)
+{
+	const struct i40e_xdp_buff *ctx = (const void *)_ctx;
+	const union i40e_rx_desc *desc = ctx->desc;
+	u64 status;
+
+	status = le64_to_cpu(desc->wb.qword1.status_error_len);
+
+	if (!(status & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)))
+		return -ENODATA;
+
+	*vlan_proto = cpu_to_be16(ETH_P_8021Q);
+	*vlan_tci = le16_to_cpu(desc->wb.qword0.lo_dword.l2tag1);
+
+	return 0;
+}
+
 static const struct xdp_metadata_ops i40e_xdp_metadata_ops = {
 	.xmo_rx_hash		= i40e_xdp_rx_hash,
+	.xmo_rx_vlan_tag	= i40e_xdp_rx_vlan_tag,
 };
 
 static const struct net_device_ops i40e_netdev_ops = {
-- 
2.47.1

