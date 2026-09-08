Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FD37A494;
	Tue,  8 Sep 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848519; cv=none; b=AHVkuNFt9p+pax+duKRqXfc7wjEdWBuPw90yR2TgSS9T1FkCD1TZmJjPljbbt4lRCLccAf7LBvZolHzQubomLFmUBP1OCLv1c6llILd7imPPi3okZDOsCO9SuBCnM5DbVx6My8Uy8ulAkodWsRPKxMJGlhLGhHEKM0otTrqkroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848519; c=relaxed/simple;
	bh=3VycUhpdwHbxfQRDQyilst+mNIkr6plBOkBxjMIVv1s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qlxy1XKnNGn26zkwZgv44lDN5/xI7wscJXaH9R8P/P1emLxDpNk4Lr8nBjfNRtYwP19gOIkuGbn9LDAGw71zRHzsnjgkIu4uZGDhV99u9cA0HwJsjwbr89EH/E+6cdYP0b+k8goNBv7xcodT/71RL/VKWVkH/5v9ANo6H9NTuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LsPUb1n+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LsPUb1n+"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Nqf3w2879773;
	Mon, 7 Sep 2026 23:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=3VycUhpdwHbxfQRDQyilst+mN
	Ikr6plBOkBxjMIVv1s=; b=LsPUb1n+4bBIqGXqSyfPeWlAmGHQjca+PrCOzFHJN
	v/puX5k8iQ/ltDtF1EPR1rA4F8S30y7hOmg/Vo0P+cq2H2W7q4ku/UXcvKK/3val
	z1idhX9vmYSreo+WV4o68czbJxTZazLc3kLXNmuT5Rc6hKgZdfdjMHMIJm2EnbQy
	qsMDdTZ7svlIJUfiwKOPyXSgr3gr/NUgMvx3oPG+skYb1oMcnHKnXcz74Mi6TFpy
	A++25c5pLN8B03XZpcIFnOLi7KZrssir1hEkmU+b7ANLnkw2Xl5LtHlIgVoCOuUv
	Y96lkMwzP34ldlmtkJYUccSuUAssQJ/JHksmy2gM5PhUQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gh7b94xua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 23:21:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 23:21:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 23:21:49 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8CCEF3F7077;
	Mon,  7 Sep 2026 23:21:48 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:51:42 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v13 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <ap-pdktpQJ8y3LYx@rkannoth-OptiPlex-7090>
References: <20260904031553.3196916-1-rkannoth@marvell.com>
 <20260905031641.F3C191F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260905031641.F3C191F00A3D@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=J/SaKgnS c=1 sm=1 tr=0 ts=6a9fa97f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=jB5l-w-mdJaMWxz8i1YA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: xgjMiF3j1-hNBJKI02l-IL0MmANao2cu
X-Proofpoint-ORIG-GUID: xgjMiF3j1-hNBJKI02l-IL0MmANao2cu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2NyBTYWx0ZWRfX15aOg9I9SZkG
 cwQNW1Ge3oH10my4dUqXfWTq/It54w/4yiGVkhSMv3dcyEwXL4lyQ8rFCtDZoAd7TM/n96a5Wx+
 FT9tukqQz19jHDU+tta7eozIUxT7WHUlb/TFNiAixpjMr26ThTwA4rmf05QHpHYyS+K2f1G3oLS
 aVCN6dWhb3h6UScKwDjLZvQ5IO1eRxJWDttEJS+2jDL+KPkwtEoGfdOR0okGVDiCUdHMmcRS5u4
 6mMfuFJYUJn8YMrT4LpfGTDcbkinmN1cQ6M/MWujPCSzHPznh1BnL3kZQDq8+fgKydkwgGaQ2ns
 prNKT6xuRCPuxuF7E3e9uyv3nvTOGsBw4t/LAndWYMBE7muiToHQxr8OgB9wHUYrZfm7gyjwskQ
 vXbSdj/ffMa/X8XLA1A2jDR2wQLi0dyr3z5PuLGmzSFw3RXsRJv9CjxFl3WkDNtR2Ox4izUT3xa
 fWng+tz10YuntUG/C3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2NyBTYWx0ZWRfXzPvlLylI1fyW
 CFyhOwM60yBPrgA/qCSbW7uvB0oeBtZkZ+BldOgJcMauaNuMqwZOCxhij3RtHqmjQNifRwlJxOJ
 u66d8GrRGZoG0m+u+4UDoSxi23rU+pc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01

On 2026-09-05 at 08:46:41, sashiko-bot@kernel.org (sashiko-bot@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Use-After-Free of transmit queue structure (qset.sq) due to direct ndo_stop() call without disabling TX
> - [High] Non-atomic read-modify-write of `pfvf->flags` causes a lost update of `OTX2_FLAG_INTF_DOWN`, leading to a double free of queue memory and IRQs.
>
> Pre-existing issues:
> - [High] Hardware QoS queues are not re-allocated after an interface bounce, causing configuration of invalid/unallocated TX schedulers.
> --

Will address in v14

pw-bot: changes-requested
