Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56A3F54D9;
	Mon, 18 May 2026 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121782; cv=none; b=eL5ckd+joog+XUMh3+5vCxUZJoeS/jmiyNGHgcyJ8fveKi8yVewY+9jSLd05r+0P7oTIqIAsbWDR14RyPOkKFiVGE/KLDZPLD3XxgYy2OtL46RxKnZGSWLIxEg098GjMbMU12mejzFdVQBP5ExCvliEflPl/WJVMV7rkYBPYQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121782; c=relaxed/simple;
	bh=wX5cHt5MOV5qS2WFeJSpXMaa6oitFgNSICt71BtgmH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xwtf3D27v4P0lmQ8s6/UEDnmxPL31Ro4yr5kIMQSLCyMRZjaq49BzDRP6+p1fDbPp/SGxdkHRRFxfGXTf3LSqzpSvoexU29CDeiwjRg/G2KSsIrf+8IYNUieJJ6BQuv+91C7qI2fBmd3N+MxbW0OyWluiubWeu04xPZu9BxhWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SBmxuxou; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SBmxuxou"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IE3iJt2818971;
	Mon, 18 May 2026 16:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=edwsF8
	UOn8laCFkVUEWcJSCH3X7HFoCsyivED0AzOJA=; b=SBmxuxou5lU+Wyaq3fs5IR
	hT21lem4ixVpj/mUS0Ye5/okKomj7z20LNEiuOmPyCwfw2KUeQdz1AV99KBTdKka
	YlgURVJ+AegvZDW1ueZa9FXxefA/dr25bBRnUnim5DYRgZoDW0+2Kjxm+CGSv4ho
	qSCVfbivSvbfq4FGK0OC/BX9DRgtaYE/CMnLGnJTckGQlZScdMnxzCmo3aGaUM5O
	0JZKyrf34ymie6aMWkxtmnCA65ByW3qdvRNKfzkjMg3wUyp7I6fslvu7VBQnJaxa
	QpHElxiqiw+33jxt8zjqpqFdcLU7fodKpQiu0T7kPDiZgmEY454PMQ1uelwOQyZw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xs1my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 16:16:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IG9CsZ013597;
	Mon, 18 May 2026 16:16:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjxq2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 16:16:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IGGsbG57278770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 16:16:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2436B2004B;
	Mon, 18 May 2026 16:16:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8501120043;
	Mon, 18 May 2026 16:16:53 +0000 (GMT)
Received: from [9.111.207.149] (unknown [9.111.207.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 16:16:53 +0000 (GMT)
Message-ID: <bd711f74-a1f3-4410-975b-64e9009aaf30@linux.ibm.com>
Date: Mon, 18 May 2026 18:16:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
From: Jens Remus <jremus@linux.ibm.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
 <20260505183531.C9EE8C2BCC7@smtp.kernel.org>
 <8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE1OSBTYWx0ZWRfXyKJNM2YMkCuP
 NxWFjIrKTPskXL7CpeZPaTNMg6gyGgn7d96zK2A6tVhHUzpPuwg+9BEIOpI5cCmjirk7gwGfY1o
 WJQby43MHKSxV7uD+jiTYBO5F04CekQJ0prORHMjpChrwpHhKeWnO98k69uZaImieNBrYHLQfWh
 0XpedfSU5Na0oc71nqIqGYNT2FBucwGue2d+by3tTz5kwPG6c/R+tUm/FEgEJJQ35jrqhUZuaEx
 dLecJDvJf4eCfgUknb3U2tAwJDJFuhsZUoQuKo8qxfJW/e8i1BO4ISXwVDnar1r6XaUTCXYTN18
 LE9nHFFexjGgRVtIjF6LDK9HbQXNzvqb7ISGV4+EsXbI6k4BIsbZHnFXdrRchZqhhlH0uvQT9j/
 AmVbXshTSOGNdnLHVSEHHWiHkJzAFh2Je4pTmIKVr02z32WM8TYImaQVg3eQXF8yBotDXgR9Vl0
 Hrau0/PgqNb2iJqmYGw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b3b79 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=epHxvWqJeI6bM8ofl7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dt_oHQXb1FRo_1ogB8QhGzZ5wUrS87ZD
X-Proofpoint-GUID: OixFTxfIlWTM7ZcaCYDbfmsAUlGb66UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180159

On 5/18/2026 4:57 PM, Jens Remus wrote:
> On 5/5/2026 8:35 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] Unprivileged user space can trigger a kernel warning (`WARN_ON_ONCE`) and potential panic by providing a maliciously crafted `.sframe` section.
>> --
>>
>> commit 20f03d41baa46baef137fb9a88081c8f92b5eb5f
>> Author: Jens Remus <jremus@linux.ibm.com>
>>
>> unwind_user: Enable archs that pass RA in a register
>>
>> This commit updates the user space stack unwinder to support architectures
>> that pass the return address in a register instead of saving it on the
>> stack. It also handles architectures where the stack pointer may be
>> unchanged in the topmost frame.
>>
>>> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
>>> index 64618618febde..bc2edae399556 100644
>>> --- a/include/linux/unwind_user.h
>>> +++ b/include/linux/unwind_user.h
>>> @@ -23,6 +23,15 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
>>>  #define unwind_user_at_function_start unwind_user_at_function_start
>>>  #endif
>>>  
>>> +#ifndef unwind_user_get_ra_reg
>>> +static inline int unwind_user_get_ra_reg(unsigned long *val)
>>> +{
>>> +	WARN_ON_ONCE(1);
> 
> Replace with the following to resolve below issue:
> 
> 	dbg_once("unwind_user_get_ra_reg() not implemented\n");

Omit or replace by the following?

	pr_debug_once("%s (%d): unwind_user_get_ra_reg() not implemented\n",
		      current->comm, current->pid);

This did not work with dbg_once() defined in kernel/unwind/user.c as
follows, as linux/unwind_deferred.h includes linux/unwind_user.h and
therefore gets included into other modules that do not define dbg_once()
(e.g. via linux/irq-entry-common.h including linux/unwind_deferred.h).

Steven, Should I omit the dbg_once() or could I replace by the above
unguarded pr_debug_once()?


#ifdef CONFIG_DYNAMIC_DEBUG

#define dbg_once(fmt, ...)							\
	pr_debug_once("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)

#else /* !CONFIG_DYNAMIC_DEBUG */

#define dbg_once(args...)		no_printk(args)

#endif /* !CONFIG_DYNAMIC_DEBUG */

> 
>>
>> Can a maliciously crafted .sframe section trigger this warning and panic
>> the kernel if panic_on_warn is enabled?
>>
>> The SFrame unwind data is parsed from user-provided ELF binaries, so the
>> .sframe sections are entirely user-controlled.
>>
>> If an unprivileged user on an architecture using the generic fallback
>> provides an SFrame Frame Row Entry with dataword_count > 0 but an
>> explicit ra_off dataword of 0, it appears this would bypass the
>> frame->outermost check while keeping frame->ra_off == 0.
> 
> Valid.  On architectures that pass the RA on the stack and therefore do
> not implement unwind_user_get_ra_reg(), such as x86-64, above
> WARN_ON_ONCE(1) can be triggered using forged .sframe that maliciously
> specifies the SFrame fixed RA offset (from CFA) as zero and has a SFrame
> FRE with either no RA and FP offsets with a RA padding offset of zero.
> 
>>
>> When the kernel unwinds the stack, unwind_user_next_common() would see
>> frame->ra_off == 0 and call unwind_user_get_ra_reg():
>>
>> kernel/unwind/user.c:unwind_user_next_common() {
>>     ...
>> 	if (frame->ra_off) {
>> 		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
>> 			return -EINVAL;
>> 	} else {
>> 		if (!state->topmost || unwind_user_get_ra_reg(&ra))
>> 			return -EINVAL;
>> 	}
>>     ...
>> }
>>
>> Would it be better to gracefully return an error code like -EINVAL here
>> without raising a warning?
>>
>>> +	return -EINVAL;
>>> +}
>>
>> [ ... ]
>>
> 
> Regards,
> Jens

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

