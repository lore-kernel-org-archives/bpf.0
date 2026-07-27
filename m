Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB432570D;
	Mon, 27 Jul 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161628; cv=none; b=gOzq7qABs+I68A/Zn2SaAx/ih16Yus4+9gtNlS3pY1uH+oMyOVD7d48x/XbBs+MVMGzbbH1MzsJTNdQ/fU5tAOIdjxbhMzgQrrqfJU688XDW4P6amOYjyJoucTWabv7XkMKnTJ5Pnt6n2jrPkLo/eKIkE7KIORcJFZf52q8dL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161628; c=relaxed/simple;
	bh=Vol3jpbbl3AVK8usQifFXWc/5UOgJn8K2NirLpdC430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCSdD/ffhawQPMQ/yNA0pSZZlcXv0TH9WrwvL3k9WfsowE/lPp89aVrY1FBYKAQWq0jTbD+OrWvrnrRfeGqiUKnM47whifDQKaiJMjWvRpHIpsONfwNafTO7yCPPSKGvCA+1HLPTsqZN1G9w4GmkHfqspxBeph+a22m9zNg7wZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PCfFmwzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PCfFmwzP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnYbq2298841;
	Mon, 27 Jul 2026 14:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+KLwLIkL3ZrHGF4EWw5yha5F1iWyji
	WrTHzZ2hWD6Wg=; b=PCfFmwzPwKIGUNiNoaxysuDTIDPMEoMzLHoG8E7eJgDhLk
	CAYFmz25hiLTK5vLZXFkwMijr6OEy8bEr9wgEuwND/BeKHj4f/cRyJ/qo4Z3Nvyg
	qiW9c8sIfXkG2d5bEbT9jLIlo459I7NOwmJ+bIfsKSxINCgeDvHIOdI3UWXpEWJt
	+UhMU3oDll7G5oVVW5ssqkPHiAbZwaSfDNv4g1h3sSVYgQi3mD00ph5q8pgsLkpQ
	bb5BAjQjVndLCyxRMgsLYtedOI+wSIUqISu0AKNwIPwVG1NMqbrH2XYF79q4QJjC
	jVUqRZgi+sp/THF8phhcsVg7L9fcnmoNhnZfgmBA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0082-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:13:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REBESJ020486;
	Mon, 27 Jul 2026 14:13:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwdgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:13:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66REDFSk52494736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:13:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9F120242;
	Mon, 27 Jul 2026 14:13:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D0120247;
	Mon, 27 Jul 2026 14:13:04 +0000 (GMT)
Received: from osiris (unknown [9.111.92.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Jul 2026 14:13:04 +0000 (GMT)
Date: Mon, 27 Jul 2026 16:13:02 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add __bpfcall attribute to
 bpf_task_work_callback()
Message-ID: <20260727141302.11274B21-hca@linux.ibm.com>
References: <20260727093834.2178900-1-hca@linux.ibm.com>
 <c1b15a2a-88d2-4f30-a827-9a96bc35b365@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b15a2a-88d2-4f30-a827-9a96bc35b365@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX8pSjzkUWIKjW
 73Rx8hX6TT6VZhWC9IUADPj0Gu6r6UTYP+nGDLFH+78pCt+ooyGGQMOph7SrAsA6cKyXA1Fc0lZ
 1fgqNFt+9U+B8sBze7w3DlSMO0oBA7I=
X-Proofpoint-GUID: S6kK0UOCQRJFqQ-d7ng5W1m0JAkgLrfc
X-Proofpoint-ORIG-GUID: HFqSRxo0KVg9W0kVZuU89tV0CKmxPn9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX7qDWyLCD6mcU
 9dmsBXj/jLaj150QNiNNVta56umwkrpukQWyTrKipGTIR4bIPq52n/SHc948pRsAi+RtP1JxQhN
 HKRelah08gtQVV+UtaZfiaG5psBKdZ36ka4uChSaQH4dKJ8owdXaVZK6XsL2NNBr4eSb/BNcZl9
 sbApwJ2MNW0pYCQ9Gt6bEMkDGdxEp2awTEDBqrhnlHG5CRfJtyTI8+ot048KoY6qZEJ5M6dAokh
 a59TuGNFgufqyxvdTZWtx6FKbida+QBQfPli9m/zbY2w7IiwAolptk0ZIKjcm369Cw+PBtw4JoZ
 4P+Rvn+THQM3s0LElcGCHuV5o3n1GiuaogQicRCpndFEaCEEg40Wr5eFLbJjDPt5pyz58gmtDEN
 /AUYvw9y1jkfqOrAuKcIuE/EY7eroReaC2zKRdUNVOa7PKK63+fFaS/x2SbkNbOVs9GXVGjBkqo
 WGL8sl42HAKb0wc7x/w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67677f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=VnNF1IyMAAAA:8 a=fa0q2D8Ytb5k2YrVW48A:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270132

On Mon, Jul 27, 2026 at 02:09:12PM +0100, Mykyta Yatsenko wrote:
> On 7/27/26 10:38 AM, Heiko Carstens wrote:
> > BPF kCFI support is optional for architectures which support kCFI.
> > If an architecture provides bpf kCFI support it must override the
> > default __bpfcall define (which translates to __nocfi).
> > 
> > Add the missing __bpfcall attribute to bpf_task_work_callback() which
> > calls bpf programs indirectly to avoid CFI checks for such cases.
> > 
> > Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  kernel/bpf/helpers.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 88b38db47de9..9bf82c9ea1da 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -4447,7 +4447,7 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> >  		bpf_task_work_ctx_put(ctx);
> >  }
> >  
> > -static void bpf_task_work_callback(struct callback_head *cb)
> > +static __bpfcall void bpf_task_work_callback(struct callback_head *cb)
> 
> Thanks for the patch, I've already sent another fix:
> https://lore.kernel.org/all/20260724-task_work_cfi-v1-1-2616691781ed@meta.com/
> Is __bpfcall still needed?

Yes, it is needed for architectures which select ARCH_SUPPORTS_CFI, and which
in addition support bpf, but do not provide CFI support for bpf programs.

As of now it looks like this is only the case for arm, at least as far as I
understand the code. It might be easier to implement bpf/cfi support for arm,
then drop the __bpfcall macro entirely, and require from future architectures
to provde bpf/cfi support whenever they select ARCH_SUPPORTS_CFI.

I'm writing the above, since due to AI feedback to this patch, there seem to
be more bpf functions which call bpf programs indirectly and which miss the
__bpfcall attribute.
