Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3B3D9544;
	Thu, 20 Aug 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216798; cv=none; b=qu/b37XelHHy7pyHIreQxJvROojSMXSKl2/mYJ5qn7vDiASkhylgjxHeB4GAo6Ga9DiuCfb5BckTzaG6UV5+eB2O/oUbWPNwn/SxgYPXX2OmjUOD1X+z8tru3z0QIBwt1kcGu6er7Y6txEcm6+3f9Wt1cxUXQvvYRic7uGtIQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216798; c=relaxed/simple;
	bh=vLCJuTo2O4w3Vc3mb/CjGxyudUJug6yKCjoKKtnk1tQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qxi/RWXYH7wffb6AH08dNc8XuID3hp7IsfqTmvwvAM2szJfRXY18x4cDFMDhOzP4XrIfKDsCIKMizcdv2t59bEuT2eBS0twe4WRFkWUHuJE4oQe1HWtlX8WoVTo1LiWOnieT6J03w+NN+pT065ZDZ1g6ZWNsVn0dRFTxFWSSQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KP1H4jTT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KP1H4jTT"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K7kOQN528169;
	Thu, 20 Aug 2026 02:06:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=h0+GZBfUH1rNYwZE6ixoi9F
	pqhGiRmR7WG1iPnQ75uo=; b=KP1H4jTTuv+4xEffutVbvv/B+uA214+9lpuKoft
	IF/VEwTS9ztHs9G3EskMgY84quReyzJTDE/qJ2b/pXXYTNsubfrhniskdnEM5x7K
	JFbOn4Y+CFHPzaj+cx9kwmNQfnjedP9YzWowFEhnXue+v/hvjSpRZcz+jQV9DYF+
	enTCQPb3Zd9lECQmDP72vCNE0PUpt6B1ehdmlPYGOzsIpIE5LulH1oJKOzdOi0jQ
	PgcMhgqAyD7JHfRvfAyhk6My/17E7uLTyHW3zumYOUrk4dMcMAz9Q3uqgp1TvUvd
	DjgKlTWIoqlul3DFnsshyv0e9PgMutD6A0vFvBEB+oueOnw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yeveyu2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 02:06:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 02:05:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 02:05:53 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D5B2B3F704F;
	Thu, 20 Aug 2026 02:05:47 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sumang@marvell.com>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <sdf@fomichev.me>,
        <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup
Date: Thu, 20 Aug 2026 14:35:33 +0530
Message-ID: <20260820090533.2681578-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2NiBTYWx0ZWRfX4MnFr7i4/3Yt
 PmvzKxDEtopFeCopU4v78KGWxUGtVs3r2G8hS7WHa/AMz/8tsd+Ss+xxrDgPnuv3Kkq1zBgA5mX
 OPMB+BVwjTu1FnNVBr6A0xJ6aRE/gIc=
X-Proofpoint-GUID: ZrqwCeOWjkmBfIwRsZWaI25S2fv9q-mO
X-Proofpoint-ORIG-GUID: ZrqwCeOWjkmBfIwRsZWaI25S2fv9q-mO
X-Authority-Analysis: v=2.4 cv=Wq8b99fv c=1 sm=1 tr=0 ts=6a86c37b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=QvjZ8wtghHIPiP3emeoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2NiBTYWx0ZWRfXxGO3doyG4TEv
 GpOh1gurZo5ErpYKHE4pq+JHDG9Uz+Mwr1I1vlVfZspCtu4bxF5cDRolP8VNPRJEQ3MKUeDNfbk
 p8CgVM87ygRHQ1Yj1U7SHQodC7hxKEfOXL8p0Xu0y5a45Z8svdP6i1KvFJm29fOSbJI/LydHQgQ
 QCz9CbBKdpOtNDsRi2tuR4zeTz5uEWb6+iJZCsKvAYvj0HCjpVbTJbSFyZGrysi7mIj5dOlid2C
 Bkh5tYPcVCH2kGvkb3FloS5kz7vMko7NRizKPv0wg9pdmTm5jy708xly5pcb9jnMzRHDDKOCno3
 EMzRKkm0jZQagn3JFvD+zy0dXr7iwxLfIAHPj+UWBugjpvyeaMQtp5K5ksX6+pDgOeSogz0B9ln
 POnZteuGCveHffGKaI2ZCiljoHvFiPhCFY6vTX3vU/q7afcJglqGuVhtQ7ALU9caeqBoFsbeCRw
 zM/xS43rpxm5Sqk6KmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

af_xdp_zc_qidx tracks receive queues using AF_XDP zero-copy and is
allocated during PF/VF probe. Representors and other non-AF_XDP paths
leave the pointer NULL, but several call sites used test_bit() on it
unconditionally.

Switching to devlink eswitch mode creates representors and runs
otx2_init_hw_resources(), which reaches otx2_pool_aq_init() and oopses
when dereferencing the NULL bitmap. Add NULL checks before every
af_xdp_zc_qidx test_bit() use in the RSS, ethtool, XSK, and pool init
paths.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c  | 6 ++++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 ++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c     | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3d253132a17f..8a36ab8ab19e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -333,7 +333,8 @@ int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id, const u32 *ind_tbl)
 	/* Get memory to put this msg */
 	for (idx = 0; idx < rss->rss_size; idx++) {
 		/* Ignore the queue if AF_XDP zero copy is enabled */
-		if (test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))
+		if (pfvf->af_xdp_zc_qidx &&
+		    test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))
 			continue;
 
 		aq = otx2_mbox_alloc_msg_nix_aq_enq(mbox);
@@ -1510,7 +1511,8 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 	if (type != AURA_NIX_RQ)
 		return 0;
 
-	if (!test_bit(pool_id, pfvf->af_xdp_zc_qidx)) {
+	if (pfvf->af_xdp_zc_qidx &&
+	    !test_bit(pool_id, pfvf->af_xdp_zc_qidx)) {
 		pp_params.order = get_order(buf_size);
 		pp_params.flags = PP_FLAG_DMA_MAP;
 		pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a0340f3422bf..9bee1b91eeaa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -939,7 +939,8 @@ static int otx2_get_rxfh(struct net_device *dev,
 
 	for (idx = 0; idx < rss->rss_size; idx++) {
 		/* Ignore if the rx queue is AF_XDP zero copy enabled */
-		if (test_bit(rss->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
+		if (pfvf->af_xdp_zc_qidx &&
+		    test_bit(rss->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
 			continue;
 		indir[idx] = rss->ind_tbl[idx];
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
index 7d67b4cbaf71..0e8a6a6486c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -193,7 +193,8 @@ int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 
 void otx2_attach_xsk_buff(struct otx2_nic *pfvf, struct otx2_snd_queue *sq, int qidx)
 {
-	if (test_bit(qidx, pfvf->af_xdp_zc_qidx))
+	if (pfvf->af_xdp_zc_qidx &&
+	    test_bit(qidx, pfvf->af_xdp_zc_qidx))
 		sq->xsk_pool = xsk_get_pool_from_qid(pfvf->netdev, qidx);
 }
 
-- 
2.43.0

