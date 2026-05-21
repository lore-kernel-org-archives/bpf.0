Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535873783AA;
	Thu, 21 May 2026 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356414; cv=none; b=doaSVyHqgIxZn+KuZJ0f0oC1bq6EGYfhFzGYzdgi+Rc28A+f279CurWfRfRy1ONnsFDMipfae+IySxdffPcQrtw7AzqqG7hbmanZnPcdKW4/Yr1JZUI8o9m68h7t0R6uEs0xHbFPk6kV8jagNCdWIrMyonQenp2eI8ICZGTyst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356414; c=relaxed/simple;
	bh=XwFOYjid+p4rAmVEIj3LMOGGAQRysx1kgot4A3Qxp34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=socS85gSOmEhcxN8sbgw20ccjjjL8rTJUa9mpHeWj8x3SKWAvcNOdp2tj9W6RNrMC8AmHx4WVD26PTlbfERRfcv47ohJK2IJ5sHLwfMkdDPqxG+2bOTdtYavoUFA6PxN4WunsVwqkPUu1w75K3UgeurN9sl9YIGJqb6tdlCLK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRpOa8kO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRpOa8kO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1HppF3935189;
	Thu, 21 May 2026 09:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3RhtfJ
	/o0OCJTI4zRmSUxOfORPP4+Y0vOxtAvzn6oOM=; b=nRpOa8kOKYouUncHiq9N83
	RpR7j9em8R5stKkl34GLyHUtg0jlDt7KStsNN7LK0huLl+Qt4vskQsLHJUwzd/Gf
	QhIT4f9XASnBTvRAa0JGJ0PdukXjPIXqwMPJyjmItaFgJAAvsrBFjBvHnK4TY8lP
	+niikH/R8RdMj9jsNDKIUHdIu3lWb8odsJkuGx1JkrtqsLLlsbDp9hopIfc7NrSG
	KTOQxZThgfg6XwffPaZZf/U6bNDuiiqZJk84hW/8C9iOkM0o10LVF1LZLM8VJf5R
	C6TiZ1X7QHkFNNb7Qc077WsxI/qymDSCX4iQx/GuJC0VBn8PosPMF8leUQ1XaGIQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y68c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:40:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L9d7sE020959;
	Thu, 21 May 2026 09:40:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkbe6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:40:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L9e4ol61342120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:40:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB5B620043;
	Thu, 21 May 2026 09:40:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 870D620040;
	Thu, 21 May 2026 09:40:04 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 09:40:04 +0000 (GMT)
Message-ID: <c3dee21e-1b37-46eb-91fd-828557f6dc8b@linux.ibm.com>
Date: Thu, 21 May 2026 11:40:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/20] unwind_user/sframe: Add support for reading
 .sframe contents
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260520154004.3845823-6-jremus@linux.ibm.com>
 <20260520163348.11FD21F00893@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520163348.11FD21F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5NSBTYWx0ZWRfX7+97ak2/cEyi
 x8cNyt7X0WtvAPLZSIEJr2H402J7Gr+u2N0SS32OPfD1B2+rdXQokYXONuGTrlC87X+LPku/7nQ
 jkAN6eB9mz7U0gPWVO+VTzTisPVvDkXD8kkPCGsVgRhMOB8krcyldB7gFIh4JYr37C5Advb5ZSS
 PC/v4eb2aDHPeblLLKF8nHMgfN2GBTbEYJ/BlTO5BSnngfstQ6YMrG38j37xdK2VuvsAIkmejpw
 vpjuZAumIqre92gJXhN47IapHhKu1MDD2MNG4PcVm0dqtwMLcxKltWbtIJ2xW32MPdKdOvXtZOb
 TGr/FiIlIDE8hTy8CULr9BF5XYXJ5LAH/CMXwd9O35B+jwlZ46ZuiAi6oTbnHX74RKd1rMFN1pF
 jAa9N1J+WdevbSQ3Ajm3+aK3OfbVmXC5zhcJuogX7mcSAzQij9nbi/KySWu2kJyfkkj6ttf7QeA
 8G7zsBENvd0OZmtz+4A==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ed2f9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=f8iy6pEWjRDl6Rsn33oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UEocYtCrjg9Opm3Ve-e968CylSPGxrpy
X-Proofpoint-GUID: 3E3vlqiN9lasgm9hDTem1RJU5tjaw_PB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210095

On 5/20/2026 6:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Incorrect FRE size calculation due to using a mutated `dataword_count`.
> - [High] Binary search incorrectly reads 64 bits for a 32-bit PC-relative offset, corrupting the function address calculation.
> - [High] Unbounded linear scan of user-controlled SFrame FREs can cause a kernel hard lockup.
> - [High] Usage of `guard(srcu)` invokes `srcu_read_lock()`, which is not NMI-safe and can corrupt the SRCU lock counter.
> - [Medium] Mixing goto-based error handling with scope-based `guard()` cleanup.
> --
> 
> commit 12c453957aeaea0a5733d7ed09d97cf7dfd380a5
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Add support for reading .sframe contents
> 
> In preparation for using sframe to unwind user space stacks, add an
> sframe_find() interface for finding the sframe information associated
> with a given text address.
> 
> Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
> Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 6b3ce3f8966d0..a38f50a363633 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> 
> [ ... ]
> 
>> @@ -15,9 +15,350 @@
> [ ... ]
>> +static __always_inline int __find_fde(struct sframe_section *sec,
>> +				      unsigned long ip,
>> +				      struct sframe_fde_internal *fde)
>> +{
> [ ... ]
>> +	while (low <= high) {
>> +		struct sframe_fde_v3 __user *mid;
>> +		s64 func_off;
>> +		unsigned long func_addr;
>> +
>> +		mid = low + ((high - low) / 2);
>> +
>> +		unsafe_get_user(func_off, (s64 __user *)mid, Efault);
> 
> [Severity: High]
> Does this read 64 bits for a 32-bit PC-relative offset? Since SFrame V3
> specifies a 32-bit signed integer for the PC-relative offset followed by
> a 32-bit function size, won't reading 8 bytes merge both fields into
> func_off and corrupt the function address calculation?

Ignore.  Sashiko AI is hallucinating that the SFrame FDE function start
offset would be signed 32-bit in SFrame V3, as it had been in SFrame V2.
With SFrame V3 it is always signed 64-bit.

> 
>> +		func_addr = (unsigned long)mid + func_off;
> 
> [ ... ]
> 
>> +static __always_inline int __read_fre(struct sframe_section *sec,
>> +				      struct sframe_fde_internal *fde,
>> +				      unsigned long fre_addr,
>> +				      struct sframe_fre_internal *fre)
>> +{
> [ ... ]
>> +	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
>> +	dataword_count--;
>> +
>> +	ra_off = sec->ra_off;
>> +	if (!ra_off) {
>> +		if (!dataword_count--)
>> +			return -EINVAL;
>> +
>> +		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
>> +	}
>> +
>> +	fp_off = sec->fp_off;
>> +	if (!fp_off && dataword_count) {
>> +		dataword_count--;
>> +		UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
>> +	}
>> +
>> +	if (dataword_count)
>> +		return -EINVAL;
>> +
>> +	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
> 
> [Severity: High]
> Is the FRE size calculation correct here? Since dataword_count is decremented
> as datawords are read, and the previous line ensures it is exactly 0, doesn't
> this entirely omit the size of the read datawords from the total FRE size?
> When __find_fre() advances to the next FRE, this might cause it to point to
> the middle of the current FRE's datawords and read garbage.

Valid, but resolved by subsequent "[PATCH v15 16/20] unwind_user/sframe:
Add support for SFrame V3 flexible FDEs".  Will nevertheless fix in next
version.

> 
>> +	fre->ip_off	= ip_off;
> 
> [ ... ]
> 
>> +static __always_inline int __find_fre(struct sframe_section *sec,
>> +				      struct sframe_fde_internal *fde,
>> +				      unsigned long ip,
>> +				      struct unwind_user_frame *frame)
>> +{
> [ ... ]
>> +	fre_addr = sec->fres_start + fde->fres_off;
>> +
>> +	for (i = 0; i < fde->fres_num; i++) {
>> +		int ret;
> 
> [Severity: High]
> Could this loop cause a kernel hard lockup? fde->fres_num is read from user
> space and can be large. Since this performs a linear scan reading each FRE
> sequentially from user memory, and unwinding often runs in NMI context (like
> perf PMU interrupts), could a maliciously large SFrame section force the
> kernel to loop without yielding and trigger the NMI watchdog?

Ignore.  Stacktracing using SFrame is only performed deferred and thus
not in NMI context.

> 
>> +
>> +		/*
>> +		 * Alternate between the two fre_addr[] entries for 'fre' and
>> +		 * 'prev_fre'.
>> +		 */
> 
> [ ... ]
> 
>> +int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct sframe_section *sec;
>> +	struct sframe_fde_internal fde;
>> +	int ret;
>> +
>> +	if (!mm)
>> +		return -EINVAL;
>> +
>> +	guard(srcu)(&sframe_srcu);
> 
> [Severity: High]
> Is this safe to use from NMI context? Stack unwinding is frequently invoked
> from NMIs (like perf PMU interrupts), but srcu_read_lock() is not NMI-safe
> on all architectures (like arm64, where the non-atomic read-modify-write
> could corrupt the SRCU lock counter). Should this use srcu_read_lock_nmisafe()
> or standard RCU instead?

Ignore.  See above.

> 
> [Severity: Medium]
> Does this mix goto-based error handling with scope-based cleanup? The
> function declares a scope-based guard here, but uses a goto-based cleanup
> label (end:) below. This goes against the cleanup subsystem guidelines
> which recommend either converting all resources to scope-based cleanup or
> none at all, to avoid confusing ownership semantics.

The scope-based cleanup is used to guard the read-access to the struct
sframe_section.  The goto-based error handling is used to guard the
user read access.

> 
>> +
>> +	sec = mtree_load(&mm->sframe_mt, ip);
>> +	if (!sec)
>> +		return -ENOENT;
>> +
>> +	if (!user_read_access_begin((void __user *)sec->sframe_start,
>> +				    sec->sframe_end - sec->sframe_start))
>> +		return -EFAULT;
>> +
>> +	ret = __find_fde(sec, ip, &fde);
>> +	if (ret)
>> +		goto end;
>> +
>> +	ret = __find_fre(sec, &fde, ip, frame);
>> +end:
>> +	user_read_access_end();
>> +	return ret;
>> +}

Will convert to scoped_user_read_access_size() as follows:

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
@@ -348,18 +348,18 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
        if (!sec)
                return -ENOENT;

-       if (!user_read_access_begin((void __user *)sec->sframe_start,
-                                   sec->sframe_end - sec->sframe_start))
-               return -EFAULT;
-
-       ret = __find_fde(sec, ip, &fde);
-       if (ret)
-               goto end;
+       scoped_user_read_access_size((void __user *)sec->sframe_start,
+                                    sec->sframe_end - sec->sframe_start,
+                                    Efault) {
+               ret = __find_fde(sec, ip, &fde);
+               if (!ret)
+                       ret = __find_fre(sec, &fde, ip, frame);
+       }

-       ret = __find_fre(sec, &fde, ip, frame);
-end:
-       user_read_access_end();
        return ret;
+
+Efault:
+       return Efault;
 }

 static void free_section(struct sframe_section *sec)

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

