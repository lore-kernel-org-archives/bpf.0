Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F72D063E;
	Tue,  1 Sep 2026 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297490; cv=none; b=Lp/jl1KUCVN+qz9YGHlHEV1wmlgE7vGHprKz83UTWQcneARvfgBQKK1h09yrfCpbPTAFJz+FgsGpNY8VQyoAFf8OXpRrZGJtU5AN9Cleh5EeogXBPDO6GqPyTHVhRhPPH+s1ZjGjjujADJNs6C7j5R4RI3BN8GjDLdryc+And2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297490; c=relaxed/simple;
	bh=+dANJpsQx5HL34vpMlzYVNbwhlqabJCBaNqb2C53gIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm7FjDGCPerNV23agGae7hIVR3c/s/iA7k0FJfa5HW0kXkOrgs7tuyRWq0S6xeBbim9MqepIuGPAwIP8SH35CSIFgU25kb4gH2mSFEVp5Ci1KE+rP+lm/v9B7WwgHm5I39H04DtMgGLfZHswjVVogPwi/SLbgrxp0e5jbIhv2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lk46vknL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lk46vknL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788297489; x=1819833489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+dANJpsQx5HL34vpMlzYVNbwhlqabJCBaNqb2C53gIc=;
  b=lk46vknL+3LI77+f8c/EMJDEmm39p4gNsUo7zfuppqDL1Eg3CDRLEwZ2
   fm0N5Xl6GzBt6TPMRRrf0JbraLyLSEfEPtHLku6NoYnBt4niz5Fzq+xj9
   kT26ikcHw8rjJ5FUaH06a6aOFLeH1O4DqOahOpiemsanZqBAQFZ6MCx4x
   SgySIqG+IX1tACibRzrBIs53t02ZFmoOfrphWc+kpK+VjhiAoeupUB1Kc
   P+YOnLPO44klGqs5if5wKnLTzRsvS0jBWvRrDAUXk8W6BlyV3oBfUB2bf
   Y1+3+QSoqVS4kBCGcTxv7Qkkd7kS8HZjUDqCvSl8GSosTY+BjvKXma4Om
   A==;
X-CSE-ConnectionGUID: 27GyzqpKSIexVlJzDlvuug==
X-CSE-MsgGUID: pXvaFTvlSDyScrBinSHEbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88670360"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88670360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:18:06 -0700
X-CSE-ConnectionGUID: 8IPnFd1DRHmiI7YeX+FPSw==
X-CSE-MsgGUID: HgRDq/0JS/O/Ozl3yXXPtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267439753"
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
Subject: [PATCH net-next 2/4] i40e: add support for bpf_xdp_metadata_rx_hash()
Date: Tue,  1 Sep 2026 14:17:48 -0700
Message-ID: <20260901211752.1922993-3-anthony.l.nguyen@intel.com>
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

Introduce i40e_xdp_rx_hash() which takes the same approach as
i40e_rx_hash() to extract the hash from RX descriptors.

Tested with X710 adapter using xdp_hw_metadata, and verified hash
consistency between bpf_xdp_metadata_rx_hash() and skb->hash.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 30 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4b11ae9ed8d5..e487d697a634 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4,6 +4,7 @@
 #include <generated/utsrelease.h>
 #include <linux/crash_dump.h>
 #include <linux/net/intel/libie/pctype.h>
+#include <linux/net/intel/libie/rx.h>
 #include <linux/if_bridge.h>
 #include <linux/if_macvlan.h>
 #include <linux/module.h>
@@ -13582,6 +13583,34 @@ static int i40e_xdp(struct net_device *dev,
 	}
 }
 
+static int i40e_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			    enum xdp_rss_hash_type *rss_type)
+{
+	const struct i40e_xdp_buff *ctx = (const void *)_ctx;
+	const union i40e_rx_desc *desc = ctx->desc;
+	struct libeth_rx_pt rx_ptype;
+	u8 raw_rx_ptype;
+	u64 status;
+
+	status = le64_to_cpu(desc->wb.qword1.status_error_len);
+	raw_rx_ptype = FIELD_GET(I40E_RXD_QW1_PTYPE_MASK, status);
+	rx_ptype = libie_rx_pt_parse(raw_rx_ptype);
+
+	if (!libeth_rx_pt_has_hash(ctx->xdp.rxq->dev, rx_ptype) ||
+	    FIELD_GET(I40E_RX_DESC_STATUS_FLTSTAT_MASK, status) !=
+		    I40E_RX_DESC_FLTSTAT_RSS_HASH)
+		return -ENODATA;
+
+	*hash = le32_to_cpu(desc->wb.qword0.hi_dword.rss);
+	*rss_type = rx_ptype.hash_type;
+
+	return 0;
+}
+
+static const struct xdp_metadata_ops i40e_xdp_metadata_ops = {
+	.xmo_rx_hash		= i40e_xdp_rx_hash,
+};
+
 static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_open		= i40e_open,
 	.ndo_stop		= i40e_close,
@@ -13784,6 +13813,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
 
 	netdev->netdev_ops = &i40e_netdev_ops;
+	netdev->xdp_metadata_ops = &i40e_xdp_metadata_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 	i40e_set_ethtool_ops(netdev);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index ed8bbdb586da..16a65c6e5153 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_TYPE_H_
 #define _I40E_TYPE_H_
 
+#include <linux/bits.h>
 #include <uapi/linux/if_ether.h>
 #include "i40e_adminq.h"
 #include "i40e_hmc.h"
@@ -699,6 +700,10 @@ enum i40e_rx_desc_status_bits {
 	I40E_RX_DESC_STATUS_LAST /* this entry must be last!!! */
 };
 
+#define I40E_RX_DESC_STATUS_FLTSTAT_MASK                   \
+	GENMASK_ULL(I40E_RX_DESC_STATUS_FLTSTAT_SHIFT + 1, \
+		    I40E_RX_DESC_STATUS_FLTSTAT_SHIFT)
+
 #define I40E_RXD_QW1_STATUS_SHIFT	0
 #define I40E_RXD_QW1_STATUS_MASK	((BIT(I40E_RX_DESC_STATUS_LAST) - 1) \
 					 << I40E_RXD_QW1_STATUS_SHIFT)
-- 
2.47.1

