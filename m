Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB523ED11D;
	Wed, 25 Feb 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043472; cv=none; b=Bdu+fjOc9oZ8FUVDfW4hJhZ8SFC61R71Vk5Mg4tr713vZLzA/pYAwSufNRFLaH4iLYqNvSeL6lfxhJ9o1zCpwoA/0t2svbfdZ7NpENuKHQDP78SVewkvbbu0p9fjgEAQeLWyFTGkhw2qDJACzDvJSSOEod9p9r+UwL1ecaeoFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043472; c=relaxed/simple;
	bh=Ho6uKwZTjfD8R8eQTjIOJqbiTAM698Fa7rzKNku20yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbzb60ECyyVVqEhi2LV/WfqQ7k1AoLiE8ZOf4chXGsLgBOk4CllhhnofJYQlzeatre7K1buvr3VzZNVZ5x/AF9NqPSA1b52xEsI3frFclwF4Mio8mnKhvgtwCNC1k0VL04dRiyLEn8gkRBsOkqKH8G5jneJzsy17a6eIv9jd448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euKsbWn1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euKsbWn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772043465; x=1803579465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ho6uKwZTjfD8R8eQTjIOJqbiTAM698Fa7rzKNku20yc=;
  b=euKsbWn1FpFYfkPc4J5aUxwgIkHooO0ZF4juDnFay9B3MmirXMgTlg0j
   OOlgI/g+UIdQlfq4jbO81HGzQP8id8DROKu41iGqBxbEHqKwo3zbCExjo
   U7Pefh8FM/xCopLGz1tMTXnxNWFAqnXQ2YB1xoF43Nb44FXHaS4i1RAlH
   7KoUlKaIwtTHdXKltfcUWXscbG+luyaIlYVBaQXJl+jl8AFVvghFZZXd9
   jBN8Hmrd7wCCcBdcmrPbT/4e9CqgHWVnHpRHQHvLlWD7KjaZAXZJ/1EgR
   fD2LKW6SkRbh8L39lPoPHm92K0v8njLqiocwMUMdXoptZPu6HWdjGSIDB
   w==;
X-CSE-ConnectionGUID: fHMR76VdSVmITnlZ4DSAUA==
X-CSE-MsgGUID: oXp3J3AzSnKy8eW1MlIwtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76928025"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="76928025"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 10:17:44 -0800
X-CSE-ConnectionGUID: gyLPuxhrSK+ASMyn0+Po+Q==
X-CSE-MsgGUID: bVBYp09hSsiGRDLEMoBYuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="216337834"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 25 Feb 2026 10:17:41 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 672BB32C87;
	Wed, 25 Feb 2026 18:17:39 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 10/10] ixgbevf: allow changing MTU when XDP program is attached
Date: Wed, 25 Feb 2026 18:46:44 +0100
Message-ID: <20260225174646.3514556-11-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225174646.3514556-1-larysa.zaremba@intel.com>
References: <20260225174646.3514556-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xskxceiver attempts to change MTU after attaching XDP program,
ixgbevf rejects the request leading to test being failed.

Support MTU change operation even when XDP program is already attached,
perform the same frame size check as when attaching a program.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 606c6123d7eb..ccefb44c524e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4078,6 +4078,18 @@ static int ixgbevf_set_mac(struct net_device *netdev, void *p)
 	return 0;
 }
 
+static bool ixgbevf_xdp_mtu_ok(const struct ixgbevf_adapter *adapter,
+			       const struct bpf_prog *prog, unsigned int mtu)
+{
+	u32 frame_size = mtu + LIBETH_RX_LL_LEN;
+	bool requires_mbuf;
+
+	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM) ||
+			adapter->flags & IXGBEVF_FLAG_HSPLIT;
+
+	return prog->aux->xdp_has_frags || !requires_mbuf;
+}
+
 /**
  * ixgbevf_change_mtu - Change the Maximum Transfer Unit
  * @netdev: network interface device structure
@@ -4093,8 +4105,10 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	int ret;
 
 	/* prevent MTU being changed to a size unsupported by XDP */
-	if (adapter->xdp_prog) {
-		dev_warn(&adapter->pdev->dev, "MTU cannot be changed while XDP program is loaded\n");
+	if (adapter->xdp_prog &&
+	    !ixgbevf_xdp_mtu_ok(adapter, adapter->xdp_prog, new_mtu)) {
+		netdev_warn(netdev,
+			    "MTU value provided cannot be set while current XDP program is attached\n");
 		return -EPERM;
 	}
 
@@ -4257,14 +4271,10 @@ ixgbevf_features_check(struct sk_buff *skb, struct net_device *dev,
 static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 			     struct netlink_ext_ack *extack)
 {
-	u32 frame_size = READ_ONCE(dev->mtu) + LIBETH_RX_LL_LEN;
 	struct ixgbevf_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
-	bool requires_mbuf;
 
-	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM) ||
-			adapter->flags & IXGBEVF_FLAG_HSPLIT;
-	if (prog && !prog->aux->xdp_has_frags && requires_mbuf) {
+	if (prog && !ixgbevf_xdp_mtu_ok(adapter, prog, READ_ONCE(dev->mtu))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Configured MTU or HW limitations require non-linear frames and XDP prog does not support frags");
 		return -EOPNOTSUPP;
-- 
2.52.0

