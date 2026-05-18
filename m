Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA23D330A;
	Mon, 18 May 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118058; cv=none; b=MjmsViRf4ud5jSOAWilMM+Y13tco+zz0DrcHKfVBB386CxwF3EYDUqWb0k8ckf24OUJqi9Go/f9LKknbYwuVfix8g20ge8EIN8R/yr4FO8qC4Ou0KSMR7DOrE3iXVOtnSWkkAdstM8svgD+5rAwZlkJlETz9Hajd0l8m/y49osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118058; c=relaxed/simple;
	bh=CoZ4OOlj3atO/jDDe3rEaR/U+AGNSFv4RlK+yLIqobk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSmhWmYcrkbhZ4GRbQFe7PaY/fXUChapo9xv/3CkIH977SFRw49q2n9RqYnTc2bYJt/HZcrNSWl31eSYQkFs2Ss2rzTzvT92EZtV7BuQCY9iRT5JZsA266MtLk4gzxjkbD2MNDGgF3txvk9cSd3nKmdWYzZGfi1azWLruuCZQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJNUoPVO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJNUoPVO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IA9MRC764296;
	Mon, 18 May 2026 15:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Glt+wl
	oTEbCFlNWSX3AiHmju9bQhUQD5rjwlokmcWWs=; b=TJNUoPVOEvAR8upiEqHFxe
	Qt/Sk2nKXpFRiOBEkaBg83+oOYI1MsDu2zYLFclYXf+MciXKiuKg8nnIKDZHoQoz
	ki3Pr6lltKQILuddwZWplkyUsJaMadwWXlXX4bBvsIEUG4958bN/7OPSnub0eWLG
	LTAxpDXedQ+beXDIpivf79vDhwjgLp4d54EGr84quy1VfSI8vPAGpoC0qJ9D3kSb
	mmBpnfYiqkhpxPKILgbZbdreVm/wHCfz3xsYkhypM7n8LtwWWlzvSd7aQ38Yqawi
	lzdJoHA95oJPNYkl0qBIE1rTgrSphK3iOGpBBKkm7KOgT04YHEKSGpDeKFD4bqzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw0975-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:27:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IFO7uf007277;
	Mon, 18 May 2026 15:27:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxx7gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:27:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IFRShl48627978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:27:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A8D820040;
	Mon, 18 May 2026 15:27:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18CA920043;
	Mon, 18 May 2026 15:27:27 +0000 (GMT)
Received: from [9.111.207.149] (unknown [9.111.207.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 15:27:26 +0000 (GMT)
Message-ID: <335cd391-2cca-4351-a388-44b1912d5785@linux.ibm.com>
Date: Mon, 18 May 2026 17:27:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/19] unwind_user/sframe: Show file name in debug
 output
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-12-jremus@linux.ibm.com>
 <20260505184638.5648DC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505184638.5648DC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0OCBTYWx0ZWRfX/RduooLue5j/
 eJ04L7pUvHFODcnbZBVWntD9uTdsNSn3w4Nt5/H3knl/rstN02AQbmII7KEPOhndLILbIEAaxFO
 4YFQzYehDTwDDxwsp+DAilAJ7+KGqUMStDwOFRvZrHUeBEZHVGREXp3HghoW7osQvODm/4iGPY3
 Nuzheq0CsYjo8mvByL7yOUlN/mFr/pNuYIxEsY1SUNYwUZK5SWtQtmlHt/XV4Uj5bjUkQ5v6ksp
 hduEiI/VsamyKPcalb4YMuQBvT3+aIyLZAAep+RCnOY87N6DSWDS6EWbDS1OHPgL9eQXOWFA3mi
 PLr4OxhS42w5XK233RnK3CP9gUTVIOmLEViU2l7z2k/8gWBKPmMxy35te9WJnAA/NPzxEeJiQNo
 31IJuIK1r+sqjjmOnEeCJo1cmaudE4n6Otw0ecbclhHSz+oJtJFVdsk7d6CmvYVy4LjtYM6TCfZ
 jOcwEgzEuuV7iuMXphg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0b2fe3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NA_8uTBmqVKMXtmOv3I5ZeXpkXhixvLw
X-Proofpoint-GUID: AHCJuiNS4c-Xw4SktRTFPON1odIy71J6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180148

On 5/5/2026 8:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:

> - [High] Unbounded kernel memory allocations controlled by user space do not use `__GFP_ACCOUNT`, allowing memory cgroup limit bypass.

> --
> 
> commit d6a437647b4507fcb6d70115c0d08b1d68cafa8a
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Show file name in debug output
> 
> This commit adds the file name to debug output messages for sframe sections
> to make debugging easier. It records the filename when the section is added
> by inspecting the associated VMA.

>> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h

>> +static inline void dbg_init(struct sframe_section *sec)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma;
>> +
>> +	guard(mmap_read_lock)(mm);
>> +	vma = vma_lookup(mm, sec->sframe_start);
>> +	if (!vma)
>> +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
>> +	else if (vma->vm_file)
>> +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);

> Do these string allocations need __GFP_ACCOUNT? Since they are triggered by
> user space and persist until the section is removed, could a user allocate
> large amounts of uncharged memory and bypass memory cgroup limits?
> 
>> +	else if (vma->vm_ops && vma->vm_ops->name)
>> +		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL);

>> +	else if (arch_vma_name(vma))
>> +		sec->filename = kstrdup(arch_vma_name(vma), GFP_KERNEL);
>> +	else if (!vma->vm_mm)
>> +		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
>> +	else
>> +		sec->filename = kstrdup("(anonymous)", GFP_KERNEL);
>> +}
> 

Documentation/core-api/memory-allocation.rst states:

* Untrusted allocations triggered from userspace should be a subject
  of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
  is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
  allocations that should be accounted.

Use GFP_KERNEL_ACCOUNT instead of GFP_KERNEL.  See my related reply to
"[PATCH v14 03/19] unwind_user/sframe: Store .sframe section data in
per-mm maple tree" for further details.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

