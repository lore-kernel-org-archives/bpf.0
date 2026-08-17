Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C526FD97;
	Mon, 17 Aug 2026 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935882; cv=none; b=jjH1zX+MKu8E6OPM5Z1fhMXZkfiWq5yo87ZRfHmnuNlxjRZCiQKw43YH/gOCrNjEQbR+xhpw77kQaczimvHYCZNbCtqSdZy/+7HPvAgVYHq8TRbHRZBO7bL2XoN22SMKPlLhOyKsBiAnVYcbb8z3mTZ87IUoLuguGQlWpMkwDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935882; c=relaxed/simple;
	bh=44ZKI6gyYThyXEbVF9HXAQR/5R5MusU9DyMF+CnI2N8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZw+lNYm+DR05GC0xXPB7GvDdXARCxZqkLCl/UEE/6JWyhwYar2K9FUL2UqFh9H5dOnEe/ipcVyKJ5q1zUpHJKV53KT2YOAEJgS3YDbcvMqbsyrxkJ3qgAGM7jen8c7LnB0xUJCZTyKkIm2l3fUeIBMURJqAWZM1K9KpRQx270k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Zsa7wI0Q; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Zsa7wI0Q"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GMieJl1291985;
	Sun, 16 Aug 2026 20:03:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=44ZKI6gyYThyXEbVF9HXAQR/5
	R5MusU9DyMF+CnI2N8=; b=Zsa7wI0QBilVtDY1gVCDYuTQs/KChHg8BnTfguksF
	6voUNfJxQwyQV7v2bVdii1vvsN3dRT1elH4E3+gkASyPl7GlsUCA+qTAu/dD1P74
	5JePtP45eCTekEdzOTxADT1nzA7Z66NPa3d+RkKwXMpbKcLW4v2ec0l1sPLVxe9j
	NjLaiHcl5LX8dwbqMVQcaYeq0Xnf1QbYn7eITxoK4GXweoY+19Yk707UiZojNa3o
	Vg8d79NnZnQIOGNyYGPDp3uj2vOy3SuzP3eVtf1FtcMUkFC6fEm7iQxCf+dF1aH3
	sdIjmbEjwfmCOnJVGN3ORsFdRHzFnRjeH6cMgCXl0SG2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g38v8h4vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Aug 2026 20:03:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 16 Aug 2026 20:03:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 16 Aug 2026 20:03:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 369E75B6922;
	Sun, 16 Aug 2026 20:03:51 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:33:50 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v8 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <aoJ6FhtWue0FHDQV@rkannoth-OptiPlex-7090>
References: <20260813082754.1165329-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260813082754.1165329-1-rkannoth@marvell.com>
X-Proofpoint-GUID: CE-0RjH_jgToRXolM0233dstsri4H3ap
X-Authority-Analysis: v=2.4 cv=ZpHd7d7G c=1 sm=1 tr=0 ts=6a827a1d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=5TXRcTkNFt69AM2IH6YA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyMiBTYWx0ZWRfX3CqMZAs9ol0p
 vASzUiXmCP4sLxb/4hrscrDzXl0Fdg4oqL+Zla28Lcgn76eBwonnKO5BYQtbH6uZWcCByQ3D2xF
 +MT0Jhkivm+gWJIVvc0mrPwb4BT8vrsaCzJTRq9egbPbnbMZU6+zTreDxAGtsOsf8R6yvtcOEbf
 tsAMoXM+xCfNMr6WEqZGAZgA2VHCJnV8oEwSAMT8Ma7Y0DMw73duBSfodS6fogF4iAOEPfLTDki
 uTEev+0zMpd28tfE2JKdKr0IfOelIKJzBzEqQzekDIIXeNk/1LCUvkkhQWsgmDof0LAN0d1R5iW
 fh0UocxuXFVisD9mBJ3IpfkiEhnRdUlHjCHqgReqeVlbMVVXG5uUTAlDVE70WfHplSlYCqnGwP/
 xruoFSj1Aggja3+NoNmFcnri7wdoSJTMkq5C9z28nkUNVQbLpw8JM34nT7vBUI5vGcddHVrul6N
 PPvXcmPl5Ix1pC5jzTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyMiBTYWx0ZWRfX4Fih+aOGYCwU
 CVpWFhjB6MCUL3IMCu9xa41uxw8qZuRlu96qTw2Hs2udEP/H/bQFLu5WxDyl3754voQdT/gClO1
 9QRrX44F4RJypkJ2pc/2td7dHeAHES8=
X-Proofpoint-ORIG-GUID: CE-0RjH_jgToRXolM0233dstsri4H3ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01

On 2026-08-13 at 13:57:54, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko comments in v9.

pw-bot: changes-requested
