Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E8441605;
	Mon,  5 Oct 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193815; cv=none; b=iD+XLvGlkZUTTOMXGi98ceQGtGLSusv7tSDhFqb92Dj3S7/LEYtbHEl7p1eohwtN93LHUSSvnVq66sxb7jTlWZ9yCFICZItvNfsU5nzRn27SKC3dovo/lEM1Al/e6n2NVeZIzkkhw3vEUtZvJQkpDBqjS+YBpmmhLgNQzRbf3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193815; c=relaxed/simple;
	bh=SSWwyrHU4CEzdxXwewbxiBw6RNUa5EB5lOz4iMt/V7I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujyn6hsn0UamKFVsQm1/Z4ryo7vmVLODATBgKX1QkDD03qp45b7wUfcnvK3o9RNGrvMbddJHzncd2NIvXFLLdAOFwqpoW5roOfXqg1WofKFTx6uCAn9wSQgsNuqCduWfnxO23lfGx7KC0wBBwrLAheZ4ZIA6SnCwJhugPNVp5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ttmqjfk0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ttmqjfk0"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6950xIYr3490181;
	Mon, 5 Oct 2026 02:49:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	SWwyrHU4CEzdxXwewbxiBw6RNUa5EB5lOz4iMt/V7I=; b=Ttmqjfk0yGorFNtNu
	TcL6aB668vE1lt8NzYmwXxqP4Ai/lKFAlE/KVgVMf0SiaHioBvJbBqnkH5dDHkmN
	fKWdYwMzeT4/1kj4tCLj1RhzOEcLtBJPhT/k0q5KpNcql599cvpSnNL+y5V0ZZgs
	AmijzIIK0SR52fgAlCalRU/ZF65jf8KWt7TGjcMgKFbdi8hNN4guIllXmVwkn+j9
	uLErFv8jznEaq0kwxYTQBOBri6JNVYki0NtACb1GOI79eeyFiVwZ7jD4UNccLjHn
	MX2KJVOXgvx6Rd8tfoZMSHdWLUyU0TE34qFO9bTos9KtIZp6rLpR2jfjYMJvQn+U
	If2QQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h3jf8b9ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 02:49:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Oct 2026 02:49:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Oct 2026 02:49:32 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 73E313F704F;
	Mon,  5 Oct 2026 02:49:27 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:19:21 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Laight <david.laight.linux@gmail.com>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 0/2] octeontx2: mqprio bandwidth offload for
 NIX TX schedulers
Message-ID: <asNyodyL__nvyY5e@rkannoth-OptiPlex-7090>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
 <20261002103752.006a7648@pumpkin>
 <asMSSdIK6WBECcs_@rkannoth-OptiPlex-7090>
 <20261005091440.575f0eea@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005091440.575f0eea@pumpkin>
X-Proofpoint-ORIG-GUID: vj9lKBWmJM0NVr33mVcsS59c9UoEpMt-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzOCBTYWx0ZWRfX43JEIQW75VWM
 ksT/eK7Is8LV2jkXVzDo6t5ZAJ+56+K69JDQdwNDOPDvCUmvJJTbQO81uhYNfb1qA6VleHCKPT9
 NJ4O76ouqpLsilefzx3sdRqtW6Z2H9Q=
X-Proofpoint-GUID: vj9lKBWmJM0NVr33mVcsS59c9UoEpMt-
X-Authority-Analysis: v=2.4 cv=YOYKWhGx c=1 sm=1 tr=0 ts=6ac372ad cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=TzAfAFAPkOg4z5699CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzOCBTYWx0ZWRfX/9p63ahh3q8L
 wKt0PSudhpnuLKtMj6G7BzrxhfvgLSLX+kqt6th5j+dlE9f0rGN5s0t0ELzXltmQ/6o5n9vVehX
 KFeu+jXt26knbzCd+PGLOnGQ5dUwLaHua9zXVOsuHKFY2fbAozpod32XrbEkANYDO/yqnc+d39U
 P/GMuOdJJbyPnNYMcvr1mslO/0XoebVrTV7+NINgL8VOjAwDOJ/8QDxsvNWmcTANnXn4sUoML2a
 CioCHkkJr824qcesDp6UT4t0ySuwzSfkWhJqzvZfn4eFQaZNDGnCNndeVctv5zJzwdXnKsJddjv
 uM28gK6dZ+JorvsNxR8I67VDkWnAv4VcI6a1msmJN8dhfaCJlcQyMRIgCRpLJJjUmQz3OyfprfQ
 D4yb1o9ZuIgchQ4jVhAbWdDlMfLEw623l8qqWiwH1r9JR3b9I5rHfTLfBjFGkJDtEnTHXHEL1KQ
 oI9xxHx7U4VWYyowfsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01

On 2026-10-05 at 13:44:40, David Laight (david.laight.linux@gmail.com) wrote:
> On Mon, 5 Oct 2026 08:28:17 +0530
> Ratheesh Kannoth <rkannoth@marvell.com> wrote:
>
> > On 2026-10-02 at 15:07:52, David Laight (david.laight.linux@gmail.com) wrote:
> >
> > I agree that atomizing the entire flags bitmap is broader than strictly required for the
> > mqprio/mbox concurrency: the cross-CPU hazard is otx2_sync_flags_from_rep() doing a non-atomic
> > read-modify-write on nic->flags while other CPUs update bits in the same word. Relocating
> > OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP (or restricting rep sync so it cannot clobber those
> > bits) would be a narrower approach than converting every OTX2_FLAG_* accessor to
> > set_bit()/clear_bit().
> >
> > On the three-valued model: INTF_DOWN and PORT_UP are not a single FSM in the driver today.
> > INTF_DOWN reflects netdev teardown and is consulted from NAPI completion etc.
> > PORT_UP is set and cleared from rep RVU_EVENT_PORT_STATE in the mbox up-handler and
> > suppresses a duplicate carrier/queue bring-up in otx2_handle_link_event() when rep has already
> > applied port state. Combinations such as INTF_DOWN set after otx2_stop() while PORT_UP remains
> > set are deliberate, so folding the two bits into one enum would need a seperate work
> > and review beyond this series.
> >
> > please note that this restructuring feels somewhat orthogonal to the goals of the
> > current series. Patch 1 focuses on replacing the non-atomic |=/&=~ operations on the
> > stop/open and mbox paths with atomic bitops for INTF_DOWN/PORT_UP, which patch 2's netdev
> > bounce depends on. The rep-flag sync behavior in otx2_sync_flags_from_rep() is a related but
> > separate concern, and I'd prefer to address the lifecycle-bit layout and sync logic in a
> > dedicated follow-up rather than expand the scope of this patch series.
>
> Right, but the atomic updates are are far more expensive than the non-atomic ones.
> They really are best avoided unless you really need to change/test multiple bits
> or need to limit the size of the data area.
> The patch is likely to be smaller if you remove the UP/DOWN bits from the bitmap
> since it will change far less code.
>
> David

Understood on cost and patch size. Before the series, we had a single shared flags word
updated with non-atomic |= / &=~ operations.

When we reviewed accessors across all bits, we found several that are written from rtnl or mbox
workqueues but read on other CPUs without rtnl protection: INTF_DOWN (NAPI, XDP, QoS—the driver
already notes it may be checked on any CPU), PORT_UP (rep port-state mbox up vs. open/link
handling), ADPTV_INT_COAL_ENABLED (ethtool vs. NAPI), and TC_MARK_ENABLED (flower vs. RX/TX). With
eswitch, the rep sync mask bits (MCAM_ENTRIES_ALLOC, NTUPLE_SUPPORT, TC_FLOWER_SUPPORT,
REP_VF_INITIALIZED) add another writer path on the same word.

Converting accessors to atomic bitops makes updates and lockless tests well-defined on that
shared word. We're not claiming every capability flag has two live writers—the driver-wide
change is for consistent concurrency on the bitmap, not because mqprio alone touched every bit.

On expense: most updates are rare, and the recurring cost is test_bit on a few hot paths versus
a mask test, which we consider acceptable for defined behavior. This change is also a
straightforward, mechanical string replacement. Happy to discuss if you'd rather optimize for
minimal diff instead.

>
> >
> > >
>
