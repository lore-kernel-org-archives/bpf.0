Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA541A930
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908750; cv=none; b=c0lRslPjP8TYE9QskU9I01xnlObGbz3z/g0tePuq58jQ/fIeRAWORjVk03kB0TfA7lciWNwlNSEQ2tikQTzUPygGIVtFbh2Rc1rCdMrTqi24n7n0lF5tSE784tzN3O469F7UHUCiAwTwlmxlvoavEET9pC6msnZeCDLxA70S6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908750; c=relaxed/simple;
	bh=1Cc8Pld4ccgxZgDOJgYItS+t5Qrfsm4GyxgX6zhZSAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjwVNQOtxLs880e1CPa6KAgy+4avVXMkltVUe49eUyYdCPjJ2AG3kX3cfunyYGRzBM7MIBzYSHsiC7etwmtfrJV27c7Svh7tCYgczcj8XjUzy8K95f8NguvYm1E56jHTRYrRHvx1AAKZ95WTwqNu95EJ6ngPGyH+2sU4qUQeeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dJi2KF+v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dJi2KF+v"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfvr01994252;
	Fri, 24 Jul 2026 15:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bBhCeux3vHUJvInLH0VRQl/72nggLj
	e/sSYMy51Akzg=; b=dJi2KF+vg2N/zFOdy7+jzipAk9DlAZNuKARlH6TZkd2jW4
	5464u6NLM1DC8ilGBJHXOQ0oMkl2LkKi5fqRaM9KUkYyzqa3yUd8cJztuKWqOl/o
	7i/kLs4yq4eooRPzvH+z3X+gAI9MwuWV8vM4sfQcq7F5FFL16VzDxxN7sJupIuHc
	WRxK70R9wBWVbIwRGAlQWw2hVCmZrgtMz044Sb1KdMrqjd+KMHGDk48Z35g7md79
	itvz8bYE6rVJbquGd19HsLfBaJfjQBzl6nZjmMvgkN8vuEX/kBai3X71o0NbEpg5
	If1kTeJAqCeQk1zpHPaK0I0c8nCqfAtqHGnWIPWA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmu3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 15:58:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OFndNA009213;
	Fri, 24 Jul 2026 15:58:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqhrkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 15:58:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OFwmpM47513986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 15:58:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F4152004D;
	Fri, 24 Jul 2026 15:29:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54C32004B;
	Fri, 24 Jul 2026 15:29:06 +0000 (GMT)
Received: from osiris (unknown [9.111.14.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 15:29:06 +0000 (GMT)
Date: Fri, 24 Jul 2026 17:29:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
        eddyz87@gmail.com, memxor@gmail.com,
        Mykyta Yatsenko <yatsenko@meta.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>
Subject: Re: [PATCH bpf-next v8 7/9] bpf: task work scheduling kfuncs
Message-ID: <20260724152905.220718B7d-hca@linux.ibm.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
 <20250923112404.668720-8-mykyta.yatsenko5@gmail.com>
 <20260724112221.212464A3f-hca@linux.ibm.com>
 <ee9e9748-c791-44a6-a1eb-b6973f304b1f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9e9748-c791-44a6-a1eb-b6973f304b1f@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QYt4qRnouM8kH5vqJAYK_uRHsQfC8QIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfX6dWUhq86bww1
 WEOryEuE2BXCmvnuzS/qK9buB+hO2t5x9yZr3WqZ8IkbNdEjFa052pFmFZQNkLs2mHuBxJwclLZ
 DkHjnKIpFmR/6izxnIuCtuIUaw8PNH96YNmjJzfdTiY0ksWWP2CzOwCX0AJnSZWN0eNsTjU7+KN
 Jd9Cq96RChpgqlhRhS6eahIbVt6aXudIssI9N3WFaQK9oO62eDgWrIFNUUgF5FxYN6oWSGLH+RG
 IhPIRO8MxWwu97tk5gzC4d0T8imch9QsxMelN17YBgsfg12+NnxgCH+ivLlRI84jyYve2RoEtu1
 CkEQdSALAHi7xz87NeYJEp/4MAvjHBR8ZzBU74CFJM7W5NcujSej8E8QxOHikMChB0Bqn7P/r/x
 xzIbAKNeeU1uMnFeNeTOPTgDo59s2JcbC37S0OtCLmyVyVu4y3owoi7citwDTtR8ErXX2xpHMEL
 CixC9r2vZVuCWnV2SIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfX21faJN7fFfQ/
 9naSVUqf9pj8lS38f8YtWn9KFpkTJrVbparna73LmI/uNSdgUZnURKDp7TxiUGwdL23+XGP07HB
 Qwiyo6EysiG/J+ZgQuaDubzeeQjlZ0I=
X-Proofpoint-GUID: DLoelGsn5d9JjYDnBigkt32LW1m_SfGD
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a638bbd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VabnemYjAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_1eai4IEQJnwGLGfP70A:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240141

On Fri, Jul 24, 2026 at 02:06:58PM +0100, Mykyta Yatsenko wrote:
> On 7/24/26 12:22 PM, Heiko Carstens wrote:
> > On Tue, Sep 23, 2025 at 12:24:02PM +0100, Mykyta Yatsenko wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
> >> program schedule task_work callbacks for a target task:
> >>  * bpf_task_work_schedule_signal() - schedules with TWA_SIGNAL
> >>  * bpf_task_work_schedule_resume() - schedules with TWA_RESUME
> > 
> > ...
> > 
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> >> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> >> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> ---
> >>  kernel/bpf/helpers.c | 292 ++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 290 insertions(+), 2 deletions(-)
> > 
> > ...
> > 
> >> +static void bpf_task_work_callback(struct callback_head *cb)
> >> +{
> > ...
> >> +	migrate_disable();
> >> +	ctx->callback_fn(ctx->map, key, ctx->map_val);
> >> +	migrate_enable();
> > 
> > The above indirect call results in a CFI failure - while trying to make kCFI
> > work on s390, and running the bpf selftests I stumbled across this, which can
> > also be reproduced on x86:
> > 
> 
> Thanks for reporting, I'll take a look.

FWIW, there is another thing to consider: architectures which select
ARCH_SUPPORTS_CFI only optionally need to support kCFI for BPF.

In order to avoid CFI failures because of missing CFI hashes of BPF programs,
functions which call such programs indirectly need to have the overridable
__bpfcall attribute. So something like this is required as well:

-static void bpf_task_work_callback(struct callback_head *cb)
+static __bpfcall void bpf_task_work_callback(struct callback_head *cb)
