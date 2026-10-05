Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BC137923;
	Mon,  5 Oct 2026 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169155; cv=none; b=PGLA5PGfQBWXaoKYRk6gDa8QeRn1pmnS3qNhZoWcuHmVBnTvbzv4zKeHfGtnj+B5u9buhxuGXNYy6s2iJXLNbfgP1ztW0tFr86C2fK4GAR6TuRCYvkV3O7wc/HtbNFWhvkQzRPpLZ5NKhBPfFMc//D8GBlUIO0RFG6l6es7ySgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169155; c=relaxed/simple;
	bh=Jfd1AEMy9MGLt026jCq56fe8IC+/6jnm9XiUU7CZEas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msLK6MhetO4UL6pdNAq6lP72Edzp2DsUZOqhzlgWZoiCR+smr0HYHUiWpcSExScC9Fs73/lAy/UzssVBEVQQJov2w/KNYfJZR56NBtbQMIGn0OgAjNEy414vDuJT393IAjrlInXeGoO8Dp0Sk/L6TWPuDeEylL1qHOSLzGDY1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bOMJ3/Rw; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bOMJ3/Rw"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6950xHhE2705250;
	Sun, 4 Oct 2026 19:58:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Jfd1AEMy9MGLt026jCq56fe8I
	C+/6jnm9XiUU7CZEas=; b=bOMJ3/RwcenwfiLHV3kNqEaWjsGvu8WQtsfAIHzea
	N3wztVmeS3N2YywuK+ppkm+PCdZ/Y9vQcBRQTuwZRCNFYiQ+hKUsFF6GOuwOlBBr
	Gbrs3bUmIrfurUxm+yD4Sj7KXlUgtw9yOfXT5m1rc+fQ+k5sjxFT5UD0zZDyzEr/
	IodF09B2Bn6YJHrOx2rE8HQcsrNToOefu5GazpM/YQpDNN+dqOUFlsPnfA0vjX8K
	wM+T8UmoJQFi/cQkRoMaQUIaOHhxIgcnAHAc+BiCq2mCYozPEbF1Za6jZioegH1D
	Atp6Eu7DARi0eNrHu91n5JBQBPdU9kA0iEABHP6jrn9Gg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h2y2kweu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Oct 2026 19:58:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 4 Oct 2026 19:58:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 4 Oct 2026 19:58:28 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D30DF5B6925;
	Sun,  4 Oct 2026 19:58:23 -0700 (PDT)
Date: Mon, 5 Oct 2026 08:28:17 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Laight <david.laight.linux@gmail.com>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 0/2] octeontx2: mqprio bandwidth offload for
 NIX TX schedulers
Message-ID: <asMSSdIK6WBECcs_@rkannoth-OptiPlex-7090>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
 <20261002103752.006a7648@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261002103752.006a7648@pumpkin>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMSBTYWx0ZWRfX9xRyfyvnIqfQ
 bnrt5sl0uLoplnIMQI7aIV9+StV864uNWPgCLazUO5AZsGIGUW4sTpX2LZfZEzhXk/WZmgPT1cz
 uWOmsnpQgXhC7ZuOI3iRd63hOf30sFzobpDdnUzav55PpLKLtORn5saVU10bLJ2ZmgSAFo4W8lY
 sUjaQEXCsMmWZ3+Cimdix80Y1l7ALUB8kUzO9/5AeUnsqBaSgrr1lbCzISQKCv2FOKPLE/vc1j1
 YdLVexDHZPKEKkTYJHd1R6oqDbJwrM+3yn5SYPC/mW3l1FnfF3TEl3/T2UmU9n92UZBxQ5ONXbS
 RhRsNsCiyqKvX/7WhMaOpFG7OdVujLlu5Gdr79nD4bXBCGpiuITLkG60PXXDcHSQSNNDYwj1IKv
 e5ezhK05lv8sHRCvKK4HcHdJIJ3LyBXGB1+86iaE151e7RQKaTnaolLdI7d/dip8tjyFjU/hMzH
 6urZo9hwBKbKbkK1YuA==
X-Proofpoint-GUID: qn-m0EM0LEDC6Y1OFMsCl585-Te4ABpb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMSBTYWx0ZWRfX7LSIdgrHA3n1
 IYcNxHZQ6XpuYkbxN4ljRpM4mL3n3MPYkf6iLpH4O0kIIezfgE4yRNFRbZfE7+/aVl1cYTSEQcV
 LbwissAo0LApqnLrh9nzwd7Wqp9XYCc=
X-Proofpoint-ORIG-GUID: qn-m0EM0LEDC6Y1OFMsCl585-Te4ABpb
X-Authority-Analysis: v=2.4 cv=cctHPXDM c=1 sm=1 tr=0 ts=6ac31255 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=pGLkceISAAAA:8
 a=2DGdwQEehr7-gy0_57IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01

On 2026-10-02 at 15:07:52, David Laight (david.laight.linux@gmail.com) wrote:
> > Patch 1 converts PF/VF and representor flag access to atomic bitops.
> > Patch 2 depends on it for safe OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP
> > updates on asynchronous mbox paths and during the mqprio netdev bounce.
>
> Can't you just move those two flags to a separate structure member?
> In at least one place the code separately clears one and sets the other.
> That makes me think it should a a three-valued state not two bits.
>
> That would save all the expensive locked operations.

Thanks for your review.

I agree that atomizing the entire flags bitmap is broader than strictly required for the
mqprio/mbox concurrency: the cross-CPU hazard is otx2_sync_flags_from_rep() doing a non-atomic
read-modify-write on nic->flags while other CPUs update bits in the same word. Relocating
OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP (or restricting rep sync so it cannot clobber those
bits) would be a narrower approach than converting every OTX2_FLAG_* accessor to
set_bit()/clear_bit().

On the three-valued model: INTF_DOWN and PORT_UP are not a single FSM in the driver today.
INTF_DOWN reflects netdev teardown and is consulted from NAPI completion etc.
PORT_UP is set and cleared from rep RVU_EVENT_PORT_STATE in the mbox up-handler and
suppresses a duplicate carrier/queue bring-up in otx2_handle_link_event() when rep has already
applied port state. Combinations such as INTF_DOWN set after otx2_stop() while PORT_UP remains
set are deliberate, so folding the two bits into one enum would need a seperate work
and review beyond this series.

please note that this restructuring feels somewhat orthogonal to the goals of the
current series. Patch 1 focuses on replacing the non-atomic |=/&=~ operations on the
stop/open and mbox paths with atomic bitops for INTF_DOWN/PORT_UP, which patch 2's netdev
bounce depends on. The rep-flag sync behavior in otx2_sync_flags_from_rep() is a related but
separate concern, and I'd prefer to address the lifecycle-bit layout and sync logic in a
dedicated follow-up rather than expand the scope of this patch series.

>
