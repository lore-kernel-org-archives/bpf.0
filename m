Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32533B955;
	Mon, 16 Mar 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683199; cv=none; b=rOBKYFMzYBfPVHn1Ma4q60yu3+eOVsNmF34ON2rYCv8JyQShvU7BX8cXsAIdAYrOdgfk9kiSjNOPIrC9bD7rIfDXbbok6nKCTWFhQz3rZbmooM9GXMw+tB4BflNodYktDmuY5EaVx8+7n5iEFvbXmLDTc6GhRdLTH/joBr/Ir7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683199; c=relaxed/simple;
	bh=CFJ+KEscHOBYqh9n0gxRKqmEsJM8VHC9VyqKl44WiBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHlRnDyHst8rhcGwHBscsYSBeqP1uzWICxOOiMEir+hvQYyyL0ZIT+0IhouDOtOgvN/LZPu+nczkhPI/SeP0c2/p2EM1B60pzJ7FMuBlzoKzz94QywpyAWLt+8CWh14kiWXwQjGDERvBsaJ2Ku4F6HAOdIQez+DReDlMlqdSWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0g1tzRW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0g1tzRW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683198; x=1805219198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CFJ+KEscHOBYqh9n0gxRKqmEsJM8VHC9VyqKl44WiBk=;
  b=Y0g1tzRWoMIaW5M0UpQQoCddeV5oGOKrUFJwYo3yiNG4/PggD5TkYmU3
   Kbmy7kNCnm9eNJ9Ddi9+HyUYSTDiWCMGkqgskQO/nZDSTfccV9SwDa/hH
   QOu10+s/74jeG0pJXp2Gh0A+ujgsPJIVgHHWT/f44ZbfG2w/5TC0zNcco
   aCK+Ppzc4SdZ2O8KEbU7jEVHJCNTH/btXV9FKmOSO16XDm3Z2eu1G+YwG
   eaz7kkiqTf4h2VOxoLC3suQfaUFPRAMf25Eqq/1F7ujiXo5prPazlisjb
   w79231RnENtldZ2ucxFVRkyYJeHuH2+Fik0nAlN3aX9h2JedafNVm4wkP
   w==;
X-CSE-ConnectionGUID: EWOtaG+9SSych+ZBLeAtIQ==
X-CSE-MsgGUID: NUJKM7ttSziypP8ArKSxXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275701"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275701"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:37 -0700
X-CSE-ConnectionGUID: JG4DILBmTlaL32J+H0TxHg==
X-CSE-MsgGUID: X9/gUArLS0S+bUZwijx3pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075730"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:34 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 2/6] ice: do not round up result of dbuff calculation for xsk pool
Date: Mon, 16 Mar 2026 18:45:46 +0100
Message-Id: <20260316174550.462177-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When programming dbuff on rx queue context, avoid division round up as
it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
example based on 4k chunk size when xsk pool pointer is valid on given
rx ring:

chunk_size = 4096
headroom = 256
tailroom = 320

ring->rx_buf_len = 4096 - 256 - 320 = 3520

rx_ctx.dbuff = DIV_ROUND_UP(3520, 128) ->
3520 / 128 = 27.5 -> round up results in 28

dbuff programming unit is 128. If we give 128 * 28 = 3584. So HW will
corrupt 64 bytes from tailroom. Doing plain division will floor the
result and would not exceed reserved space at the end.

Also, restore ::rx_buf_len setting via xsk_pool_get_rx_frame_size() as
of now it respects the tailroom.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..930688bd3476 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -498,8 +498,11 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
-				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
+	if (ring->xsk_pool)
+		rlan_ctx.dbuf = ring->rx_buf_len / BIT_ULL(ICE_RLAN_CTX_DBUF_S);
+	else
+		rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+					     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
@@ -673,6 +676,9 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		if (ring->xsk_pool) {
 			u32 frag_size =
 				xsk_pool_get_rx_frag_step(ring->xsk_pool);
+
+			ring->rx_buf_len =
+				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-- 
2.43.0

