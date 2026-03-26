Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3653F99EB;
	Thu, 26 Mar 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525820; cv=none; b=t4jDptid7mIaveUxxjFFHJkht24npAjhPaDyem810yhE5bRoXbGiJR3DFF5wcqz9JwL1NzBl4TSqT2LL6PzjTFF4VSL4CGz5Op/EQZt6EKSOHVW2vKqO5uShRB5M4epYVVwLg7OckxJ4pejyCGgSTWk1KKdeeHczM6rEQetOOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525820; c=relaxed/simple;
	bh=7DzG31ZGhqPkrPLi2IPyde6AgUF12n7Wafc6dg4dgKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJxn5k/i8Zk6pmI7DmkGW9+9GWRSjk2YQlYnKJ+CYDRqSjl30n/0zZ1VX73dHbv8ji8BuDGBuRRQIxsRi8CQu0K+S12GaW7VDyo83igdZlxrNVnIVVn3cw+oZ8in3QD2c8e8VzuYDDj089RQEzdkPtfMdsm0ZQhUnfblN+dPdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzF4KXWE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzF4KXWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525812; x=1806061812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DzG31ZGhqPkrPLi2IPyde6AgUF12n7Wafc6dg4dgKk=;
  b=UzF4KXWE2tC1gpbNfYpiVpxAYrvoc1pTqiKvV1yLonFDVYhZ4slxTBCH
   EJ9jxndCkdolyOsg2Gb5MGtHWMqw4tDWPO5s5T+dWP18I1hdSwmONPebW
   ++vH5BL3AZk82fRmAhTeOH1D6dN4wSrxb6GzwXlpvBTkBA6viGYMc81qp
   CeFJOg4daZpxMeL4wizrP7QxqRVEYXN9oxGnXjaRal8Vu6MvrXHtGPpUr
   04NMyXpbFV4QQT8bQKEQceRrKnrMHKxwm3dUHAO5PT8HYI9SOAJtJVCMo
   33/0cVxNFYf1p6X9tVAeEkG54ze8r1WxUo3SzNH/MmbzV6eo0Y/kx6f3Q
   w==;
X-CSE-ConnectionGUID: 1pIIxkmVQcum6UDVU2vhdw==
X-CSE-MsgGUID: /IseyFuXR4epBu29wJqRaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776286"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:57 -0700
X-CSE-ConnectionGUID: jmEDcq75TleJGkVPD1Su3A==
X-CSE-MsgGUID: vGLBuUVcSy6/7NwrGzD5KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029093"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:54 -0700
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
Subject: [PATCH v4 net 10/11] igc: remove home-grown xsk's frame size validation
Date: Thu, 26 Mar 2026 12:49:18 +0100
Message-Id: <20260326114919.519456-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this check is now present in core in xp_assign_dev(), remove
redundant statement from igc_xdp_enable_pool().

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 9eb47b4beb06..4126173a0226 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -61,23 +61,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 	struct igc_ring *rx_ring, *tx_ring;
 	struct napi_struct *napi;
 	bool needs_reset;
-	u32 frame_size;
 	int err;
 
 	if (queue_id >= adapter->num_rx_queues ||
 	    queue_id >= adapter->num_tx_queues)
 		return -EINVAL;
 
-	frame_size = xsk_pool_get_rx_frame_size(pool);
-	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
-		/* When XDP is enabled, the driver doesn't support frames that
-		 * span over multiple buffers. To avoid that, we check if xsk
-		 * frame size is big enough to fit the max ethernet frame size
-		 * + vlan double tagging.
-		 */
-		return -EOPNOTSUPP;
-	}
-
 	err = xsk_pool_dma_map(pool, dev, IGC_RX_DMA_ATTR);
 	if (err) {
 		netdev_err(ndev, "Failed to map xsk pool\n");
-- 
2.43.0

