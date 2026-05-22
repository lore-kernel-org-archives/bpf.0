Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885F3B83F8;
	Fri, 22 May 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443104; cv=none; b=HeYanbyIpQyIyM2+Bu1vkPk6Qw3VqtSlxASpUxMXyruhYN6ts72ussfJODuR6/tfjj66IvSr2Ru8JK48fAiFIJXiZGpkGC4RB0RAUuyFwWTfJ+pzD+pmh4+FGgG73XLW+H6Lu9d2MPqGaRUff2UbBQtvgK7IlxvDcmnXlJo6ysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443104; c=relaxed/simple;
	bh=8rDv+Vw5qD7XIy+EwLuItDtgEhs+/7o8/Us/1TsoP2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj+DFIfkztDlIWBr/w8CmQ2NR6fLPDEL2MncNR0spkj6HlUbEkeRwgMLV373Us4T06weXUc+WTHWcVw8/WCizfwUB09CrDQCsAWfnw0o6fn3+7JIM4qXpLvd0xq0U/D5scoaEIa2Uyr+cfsC2R3vy7nsoxc8AzTxFOg/I32O/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MxEL6ynn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MxEL6ynn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LMxtjH271835;
	Fri, 22 May 2026 09:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/ZeuZV
	maZShaA4NUD+iaf4GUtWf6Dtn/fQf2uAjYccQ=; b=MxEL6ynnGX+GOkxFY93K5A
	DySjpJz9JbfUtdXwoMruoJ2kb5CkeP91eAI0QVXMbDrptJyNid9yiXRP2UHpPIyX
	4P8cgoDCS8AH93rUKrbbRF6v79OwRccrV1KipfxYs7dRN2T9i5BPN1LtnjHVhHXG
	FACJ4WOBHkkyLYQDUbSAP7fRr9rz1O11cKaEGxHdWpEJaz2VASJ1wRh66iMIkIBT
	ZenVfhrd9jrN2EVzOeLKH6K3QxWkFydMt7FQfBnYCX7q4Nc7tvYSNyYD1JLQslGl
	OkiirP7SpeV9JsV3AclSiXZVw7nntc4YwL4jog9cNkMRVnNFtTeX9lxdpJI55L2g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75ba5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:43:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M9d8xJ012698;
	Fri, 22 May 2026 09:43:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyg26f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:43:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M9hAUP60031238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 09:43:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8006A2004B;
	Fri, 22 May 2026 09:43:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98BCC20043;
	Fri, 22 May 2026 09:43:07 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 09:43:07 +0000 (GMT)
Message-ID: <d82ea328-758e-4e41-a58e-46f3137feca7@linux.ibm.com>
Date: Fri, 22 May 2026 11:43:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unwind: Add sframe_(un)register() system calls
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260521183532.7a145c8a@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521183532.7a145c8a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a102534 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bC-a23v3AAAA:8 a=meVymXHHAAAA:8 a=PwbjKb6qUXuBVeOY6egA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 7mqlhaJ-PEhwEWK1118C-oxnIBBOAi4k
X-Proofpoint-GUID: y4Vxus9ohHsFO2v2NKXI_eSEYlFEJZEt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NSBTYWx0ZWRfX0PB1SjFjFaYQ
 CG7YO0Tod+VVi8UJlduMaVmoAIJTMXi6Nt8NYlJRz8vK3vTI9dDkrUfu6JrWyaW0ejGuUw72kbW
 YdA8GhZUaw/3XoZdTHw5vm1bDvI/dLqsraSAsFIozdZ3MeEVVgb4xeKprZD28JDx/PxMWY60PMj
 IS8UbVbexj9VD21JbNwA+EuE79kbVuAN8Y6Lcw4nksJDS/0GlgH5uFO92xgnF++DxYHuCTr+ZoK
 +ItxroX4VxUDZdi4SZ49Eba/4pYGSP1sUmEI78VhsoP9NogGhJ8eKapk8QAWKePgAvbuF5x7+bF
 YVFS4scEDsY8lXL/oL/F2pUcZ28vQ8WUiTqYvNNQCJHdyv7PZt8bfPHn7I4v5oR0tInKF+aISfS
 zU4Z/lxaygjwiD82EK6NHx3Pgnc7sjBCftDZYDfBE0kxE9XYu9xN5gAyT7WzCdIK9YJ6IU805Zu
 3mPJsH5N4DJz1SOA80g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220095

On 5/22/2026 12:35 AM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add system calls to register and unregister sframes that can be used by
> dynamic linkers to tell the kernel where the sframe section is in memory
> for libraries it loads.

Why two separate system calls?  Can't that be one single stacktracectl?
Could they at least be non-sframe specific, e.g. stracktrace_register
and stracktrace_unregister, so that if one would implement e.g. unwind
user dwarf/eh_frame in the future one could pass ehframe_start and
ehframe_end in addition to sframe_start and sframe_end?

> 
> Both system calls take a pointer to a new structure:
> 
>   struct sframe_setup {
> 	unsigned long		sframe_start;
> 	unsigned long		sframe_size;
> 	unsigned long		text_start;
> 	unsigned long		text_size;
>   };
> 
> and a size of the passed in structure. If the system call needs to be
> extended, then the structure could be changed and the size of that
> structure will tell the kernel that it is the new version. If the kernel
> does not recognize the structure size, it will return -EINVAL.
> 
>   sframe_start - The virtual address of the sframe section
>   sframe_size  - The length of the sframe section
>   text_start   - the text section the sframe represents
>   test_size    - the length of the section
> 
> If other stack tracing functionality is added, it will require a new
> system call.
> 
> The unregister only needs the sframe_start and requires all the rest of
> the fields to be 0. In the future, if more can be done, then user space
> can update the other values and check the return code to see if the kernel
> supports it.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> 
> Based on top of Jens patches here:
> 
>   https://lore.kernel.org/linux-trace-kernel/20260520154004.3845823-1-jremus@linux.ibm.com/
> 
> [ Note, I tested this with the same program from the RFC patch ]
> 
> Changes from RFC: https://patch.msgid.link/20260429114355.6c712e6a@gandalf.local.home
> 
> - Remove the ioctl() like system call for a unique system call for each
>   functionality. Right now there's two functionalities:
>    1. register sframe section
>    2. unregister sframe sections
> 
> - Added taking a lock around the mtree logic in __sframe_remove_section()
>   as Sashiko mentioned that there could be races from user space
>   registering and unregistering sframe sections at the same time.

Doesn't sframe_add_section() then also need likewise?

> 
> - Removed [RFC] from subject as I believe this is more likely the way
>   this system call will be done.

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h

> @@ -999,6 +999,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
>  asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
>  				      u32 size, u32 flags);
>  asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
> +asmlinkage long sys_sframe_register(void *data, unsigned int size);
> +asmlinkage long sys_sframe_unregister(void *data, unsigned int size);
>  
>  /*
>   * Architecture-specific system calls


> diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h

> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_SFRAME_H
> +#define _UAPI_LINUX_SFRAME_H
> +
> +struct sframe_setup {
> +	unsigned long		sframe_start;
> +	unsigned long		sframe_size;
> +	unsigned long		text_start;
> +	unsigned long		text_size;
> +};
> +
> +#endif /* _UAPI_LINUX_SFRAME_H */

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

> @@ -842,9 +844,11 @@ static void sframe_free_srcu(struct rcu_head *rcu)
>  static int __sframe_remove_section(struct mm_struct *mm,
>  				   struct sframe_section *sec)
>  {
> -	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> -		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
> -		return -EINVAL;
> +	scoped_guard(mmap_read_lock, mm) {

Why is a read lock sufficient? Doesn't that allow multiple readers?
How does that prevent a concurrent modification of the mm->sframe_mt?

> +		if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> +			dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
> +			return -EINVAL;
> +		}

Is (or why not) likewise required in sframe_add_section() for the
mtree_insert_range()?

Wasn't the reported issue that while mt_for_each() in
sframe_remove_section() there could be concurrent mtree_erase() in
__sframe_remove_section() followed by mtree_insert_range() in
sframe_add_section(), so that the mt_for_each() could get confused?

>  	}
>  
>  	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
> @@ -936,3 +940,56 @@ void sframe_free_mm(struct mm_struct *mm)
>  
>  	mtree_destroy(&mm->sframe_mt);
>  }
> +
> +/**
> + * sys_sframe_register - register an address for user space stacktrace walking.
> + * @data: Structure of sframe data used to register the sframe section
> + * @size: The size of the given structure.
> + *
> + * This system call is used by dynamic library utilities to inform the kernel
> + * of meta data that it loaded that can be used by the kernel to know how
> + * to stack walk the given text locations.
> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE2(sframe_register, __user struct sframe_setup *, data, unsigned int, size)
> +{
> +	struct sframe_setup sframe;
> +
> +	if (sizeof(sframe) != size)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&sframe, data, size))
> +		return -EFAULT;
> +
> +	return sframe_add_section(sframe.sframe_start,
> +				  sframe.sframe_start + sframe.sframe_size,
> +				  sframe.text_start,
> +				  sframe.text_start + sframe.text_size);
> +}
> +
> +/**
> + * sys_sframe_unregister - unregister an sframe address
> + * @data: Structure of sframe data used to register the sframe section
> + * @size: The size of the given structure.
> + *
> + * The data->sframe_start is the only value that is used. The rest must
> + * be zero.
> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE2(sframe_unregister, __user struct sframe_setup *, data, unsigned int, size)
> +{
> +	struct sframe_setup sframe;
> +
> +	if (sizeof(sframe) != size)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&sframe, data, size))
> +		return -EFAULT;
> +
> +	if (sframe.sframe_size || sframe.text_start || sframe.text_size)
> +		return -EINVAL;
> +
> +	return sframe_remove_section(sframe.sframe_start);
> +}
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

