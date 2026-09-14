Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A534C9A3;
	Mon, 14 Sep 2026 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355762; cv=none; b=nPkH1GFY8SP3gsO7rlK+jpLAqCmDy3GUeVzrpzFw+0kqs27C0a2BEbr0bmXOyoFEZimsi3JVQkLx+0rq9zaT0bAeydTICAqBOQdLzmdTSZgL58X3gqocZ3oen57Wpel80ltr8TaY48TvzXKgb5DObf3+rDwyJrJPgfW5SFBLb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355762; c=relaxed/simple;
	bh=6/S9Z5FG0s11+HWWVjIlFOzA2T+2EeMHBlP204wPstY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIRn3vKJPFF7m5z9Ss5ZGwXGpDoXZCeZ5GShuxriBEMSY4oF+gkcjvZhP7AadM0m2lak3dcS9UgjQCQGzX39ML78RZAXRY+pJuCQljmreaewqnG5bRZSe4zANrO/mw6y2GbAyXkvzCkMPVPoECqsPECyDp6Q4Pjb8uqV9KBJ0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fAx9a3L6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fAx9a3L6"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eT6d2045914;
	Sun, 13 Sep 2026 20:15:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6/S9Z5FG0s11+HWWVjIlFOzA2
	T+2EeMHBlP204wPstY=; b=fAx9a3L6OjsyNF/HCNzmRolxTAiXuwmnOy1kYsqEk
	k9x5Daw3RHOjJruOs3T+6WWZKpFNHlI3u+7h3sVeOsvEXtFp4L/qmRC2YoWATNY2
	9XUV1a6S1L59MbibqwSvOZi/sZFKDDYgsXsTRWxT1PtRSq8sgU+OvBrCQC57MQR3
	cYIBjtH1k4AFLJoD/Akth4wpMHb/iZSRoHFOUZp11UTrrW8k2+gVCZTQiF7hZJjI
	FnlWDzqzLSrpkD3oaSfLLNhkuGqshbun3alHj01rB13sRcVfwp17zMM/QHwSDhW5
	EdkwCGF0r5ktWnplT26Dz489Kj85MQyWPXQKndnjHdYVw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gnu08hc6g-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 20:15:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Sep 2026 20:15:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 13 Sep 2026 20:15:31 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 24A923F706F;
	Sun, 13 Sep 2026 20:15:29 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:45:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v15 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Message-ID: <aqdmy0GU7pV6wryi@rkannoth-OptiPlex-7090>
References: <20260911105521.689565-1-rkannoth@marvell.com>
 <20260911105521.689565-2-rkannoth@marvell.com>
 <20260912105628.B3E251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260912105628.B3E251F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA0MyBTYWx0ZWRfX6aCS7ZwJ3VEp
 sg5jp9fO0EJg1jTnU4PW1uEWL/9ICIzIHUaYpAOYod3ptanL+tIoXnrMjfpcIYUOznozt9ykg0W
 +c2OWyl1L2+qO+sr/n/6kTU5any+OjtXDiNOJKxC6+kyk0StQsnrVHAunJmGSZjrtRbmpcPyL/S
 UBVHiSfQZnjspKsj3h5ow5nawLLiAh1OPI8O7o/lJ9rsDTKD7m6hySbKyPhUc01x2f8LoG4WAGv
 XPShlkyW1USGazzi2AIGbcsaKm/vsCoQlJPxfUekwksD5ZUOsJts/KWlg01vSTHEiPePOMPvI94
 PliEOujMCBKHDIpOZTNJETCHRNMV2YYJ2Bd+3ontNE7Xj2cKMSiHVdVVEy9uGzwsmPK6aFJldLs
 38uGOml8JhOmfL4OlaV7+zZ7SiVZLRluTA3eBaxwuM8xOoL/LGqUnk7E1FR1jMRf1Uw01wEX2JV
 QNIQWYMUaJZH46/dfnw==
X-Proofpoint-GUID: C8dX82UJ-yqTehfBiYh2I3S3cZCHxRen
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6aa766e2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=xbFrFwBMfRNEcMa7yh4A:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA0MyBTYWx0ZWRfX/D4zd1Kppsb8
 N8NzXQkYi8bhap6Q8I38r9Fwxszwnk3c02Nxu34khfDhaHJrXWEsCIfJRP61DElSqOxUy8Tt+lA
 3g3Og6w/oFEheVv+4yrAVYlXWQ4qYVo=
X-Proofpoint-ORIG-GUID: C8dX82UJ-yqTehfBiYh2I3S3cZCHxRen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01

On 2026-09-12 at 16:26:28, sashiko-bot@kernel.org (sashiko-bot@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] TC offload setup on representors corrupts the shared physical function (PF) device state by locklessly overwriting its netdev and clobbering its flags via a non-atomic bitwise sync loop.
> - [High] Inverted logic in `otx2_tc_del_flow()` prematurely disables TC MARK hardware offload when any single mark rule is deleted.
> - [High] Missing cancellation of `stats_wrk` leads to a Use-After-Free during representor teardown.
> - [High] `rvu_rep_mcam_flow_init()` interacts with the mailbox without acquiring its lock and executes an unbalanced `mutex_unlock()`.
> --

I will address these in separate follow-up patches to the 'net' tree once this series is merged.
