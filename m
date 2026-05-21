Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D93859C9;
	Thu, 21 May 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364745; cv=none; b=EvmUe1VFc8eDRslaP4Kra/xgDyKOWi1xfV3n3EJsvxhnyYfajEudWdpet/oE9ojj+PXNaN0KbXoNpDcUzHTymOl3QSnJE5D3nNIljwSCr7Uoi2jif4DeM8CIiQleaUswa8fSqd4EEWij9xfZJJVOjYb5hsUTMmro7mz5nhCAzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364745; c=relaxed/simple;
	bh=6R55RaKU35cthWSmstgvsGVH8FT4aEmvq9iWOB0k8Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rX0+Pm6YzOKNIXZbpb+yzg+V18TrVwJ3APQ7R/UvTOvQkYAZ+lk4rkemXBj0XtpTmV4KnFjEtWb51h+fdGzHK1vGEKNUS+LFm5mfRyOq4b1icFAhk1lAO9/8aQVETdz66lbFw+AZjOaNS2ewRUYdXPuhiPS7EoAi/tD8sADjtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pSz9nYys; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pSz9nYys"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KLK9N52070048;
	Thu, 21 May 2026 11:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P3agUU
	pYlk1cV/jDW3hG/Eq3qsa8YD+bMuWoEsaUdEs=; b=pSz9nYysVFzq7+3ransRpv
	D6hW/NCY55/OeWaDjBogHrRsk2KB81NnS+CR6NeJRVHRnmNMI1/KvGgc0ICDdR8y
	5omeMr0v1yw0lPMluBb8jAfiA8bKL6cauOE9beTw0D/RD1yY9dvXqP9qPU8reXSi
	AFx1dfKfcx7FJ/ZDKzBWZdx9pHoWDajwIEoqfPuTjK/XSWNo0s4tA6Zps6fTwPwN
	HJi1IB8AQHMI3f9TYnJ/vBDx+zeaULSvqS70HsVACdcDPmUZaxPm4LtZai9+c+mO
	mUyHAAQm2XV8yeReiEZezO0tG53mYSSDqqD7cT3zYOddRapvRyjgnPJfP6ko1wtQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88nfcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:59:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LBs98c021038;
	Thu, 21 May 2026 11:59:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhutss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:59:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LBwwTc47644994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 11:58:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DB5920043;
	Thu, 21 May 2026 11:58:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4270C20040;
	Thu, 21 May 2026 11:58:58 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 11:58:58 +0000 (GMT)
Message-ID: <d11481c2-201a-4a02-b9e0-80af52ce061d@linux.ibm.com>
Date: Thu, 21 May 2026 13:58:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 16/20] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260520154004.3845823-17-jremus@linux.ibm.com>
 <20260520170420.335441F00894@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520170420.335441F00894@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EP2FJ1NwsaXIrII2a50CXL4b4finnB9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExNiBTYWx0ZWRfX81SKShdQ4aqs
 sm33WYocDv85E8+YaDtb5X/yKLQ5JeTJE4tDugdcCnP67PXLxFgL4mO9ZMOjXEkZvaG1rpKFiGh
 rlW1lQHnnQbJM03IL0DguFU2K+mt8ZsqtouRxYGjPtqUiEUq5l+RW19PCqh/O84N20T3UJhWv4Z
 T5ePLy7Z6oq0O4w2N9dnVnPIy3wfcT0QtV9bBLXsx9KPwsnHGsKtaXKyhpn9BY2X4q69s8+Vc35
 6pVJJu/gi8n4OO5TdaO5zyLds+2M0BaTx01cRbS4u58Djjyn/qc+SBSyqNcynVzcUO4WFTUjSXr
 bctXL57Zwyn1/8UVlyvfvqU3gJs1EqOUWI1G3isRzOxu1EEV/v56kOpEXrBUiqtcxze/QTyqXd/
 IjJmcMZeuc/NTI6bkJA4GlQm0DM8+zzUUOZJ8bDqDt2lXYKFCElKsWwnz13SH2HDHj0rQx2BMio
 2oQmQ19wIfAXTcVjpSA==
X-Proofpoint-GUID: Ag4nZrPvk01RNSS70-HHND7aTNKgGJLb
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0ef385 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=njC-hnyFwTIKUP6h0CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210116

On 5/20/2026 7:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The patch references undefined macros `SFRAME_REG_SP` and `SFRAME_REG_FP` and includes a nonexistent architecture-specific header `<asm/unwind_user_sframe.h>`, resulting in a build failure.
> - [Low] The variable `ret` is used outside of its declared scope in `__find_fre()`, resulting in a compilation error.
> --
> 
> commit 725751526853387385ad4dffd9fdbe24d42e98d3
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user/sframe: Add support for SFrame V3 flexible FDEs
> 
> SFrame V3 introduces flexible FDEs in addition to the regular FDEs.
> The key difference is that flexible FDEs encode the CFA, RA, and FP
> tracking information using two FRE data words, a control word and an
> offset, or a single padding data word of zero.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 6187379750db5..48709f0bafc78 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/string_helpers.h>
>>  #include <linux/sframe.h>
>> +#include <asm/unwind_user_sframe.h>
> 
> [Severity: Low]
> Does this new architecture-specific header exist in the tree at this point?
> 
> It appears this include, along with macros like SFRAME_REG_SP and
> SFRAME_REG_FP used later in the patch, causes a build failure because they
> aren't introduced until a later commit (bfea14fc9b480 "unwind_user/sframe/x86:
> Enable sframe unwinding on x86").
> 
> Each patch in a series should be self-contained and compile successfully on
> its own.

This is intended.  kernel/unwind/sframe.o is only built if an arch
enables HAVE_UNWIND_USER_SFRAME and provides an arch-specific
asm/unwind_user_sframe.h header that defines at least SFRAME_REG_SP and
SFRAME_REG_FP.

> 
> [ ... ]
> 
>> @@ -356,9 +528,15 @@ static __always_inline int __find_fre(struct sframe_section *sec,
>>  		return -EINVAL;
>>  	fre = prev_fre;
>>  
>> -	sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off);
>> -	sframe_init_rule_data(&frame->ra, fre->ra_off);
>> -	sframe_init_rule_data(&frame->fp, fre->fp_off);
>> +	ret = sframe_init_cfa_rule_data(&frame->cfa, fre->cfa_ctl, fre->cfa_off);
>         ^^^
> 
> [Severity: Low]
> Is the variable ret in scope here?
> 
> It looks like int ret is declared inside the for loop in __find_fre(), so
> accessing it outside the loop results in a compilation error.
> 
> This is fixed in a later commit (9c045164b82cb "unwind_user/sframe: Separate
> reading of FRE from reading of FRE data words") which moves the declaration to
> the function scope, but it breaks the build on this commit.

Will fix in next version.

> 
>> +	if (ret)
>> +		return ret;
>> +	ret = sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off);
>> +	if (ret)
>> +		return ret;
>> +	ret = sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);
>> +	if (ret)
>> +		return ret;
>>  	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
>>  
>>  	return 0;
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

