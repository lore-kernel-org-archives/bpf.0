Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69160223336;
	Wed, 14 Oct 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945335; cv=none; b=dSSlzjlr8G9zKY2WG9wEA6D5T4FgOqYkEosp7K0OwykzeHusIBAxuTuuzIr5F4JsdOsRDJMkOahLDD4n5UhtdgKIypLoGmOH0UWAnwJB2eTU4067HiigGBUNz9bwCRY3xXwp6167nSHuekEpl7C42wxefyD+r0AQZpRLoJvA6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945335; c=relaxed/simple;
	bh=hV1iYsAbrRI/L7DtiwUcL+pWo+AaCmerbVf7j3gltfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uckQQ5cEjnSagtuKZHalJv567K7lJ98ZlpFBd+p36Vv5Ad6r2Iy3xH/gvbyHbaEE547Gj8Xw6sX+yyuFstBoD63UbV2K7DiR8g+g5z0pt6wiPMiM0GjCX83Cty1u5BFI8qEdUB4X4QITSfuEnXZ0naPZ6pYK8xCL8skJLKkVDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K76Qs8TR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K76Qs8TR"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DMv73r1835531;
	Tue, 13 Oct 2026 19:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	0kZAw+V+14RNO/DY7ZcNwOzptCGpbstq68Vjsweivc=; b=K76Qs8TRnkDAINyOr
	7aRiNTy4rYLat9EOfUWiA2+3/sPqassR7XYpe/Z/J7oXkoq7pBqZ6jOTdT1qQjfS
	Bs6hkjT7Uy7VQqMy/sVYpeGzxBQ6lYWsRZwtBDpsugEeE9Go4HnfPBkOV1/2gDng
	ZQHj25Z5clajk/9nF3roSjHTQk48X5Ul99k0xBpjtNVmP6Zl4uXzlBK9VTQOlP9T
	3aBrgh0I3dkjmIRNUVps66aBYcsG6Q9WJEVsvqxIkVwUnyXYj69GNL0HWC/5XTcr
	mFIyXU/pbY6tn3IziA+iNrR+qrApt9hH+kEwCIUmb0NSUxj3+KF9WCJUwuu99Du9
	i3Cew==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h9r9xjpj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 19:35:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Oct 2026 19:35:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Oct 2026 19:35:01 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 20D303F70B3;
	Tue, 13 Oct 2026 19:34:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@kernel.org>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH v20 net-next 2/2] octeontx2: add mqprio bandwidth offload for NIX TX schedulers
Date: Wed, 14 Oct 2026 08:04:31 +0530
Message-ID: <20261014023431.1775238-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014023431.1775238-1-rkannoth@marvell.com>
References: <20261014023431.1775238-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DvDDa2/+ c=1 sm=1 tr=0 ts=6aceea56 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=_hmXFnRg6jpWjyhfFtMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qDXz22Ln7BNAhbLP62Pg9NkqJczdET0g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwOSBTYWx0ZWRfX2ig6rTQlnNNj
 xVhAdhurrmaYLKwjpsAOdu4L2OHzoryR1RJanD3VVZa9reps9k3U6nLqEXjrReqdu1uFF82LFyo
 NQONH+ocCI5ZJVzlJH7OfCSs4de6GXPIliL1Wx7V3eHy9z3KTj7QgLurY82fjDFpn7r8rfkerT9
 t3jP7v/EGMR23W+WYHkv/DMNrp08HjlWa4tKCu/rfTiROZHXSziGGOXXuON+ZKnvnHCi281f0ts
 ho/4Ikri+rPbwPTNYYRZBBazW08TufgaKyH4+OSL9/30FRYszIrFABPmzTZrBxn/5Q+ZTK2whq+
 1RNKbNfYUZHgZerq1JAr8AuG2Y0WVk6S3awWPsQwGBhF/L2PCDhZZAmv5XbcEsYev84erTTpPCb
 223tt44TrW1mTwWAOyuyI0kGNVFEMl29AEHVvWBYsHvgngc4QRAJJUfCN4MNNRMShcYQ8gD1Wnp
 m/O4FuJvunkYpzRmjbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwOSBTYWx0ZWRfX58T1dk6B+U3H
 y92PWq6f4XV+3K1ZtUUoGfs/qhvm+VORc34tGP2WbSwn78MIT+9td5+2cd94oNt6Cg+dkCE7qwb
 VVwbddL7z0Yuw0louLMqFzMnruqaT5Y=
X-Proofpoint-GUID: qDXz22Ln7BNAhbLP62Pg9NkqJczdET0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

Add TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE on PF and
VF netdevs. Program per-queue MDQ CIR/PIR via the NIX TX scheduler mailbox;
when active, allocate one SMQ per non-QoS queue under TL4[0].

The TX scheduler cannot be reprogrammed live, so add/replace/delete and
failed setup bounce the netdev through ndo_stop()/ndo_open(). Cache rates
in software and restore them from otx2_mqprio_up() on open, failing closed
on error.

Stage tc replace in mq_offload_snap snapshots committed on TC_ROOT_GRAFT or
replaced-qdisc teardown.

Require a running interface with CIR+PIR support. Reject offload with PFC,
XDP, HTB, SDP representors, per-TC rates on multi-queue classes, and
ethtool channel changes while active.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 143 ++-
 .../marvell/octeontx2/nic/otx2_common.h       |  34 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  34 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 936 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  28 +-
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  11 +
 8 files changed, 1179 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 836601fc10d8..c95177602bf9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -615,6 +615,139 @@ void otx2_get_mac_from_af(struct net_device *netdev)
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
+	/* MQPRIO exposes only min/max rate, not burst.  Use the same 65536
+	 * byte default as the HTB shaper path.
+	 *
+	 * mqprio setup restarts the netdev (otx2_mqprio_restart_netdev);
+	 * ndo_open() may restore cached MDQ shapers via otx2_mqprio_up(), and
+	 * setup clears every MDQ shaper before applying the new mapping.
+	 * Program both PIR and CIR on every update so omitted rates are
+	 * applied explicitly rather than relying on stale hardware state.
+	 */
+	req->reg[n] = NIX_AF_MDQX_PIR(smq);
+	if (maxrate) {
+		rate = otx2_convert_rate(maxrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 65536);
+	} else {
+		req->regval[n] = 0;
+	}
+	n++;
+
+	/* CIR+PIR support is required and checked at mqprio setup. */
+	req->reg[n] = NIX_AF_MDQX_CIR(smq);
+	if (minrate) {
+		rate = otx2_convert_rate(minrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 65536);
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
@@ -651,7 +784,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
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
@@ -777,6 +914,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
 	}
 
+	if (pfvf->mqprio.rate_limit)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
@@ -841,6 +981,7 @@ void otx2_txschq_stop(struct otx2_nic *pfvf)
 
 	/* Clear the txschq list */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		pfvf->hw.txschq_cnt[lvl] = 0;
 		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
 			pfvf->hw.txschq_list[lvl][schq] = 0;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 0dc4c44e521d..61a02202a667 100644
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
@@ -517,6 +518,27 @@ enum otx2_flag_bits {
 	 BIT(OTX2_FLAG_TC_FLOWER_SUPPORT) |			\
 	 BIT(OTX2_FLAG_REP_VF_INITIALIZED))
 
+struct mq_offload_snap {
+	u64 min_rate[TC_QOPT_MAX_QUEUE];
+	u64 max_rate[TC_QOPT_MAX_QUEUE];
+	u32 flags;
+	__u8 num_tc;
+	__u16 count[TC_QOPT_MAX_QUEUE];
+	__u16 offset[TC_QOPT_MAX_QUEUE];
+	__u8 prio_tc_map[TC_QOPT_BITMASK + 1];
+};
+
+struct otx2_mqprio {
+	u32	flags;
+	u64	*min_rate;
+	u64	*max_rate;
+	bool	rate_limit;
+	bool	replace_setup_done;
+	bool	replace_graft_done;
+	bool	defer_tc_work;
+	struct work_struct netdev_tc_work;
+};
+
 struct otx2_nic {
 	void __iomem		*reg_base;
 	struct net_device	*netdev;
@@ -528,6 +550,10 @@ struct otx2_nic {
 	unsigned long		flags;
 	u64			*cq_op_addr;
 
+	struct otx2_mqprio	mqprio;
+	struct mq_offload_snap	*cur_mq_snap;
+	struct mq_offload_snap	*old_mq_snap;
+
 	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
@@ -1036,6 +1062,8 @@ static inline u16 otx2_get_smq_idx(struct otx2_nic *pfvf, u16 qidx)
 	if (qidx >= pfvf->hw.non_qos_queues) {
 		smq = pfvf->qos.qid_to_sqmap[qidx - pfvf->hw.non_qos_queues];
 	} else {
+		if (!pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ])
+			return 0;
 		idx = qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
 		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];
 	}
@@ -1223,6 +1251,7 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf);
 
 /* tc support */
 int otx2_init_tc(struct otx2_nic *nic);
+void otx2_shutdown_tc_mqprio(struct otx2_nic *nic);
 void otx2_shutdown_tc(struct otx2_nic *nic);
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data);
@@ -1294,6 +1323,11 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
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
index e3d54009180d..851bf3fd5bab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -408,6 +408,12 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
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
index 4fe473d9ea0d..5428b3d1b332 100644
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
index 777e7156badb..f51161e8b594 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2008,6 +2008,15 @@ int otx2_open(struct net_device *netdev)
 	if (err)
 		goto err_free_mem;
 
+	/* Fail closed: abort open if cached mqprio shapers cannot be restored. */
+	err = otx2_mqprio_up(pf);
+	if (err) {
+		netdev_err(pf->netdev,
+			   "mqprio: failed to restore shapers during open: %d\n",
+			   err);
+		goto err_free_hw;
+	}
+
 	/* Register NAPI handler */
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
@@ -2206,6 +2215,7 @@ int otx2_open(struct net_device *netdev)
 	free_irq(vec, pf);
 err_disable_napi:
 	otx2_disable_napi(pf);
+err_free_hw:
 	otx2_free_hw_resources(pf);
 err_free_mem:
 	otx2_free_queue_mem(qset);
@@ -2281,6 +2291,7 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
+	synchronize_net();
 	otx2_free_queue_mem(qset);
 	/* Do not clear RQ/SQ ringsize settings */
 	memset_startat(qset, 0, sqe_cnt);
@@ -2924,6 +2935,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
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
@@ -3368,10 +3385,14 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_mcs_free;
 
+	err = otx2_init_tc(pf);
+	if (err)
+		goto err_ipsec_clean;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-		goto err_ipsec_clean;
+		goto err_shutdown_tc;
 	}
 
 	err = otx2_wq_init(pf);
@@ -3380,10 +3401,6 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	otx2_set_ethtool_ops(netdev);
 
-	err = otx2_init_tc(pf);
-	if (err)
-		goto err_mcam_flow_del;
-
 	err = otx2_register_dl(pf);
 	if (err)
 		goto err_mcam_flow_del;
@@ -3420,11 +3437,13 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	otx2_sriov_vfcfg_cleanup(pf);
 err_pf_sriov_init:
 	otx2_unregister_dl(pf);
-	otx2_shutdown_tc(pf);
 err_mcam_flow_del:
 	otx2_mcam_flow_del(pf);
 err_unreg_netdev:
+	otx2_shutdown_tc_mqprio(pf);
 	unregister_netdev(netdev);
+err_shutdown_tc:
+	otx2_shutdown_tc(pf);
 err_ipsec_clean:
 	cn10k_ipsec_clean(pf);
 err_mcs_free:
@@ -3622,7 +3641,9 @@ static void otx2_remove(struct pci_dev *pdev)
 	otx2_cgx_config_linkevents(pf, false);
 
 	otx2_unregister_dl(pf);
+	otx2_shutdown_tc_mqprio(pf);
 	unregister_netdev(netdev);
+	otx2_shutdown_tc(pf);
 	cn10k_ipsec_clean(pf);
 	cn10k_mcs_free(pf);
 	otx2_sriov_disable(pf->pdev);
@@ -3632,7 +3653,6 @@ static void otx2_remove(struct pci_dev *pdev)
 
 	otx2_ptp_destroy(pf);
 	otx2_mcam_flow_del(pf);
-	otx2_shutdown_tc(pf);
 	otx2_shutdown_qos(pf);
 	otx2_ndc_sync(pf);
 	otx2_detach_resources(&pf->mbox);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 8877af348a09..b34a86259e78 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/string.h>
 #include <linux/etherdevice.h>
 #include <linux/inetdevice.h>
 #include <linux/rhashtable.h>
@@ -16,6 +18,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/ipv6.h>
+#include <net/pkt_sched.h>
 
 #include "cn10k.h"
 #include "otx2_common.h"
@@ -31,6 +34,19 @@
 
 #define MCAST_INVALID_GRP		(-1U)
 #define RATE_MANTISSA_BITS		8
+/* Min per-queue egress shaping rate the NIX TLX encoder supports (2 Mbps). */
+#define OTX2_MQPRIO_MIN_RATE_BYTES_PS	250000ULL
+
+static u64 otx2_mqprio_max_rate_bytes_ps(void)
+{
+	u64 max_mbps;
+
+	/* NIX TLX maximum rate (Mbps), not the burst bucket cap. */
+	max_mbps = 2ULL * ((256ULL + MAX_RATE_MANTISSA) << MAX_RATE_EXPONENT) /
+		   256ULL;
+
+	return div_u64(max_mbps * 1000000ULL, 8ULL);
+}
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
@@ -61,6 +77,9 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 			*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
 		}
 	} else {
+		/* burst 0: largest encodable burst (CN10K_MAX_BURST_SIZE on
+		 * CN10K), not a minimal burst.
+		 */
 		*burst_exp = MAX_BURST_EXPONENT;
 		*burst_mantissa = max_mantissa;
 	}
@@ -1600,14 +1619,914 @@ static int otx2_setup_tc_block(struct net_device *netdev,
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
+	u64 *min_rate, *max_rate;
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
+	min_rate = devm_kcalloc(pfvf->dev, num_txq, sizeof(*min_rate), GFP_KERNEL);
+	max_rate = devm_kcalloc(pfvf->dev, num_txq, sizeof(*max_rate), GFP_KERNEL);
+	if (!min_rate || !max_rate) {
+		devm_kfree(pfvf->dev, min_rate);
+		devm_kfree(pfvf->dev, max_rate);
+		return -ENOMEM;
+	}
+
+	otx2_mqprio_free_cache(pfvf);
+	pfvf->mqprio.min_rate = min_rate;
+	pfvf->mqprio.max_rate = max_rate;
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
+	snap->num_tc = qopt->num_tc;
+	snap->flags = mqprio->flags;
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
+	memcpy(snap->prio_tc_map, qopt->prio_tc_map, sizeof(snap->prio_tc_map));
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
+static void otx2_mqprio_clear_replace_state(struct otx2_nic *pfvf)
+{
+	pfvf->mqprio.replace_setup_done = false;
+	pfvf->mqprio.replace_graft_done = false;
+}
+
+static bool otx2_mqprio_mdq_allocated(struct otx2_nic *pfvf)
+{
+	return pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_MDQ] != 0;
+}
+
+static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit);
+
+static void otx2_mqprio_apply_snap_netdev(struct net_device *netdev,
+					  const struct mq_offload_snap *snap)
+{
+	int tc;
+
+	if (!snap)
+		return;
+
+	netdev_set_num_tc(netdev, snap->num_tc);
+	for (tc = 0; tc < snap->num_tc; tc++)
+		netdev_set_tc_queue(netdev, tc, snap->count[tc],
+				    snap->offset[tc]);
+	for (tc = 0; tc < TC_QOPT_BITMASK + 1; tc++)
+		netdev_set_prio_tc_map(netdev, tc, snap->prio_tc_map[tc]);
+}
+
+static void otx2_mqprio_netdev_tc_work(struct work_struct *work)
+{
+	struct otx2_mqprio *mqprio = container_of(work, struct otx2_mqprio,
+						  netdev_tc_work);
+	struct otx2_nic *pfvf = container_of(mqprio, struct otx2_nic, mqprio);
+
+	rtnl_lock();
+	if (READ_ONCE(pfvf->mqprio.defer_tc_work))
+		goto out;
+	if (pfvf->mqprio.rate_limit && pfvf->old_mq_snap)
+		otx2_mqprio_apply_snap_netdev(pfvf->netdev, pfvf->old_mq_snap);
+out:
+	rtnl_unlock();
+}
+
+static void otx2_mqprio_defer_netdev_tc_restore(struct otx2_nic *pfvf)
+{
+	if (READ_ONCE(pfvf->mqprio.defer_tc_work))
+		return;
+	schedule_work(&pfvf->mqprio.netdev_tc_work);
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
+	if (err) {
+		netdev_err(netdev,
+			   "mqprio: rollback failed to allocate rate cache: %d\n",
+			   err);
+		return err;
+	}
+
+	memset(pfvf->mqprio.min_rate, 0, num_txq * sizeof(*pfvf->mqprio.min_rate));
+	memset(pfvf->mqprio.max_rate, 0, num_txq * sizeof(*pfvf->mqprio.max_rate));
+	pfvf->mqprio.flags = snap->flags;
+
+	for (tc = 0; tc < snap->num_tc; tc++) {
+		u64 min_rate = snap->min_rate[tc];
+		u64 max_rate = snap->max_rate[tc];
+
+		for (txq = snap->offset[tc];
+		     txq < snap->offset[tc] + snap->count[tc]; txq++) {
+			pfvf->mqprio.min_rate[txq] = min_rate;
+			pfvf->mqprio.max_rate[txq] = max_rate;
+		}
+	}
+
+	otx2_mqprio_apply_snap_netdev(netdev, snap);
+
+	if (otx2_mqprio_mdq_allocated(pfvf)) {
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+		if (err) {
+			netdev_err(netdev,
+				   "mqprio: rollback shaper clear failed: %d; hardware limits may not match qdisc\n",
+				   err);
+			return err;
+		}
+	}
+
+	/* Rebuild the TX scheduler via netdev restart when running; otx2_mqprio_up()
+	 * alone is insufficient after a failed replace that already bounced the
+	 * interface. If open failed, TX schedulers were freed; defer shaper restore
+	 * to the next successful ndo_open() via otx2_mqprio_up().
+	 */
+	pfvf->mqprio.rate_limit = true;
+
+	if (netif_running(netdev)) {
+		err = otx2_mqprio_restart_netdev(netdev, true);
+		if (err) {
+			netdev_err(netdev,
+				   "mqprio: rollback netdev restart failed: %d; qdisc rates may not be enforced\n",
+				   err);
+			return err;
+		}
+	} else if (pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]) {
+		err = otx2_mqprio_up(pfvf);
+		if (err) {
+			netdev_err(netdev,
+				   "mqprio: rollback shaper restore failed: %d; qdisc rates may not be enforced\n",
+				   err);
+			return err;
+		}
+	}
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
+/* Offloaded mqprio replaced by software mqprio installs netdev TC layout in
+ * mqprio_init() before the old offload instance is destroyed during graft.
+ */
+static bool otx2_mqprio_keep_netdev_tc(struct otx2_nic *pfvf)
+{
+	struct Qdisc *qdisc = rtnl_dereference(pfvf->netdev->qdisc);
+
+	return qdisc && qdisc->ops && !strcmp(qdisc->ops->id, "mqprio");
+}
+
+static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+
+	pfvf->mqprio.rate_limit = false;
+	otx2_mqprio_clear_replace_state(pfvf);
+	if (!otx2_mqprio_keep_netdev_tc(pfvf)) {
+		struct Qdisc *root = rtnl_dereference(netdev->qdisc);
+
+		if (root && root->ops && !strcmp(root->ops->id, "taprio"))
+			netdev_warn(netdev,
+				    "mqprio: offload teardown cleared the TC layout of the new %s\n",
+				    root->ops->id);
+		netdev_set_num_tc(netdev, 0);
+	}
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
+	/* The core cannot veto qdisc teardown, so always release software
+	 * state.  The netdev restart that follows reallocates the TX
+	 * scheduler, which drops any shaper left programmed.
+	 */
+	if (err)
+		netdev_warn(pfvf->netdev,
+			    "mqprio: failed to clear hardware shapers: %d; releasing offload state\n",
+			    err);
+
+	otx2_mqprio_clear_sw(pfvf);
+
+	return err;
+}
+
+/* Restore cached mqprio MDQ shapers after ndo_open() reprograms the TX
+ * scheduler. Called from otx2_open() when bandwidth offload stays active
+ * across admin down/up or an mqprio netdev bounce.
+ *
+ * Returns an error if any shaper mailbox operation fails. otx2_open()
+ * fail-closes on that error: it aborts open and leaves the interface down
+ * rather than running with partial or missing bandwidth limits.
+ */
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
+			if (otx2_mqprio_mdq_allocated(pfvf) &&
+			    otx2_nix_tm_clear_queue_shaper(pfvf))
+				netdev_warn(netdev,
+					    "mqprio: failed to clear shapers after partial restore\n");
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
+ * LBK carrier on) runs correctly.
+ *
+ * Intentional behaviour: this full stop/open cycle drops in-flight traffic
+ * (carrier off, IRQ/NAPI teardown, queue drain).  The NIX TX scheduler must
+ * be reallocated (e.g. one SMQ per non-QoS queue) and cannot be reprogrammed
+ * live today, so a netdev bounce is required on every mqprio add, replace,
+ * delete, and rollback.  Users see a brief connectivity blip; this is not a
+ * bug to "fix" without implementing the live-reprogramming path noted below.
+ * If open fails, OTX2_FLAG_INTF_DOWN is set before netif_close() so
+ * otx2_stop() returns early and does not touch resources already torn
+ * down by the open error path.
+ *
+ * Do not call dev_deactivate()/dev_activate() here.  On replace,
+ * qdisc_graft() already deactivates qdiscs around offload teardown;
+ * dev_activate() from ndo_setup_tc() would republish qdiscs before graft
+ * completes and race __qdisc_run() on the old root qdisc.  After
+ * ndo_open(), carrier and TX queues are restored via otx2_handle_link_event()
+ * when link is up, same as otx2_change_mtu(), not via dev_activate().
+ *
+ * Clear __LINK_STATE_START before ndo_stop() so netif_running() is false
+ * for the duration of the bounce.
+ */
+static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	bool running = netif_running(netdev);
+	int err;
+
+	/* TODO: Explore live TX scheduler reprogramming to avoid a full
+	 * ndo_stop()/ndo_open() bounce on every mqprio change.
+	 */
+	netdev_dbg(netdev,
+		   "mqprio: restarting interface to reprogram TX scheduler\n");
+
+	if (running) {
+		clear_bit(__LINK_STATE_START, &netdev->state);
+		smp_mb__after_atomic(); /* Commit netif_running(). */
+	}
+
+	err = ops->ndo_stop(netdev);
+	if (err) {
+		if (running)
+			set_bit(__LINK_STATE_START, &netdev->state);
+		return err;
+	}
+
+	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation.
+	 * On teardown, drop mqprio software state so ndo_open() does not
+	 * re-apply bandwidth limits via otx2_mqprio_up() after the kernel
+	 * removed the qdisc.
+	 */
+	if (rate_limit)
+		pfvf->mqprio.rate_limit = true;
+	else
+		otx2_mqprio_clear_sw(pfvf);
+
+	err = ops->ndo_open(netdev);
+	if (!err && running) {
+		set_bit(__LINK_STATE_START, &netdev->state);
+	} else if (err) {
+		netdev_err(netdev,
+			   "Failed to restart device after mqprio change: %d; bringing interface down\n",
+			   err);
+		/* ndo_open() already tore down TX scheduler resources on failure;
+		 * netif_running() is false here (__LINK_STATE_START stays clear
+		 * until open succeeds). Drop mqprio software state only instead
+		 * of sending shaper clears to freed queues.
+		 */
+		otx2_mqprio_clear_sw(pfvf);
+		/* ndo_open() rolls back on failure; mark the interface down so
+		 * otx2_stop() returns early when netif_close() runs.  Caller
+		 * holds RTNL; netif_close() is used since it needs no extra
+		 * locking (dev_close() would also take the netdev ops lock).
+		 */
+		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
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
+	/* TODO: per-TC TL4 shapers or equal per-queue MDQ split for multi-queue TC rates. */
+	netdev_err(netdev,
+		   "mqprio: %s rate for tc %d not supported with %u queues\n",
+		   name, tc, qcount);
+	NL_SET_ERR_MSG_FMT_MOD(extack,
+			       "mqprio: tc %d rate needs 1 queue (has %u)",
+			       tc, qcount);
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
+				       "TCs (%u) exceed hw queues %u",
+				       qopt->num_tc, num_txq);
+		return -EINVAL;
+	}
+
+	if (num_txq > MAX_TXSCHQ_PER_FUNC) {
+		netdev_err(netdev,
+			   "Number of queues (%u) exceeds max scheduler queues %u\n",
+			   num_txq, MAX_TXSCHQ_PER_FUNC);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "queues (%u) exceed max schq %u",
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
+						       "mqprio: txq %d exceeds queues %u",
+						       txq, num_txq);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static bool otx2_mqprio_rate_valid(struct otx2_nic *pfvf, u64 rate_bytes_ps)
+{
+	u64 mbps;
+
+	if (!rate_bytes_ps)
+		return true;
+
+	if (rate_bytes_ps < OTX2_MQPRIO_MIN_RATE_BYTES_PS)
+		return false;
+
+	if (rate_bytes_ps > otx2_mqprio_max_rate_bytes_ps())
+		return false;
+
+	if (rate_bytes_ps > div_u64(U64_MAX, 8))
+		return false;
+
+	mbps = otx2_convert_rate(rate_bytes_ps);
+	return ilog2(mbps / 2) <= MAX_RATE_EXPONENT;
+}
+
+static bool otx2_tc_can_offload(struct net_device *netdev)
+{
+	return !!(netdev->hw_features & NETIF_F_HW_TC);
+}
+
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct netlink_ext_ack *extack = mqprio->extack;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	bool had_mqprio = pfvf->mqprio.rate_limit;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+	int err;
+
+	if (!otx2_tc_can_offload(netdev))
+		return -EOPNOTSUPP;
+
+	qopt->hw = 0;
+
+	/* tc qdisc replace runs setup on the new mqprio before destroying the
+	 * old one. replace_setup_done and TC_ROOT_GRAFT distinguish stale
+	 * old-instance teardown from graft failure after setup.
+	 * qdisc_offload_graft_helper() skips TC_ROOT_GRAFT unless hw-tc-offload
+	 * is enabled in netdev->features; commit without graft in that case.
+	 */
+	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
+		err = 0;
+		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev)) {
+			otx2_mqprio_snap_commit(pfvf);
+		} else {
+			err = otx2_mqprio_restore_old(pfvf);
+			if (err && extack)
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: rollback failed (%d)",
+						       err);
+		}
+		otx2_mqprio_clear_replace_state(pfvf);
+		return err;
+	}
+
+	/* Skip the netdev restart when mqprio offload was not active. */
+	if (!had_mqprio)
+		return 0;
+
+	if (if_up) {
+		err = otx2_mqprio_down(pfvf);
+		if (err) {
+			if (extack)
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: teardown incomplete (%d)",
+						       err);
+			netdev_err(netdev,
+				   "mqprio: offload teardown incomplete (%d); driver state may not match removed qdisc\n",
+				   err);
+			return err;
+		}
+
+		err = otx2_mqprio_restart_netdev(netdev, false);
+		if (err) {
+			if (extack)
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: teardown restart failed (%d)",
+						       err);
+			netdev_err(netdev,
+				   "mqprio: offload teardown restart failed (%d); driver state may not match removed qdisc\n",
+				   err);
+			return err;
+		}
+		return 0;
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
+	struct netlink_ext_ack *extack = mqprio->extack;
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	bool replacing = pfvf->mqprio.rate_limit;
+	bool if_up = netif_running(netdev);
+	int tc, txq, err, i;
+
+	if (!otx2_tc_can_offload(netdev))
+		return -EOPNOTSUPP;
+
+	if (!qopt->hw)
+		return otx2_teardown_tc_mqprio(pfvf, mqprio);
+
+	if (!if_up) {
+		netdev_err(netdev, "mqprio: setup requires interface UP\n");
+		NL_SET_ERR_MSG_MOD(extack, "mqprio: setup requires interface UP");
+		err = -EOPNOTSUPP;
+		goto fail_validate;
+	}
+
+	if (!replacing && otx2_mqprio_keep_netdev_tc(pfvf)) {
+		netdev_err(netdev,
+			   "mqprio: delete existing mqprio before re-enabling hw/sw offload\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: delete existing mqprio before re-enabling hw/sw offload");
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+		netdev_err(netdev, "Unsupported mqprio shaper %#x\n", mqprio->shaper);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "mqprio: bad shaper %#x",
+				       mqprio->shaper);
+		err = -EOPNOTSUPP;
+		goto fail_validate;
+	}
+
+	if (!test_bit(QOS_CIR_PIR_SUPPORT, &pfvf->hw.cap_flag)) {
+		netdev_err(netdev,
+			   "mqprio: bandwidth offload requires CIR+PIR support\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: bandwidth offload requires CIR+PIR support");
+		err = -EOPNOTSUPP;
+		goto fail_validate;
+	}
+
+	if (is_otx2_sdp_rep(pfvf->pdev)) {
+		netdev_err(netdev, "mqprio: bandwidth offload not supported on SDP rep\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: bandwidth offload not supported on SDP rep");
+		err = -EOPNOTSUPP;
+		goto fail_validate;
+	}
+
+	if (pfvf->pfc_en) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while PFC is enabled\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while PFC is enabled");
+		err = -EOPNOTSUPP;
+		goto fail_validate;
+	}
+
+	if (pfvf->xdp_prog) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while XDP is active\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while XDP is active");
+		err = -EOPNOTSUPP;
+		goto fail_validate;
+	}
+
+	if (!list_empty(&pfvf->qos.qos_tree)) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while HTB is active\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while HTB is active");
+		err = -EOPNOTSUPP;
+		goto fail_validate;
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
+					       "mqprio: min>max rate for tc %d",
+					       tc);
+			err = -EINVAL;
+			goto fail_validate;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE) {
+			err = otx2_mqprio_validate_tc_rate(netdev, extack, min_rate,
+							   qcount, tc, "min");
+			if (err)
+				goto fail_validate;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE) {
+			err = otx2_mqprio_validate_tc_rate(netdev, extack, max_rate,
+							   qcount, tc, "max");
+			if (err)
+				goto fail_validate;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE &&
+		    !otx2_mqprio_rate_valid(pfvf, min_rate)) {
+			netdev_err(netdev,
+				   "mqprio: min_rate %llu for tc %d is outside hardware limits\n",
+				   min_rate, tc);
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "mqprio: min_rate out of range (tc %d)",
+					       tc);
+			err = -EINVAL;
+			goto fail_validate;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE &&
+		    !otx2_mqprio_rate_valid(pfvf, max_rate)) {
+			netdev_err(netdev,
+				   "mqprio: max_rate %llu for tc %d is outside hardware limits\n",
+				   max_rate, tc);
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "mqprio: max_rate out of range (tc %d)",
+					       tc);
+			err = -EINVAL;
+			goto fail_validate;
+		}
+	}
+
+	err = otx2_mqprio_validate_txqs(netdev, extack, qopt);
+	if (err)
+		goto fail_validate;
+
+	err = otx2_mqprio_stage_cur(pfvf, mqprio);
+	if (err)
+		goto fail_validate;
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
+		if (err) {
+			if (extack)
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: shaper clear failed (%d)",
+						       err);
+			goto cleanup;
+		}
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
+		 * otx2_nix_tm_set_queue_shaper().
+		 * TODO: multi-queue TC rates need per-queue split; see
+		 * otx2_mqprio_validate_tc_rate().
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
+			if (err) {
+				if (extack)
+					NL_SET_ERR_MSG_FMT_MOD(extack,
+							       "mqprio: shaper program failed (%d)",
+							       err);
+				netdev_err(netdev,
+					   "mqprio: programming shaper failed (%d); partial limits may be active\n",
+					   err);
+				goto cleanup;
+			}
+		}
+	}
+
+	netdev_set_num_tc(netdev, pfvf->cur_mq_snap->num_tc);
+	for (i = 0; i < pfvf->cur_mq_snap->num_tc; i++)
+		netdev_set_tc_queue(netdev, i, pfvf->cur_mq_snap->count[i],
+				    qopt->offset[i]);
+
+	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+
+	if (replacing) {
+		pfvf->mqprio.replace_setup_done = true;
+		pfvf->mqprio.replace_graft_done = false;
+	} else {
+		otx2_mqprio_snap_commit(pfvf);
+	}
+
+	netdev_warn_once(netdev,
+			 "mqprio: bandwidth offload uses TL4[0] without explicit topology programming; verify scheduling if limits look wrong\n");
+
+	return 0;
+
+fail_validate:
+	/* Failed replace destroys the new qdisc with hw_offload unset, so
+	 * mqprio_destroy() clears netdev TC after we return. Re-apply the
+	 * prior layout when validation fails before any hardware change.
+	 */
+	if (replacing)
+		otx2_mqprio_defer_netdev_tc_restore(pfvf);
+	return err;
+
+cleanup:
+	qopt->hw = 0;
+	if (replacing) {
+		int restore_err = otx2_mqprio_restore_old(pfvf);
+
+		otx2_mqprio_clear_replace_state(pfvf);
+		if (restore_err) {
+			netdev_err(netdev,
+				   "mqprio: replace failed and prior configuration rollback failed: %d\n",
+				   restore_err);
+			if (extack)
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "mqprio: rollback failed (%d)",
+						       restore_err);
+		} else {
+			netdev_err(netdev,
+				   "mqprio: replace failed; hardware limits restored, netdev TC layout restore deferred\n");
+			if (extack)
+				NL_SET_ERR_MSG_MOD(extack,
+						   "mqprio: replace failed; hardware limits restored, netdev TC layout restore deferred");
+			/* Failed replace destroys the new qdisc with hw_offload
+			 * unset, so mqprio_destroy() clears netdev TC after we
+			 * return. Re-apply the restored layout once that unwind
+			 * finishes.
+			 */
+			otx2_mqprio_defer_netdev_tc_restore(pfvf);
+		}
+		return err ? err : -EIO;
+	}
+	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
+	otx2_teardown_tc_mqprio(pfvf, mqprio);
+	return err;
+}
+
+static int otx2_setup_tc_root(struct otx2_nic *pfvf,
+			      struct tc_root_qopt_offload *root)
+{
+	switch (root->command) {
+	case TC_ROOT_GRAFT:
+		if (pfvf->mqprio.replace_setup_done)
+			pfvf->mqprio.replace_graft_done = true;
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
@@ -1625,10 +2544,27 @@ int otx2_init_tc(struct otx2_nic *nic)
 		return -EINVAL;
 	}
 
+	INIT_WORK(&nic->mqprio.netdev_tc_work, otx2_mqprio_netdev_tc_work);
+	WRITE_ONCE(nic->mqprio.defer_tc_work, false);
+
 	return 0;
 }
 EXPORT_SYMBOL(otx2_init_tc);
 
+void otx2_shutdown_tc_mqprio(struct otx2_nic *nic)
+{
+	/* Set the flag under RTNL: the work is only queued from ndo_setup_tc()
+	 * (RTNL held), so nothing can be queued once this section ends.
+	 * cancel_work_sync() must run after rtnl_unlock() as the work takes RTNL.
+	 */
+	rtnl_lock();
+	WRITE_ONCE(nic->mqprio.defer_tc_work, true);
+	otx2_mqprio_snap_destroy(nic);
+	rtnl_unlock();
+	cancel_work_sync(&nic->mqprio.netdev_tc_work);
+}
+EXPORT_SYMBOL(otx2_shutdown_tc_mqprio);
+
 void otx2_shutdown_tc(struct otx2_nic *nic)
 {
 	otx2_destroy_tc_flow_list(nic);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 5f7915231ca3..6ca08b12520a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -740,25 +740,25 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_ipsec_clean;
 
+	err = otx2vf_mcam_flow_init(vf);
+	if (err)
+		goto err_wq_destroy;
+
+	err = otx2_init_tc(vf);
+	if (err)
+		goto err_wq_destroy;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-		goto err_wq_destroy;
+		goto err_shutdown_tc;
 	}
 
 	otx2vf_set_ethtool_ops(netdev);
 
-	err = otx2vf_mcam_flow_init(vf);
-	if (err)
-		goto err_unreg_netdev;
-
-	err = otx2_init_tc(vf);
-	if (err)
-		goto err_unreg_netdev;
-
 	err = otx2_register_dl(vf);
 	if (err)
-		goto err_shutdown_tc;
+		goto err_unreg_netdev;
 
 	vf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
 	if (!vf->af_xdp_zc_qidx) {
@@ -784,10 +784,11 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 #endif
 err_unreg_devlink:
 	otx2_unregister_dl(vf);
-err_shutdown_tc:
-	otx2_shutdown_tc(vf);
 err_unreg_netdev:
+	otx2_shutdown_tc_mqprio(vf);
 	unregister_netdev(netdev);
+err_shutdown_tc:
+	otx2_shutdown_tc(vf);
 err_wq_destroy:
 	cancel_work_sync(&vf->reset_task);
 	cancel_work_sync(&vf->rx_mode_work);
@@ -840,7 +841,9 @@ static void otx2vf_remove(struct pci_dev *pdev)
 #endif
 
 	otx2_unregister_dl(vf);
+	otx2_shutdown_tc_mqprio(vf);
 	unregister_netdev(netdev);
+	otx2_shutdown_tc(vf);
 	if (vf->otx2_wq) {
 		cancel_work_sync(&vf->reset_task);
 		cancel_work_sync(&vf->rx_mode_work);
@@ -849,7 +852,6 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	cn10k_ipsec_clean(vf);
 	otx2_ptp_destroy(vf);
 	otx2_mcam_flow_del(vf);
-	otx2_shutdown_tc(vf);
 	otx2_shutdown_qos(vf);
 	otx2_detach_resources(&vf->mbox);
 	otx2vf_disable_mbox_intr(vf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index f160b1618efa..9ef55a6db50b 100644
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
@@ -1088,6 +1091,14 @@ static int otx2_qos_root_add(struct otx2_nic *pfvf, u16 htb_maj_id, u16 htb_defc
 		   "TC_HTB_CREATE: handle=0x%x defcls=0x%x\n",
 		   htb_maj_id, htb_defcls);
 
+	if (pfvf->mqprio.rate_limit) {
+		netdev_err(pfvf->netdev,
+			   "HTB: cannot enable while mqprio bandwidth offload is active\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "HTB: cannot enable while mqprio bandwidth offload is active");
+		return -EOPNOTSUPP;
+	}
+
 	root = otx2_qos_alloc_root(pfvf);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-- 
2.43.0

