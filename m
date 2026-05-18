Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CF291C10;
	Mon, 18 May 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116272; cv=none; b=Ud8W/RQI5+YYiYwSmTRRZJp5GkteNKlCM9Sa6TqirTclbv4rKGUlWOh2f6KMKJvvtyhotLSeyuQVP+yXxxKB53paIDsdcL0lnWf4th+h+PL4NvGs5XIzz0LETjGnGNQTPpdUEmvpYuuAP1IhTK2B0LuPivIoUK8/4l2vUot95WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116272; c=relaxed/simple;
	bh=7ktxawS5KVjLbM/w1D4iwouHsaHwsjNSABtQwEwl4As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI8CuEvuW7RHp10FroffmlvjYRhuXRC/Jz/6WzpFGC47nemXQTiTKVL0TAKo1qL6iglf0hZigy1f8s5Tk1tnMXB882VK9+DtDS8UHwZOtB0NhVqeT5WBuisbusAo7dpGad/fKRWDDWVlYYYcqL+c0PziUAJTHdDGjwDb37zLyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c4ADVz3V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c4ADVz3V"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICHoG31495254;
	Mon, 18 May 2026 14:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uA2IR4
	OCFja38JDVkfWG5CPL2UdDqkY2yoRaj0TkTsw=; b=c4ADVz3VptvzDFl9vqiwV5
	8alBoEr9SUHLDEP1b9lZekBa4rSakkX1kRq6JvNnnJuuKKbKL0XAuIreV1/ZMqJh
	vJaoM7kwJOHYQfSHApScItWNuKsb7RPEqawu3/X58J7DH1zvSRNFsoKFuUIAAtlG
	qZOHu4T06PcXnW2XnHKQix5kHYJEMhHJBCp7mpWjTVCTR8bkM8D0OusvYYa+62NH
	VNRHjnzrpgImWt22dhGjI7T0J5R9iliofwrlJ/7czHJREgxrBCCAOlw7QmLNHsCF
	rQOxjJWnXHdLze3JTLXGiUU72WIjcpmJmjv4zp6dzGsbhJrrffZp3749+yTFyBgA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb884u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 14:57:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IEs6fA007474;
	Mon, 18 May 2026 14:57:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxx3u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 14:57:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IEvhOu43581726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 14:57:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7392004B;
	Mon, 18 May 2026 14:57:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD3B20040;
	Mon, 18 May 2026 14:57:42 +0000 (GMT)
Received: from [9.111.207.149] (unknown [9.111.207.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 14:57:42 +0000 (GMT)
Message-ID: <8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
Date: Mon, 18 May 2026 16:57:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
 <20260505183531.C9EE8C2BCC7@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505183531.C9EE8C2BCC7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0MyBTYWx0ZWRfX3Kv8/mH/Yj5Q
 JfujWqt7VobuNy3SgXifwBTESg9MczRc6evReT8fN5fy3AXuvwMyVKSvJfhPShNQ35BLzCgI1PQ
 Qq53wn5O/rXUieiJ1hs6ICJ/MMQWyp3JIKFd8AwckG7J/MQNA3j5ESWuTnFPp7FLrQuLNUCGlRS
 9igOfdFq8aMbQPgHF05Y+v9snRC/JqWzfh9qUKDSw9HdmDXt3MjHiwAlLaoZNltzuNSZr5hNOHU
 CzAGpl/omnJ/aFrdSgokbEZTJ3FpTS62KVtl4O2ZWg64t5kvPOnu1Gl5ZsDZPg2pQ3tzsd5Fc5w
 X8ccBi6VL34zRU6n4z56k2ybg7OYCY541Rgwo+6IAMl8j4344nPNmGzUMlX2wn/hUOP6TLSBJtJ
 9bBSIOfPEENhilyb1eYLlYUKO32tSLcmx5l4t2ssinqbl+O2l2ZoSbJnjrjort3AqxBxghOYFip
 9X6iBdMsDAnT2uD87Bg==
X-Proofpoint-GUID: zr5uQ8bGz9pV_KoCLlFTyIoqix8SJAhr
X-Proofpoint-ORIG-GUID: 0UhcnhLBuGR-k1NDtznL7j9-oL9yISrN
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0b28ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pv3SwhiLR4WZEVut454A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180143

On 5/5/2026 8:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unprivileged user space can trigger a kernel warning (`WARN_ON_ONCE`) and potential panic by providing a maliciously crafted `.sframe` section.
> --
> 
> commit 20f03d41baa46baef137fb9a88081c8f92b5eb5f
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user: Enable archs that pass RA in a register
> 
> This commit updates the user space stack unwinder to support architectures
> that pass the return address in a register instead of saving it on the
> stack. It also handles architectures where the stack pointer may be
> unchanged in the topmost frame.
> 
>> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
>> index 64618618febde..bc2edae399556 100644
>> --- a/include/linux/unwind_user.h
>> +++ b/include/linux/unwind_user.h
>> @@ -23,6 +23,15 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
>>  #define unwind_user_at_function_start unwind_user_at_function_start
>>  #endif
>>  
>> +#ifndef unwind_user_get_ra_reg
>> +static inline int unwind_user_get_ra_reg(unsigned long *val)
>> +{
>> +	WARN_ON_ONCE(1);

Replace with the following to resolve below issue:

	dbg_once("unwind_user_get_ra_reg() not implemented\n");

> 
> Can a maliciously crafted .sframe section trigger this warning and panic
> the kernel if panic_on_warn is enabled?
> 
> The SFrame unwind data is parsed from user-provided ELF binaries, so the
> .sframe sections are entirely user-controlled.
> 
> If an unprivileged user on an architecture using the generic fallback
> provides an SFrame Frame Row Entry with dataword_count > 0 but an
> explicit ra_off dataword of 0, it appears this would bypass the
> frame->outermost check while keeping frame->ra_off == 0.

Valid.  On architectures that pass the RA on the stack and therefore do
not implement unwind_user_get_ra_reg(), such as x86-64, above
WARN_ON_ONCE(1) can be triggered using forged .sframe that maliciously
specifies the SFrame fixed RA offset (from CFA) as zero and has a SFrame
FRE with either no RA and FP offsets with a RA padding offset of zero.

> 
> When the kernel unwinds the stack, unwind_user_next_common() would see
> frame->ra_off == 0 and call unwind_user_get_ra_reg():
> 
> kernel/unwind/user.c:unwind_user_next_common() {
>     ...
> 	if (frame->ra_off) {
> 		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
> 			return -EINVAL;
> 	} else {
> 		if (!state->topmost || unwind_user_get_ra_reg(&ra))
> 			return -EINVAL;
> 	}
>     ...
> }
> 
> Would it be better to gracefully return an error code like -EINVAL here
> without raising a warning?
> 
>> +	return -EINVAL;
>> +}
> 
> [ ... ]
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

