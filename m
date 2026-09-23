Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01334D4F9;
	Wed, 23 Sep 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128022; cv=none; b=CnG6N2h2Cpuuy984TJgPLkjU0SusPj6RPhrjDPxCqchfiUPJ9aiLgBigmbGkfzO3sOxrswBZ7UZkulpSInfAZykTGKjr6S5VWSqHhOypEwRz38QQwzfqvju57E72hZxpAUmzIx9v6cR8tPEjWxhhxoHeJ+hH5749Rj/JrQcaIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128022; c=relaxed/simple;
	bh=XDuCX5mpDUYPZq4gdQrExw0wdk9ti/C0Roso2HobxSo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SskgBSmnoYxxBjOC3I61MtnE3AGBi9ghNhuv4tScvDYsuJVuPBQXknhNdk0bwtEn6Dk0k1Z3xHNIh7GSgzK2yej7v8LyAvcrt90umAsOZo6zx6qu8iKOHXgfOVrZqueOcXE0JWi/aPe9y/FqoyKonAlYeOtlJieMcpMwiKWDM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D+bhSRva; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D+bhSRva"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIJhnf008855;
	Tue, 22 Sep 2026 18:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	ynuKi0WJ7na1xrBPe/e2ovkHYbRbpN2M+SWPcznReY=; b=D+bhSRvaZycsnROvH
	8STmDLw0PIzVnIEO8sM+DlJn51cJqIBvrX0ZpXXls+EWwNklcEnSoYQtQaIa7704
	DZ6QcqcC/KXNeUTVOMTpscjdjHls2qGjY0VMjErvThmma1kyZDR9XZyRIM/O2IYU
	u1UHla+ziDNcPBWGcZEvljhPXiTcyiimi1padCPCUx6aasCM1L6DU4epZ+o0/grz
	XBAn2bCYC6indQv9KYU2+Fbe9Jhp0XeocDt+yWt5RBmHOEqFXF9rwEUpHPvBHWaW
	5oFkx8RRfLmmKGJ7/r5euMElQjGsfLMJIqkduzhSg974ID7GPvJU85VbpNpR4FI/
	lUofQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4guvwu304f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 18:46:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 18:46:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 18:46:25 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3CD313F7072;
	Tue, 22 Sep 2026 18:46:20 -0700 (PDT)
Date: Wed, 23 Sep 2026 07:16:15 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v16 net-next 2/2] octeontx2-pf: add mqprio bandwidth
 offload for NIX TX schedulers
Message-ID: <arMvZ-N227m8lpCL@rkannoth-OptiPlex-7090>
References: <20260918015906.1255204-3-rkannoth@marvell.com>
 <179004355373.2160803.6964448826928226346@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179004355373.2160803.6964448826928226346@kernel.org>
X-Proofpoint-ORIG-GUID: jFBeiJTeTOdqrDBvCUyyXwO4iWTvbSIH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNiBTYWx0ZWRfX4sjzAGjC1G27
 hMbe1stVRpa43V9985Ax1HAnJRoLbiBGhciOVYXL3X1ujI5imLQJoBHAPUfNwsmG0lYd4vjpEuC
 yDKBJi8sh6/ZjyI08OHcITRHSKe4FCM=
X-Authority-Analysis: v=2.4 cv=b/UncdGx c=1 sm=1 tr=0 ts=6ab32f72 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=4cC4gU3_DxgSVQyE84wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNiBTYWx0ZWRfX8VW4lKZh3cWT
 gfq/sxwhWvidv7Z/NjBzZAsUatlPDl5Y84VV0aGYPEvNRu5aawKWwbijkID/eb0GzcJYYD+EhPP
 i3a/o7OSH+VQkWrz0uucI2KLALw+uC8FGlPyUav9LI5EZThdx0JFgqt8ktCwD9rn166zbL/wzej
 e9dv18LBtxXrDzdLE+24OXRkYdMcFXFZUcbP+5iplEGSD9W2n4RNmIf3RKTitAoCxYBtLCIgTS2
 jLoD8CkMvUoTnaCD4XikN4dth5QNqzvL80qrUV9LXZhYRpXbROSsybMYVt4oDK49uEguzvwu/ZH
 blLa61PIUUINcrXZMUPA2oDv4JUx+u/8B9x9nS9M81wepeyXEBYbDBcwZAVaM/4SMFa99TUXGvr
 5UuqNUQZpAvvr0O8i1GntcRsYYjiIZFRwU9wfPv44Wez+a62dqw0S6PHIij3RQlNkMthwwXfM+3
 qeDjGgyHxqDcGQ5GA3g==
X-Proofpoint-GUID: jFBeiJTeTOdqrDBvCUyyXwO4iWTvbSIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01

On 2026-09-22 at 07:49:13, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 17 potential
> issue(s) to consider.
>
> Critical: 0 · High: 7 · Medium: 9 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] otx2_mqprio_restart_netdev() manipulates the core-owned
>   __LINK_STATE_START bit directly (clear_bit()/set_bit()) to fake…
> - [High] When otx2_nix_tm_clear_queue_shaper() fails, otx2_mqprio_down()
>   deliberately returns the error and keeps pfvf->mqprio.rate_limit =…
> - [High] otx2_mqprio_netdev_tc_work() reads pfvf->mqprio.rate_limit and
>   pfvf->old_mq_snap before taking rtnl_lock() and never re-validates…
> - [High] Every early validation return in otx2_setup_tc_mqprio()
>   (interface not UP, wrong shaper, no CIR+PIR, SDP rep, PFC enabled, XDP…
> - [High] A successful mqprio replacement is rolled back when
>   NETIF_F_HW_TC is not enabled, which is the default for these devices.
> - [High] Replacing a software mqprio root with an offloaded mqprio
>   succeeds but loses the newly installed traffic-class layout.
> - [High] The new mqprio.netdev_tc_work dereferences pfvf->netdev and
>   pfvf->old_mq_snap and mutates core netdev TC state, but…
> - [Medium] Two changes to code shared by all PF/VF configurations are
>   bundled into this feature patch with no mention in the commit message:…
> - [Medium] The commit message claims failed setup 'rolls back via netdev
>   restart' and the code reports 'mqprio: replace failed; prior…
> - [Medium] otx2_mqprio_max_rate_bytes_ps() derives a maximum *rate*
>   (bytes/s) from the NIX *burst-size* constants MAX_BURST_SIZE (130816…
> - [Medium] The driver reconstructs the core qdisc replace state machine:
>   otx2_mqprio_keep_netdev_tc() strcmp()s…
> - [Medium] otx2_txschq_stop() now zeroes pfvf->hw.txschq_cnt[] on every
>   interface stop, but otx2_get_smq_idx() computes 'idx = qidx %…
> - [Medium] A failed mqprio replacement can leave the surviving old qdisc
>   inconsistent with both the driver's cached state and the programmed…
> - [Medium] pf->refill_wrk (devm_kcalloc'd array of INIT_DELAYED_WORK'd
>   struct refill_work, allocated in otx2_config_nix_queues() from…
> - [Medium] INIT_WORK(&nic->mqprio.netdev_tc_work,
>   otx2_mqprio_netdev_tc_work) is performed in otx2_init_tc(), which runs…
> - [Medium] otx2_nix_tm_set_queue_shaper() programs both MDQ PIR and CIR
>   via otx2_get_txschq_rate_regval(pfvf, rate, 0), and burst == 0 in…
> - [Low] Two new comments describe the hard-coded burst value 65536 in the
>   HTB shaper path as 'the kernel-side default burst when HTB does not…
>
Will address in v17.

pw-bot: changes-requested
