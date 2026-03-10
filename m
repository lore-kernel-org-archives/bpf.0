Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30A3F167D;
	Tue, 10 Mar 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180407; cv=none; b=s2L3c0pxh4LY2NVvOJGd0GFEvg3TjwsIvhNL7KMtjcT7qpstMJuEPC59la4LzVU6T+7cYcI/TcSPT0WN2tWUrvDXXUfvCZryWDptEJHFDhDjYVGB0uX5TNL3cnjx3euRfNfWg6xCucsVXTZtcJv62FVKWbJtS0C5enTdd6ot2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180407; c=relaxed/simple;
	bh=6bTjoVf93vpaN+5d3y+2SomvL/7mz6GeJJvVeeyB4rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqOuSc9Y+B4ZUf5Ivr1AXttWEcm1aCkdGWKC6ONOo/Xf8x2oY/gncmS+5jbtcEJKqGJhWApWZt0Zdh2Mums+jmaS/fJHCPWNMrhhhTmXzPZlp8dCeX5afw34I9PA2/75Y7ckq45Pix2VMAyKwxmqyZFMPRVbc744MYZMaClT0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFqyv61+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFqyv61+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180400; x=1804716400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6bTjoVf93vpaN+5d3y+2SomvL/7mz6GeJJvVeeyB4rA=;
  b=ZFqyv61+LjJaS/tCXnRKAsACKHu8mWv6u2pnwFKo3P0DkBLVmUegkmns
   IDZGDn2qHF71fTghqV68lmaaFBGB4ZmRacc5ySPXbu1DgaOA1nBv0UvUn
   uIcA+B1SySAjsnvdNwPhGpvA3wCW2DEiFo84BbUrZHmSEx2CQXvFcylDG
   B66dMcwRktNMRDwsblnkvBBq0N8YwB5yGBZkrxn1Bme39x4g4Be7G29y6
   ltvACYtn95PyUCJWy25S5q4y4uqMKPQ+v5wXJzm2Wp5nHS3Yng7m1PHYf
   6ZA7w/fq5aEIqji+VVLXRCguTYYTFWbUykkWRG3Mw3zP6D8Cd9c5Zzdui
   w==;
X-CSE-ConnectionGUID: S2mAlsN+RqqD87tdvCj7kg==
X-CSE-MsgGUID: HzNRzGp8ScaYEICicHDRtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74156376"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74156376"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:06:29 -0700
X-CSE-ConnectionGUID: pUFGHEZZQ9ernXvYw4wKzg==
X-CSE-MsgGUID: HTXByI8FSU6Ky31XvDcO4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220298608"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 15:06:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 5/5] ice: add support for transmitting unreadable frags
Date: Tue, 10 Mar 2026 15:06:22 -0700
Message-ID: <20260310220624.537917-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310220624.537917-1-anthony.l.nguyen@intel.com>
References: <20260310220624.537917-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Advertise netmem Tx support in ice. The only change needed is to set
ICE_TX_BUF_FRAG conditionally, only when skb_frag_is_net_iov() is
false. Otherwise, the Tx buffer type will be ICE_TX_BUF_EMPTY and
the driver will skip the DMA unmapping operation.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 17 +++++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 489718c6f7fe..10d2f9f8472b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3525,6 +3525,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->netdev_ops = &ice_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index bd5eeb27d3f8..f3ac5dfabc0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -59,6 +59,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 59b2ab09b87a..3008745c2b39 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -113,11 +113,17 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 static void
 ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 {
-	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
+	switch (tx_buf->type) {
+	case ICE_TX_BUF_DUMMY:
+	case ICE_TX_BUF_FRAG:
+	case ICE_TX_BUF_SKB:
+	case ICE_TX_BUF_XDP_XMIT:
 		dma_unmap_page(ring->dev,
 			       dma_unmap_addr(tx_buf, dma),
 			       dma_unmap_len(tx_buf, len),
 			       DMA_TO_DEVICE);
+		break;
+	}
 
 	switch (tx_buf->type) {
 	case ICE_TX_BUF_DUMMY:
@@ -337,12 +343,14 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buf, len)) {
+			if (tx_buf->type != ICE_TX_BUF_EMPTY) {
 				dma_unmap_page(tx_ring->dev,
 					       dma_unmap_addr(tx_buf, dma),
 					       dma_unmap_len(tx_buf, len),
 					       DMA_TO_DEVICE);
+
 				dma_unmap_len_set(tx_buf, len, 0);
+				tx_buf->type = ICE_TX_BUF_EMPTY;
 			}
 		}
 		ice_trace(clean_tx_irq_unmap_eop, tx_ring, tx_desc, tx_buf);
@@ -1494,7 +1502,8 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 				       DMA_TO_DEVICE);
 
 		tx_buf = &tx_ring->tx_buf[i];
-		tx_buf->type = ICE_TX_BUF_FRAG;
+		if (!skb_frag_is_net_iov(frag))
+			tx_buf->type = ICE_TX_BUF_FRAG;
 	}
 
 	/* record SW timestamp if HW timestamp is not available */
@@ -2366,7 +2375,7 @@ void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring)
 		}
 
 		/* unmap the data header */
-		if (dma_unmap_len(tx_buf, len))
+		if (tx_buf->type != ICE_TX_BUF_EMPTY)
 			dma_unmap_single(tx_ring->dev,
 					 dma_unmap_addr(tx_buf, dma),
 					 dma_unmap_len(tx_buf, len),
-- 
2.47.1

