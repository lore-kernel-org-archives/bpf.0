Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440BE32ED39;
	Mon, 31 Aug 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181868; cv=none; b=GTJUlwnvF787vt31E6rCkQkvjVuk4CL3iiA+/Jp69lu1dSD9WftwGmcZe3Yl7xJi/trLp9V1IWme7svwsTcuWSznFw5Um1iswS4m878B34j5gDPaDSA487ZhmdZiUg1n50aqbkYyQkiS+ucp815kf0T6bs7qM6pBBJ+Gbeq9wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181868; c=relaxed/simple;
	bh=AwOJwGpElxv2dzX6LIPx8csmYq6W/1D3c+8Hq8DAQVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZgpjcwY+u530tTkounhR2TCVCoCpXGMGIGW+3S4WV1usdAoLlOOlMxS2p7/d9aiE2sddWzSgSYUwJoaddDakhvANNqAYGSI3vRPTpRjhWTVMM4RLtBzB56jOb9Ew9GkR3JPUFLLhNw76cxGtbVhoD3xgd+7RN35fCNy0jpYOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bJer3f7x; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bJer3f7x"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBBjUQ536832;
	Mon, 31 Aug 2026 06:10:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	m78PwU1BlgVIF3kKgvRBSGtZYl43cW0jXyJ0fUStz4=; b=bJer3f7xpJAn0EnVc
	suR1omw6D+274I4zSXeKYcyx1cr4xSjQn+YmaLi5b6l1WxkWmMyYO9s52ZmMAk7r
	CQFHr9BA4ZGrWfoMVyIoYMKtePISLRbeeHJk8jzosqEdyrZISSOBRCvQQuuVYxZS
	oDhA9Isaig5f9yle2Ip0EdmL+txDiVd8NC6g60KlisBSGKTcSLMtu8BM0PKyVH/z
	XUWWU2PLvzO+AsFPEoqraz4HXndg9qN0AbmurDO1VLi6IJ5bOgmZERxoWXqwP94g
	OO1A9VPkWTxURsGuVZvT2eSZqs08QT0WDbmi4wHTOVGD0ZczQIoxeDVa8DwCxXs1
	BBxNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8jepf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:10:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:10:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:10:36 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DAFC33F7089;
	Mon, 31 Aug 2026 06:10:31 -0700 (PDT)
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
Subject: [PATCH v10 net-next 1/2] net/sched: mqprio: pass qdisc handle to offload drivers
Date: Mon, 31 Aug 2026 18:40:12 +0530
Message-ID: <20260831131014.2639581-2-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNCBTYWx0ZWRfX62GshWewOsQi
 7BW4+2b9wG3xTBitVZywxzNeGNWwNOoKa+wO3OU8CoIgbFkeZpu9SVRSo3dp/5+u8Aae3eGzkdT
 kQBcw+MVsLhHaDMCB7eIKwrUs8DAloFSiVT0+1X4+ZBdk9KX5GN4ATE5x/9gEeiiaNFJX3jmVGN
 7ePNz26LLQnGOlHjhhGOADNE+P/by4B/QrAsod5jsi61XU2hsmBjUrxDq2IeL3wOnrQgq/3kSIP
 LmiYB0ynZ0dbwhROwy9VAtc0JD39fpoaECF7cGGk5MobBKyhDlOxOjuHshpz3DSa/urRMCaNL1R
 2pukaiROkLcHnx7Z01EJt82D4na8nkTSDELt07Ulh7ORKQA7Y1t4JKyqNdlRO2UdcsOEAJfZ90c
 SvcQ9DYsxNvMmX0fy39/ICAuCT52z1YxhsGJeoYLjtdpbiMc4y3JC8eglhiIE0N6KQOHkcMExZx
 afpOGvZHvtC5xVA93yg==
X-Proofpoint-GUID: Olz054qTy5FiiyOt5K0OAAvkfEqCxmBj
X-Proofpoint-ORIG-GUID: Olz054qTy5FiiyOt5K0OAAvkfEqCxmBj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNCBTYWx0ZWRfX7BOjS1WKLNUN
 5Gbjy1nfKIsHC316A/Pf+TI3ND883Qy1nbDC9dQ48NqppRh+He0XH2W6Qo3NqlP0NAHiWMMzu8a
 t+/jlfe//XjYChFqqVedk08TclE5F9A=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a957d4d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=9NOKFUTgC_054liOIZIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

Extend struct tc_mqprio_qopt_offload with the owning qdisc handle and
fill it from mqprio_enable_offload() and mqprio_disable_offload().

Offload drivers need the handle to tell apart mqprio setup, teardown,
and tc qdisc replace when they track committed configuration state.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 include/net/pkt_sched.h | 1 +
 net/sched/sch_mqprio.c  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 90d3e7943b19..9f8694ecd436 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -165,6 +165,7 @@ struct tc_mqprio_caps {
 struct tc_mqprio_qopt_offload {
 	/* struct tc_mqprio_qopt must always be the first element */
 	struct tc_mqprio_qopt qopt;
+	u32 handle;
 	struct netlink_ext_ack *extack;
 	u16 mode;
 	u16 shaper;
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 6ced7008ef5c..adc1393f84ea 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -39,6 +39,7 @@ static int mqprio_enable_offload(struct Qdisc *sch,
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_mqprio_qopt_offload mqprio = {
 		.qopt = *qopt,
+		.handle = sch->handle,
 		.extack = extack,
 	};
 	int err, i;
@@ -79,7 +80,9 @@ static int mqprio_enable_offload(struct Qdisc *sch,
 
 static void mqprio_disable_offload(struct Qdisc *sch)
 {
-	struct tc_mqprio_qopt_offload mqprio = { { 0 } };
+	struct tc_mqprio_qopt_offload mqprio = {
+		.handle = sch->handle,
+	};
 	struct mqprio_sched *priv = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 
-- 
2.43.0

