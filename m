Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D5443C20;
	Fri, 11 Sep 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124192; cv=none; b=oIIIkbwXHspVZ+6x/uiF/3A0WkyQFT+dQJ8aji3MZzRlvRCiWQUeNbFEyVygkPWEYSDOFz4LS+CO/B0O+KJkIgGICNOWuP65Z2CrSPy81V//cJOPDw0m9APxiKt/WjN40+Oy6dpPWVJR1nUbZ8FBzpm7MYhmNF8JLZvcHyve4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124192; c=relaxed/simple;
	bh=AWdWTWQ84PLBNFI+OF2NEuH9iHxLX09vmyhN0/rqOoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlfEXm032LHh7oe9ATQdfZ1VT36ZSgB9vVStCHavRDqGHQjayGFAfSSRTgOwuDuzlAKpw0VLuzqnwgsl1Rrw5RTw57HVQG7ygdjfcAopZtDcTQ6Wf9QnQTFmvwx2VNa2TmWg6MlvNvOwuqYDjeynER2BfEYcFV7Gm9jTBpPMaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=POcAzEFq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="POcAzEFq"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAoo0B919465;
	Fri, 11 Sep 2026 03:55:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
	FqWbmGZBkCGiYr1V/N6O1daO8QTc/K/ekqiZG7VgBU=; b=POcAzEFqBdxF6GjPX
	fVJXgxnCXUMJTxsY80DFC9CpX0DqlzG+knc8j4GFOtJr/QbB2FIu1QHkQte73ZPt
	A7mbWXolM5Jb7BQWD0p9ToGTtJFEvA4NxhS4xufpTBC/zaIcBluXMVRI+FdhfOHr
	A78REC5aWQLJy+MaKcFuPgfDRqxG2bXQ/Vg4pZOxy2if3j0g3KkrOVtWzpWa8Ih6
	6MWcbF0PXyA7mwbbXCu7i+kI6d+LhjiJnKM+NIJOA3HM6w8+yIJdv3FOur8vV3k6
	Kudg27rG7U3wNDm3QhCj+zuNXpW9xk9MQs4Uvue4UHHj1kmyYmpFgSzPb7t2aPNj
	hEYLQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gmb958wab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 03:55:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Sep 2026 03:55:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 11 Sep 2026 03:55:43 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CE0D45C68EC;
	Fri, 11 Sep 2026 03:55:38 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v15 net-next 2/2] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Fri, 11 Sep 2026 16:25:21 +0530
Message-ID: <20260911105521.689565-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911105521.689565-1-rkannoth@marvell.com>
References: <20260911105521.689565-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE1MyBTYWx0ZWRfX1xUw8RllBj9Q
 KUns6nAIDP/00qtzu7XXRgb96EIpikeMXFvtT69imt1GofgSzhIHbacb4vLpgdi1dDrr06AUUXf
 KfEGTcYf6tMmj5EZDyATSV3IPp3+2xmR4OaJmKb4WXOuoCQdG9Y1EzwMsIHJ2qtmuteHoVOqNhU
 eMre1k3grxeAK2ejZwry+3DKS+g5AFop7nGq/pmbYA4Ec5kRYZDkDeswb/QVvkSsPLktqMnH4bL
 fjvQ3NcaGZMQcl+MX6eDPFC20BhdhcGKJheRac7ZpAGTYwLBfOWgbW10MI9Xx7k4cL8tPQvHNxK
 65cI4GuG5BUTD9FdCJifvpPvxNhR9s5IZhg/dbC7tMDMbsF2rhtZKIv5lcSPXRZmi2N0yKVDMjP
 4AMaTeHwN/br1rO5GPNU2KqD7Kn+RW7ef8FkK0jl1FNBmiXJ1ueLtEzPj748EVPtFYD2EJ0eMXf
 UlvdM1LrhcwHzGP6hSg==
X-Proofpoint-GUID: ImA5MpH-Z9UppJmRGk0bcFk3vAES7GNY
X-Proofpoint-ORIG-GUID: ImA5MpH-Z9UppJmRGk0bcFk3vAES7GNY
X-Authority-Analysis: v=2.4 cv=c6M+0h9l c=1 sm=1 tr=0 ts=6aa3de30 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=qYNwLfoQtLZSC4CaE8cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE1MyBTYWx0ZWRfX6GqLC1+vV+/H
 691TwBS2iO4jqT2fj1vIuQYsVrhBd+jR4dgAbINyj5f+2w5TJ78juI/SQ4RdP3BAJzpnEHIAMSs
 MnsaQcES/F9mQLH7rrd0Ng+0MB1rtGE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01

Add TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE. Program per-queue MDQ CIR/PIR through the
NIX TX scheduler mailbox for each non-QoS transmit queue. When offload
is active, allocate one SMQ per such queue, parent every MDQ under
TL4[0], and map each traffic-class min/max rate to the queue(s) in that
class.

The NIX TX scheduler hierarchy cannot be reprogrammed live today, so
mqprio add, replace, delete, and failed-replace rollback rebuild it by
bouncing the netdev through ndo_stop()/ndo_open(). That intentionally
drops in-flight traffic on each change. Before ndo_stop(), quiesce the
transmit path with dev_deactivate() so xmit cannot race queue teardown.
After a successful bounce on a running interface, reactivate TX queues
with dev_activate(). Cache the active rates and restore MDQ shapers from
otx2_mqprio_up() during ndo_open(); fail open if restoration fails.

Track mqprio configuration in mq_offload_snap snapshots (TC layout and
rates). On tc qdisc replace, stage the new configuration while keeping
the previous snapshot for rollback: failed setup restores the old
snapshot via netdev restart when the interface is running, successful
graft is recorded through TC_ROOT_GRAFT, and teardown of the replaced
qdisc instance commits the staged snapshot without tearing down the
live offload.

Reject offload unless the interface is running and the device advertises
CIR+PIR support. Reject per-TC rates for traffic classes mapped to more
than one queue. Block concurrent use with PFC, XDP, SDP rep, or HTB (and
block HTB while mqprio offload is active). Block ethtool channel count
changes while mqprio bandwidth offload is active.

Use atomic bit operations when updating OTX2_FLAG_PORT_UP and
OTX2_FLAG_INTF_DOWN on asynchronous and netdev-restart paths.

Add a ratelimited AF debug message when validating TX scheduler queue
ownership to aid mqprio hierarchy setup failures.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 146 +++-
 .../marvell/octeontx2/nic/otx2_common.h       |  27 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  16 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 746 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  11 +
 8 files changed, 964 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d80d2c00bd84..2d1ab8c761c4 100644
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
index b421cb75e44b..5bad2466da0c 100644
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
@@ -844,6 +987,7 @@ void otx2_txschq_stop(struct otx2_nic *pfvf)
 
 	/* Clear the txschq list */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		pfvf->hw.txschq_cnt[lvl] = 0;
 		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
 			pfvf->hw.txschq_list[lvl][schq] = 0;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 7e09c1444a6d..6e7132f27b62 100644
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
+	u64 min_rate[TC_QOPT_MAX_QUEUE];
+	u64 max_rate[TC_QOPT_MAX_QUEUE];
+	__u8 num_tc;
+	__u16 count[TC_QOPT_MAX_QUEUE];
+	__u16 offset[TC_QOPT_MAX_QUEUE];
+};
+
+struct otx2_mqprio {
+	u32	flags;
+	u64	*min_rate;
+	u64	*max_rate;
+	bool	rate_limit;
+	bool	replace_setup_done;
+	bool	replace_graft_done;
+};
+
 struct otx2_nic {
 	void __iomem		*reg_base;
 	struct net_device	*netdev;
@@ -516,6 +534,10 @@ struct otx2_nic {
 	unsigned long		flags;
 	u64			*cq_op_addr;
 
+	struct otx2_mqprio	mqprio;
+	struct mq_offload_snap	*cur_mq_snap;
+	struct mq_offload_snap	*old_mq_snap;
+
 	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
@@ -1275,6 +1297,11 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
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
index 91d346d114af..b7bd08129fb6 100644
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
index 9a05aa5d902d..e63ead3b1113 100644
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
index 32582b6347ea..1e17f8d49fd4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2007,6 +2007,14 @@ int otx2_open(struct net_device *netdev)
 	if (err)
 		goto err_free_mem;
 
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
@@ -2205,6 +2213,7 @@ int otx2_open(struct net_device *netdev)
 	free_irq(vec, pf);
 err_disable_napi:
 	otx2_disable_napi(pf);
+err_free_hw:
 	otx2_free_hw_resources(pf);
 err_free_mem:
 	otx2_free_queue_mem(qset);
@@ -2280,6 +2289,7 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
+	synchronize_net();
 	otx2_free_queue_mem(qset);
 	/* Do not clear RQ/SQ ringsize settings */
 	memset_startat(qset, 0, sqe_cnt);
@@ -2923,6 +2933,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
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
index ddb46b580c3b..70d99ae3defb 100644
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
@@ -1600,14 +1609,750 @@ static int otx2_setup_tc_block(struct net_device *netdev,
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
+	/* Rebuild the TX scheduler via netdev restart when running; otx2_mqprio_up()
+	 * alone is insufficient after a failed replace that already bounced the
+	 * interface. If open failed, TX schedulers were freed; defer shaper restore
+	 * to the next successful ndo_open() via otx2_mqprio_up().
+	 */
+	pfvf->mqprio.rate_limit = true;
+
+	if (netif_running(netdev)) {
+		err = otx2_mqprio_restart_netdev(netdev, true);
+		if (err)
+			return err;
+	} else if (pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]) {
+		err = otx2_mqprio_up(pfvf);
+		if (err)
+			return err;
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
+static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+
+	pfvf->mqprio.rate_limit = false;
+	otx2_mqprio_clear_replace_state(pfvf);
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
+		netdev_warn(pfvf->netdev,
+			    "mqprio: failed to clear hardware shapers: %d; clearing software state\n",
+			    err);
+		otx2_mqprio_clear_sw(pfvf);
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
+ * LBK carrier on) runs correctly.
+ *
+ * Intentional behaviour: this full stop/open cycle drops in-flight traffic
+ * (carrier off, IRQ/NAPI teardown, queue drain).  The NIX TX scheduler must
+ * be reallocated (e.g. one SMQ per non-QoS queue) and cannot be reprogrammed
+ * live today, so a netdev bounce is required on every mqprio add, replace,
+ * delete, and rollback.  Users see a brief connectivity blip; this is not a
+ * bug to "fix" without implementing the live-reprogramming path noted below.
+ * If open fails, the interface is left administratively down without calling
+ * ndo_stop() again on resources already torn down by the open error path.
+ *
+ * Quiesce the transmit path like __dev_close_many() before ndo_stop() so
+ * otx2_xmit() cannot race otx2_free_queue_mem().
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
+	netdev_info(netdev,
+		    "mqprio: restarting interface to reprogram TX scheduler; in-flight traffic will be dropped\n");
+
+	if (running) {
+		clear_bit(__LINK_STATE_START, &netdev->state);
+		smp_mb__after_atomic(); /* Commit netif_running(). */
+	}
+	dev_deactivate(netdev, true);
+
+	err = ops->ndo_stop(netdev);
+	if (err) {
+		if (running) {
+			set_bit(__LINK_STATE_START, &netdev->state);
+			dev_activate(netdev);
+		}
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
+		dev_activate(netdev);
+	} else if (err) {
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
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	bool had_mqprio = pfvf->mqprio.rate_limit;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+	int err;
+
+	qopt->hw = 0;
+
+	/* tc qdisc replace runs setup on the new mqprio before destroying the
+	 * old one. replace_setup_done and TC_ROOT_GRAFT distinguish stale
+	 * old-instance teardown from graft failure after setup.
+	 */
+	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
+		err = 0;
+		if (pfvf->mqprio.replace_graft_done)
+			otx2_mqprio_snap_commit(pfvf);
+		else
+			err = otx2_mqprio_restore_old(pfvf);
+		otx2_mqprio_clear_replace_state(pfvf);
+		return err;
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
+	struct netlink_ext_ack *extack = mqprio->extack;
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
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
+	if (!list_empty(&pfvf->qos.qos_tree)) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while HTB is active\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mqprio: cannot enable offload while HTB is active");
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
+
+	if (replacing) {
+		pfvf->mqprio.replace_setup_done = true;
+		pfvf->mqprio.replace_graft_done = false;
+	} else {
+		otx2_mqprio_snap_commit(pfvf);
+	}
+
+	return 0;
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
@@ -1632,6 +2377,7 @@ EXPORT_SYMBOL(otx2_init_tc);
 void otx2_shutdown_tc(struct otx2_nic *nic)
 {
 	otx2_destroy_tc_flow_list(nic);
+	otx2_mqprio_snap_destroy(nic);
 }
 EXPORT_SYMBOL(otx2_shutdown_tc);
 
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

