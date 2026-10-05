Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620C25A645;
	Mon,  5 Oct 2026 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173823; cv=none; b=sGYYQ1QlZ5LAUjta5RZV5KGhQbcfgZW6FMGxXyVOBlcDB9qqFMiOnE2JfMWTyZHELrO0aBk4LrEIfUiUJKoritT+2xima/2WofdH+f3lHRC3ZWMRjAu5QN2m8QbyQFLM4JaacAzCblkZSQ8RZLOMLmA7CjZfeH8IpjrS4dDfPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173823; c=relaxed/simple;
	bh=CDapw1t9jFbDOSHFj5338b3DvTeaDf6vGx68NuFf7Bc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjX0k/+CelIvhOdqFPb9+mCmAdTI5IgpA2+KUsRZZXzJh4NvKSsAYBnBTm9VFDaZaBdVba2+D5B++2GZB5IA85k/GnNCavca5mZ5MRQAWG+DNsBr1EpGXHVhbQOul8dx145EM8o3RikULkGM3UFImnZUo80FGUGoGSvDAV2rKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HguG3RGi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HguG3RGi"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6950xUFB2705679;
	Sun, 4 Oct 2026 21:16:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	8AppGHRCGkHkMss6jcHx9nRvSXXa0G5dwqjuWraEf0=; b=HguG3RGiik8wu+t8N
	WUH9Re+I32ZiK5buWa0N84cc7IdOz1WiYGZ9BK+L9nkfKtTpWct4i+XP/b2VKWC/
	2t/O/NuTVb3fS46qH7+7JVSQcepM/st3r4rC4Udbv9/8U5vgbbDAOXAaTHEWk4OR
	UNLxRWub/vNbSqQp2qbFAhFhZTTDvUdph/IJRRYabCCn88q3u+1ZHyaRmxETVffb
	xXAUPlPjPW2md4KrjwgsCC8+PncEJN3RtHg7ezjH3xLrvSxYCmsn9rRctstEztlg
	C/Yfid+e13MhWs0COhO4Yj5aHW80TXfWqha1BX17UgPTUt0qZMOGVLi6D9pD0R2p
	Lzp8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h2y2kwmda-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Oct 2026 21:16:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 4 Oct 2026 21:16:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 4 Oct 2026 21:16:24 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0D7BE3F706D;
	Sun,  4 Oct 2026 21:16:18 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:46:12 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Message-ID: <asMkjGNqafk9xnC5@rkannoth-OptiPlex-7090>
References: <20260929022915.2704627-2-rkannoth@marvell.com>
 <179092987490.434549.16075378413092077912@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179092987490.434549.16075378413092077912@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxNiBTYWx0ZWRfX12LkkwVaPXLH
 0jDmCNY4iwijSUBwRsF7CB8XbQ3nUH9fzrKKy3/zYxbUp6fe8wVKTSDZFxD+WazYfwnloaIQNsx
 Yh05smm5lD2kjyiehI1ctreEcB38dpM5ALf6upOBAM4x4xz+AKjg6tZbYX/Y+WYbeCP4GATRy12
 6jhIria0mztwc3lId2xZ9LSV/oluLtEhXXZ/XnZJQBPp33mNIJHzbv2DuZj0gNK31vHzr75oqun
 ubtZvPSzmwnQ0XFo10XhdO6fUcwrimJSCYVBY2TkI+YD3Du3ZSvgjy8CDdGUNf5kcKXMANnv2PJ
 NdcwN+oZNVkxbB6yvhILrNQDNXA3p4coU+7amfl87pPpb6t570InfvduQSAkw4UFoFE2WhBBGlN
 nAxUK5fNFcntvwM9nnfNfxbYZyCjdwXgLnr78BMYyTN8Ff0/7qwxuuV/ZFs4FaD905pKOvIG2LN
 rA4w4H7odkXSRtDHDig==
X-Proofpoint-GUID: tFMiLYAwSLZd-EDhQ30S_w_lKbL0XIeI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxNiBTYWx0ZWRfX7CZlKCTOeYHZ
 VeO20jjeXP8irwOAa4MbmRzVaE8CgU8rmi4SvBApwdm7Lb3Q+f1LsCOiC0B52RaTUd0XaMfdFYG
 tHxPwS1P1KLa87szl8uv+CMXVZh9XDA=
X-Proofpoint-ORIG-GUID: tFMiLYAwSLZd-EDhQ30S_w_lKbL0XIeI
X-Authority-Analysis: v=2.4 cv=cctHPXDM c=1 sm=1 tr=0 ts=6ac3249d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=hbAsFnCSbouS6EmkqWQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01

On 2026-10-02 at 14:01:14, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 1 (3) · Medium: 1 (5) · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates the
>   shared rep-PF flags word with a plain, non-atomic read-modify-write:…
> - [Medium] The patch quietly fixes a serious representor bug but gives it
>   neither a Fixes: tag nor a description.

patch 1 is almost entirely mechanical (u64 masks → unsigned long + set_bit/clear_bit/test_bit)
It does not add new control flow. Reframed that way, every code issue Sashiko raised is a pre-existing defect
or race;

>
> Pre-existing issues:
> - [High] rvu_rep_destroy() (rep.c:637-643) calls free_netdev(rep->netdev)
>   and then kfree(rep->flow_cfg).
> - [High] rep->stats_wrk is a delayed_work inside rep_dev, which is
>   net_device private data.
> - [High] rvu_rep_mcam_flow_init() (rep.c:54-91) builds and sends NPC MCAM
>   alloc mailbox messages (otx2_mbox_alloc_msg_npc_mcam_alloc_entry(),…
> - [Medium] otx2_tc_del_flow() (otx2_tc.c:1197-1198) clears
>   OTX2_FLAG_TC_MARK_ENABLED on every delete of a mark flow, even when…
> - [Medium] rvu_rep_setup_tc_cb() (rep.c:115-121) ignores the return value
>   of rvu_rep_mcam_flow_init() and then publishes rep->flow_cfg to…
> - [Medium] rvu_rep_mcam_flow_init() (rep.c:43-52) always overwrites
>   rep->flow_cfg with a new kzalloc and never frees the previous one.
> - [Medium] rvu_rep_mcam_flow_init() allocates rep->flow_cfg with kzalloc
>   and never calls refcount_set(&flow_cfg->mark_flows, 1).
> - [Medium] rvu_rep_state_evt_handler() (rep.c:297-309) uses the result of
>   rvu_rep_get_repid() as an index into priv->reps[] without checking it,…
