Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8A41CB5E;
	Tue, 11 Aug 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438296; cv=none; b=u3FaB+igsoRWWYlx4fWI+DjUqaH9pVTeyXN+DtSlhxuMI/HEQEg9SzwbRjrikJ53qVkRu4vMQeWQ1mEgpMxZlf8xx3Y5+0LWETaartsrh704xlmFD3QE76ity+U4oD57kACwKyAhepMRCNiiKQ5zXaXDQk9QzBYPo/WKuAF0Ae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438296; c=relaxed/simple;
	bh=SulzMiYpX9rTYmY+T5Wvw9IrLw41Z651W5XHYYyOAa0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1qqi03N012Ja6FRXPZcE+TRXSXX1qRFDlGFGnK6GJpjZKK6fk+RtpQMAxJWhhu9QubRTduWun291VDg4iM8blw2bVYlvq01Nh9Ag2x3x/e1dlnDX2zQ5YilnYyAs9wvIkFhpZhnWYYqTSaelUzxNP4o02U6npTNkbNOBe21bJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PHNN+wvB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PHNN+wvB"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMrMkp1812465;
	Tue, 11 Aug 2026 01:50:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=TLtXIiS8yjnV3vSw0Uc/+lZ
	4mivgegw4fSrShoyj+Nw=; b=PHNN+wvBX8K4Gp7mwDMrGxPdZCi20UtcRRlZodN
	1slVXVxgae/my3A3b4z3UhGzO/9+u1gmo8aVkkE5gXQ7n867NF1hGw6GYISqcZCe
	040dHFR6HAwi9SxolGac60snd95YY8RyKhkj/AIr3KbutcC7ecmPwO6Dk+v4UlpV
	YDCPe7CbmV4GuFsju543T8D9ajy3w0UUaWAJbQiwdWO/9KqY+4hGzW5KoM+kbJP9
	5qp3mrPMKU8+87y2KwBKlYVmgJsLBnWPqinbwh3JoLGTW9QIvSoMTzjHSj0nLv2j
	JnIO6/w8D1xrW7+hjNXXDgandnubHrRDGeycTRKnwQMQZOg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fx1tmg9q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:50:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 01:50:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 01:50:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 80E473F706B;
	Tue, 11 Aug 2026 01:50:52 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v7 net-next] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Tue, 11 Aug 2026 14:20:50 +0530
Message-ID: <20260811085050.3212280-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfXzqO5anE2bQjX
 U2K33DKSL9gn6EM1r/dfxU1Eu78u5U4G6JHSunejzadqioJzBiDnVq2rkkjH1ynuMUMy3VzOgqz
 iDeOdKFBJI/BgLawlJj6FW+oXwicFQ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfXz/JL1OxJV00q
 4gKIEwNEAnY6wzvwvqQ/MZFYUd2Ri8Qxnv7wyxfY/ozYL1nJpxFh9WGTcihC6HZCeVaWQjnE9+U
 nE/ztOCejK7JU6qEbWQ58sCTP9c6Wco5rGsMLo0IoNDSp+9MswR176NS3njj14lDnL4Gqmek02c
 dLeBcyXNmjxz3k5OE/Piv/sUbGZTXgyubzRUdwzT0vkTYwvRShv1AdF+EXZOQN85PGENXAJBT/R
 lX8PolT/V9vr0A27O+dID5bIHe46SIsqeqrPZzhJwBDJ0WCh955qa+Ny2coNfHbopMzrYtEqv3E
 xYbTRVaWuqRJhOwlwPToIqpjGmvVhu8PcFmVHMW0Rr0SBtjg27ps3w6U/cu8vklG5cBOjKIeEmu
 WKX0UJSMs+i/Hb+fsRuDMaHy6XrYEqGP5/U7Up+t+sW7+JXAk4NawidsonNATDP9vV+VO+3sFx4
 EkhvyGcwdNR0HWtoapw==
X-Proofpoint-GUID: df_qi1ZH3NFBM4ryLDURgZeh_NIAbejK
X-Proofpoint-ORIG-GUID: df_qi1ZH3NFBM4ryLDURgZeh_NIAbejK
X-Authority-Analysis: v=2.4 cv=dPWWXuZb c=1 sm=1 tr=0 ts=6a7ae272 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=gfYIVBMOQYzuyo8xvPAA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01

Add TC_SETUP_QDISC_MQPRIO handling to offload per-queue MDQ CIR/PIR
shaping for mqprio channel mode with TC_MQPRIO_SHAPER_BW_RATE. When
bandwidth offload is enabled, allocate one SMQ per non-QoS transmit
queue, parent all MDQs under TL4[0], and program min/max rates by
dividing each traffic class byte/s limit across its queues.

Setting up or tearing down the offload restarts the netdev via
ndo_stop()/ndo_open() to rebuild the TX scheduler hierarchy. That
clears carrier, tears down IRQ/NAPI and drops in-flight traffic; if
ndo_open() fails the interface is left administratively down. Offload
setup is rejected unless the interface is already running.

Reject incompatible configurations (HTB, PFC, XDP, SDP rep, missing
CIR+PIR support) and out-of-range rates. Validate queue mappings
against hw.non_qos_queues and reject per-TC rates smaller than the
queue count that integer division would truncate to zero. Track offload
state in mqprio_rate_limit instead of pfvf->flags to avoid races with
the mbox up-handler, skip spurious teardown on tc qdisc replace, and
clear all MDQ shapers before applying a new mapping so queues dropped
from a TC layout do not retain stale limits. Restore cached shapers
across routine netdev stop/open via otx2_mqprio_up().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

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
 .../marvell/octeontx2/nic/otx2_common.c       | 154 +++++-
 .../marvell/octeontx2/nic/otx2_common.h       |  11 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  11 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 454 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  15 +
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |   1 +
 9 files changed, 664 insertions(+), 2 deletions(-)

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
index ca73a94db794..dfabda1201bd 100644
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
+		if (pfvf->mqprio_rate_limit) {
+			/* TODO: Program NIX_AF_TL4X_TOPOLOGY on TL4[0]. MQPRIO
+			 * parents every MDQ under the same TL4 with schedule
+			 * priority 0, so sibling arbitration depends on the TL4
+			 * topology register. Only the HTB path programs this
+			 * today and the AF does not reset it on schq realloc,
+			 * so a TL4 reused after HTB teardown can retain stale
+			 * RR_PRIO/PRIO_ANCHOR and starve some TX queues.
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
 
+	if (pfvf->mqprio_rate_limit)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..cf1cd391bf52 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -515,6 +515,12 @@ struct otx2_nic {
 	u64			flags;
 	u64			*cq_op_addr;
 
+	u32			mqprio_flags;
+	u64			*mqprio_min_rate;
+	u64			*mqprio_max_rate;
+	bool			mqprio_rate_limit;
+	bool			mqprio_skip_teardown;
+
 	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
@@ -1246,6 +1252,11 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
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
index f110dfa42360..832f05cf129e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -413,6 +413,12 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 	u8 old_pfc_en;
 	int err;
 
+	if (pfvf->mqprio_rate_limit && pfc->pfc_en) {
+		netdev_err(dev,
+			   "PFC: cannot enable while mqprio bandwidth offload is active\n");
+		return -EOPNOTSUPP;
+	}
+
 	old_pfc_en = pfvf->pfc_en;
 	pfvf->pfc_en = pfc->pfc_en;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a0340f3422bf..c1317fbcd848 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -287,6 +287,14 @@ static int otx2_set_channels(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (pfvf->mqprio_rate_limit &&
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
index c995f2900859..70c95e9c5bf8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1980,6 +1980,10 @@ int otx2_open(struct net_device *netdev)
 	if (err)
 		goto err_free_mem;
 
+	err = otx2_mqprio_up(pf);
+	if (err)
+		goto err_free_hw;
+
 	/* Register NAPI handler */
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
@@ -2140,6 +2144,7 @@ int otx2_open(struct net_device *netdev)
 	free_irq(vec, pf);
 err_disable_napi:
 	otx2_disable_napi(pf);
+err_free_hw:
 	otx2_free_hw_resources(pf);
 err_free_mem:
 	otx2_free_queue_mem(qset);
@@ -2846,6 +2851,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
 	bool if_up = netif_running(pf->netdev);
 	struct bpf_prog *old_prog;
 
+	if (prog && pf->mqprio_rate_limit) {
+		netdev_err(dev,
+			   "XDP: cannot attach while mqprio bandwidth offload is active\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (prog && dev->mtu > MAX_XDP_MTU) {
 		netdev_warn(dev, "Jumbo frames not yet supported with XDP\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 039fd47ebf52..5bd95f061662 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -16,6 +16,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/ipv6.h>
+#include <net/pkt_sched.h>
 
 #include "cn10k.h"
 #include "otx2_common.h"
@@ -31,6 +32,8 @@
 
 #define MCAST_INVALID_GRP		(-1U)
 #define RATE_MANTISSA_BITS		8
+/* Max egress shaping rate the NIX TLX encoder supports (130816 Mbps). */
+#define OTX2_MQPRIO_MAX_RATE_BYTES_PS	((MAX_BURST_SIZE * 1000000ULL) / 8ULL)
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
@@ -61,6 +64,9 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 			*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
 		}
 	} else {
+		/* burst 0: largest encodable burst (CN10K_MAX_BURST_SIZE on
+		 * CN10K), not a minimal burst.
+		 */
 		*burst_exp = MAX_BURST_EXPONENT;
 		*burst_mantissa = max_mantissa;
 	}
@@ -1600,14 +1606,462 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 					  nic, nic, ingress);
 }
 
+/* Free the per-queue min/max rate caches. */
+static void otx2_mqprio_free_cache(struct otx2_nic *pfvf)
+{
+	devm_kfree(pfvf->dev, pfvf->mqprio_min_rate);
+	devm_kfree(pfvf->dev, pfvf->mqprio_max_rate);
+	pfvf->mqprio_min_rate = NULL;
+	pfvf->mqprio_max_rate = NULL;
+	pfvf->mqprio_flags = 0;
+}
+
+static int otx2_mqprio_alloc_cache(struct otx2_nic *pfvf)
+{
+	u16 num_txq = pfvf->hw.non_qos_queues;
+
+	otx2_mqprio_free_cache(pfvf);
+
+	pfvf->mqprio_min_rate = devm_kcalloc(pfvf->dev, num_txq,
+					     sizeof(*pfvf->mqprio_min_rate),
+					     GFP_KERNEL);
+	pfvf->mqprio_max_rate = devm_kcalloc(pfvf->dev, num_txq,
+					     sizeof(*pfvf->mqprio_max_rate),
+					     GFP_KERNEL);
+	if (!pfvf->mqprio_min_rate || !pfvf->mqprio_max_rate) {
+		otx2_mqprio_free_cache(pfvf);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static bool otx2_txschq_is_allocated(struct otx2_nic *pfvf)
+{
+	int lvl, idx;
+
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		for (idx = 0; idx < pfvf->hw.txschq_cnt[lvl]; idx++) {
+			if (pfvf->hw.txschq_list[lvl][idx])
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/* Tear down mqprio bandwidth offload: clear per-queue shapers,
+ * mqprio_rate_limit, netdev TC mappings, and the cached rates.  Called on
+ * explicit mqprio teardown (tc qdisc del) and error cleanup, not on
+ * routine netdev stop/open cycles where the offload stays active.
+ */
+int otx2_mqprio_down(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+	int err = 0;
+
+	if (!pfvf->mqprio_rate_limit)
+		return 0;
+
+	if (otx2_txschq_is_allocated(pfvf))
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+
+	pfvf->mqprio_rate_limit = false;
+	pfvf->mqprio_skip_teardown = false;
+	netdev_set_num_tc(netdev, 0);
+	otx2_mqprio_free_cache(pfvf);
+
+	return err;
+}
+
+int otx2_mqprio_up(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+	int txq, err;
+
+	if (!pfvf->mqprio_rate_limit)
+		return 0;
+
+	if (!pfvf->mqprio_min_rate || !pfvf->mqprio_max_rate)
+		return 0;
+
+	for (txq = 0; txq < pfvf->hw.non_qos_queues; txq++) {
+		u64 min_rate = 0, max_rate = 0;
+
+		if (pfvf->mqprio_flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = pfvf->mqprio_min_rate[txq];
+		if (pfvf->mqprio_flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = pfvf->mqprio_max_rate[txq];
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
+ * traffic.  If open fails, netif_close() clears IFF_UP and leaves the
+ * interface administratively down.
+ */
+static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	int err;
+
+	netdev_info(netdev,
+		    "mqprio: restarting interface to reprogram TX scheduler; in-flight traffic will be dropped\n");
+
+	err = ops->ndo_stop(netdev);
+	if (err)
+		return err;
+
+	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation. */
+	if (rate_limit)
+		pfvf->mqprio_rate_limit = true;
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
+		/* Caller holds netdev/RTNL lock; dev_close() would deadlock. */
+		netif_close(netdev);
+	}
+
+	return err;
+}
+
+static u64 otx2_mqprio_per_queue_rate(u64 rate, u32 qcount)
+{
+	if (!rate || qcount <= 1)
+		return rate;
+
+	return div_u64(rate, qcount);
+}
+
+static int otx2_mqprio_validate_tc_rate(struct net_device *netdev, u64 rate,
+					u32 qcount, int tc, const char *name)
+{
+	if (!rate || qcount <= 1 || rate >= qcount)
+		return 0;
+
+	netdev_err(netdev,
+		   "mqprio: %s rate %llu for tc %d too small for %u queues\n",
+		   name, rate, tc, qcount);
+	return -EINVAL;
+}
+
+static int otx2_mqprio_validate_txqs(struct net_device *netdev,
+				     struct tc_mqprio_qopt *qopt)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	u16 num_txq = pfvf->hw.non_qos_queues;
+	int tc, txq;
+
+	if (qopt->num_tc > num_txq) {
+		netdev_err(netdev, "Number of TCs (%u) exceeds hw queues %u\n",
+			   qopt->num_tc, num_txq);
+		return -EINVAL;
+	}
+
+	if (num_txq > MAX_TXSCHQ_PER_FUNC) {
+		netdev_err(netdev,
+			   "Number of queues (%u) exceeds max scheduler queues %u\n",
+			   num_txq, MAX_TXSCHQ_PER_FUNC);
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
+	if (rate_bytes_ps > OTX2_MQPRIO_MAX_RATE_BYTES_PS)
+		return false;
+
+	if (rate_bytes_ps > div_u64(U64_MAX, 8))
+		return false;
+
+	mbps = otx2_convert_rate(rate_bytes_ps);
+	return mbps <= 2 || ilog2(mbps / 2) <= MAX_RATE_EXPONENT;
+}
+
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	bool had_mqprio = pfvf->mqprio_rate_limit;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+	int down_err, err;
+
+	qopt->hw = 0;
+
+	/* tc qdisc replace grafts the new mqprio before destroying the old
+	 * one. The new configuration has already reprogrammed hardware and
+	 * set mqprio_rate_limit, so ignore teardown from
+	 * the replaced qdisc.
+	 */
+	if (pfvf->mqprio_skip_teardown) {
+		pfvf->mqprio_skip_teardown = false;
+		return 0;
+	}
+
+	/* Skip the netdev restart when mqprio offload was not active. */
+	if (!had_mqprio)
+		return 0;
+
+	down_err = otx2_mqprio_down(pfvf);
+
+	if (if_up) {
+		err = otx2_mqprio_restart_netdev(netdev, false);
+		if (err)
+			return err;
+	}
+
+	return down_err;
+}
+
+static int otx2_setup_tc_mqprio(struct net_device *netdev,
+				struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	bool replacing = pfvf->mqprio_rate_limit;
+	bool if_up = netif_running(netdev);
+	int tc, txq, err, i;
+
+	if (!qopt->hw)
+		return otx2_teardown_tc_mqprio(pfvf, mqprio);
+
+	if (!if_up) {
+		netdev_err(netdev, "mqprio: setup requires interface UP\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+		netdev_err(netdev, "Unsupported mqprio shaper %#x\n", mqprio->shaper);
+		return -EOPNOTSUPP;
+	}
+
+	if (!test_bit(QOS_CIR_PIR_SUPPORT, &pfvf->hw.cap_flag)) {
+		netdev_err(netdev,
+			   "mqprio: bandwidth offload requires CIR+PIR support\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_otx2_sdp_rep(pfvf->pdev)) {
+		netdev_err(netdev, "mqprio: bandwidth offload not supported on SDP rep\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (otx2_qos_htb_active(pfvf)) {
+		netdev_err(netdev, "mqprio: cannot enable offload while HTB is active\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pfvf->pfc_en) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while PFC is enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pfvf->xdp_prog) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while XDP is active\n");
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
+			return -EINVAL;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE) {
+			err = otx2_mqprio_validate_tc_rate(netdev, min_rate,
+							   qcount, tc,
+							   "min");
+			if (err)
+				return err;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE) {
+			err = otx2_mqprio_validate_tc_rate(netdev, max_rate,
+							   qcount, tc,
+							   "max");
+			if (err)
+				return err;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE &&
+		    !otx2_mqprio_rate_valid(otx2_mqprio_per_queue_rate(min_rate,
+								       qcount))) {
+			netdev_err(netdev,
+				   "mqprio: min_rate %llu for tc %d exceeds hardware limit\n",
+				   min_rate, tc);
+			return -EINVAL;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE &&
+		    !otx2_mqprio_rate_valid(otx2_mqprio_per_queue_rate(max_rate,
+								       qcount))) {
+			netdev_err(netdev,
+				   "mqprio: max_rate %llu for tc %d exceeds hardware limit\n",
+				   max_rate, tc);
+			return -EINVAL;
+		}
+	}
+
+	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
+	if (err)
+		return err;
+
+	err = otx2_mqprio_alloc_cache(pfvf);
+	if (err)
+		goto cleanup;
+
+	err = otx2_mqprio_validate_txqs(netdev, qopt);
+	if (err)
+		goto cleanup;
+
+	/* otx2_mqprio_up() may have restored the previous configuration during
+	 * the restart above. Clear every MDQ shaper before applying the new
+	 * mapping so queues dropped from the TC layout do not keep stale
+	 * limits in hardware.
+	 */
+	if (otx2_txschq_is_allocated(pfvf)) {
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+		if (err)
+			goto cleanup;
+	}
+
+	pfvf->mqprio_flags = mqprio->flags;
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+		u32 qcount = qopt->count[tc];
+
+		/* Rates omitted from tc mqprio are passed as zero and both MDQ
+		 * shaper registers are programmed; see
+		 * otx2_nix_tm_set_queue_shaper().
+		 */
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = otx2_mqprio_per_queue_rate(mqprio->min_rate[tc],
+							      qcount);
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = otx2_mqprio_per_queue_rate(mqprio->max_rate[tc],
+							      qcount);
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qcount; txq++) {
+			netdev_dbg(netdev,
+				   "mqprio: tc %d txq %d min_rate %llu max_rate %llu\n",
+				   tc, txq, min_rate, max_rate);
+
+			pfvf->mqprio_min_rate[txq] = min_rate;
+			pfvf->mqprio_max_rate[txq] = max_rate;
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
+		pfvf->mqprio_skip_teardown = true;
+
+	return 0;
+
+cleanup:
+	otx2_teardown_tc_mqprio(pfvf, mqprio);
+	return err;
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
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..f7693f02a07c 100644
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
 
+	if (pfvf->mqprio_rate_limit &&
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

