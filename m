Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE03290AA;
	Wed, 12 Aug 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525132; cv=none; b=qVRHN48dh2D/W4d+AjmPbTEkESWcqiIHsH2zWLp6rTiuimuQCvCIC+Go+Cr01Q2W4OIIe6QkU+IlLelDSiQVAGLLbQen7F/97Ra+y/LJIE86gX5WyuwTBrePKgMSjeuZvj3DqCM6NAZiiiU3GvTrQLm5ue8WmJivgUcYuKLZIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525132; c=relaxed/simple;
	bh=TIUNcsdx7eirVf4HUBYkbx/VZpXBj7srvu6LEKhSZqc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDe/4f9L8pKeO/TqYBYmlr9IptQhZiX4z6vCKtPiWo6DSrxWMW2d0bmlB0/SS8fNIQxoOQQY5DnoC/XmUh2cBR2fT5+pAm9TV1rtxM7oZ2y9GoiO75hdGyTsLBxCI+PvV11peD+C8aS/7x1tBJ7A+i3+VHWvUmJgtbuJ9RmnpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ViE9QW38; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ViE9QW38"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C612kX1934024;
	Wed, 12 Aug 2026 01:58:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TIUNcsdx7eirVf4HUBYkbx/VZ
	pXBj7srvu6LEKhSZqc=; b=ViE9QW38ssvwfeSMmyChyuLPtXUCqGvPP1k+87YxD
	kQUskq/GP2L8iXNPOnJZ4ZQFipJEAQDEMD/L198fWejlnjeOFHPWStfdFkb3RV1H
	9gNhwwdrtIlZJIn8cdsV4OJF+7n6XPnsqVLnedJKpp6NsubtcFxxvDaDPr04axpk
	vV0zC/q4Ao3C9rHhlglImB2ZGWzT+xRhsqZQbEXOiU+ifev/MD6tSP6Y6KFHahQf
	FNid1PShSboatOkUkwMvXhcn4qBWsFkLhssp92f/Aog86yExMT54YSrmmFui4te9
	btouor27AgBcAEQiky59Uw/LyIAO9twDhI7KARDLHMZyw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g0deh99fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 01:58:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Aug 2026 01:58:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Aug 2026 01:58:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B2C453F7077;
	Wed, 12 Aug 2026 01:58:04 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:28:03 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v7 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <anw1mz7NYdDbTAdN@rkannoth-OptiPlex-7090>
References: <20260811085050.3212280-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811085050.3212280-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfX+Jg+TtHWaTxv
 9K027UpLieAUI+twNXcxJquFW2Xg8p3q9/qms9vSihQz3W12ywMRQ/f968FmjBH1XrmxdjVlzqP
 Z0JZYMtukfXOKNGJyZUT3jTrovZDS7U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfXxZQcRj125i62
 kfXUohNaNApXV1APFDdWIYGoDoXtj4mA90B+Y/H+QNmltJLucgeGoQR04UIvpcKJDiY0cUPf400
 t7+i2UTDkm0zL/ilphemgfolawN55ZSugrxi3WSjVH78Y5LeS3e0lHeerDJAKOaxy3m6irhCdDQ
 stLXACTHqP3BGgdnPZ4OOWcxp6vHNG2jr8jCLQ9VBis7bzGVD3jXmGwMcTNi5E33mwVUcOxW/0r
 OmcWKYmCH/409DZAzmdiYajxbB/onNgQ6TZSlrwSGABvoUcak9vih0/HjhmzyyN40BSnIlCTEld
 7a+Gg5xByVoowU6QGckBZ+qGYszS3W5E2q2VydOgGN8vcUD7FubOIlCP7Hgo4CxhxxEiWTDw70s
 maNAvEFfSLo3KIc6lSxWKLx9jDGNHGNgVj7ASrcpcPIQ0B2qiGtUMeX4+NI55Yue3i2/JC4iIoz
 VgUzCxMmCsyKOETv/Fg==
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a7c35a1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=5TXRcTkNFt69AM2IH6YA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: hV50G04ClJnWhEVv3X9XYgipQN5tb4_G
X-Proofpoint-GUID: hV50G04ClJnWhEVv3X9XYgipQN5tb4_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01

On 2026-08-11 at 14:20:50, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO handling to offload per-queue MDQ CIR/PIR
> shaping for mqprio channel mode with TC_MQPRIO_SHAPER_BW_RATE. When
> bandwidth offload is enabled, allocate one SMQ per non-QoS transmit
> queue, parent all MDQs under TL4[0], and program min/max rates by
> dividing each traffic class byte/s limit across its queues.
>
> Setting up or tearing down the offload restarts the netdev via
> ndo_stop()/ndo_open() to rebuild the TX scheduler hierarchy. That
> clears carrier, tears down IRQ/NAPI and drops in-flight traffic; if
> ndo_open() fails the interface is left administratively down. Offload
> setup is rejected unless the interface is already running.
>
> Reject incompatible configurations (HTB, PFC, XDP, SDP rep, missing
> CIR+PIR support) and out-of-range rates. Validate queue mappings
> against hw.non_qos_queues and reject per-TC rates smaller than the
> queue count that integer division would truncate to zero. Track offload
> state in mqprio_rate_limit instead of pfvf->flags to avoid races with
> the mbox up-handler, skip spurious teardown on tc qdisc replace, and
> clear all MDQ shapers before applying a new mapping so queues dropped
> from a TC layout do not retain stale limits. Restore cached shapers
> across routine netdev stop/open via otx2_mqprio_up().

Will address sashiko issues in v8

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260811085050.3212280-1-rkannoth%40marvell.com

pw-bot: changes-requested
