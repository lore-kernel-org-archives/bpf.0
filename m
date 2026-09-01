Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19F3C09EC;
	Tue,  1 Sep 2026 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297492; cv=none; b=rs23Nn6ui3MSWU10yRLG1fWZb4sBWrItJekAD44NbnFcge0UBsxeZHfwE8+2ZGmN0tHvXYjwKmMArj5bXxVIHtZ0GIxGJV+19apef2sJ6eE4eeMa5uhmAzZYmvNotmuU6u5lTRmRTmwgq38evclQzuC4nlnNNlBr3atVzPntuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297492; c=relaxed/simple;
	bh=l53vH96oBxDrKf3F+DaJU5jUopwYKXsTsTUvDa/ClKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pvlu74FKhty6ddMk7DpVkLmfi/xf0n9t2ts5ND6tZM1hoh+jKIJc6HPW2XTOKrM8Ra70NuKc092mzqntMNCqmQz5lLbVTgU5U07q69Kf4l9KxYNKwHT6Z2ObX4kBUzKIRZyYvrorchcHUWCq15itc/f9WJH6q0Lwo8IgTzy5/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlaSn1zC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlaSn1zC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788297491; x=1819833491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l53vH96oBxDrKf3F+DaJU5jUopwYKXsTsTUvDa/ClKc=;
  b=OlaSn1zCnWCqJJBnlphbCv7Nhe+XKA9FHZwV7lbamujWigaceTG8JuPc
   PVhDLp3BzOdbu5/mKTA+vcawngYAtushBjcy+lkfboOgMTG49LxM/Yb0I
   MZtdFoyiMEfk4d26vWYrroRSaIlTybZ+UreawnaMeSLXQjxZha6NuqjaL
   4d7e/PbyoN+szeL1jVJa3RVfZdwJO9zowOqksx3+gYU7lAqhPVvRMRTGa
   kaTyVtY+qTH9/RMSmTO/Kls8esYZ0UosMcUE80oKRceJY7IojApRqv3WA
   ejxzAoCBYFsKgpoVOs14ovwSRoslwn2bhRUvDBbYrrSKMKJCe79aTiTtS
   w==;
X-CSE-ConnectionGUID: LnWAgPDzTriOKMKan4h1Zg==
X-CSE-MsgGUID: wAYC7ktcR1CEPMGdVFw6bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88670372"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88670372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:18:06 -0700
X-CSE-ConnectionGUID: ByNxaF/ZQs+xLP/QDNWaVw==
X-CSE-MsgGUID: ow28Or3cTdW7H6zJXvoGqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267439757"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 14:18:05 -0700
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
	enjuk@amazon.com,
	chris.packham@alliedtelesis.co.nz,
	przemyslaw.kitszel@intel.com,
	blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	horms@kernel.org,
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
Subject: [PATCH net-next 3/4] i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
Date: Tue,  1 Sep 2026 14:17:49 -0700
Message-ID: <20260901211752.1922993-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
References: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
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

