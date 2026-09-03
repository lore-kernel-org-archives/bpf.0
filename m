Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3443515D2;
	Thu,  3 Sep 2026 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402657; cv=none; b=vD6YnPtQWz4PSdSkmsGzakUbR2ctGcx36uMzyIPnXfOUek9xrrHzzhJ5mGxOMtZbdMnA+4KB0tpccRSmpTmTDVCNZuRA/FlR6Ub2P7Ej7WQIEb8FaCKPIzt2gwXL7A2AN8TVOwCw2WPUnink+4xD9RdiINDJoI3uJo9yz6pk+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402657; c=relaxed/simple;
	bh=AyX2EFPvuiK1pqoqXM9KP4CsCsWwvZZ/tNc38egcLoE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hndoyoeZfhP+GlIeqUT8nuLQ+uQVUQJa0Qx5NF5iXtGznZbXbQRY7OmfsCzC9hgvSlOoEmJWbE0oRG8BM1T7AKD1pKOea+q/zoapuU+ub/mOtaeDroOer5cUzV258PXCsXdcJ7yRhub6UNuVukF4ZlEinCgS+Vqx/Q0u8E+Lt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bC97djAD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bC97djAD"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682NMCXi3630541;
	Wed, 2 Sep 2026 19:30:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=AyX2EFPvuiK1pqoqXM9KP4CsC
	sWwvZZ/tNc38egcLoE=; b=bC97djADl+4XUaGJXAoKcaCGLw+ONBQPVxshS+6Hb
	9SVmi22NHQCbnd59MxXyXQsCT4DRVplIDPFTiYidXplYkzXPVvqgauTgkNiFslFn
	klXZlFR0PRaDyZErMBHptSyrR9tS1/jD/+HYtAx/ucWGQDzevNKbkGbWxOyc4gRT
	iHD6sEblNxHI/ocB8RAZsiE5oy2/rEUBR6eWj+ro2CxNUvikP2RigDh2oypmorUV
	UVkNR8tW+L2yzlhVymDSp6jvgZMvwHbnnmRtA6BvtzUQ6ZxCT2uqCJpeZkmpKnoh
	RpZbX/9DoVw6Iaib3Er02qPepUviMN1ArWDq2Sjv6I+ow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gegb62xnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 19:30:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Sep 2026 19:30:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 2 Sep 2026 19:30:02 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B3BD23F7072;
	Wed,  2 Sep 2026 19:29:58 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:59:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v11 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <apjboPTH53wIfke0@rkannoth-OptiPlex-7090>
References: <20260902015500.2985371-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902015500.2985371-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyMSBTYWx0ZWRfX5VeMKuQfoDUG
 5uzBIjEboLIisaI8gpJ2sBvakcEJCSUmlVfrZTBKohxw+ZHLvG9U6WvmBJ3ZDEbQq2MALed4TRO
 I+rGW42TyUqy4WPJbAsGJVv2+RI9v7nO/Lq2/GGaS87ZRGu7cbOk6h77KxKKJJSwq0WY5MEHfBw
 mMf4sCYXhtcX5vx3mA/eC29uK0AjF8JGkqU0uJVqFASmjEaakiXKPXnLW7lQeioV4s0WC49Eqtz
 viQVljZSlZoqfeeMm3WGNg1/2XYvmFbhIV09xb1H32ORT+2bzMtYS2bHdpVHAVKCbGDBhdXL09E
 3dSYPgvARwD48Xbah28nDBf4f1W8/00s6tBh/8IXYAXW2P43xYzfGrwaaQn0kbCEOrmW9lai8XB
 FUHvEFxejRQVc6fufkzRe8Vu4vZUu1Cj/HPGapmkbQTa0d4A4dDiQlssrrHDTPUe0Zu0ovfA/Th
 SpNYlUwAtwV//2POA5g==
X-Proofpoint-GUID: Tzlo5EZCpD6573HLryst_2rfiTdkzPvN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyMSBTYWx0ZWRfXxDcOBLCsBsgy
 6E4V/k56qcIHSffqCEfwJ1oSxUG5U4VBBPG0JRCaZjfHTq1DFUOZdJc4ZlN3+iS0y0D53sTDziy
 CnxcP/SomsJ6liObtSNhiqr3EwcR8Bs=
X-Authority-Analysis: v=2.4 cv=GpJyPE1C c=1 sm=1 tr=0 ts=6a98dbab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=rrcPliMPUjUZiAMkEZsA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: Tzlo5EZCpD6573HLryst_2rfiTdkzPvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_06,2026-09-02_04,2025-10-01_01

On 2026-09-02 at 07:25:00, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE. Program per-queue MDQ CIR/PIR through the
> NIX TX scheduler mailbox for each non-QoS transmit queue. When offload
> is active, allocate one SMQ per such queue, parent every MDQ under
> TL4[0], and map each traffic class min/max rate to the queue(s) in that
> class.
>
> Rebuild the TX scheduler hierarchy by bouncing the netdev through
> ndo_stop() and ndo_open() on mqprio add, replace, and delete. Cache
> the active rates and restore MDQ shapers from otx2_mqprio_up() during
> ndo_open(); log and continue if restoration fails so a normal open is
> not blocked.
>
> Track mqprio configuration in mq_offload_snap snapshots (TC layout and
> rates). On tc qdisc replace, stage the new configuration while keeping
> the previous snapshot for rollback: failed setup restores the old
> snapshot, successful graft is recorded through TC_ROOT_GRAFT, and
> teardown of the replaced qdisc instance commits the staged snapshot
> without tearing down the live offload.
>
> Reject offload unless the interface is running and the device advertises
> CIR+PIR support. Reject per-TC rates for traffic classes mapped to more
> than one queue, SDP rep ports, and concurrent PFC or XDP use. Block
> ethtool channel count changes while mqprio bandwidth offload is active.
>
> Add a ratelimited AF debug message when validating TX scheduler queue
> ownership to aid mqprio hierarchy setup failures.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko reviews in v12.

pw-bot: changes-requested
