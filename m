Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAA330650;
	Mon, 31 Aug 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181882; cv=none; b=OGkXquNOPHAN0Qj054XvvjSBDxnFrGU7TskC3FxfhV5wMnUxkNSQ8B+56wrXyne1RuDv2y/oezdPGAyLDheYA63nVuJlA9UhBz1uBhekBo8tsV/5vmpExKrtKinisgkn7Q5UrJL5lSxPp1pEm4SDf9bWhT9H9lDZqHWsnjZJ8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181882; c=relaxed/simple;
	bh=Ga/I0s3QP3NNa83ikATlZeg+KO9YYwWq4hmBNx1Ni0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl8IdTktWb9a7axWtSHuGE9svxl4n2i4FM4xI/tawSf4dhYdpqfL2p6pc6bTdpLa7WF15iY7hsKIA/+/IjmFQDPd4Rn5IPIZ6+lXf7GwNX3gyAKUb3IUbXClzO02BlC+aFeNGaFevcXZ+XciCRaa29waXmOyj3vibcu59QVUdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MbPkI/T0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MbPkI/T0"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBDPan1197136;
	Mon, 31 Aug 2026 06:10:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	3wpqtxgkvw6cXdMav6DYFbEx579wZHK4ch0yz3YvWE=; b=MbPkI/T0qZvNJ8vsQ
	hFpOq7c18XgoIlfMNo2fuxKR2BDQD+hXTom1BPLMO3jEhz3DJb8JPtlMFtGu7pTm
	NalqRDNd5EGG5rPvnh4lfBfm2s2kW3iNBd7qC9+m7Y6J72EyDjaeM+4zIG7Nu6nL
	V3BVh1GzJOJLDTOIhxddDDuCi2NRqgzHoSqB5FZ1Yj0Vi1xhtkXz/CH3OQXg7iw/
	MUJ1PWjEkINBCiONZR2kJzbHb47HoFXeFhK4m0oI/Okmmvz4txf+lJUe3Tnfq03p
	7vKUQYew8te0OZQ/rMGLyFepdA1rz2OaYFkFj1+KTnSHvHHRDi8AtdXmW+p/84ZY
	yLv9g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj3xpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:10:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:10:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:10:42 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5E6F13F7089;
	Mon, 31 Aug 2026 06:10:37 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <horms@kernel.org>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v10 net-next 2/2] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Mon, 31 Aug 2026 18:40:13 +0530
Message-ID: <20260831131014.2639581-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831131014.2639581-1-rkannoth@marvell.com>
References: <20260831131014.2639581-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNCBTYWx0ZWRfX57laIHXFV71F
 bQVCV3y26Yjp1eb5wtzFiGw8FIeACsZiA8SaU6IcmugTvaOTiZGIObvI3ZeJ/V87HLWprfbOaui
 SP9QQwNcNskepnxN5Ne6j74V8j90DQc=
X-Proofpoint-GUID: 1bpT61RZvTz4FZuAIsDZpeogJOkTkc-a
X-Proofpoint-ORIG-GUID: 1bpT61RZvTz4FZuAIsDZpeogJOkTkc-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNCBTYWx0ZWRfX1SDAWvr/0BPZ
 2XDvXcRE7kudU5QJQhZs6la6X387YCOPwturoG5UsUl03riA5FOCPWgWqVA3BBMTryEZJOsvkCK
 yoHgVLgV7cLFhzJD0+XRoo4qCrC34DCEnpb75uMU3xG21fbmDWBZz/WJqlVlk1IhMqcbP8hBmXX
 V9hU18PwuqfjhlkklCGgRovbymeomL1fb/zPn2jbskWp35rzUC5QS+B+/x/xUufcyO/P30rvcLB
 VKI9+ibiBmm1ytgZRJQDvZQeieNgXK1vvAzEd2zHyDoAEnrK1wj5l7ypIwcHQlWqlnEGlFQtXYJ
 BwTL64AKEvgEQM/PLs2zyfNIWwHOi/+XpAEby9Ye0x6D2FrxgUPnKR2ywemf67RhfkU3MNjVyTb
 woEaPcOfyGAd9fVYIAs3IFTpo7KoEL/YcYmW6PG4SY/lZdX+Lt3xYikVAM6IV1EwvUSHNcAAu6L
 XGE5AMwEl0IZrJ7vMsg==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a957d54 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=CPZXpxijqHspJ90g2woA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

Add TC_SETUP_QDISC_MQPRIO handling for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE. Shape each non-QoS transmit queue by
programming MDQ CIR/PIR on hw.non_qos_queues. When bandwidth offload is
enabled, allocate one SMQ per such queue, parent every MDQ under TL4[0],
and apply each traffic class min/max rate to the queue(s) in that class.
Reprogram the default TX scheduler hierarchy through ndo_stop() and
ndo_open() on every mqprio add, replace, or delete.

Track committed mqprio state in mq_offload_snap snapshots (handle, TC
layout, and rates) using the qdisc handle passed from the core mqprio
offload path. Roll back from the previous snapshot when tc qdisc replace
fails, and ignore teardown from a replaced qdisc instance once the new
handle is committed.

Restore shapers from the cached per-queue rates in otx2_mqprio_up()
during ndo_open(). Log and continue if programming fails so a routine
link up is not blocked.

Reject offload unless the interface is running and the device supports
CIR+PIR shaping. Reject per-TC rates for traffic classes spanning more
than one queue, SDP rep devices, and concurrent PFC or XDP use. Block
ethtool channel count changes while mqprio bandwidth offload is active.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 145 +++-
 .../marvell/octeontx2/nic/otx2_common.h       |  27 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  12 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 696 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |   3 +
 8 files changed, 901 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..c9a4326d725d 100644
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
index 175992188c18..5c502c9d7c83 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -615,6 +615,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)
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
@@ -651,7 +787,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 						(u64)hw->smq_link_type);
 		req->num_regs++;
 		/* MDQ config */
-		parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
+		if (pfvf->mqprio.rate_limit)
+			parent = schq_list[NIX_TXSCH_LVL_TL4][0];
+		else
+			parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
+
 		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
 		req->regval[1] = parent << 16;
 		req->num_regs++;
@@ -779,6 +919,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
 	}
 
+	if (pfvf->mqprio.rate_limit)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..dbd46ff26d96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -17,6 +17,7 @@
 #include <linux/soc/marvell/silicons.h>
 #include <linux/soc/marvell/octeontx2/asm.h>
 #include <net/macsec.h>
+#include <uapi/linux/pkt_sched.h>
 #include <net/pkt_cls.h>
 #include <net/devlink.h>
 #include <linux/time64.h>
@@ -483,6 +484,23 @@ struct pf_irq_data {
 	int mdevs;
 };
 
+struct mq_offload_snap {
+	u32 handle;
+	u64 min_rate[TC_QOPT_MAX_QUEUE];
+	u64 max_rate[TC_QOPT_MAX_QUEUE];
+	__u8 num_tc;
+	__u16 count[TC_QOPT_MAX_QUEUE];
+	__u16 offset[TC_QOPT_MAX_QUEUE];
+};
+
+struct otx2_mqprio {
+	u32	flags;
+	u32	handle;
+	u64	*min_rate;
+	u64	*max_rate;
+	bool	rate_limit;
+};
+
 struct otx2_nic {
 	void __iomem		*reg_base;
 	struct net_device	*netdev;
@@ -515,6 +533,10 @@ struct otx2_nic {
 	u64			flags;
 	u64			*cq_op_addr;
 
+	struct otx2_mqprio	mqprio;
+	struct mq_offload_snap	*cur_mq_snap;
+	struct mq_offload_snap	*old_mq_snap;
+
 	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
@@ -1246,6 +1268,11 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
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
index 9bee1b91eeaa..ec2601c6c255 100644
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
index c995f2900859..79a82e445454 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1980,6 +1980,12 @@ int otx2_open(struct net_device *netdev)
 	if (err)
 		goto err_free_mem;
 
+	err = otx2_mqprio_up(pf);
+	if (err)
+		netdev_err(pf->netdev,
+			   "mqprio: failed to restore shapers during open: %d; continuing without bandwidth limits\n",
+			   err);
+
 	/* Register NAPI handler */
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
@@ -2846,6 +2852,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
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
index 039fd47ebf52..3f835eb977d3 100644
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
@@ -1600,14 +1609,700 @@ static int otx2_setup_tc_block(struct net_device *netdev,
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
+static int otx2_mqprio_alloc_cache(struct otx2_nic *pfvf, bool replacing)
+{
+	u16 num_txq = pfvf->hw.non_qos_queues;
+
+	if (replacing && pfvf->mqprio.min_rate && pfvf->mqprio.max_rate) {
+		memset(pfvf->mqprio.min_rate, 0,
+		       num_txq * sizeof(*pfvf->mqprio.min_rate));
+		memset(pfvf->mqprio.max_rate, 0,
+		       num_txq * sizeof(*pfvf->mqprio.max_rate));
+		pfvf->mqprio.flags = 0;
+		return 0;
+	}
+
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
+static void otx2_mqprio_snap_free(struct otx2_nic *pfvf,
+				  struct mq_offload_snap **snap)
+{
+	if (!*snap)
+		return;
+
+	devm_kfree(pfvf->dev, *snap);
+	*snap = NULL;
+}
+
+static int otx2_mqprio_snap_copy(struct otx2_nic *pfvf,
+				 struct mq_offload_snap **dst,
+				 const struct tc_mqprio_qopt_offload *mqprio)
+{
+	const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct mq_offload_snap *snap;
+	int tc;
+
+	if (!*dst) {
+		snap = devm_kzalloc(pfvf->dev, sizeof(*snap), GFP_KERNEL);
+		if (!snap)
+			return -ENOMEM;
+		*dst = snap;
+	} else {
+		snap = *dst;
+	}
+
+	snap->handle = mqprio->handle;
+	snap->num_tc = qopt->num_tc;
+	for (tc = 0; tc < TC_QOPT_MAX_QUEUE; tc++) {
+		snap->count[tc] = qopt->count[tc];
+		snap->offset[tc] = qopt->offset[tc];
+		snap->min_rate[tc] = 0;
+		snap->max_rate[tc] = 0;
+	}
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			snap->min_rate[tc] = mqprio->min_rate[tc];
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			snap->max_rate[tc] = mqprio->max_rate[tc];
+	}
+
+	return 0;
+}
+
+static int otx2_mqprio_stage_cur(struct otx2_nic *pfvf,
+				 const struct tc_mqprio_qopt_offload *mqprio)
+{
+	return otx2_mqprio_snap_copy(pfvf, &pfvf->cur_mq_snap, mqprio);
+}
+
+static void otx2_mqprio_snap_commit(struct otx2_nic *pfvf)
+{
+	otx2_mqprio_snap_free(pfvf, &pfvf->old_mq_snap);
+	pfvf->old_mq_snap = pfvf->cur_mq_snap;
+	pfvf->cur_mq_snap = NULL;
+}
+
+static bool otx2_mqprio_mdq_allocated(struct otx2_nic *pfvf)
+{
+	return pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_MDQ] != 0;
+}
+
+static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
+{
+	struct mq_offload_snap *snap = pfvf->old_mq_snap;
+	struct net_device *netdev = pfvf->netdev;
+	u16 num_txq = pfvf->hw.non_qos_queues;
+	int tc, txq, err;
+
+	if (!snap)
+		return 0;
+
+	err = otx2_mqprio_alloc_cache(pfvf, false);
+	if (err)
+		return err;
+
+	memset(pfvf->mqprio.min_rate, 0, num_txq * sizeof(*pfvf->mqprio.min_rate));
+	memset(pfvf->mqprio.max_rate, 0, num_txq * sizeof(*pfvf->mqprio.max_rate));
+	pfvf->mqprio.flags = 0;
+
+	for (tc = 0; tc < snap->num_tc; tc++) {
+		u64 min_rate = snap->min_rate[tc];
+		u64 max_rate = snap->max_rate[tc];
+
+		if (min_rate)
+			pfvf->mqprio.flags |= TC_MQPRIO_F_MIN_RATE;
+		if (max_rate)
+			pfvf->mqprio.flags |= TC_MQPRIO_F_MAX_RATE;
+
+		for (txq = snap->offset[tc];
+		     txq < snap->offset[tc] + snap->count[tc]; txq++) {
+			pfvf->mqprio.min_rate[txq] = min_rate;
+			pfvf->mqprio.max_rate[txq] = max_rate;
+		}
+	}
+
+	pfvf->mqprio.handle = snap->handle;
+
+	netdev_set_num_tc(netdev, snap->num_tc);
+	for (tc = 0; tc < snap->num_tc; tc++)
+		netdev_set_tc_queue(netdev, tc, snap->count[tc],
+				    snap->offset[tc]);
+
+	if (otx2_mqprio_mdq_allocated(pfvf)) {
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+		if (err)
+			return err;
+	}
+
+	err = otx2_mqprio_up(pfvf);
+	if (err)
+		return err;
+
+	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
+
+	return 0;
+}
+
+static void otx2_mqprio_snap_destroy(struct otx2_nic *pfvf)
+{
+	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
+	otx2_mqprio_snap_free(pfvf, &pfvf->old_mq_snap);
+}
+
+static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+
+	pfvf->mqprio.rate_limit = false;
+	pfvf->mqprio.handle = 0;
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
+	if (err) {
+		netdev_err(pfvf->netdev,
+			   "mqprio: failed to clear hardware shapers: %d; some TX queues may retain bandwidth limits\n",
+			   err);
+		return err;
+	}
+
+	otx2_mqprio_clear_sw(pfvf);
+
+	return 0;
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
+		netdev_err(netdev,
+			   "Failed to restart device after mqprio change: %d\n",
+			   err);
+		/* ndo_open() already freed the TX schedulers on failure while
+		 * netif_running() may still be true; drop mqprio software state
+		 * only instead of sending shaper clears to freed queues.
+		 */
+		otx2_mqprio_clear_sw(pfvf);
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
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	bool had_mqprio = pfvf->mqprio.rate_limit;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+	bool rollback;
+	int err;
+
+	qopt->hw = 0;
+
+	/* tc qdisc replace runs setup on the new mqprio before destroying the
+	 * old one. Ignore teardown from the replaced instance once the new
+	 * handle is committed in otx2_setup_tc_mqprio().
+	 */
+	if (mqprio->handle && mqprio->handle != pfvf->mqprio.handle) {
+		if (pfvf->cur_mq_snap)
+			otx2_mqprio_snap_commit(pfvf);
+		return 0;
+	}
+
+	if (mqprio->handle && mqprio->handle == pfvf->mqprio.handle &&
+	    pfvf->old_mq_snap) {
+		rollback = pfvf->cur_mq_snap;
+
+		err = otx2_mqprio_restore_old(pfvf);
+		if (err)
+			return err;
+		if (rollback)
+			return 0;
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
+	err = otx2_mqprio_stage_cur(pfvf, mqprio);
+	if (err)
+		return err;
+
+	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
+	if (err)
+		goto cleanup;
+
+	err = otx2_mqprio_alloc_cache(pfvf, replacing);
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
+	netdev_set_num_tc(netdev, pfvf->cur_mq_snap->num_tc);
+	for (i = 0; i < pfvf->cur_mq_snap->num_tc; i++)
+		netdev_set_tc_queue(netdev, i, pfvf->cur_mq_snap->count[i],
+				    qopt->offset[i]);
+
+	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+	pfvf->mqprio.handle = mqprio->handle;
+
+	if (!replacing)
+		otx2_mqprio_snap_commit(pfvf);
+
+	return 0;
+
+cleanup:
+	qopt->hw = 0;
+	if (replacing) {
+		int restore_err = otx2_mqprio_restore_old(pfvf);
+
+		if (restore_err) {
+			netdev_err(netdev,
+				   "mqprio: replace failed and prior configuration rollback failed: %d\n",
+				   restore_err);
+			if (extack)
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: replace failed and prior configuration rollback failed: %d",
+						       restore_err);
+		} else {
+			netdev_err(netdev,
+				   "mqprio: replace failed; prior configuration restored\n");
+			if (extack)
+				NL_SET_ERR_MSG_MOD(extack,
+						   "mqprio: replace failed; prior configuration restored");
+		}
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
@@ -1632,6 +2327,7 @@ EXPORT_SYMBOL(otx2_init_tc);
 void otx2_shutdown_tc(struct otx2_nic *nic)
 {
 	otx2_destroy_tc_flow_list(nic);
+	otx2_mqprio_snap_destroy(nic);
 }
 EXPORT_SYMBOL(otx2_shutdown_tc);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..d9af182e5721 100644
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
-- 
2.43.0

