Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C538331F;
	Thu, 11 Jun 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193542; cv=none; b=gpCVGqhsq8EnlpZCBcyYScxRtgIPEt6AcDH97xR5NtwvSUnQyEANgYYMZFv0mOnpuIBabfZ7T37eryfhbY7TbFqd1lBXtT1szaUBa6S/ABhPiVnLnqFRaXluUYWC9IcyfNuqcNa5EocTSshpSUjZ2B+AozF90Ped4eZwh1VLi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193542; c=relaxed/simple;
	bh=sx9AournhQHTNF7fKJWJ1VgdTtO+KQAZAQbKmR05WR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRGkkgMQnQgvCQLV0ksfohd9pLQETRQ8civ33oGuEhgLIkPwry+EwCb0XvZm/ZEOM2e0MRrUGD4xJDxcn9K/SnWZhkb39GXRU6vsk89/0/TGwgtfq+n1Au7BL/Qry9xPacrt8/0WIdCGHqBFBFFUZXgLf9OQOOKFEZP/AvZTp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PhOkQVLw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PhOkQVLw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBj3JX1741947;
	Thu, 11 Jun 2026 15:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QLi9Gb
	rXHsKz/1fopsLHCuYdF0LQ+nJMGcgV5r3sUVE=; b=PhOkQVLwkoG9Sfk+j6nEbo
	7yShRzJjfLJVfQOSIu21KSocNllNWzm3O2ITOZzS+6M1Fxg3GQwv7O+yN3yPMbOt
	jU8mvwOWCTcruibPfyCTm+m4JAyqL3bqPHO8AQjrZO7a324PTNMsdyQ8MS35Hw9x
	lQu3hVFznJFi6ZiNmQU7G3/nn51HPkp23wqQ7Ym9sJeq9PmbGdP1q3ntpr1W7Ggp
	pnlXvm2c5lY2BZg+6bN1GgC+mKIXiuMXx6Dn8LUjznAKlT9gsAd/P1qdJ7bQR6z0
	FxBR1qcMDZ26VFDWmEGQ2kGkaKSpg4k/MyPZXsbpfFmSibqtl6EwNXtH5uqXgeoA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bmj6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:58:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BFnuBP000369;
	Thu, 11 Jun 2026 15:58:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08uvjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:58:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BFwlNC57344340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:58:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C41D02004B;
	Thu, 11 Jun 2026 15:58:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CA420040;
	Thu, 11 Jun 2026 15:58:47 +0000 (GMT)
Received: from [9.224.91.136] (unknown [9.224.91.136])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:58:47 +0000 (GMT)
Message-ID: <7890fc57-f250-4bab-916b-f5855eb38b33@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:58:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/6] x86/asm: Use CFI_* macros in SYM_FUNC_* macros so
 they can be added to VDSO
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260522110427.2816637-4-jremus@linux.ibm.com>
 <20260522115844.9BEEB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260522115844.9BEEB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2adb3a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HSAZBKcgB-AHDwtM:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4nY6BhhXb-sw2prgwzAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfX2lzCUKERLALc
 4LT5CDJKS4a6JWw+U5G3DJU8TBnP16OVVr8QlciAtfZoJD/DCQHeSH5di7KzCYfrluLAeFIcjWA
 bGPrwKy5Q/xTYe8YgcLKsfRwNI9tNLr+KwhxjI+ziNvl5605naB1YLSgY0ODIKZqvc/0a6E3/Qu
 4t3DFhHouwDrkvKH/AjhjANEEpT+zVv8/oftFgsKYE3c6H1CNoM14smMxsbe7RgfF4DoW7+ElPB
 BrTGxsLoOelE+pSmgpnKimfOWJM7qmnCmJnjHP6i3bum3ytGj59NCYLd32/zZZ64rBDVeUztuhV
 bYOw/AfViz+oM9RCqBmtYTcRfzxIidVeKL+9pNsoxwyteKZ7wYvYjaRPyq1EBw7jhNay0dZHaYs
 o/VoRWyYUHw372dCr5bgGoz/BMCXQsPoPRR5bFJ3UpauyiApBRncFl557XXsCpRvpQi9LUUm0tQ
 FVEITObT1rUzGVxLKgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXziTrJ70aHG4X
 C0A4ihSDY+JRsztXwwGsKvaKFn5v1r1Q1LWTlFVXEqIuBbXTWNWpe0AcWtbzRo05kriJsD5itIT
 zpb8vFsPx1k+mUAx/lnVY/zu0w35gVY=
X-Proofpoint-ORIG-GUID: X-3WjSLoMWiCd0r2i0r4NLPMfZlMB0K5
X-Proofpoint-GUID: D7u7ZnjLUv9j9D3x9dQYiYvcFeO9ojWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110157

On 5/22/2026 1:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `__CFI_TYPE` macro in `arch/x86/include/asm/linkage.h` creates unbalanced CFI directives because it uses `SYM_START` but closes with `SYM_FUNC_END`.
> --
> 
> commit 2769cdf2ca16b1b56aace01ab1acf0951b91be1f
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to VDSO
> 
> This commit adds CFI_STARTPROC and CFI_ENDPROC annotations to the SYM_FUNC_*
> macros. This allows VDSO asm functions to avoid adding them manually, while
> leaving the macros empty for the kernel proper.
> 
>> diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
>> index a7294656ad908..c2ca8117376fb 100644
>> --- a/arch/x86/include/asm/linkage.h
>> +++ b/arch/x86/include/asm/linkage.h
>> @@ -112,34 +116,51 @@
>>  # define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
>>  #endif
>>  
>> +#define __SYM_FUNC_START				\
>> +	CFI_STARTPROC ASM_NL
>> +
>> +#define __SYM_FUNC_END					\
>> +	CFI_ENDPROC ASM_NL
> 
> [ ... ]
> 
>> +#define SYM_FUNC_END(name)				\
>> +	__SYM_FUNC_END					\
>> +	SYM_END(name, SYM_T_FUNC)
> 
> [Severity: Low]
> Does this change to SYM_FUNC_END() create unbalanced CFI directives when
> used with __CFI_TYPE()?
> 
> The __CFI_TYPE() macro is defined earlier in this file to expand to a
> block that starts with SYM_START() and ends with SYM_FUNC_END():
> 
> #define __CFI_TYPE(name)                                        \
>         SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)        \
>         ...                                                     \
>         SYM_FUNC_END(__cfi_##name)

	SYM_END(__cfi_##name, SYM_T_FUNC)

> 
> Because SYM_START() does not emit CFI_STARTPROC (unlike SYM_FUNC_START()),
> code expanding __CFI_TYPE() will now emit a CFI_ENDPROC directive without
> a corresponding CFI_STARTPROC.
> 
> While this might not break the build today since CFI_ENDPROC evaluates to an
> empty nocfi macro outside VDSO and __CFI_TYPE() is not used in VDSO code,
> will this cause issues if KCFI or typed symbols are ever used in VDSO builds?

IIUC kCFI would never be used in VDSO builds.  But CFI_STARTPROC and
CFI_ENDPROC could evaluate to the actual DWARF CFI directives outside
of VDSO in the future.

> 
> Should __CFI_TYPE() pair SYM_START() with SYM_END() instead?

Makes sense, as any future changes that require SYM_FUNC_START*() to be 
paired with SYM_FUNC_END() would cause to __CFI_TYPE() to break.

I have sent a separate patch:
[PATCH] x86/cfi: Use symmetric SYM_START and SYM_END in __CFI_TYPE()
https://lore.kernel.org/all/20260611155716.830563-1-jremus@linux.ibm.com/

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

