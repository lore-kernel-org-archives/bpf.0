Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8248032F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937117; cv=none; b=pCM/vGOiZK2MAAjPxBVrCwzVYwLcFZ+bu/EtVCcE/F5kzluiEsMuEGgVp8czaxf9FPrPVRkMXJVUQJ55/o+vOUm7m0lS+9cb99iAkg9laWdCOPmVyogm9hsYYJ+01tKA5cWYc0D9iAJ46i1JX158FiX3cedfFUJJV/JXQknZtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937117; c=relaxed/simple;
	bh=JiRhnkR9+kKSTc2APTmxf7fqu8y1l1mW6KxRHAOMCow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L7ISz19Iktp93L4dB0JqvTg5GnHM+L1sk+jKS46fd91bn6J085qlBTcWl3t4qLp8FqofY1ujS5uVmBWLvIao556PQSp9rveEVBSuQWMypa/McvDIgGCO/rsYv/TEctDXZzfe68/G786R1EqIlBAvq6TGY7Sk4qivAuA5Z+4l9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E56lrZ0D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E56lrZ0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790937109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UbTwYRHb8DyqJwziSa/wyNcRZN8bf0V0Em3U5wv/Th0=;
	b=E56lrZ0D9Ddlko0icwmfy/m/wVFOsCpN19kEVlmJibkJH/kipAo3xqZboyd3Egvdypyr8v
	7/bb3DNQGwkyxyQv827DwiWwWChAP6pjzjcvXqmfVvT55Z3ASyiqdTQ8x2xSxESCw+qmY3
	SABkydRFY7Kb7a0I5U+uob54B3htOHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-N3yYzrrcMRi4_1DBORVtWA-1; Fri,
 02 Oct 2026 06:31:45 -0400
X-MC-Unique: N3yYzrrcMRi4_1DBORVtWA-1
X-Mimecast-MFC-AGG-ID: N3yYzrrcMRi4_1DBORVtWA_1790937103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92DBC1955D62;
	Fri,  2 Oct 2026 10:31:42 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1114180034F;
	Fri,  2 Oct 2026 10:31:36 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net] ice: keep the VLAN tag of priority-tagged frames with Rx stripping enabled
Date: Fri,  2 Oct 2026 12:31:08 +0200
Message-ID: <20261002103108.2513191-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

With Rx VLAN stripping enabled the hardware also strips tags with VID 0,
but ice_receive_skb() only puts the stripped tag back when the VID is
non-zero. Priority-tagged frames reach the stack as untagged and a vlan0
upper device never sees them, while the same traffic works with rxvlan
disabled.

Hit by our QE VLAN test on an E810-XXV, where ping over vlan0 fails and
tcpdump on the PF shows the peer's priority-tagged ARP requests arriving
untagged. Reproduced on the net tree with a PF and its VF as the peer in
both single and double VLAN mode. i40e had the same bug, fixed by commit
2a508c64ad27 ("i40e: fix VLAN.TCI == 0 RX HW offload").

Put the tag in ice_process_skb_fields() keyed on the L2TAG1P/L2TAG2P
status bits, let ice_get_vlan_tci() report whether a tag was stripped
(this also fixes the XDP VLAN hint for a zero TCI) and drop the now
trivial ice_receive_skb().

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Fixes: 714ed949c6f3 ("ice: Implement VLAN tag hint")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  5 +---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 ++++--------------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 27 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  5 +---
 4 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 31303ab5be175a..3935ac05a251b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -970,7 +970,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		struct sk_buff *skb;
 		unsigned int size;
 		u16 stat_err_bits;
-		u16 vlan_tci;
 		bool rxe;
 
 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
@@ -1051,8 +1050,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			continue;
 		}
 
-		vlan_tci = ice_get_vlan_tci(rx_desc);
-
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
@@ -1061,7 +1058,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 
 		/* update budget accounting */
 		total_rx_pkts++;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d18..19307086c238f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -218,6 +218,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       struct sk_buff *skb)
 {
 	u16 ptype = ice_get_ptype(rx_desc);
+	u16 vlan_tci;
 
 	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
 
@@ -238,29 +239,13 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
 
+	if (rx_ring->vlan_proto && ice_get_vlan_tci(rx_desc, &vlan_tci))
+		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto, vlan_tci);
+
 	if (rx_ring->ptp_rx)
 		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
 }
 
-/**
- * ice_receive_skb - Send a completed packet up the stack
- * @rx_ring: Rx ring in play
- * @skb: packet to send up
- * @vlan_tci: VLAN TCI for packet
- *
- * This function sends the completed packet (via. skb) up the stack using
- * gro receive functions (with/without VLAN tag)
- */
-void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
-{
-	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
-		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
-				       vlan_tci);
-
-	napi_gro_receive(&rx_ring->q_vector->napi, skb);
-}
-
 /**
  * ice_clean_xdp_tx_buf - Free and unmap XDP Tx buffer
  * @dev: device for DMA mapping
@@ -587,8 +572,7 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	if (!*vlan_proto)
 		return -ENODATA;
 
-	*vlan_tci = ice_get_vlan_tci(xdp_ext->desc);
-	if (!*vlan_tci)
+	if (!ice_get_vlan_tci(xdp_ext->desc, vlan_tci))
 		return -ENODATA;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index f17990b68b621d..579ce56c0c3c0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -70,25 +70,32 @@ ice_build_tstamp_desc(u16 tx_desc, u32 tstamp)
 /**
  * ice_get_vlan_tci - get VLAN TCI from Rx flex descriptor
  * @rx_desc: Rx 32b flex descriptor with RXDID=2
+ * @vlan_tci: VLAN TCI stripped by hardware
  *
  * The OS and current PF implementation only support stripping a single VLAN tag
- * at a time, so there should only ever be 0 or 1 tags in the l2tag* fields. If
- * one is found return the tag, else return 0 to mean no VLAN tag was found.
+ * at a time, so there should only ever be 0 or 1 tags in the l2tag* fields.
+ *
+ * Return: true if a VLAN tag was stripped and stored in @vlan_tci, false
+ * otherwise.
  */
-static inline u16
-ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc)
+static inline bool
+ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc, u16 *vlan_tci)
 {
 	u16 stat_err_bits;
 
 	stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_L2TAG1P_S);
-	if (ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
-		return le16_to_cpu(rx_desc->wb.l2tag1);
+	if (ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits)) {
+		*vlan_tci = le16_to_cpu(rx_desc->wb.l2tag1);
+		return true;
+	}
 
 	stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
-	if (ice_test_staterr(rx_desc->wb.status_error1, stat_err_bits))
-		return le16_to_cpu(rx_desc->wb.l2tag2_2nd);
+	if (ice_test_staterr(rx_desc->wb.status_error1, stat_err_bits)) {
+		*vlan_tci = le16_to_cpu(rx_desc->wb.l2tag2_2nd);
+		return true;
+	}
 
-	return 0;
+	return false;
 }
 
 /**
@@ -132,7 +139,5 @@ void
 ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb);
-void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
 
 #endif /* !_ICE_TXRX_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c35a..fd2e628a8bc95c 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -591,7 +591,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		struct xdp_buff *xdp;
 		struct sk_buff *skb;
 		u16 stat_err_bits;
-		u16 vlan_tci;
 
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
@@ -667,10 +666,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
-		vlan_tci = ice_get_vlan_tci(rx_desc);
-
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
 	rx_ring->next_to_clean = ntc;
-- 
2.55.0

