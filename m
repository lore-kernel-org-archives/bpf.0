Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E031A06C;
	Wed,  6 May 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075455; cv=none; b=bbs3Ely8BL2+rVz8vqHhlOTChtlF0pDQE7pLuzIxJN8iauJLodMd5+8V7fBO4Zc7RYFE1VkzWgSC7Oc68vEmmlq8EEKncKMT6L2myLVuYC6sE4OoisL8fu88QLTsfRCsdpj05xkJJL21d/8NoVnCSUN1O6u16RBgKiksutskm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075455; c=relaxed/simple;
	bh=kya7CyX8B6k7kt0FGrLt9IE5yhQNaHdb1KkUjt4FzaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXTciBLASg5AZhXLZsLZEW1gQbTS3+BGME4GwNtC68fkD66xMq81x4wGsLjJM+hZXtsTJSggDGnICouZ3rZek4LtmOIDsNdlrfkfQ7x80GagnD2/fKJoPSLUkFuoEkQmz4ft5R3+DTbXDMwjCIeM2et8yEZV4eULHRig+fxz1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKmpZdIX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKmpZdIX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64695Gc62062528;
	Wed, 6 May 2026 13:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=poL33O
	/KFoBdMk8AOsrcc6ZNOxiRBALDMQ087Zyzt8A=; b=BKmpZdIXglTT7kSbwdL3NP
	JPtayUaUyxLTVZsM7WUfqVBiP/76KueEcWIt0XiwcQ8nT2wI1vxow2ZfqFa57FgF
	tYFdLVvn3Q/kfyl1r4T3nvX68M9ZbieezE3Szi3om6bDQTfBSK4LkosHD4FrcagL
	hxV2J3lcC/ZmeVeXiH2cDpdd0mPuFjFMQ6x5+rs99bKQt/LcA/68I7WvXaWrKlaK
	skb3HXljfl42uSN7UcgL1wMbNqaYEI4gP7AT1aSZ+hffhHSiRW27S7ua/Y2qh18n
	2VGqQqVJ7uYRAlnZhyp6/r65fZAiVuEuod26hA81pEKi07zUOV0edC0ererfp8Qw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6g9p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:50:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DdSIQ007540;
	Wed, 6 May 2026 13:50:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtge92y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:50:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646DokoQ33751366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 13:50:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 075262004B;
	Wed,  6 May 2026 13:50:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D08BD20043;
	Wed,  6 May 2026 13:50:45 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 13:50:45 +0000 (GMT)
Message-ID: <49318ed5-8668-43fe-880d-b91bd7c3a7a9@linux.ibm.com>
Date: Wed, 6 May 2026 15:50:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] unwind_user/sframe: Store .sframe section data
 in per-mm maple tree
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-4-jremus@linux.ibm.com>
 <20260505185158.39F35C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505185158.39F35C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb4738 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=5z3OOvnrkLlYczDheucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: roZ7ef1M_X0YI0fTxpiO0nwq4ZmX19jq
X-Proofpoint-GUID: 5jirEh7eZEeFEczUQqsqK35rYfITND4P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNCBTYWx0ZWRfX6yz1ebBC9c1t
 PtV5YpiPx8aAWY32PO7TdNq58E85bdSO7yKK3X/tNzv6rPjO4obuusE4oerDfdAHlLDSytOzPuE
 LjhjSsCog7hzF6Jd+gCP6akrM9VY6imwPFABpC/3fz9fVON4h21mSzB1NNaAlP9CYatO9KzRoo5
 Kr+cqewBZ/s0bNrGWxAKlpXqZwBGg20bRNLYLphGysA45CrSZwmzs7Pcx54JiQ45BrcgUmjOLmo
 7xlCZ/zQle/oa+MUejS4gwVK3b+Ke8OjV0FX7N8FY2wZJeajS0amXShPKA1ACKN3DL8ho3y/5qE
 TlAvmtMK7WjQGwEfAH2Taq2RyPmotkCYIxlt2E5fJKJPcN3xzyLZrdwZBhh00wCzi6cnz/AJyOA
 ijClHvdqqtOuKnDRvngSsZi+b6ZfOaijfJpERrzvfu9ZGJU3hy9bQOzvjoDrB+jdZo1kngj44at
 625N/VE+ukBdpYjHGag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060134

On 5/5/2026 8:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [Critical] Concurrency Use-After-Free and Double Free in sframe_remove_section
> - [High] Unbounded memory leak of sframe_section allocations leading to Denial of Service (OOM)
> - [High] Missing MT_FLAGS_USE_RCU initialization breaks lockless NMI unwinding
> - [Medium] Child processes silently lose .sframe unwind data on fork()
> - [Medium] Inclusive bound semantics in maple tree cause 1-byte overlap rejections for contiguous sections
> - [Low] Zero-address validation falsely rejects valid memory mappings
> --
> 
> commit 3b41045a6b38a262cb32acf9ed118e4d667448dd
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Store .sframe section data in per-mm maple tree
> 
> Associate an .sframe section with its mm by adding it to a per-mm maple
> tree which is indexed by the corresponding text address range. A single
> .sframe section can be associated with multiple text ranges.
> 
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index f1ad69c6dc2d4..0d92fb1c61a99 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
> [ ... ]
>> @@ -1072,6 +1074,13 @@ static void mmap_init_lock(struct mm_struct *mm)
>>  #endif
>>  }
>>  
>> +static void mm_init_sframe(struct mm_struct *mm)
>> +{
>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>> +	mt_init(&mm->sframe_mt);
>> +#endif
>> +}
>> +
>>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
> 
> mt_init() initializes the maple tree with flags set to 0. Since stack
> unwinding typically occurs in profiling interrupts (NMIs) which must
> traverse the maple tree locklessly via RCU, does this missing
> MT_FLAGS_USE_RCU flag allow concurrent modifications to perform in-place
> updates instead of RCU-safe copy-on-write allocations? This could result in
> the NMI unwinder observing corrupted tree states.

Please advise.

> [ ... ]
>> @@ -1100,6 +1109,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>  	mm->pmd_huge_pte = NULL;
>>  #endif
>>  	mm_init_uprobes_state(mm);
>> +	mm_init_sframe(mm);
>>  	hugetlb_count_init(mm);
>>  
>>  	mm_flags_clear_all(mm);
> 
> When a process forks, this initializes an empty sframe_mt for the child's
> mm_struct. While dup_mmap() duplicates the parent's VMAs, it doesn't appear
> that the registered .sframe entries are propagated to the child's maple tree.
> Will child processes silently lose their .sframe unwind data for shared
> libraries registered prior to the fork?

Does this ring any bell, Steven?  I ran into it with my signal frame
stacktracing test on s390.  I think we discussed this during one of the
SFrame calls and it got lost.  

>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index c128c1eeaca20..fdb2a49085638 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> [ ... ]
>> @@ -81,6 +81,7 @@ static int sframe_read_header(struct sframe_section *sec)
>>  int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>>  		       unsigned long text_start, unsigned long text_end)
>>  {
>> +	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
>>  	struct vm_area_struct *sframe_vma, *text_vma;
>>  	struct mm_struct *mm = current->mm;
>>  	struct sframe_section *sec;
>> @@ -88,10 +89,12 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>>  	if (!sframe_start || !sframe_end || !text_start || !text_end) {
> 
> Virtual addresses can legitimately be zero, such as when mmap_min_addr
> permits it. Does checking !text_start falsely reject valid zero-address
> VMAs? Checking the range bounds explicitly might be safer here.

Addressed in previous patch.

> [ ... ]
>>  		}
>>  	}
>>  
>>  	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
> 
> This allocates the section with GFP_KERNEL instead of GFP_KERNEL_ACCOUNT,
> which bypasses memory cgroup limits.
> 
> Furthermore, is there a mechanism to clean up these allocated sections when
> the corresponding VMA is torn down (e.g., via munmap)? Without cleanup hooks
> in the VMA teardown paths, it looks like an application could repeatedly mmap
> an executable region, register it here, and munmap it, leaking kernel memory
> and maple tree nodes indefinitely.

Isn't that taken care of by the change in __mmdrop() to call
sframe_free_mm(mm), which is part of this patch?

> [ ... ]
>> -	/* TODO nowhere to store it yet - just free it and return an error */
>> -	ret = -ENOSYS;
>> +	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);

	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - 1,
				 sec, GFP_KERNEL);

> The Maple Tree API stores ranges inclusively as [first, last]. Since VMA
> boundaries are exclusive, does passing sec->text_end directly cause the
> maple tree range to incorrectly cover one extra byte?
> 
> If an application registers two perfectly contiguous .sframe sections, the
> insertion of the second section could fail with -EEXIST because the first
> section erroneously claims the first byte of the second section. Using
> sec->text_end - 1 might prevent this overlap.
> 
>> +	if (ret) {
>> +		dbg("mtree_insert_range failed: text=%lx-%lx\n",
>> +		    sec->text_start, sec->text_end);
>> +		goto err_free;
>> +	}
>> +
>> +	return 0;
>>  
>>  err_free:
>>  	free_section(sec);
>>  	return ret;
>>  }
>>  
>> +static int __sframe_remove_section(struct mm_struct *mm,
>> +				   struct sframe_section *sec)
>> +{
>> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
>> +		return -EINVAL;
>> +	}
>> +
>> +	free_section(sec);
>> +
>> +	return 0;
>> +}
>> +
>>  int sframe_remove_section(unsigned long sframe_start)
>>  {
>> -	return -ENOSYS;
>> +	struct mm_struct *mm = current->mm;
>> +	struct sframe_section *sec;
>> +	unsigned long index = 0;
>> +	bool found = false;
>> +	int ret = 0;
>> +
>> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
>> +		if (sec->sframe_start == sframe_start) {
> 
> Can concurrent calls to sframe_remove_section() cause a use-after-free and
> subsequent double free?
> 
> mt_for_each() locklessly iterates mm->sframe_mt, and internally acquires and
> drops the RCU read lock, meaning the returned sec pointer has no lifetime
> protection in the loop body.
> 
> If two threads concurrently invoke sframe_remove_section(), both could
> receive the exact same sec pointer from the tree. Thread A could then call
> __sframe_remove_section(), erasing the entry and freeing sec via
> free_section(). Thread B would then evaluate the if statement using the
> freed sec pointer, causing a use-after-free read, and potentially proceeding
> to free it again.

Please advise.

> Additionally, does free_section() need to use kfree_rcu() instead of
> kfree() to prevent lockless NMI unwinders from hitting a use-after-free
> when reading payloads?

Please advise.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

