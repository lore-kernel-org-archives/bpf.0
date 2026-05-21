Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E196379EFE;
	Thu, 21 May 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356392; cv=none; b=SccbVxnWhNzMT1MnIpI0Y/ASwSmt5juPSb6WqNzNxWdWi2YqfGvRhondMGkFX16KXU4lz77IwxOvDFPLrMpIrZjH2KxmRvqlBI3y58ALi5QphQya3z2uj/FDFMH/CxvjaGW7ilNeuSVmmjFgFijmTz63dA8oEiKWxOkLY7sMjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356392; c=relaxed/simple;
	bh=15A3VWWQXsGIYx8QmQbRs7H515mURE5odsjRfEydyxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRvpOygRtgU06+Y+neC77zhsQNEPxrU+7VTraJsIIDsM80NicRppsMxM3APX3yrNPUxsC7NJ84j22pPCEzJD0yhiRjYA7cnzhXT/MkOsx+LNOosMUuq3lrIuuk6ObgKTbOby1OmjMX3iK8zLwetVlbTFezALKv0wxyFk28L5lHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OsI4oKz8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OsI4oKz8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L5YUik220135;
	Thu, 21 May 2026 09:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ymCmBR
	MPL5uDMTJVIazU6HwkEwv/JxhGRxmChYRcOeE=; b=OsI4oKz8gxgqSztjdP0qI6
	OpIOyLGYZLbWFT4gvqFOxFj2Tvvv53YWaoE1D+itNLHCVbUgbBbIggenFVpIgPej
	fQMhwmg54owas4vf7QL0lNdIVhz0D+WQ3t0E3TQiqrZ+hEueGihp+Z/2ywlABxos
	1MrVZUZP0NXLMw4wdUV38dBPeHy8UOsgKiM0Cw2MzPDNruQhFSsAIvsBAAwLSwxW
	9GBtkD3QJH3gJ37/A+PPecldmO17sjb3HeTRQMvGHA7nDaQzk5EsykQ62HeM400A
	Tkk8yjnVkldh4KO6R4j03bfjwwlP8OWxtR+nBw8lPd/XzwyayADYgE4Fpr28meoQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y68aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:39:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L9dCeg007999;
	Thu, 21 May 2026 09:39:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhubvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:39:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L9djLm47972790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:39:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 657DB20043;
	Thu, 21 May 2026 09:39:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4735D20040;
	Thu, 21 May 2026 09:39:45 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 09:39:45 +0000 (GMT)
Message-ID: <cd3beb08-cc63-47bc-b877-9f43112ef51d@linux.ibm.com>
Date: Thu, 21 May 2026 11:39:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/20] unwind_user/sframe: Store .sframe section data
 in per-mm maple tree
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260520154004.3845823-4-jremus@linux.ibm.com>
 <20260520162914.13A0F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520162914.13A0F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5NSBTYWx0ZWRfX42IXDi+exWNH
 IDJFrrU7Ei336C0NBSMqkcKWeYs98e2d2NV2SbnA9ckR5Aa05XegtSSqctisbkPXtitq/swGucC
 A0gG3dekYrK+2qNwWJg5PrIVo3I92W3VylSRCHYNb/CJF3nee5JfWaL0J6wcvQY29v07K6n5BXa
 aGUBS+DFb72wLts85TTHe3RTf9Kv0vQ89F9gw3USfOVi2/XI/bhN228cvgd2OzJY/DO4jGx8+ny
 VtqT/HZPrcnSQXJKyPO6lmzKRAbNhtwc+cTdp2OTbgjoCg8+G+FTTssubbVrCnqVujjZLagw7+b
 6ZRQIr0kW3eLKsPals21lCg33HMtncll8tlgUpQ2qOkHaI3+i0sTHxqHll2Yqr4NDkMOXErZ9/t
 +cpwVTUsHSksEPeGilWWDWUOSUuxi3/4sbb2EDYyVJFzXa6d82SCTziP1ufwmbYRbS+p3CwJYFJ
 MaTISogD68jTwiXuuEg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ed2e5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=UoO_1Pgrh8XTa-HTx5YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kbhAMpKvgjMmMg7SoQpEqlgUz3qHanOH
X-Proofpoint-GUID: 6m1fg_Nsus_rltrLTI8A0qN7X5o3bceY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210095

On 5/20/2026 6:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Missing `MT_FLAGS_USE_RCU` during maple tree initialization causes Use-After-Free of tree internal nodes.
> - [High] Synchronous `kfree()` of `sframe_section` bypasses SRCU/RCU grace periods, causing Use-After-Free for concurrent readers.
> - [Low] Undeclared identifier `sframe_srcu` causes build failure.
> - [Low] Macro expansion of `INIT_MM_SFRAME` breaks compilation on non-x86 architectures.
> --
> 
> commit ce5ec4616b79b2c0aa851c150b33143b5d3876af
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Store .sframe section data in per-mm maple tree
> 
> Associate an .sframe section with its mm by adding it to a per-mm maple
> tree which is indexed by the corresponding text address range. A single
> .sframe section can be associated with multiple text ranges.
> 
>> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> [ ... ]
>> @@ -19,18 +21,31 @@ struct sframe_section {
>>  	signed char	fp_off;
>>  };
>>  
>> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
> 
> [Severity: High]
> Does this maple tree need to be initialized with MT_FLAGS_USE_RCU?
> 
> Without it, the tree operates in non-RCU mode, so lockless iterations
> might race with in-place node modifications and synchronous node frees,
> potentially causing use-after-free of the internal nodes.

Steven, please advise.

> 
>> diff --git a/kernel/fork.c b/kernel/fork.c
> [ ... ]
>> @@ -1073,6 +1075,13 @@ static void mmap_init_lock(struct mm_struct *mm)
>>  #endif
>>  }
>>  
>> +static void mm_init_sframe(struct mm_struct *mm)
>> +{
>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>> +	mt_init(&mm->sframe_mt);
> 
> [Severity: High]
> Similar to MTREE_INIT above, does mt_init() need to use mt_init_flags()
> with MT_FLAGS_USE_RCU here to prevent use-after-free during lockless reads?

Likewise.

> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> [ ... ]
>> +static int __sframe_remove_section(struct mm_struct *mm,
>> +				   struct sframe_section *sec)
>> +{
>> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
>> +		return -EINVAL;
>> +	}
>> +
>> +	free_section(sec);

I'll move the SRCU logic from patch "[PATCH v15 05/20] unwind_user/
sframe: Add support for reading .sframe contents" here:

	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);

> 
> [Severity: High]
> Can this synchronous free cause a use-after-free for concurrent readers?
> 
> If an unwinder or other thread is iterating the tree locklessly and has
> already obtained the section pointer before it is erased, freeing it
> immediately here without waiting for an RCU or SRCU grace period would
> pull the structure out from under them.

This will be resolved by above and below.

> 
>> +
>> +	return 0;
>> +}
>> +
>>  int sframe_remove_section(unsigned long sframe_start)
>>  {
> [ ... ]
>> +	struct mm_struct *mm = current->mm;
>> +	struct sframe_section *sec;
>> +	unsigned long index = 0;
>> +	bool found = false;
>> +	int ret = 0;
>> +
>> +	guard(srcu)(&sframe_srcu);
> 
> [Severity: Low]
> Is sframe_srcu defined anywhere? It doesn't appear to be declared in this
> file or its headers, which would cause a build failure.

My bad!  I'll move the definition of sframe_srcu and sframe_free_srcu()
from "[PATCH v15 05/20] unwind_user/sframe: Add support for reading
.sframe contents" to this patch.

> 
>> diff --git a/mm/init-mm.c b/mm/init-mm.c
> [ ... ]
>> @@ -49,6 +50,7 @@ struct mm_struct init_mm = {
>>  #endif
>>  	.flexible_array	= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>>  	INIT_MM_CONTEXT(init_mm)
>> +	INIT_MM_SFRAME
>>  };
> 
> [Severity: Low]
> Can this cause compilation failures on non-x86 architectures?
> 
> If architectures like PowerPC or UML define INIT_MM_CONTEXT without a
> trailing comma, placing INIT_MM_SFRAME (which expands to .sframe_mt = ...)
> immediately after it might result in a missing-comma syntax error.
Possibly.  This has not changed inbetween versions of this patch.  So if
that happens it will need fixing in the affected arch's definition of
INIT_MM_CONTEXT.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

