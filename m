Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D912CDA5;
	Mon, 17 Aug 2026 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937321; cv=none; b=SIUazXBAgkaar1eALpEes+25JsfSceM0FpnDHDTBCKRNZyPY26/7MxTOMA6wtJDWSIffxmGPguvMhWUnas7kd30ZKq8ehWF+XsWTNxMyiXySIAtcTpxFIixZwLCE4Pa8MW+XktMwC5HMi9tYZy+j25Cid7orWh6t6+KLFuuphGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937321; c=relaxed/simple;
	bh=jEBjjJIc1ZY7cDKCPvjJ/aKII2VVtQvW2mewOqnkpGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZLsP7kLmmtrMLZT09rZkjBnUO2XogcvasuatqGz7VrE5NYsiArEexCn+/oXWe6KQARzNsmauD5f02OIVpjaA13dqalww15iVCyWFgZkP/7oNjS7RX2mmjLm8ePe7m/fmRv/eTemipjtHmaVADhWBXYrmRIwJuPPhCg/AjoKhvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N6FfcetO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N6FfcetO"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H1Y7KM1095248;
	Sun, 16 Aug 2026 20:27:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lXolXiTlDQtcd+FaZViV6vO
	kGJJJX6vnH6s9WIwposc=; b=N6FfcetOT2GfQFaJsvws6nTl7ga3b2N855Yc6Ne
	J8bCcZO2fv2niW8lKlqzaAvs8Im7YGOVINIyi2jXIyAMcGMG/GR7YFtglAys3cZM
	KtDXBdKfLmlXCoIynzoIqYCvOTnXyUNLKADVjrKGgagYPvip2G4f/G7MC5BZYPKI
	oCeI1lYP0tpT1k+zBIt7G+3aFZip1uzKx5AU8UJ2EgfQjHYU6nCC2f/SpQRp5Q9r
	PbRSrjTs7AVe6PIstYXwjHOxclCVTyfUN+4YVOuKtgdbgbRwi3sIx0cryLsjx//f
	pLsxptqS12jsQAOaZ+7O9+WzjxkPymcZHhbwF3hkg68FLmQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g2nfku52g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Aug 2026 20:27:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 16 Aug 2026 20:27:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 16 Aug 2026 20:27:55 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2CF6E3F7080;
	Sun, 16 Aug 2026 20:27:49 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Mon, 17 Aug 2026 08:57:47 +0530
Message-ID: <20260817032747.1765883-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNCBTYWx0ZWRfX1ZH9fy6pYtKZ
 JjQ3kBf/q+H5VlsfBDDczY8lLZByebZsuXcD2Dyup33W3ThjTIjLHKVjgHbWj95MlYZ/OR4k/bw
 3yHT7hbdH3mtBMb2BQmsOEPY2J6mv5ynyXIOV35Ss+g20qrdXCDLsFa1r/pG7wf2p411vqNjqQB
 M5vmq5QmVZgDSB93cgUULisizhYcAdjaDjKPHWL+vuiuOdFtC1BwfE7WnfjF0LKPA1E5YkN2wCW
 F4nYw3m9NXv6FzPddlK7ytMtbbeLAMPET+JSNtHvicv1eMobAG/b+9tdraFY0T16IollNBqKFCO
 42KpzsQ5pHqft7U/x13p1e8Cx/C9rQtWttbS1PT1kb+/ueXRu7wm2losuAyLn+DLE7kNgjExiCv
 L/3wlBa+nLv8+fOkH7VNfJq8l+6hEiAT3i3DhZgDsCz7A18h4q40JWc10Gb8/rLtZ4sl4IYwjao
 aC6rDbpfJCUGNZwDxTw==
X-Proofpoint-ORIG-GUID: 416ajX1ioD7IphV-NR-4BUTKT0ukbP7Q
X-Proofpoint-GUID: 416ajX1ioD7IphV-NR-4BUTKT0ukbP7Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNCBTYWx0ZWRfXwcwW5AlJHU+P
 u1mB+hXhEoZkXIkthVYX1OxkStV4jH4d85nw+l42MmRVMA3PsLhC+YnZm/8SfHzqnoL1J3kz//e
 Cyc8G0s9aGNo1vl4bi5E/kpSXHUqr4w=
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a827fbc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=Vk650Z6Kb_TtDR3AB1EA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01

Add TC_SETUP_QDISC_MQPRIO handling for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE. Offload programs per-transmit-queue MDQ
CIR/PIR shapers on non-QoS queues (hw.non_qos_queues). When enabled,
allocate one SMQ per such queue, parent every MDQ under TL4[0], and
apply each traffic class min/max rate to the queue(s) in that class.

Rates are only supported when a traffic class maps to a single queue;
multi-queue classes with min or max rates are rejected because the
driver shapes at MDQ granularity and cannot enforce a shared TC cap
without per-TC TL4 shapers. TC-to-queue mapping without rates is
still allowed for multi-queue classes. Advertise
TC_QUERY_CAPS.validate_queue_counts so the core mqprio code validates
queue layout before offload.

Setup and teardown that change the scheduler hierarchy restart the
netdev via ndo_stop()/ndo_open(). That drops carrier, tears down
IRQ/NAPI, and discards in-flight traffic. Offload setup requires the
interface to already be running. If ndo_open() fails after restart,
the interface is left administratively down.

Reject incompatible configurations: HTB, PFC, XDP, SDP representors, and
hardware without CIR+PIR support (QOS_CIR_PIR_SUPPORT). Reject rates
outside the NIX TLX encoder range (~2 Mbps to ~130 Gbps). Block
ethtool channel changes while offload is active.

Track offload state in pfvf->mqprio.rate_limit instead of pfvf->flags
to avoid races with the mbox up-handler. Handle tc qdisc replace via
TC_ROOT_GRAFT: skip teardown of the replaced qdisc after the new
configuration is programmed. Clear all MDQ shapers before applying a
new mapping so queues removed from the TC layout do not keep stale
limits. Cache per-queue rates and restore them across routine netdev
stop/open in otx2_mqprio_up().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v8 -> v9: Addressed Sashiko comments
	https://lore.kernel.org/netdev/aoJ6FhtWue0FHDQV@rkannoth-OptiPlex-7090/

v7 -> v8: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260811085050.3212280-1-rkannoth%40marvell.com
v6 -> v7: Addressed Sashiko comments
	https://sashiko.dev/#/message/20260810034738.1786029-1-rkannoth%40marvell.com
v5 -> v6: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260806095434.1144397-1-rkannoth@marvell.com/
v4 -> v5: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260803042724.3380209-1-rkannoth%40marvell.com
v3 -> v4: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260729105139.2302908-1-rkannoth@marvell.com/
v2 -> v3: Addressed sashiko comments
	https://lore.kernel.org/netdev/amnYX866mYx02cBe@rkannoth-OptiPlex-7090/T/#m67310cbec48b21c7720858ab3a1ea083a0f8dc10
v1 -> v2: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260724075010.2665758-1-rkannoth@marvell.com/
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 154 ++++-
 .../marvell/octeontx2/nic/otx2_common.h       |  16 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 604 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  15 +
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |   1 +
 9 files changed, 825 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index b81c47ea023b..22f64c1ede91 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -331,8 +331,12 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 			return true;
 	}
 
-	if (map_func != pcifunc)
+	if (map_func != pcifunc) {
+		dev_err_ratelimited(rvu->dev,
+				    "pcifunc %x map pcifunc %x not equal, lvl=%u schq=%u\n",
+				    pcifunc, map_func, lvl, schq);
 		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index ca73a94db794..dc94b1947ba2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -614,6 +614,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)
 }
 EXPORT_SYMBOL(otx2_get_mac_from_af);
 
+static int
+otx2_nix_tmq_reg_write(struct otx2_nic *pfvf, int cnt,
+		       u64 reg_addr[MAX_REGS_PER_MBOX_MSG],
+		       u64 reg_val[MAX_REGS_PER_MBOX_MSG])
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *req;
+	int i, err;
+
+	mutex_lock(&mbox->lock);
+	req = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return -ENOMEM;
+	}
+
+	req->lvl = NIX_TXSCH_LVL_MDQ;
+	req->num_regs = cnt;
+
+	for (i = 0; i < cnt; i++) {
+		req->reg[i] = reg_addr[i];
+		req->regval[i] = reg_val[i];
+	}
+
+	err = otx2_sync_mbox_msg(mbox);
+	mutex_unlock(&mbox->lock);
+
+	return err;
+}
+
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf)
+{
+	u64 reg_addr[MAX_REGS_PER_MBOX_MSG];
+	u64 reg_val[MAX_REGS_PER_MBOX_MSG];
+	int err, smq, i, cnt = 0;
+
+	for (i = 0; i < pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]; i++) {
+		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][i];
+
+		reg_addr[cnt] = NIX_AF_MDQX_PIR(smq);
+		reg_val[cnt] = 0;
+		cnt++;
+
+		reg_addr[cnt] = NIX_AF_MDQX_CIR(smq);
+		reg_val[cnt] = 0;
+		cnt++;
+
+		if (cnt < MAX_REGS_PER_MBOX_MSG - 1)
+			continue;
+
+		err = otx2_nix_tmq_reg_write(pfvf, cnt,
+					     reg_addr, reg_val);
+		if (err)
+			goto fail;
+		cnt = 0;
+	}
+
+	if (cnt) {
+		err = otx2_nix_tmq_reg_write(pfvf, cnt,
+					     reg_addr, reg_val);
+		if (err)
+			goto fail;
+	}
+
+	return 0;
+fail:
+	return err;
+}
+
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf,
+				 int txq, u64 minrate, u64 maxrate)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *req;
+	int err, smq, n = 0;
+	u64 reg_addr[2];
+	u64 reg_val[2];
+	u64 rate;
+
+	if (!maxrate && !minrate) {
+		smq = otx2_get_smq_idx(pfvf, txq);
+		reg_addr[0] = NIX_AF_MDQX_PIR(smq);
+		reg_val[0] = 0;
+		reg_addr[1] = NIX_AF_MDQX_CIR(smq);
+		reg_val[1] = 0;
+		return otx2_nix_tmq_reg_write(pfvf, 2, reg_addr, reg_val);
+	}
+
+	smq = otx2_get_smq_idx(pfvf, txq);
+
+	mutex_lock(&mbox->lock);
+	req = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return -ENOMEM;
+	}
+
+	req->lvl = NIX_TXSCH_LVL_MDQ;
+
+	/* MQPRIO exposes only min/max rate, not burst.  Pass burst 0 so
+	 * otx2_get_egress_burst_cfg() programmes the largest burst the NIX
+	 * encoding supports (CN10K_MAX_BURST_SIZE on CN10K).  This differs
+	 * from the 65536 byte default used in the HTB path, which is a
+	 * kernel-side default when no explicit burst is configured, not a
+	 * hardware cap.
+	 *
+	 * mqprio setup restarts the netdev (otx2_mqprio_restart_netdev),
+	 * which resets MDQ shapers to zero.  Program both PIR and CIR on
+	 * every update so omitted rates are applied explicitly rather than
+	 * relying on stale hardware state.
+	 */
+	req->reg[n] = NIX_AF_MDQX_PIR(smq);
+	if (maxrate) {
+		rate = otx2_convert_rate(maxrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
+	} else {
+		req->regval[n] = 0;
+	}
+	n++;
+
+	/* CIR+PIR support is required and checked at mqprio setup. */
+	req->reg[n] = NIX_AF_MDQX_CIR(smq);
+	if (minrate) {
+		rate = otx2_convert_rate(minrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
+	} else {
+		req->regval[n] = 0;
+	}
+	n++;
+	req->num_regs = n;
+
+	err = otx2_sync_mbox_msg(mbox);
+	mutex_unlock(&mbox->lock);
+	return err;
+}
+
 int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for_pfc)
 {
 	u16 (*schq_list)[MAX_TXSCHQ_PER_FUNC];
@@ -650,7 +786,20 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 						(u64)hw->smq_link_type);
 		req->num_regs++;
 		/* MDQ config */
-		parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
+		if (pfvf->mqprio.rate_limit) {
+			/* TODO: Not an mqprio bug - stale TL4 topology is left when
+			 * HTB is torn down without clearing NIX_AF_TL4X_TOPOLOGY;
+			 * the AF does not reset it on schq realloc. MQPRIO parents
+			 * every MDQ under TL4[0] with schedule priority 0, so a
+			 * reused TL4 can retain HTB RR_PRIO/PRIO_ANCHOR and starve
+			 * some TX queues until topology is reprogrammed here or HTB
+			 * teardown is fixed to restore defaults.
+			 */
+			parent = schq_list[NIX_TXSCH_LVL_TL4][0];
+		} else {
+			parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
+		}
+
 		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
 		req->regval[1] = parent << 16;
 		req->num_regs++;
@@ -778,6 +927,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
 	}
 
+	if (pfvf->mqprio.rate_limit)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..67d4aae9440f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -483,6 +483,13 @@ struct pf_irq_data {
 	int mdevs;
 };
 
+struct otx2_mqprio {
+	u32	flags;
+	u64	*min_rate;
+	u64	*max_rate;
+	bool	rate_limit;
+};
+
 struct otx2_nic {
 	void __iomem		*reg_base;
 	struct net_device	*netdev;
@@ -515,6 +522,10 @@ struct otx2_nic {
 	u64			flags;
 	u64			*cq_op_addr;
 
+	struct otx2_mqprio	mqprio;
+	bool			mqprio_replace_pending;
+	bool			mqprio_skip_teardown;
+
 	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
@@ -1246,6 +1257,11 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf, int txq,
+				 u64 minrate, u64 maxrate);
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf);
+int otx2_mqprio_down(struct otx2_nic *pfvf);
+int otx2_mqprio_up(struct otx2_nic *pfvf);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
 int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index f110dfa42360..4a70abc230be 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -413,6 +413,12 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 	u8 old_pfc_en;
 	int err;
 
+	if (pfvf->mqprio.rate_limit && pfc->pfc_en) {
+		netdev_err(dev,
+			   "PFC: cannot enable while mqprio bandwidth offload is active\n");
+		return -EOPNOTSUPP;
+	}
+
 	old_pfc_en = pfvf->pfc_en;
 	pfvf->pfc_en = pfc->pfc_en;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a0340f3422bf..837d29024981 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -287,6 +287,14 @@ static int otx2_set_channels(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (pfvf->mqprio.rate_limit &&
+	    (channel->tx_count != pfvf->hw.tx_queues ||
+	     channel->rx_count != pfvf->hw.rx_queues)) {
+		netdev_info(dev,
+			    "Not permitted to change channel count while MQ prio is active\n");
+		return -EINVAL;
+	}
+
 	if (if_up)
 		dev->netdev_ops->ndo_stop(dev);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..06cb44e7263c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1980,6 +1980,16 @@ int otx2_open(struct net_device *netdev)
 	if (err)
 		goto err_free_mem;
 
+	/* TODO: otx2_mqprio_up() failure here aborts the entire ndo_open()
+	 * path even though mqprio_rate_limit and the rate cache remain set.
+	 * Routine ip link set up or driver reset with active mqprio offload
+	 * can leave the interface stuck down until the qdisc is removed and
+	 * reapplied.
+	 */
+	err = otx2_mqprio_up(pf);
+	if (err)
+		goto err_free_hw;
+
 	/* Register NAPI handler */
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
@@ -2140,6 +2150,7 @@ int otx2_open(struct net_device *netdev)
 	free_irq(vec, pf);
 err_disable_napi:
 	otx2_disable_napi(pf);
+err_free_hw:
 	otx2_free_hw_resources(pf);
 err_free_mem:
 	otx2_free_queue_mem(qset);
@@ -2846,6 +2857,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
 	bool if_up = netif_running(pf->netdev);
 	struct bpf_prog *old_prog;
 
+	if (prog && pf->mqprio.rate_limit) {
+		netdev_err(dev,
+			   "XDP: cannot attach while mqprio bandwidth offload is active\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (prog && dev->mtu > MAX_XDP_MTU) {
 		netdev_warn(dev, "Jumbo frames not yet supported with XDP\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 039fd47ebf52..2d0174b374cc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -16,6 +16,8 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/ipv6.h>
+#include <net/pkt_sched.h>
+#include <net/sch_generic.h>
 
 #include "cn10k.h"
 #include "otx2_common.h"
@@ -31,6 +33,10 @@
 
 #define MCAST_INVALID_GRP		(-1U)
 #define RATE_MANTISSA_BITS		8
+/* Min per-queue egress shaping rate the NIX TLX encoder supports (2 Mbps). */
+#define OTX2_MQPRIO_MIN_RATE_BYTES_PS	250000ULL
+/* Max egress shaping rate the NIX TLX encoder supports (130816 Mbps). */
+#define OTX2_MQPRIO_MAX_RATE_BYTES_PS	((MAX_BURST_SIZE * 1000000ULL) / 8ULL)
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
@@ -61,6 +67,9 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 			*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
 		}
 	} else {
+		/* burst 0: largest encodable burst (CN10K_MAX_BURST_SIZE on
+		 * CN10K), not a minimal burst.
+		 */
 		*burst_exp = MAX_BURST_EXPONENT;
 		*burst_mantissa = max_mantissa;
 	}
@@ -1600,14 +1609,609 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 					  nic, nic, ingress);
 }
 
+/* Free the per-queue min/max rate caches. */
+static void otx2_mqprio_free_cache(struct otx2_nic *pfvf)
+{
+	devm_kfree(pfvf->dev, pfvf->mqprio.min_rate);
+	devm_kfree(pfvf->dev, pfvf->mqprio.max_rate);
+	pfvf->mqprio.min_rate = NULL;
+	pfvf->mqprio.max_rate = NULL;
+	pfvf->mqprio.flags = 0;
+}
+
+static int otx2_mqprio_alloc_cache(struct otx2_nic *pfvf)
+{
+	u16 num_txq = pfvf->hw.non_qos_queues;
+
+	/* TODO: otx2_mqprio_free_cache() here drops the committed rate cache
+	 * on tc qdisc replace before the new mapping is complete. Stage the
+	 * incoming rates separately and commit only after replace succeeds so
+	 * a failure after netdev restart can roll back from the prior cache.
+	 */
+	otx2_mqprio_free_cache(pfvf);
+
+	pfvf->mqprio.min_rate = devm_kcalloc(pfvf->dev, num_txq,
+					     sizeof(*pfvf->mqprio.min_rate),
+					     GFP_KERNEL);
+	pfvf->mqprio.max_rate = devm_kcalloc(pfvf->dev, num_txq,
+					     sizeof(*pfvf->mqprio.max_rate),
+					     GFP_KERNEL);
+	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate) {
+		otx2_mqprio_free_cache(pfvf);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static bool otx2_mqprio_mdq_allocated(struct otx2_nic *pfvf)
+{
+	return pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_MDQ] != 0;
+}
+
+static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+
+	pfvf->mqprio.rate_limit = false;
+	pfvf->mqprio_replace_pending = false;
+	pfvf->mqprio_skip_teardown = false;
+	netdev_set_num_tc(netdev, 0);
+	otx2_mqprio_free_cache(pfvf);
+}
+
+/* Tear down mqprio bandwidth offload: clear per-queue shapers,
+ * mqprio_rate_limit, netdev TC mappings, and the cached rates.  Called on
+ * explicit mqprio teardown (tc qdisc del) and error cleanup, not on
+ * routine netdev stop/open cycles where the offload stays active.
+ */
+int otx2_mqprio_down(struct otx2_nic *pfvf)
+{
+	int err = 0;
+
+	if (!pfvf->mqprio.rate_limit)
+		return 0;
+
+	if (netif_running(pfvf->netdev) &&
+	    otx2_mqprio_mdq_allocated(pfvf))
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+
+	if (err)
+		netdev_err(pfvf->netdev,
+			   "mqprio: failed to clear hardware shapers: %d; some TX queues may retain bandwidth limits\n",
+			   err);
+
+	/* TODO: mqprio_down() clears mqprio_rate_limit, netdev TC mappings,
+	 * and the rate cache even when otx2_nix_tm_clear_queue_shaper() fails
+	 * partway through the MDQ batch. Software then reports offload as
+	 * inactive while some queues may retain programmed CIR/PIR, so a later
+	 * mqprio_up() or re-setup can shape with the wrong effective rates.
+	 */
+	otx2_mqprio_clear_sw(pfvf);
+
+	return err;
+}
+
+int otx2_mqprio_up(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+	int txq, err;
+
+	if (!pfvf->mqprio.rate_limit)
+		return 0;
+
+	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate)
+		return 0;
+
+	for (txq = 0; txq < pfvf->hw.non_qos_queues; txq++) {
+		u64 min_rate = 0, max_rate = 0;
+
+		if (pfvf->mqprio.flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = pfvf->mqprio.min_rate[txq];
+		if (pfvf->mqprio.flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = pfvf->mqprio.max_rate[txq];
+
+		if (!min_rate && !max_rate)
+			continue;
+
+		err = otx2_nix_tm_set_queue_shaper(pfvf, txq, min_rate,
+						   max_rate);
+		if (err) {
+			netdev_err(netdev,
+				   "mqprio: failed to restore shaper for txq %d: %d\n",
+				   txq, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/* Restart the netdev to reprogram the TX scheduler hierarchy for mqprio
+ * bandwidth offload.  Both mqprio add and delete (when offload was active)
+ * take this path via ndo_stop()/ndo_open() so VF-specific open logic (e.g.
+ * LBK carrier on) runs correctly.  The full stop/open cycle clears
+ * carrier, stops all TX queues, tears down IRQs/NAPI and drops in-flight
+ * traffic.  If open fails, the interface is left administratively down
+ * without calling ndo_stop() again on resources already torn down by
+ * the open error path.
+ *
+ * Do not call dev_deactivate()/dev_activate() here: this runs from
+ * ndo_setup_tc() while qdisc_graft() may already hold the device
+ * deactivated and must perform the final dev_activate().
+ */
+static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	int err;
+
+	/* TODO: Explore live TX scheduler reprogramming to avoid a full
+	 * ndo_stop()/ndo_open() bounce on every mqprio change.
+	 */
+	netdev_info(netdev,
+		    "mqprio: restarting interface to reprogram TX scheduler; in-flight traffic will be dropped\n");
+
+	err = ops->ndo_stop(netdev);
+	if (err)
+		return err;
+
+	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation. */
+	if (rate_limit)
+		pfvf->mqprio.rate_limit = true;
+
+	err = ops->ndo_open(netdev);
+	if (err) {
+		int down_err;
+
+		netdev_err(netdev,
+			   "Failed to restart device after mqprio change: %d\n",
+			   err);
+		down_err = otx2_mqprio_down(pfvf);
+		if (down_err)
+			netdev_err(netdev,
+				   "mqprio: failed to clear shapers after restart error: %d\n",
+				   down_err);
+		/* ndo_open() rolls back on failure; mark the interface down so
+		 * netif_close() does not invoke ndo_stop() on freed NAPI/queue
+		 * state. Caller holds RTNL; dev_close() would deadlock.
+		 */
+		pfvf->flags |= OTX2_FLAG_INTF_DOWN;
+		/* visible to otx2_stop() on other cpus */
+		smp_wmb();
+		netif_close(netdev);
+	}
+
+	return err;
+}
+
+static int otx2_mqprio_validate_tc_rate(struct net_device *netdev,
+					struct netlink_ext_ack *extack,
+					u64 rate, u32 qcount, int tc,
+					const char *name)
+{
+	if (!rate)
+		return 0;
+
+	if (qcount <= 1)
+		return 0;
+
+	/* TODO: mqprio min_rate/max_rate are per traffic class, but bandwidth
+	 * offload shapes on per-queue MDQ nodes parented under a single TL4.
+	 * Without per-TC TL4 shapers the driver cannot honor TC-level limits
+	 * for a traffic class that spans multiple queues without either
+	 * dividing the rate across queues (uAPI mismatch) or exceeding the TC
+	 * cap when every member queue is active. Reject until per-TC TL4
+	 * shaping can be implemented without allocating additional TL4 nodes
+	 * beyond the existing hierarchy.
+	 */
+	netdev_err(netdev,
+		   "mqprio: %s rate for tc %d not supported with %u queues\n",
+		   name, tc, qcount);
+	NL_SET_ERR_MSG_FMT_MOD(extack,
+			       "mqprio: %s rate for tc %d not supported with %u queues",
+			       name, tc, qcount);
+	return -EOPNOTSUPP;
+}
+
+static int otx2_mqprio_validate_txqs(struct net_device *netdev,
+				     struct netlink_ext_ack *extack,
+				     struct tc_mqprio_qopt *qopt)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	u16 num_txq = pfvf->hw.non_qos_queues;
+	int tc, txq;
+
+	if (qopt->num_tc > num_txq) {
+		netdev_err(netdev, "Number of TCs (%u) exceeds hw queues %u\n",
+			   qopt->num_tc, num_txq);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Number of TCs (%u) exceeds hw queues %u",
+				       qopt->num_tc, num_txq);
+		return -EINVAL;
+	}
+
+	if (num_txq > MAX_TXSCHQ_PER_FUNC) {
+		netdev_err(netdev,
+			   "Number of queues (%u) exceeds max scheduler queues %u\n",
+			   num_txq, MAX_TXSCHQ_PER_FUNC);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Number of queues (%u) exceeds max scheduler queues %u",
+				       num_txq, MAX_TXSCHQ_PER_FUNC);
+		return -EINVAL;
+	}
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u32 qcount = qopt->count[tc];
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qcount; txq++) {
+			if (txq >= num_txq) {
+				netdev_err(netdev,
+					   "mqprio: txq %d exceeds offload queue count %u\n",
+					   txq, num_txq);
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: txq %d exceeds offload queue count %u",
+						       txq, num_txq);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static bool otx2_mqprio_rate_valid(u64 rate_bytes_ps)
+{
+	u64 mbps;
+
+	if (!rate_bytes_ps)
+		return true;
+
+	if (rate_bytes_ps < OTX2_MQPRIO_MIN_RATE_BYTES_PS)
+		return false;
+
+	if (rate_bytes_ps > OTX2_MQPRIO_MAX_RATE_BYTES_PS)
+		return false;
+
+	if (rate_bytes_ps > div_u64(U64_MAX, 8))
+		return false;
+
+	mbps = otx2_convert_rate(rate_bytes_ps);
+	return ilog2(mbps / 2) <= MAX_RATE_EXPONENT;
+}
+
+static void otx2_mqprio_pre_graft_reject_msg(struct net_device *netdev)
+{
+	/* TODO: mqprio offload setup may complete in ndo_setup_tc() before
+	 * qdisc_create() rejects the request (for example TCA_RATE on a
+	 * TCQ_F_MQROOT qdisc). Roll back the programmed MDQ shapers, netdev
+	 * TC mapping, rate cache, and mqprio.rate_limit to the prior grafted
+	 * configuration instead of leaving the rejected values active while the
+	 * old mqprio remains root.
+	 */
+	netdev_err(netdev,
+		   "mqprio: rejected before graft; programmed shapers and TC mapping remain active while prior mqprio is still root\n");
+}
+
+static void otx2_mqprio_replace_failed_msg(struct net_device *netdev,
+					   struct netlink_ext_ack *extack)
+{
+	/* TODO: On failed tc qdisc replace restore the prior rate cache,
+	 * netdev TC mapping, and hardware shapers from a snapshot taken before
+	 * reprogramming instead of leaving the new offload values active while
+	 * the previous mqprio remains the grafted root qdisc.
+	 */
+	netdev_err(netdev,
+		   "mqprio: replace failed; new offload values active, old mqprio still root\n");
+	if (extack)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: replace failed; new offload values active, old mqprio still root");
+}
+
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	bool had_mqprio = pfvf->mqprio.rate_limit;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+
+	qopt->hw = 0;
+
+	/* tc qdisc replace grafts the new mqprio before destroying the old
+	 * one. mqprio_skip_teardown is armed from TC_ROOT_GRAFT so teardown
+	 * from the replaced qdisc is ignored after the new configuration has
+	 * reprogrammed hardware and set mqprio_rate_limit.
+	 */
+	if (pfvf->mqprio_skip_teardown) {
+		pfvf->mqprio_skip_teardown = false;
+		pfvf->mqprio_replace_pending = false;
+		return 0;
+	}
+
+	if (pfvf->mqprio_replace_pending) {
+		otx2_mqprio_pre_graft_reject_msg(netdev);
+		pfvf->mqprio_replace_pending = false;
+		return -EIO;
+	}
+
+	/* Skip the netdev restart when mqprio offload was not active. */
+	if (!had_mqprio)
+		return 0;
+
+	if (if_up) {
+		int down_err, err;
+
+		down_err = otx2_mqprio_down(pfvf);
+		err = otx2_mqprio_restart_netdev(netdev, false);
+		if (err)
+			return err;
+		return down_err;
+	}
+
+	/* ndo_stop() already freed the TX scheduler TL nodes; drop software
+	 * state only.
+	 */
+	otx2_mqprio_clear_sw(pfvf);
+	return 0;
+}
+
+static int otx2_setup_tc_mqprio(struct net_device *netdev,
+				struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	bool replacing = pfvf->mqprio.rate_limit;
+	bool if_up = netif_running(netdev);
+	int tc, txq, err, i;
+
+	if (!qopt->hw)
+		return otx2_teardown_tc_mqprio(pfvf, mqprio);
+
+	if (!if_up) {
+		netdev_err(netdev, "mqprio: setup requires interface UP\n");
+		NL_SET_ERR_MSG_MOD(extack, "mqprio: setup requires interface UP");
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+		netdev_err(netdev, "Unsupported mqprio shaper %#x\n", mqprio->shaper);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported mqprio shaper %#x",
+				       mqprio->shaper);
+		return -EOPNOTSUPP;
+	}
+
+	if (!test_bit(QOS_CIR_PIR_SUPPORT, &pfvf->hw.cap_flag)) {
+		netdev_err(netdev,
+			   "mqprio: bandwidth offload requires CIR+PIR support\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: bandwidth offload requires CIR+PIR support");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_otx2_sdp_rep(pfvf->pdev)) {
+		netdev_err(netdev, "mqprio: bandwidth offload not supported on SDP rep\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: bandwidth offload not supported on SDP rep");
+		return -EOPNOTSUPP;
+	}
+
+	if (otx2_qos_htb_active(pfvf)) {
+		netdev_err(netdev, "mqprio: cannot enable offload while HTB is active\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while HTB is active");
+		return -EOPNOTSUPP;
+	}
+
+	if (pfvf->pfc_en) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while PFC is enabled\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while PFC is enabled");
+		return -EOPNOTSUPP;
+	}
+
+	if (pfvf->xdp_prog) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while XDP is active\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while XDP is active");
+		return -EOPNOTSUPP;
+	}
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+		u32 qcount = qopt->count[tc];
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = mqprio->min_rate[tc];
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = mqprio->max_rate[tc];
+
+		if (min_rate && max_rate && min_rate > max_rate) {
+			netdev_err(netdev,
+				   "min_rate %llu exceeds max_rate %llu for tc %d\n",
+				   min_rate, max_rate, tc);
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "min_rate %llu exceeds max_rate %llu for tc %d",
+					       min_rate, max_rate, tc);
+			return -EINVAL;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE) {
+			err = otx2_mqprio_validate_tc_rate(netdev, extack, min_rate,
+							   qcount, tc, "min");
+			if (err)
+				return err;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE) {
+			err = otx2_mqprio_validate_tc_rate(netdev, extack, max_rate,
+							   qcount, tc, "max");
+			if (err)
+				return err;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE &&
+		    !otx2_mqprio_rate_valid(min_rate)) {
+			netdev_err(netdev,
+				   "mqprio: min_rate %llu for tc %d is outside hardware limits\n",
+				   min_rate, tc);
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "mqprio: min_rate %llu for tc %d is outside hardware limits",
+					       min_rate, tc);
+			return -EINVAL;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE &&
+		    !otx2_mqprio_rate_valid(max_rate)) {
+			netdev_err(netdev,
+				   "mqprio: max_rate %llu for tc %d is outside hardware limits\n",
+				   max_rate, tc);
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "mqprio: max_rate %llu for tc %d is outside hardware limits",
+					       max_rate, tc);
+			return -EINVAL;
+		}
+	}
+
+	err = otx2_mqprio_validate_txqs(netdev, extack, qopt);
+	if (err)
+		return err;
+
+	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
+	if (err)
+		return err;
+
+	/* TODO: Failures from here through the end of init() (e.g. -ENOMEM
+	 * from otx2_mqprio_alloc_cache(), mbox errors from
+	 * otx2_nix_tm_clear_queue_shaper() or otx2_nix_tm_set_queue_shaper())
+	 * reach cleanup. On tc qdisc replace the old mqprio remains grafted,
+	 * so cleanup returns without rolling back netdev TC mapping, the rate
+	 * cache, or partially reprogrammed hardware shapers. Restore the prior
+	 * configuration instead of calling otx2_mqprio_down() and bouncing the
+	 * interface a second time.
+	 */
+	err = otx2_mqprio_alloc_cache(pfvf);
+	if (err)
+		goto cleanup;
+
+	/* otx2_mqprio_up() may have restored the previous configuration during
+	 * the restart above. Clear every MDQ shaper before applying the new
+	 * mapping so queues dropped from the TC layout do not keep stale
+	 * limits in hardware.
+	 */
+	if (otx2_mqprio_mdq_allocated(pfvf)) {
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+		if (err)
+			goto cleanup;
+	}
+
+	pfvf->mqprio.flags = mqprio->flags;
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+		u32 qcount = qopt->count[tc];
+
+		/* Rates omitted from tc mqprio are passed as zero and both MDQ
+		 * shaper registers are programmed; see
+		 * otx2_nix_tm_set_queue_shaper(). Multi-queue TCs with rates
+		 * are rejected above.
+		 */
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = mqprio->min_rate[tc];
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = mqprio->max_rate[tc];
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qcount; txq++) {
+			netdev_dbg(netdev,
+				   "mqprio: tc %d txq %d min_rate %llu max_rate %llu\n",
+				   tc, txq, min_rate, max_rate);
+
+			pfvf->mqprio.min_rate[txq] = min_rate;
+			pfvf->mqprio.max_rate[txq] = max_rate;
+
+			err = otx2_nix_tm_set_queue_shaper(pfvf, txq,
+							   min_rate, max_rate);
+			if (err)
+				goto cleanup;
+		}
+	}
+
+	netdev_set_num_tc(netdev, qopt->num_tc);
+	for (i = 0; i < qopt->num_tc; i++)
+		netdev_set_tc_queue(netdev, i, qopt->count[i], qopt->offset[i]);
+
+	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+
+	if (replacing)
+		pfvf->mqprio_replace_pending = true;
+
+	return 0;
+
+cleanup:
+	/* Clear hardware offload on this rejected request so a failed replace
+	 * does not leave tc reporting offload for driver state that was torn
+	 * down while the previous mqprio remains grafted.
+	 */
+	qopt->hw = 0;
+	if (replacing) {
+		otx2_mqprio_replace_failed_msg(netdev, extack);
+		pfvf->mqprio_replace_pending = false;
+		return err ? err : -EIO;
+	}
+	otx2_teardown_tc_mqprio(pfvf, mqprio);
+	return err;
+}
+
+static int otx2_setup_tc_root(struct otx2_nic *pfvf,
+			      struct tc_root_qopt_offload *root)
+{
+	switch (root->command) {
+	case TC_ROOT_GRAFT:
+		if (root->ingress)
+			return 0;
+		if (pfvf->mqprio_replace_pending) {
+			pfvf->mqprio_skip_teardown = true;
+			pfvf->mqprio_replace_pending = false;
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int otx2_setup_tc_query_caps(void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+	struct tc_mqprio_caps *caps;
+
+	if (base->type != TC_SETUP_QDISC_MQPRIO)
+		return -EOPNOTSUPP;
+
+	caps = base->caps;
+	caps->validate_queue_counts = true;
+
+	return 0;
+}
+
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data)
 {
 	switch (type) {
+	case TC_QUERY_CAPS:
+		return otx2_setup_tc_query_caps(type_data);
 	case TC_SETUP_BLOCK:
 		return otx2_setup_tc_block(netdev, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return otx2_setup_tc_htb(netdev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return otx2_setup_tc_mqprio(netdev, type_data);
+	case TC_SETUP_ROOT_QDISC:
+		return otx2_setup_tc_root(netdev_priv(netdev), type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..cf0021788356 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -118,6 +118,9 @@ static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
 	/* configure PIR */
 	maxrate = (node->rate > node->ceil) ? node->rate : node->ceil;
 
+	/* 65536 is the kernel-side default burst when HTB does not supply an
+	 * explicit value, not the NIX hardware maximum (CN10K_MAX_BURST_SIZE).
+	 */
 	cfg->regval[*num_regs] =
 		otx2_get_txschq_rate_regval(pfvf, maxrate, 65536);
 	(*num_regs)++;
@@ -1729,11 +1732,23 @@ void otx2_qos_config_txschq(struct otx2_nic *pfvf)
 	otx2_qos_root_destroy(pfvf);
 }
 
+bool otx2_qos_htb_active(struct otx2_nic *pfvf)
+{
+	return otx2_sw_node_find(pfvf, OTX2_QOS_ROOT_CLASSID);
+}
+
 int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb)
 {
 	struct otx2_nic *pfvf = netdev_priv(ndev);
 	int res;
 
+	if (pfvf->mqprio.rate_limit &&
+	    htb->command != TC_HTB_DESTROY) {
+		NL_SET_ERR_MSG_MOD(htb->extack,
+				   "HTB offload cannot be used with mqprio bandwidth offload active");
+		return -EOPNOTSUPP;
+	}
+
 	switch (htb->command) {
 	case TC_HTB_CREATE:
 		return otx2_qos_root_add(pfvf, htb->parent_classid,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
index 221bd0438f60..c777cc42eac9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
@@ -23,6 +23,7 @@ enum qos_smq_operations {
 u64 otx2_get_txschq_rate_regval(struct otx2_nic *nic, u64 maxrate, u32 burst);
 
 int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb);
+bool otx2_qos_htb_active(struct otx2_nic *pfvf);
 int otx2_qos_get_qid(struct otx2_nic *pfvf);
 void otx2_qos_free_qid(struct otx2_nic *pfvf, int qidx);
 int otx2_qos_enable_sq(struct otx2_nic *pfvf, int qidx);
-- 
2.43.0

