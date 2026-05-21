Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1F36F8F3;
	Thu, 21 May 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365168; cv=none; b=lW6Pa/tF3kYaNXeRgHBxRm0LYudGz4AUr3/tuXuzXoIlOG74SAdCOkS7wFoZbfa2UI4YSLJPmLkwtWU5huFAEokjk6cSgJ/CXNxMQQUl6LFaqwHaZIabmq6vjXixhvhPD4gmKL0PV4F1Hj+jFVcEuctGP4x6YU0zNMEd3nbqpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365168; c=relaxed/simple;
	bh=o3UeE0B1gQsdaujAM6JHX3XjO0D2yR+ppFJvBvhj2wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9DGrwcNb4jjevNVbE37DJMWSt0OxtdI9rQE9bH/Pev8FlXGCYrmV7HRaz/vq48Pl3gQUcyxIzaVBaN19KzqwkLQ6ntCTBqlMNHh7XQVTsBI/Z8uRtL0QwIz/xthrQQgVaqAE5DG1mukYOTPsnayTVezYApY0P/btGMgg8sxmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aEhWrGvU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aEhWrGvU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L67aSf441640;
	Thu, 21 May 2026 12:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YGlv5i
	A8YcXVb4xuyVsf4pRMy3TV3Cu0ZNMWpvskLcM=; b=aEhWrGvUDctqj4qiYnwos5
	0L2dWutds6Cd3Kejy7YVJqKDTw75Zkh6aTrzmgSIIVZJ9ymElFnhTlxIy6yONp0o
	IRBvYYptwZwWabJIBwJrHewb6+7KrpXITPNxxKSFSY3lZ2whMhywQJgDVLSQU1nr
	cxXKqER+npJxR0NlwZ7qRfMaPRwgFg5rAJjKDads0S7aGoon0TJ/x931aUFNzOiy
	0GXy8VGrQV9N9IucBzxAepFJ7NklysBwBX5UyTvcpisnEFYUcygRipVt7ThDrFUO
	r2KhKryIGyo7YBixDlcwxZPACG7dvGxnBmEDcue15i44SuTqfHTlnNIrMV/rg8ZQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8nfvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:06:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LBs6I3021027;
	Thu, 21 May 2026 12:06:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhuv5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:06:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LC61r547382788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 12:06:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 717432004B;
	Thu, 21 May 2026 12:06:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 501A620043;
	Thu, 21 May 2026 12:06:01 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 12:06:01 +0000 (GMT)
Message-ID: <f746df8e-0fb7-4e0b-be46-2fa9c1e21a04@linux.ibm.com>
Date: Thu, 21 May 2026 14:05:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 18/20] unwind_user/sframe: Duplicate registered
 .sframe section data on clone/fork
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260520154004.3845823-19-jremus@linux.ibm.com>
 <20260520170112.A8AA41F00893@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520170112.A8AA41F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMSBTYWx0ZWRfX9Dh0nif3dal0
 aQrl+QVIABSem0B68jYUv/tNQP1N2fTRlQtJvCZT4zCgrcC7YC76jWNnigXhCcXHoUvSoysDvnl
 HR6tSX9vnieVfAwb4SUbjOyrnsswJxO8pfsON7yMZj7PgDEQyJJXMcGAr5iAGJMOXC9GLkEqkWd
 nbj5CKAkRBSCTbt0uC24Y4BFosXmMB16rH03QBXVkgbhTaNEXD8Z2LBi7vdOEu065dM/mWAuMEs
 jxyeFO+cXrVKa0WEH0goLY0OlmiLSxrphtYiyvpBoeYRB7jbnQd40Sut5bhXFBpE+nn5C7TBgT3
 rZBhyfIt84z7CQEtHta1WBWNHs3CXDe6TqBGCWou/fM3DUYhCTlcBYtkZvHp415TI5hTseR/gqQ
 PWhsKJoI/AHC8siX6KCNTkG4cb7oaijmg5YN8zM28V0e0SLM4AeO1PqeU6IMczB+LGiJGKn+ObI
 gzYDJxr7LWG/xW7dJ8w==
X-Proofpoint-GUID: iLkTU3lhzcFHpEiSiRuE-QTg1cDx_H9s
X-Proofpoint-ORIG-GUID: rNSJJtBAR-bJt7rr0sXvuVFcYJJVXuVA
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ef52c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ijAAiHPv0kBOpVhWHt0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210121

On 5/20/2026 7:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Mixing goto-based error handling with guard() scope-based cleanup in sframe_dup_mm().
> - [Low] Redundant #ifdef blocks around sframe functions in dup_mmap().
> --
> 
> commit 06e12a491c0dc4cc93fac24f7de9fe0b02b9a9e0
> Author: Jens Remus <jremus@linux.ibm.com>
> Subject: unwind_user/sframe: Duplicate registered .sframe section data on clone/fork
> 
> When duplicating a process' virtual memory mappings also duplicate all
> of its registered .sframe sections stored in the per-mm maple tree to
> enable stacktracing using sframe of the child process.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index ec8318977a2ef..0661090dd5bcd 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> [ ... ]
>> @@ -886,6 +886,54 @@ int sframe_remove_section(unsigned long sframe_start)
> [ ... ]
>> +int sframe_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
>> +{
>> +	struct sframe_section *sec, *oldsec;
>> +	unsigned long index = 0;
>> +	int ret;
>> +
>> +	guard(srcu)(&sframe_srcu);
>> +
>> +	mt_for_each(&oldmm->sframe_mt, oldsec, index, ULONG_MAX) {
>> +		sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
>> +		if (!sec)
>> +			return -ENOMEM;
>> +
>> +		__sframe_dup_section(sec, oldsec);
>> +
>> +		ret = mtree_insert_range(&mm->sframe_mt,
>> +					 sec->text_start,
>> +					 sec->text_end - 1,
>> +					 sec, GFP_KERNEL_ACCOUNT);
>> +		if (ret)
>> +			goto err_free;
> 
> [Severity: Medium]
> Is it intentional to mix goto-based error handling with scope-based cleanup
> in the same function?
> 
> The cleanup subsystem guidelines recommend against mixing goto labels and
> guard declarations to prevent confusing ownership semantics and lifecycle
> bugs. Would it be better to drop the err_free label entirely and explicitly
> call free_section(sec) followed by returning ret directly inside this block?

No.  sec must not be unconditionally free'd if it got successfully
inserted into the maple tree.

> 
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	free_section(sec);
>> +	return ret;
>> +}
> [ ... ]
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 2311ae7c2ff45..d5aa8c54f8c1c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
> [ ... ]
>> @@ -1846,6 +1847,11 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>>  	}
>>  	/* a new mm has just been created */
>>  	retval = arch_dup_mmap(oldmm, mm);
>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>> +	if (!retval) {
>> +		retval = sframe_dup_mm(mm, oldmm);
>> +	}
>> +#endif

Will swap the order, so that arch_dup_mmap() is last.

> 
> [Severity: Low]
> This isn't a bug, but are these preprocessor guards necessary?
> 
> Since include/linux/sframe.h already provides static inline dummy versions
> of sframe_dup_mm() and sframe_free_mm() when CONFIG_HAVE_UNWIND_USER_SFRAME
> is disabled, these conditional blocks could potentially be removed to keep
> the C source code cleaner.

Valid.  Will drop the unnecessary #ifdef.

> 
>>  loop_out:
>>  	vma_iter_free(&vmi);
>>  	if (!retval) {
> [ ... ]
>> @@ -1893,6 +1899,9 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>>  			vm_unacct_memory(charge);
>>  		}
>>  		__mt_destroy(&mm->mm_mt);
>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>> +		sframe_free_mm(mm);
>> +#endif
> 
> [Severity: Low]
> This isn't a bug, but similarly, could this block be dropped since the dummy
> stub handles the disabled case without needing explicit conditionals?
> 
>>  		/*
>>  		 * The mm_struct is going to exit, but the locks will be dropped
>>  		 * first.  Set the mm_struct as unstable is advisable as it is
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

