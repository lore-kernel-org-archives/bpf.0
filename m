Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AB375F88;
	Fri, 21 Aug 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309779; cv=none; b=ALQEGUCnqj+hWuPwwTFwzVD7PBmq22E9hsMxTMDfijXEdn9ZWwplnU4eFJEZ8GfFFiEPcsFWhuElOJRPgRkhebvDhPJePc2OTnEY//eKLxgu+oxC248G5kNG5wiy1nv7DXjhgTUNaI2loz5Ilp8a9SMyy/9R1SZgpXb5sp796Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309779; c=relaxed/simple;
	bh=xbq3UjKbSp7jnHTaX+kqQg7qqd7pIq1rUcf5N9q1UUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6f6fB94xv6epqx30n5yNGUDEovCsmtf8c5NgpsYBcYTVytBBYta2rBOqtPcCwmehDxddnXRwFW1q3nKlzGozyk6dphgw2/0xXUWxTZjSFle6E7LI31567w4jOc0grMJUd0JTE5a91v+0KfX6goWrG9ghjmkdjlA6dRkGdhQ3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D/wtM0dR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D/wtM0dR"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9PwWP4183906;
	Fri, 21 Aug 2026 03:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=yM7KI5HADkOHb5NjuXLEdxP
	N3wx+BY3fjouI8Qi/8n8=; b=D/wtM0dREfZNCsULiu1EfpkYrlorRGHA1l4MG49
	r9jHDy2+FGYA8XG+IJtXU8wq7AP8G+goDHraG4C4hccHU4K6cG5Km8P2+cQtYJ8a
	mw3UCoPFtX63ds+0BbkVFQdyM0TCebdm1c32pwmMSGDdYoivkEVASPHGNeycIqWq
	PbYFixEfufQ1UK/zRTDs5y7miBymHk1zTzq9frG1D7Hib8dthpFfg0kD/jkfXeDm
	L3Rq/nfXtAkSUsdadmUO4Jxg8HwrL9e1Kf6cgLVrMydp+vCkrr7OO6lXy7C+Z3CQ
	nABsjUfYjEwJNaBMQb5n7LBUhncXfVXi0E5qa1cKPkqaQdg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g6m1k058k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 03:55:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 21 Aug 2026 03:55:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 21 Aug 2026 03:55:50 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id EC8033F7094;
	Fri, 21 Aug 2026 03:55:45 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sumang@marvell.com>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <sdf@fomichev.me>,
        <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup
Date: Fri, 21 Aug 2026 16:25:35 +0530
Message-ID: <20260821105536.2998765-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UbVhjqSN c=1 sm=1 tr=0 ts=6a882eb7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8
 a=ZaGVntTZuAbbtjky5UUA:9 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: P9RaX2Y8gE0ovXbU2fY_7zq84Skng5DP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MiBTYWx0ZWRfXw16kYvAVr2Du
 ZG9VaZbiHWhrz/CCj9p1n9pxhN1cGGNCQF7fEKYxnFzozKzIp1igTSq7rouKUt80jNUWRgfOhsW
 KyfNTxqj7/D5tw76ZRZx/kVuJFRoSg0M/Wx9GezZnIKoHK1AIpHTpx60AdbkhMkXJyWT33f45NF
 7iFvQqdKn3YYb9VajwrAX5OnDoqOu4ai0MFc0AKAqpNdf/MI0GYzqabrkm/YosllgTNekMWwihI
 OnOz5VCKkEqRAEEGS4RefGAInGzSSrD03bbXnEg5TYXMoMkh6Ll3cjU6hYZdgM2eCqwUtmXKq9x
 XBUpRqx+r0ZQFNFTzktjIbnrot+aykCWsPkd2mdlQaJRfiQvQ4sSUejzarpRwXgm6KVKZTKHfyU
 lsJgVFJ6aGz6Y7K6fcGRI+R5BIAH2alkGRcJFat3uU/BEc5xnt8EUw+00rofUiTzq90TP/EFZHY
 V42F/XrqFmmPgSpSxtw==
X-Proofpoint-ORIG-GUID: P9RaX2Y8gE0ovXbU2fY_7zq84Skng5DP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MiBTYWx0ZWRfX7K27AF+/dr3G
 FB8pSdUEYuVy0m1KxkIhjycTSwS0F91CzsFWUPhrmmfmKGrN3lUkWf/5WNZ/R6mXNIKIumx21df
 IwDledApN6SNwdaqGnF5Qnype9d8Pno=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

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
v1 -> v2: Addressed sashiko comments
	https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260820090533.2681578-1-rkannoth%40marvell.com
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c  | 6 ++++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 ++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c     | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index ca73a94db794..175992188c18 100644
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
@@ -1509,7 +1510,8 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 	if (type != AURA_NIX_RQ)
 		return 0;
 
-	if (!test_bit(pool_id, pfvf->af_xdp_zc_qidx)) {
+	if (!pfvf->af_xdp_zc_qidx ||
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

