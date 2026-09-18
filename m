Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7752ED21;
	Fri, 18 Sep 2026 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766711; cv=none; b=UeCoeJLeQv/qlOThgt2ZjxhNQrpqiWQ5TZroMy4gtCvkqeXaILVr7MJ0zwuQLEy0HTbd1r+QNvSSVjeJaNl659WXDMvYpNke8P8uS5AmDkfLSIHMVn+O6XwUw11LU8Avvf3BTSuzYf+fC6r/3bfN+2VZ+Uk/YwSmMY7xosv17Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766711; c=relaxed/simple;
	bh=NxemBkcpOxHcTHt2Ca0k4VZJiTLtFgSmzqjEze2H4Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2OHS+7/mw5xdCw+Znb8I2cThlAdRjZyTsCvUfqgGwGg7K8AMxhobymRBtf9pM2lCn3r06g1ms+1nGBRIWlfzOD2eX72Jgk/ERKFjkDx0vlTr0FFjZmlO8ocPSr8pLza+hRcAl9AqnoMi1QtmeoEhpoJb2xBk48gj/GTtQJylFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ffjgqm1w; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ffjgqm1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766710; x=1821302710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NxemBkcpOxHcTHt2Ca0k4VZJiTLtFgSmzqjEze2H4Pw=;
  b=Ffjgqm1w69UZujewIFED2vLYnU44n1X2XvvWQdGUeeQsoyTGns5Sp01S
   JBi96NTNR/aWb3WTRNcyrnbd1D63a6HQjUQghhZ1UzoxI8yV7zirjTiDa
   gC4rNeJne5bX0pqUkGSQDUjQzyD+0i8g2jmYWNTkqwLLe6WstuWXSt191
   lIuW9/TWdce9/pRisppZdXCbqu43JT82H3oEvl1dmNfp9iON5TYzFvLDj
   1e24zS4mE8eVwgwmK+ZfxrFKxZ9eLJKid3I2wazd0ExahQH4j32pv5M2z
   objglx1Xbm7vRCAJBU2nPK40EEsL5W2zcTUvCIIOxBHS0kjJq2Y3wZeXq
   Q==;
X-CSE-ConnectionGUID: yDt32SVsQs+CUv1b5BngNQ==
X-CSE-MsgGUID: jBPB+KSORP6e9oNBPbbApw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436270"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436270"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:07 -0700
X-CSE-ConnectionGUID: HTVGCfCaSzWGuCFKjpNVJg==
X-CSE-MsgGUID: hUap7SlyQ2aGojyna0zguQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251416"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 14:25:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	zhaochenguang@kylinos.cn,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 6/8] i40e: do not expose netdev too early
Date: Fri, 18 Sep 2026 14:24:53 -0700
Message-ID: <20260918212458.550425-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

i40e_vsi_setup() registers the netdev before rings and q_vectors are fully
allocated and mapped. Once register_netdev() returns, userspace can reach
netdev callbacks such as ndo_open(), so the VSI backing state must already
be ready.

Move register_netdev() to the end of the setup path, after ring/q_vector
allocation, ring mapping and RSS configuration. Keep freeing an allocated
but not registered netdev on the error path.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 29 ++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2b4b061302db..82037faf960f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14449,15 +14449,6 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 				goto err_netdev;
 			SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
 		}
-		ret = register_netdev(vsi->netdev);
-		if (ret)
-			goto err_dl_port;
-		vsi->netdev_registered = true;
-		netif_carrier_off(vsi->netdev);
-#ifdef CONFIG_I40E_DCB
-		/* Setup DCB netlink interface */
-		i40e_dcbnl_setup(vsi);
-#endif /* CONFIG_I40E_DCB */
 		fallthrough;
 	case I40E_VSI_FDIR:
 		/* set up vectors and rings if needed */
@@ -14485,6 +14476,19 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		if (ret)
 			goto err_config;
 	}
+
+	if (vsi->netdev) {
+		ret = register_netdev(vsi->netdev);
+		if (ret)
+			goto err_config;
+		vsi->netdev_registered = true;
+		netif_carrier_off(vsi->netdev);
+#ifdef CONFIG_I40E_DCB
+		/* Setup DCB netlink interface */
+		i40e_dcbnl_setup(vsi);
+#endif /* CONFIG_I40E_DCB */
+	}
+
 	return vsi;
 
 err_config:
@@ -14495,13 +14499,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
 	}
-err_dl_port:
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 err_netdev:
+	if (vsi->netdev) {
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+	}
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
 	i40e_vsi_clear(vsi);
-- 
2.47.1

