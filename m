Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745833515EB;
	Wed,  2 Sep 2026 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313209; cv=none; b=iNCks5Ko1E2RsTM3+PWbJRfsnxk6O8FqqMLaWsVDh0KNk3+pJZI2XenS22Tvs1Qk18tib6lH1vhHWrzlKLgzWWrJUzMAXssWVAcOCGLNKyatXTIXCqcBEEUYArFallvTySgGmUcIodPi5JkgReHg+qVOBk2Y4t/34rx4AjMlZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313209; c=relaxed/simple;
	bh=tbjkzBf9v60YqlUBHhCUP11y+aKkwQG4oLuVfMjjNzc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2BkH/jbiPpCFR5U0QOlftttdG9FZNxI3DL9XVCj8sw8QFAEtBhNPe6jzjrCcQ0yyPRwzabZmu7vWdecPdGW2QBrzfxI1bcawWa3CFL+jq7RUlAZyEof3pIOJ80jfHCBJfjB1PXf56NIkD1TPJJObMQLxXUDjP2bGPVD1wV9hNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G9sA1NmM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G9sA1NmM"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWxKG4132527;
	Tue, 1 Sep 2026 18:39:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=BAKmL6RTJaLJE6UNg1cEhYSVp
	G9lmPPM9QPgHyBfqa4=; b=G9sA1NmM15xmkefPgJAVOV9TytFxT6Dnpkgov20hN
	wMh8ce7QMfeN2GG2kGF1dAQmc0ib6A27AszrESWJbyC1/erVgIZjM+0mPNdF0O1d
	KY8Rg0XyaZY+n/LRjfF6bviogaNuqtBNJENrh9YI8kSJTV22c99azcje9XwNCwee
	cBsfq0TtyInOMtMgOZPKVLs4mKTrLteRpKFat/mtp4ewIge5aZ6rp0Wtq3y50kOe
	hs12QgrN1osU6fQEU6jZInmWeCkU2X9y3Iw2EZHtXXLXtgtry+sElmQRIdOpKFnv
	QBxcfxqEYR+/yGZJ4xjW9ikWPBLCfE2qQNtYYdGx/8XNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ge4ttrxvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 18:39:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 18:39:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 18:39:28 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6107C3F704D;
	Tue,  1 Sep 2026 18:39:23 -0700 (PDT)
Date: Wed, 2 Sep 2026 07:09:17 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <horms@kernel.org>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v10 net-next 0/2] octeontx2-pf: mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <apd-RdkplZBclQZw@rkannoth-OptiPlex-7090>
References: <20260831131014.2639581-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260831131014.2639581-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAxMSBTYWx0ZWRfX3mB7UdsfU888
 fDZgrclnBjTfqb9/0K+zl7xlSmyyqenWSkH1fnrXEpbAOmP1uBkWLRrnZjUn91ghrQ9bfsbJ72x
 ZBJrMjhasrtSVJk+ajT2bPwOjtjLLvkzJ8X+y+4GL1e+4vQLA0ceHM2QcbcMBjXFSww3+wQBFec
 a3Da0qtDA17+//pTWLJVqfLFSiJzUvt6BMqMNCpb/IAJB+8zqJJ5h5FzZeU/UYdANpC66qQsmSS
 ykAN0tFHs2mqwAx0eMnsW8s4DHARSb8ddZOGP5Oe5jarnp9KKFdz3iMTNxAhpTAh0zJlfWO++Ge
 NFQ4/L6TH+suDaiHnjxm1JauEExlulu0lOXej8ge9YBLtOzFIuRySWx0Hyqw5w5bbDGk1Mofb8f
 QkGjEl1uLb2uvIVcXG620JIN+D8V9rPL267XCRls9WtXMziTDTy8vbWH/oGjCfOtSop91ipqy+I
 O7d3ZJzeE67ddP7TkZw==
X-Authority-Analysis: v=2.4 cv=MfBcfZ/f c=1 sm=1 tr=0 ts=6a977e51 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=yaMLrZmCnpOwXphqEKQA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAxMSBTYWx0ZWRfX1YgHGKcjKWKS
 h9+tBJmewcOQPZtww55jfWL4srYCgcV7l0j7zZ3gSSp+omVPFrERdhALBUsGFET/QmQY7VQ1AoQ
 rsutvT6iP5VMUXbujwWLPA3c0vm8SIE=
X-Proofpoint-ORIG-GUID: MSkL9hnqL6aXyqXJzU3KeluH0vSjkfRr
X-Proofpoint-GUID: MSkL9hnqL6aXyqXJzU3KeluH0vSjkfRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01

On 2026-08-31 at 18:40:11, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> This series adds hardware offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2 PF devices. Each
> non-QoS transmit queue is shaped by programming MDQ CIR/PIR on the NIX TX
> scheduler. When bandwidth offload is enabled, the driver allocates one
> SMQ per queue, parents every MDQ under TL4[0], and applies each traffic
> class min/max rate to the queue(s) in that class. The TX scheduler
> hierarchy is reprogrammed through ndo_stop()/ndo_open() on every mqprio
> add, replace, or delete.
>
> Patch 1 is required for patch 2. The octeontx2 driver tracks committed
> mqprio configuration in snapshots keyed by the owning qdisc handle. That
> handle is needed to implement two behaviours that patch 2 relies on:
>
>   * tc qdisc replace installs the new mqprio and runs its offload setup
>     before tearing down the replaced instance. Without the handle, the
>     driver cannot tell a stale disable callback from the replaced qdisc
>     apart from teardown of the active configuration, and may clear
>     hardware shapers or netdev TC state while the new mqprio is being
>     committed.
>
>   * When replace fails after partial programming, the driver rolls back
>     from the previous snapshot. Matching setup and teardown callbacks to
>     the same qdisc instance requires the handle passed through the core
>     mqprio offload path.
>
> Patch 1 extends struct tc_mqprio_qopt_offload with that handle and fills
> it from mqprio_enable_offload() and mqprio_disable_offload(). Patch 2
> consumes it in the octeontx2 PF mqprio offload path.
>
> The driver rejects offload unless the interface is running and the
> device supports CIR+PIR shaping. Per-TC rates are rejected when a
> traffic class spans more than one queue, and concurrent PFC, XDP, or SDP
> rep use is blocked. Ethtool channel count changes are blocked while mqprio
> bandwidth offload is active.
>

Will address sashiko comments in v11.

pw-bot: changes-requested
