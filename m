Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A823B058A;
	Tue, 29 Sep 2026 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649018; cv=none; b=bH+PRjuCba7D0cmu1oU5OP+RtxL7P+qQHBKWirYv0Hw0VchRAFYCfyXLkIz6VwM/e04vskWNgFYStDdmjthN9rLzn378tbnFLVFrkjZrpKEg0OBniqG5yYs4d4cbya2K6uu+NKuja9LiTnBB2jpJa4VVtJovntq3HSWxeH4djVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649018; c=relaxed/simple;
	bh=xQkfXLnTwO9JtbYEUYAmydCKh294xQ6zWQCcV/0FxfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOCku24qLAHZEDiahNFg53nLlT/TLyzqgw2AvAwh8s3cBpGujkXdD3myWnROrutwz/Y8uZsD8UA130YyqvLHLdu+6KcsvHgxWLzAoeNnqRr7sMFAUjXGzoSTyZL3EU4/H0sxO+cAOwLvOKRZnZ7hN2dwR6zTMMnKrn+DS06fSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jlEoExni; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jlEoExni"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T1XcxQ2903203;
	Mon, 28 Sep 2026 19:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	ZVCDRKc391o4fCJH+68MGg2zZbPBui0ygNw9ZUF32Q=; b=jlEoExnit+RbEYyci
	IDTnV3EulfDFq0kKlZIpQdJZTSOxUzdcmOmwbzYxYNQCuE2vxzR8mEiFcVKPzD8L
	+Ie+4PkD0PbVsgCjw6zamyVQ+G6sjkVOyb4o4xZVRcqLBxtliCi2cYJR1Hm36tm0
	iSCtm8cFBi/FamZpIbqFWxEYb259qJymrjGGZljtOA6kxkaEGpSoNHkTC6pRfr9t
	xj57M/WhoWz+ru9Ki23ARzHItaMhwmVxamU0q4oaW7lAJxRgikze6+aML1FD7LPo
	c7ihCklNjrFH5aBZbyhpolaKOGAZG6irMeGbF0kkpyCn3ZWHhIvR2bOxPZ84czYO
	haJoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gyub5tv4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 19:29:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Sep 2026 19:29:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 28 Sep 2026 19:29:31 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 653D65B6928;
	Mon, 28 Sep 2026 19:29:27 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v18 net-next 1/2] octeontx2: use atomic bitops for PF/VF and rep flags
Date: Tue, 29 Sep 2026 07:59:14 +0530
Message-ID: <20260929022915.2704627-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929022915.2704627-1-rkannoth@marvell.com>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAwOSBTYWx0ZWRfX9kaylq8pnx4T
 bcY3Xk0IYH4Dh37E9c8GGc//LoVPeUhLuWOEVMWG7qeGx9GiU43v1SAS4/+5laA8LiRPxrnKM7I
 3ttBbzorhaXhm3dslN7lnJmU0XMw8oeYk1HmmaTrzn23azaJ4Lo+gXWr0sIBSgniRWUaZMomgoj
 DqyDAnbc1Cj7q6/vAcldzJKaVqlrZ5rTOW2MRpXm+/rZRNsxmHwyaxca8yChG8I+/H5+q709s4S
 h1j077I60/U4xN2RO1ctY8ueseRraYVxKSOD9kDsnyfF6TPqNu6O0ohiHImnaSD2pl8ylo05Qic
 UXTniwN4iYqIDeTTURXQJnriyymF4uJkotljcGJ25PoF55eo2urslGeueJ1cxgZEwGu3yiXJ3yz
 iRETQmswIA6hkcXHhE4SYeDRcmWYh3WXAc/LQKiPF9qsOjb9aXv2t5qTZEi51+V2ZtiYDb/Xl8+
 uCSEx5fwwLcTT/FFQvA==
X-Proofpoint-ORIG-GUID: Z6n8h5wv8v4C7rHpbvP12lnGw9sxkTjw
X-Authority-Analysis: v=2.4 cv=e/ST2qp/ c=1 sm=1 tr=0 ts=6abb228c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=REpVsXYNUi8hGgUnutoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Z6n8h5wv8v4C7rHpbvP12lnGw9sxkTjw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAwOSBTYWx0ZWRfXw0oSVYO75RjG
 t3cMYrcDTm04YtHyN2iSuhScDDWaMtSGajJ8dw7FefUQzvHuaZ5YdKZFFzMWxKE7HjJqjzDX3Oy
 bCmPGE/hBpnqcVXG+hc8+csbKazajtE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01

Switch PF/VF and representor flags from non-atomic u64 masks to unsigned
long bitmaps with set_bit/clear_bit/test_bit.  Add helpers and
otx2_sync_flags_from_rep() to publish representor-owned flags onto the PF
mailbox context with a masked WRITE_ONCE, giving lockless NAPI readers a
consistent word without clearing PF-owned bits.

Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
(bit 21).

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |  8 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  8 +-
 .../marvell/octeontx2/nic/otx2_common.h       | 84 ++++++++++++++-----
 .../marvell/octeontx2/nic/otx2_devlink.c      |  2 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 21 ++---
 .../marvell/octeontx2/nic/otx2_flows.c        | 34 ++++----
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 78 ++++++++---------
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 30 +++----
 .../marvell/octeontx2/nic/otx2_txrx.c         | 16 ++--
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 10 +--
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c |  4 +-
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |  4 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 32 +++----
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  3 +-
 14 files changed, 185 insertions(+), 149 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 77543d472345..50ec4542c418 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -334,7 +334,7 @@ static int cn10k_outb_cpt_init(struct net_device *netdev)
 						CN10K_CPT_LF_NQX(0));
 
 	/* Set ipsec offload enabled for this device */
-	pf->flags |= OTX2_FLAG_IPSEC_OFFLOAD_ENABLED;
+	otx2_set_flag(pf, OTX2_FLAG_IPSEC_OFFLOAD_ENABLED);
 
 	cn10k_cpt_device_set_available(pf);
 	return 0;
@@ -356,7 +356,7 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
 	}
 
 	/* Set ipsec offload disabled for this device */
-	pf->flags &= ~OTX2_FLAG_IPSEC_OFFLOAD_ENABLED;
+	otx2_clear_flag(pf, OTX2_FLAG_IPSEC_OFFLOAD_ENABLED);
 
 	/* Disable CPTLF Instruction Queue (IQ) */
 	cn10k_outb_cptlf_iq_disable(pf);
@@ -820,7 +820,7 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
 	if (!is_dev_support_ipsec_offload(pf->pdev))
 		return;
 
-	if (!(pf->flags & OTX2_FLAG_IPSEC_OFFLOAD_ENABLED))
+	if (!otx2_test_flag(pf, OTX2_FLAG_IPSEC_OFFLOAD_ENABLED))
 		return;
 
 	if (pf->ipsec.sa_workq) {
@@ -945,7 +945,7 @@ bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
 	u16 dlen;
 
 	/* Check for IPSEC offload enabled */
-	if (!(pf->flags & OTX2_FLAG_IPSEC_OFFLOAD_ENABLED))
+	if (!otx2_test_flag(pf, OTX2_FLAG_IPSEC_OFFLOAD_ENABLED))
 		goto drop;
 
 	sp = skb_sec_path(skb);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 175992188c18..b421cb75e44b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -220,10 +220,10 @@ int otx2_set_mac_address(struct net_device *netdev, void *p)
 		eth_hw_addr_set(netdev, addr->sa_data);
 		/* update dmac field in vlan offload rule */
 		if (netif_running(netdev) &&
-		    pfvf->flags & OTX2_FLAG_RX_VLAN_SUPPORT)
+		    otx2_test_flag(pfvf, OTX2_FLAG_RX_VLAN_SUPPORT))
 			otx2_install_rxvlan_offload_flow(pfvf);
 		/* update dmac address in ntuple and DMAC filter list */
-		if (pfvf->flags & OTX2_FLAG_DMACFLTR_SUPPORT)
+		if (otx2_test_flag(pfvf, OTX2_FLAG_DMACFLTR_SUPPORT))
 			otx2_dmacflt_update_pfmac_flow(pfvf);
 	} else {
 		return -EPERM;
@@ -275,8 +275,8 @@ int otx2_config_pause_frm(struct otx2_nic *pfvf)
 		goto unlock;
 	}
 
-	req->rx_pause = !!(pfvf->flags & OTX2_FLAG_RX_PAUSE_ENABLED);
-	req->tx_pause = !!(pfvf->flags & OTX2_FLAG_TX_PAUSE_ENABLED);
+	req->rx_pause = otx2_test_flag(pfvf, OTX2_FLAG_RX_PAUSE_ENABLED);
+	req->tx_pause = otx2_test_flag(pfvf, OTX2_FLAG_TX_PAUSE_ENABLED);
 	req->set = 1;
 
 	err = otx2_sync_mbox_msg(&pfvf->mbox);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 5850bc1870a1..b146ca4be5db 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -482,6 +482,41 @@ struct pf_irq_data {
 	int mdevs;
 };
 
+enum otx2_flag_bits {
+	OTX2_FLAG_RX_TSTAMP_ENABLED,
+	OTX2_FLAG_TX_TSTAMP_ENABLED,
+	OTX2_FLAG_INTF_DOWN,
+	OTX2_FLAG_MCAM_ENTRIES_ALLOC,
+	OTX2_FLAG_NTUPLE_SUPPORT,
+	OTX2_FLAG_UCAST_FLTR_SUPPORT,
+	OTX2_FLAG_RX_VLAN_SUPPORT,
+	OTX2_FLAG_VF_VLAN_SUPPORT,
+	OTX2_FLAG_PF_SHUTDOWN,
+	OTX2_FLAG_RX_PAUSE_ENABLED,
+	OTX2_FLAG_TX_PAUSE_ENABLED,
+	OTX2_FLAG_TC_FLOWER_SUPPORT,
+	OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED,
+	OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED,
+	OTX2_FLAG_DMACFLTR_SUPPORT,
+	OTX2_FLAG_PTP_ONESTEP_SYNC,
+	OTX2_FLAG_ADPTV_INT_COAL_ENABLED,
+	OTX2_FLAG_TC_MARK_ENABLED,
+	OTX2_FLAG_REP_MODE_ENABLED,
+	OTX2_FLAG_PORT_UP,
+	OTX2_FLAG_IPSEC_OFFLOAD_ENABLED,
+	OTX2_FLAG_REP_VF_INITIALIZED,
+	OTX2_FLAG_MAX,
+};
+
+/* Representor-owned flags copied onto the PF mailbox context in
+ * rvu_rep_setup_tc_cb().  All other bits are owned by the PF/VF netdev.
+ */
+#define OTX2_REP_SYNC_FLAGS_MASK				\
+	(BIT(OTX2_FLAG_MCAM_ENTRIES_ALLOC) |			\
+	 BIT(OTX2_FLAG_NTUPLE_SUPPORT) |			\
+	 BIT(OTX2_FLAG_TC_FLOWER_SUPPORT) |			\
+	 BIT(OTX2_FLAG_REP_VF_INITIALIZED))
+
 struct otx2_nic {
 	void __iomem		*reg_base;
 	struct net_device	*netdev;
@@ -490,28 +525,7 @@ struct otx2_nic {
 	u16			tx_max_pktlen;
 	u16			rbsize; /* Receive buffer size */
 
-#define OTX2_FLAG_RX_TSTAMP_ENABLED		BIT_ULL(0)
-#define OTX2_FLAG_TX_TSTAMP_ENABLED		BIT_ULL(1)
-#define OTX2_FLAG_INTF_DOWN			BIT_ULL(2)
-#define OTX2_FLAG_MCAM_ENTRIES_ALLOC		BIT_ULL(3)
-#define OTX2_FLAG_NTUPLE_SUPPORT		BIT_ULL(4)
-#define OTX2_FLAG_UCAST_FLTR_SUPPORT		BIT_ULL(5)
-#define OTX2_FLAG_RX_VLAN_SUPPORT		BIT_ULL(6)
-#define OTX2_FLAG_VF_VLAN_SUPPORT		BIT_ULL(7)
-#define OTX2_FLAG_PF_SHUTDOWN			BIT_ULL(8)
-#define OTX2_FLAG_RX_PAUSE_ENABLED		BIT_ULL(9)
-#define OTX2_FLAG_TX_PAUSE_ENABLED		BIT_ULL(10)
-#define OTX2_FLAG_TC_FLOWER_SUPPORT		BIT_ULL(11)
-#define OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED	BIT_ULL(12)
-#define OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED	BIT_ULL(13)
-#define OTX2_FLAG_DMACFLTR_SUPPORT		BIT_ULL(14)
-#define OTX2_FLAG_PTP_ONESTEP_SYNC		BIT_ULL(15)
-#define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
-#define OTX2_FLAG_TC_MARK_ENABLED		BIT_ULL(17)
-#define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(18)
-#define OTX2_FLAG_PORT_UP			BIT_ULL(19)
-#define OTX2_FLAG_IPSEC_OFFLOAD_ENABLED		BIT_ULL(20)
-	u64			flags;
+	unsigned long		flags;
 	u64			*cq_op_addr;
 
 	struct bpf_prog		*xdp_prog;
@@ -593,6 +607,32 @@ struct otx2_nic {
 	unsigned long		*af_xdp_zc_qidx;
 };
 
+static inline void otx2_set_flag(struct otx2_nic *nic, unsigned int flag)
+{
+	set_bit(flag, &nic->flags);
+}
+
+static inline void otx2_clear_flag(struct otx2_nic *nic, unsigned int flag)
+{
+	clear_bit(flag, &nic->flags);
+}
+
+static inline bool otx2_test_flag(struct otx2_nic *nic, unsigned int flag)
+{
+	return test_bit(flag, &nic->flags);
+}
+
+static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
+					    unsigned long *src_flags)
+{
+	unsigned long src = READ_ONCE(*src_flags);
+	unsigned long new_flags;
+
+	new_flags = (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
+		    (src & OTX2_REP_SYNC_FLAGS_MASK);
+	WRITE_ONCE(dst->flags, new_flags);
+}
+
 static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
 {
 	return (pdev->device == PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 4a5ce0e67dda..863a5ced9a26 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -104,7 +104,7 @@ static int otx2_dl_ucast_flt_cnt_validate(struct devlink *devlink, u32 id,
 	struct otx2_nic *pfvf = otx2_dl->pfvf;
 
 	/* Check for UNICAST filter support*/
-	if (!(pfvf->flags & OTX2_FLAG_UCAST_FLTR_SUPPORT)) {
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_UCAST_FLTR_SUPPORT)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Unicast filter not enabled");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a05dee0085a3..4fe473d9ea0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -354,14 +354,14 @@ static int otx2_set_pauseparam(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	if (pause->rx_pause)
-		pfvf->flags |= OTX2_FLAG_RX_PAUSE_ENABLED;
+		otx2_set_flag(pfvf, OTX2_FLAG_RX_PAUSE_ENABLED);
 	else
-		pfvf->flags &= ~OTX2_FLAG_RX_PAUSE_ENABLED;
+		otx2_clear_flag(pfvf, OTX2_FLAG_RX_PAUSE_ENABLED);
 
 	if (pause->tx_pause)
-		pfvf->flags |= OTX2_FLAG_TX_PAUSE_ENABLED;
+		otx2_set_flag(pfvf, OTX2_FLAG_TX_PAUSE_ENABLED);
 	else
-		pfvf->flags &= ~OTX2_FLAG_TX_PAUSE_ENABLED;
+		otx2_clear_flag(pfvf, OTX2_FLAG_TX_PAUSE_ENABLED);
 
 	return otx2_config_pause_frm(pfvf);
 }
@@ -470,8 +470,7 @@ static int otx2_get_coalesce(struct net_device *netdev,
 	cmd->rx_max_coalesced_frames = hw->cq_ecount_wait;
 	cmd->tx_coalesce_usecs = hw->cq_time_wait;
 	cmd->tx_max_coalesced_frames = hw->cq_ecount_wait;
-	if ((pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED) ==
-			OTX2_FLAG_ADPTV_INT_COAL_ENABLED) {
+	if (otx2_test_flag(pfvf, OTX2_FLAG_ADPTV_INT_COAL_ENABLED)) {
 		cmd->use_adaptive_rx_coalesce = 1;
 		cmd->use_adaptive_tx_coalesce = 1;
 	} else {
@@ -502,15 +501,14 @@ static int otx2_set_coalesce(struct net_device *netdev,
 	}
 
 	/* Check and update coalesce status */
-	if ((pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED) ==
-			OTX2_FLAG_ADPTV_INT_COAL_ENABLED) {
+	if (otx2_test_flag(pfvf, OTX2_FLAG_ADPTV_INT_COAL_ENABLED)) {
 		priv_coalesce_status = 1;
 		if (!ec->use_adaptive_rx_coalesce)
-			pfvf->flags &= ~OTX2_FLAG_ADPTV_INT_COAL_ENABLED;
+			otx2_clear_flag(pfvf, OTX2_FLAG_ADPTV_INT_COAL_ENABLED);
 	} else {
 		priv_coalesce_status = 0;
 		if (ec->use_adaptive_rx_coalesce)
-			pfvf->flags |= OTX2_FLAG_ADPTV_INT_COAL_ENABLED;
+			otx2_set_flag(pfvf, OTX2_FLAG_ADPTV_INT_COAL_ENABLED);
 	}
 
 	/* 'cq_time_wait' is 8bit and is in multiple of 100ns,
@@ -556,8 +554,7 @@ static int otx2_set_coalesce(struct net_device *netdev,
 	 * 'on' to 'off'.
 	 */
 	if (priv_coalesce_status &&
-	    ((pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED) !=
-	     OTX2_FLAG_ADPTV_INT_COAL_ENABLED)) {
+	    (!otx2_test_flag(pfvf, OTX2_FLAG_ADPTV_INT_COAL_ENABLED))) {
 		hw->cq_time_wait = CQ_TIMER_THRESH_DEFAULT;
 		hw->cq_ecount_wait = CQ_CQE_THRESH_DEFAULT;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 99d78fc5a2c4..b8ff49f0f6e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -270,9 +270,9 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	flow_cfg->max_flows = allocated;
 
 	if (allocated) {
-		pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
-		pfvf->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
-		pfvf->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
+		otx2_set_flag(pfvf, OTX2_FLAG_MCAM_ENTRIES_ALLOC);
+		otx2_set_flag(pfvf, OTX2_FLAG_NTUPLE_SUPPORT);
+		otx2_set_flag(pfvf, OTX2_FLAG_TC_FLOWER_SUPPORT);
 	}
 
 	if (allocated != count)
@@ -376,7 +376,7 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	flow_cfg->unicast_offset = vf_vlan_max_flows;
 	flow_cfg->rx_vlan_offset = flow_cfg->unicast_offset +
 					flow_cfg->ucast_flt_cnt;
-	pfvf->flags |= OTX2_FLAG_UCAST_FLTR_SUPPORT;
+	otx2_set_flag(pfvf, OTX2_FLAG_UCAST_FLTR_SUPPORT);
 
 	/* Check if NPC_DMAC field is supported
 	 * by the mkex profile before setting VLAN support flag.
@@ -401,11 +401,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	}
 
 	if (frsp->enable) {
-		pfvf->flags |= OTX2_FLAG_RX_VLAN_SUPPORT;
-		pfvf->flags |= OTX2_FLAG_VF_VLAN_SUPPORT;
+		otx2_set_flag(pfvf, OTX2_FLAG_RX_VLAN_SUPPORT);
+		otx2_set_flag(pfvf, OTX2_FLAG_VF_VLAN_SUPPORT);
 	}
 
-	pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
+	otx2_set_flag(pfvf, OTX2_FLAG_MCAM_ENTRIES_ALLOC);
 	mutex_unlock(&pfvf->mbox.lock);
 
 	/* Allocate entries for Ntuple filters */
@@ -415,7 +415,7 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 		return 0;
 	}
 
-	pfvf->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
+	otx2_set_flag(pfvf, OTX2_FLAG_TC_FLOWER_SUPPORT);
 
 	refcount_set(&flow_cfg->mark_flows, 1);
 	return 0;
@@ -479,7 +479,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 		return err;
 
 	/* Check if MCAM entries are allocate or not */
-	if (!(pf->flags & OTX2_FLAG_UCAST_FLTR_SUPPORT))
+	if (!otx2_test_flag(pf, OTX2_FLAG_UCAST_FLTR_SUPPORT))
 		return 0;
 
 	pf->mac_table = devm_kzalloc(pf->dev, sizeof(struct otx2_mac_table)
@@ -501,7 +501,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 	if (!pf->flow_cfg->bmap_to_dmacindex)
 		return -ENOMEM;
 
-	pf->flags |= OTX2_FLAG_DMACFLTR_SUPPORT;
+	otx2_set_flag(pf, OTX2_FLAG_DMACFLTR_SUPPORT);
 
 	return 0;
 }
@@ -521,7 +521,7 @@ static int otx2_do_add_macfilter(struct otx2_nic *pf, const u8 *mac)
 	struct npc_install_flow_req *req;
 	int err, i;
 
-	if (!(pf->flags & OTX2_FLAG_UCAST_FLTR_SUPPORT))
+	if (!otx2_test_flag(pf, OTX2_FLAG_UCAST_FLTR_SUPPORT))
 		return -ENOMEM;
 
 	/* dont have free mcam entries or uc list is greater than alloted */
@@ -1167,7 +1167,7 @@ static int otx2_is_flow_rule_dmacfilter(struct otx2_nic *pfvf,
 	u64 ring_cookie = fsp->ring_cookie;
 	u32 flow_type;
 
-	if (!(pfvf->flags & OTX2_FLAG_DMACFLTR_SUPPORT))
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_DMACFLTR_SUPPORT))
 		return false;
 
 	flow_type = fsp->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
@@ -1364,7 +1364,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	}
 
 	ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
-	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_NTUPLE_SUPPORT))
 		return -ENOMEM;
 
 	/* Number of queues on a VF can be greater or less than
@@ -1596,7 +1596,7 @@ int otx2_destroy_ntuple_flows(struct otx2_nic *pfvf)
 	struct otx2_flow *iter, *tmp;
 	int err;
 
-	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_NTUPLE_SUPPORT))
 		return 0;
 
 	if (!flow_cfg->max_flows)
@@ -1629,7 +1629,7 @@ int otx2_destroy_mcam_flows(struct otx2_nic *pfvf)
 	struct otx2_flow *iter, *tmp;
 	int err;
 
-	if (!(pfvf->flags & OTX2_FLAG_MCAM_ENTRIES_ALLOC))
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_MCAM_ENTRIES_ALLOC))
 		return 0;
 
 	/* remove all flows */
@@ -1658,7 +1658,7 @@ int otx2_destroy_mcam_flows(struct otx2_nic *pfvf)
 		return err;
 	}
 
-	pfvf->flags &= ~OTX2_FLAG_MCAM_ENTRIES_ALLOC;
+	otx2_clear_flag(pfvf, OTX2_FLAG_MCAM_ENTRIES_ALLOC);
 	flow_cfg->max_flows = 0;
 	mutex_unlock(&pfvf->mbox.lock);
 
@@ -1721,7 +1721,7 @@ int otx2_enable_rxvlan(struct otx2_nic *pf, bool enable)
 	int err;
 
 	/* Dont have enough mcam entries */
-	if (!(pf->flags & OTX2_FLAG_RX_VLAN_SUPPORT))
+	if (!otx2_test_flag(pf, OTX2_FLAG_RX_VLAN_SUPPORT))
 		return -ENOMEM;
 
 	if (enable) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c0e2100de1d9..32582b6347ea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -879,7 +879,7 @@ static void otx2_handle_link_event(struct otx2_nic *pf)
 	struct cgx_link_user_info *linfo = &pf->linfo;
 	struct net_device *netdev = pf->netdev;
 
-	if (pf->flags & OTX2_FLAG_PORT_UP)
+	if (otx2_test_flag(pf, OTX2_FLAG_PORT_UP))
 		return;
 
 	pr_info("%s NIC Link is %s %d Mbps %s duplex\n", netdev->name,
@@ -907,11 +907,11 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
 
 	if (info->event == RVU_EVENT_PORT_STATE) {
 		if (info->evt_data.port_state) {
-			pf->flags |= OTX2_FLAG_PORT_UP;
+			otx2_set_flag(pf, OTX2_FLAG_PORT_UP);
 			netif_carrier_on(netdev);
 			netif_tx_start_all_queues(netdev);
 		} else {
-			pf->flags &= ~OTX2_FLAG_PORT_UP;
+			otx2_clear_flag(pf, OTX2_FLAG_PORT_UP);
 			netif_tx_stop_all_queues(netdev);
 			netif_carrier_off(netdev);
 		}
@@ -953,7 +953,7 @@ int otx2_mbox_up_handler_cgx_link_event(struct otx2_nic *pf,
 	}
 
 	/* interface has not been fully configured yet */
-	if (pf->flags & OTX2_FLAG_INTF_DOWN)
+	if (otx2_test_flag(pf, OTX2_FLAG_INTF_DOWN))
 		return 0;
 
 	otx2_handle_link_event(pf);
@@ -1828,7 +1828,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
 		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
-		if (!(pf->flags & OTX2_FLAG_PF_SHUTDOWN))
+		if (!otx2_test_flag(pf, OTX2_FLAG_PF_SHUTDOWN))
 			free_req->flags |= NIX_LF_DONT_FREE_TX_VTAG;
 		if (otx2_sync_mbox_msg(mbox))
 			dev_err(pf->dev, "%s failed to free nixlf\n", __func__);
@@ -2135,21 +2135,21 @@ int otx2_open(struct net_device *netdev)
 	}
 	otx2_write64(pf, NIX_LF_RAS_ENA_W1S, NIX_LF_RAS_MASK);
 
-	if (pf->flags & OTX2_FLAG_RX_VLAN_SUPPORT)
+	if (otx2_test_flag(pf, OTX2_FLAG_RX_VLAN_SUPPORT))
 		otx2_enable_rxvlan(pf, true);
 
 	/* When reinitializing enable time stamping if it is enabled before */
-	if (pf->flags & OTX2_FLAG_TX_TSTAMP_ENABLED) {
-		pf->flags &= ~OTX2_FLAG_TX_TSTAMP_ENABLED;
+	if (otx2_test_flag(pf, OTX2_FLAG_TX_TSTAMP_ENABLED)) {
+		otx2_clear_flag(pf, OTX2_FLAG_TX_TSTAMP_ENABLED);
 		otx2_config_hw_tx_tstamp(pf, true);
 	}
-	if (pf->flags & OTX2_FLAG_RX_TSTAMP_ENABLED) {
-		pf->flags &= ~OTX2_FLAG_RX_TSTAMP_ENABLED;
+	if (otx2_test_flag(pf, OTX2_FLAG_RX_TSTAMP_ENABLED)) {
+		otx2_clear_flag(pf, OTX2_FLAG_RX_TSTAMP_ENABLED);
 		otx2_config_hw_rx_tstamp(pf, true);
 	}
 
-	pf->flags &= ~OTX2_FLAG_INTF_DOWN;
-	pf->flags &= ~OTX2_FLAG_PORT_UP;
+	otx2_clear_flag(pf, OTX2_FLAG_INTF_DOWN);
+	otx2_clear_flag(pf, OTX2_FLAG_PORT_UP);
 	/* 'intf_down' may be checked on any cpu */
 	smp_wmb();
 
@@ -2161,7 +2161,7 @@ int otx2_open(struct net_device *netdev)
 		otx2_handle_link_event(pf);
 
 	/* Install DMAC Filters */
-	if (pf->flags & OTX2_FLAG_DMACFLTR_SUPPORT)
+	if (otx2_test_flag(pf, OTX2_FLAG_DMACFLTR_SUPPORT))
 		otx2_dmacflt_reinstall_flows(pf);
 
 	otx2_tc_apply_ingress_police_rules(pf);
@@ -2186,7 +2186,7 @@ int otx2_open(struct net_device *netdev)
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
-	pf->flags |= OTX2_FLAG_INTF_DOWN;
+	otx2_set_flag(pf, OTX2_FLAG_INTF_DOWN);
 	/* free NIXLF POISON irq */
 	vec = pci_irq_vector(pf->pdev,
 			     pf->hw.nix_msixoff + NIX_LF_POISON_VEC);
@@ -2220,13 +2220,13 @@ int otx2_stop(struct net_device *netdev)
 	int qidx, vec, wrk;
 
 	/* If the DOWN flag is set resources are already freed */
-	if (pf->flags & OTX2_FLAG_INTF_DOWN)
+	if (otx2_test_flag(pf, OTX2_FLAG_INTF_DOWN))
 		return 0;
 
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
-	pf->flags |= OTX2_FLAG_INTF_DOWN;
+	otx2_set_flag(pf, OTX2_FLAG_INTF_DOWN);
 	/* 'intf_down' may be checked on any cpu */
 	smp_wmb();
 
@@ -2457,7 +2457,7 @@ static int otx2_config_hw_rx_tstamp(struct otx2_nic *pfvf, bool enable)
 	struct msg_req *req;
 	int err;
 
-	if (pfvf->flags & OTX2_FLAG_RX_TSTAMP_ENABLED && enable)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_RX_TSTAMP_ENABLED) && enable)
 		return 0;
 
 	mutex_lock(&pfvf->mbox.lock);
@@ -2478,9 +2478,9 @@ static int otx2_config_hw_rx_tstamp(struct otx2_nic *pfvf, bool enable)
 
 	mutex_unlock(&pfvf->mbox.lock);
 	if (enable)
-		pfvf->flags |= OTX2_FLAG_RX_TSTAMP_ENABLED;
+		otx2_set_flag(pfvf, OTX2_FLAG_RX_TSTAMP_ENABLED);
 	else
-		pfvf->flags &= ~OTX2_FLAG_RX_TSTAMP_ENABLED;
+		otx2_clear_flag(pfvf, OTX2_FLAG_RX_TSTAMP_ENABLED);
 	return 0;
 }
 
@@ -2489,7 +2489,7 @@ static int otx2_config_hw_tx_tstamp(struct otx2_nic *pfvf, bool enable)
 	struct msg_req *req;
 	int err;
 
-	if (pfvf->flags & OTX2_FLAG_TX_TSTAMP_ENABLED && enable)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_TX_TSTAMP_ENABLED) && enable)
 		return 0;
 
 	mutex_lock(&pfvf->mbox.lock);
@@ -2510,9 +2510,9 @@ static int otx2_config_hw_tx_tstamp(struct otx2_nic *pfvf, bool enable)
 
 	mutex_unlock(&pfvf->mbox.lock);
 	if (enable)
-		pfvf->flags |= OTX2_FLAG_TX_TSTAMP_ENABLED;
+		otx2_set_flag(pfvf, OTX2_FLAG_TX_TSTAMP_ENABLED);
 	else
-		pfvf->flags &= ~OTX2_FLAG_TX_TSTAMP_ENABLED;
+		otx2_clear_flag(pfvf, OTX2_FLAG_TX_TSTAMP_ENABLED);
 	return 0;
 }
 
@@ -2537,8 +2537,8 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
 
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
-		if (pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC)
-			pfvf->flags &= ~OTX2_FLAG_PTP_ONESTEP_SYNC;
+		if (otx2_test_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC))
+			otx2_clear_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
 
 		cancel_delayed_work(&pfvf->ptp->synctstamp_work);
 		otx2_config_hw_tx_tstamp(pfvf, false);
@@ -2549,7 +2549,7 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
 					   "One-step time stamping is not supported");
 			return -ERANGE;
 		}
-		pfvf->flags |= OTX2_FLAG_PTP_ONESTEP_SYNC;
+		otx2_set_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
 		schedule_delayed_work(&pfvf->ptp->synctstamp_work,
 				      msecs_to_jiffies(500));
 		fallthrough;
@@ -2835,7 +2835,7 @@ static int otx2_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan, u8 qos,
 	if (proto != htons(ETH_P_8021Q))
 		return -EPROTONOSUPPORT;
 
-	if (!(pf->flags & OTX2_FLAG_VF_VLAN_SUPPORT))
+	if (!otx2_test_flag(pf, OTX2_FLAG_VF_VLAN_SUPPORT))
 		return -EOPNOTSUPP;
 
 	return otx2_do_set_vf_vlan(pf, vf, vlan, qos, proto);
@@ -3086,7 +3086,7 @@ int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 	 * interrupt range (QINT, CINT, GINT, ERR and POISON vectors).
 	 */
 	num_vec = hw->nix_msixoff;
-	if (pf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+	if (otx2_test_flag(pf, OTX2_FLAG_REP_MODE_ENABLED))
 		num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
 	else
 		num_vec += NIX_LF_POISON_VEC + 1;
@@ -3273,7 +3273,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pf->pdev = pdev;
 	pf->dev = dev;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
-	pf->flags |= OTX2_FLAG_INTF_DOWN;
+	otx2_set_flag(pf, OTX2_FLAG_INTF_DOWN);
 
 	hw = &pf->hw;
 	hw->pdev = pdev;
@@ -3328,23 +3328,23 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_del_mcam_entries;
 
-	if (pf->flags & OTX2_FLAG_NTUPLE_SUPPORT)
+	if (otx2_test_flag(pf, OTX2_FLAG_NTUPLE_SUPPORT))
 		netdev->hw_features |= NETIF_F_NTUPLE;
 
-	if (pf->flags & OTX2_FLAG_UCAST_FLTR_SUPPORT)
+	if (otx2_test_flag(pf, OTX2_FLAG_UCAST_FLTR_SUPPORT))
 		netdev->priv_flags |= IFF_UNICAST_FLT;
 
 	/* Support TSO on tag interface */
 	netdev->vlan_features |= netdev->features;
 	netdev->hw_features  |= NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_STAG_TX;
-	if (pf->flags & OTX2_FLAG_RX_VLAN_SUPPORT)
+	if (otx2_test_flag(pf, OTX2_FLAG_RX_VLAN_SUPPORT))
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX |
 				       NETIF_F_HW_VLAN_STAG_RX;
 	netdev->features |= netdev->hw_features;
 
 	/* HW supports tc offload but mutually exclusive with n-tuple filters */
-	if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
+	if (otx2_test_flag(pf, OTX2_FLAG_TC_FLOWER_SUPPORT))
 		netdev->hw_features |= NETIF_F_HW_TC;
 
 	netdev->hw_features |= NETIF_F_LOOPBACK | NETIF_F_RXALL;
@@ -3595,18 +3595,18 @@ static void otx2_remove(struct pci_dev *pdev)
 
 	pf = netdev_priv(netdev);
 
-	pf->flags |= OTX2_FLAG_PF_SHUTDOWN;
+	otx2_set_flag(pf, OTX2_FLAG_PF_SHUTDOWN);
 
-	if (pf->flags & OTX2_FLAG_TX_TSTAMP_ENABLED)
+	if (otx2_test_flag(pf, OTX2_FLAG_TX_TSTAMP_ENABLED))
 		otx2_config_hw_tx_tstamp(pf, false);
-	if (pf->flags & OTX2_FLAG_RX_TSTAMP_ENABLED)
+	if (otx2_test_flag(pf, OTX2_FLAG_RX_TSTAMP_ENABLED))
 		otx2_config_hw_rx_tstamp(pf, false);
 
 	/* Disable 802.3x pause frames */
-	if (pf->flags & OTX2_FLAG_RX_PAUSE_ENABLED ||
-	    (pf->flags & OTX2_FLAG_TX_PAUSE_ENABLED)) {
-		pf->flags &= ~OTX2_FLAG_RX_PAUSE_ENABLED;
-		pf->flags &= ~OTX2_FLAG_TX_PAUSE_ENABLED;
+	if (otx2_test_flag(pf, OTX2_FLAG_RX_PAUSE_ENABLED) ||
+	    otx2_test_flag(pf, OTX2_FLAG_TX_PAUSE_ENABLED)) {
+		otx2_clear_flag(pf, OTX2_FLAG_RX_PAUSE_ENABLED);
+		otx2_clear_flag(pf, OTX2_FLAG_TX_PAUSE_ENABLED);
 		otx2_config_pause_frm(pf);
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 039fd47ebf52..ddb46b580c3b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -159,7 +159,7 @@ static int otx2_tc_validate_flow(struct otx2_nic *nic,
 				 struct flow_action *actions,
 				 struct netlink_ext_ack *extack)
 {
-	if (nic->flags & OTX2_FLAG_INTF_DOWN) {
+	if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN)) {
 		NL_SET_ERR_MSG_MOD(extack, "Interface not initialized");
 		return -EINVAL;
 	}
@@ -223,7 +223,7 @@ static int otx2_tc_egress_matchall_install(struct otx2_nic *nic,
 	if (err)
 		return err;
 
-	if (nic->flags & OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED) {
+	if (otx2_test_flag(nic, OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only one Egress MATCHALL ratelimiter can be offloaded");
 		return -ENOMEM;
@@ -244,7 +244,7 @@ static int otx2_tc_egress_matchall_install(struct otx2_nic *nic,
 						    otx2_convert_rate(entry->police.rate_bytes_ps));
 		if (err)
 			return err;
-		nic->flags |= OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED;
+		otx2_set_flag(nic, OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED);
 		break;
 	default:
 		NL_SET_ERR_MSG_MOD(extack,
@@ -261,13 +261,13 @@ static int otx2_tc_egress_matchall_delete(struct otx2_nic *nic,
 	struct netlink_ext_ack *extack = cls->common.extack;
 	int err;
 
-	if (nic->flags & OTX2_FLAG_INTF_DOWN) {
+	if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN)) {
 		NL_SET_ERR_MSG_MOD(extack, "Interface not initialized");
 		return -EINVAL;
 	}
 
 	err = otx2_set_matchall_egress_rate(nic, 0, 0);
-	nic->flags &= ~OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED;
+	otx2_clear_flag(nic, OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED);
 	return err;
 }
 
@@ -505,7 +505,7 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 			mark = act->mark;
 			req->match_id = mark & OTX2_RX_MATCH_ID_MASK;
 			req->op = NIX_RX_ACTION_DEFAULT;
-			nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
+			otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
 			refcount_inc(&nic->flow_cfg->mark_flows);
 			break;
 
@@ -942,7 +942,7 @@ static void otx2_destroy_tc_flow_list(struct otx2_nic *pfvf)
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
 	struct otx2_tc_flow *iter, *tmp;
 
-	if (!(pfvf->flags & OTX2_FLAG_MCAM_ENTRIES_ALLOC))
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_MCAM_ENTRIES_ALLOC))
 		return;
 
 	list_for_each_entry_safe(iter, tmp, &flow_cfg->flow_list_tc, list) {
@@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 	/* Disable TC MARK flag if they are no rules with skbedit mark action */
 	if (flow_node->req.match_id)
 		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
-			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
+			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
 
 	if (flow_node->is_act_police) {
 		__clear_bit(flow_node->rq, &nic->rq_bmap);
 
-		if (nic->flags & OTX2_FLAG_INTF_DOWN)
+		if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN))
 			goto free_mcam_flow;
 
 		mutex_lock(&nic->mbox.lock);
@@ -1246,10 +1246,10 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	struct npc_install_flow_req *req, dummy;
 	int rc, err, entry;
 
-	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
+	if (!otx2_test_flag(nic, OTX2_FLAG_TC_FLOWER_SUPPORT))
 		return -ENOMEM;
 
-	if (nic->flags & OTX2_FLAG_INTF_DOWN) {
+	if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN)) {
 		NL_SET_ERR_MSG_MOD(extack, "Interface not initialized");
 		return -EINVAL;
 	}
@@ -1444,7 +1444,7 @@ static int otx2_tc_ingress_matchall_install(struct otx2_nic *nic,
 	if (err)
 		return err;
 
-	if (nic->flags & OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED) {
+	if (otx2_test_flag(nic, OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only one ingress MATCHALL ratelimitter can be offloaded");
 		return -ENOMEM;
@@ -1469,7 +1469,7 @@ static int otx2_tc_ingress_matchall_install(struct otx2_nic *nic,
 		err = cn10k_set_matchall_ipolicer_rate(nic, entry->police.burst, rate);
 		if (err)
 			return err;
-		nic->flags |= OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED;
+		otx2_set_flag(nic, OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED);
 		break;
 	default:
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1486,13 +1486,13 @@ static int otx2_tc_ingress_matchall_delete(struct otx2_nic *nic,
 	struct netlink_ext_ack *extack = cls->common.extack;
 	int err;
 
-	if (nic->flags & OTX2_FLAG_INTF_DOWN) {
+	if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN)) {
 		NL_SET_ERR_MSG_MOD(extack, "Interface not initialized");
 		return -EINVAL;
 	}
 
 	err = cn10k_free_matchall_ipolicer(nic);
-	nic->flags &= ~OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED;
+	otx2_clear_flag(nic, OTX2_FLAG_TC_MATCHALL_INGRESS_ENABLED);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 8d2d607bc92f..f65ba44db60b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -171,7 +171,7 @@ static void otx2_set_rxtstamp(struct otx2_nic *pfvf,
 	u64 timestamp, tsns;
 	int err;
 
-	if (!(pfvf->flags & OTX2_FLAG_RX_TSTAMP_ENABLED))
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_RX_TSTAMP_ENABLED))
 		return;
 
 	timestamp = pfvf->ptp->convert_rx_ptp_tstmp(*(u64 *)data);
@@ -374,13 +374,13 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	}
 	otx2_set_rxhash(pfvf, cqe, skb);
 
-	if (!(pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)) {
+	if (!otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED)) {
 		skb_record_rx_queue(skb, cq->cq_idx);
 		if (pfvf->netdev->features & NETIF_F_RXCSUM)
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
-	if (pfvf->flags & OTX2_FLAG_TC_MARK_ENABLED)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_TC_MARK_ENABLED))
 		skb->mark = parse->match_id;
 
 	skb_mark_for_recycle(skb);
@@ -513,7 +513,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 		     ((u64)cq->cq_idx << 32) | processed_cqe);
 
 #if IS_ENABLED(CONFIG_RVU_ESWITCH)
-	if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
 		ndev = pfvf->reps[qidx]->netdev;
 	else
 #endif
@@ -526,7 +526,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 		if (qidx >= pfvf->hw.tx_queues)
 			qidx -= pfvf->hw.xdp_queues;
-		if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+		if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
 			qidx = 0;
 		txq = netdev_get_tx_queue(ndev, qidx);
 		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
@@ -599,11 +599,11 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 
 	if (workdone < budget && napi_complete_done(napi, workdone)) {
 		/* If interface is going down, don't re-enable IRQ */
-		if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
+		if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
 			return workdone;
 
 		/* Adjust irq coalese using net_dim */
-		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
+		if (otx2_test_flag(pfvf, OTX2_FLAG_ADPTV_INT_COAL_ENABLED))
 			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
 
 		if (likely(cq))
@@ -1137,7 +1137,7 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
 
 	if (unlikely(!skb_shinfo(skb)->gso_size &&
 		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {
-		if (unlikely(pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC &&
+		if (unlikely(otx2_test_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC) &&
 			     otx2_ptp_is_sync(skb, &ptp_offset, &udp_csum_crt))) {
 			origin_tstamp = (struct ptpv2_tstamp *)
 					((u8 *)skb->data + ptp_offset +
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index f7765e19d78a..5f7915231ca3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -610,7 +610,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	vf->dev = dev;
 	vf->iommu_domain = iommu_get_domain_for_dev(dev);
 
-	vf->flags |= OTX2_FLAG_INTF_DOWN;
+	otx2_set_flag(vf, OTX2_FLAG_INTF_DOWN);
 	hw = &vf->hw;
 	hw->pdev = vf->pdev;
 	hw->rx_queues = qcount;
@@ -824,10 +824,10 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	vf = netdev_priv(netdev);
 
 	/* Disable 802.3x pause frames */
-	if (vf->flags & OTX2_FLAG_RX_PAUSE_ENABLED ||
-	    (vf->flags & OTX2_FLAG_TX_PAUSE_ENABLED)) {
-		vf->flags &= ~OTX2_FLAG_RX_PAUSE_ENABLED;
-		vf->flags &= ~OTX2_FLAG_TX_PAUSE_ENABLED;
+	if (otx2_test_flag(vf, OTX2_FLAG_RX_PAUSE_ENABLED) ||
+	    otx2_test_flag(vf, OTX2_FLAG_TX_PAUSE_ENABLED)) {
+		otx2_clear_flag(vf, OTX2_FLAG_RX_PAUSE_ENABLED);
+		otx2_clear_flag(vf, OTX2_FLAG_TX_PAUSE_ENABLED);
 		otx2_config_pause_frm(vf);
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
index 0e8a6a6486c4..7808588a0234 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -96,7 +96,7 @@ static void otx2_clean_up_rq(struct otx2_nic *pfvf, int qidx)
 	u64 iova;
 
 	/* If the DOWN flag is set SQs are already freed */
-	if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
 		return;
 
 	cq = &qset->cq[qidx];
@@ -172,7 +172,7 @@ int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
 
-	if (pf->flags & OTX2_FLAG_INTF_DOWN)
+	if (otx2_test_flag(pf, OTX2_FLAG_INTF_DOWN))
 		return -ENETDOWN;
 
 	if (queue_id >= pf->hw.rx_queues || queue_id >= pf->hw.tx_queues)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
index 2872adabc830..5f09e2960144 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
@@ -238,7 +238,7 @@ int otx2_qos_enable_sq(struct otx2_nic *pfvf, int qidx)
 	struct otx2_hw *hw = &pfvf->hw;
 	int pool_id, sq_idx, err;
 
-	if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
 		return -EPERM;
 
 	sq_idx = hw->non_qos_queues + qidx;
@@ -288,7 +288,7 @@ void otx2_qos_disable_sq(struct otx2_nic *pfvf, int qidx)
 	sq_idx = hw->non_qos_queues + qidx;
 
 	/* If the DOWN flag is set SQs are already freed */
-	if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
+	if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
 		return;
 
 	sq = &pfvf->qset.sq[sq_idx];
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..7df82c22cc12 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -93,9 +93,9 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
 	rep->flow_cfg->max_flows = allocated;
 
 	if (allocated) {
-		rep->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
-		rep->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
-		rep->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
+		set_bit(OTX2_FLAG_MCAM_ENTRIES_ALLOC, &rep->flags);
+		set_bit(OTX2_FLAG_NTUPLE_SUPPORT, &rep->flags);
+		set_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags);
 	}
 
 	INIT_LIST_HEAD(&rep->flow_cfg->flow_list);
@@ -109,14 +109,14 @@ static int rvu_rep_setup_tc_cb(enum tc_setup_type type,
 	struct rep_dev *rep = cb_priv;
 	struct otx2_nic *priv = rep->mdev;
 
-	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
 		return -EINVAL;
 
-	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
+	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
 		rvu_rep_mcam_flow_init(rep);
 
 	priv->netdev = rep->netdev;
-	priv->flags = rep->flags;
+	otx2_sync_flags_from_rep(priv, &rep->flags);
 	priv->pcifunc = rep->pcifunc;
 	priv->flow_cfg = rep->flow_cfg;
 
@@ -303,9 +303,9 @@ static void rvu_rep_state_evt_handler(struct otx2_nic *priv,
 	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
 	rep = priv->reps[rep_id];
 	if (info->evt_data.vf_state)
-		rep->flags |= RVU_REP_VF_INITIALIZED;
+		set_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags);
 	else
-		rep->flags &= ~RVU_REP_VF_INITIALIZED;
+		clear_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags);
 }
 
 int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info)
@@ -382,7 +382,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 {
 	struct rep_dev *rep = netdev_priv(dev);
 
-	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
 		return;
 
 	stats->rx_packets = rep->stats.rx_frames;
@@ -453,7 +453,7 @@ static int rvu_rep_open(struct net_device *dev)
 	struct otx2_nic *priv = rep->mdev;
 	struct rep_event evt = {0};
 
-	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
 		return 0;
 
 	netif_carrier_on(dev);
@@ -472,7 +472,7 @@ static int rvu_rep_stop(struct net_device *dev)
 	struct otx2_nic *priv = rep->mdev;
 	struct rep_event evt = {0};
 
-	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
 		return 0;
 
 	netif_carrier_off(dev);
@@ -547,7 +547,7 @@ static int rvu_rep_napi_init(struct otx2_nic *priv,
 		otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
 		otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx), BIT_ULL(0));
 	}
-	priv->flags &= ~OTX2_FLAG_INTF_DOWN;
+	otx2_clear_flag(priv, OTX2_FLAG_INTF_DOWN);
 	return 0;
 
 err_free_cints:
@@ -632,7 +632,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	int rep_id;
 
 	rvu_eswitch_config(priv, false);
-	priv->flags |= OTX2_FLAG_INTF_DOWN;
+	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
 	rvu_rep_free_cq_rsrc(priv);
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
 		rep = priv->reps[rep_id];
@@ -801,8 +801,8 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, priv);
 	priv->pdev = pdev;
 	priv->dev = dev;
-	priv->flags |= OTX2_FLAG_INTF_DOWN;
-	priv->flags |= OTX2_FLAG_REP_MODE_ENABLED;
+	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
+	otx2_set_flag(priv, OTX2_FLAG_REP_MODE_ENABLED);
 
 	hw = &priv->hw;
 	hw->pdev = pdev;
@@ -845,7 +845,7 @@ static void rvu_rep_remove(struct pci_dev *pdev)
 	struct otx2_nic *priv = pci_get_drvdata(pdev);
 
 	otx2_unregister_dl(priv);
-	if (!(priv->flags & OTX2_FLAG_INTF_DOWN))
+	if (!otx2_test_flag(priv, OTX2_FLAG_INTF_DOWN))
 		rvu_rep_destroy(priv);
 	otx2_detach_resources(&priv->mbox);
 	if (priv->hw.lmt_info)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 5bc9e2c7d800..45707c434d89 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -37,8 +37,7 @@ struct rep_dev {
 	struct delayed_work stats_wrk;
 	struct devlink_port dl_port;
 	struct otx2_flow_config	*flow_cfg;
-#define RVU_REP_VF_INITIALIZED		BIT_ULL(0)
-	u64 flags;
+	unsigned long		flags;
 	u16 rep_id;
 	u16 pcifunc;
 	u8 mac[ETH_ALEN];
-- 
2.43.0

