Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851F382383
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777437296; cv=none; b=krZ+EaPaOWUKqkizQf3WduqC5LspNq5w6aLFCZekOTSmdvtb8Ni6CYoostTJup0dPPwsAUQLPFCTpf/wubJyJETqnmgyURM7cRrJGw8kotuUAUQ+aCOgZwSJKgHt3E6FJUouwcBfZjvWfa36jv6fnCCTxv9xeFtBJMPsRBJeORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777437296; c=relaxed/simple;
	bh=b0XK/tbcMcEau6dcvSSIYEOmy8uotONOhpwTdVRRCoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR3YkRdKVtiTEr3zGfDTS+5cNVKw8N0IVR8dHX20B2YdWksQasKWwyTiA5xEEzTi7MDtyP0VfVnXawuI87hil3QVXti+Z6kbXfmQalFId6ojdDBT4U4vdGxonyb6VXePQHLdXt16pRds009TSvGDmxbtVGi3fgZLzyLv4iFx+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R/GNfer8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R/GNfer8"
Message-ID: <7b17c0c8-253f-4755-a324-1132cd3c0921@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777437292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8owAGB2dES6d7EjS4RuaoW7yOHbnwCyeEq2Bot6ImOo=;
	b=R/GNfer8bsyRbTQyVruq90Dylr8abYClc80TDVE5TNJ2eAW95mwTwgTImMrRW61ia3wygK
	q2G9fJBWVrOU89kcOtLjeqv7xH3Tu52I7WP+3Cborh/n+xHEn2dAZDhsqOi9tdIQA+jXqs
	MYtUQkLuAzGCPzWaJw/8+6UX9On+YHc=
Date: Wed, 29 Apr 2026 12:34:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 08/17] mm: introduce bpf_oom_kill_process()
 bpf kfunc
To: Matt Bobrowski <mattbobrowski@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-9-roman.gushchin@linux.dev>
 <aYAsxRI2JGU9KCeO@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <aYAsxRI2JGU9KCeO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2026/2/2 12:49, Matt Bobrowski wrote:
> On Mon, Jan 26, 2026 at 06:44:11PM -0800, Roman Gushchin wrote:
>> Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
>> to be used by BPF OOM programs. It allows to kill a process
>> in exactly the same way the OOM killer does: using the OOM reaper,
>> bumping corresponding memcg and global statistics, respecting
>> memory.oom.group etc.
>>
>> On success, it sets the oom_control's bpf_memory_freed field to true,
>> enabling the bpf program to bypass the kernel OOM killer.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>   mm/oom_kill.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 44bbcf033804..09897597907f 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -46,6 +46,7 @@
>>   #include <linux/cred.h>
>>   #include <linux/nmi.h>
>>   #include <linux/bpf_oom.h>
>> +#include <linux/btf.h>
>>   
>>   #include <asm/tlb.h>
>>   #include "internal.h"
>> @@ -1290,3 +1291,82 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>>   	return -ENOSYS;
>>   #endif /* CONFIG_MMU */
>>   }
>> +
>> +#ifdef CONFIG_BPF_SYSCALL
>> +
>> +__bpf_kfunc_start_defs();
>> +/**
>> + * bpf_oom_kill_process - Kill a process as OOM killer
>> + * @oc: pointer to oom_control structure, describes OOM context
>> + * @task: task to be killed
>> + * @message__str: message to print in dmesg
>> + *
>> + * Kill a process in a way similar to the kernel OOM killer.
>> + * This means dump the necessary information to dmesg, adjust memcg
>> + * statistics, leverage the oom reaper, respect memory.oom.group etc.
>> + *
>> + * bpf_oom_kill_process() marks the forward progress by setting
>> + * oc->bpf_memory_freed. If the progress was made, the bpf program
>> + * is free to decide if the kernel oom killer should be invoked.
>> + * Otherwise it's enforced, so that a bad bpf program can't
>> + * deadlock the machine on memory.
>> + */
>> +__bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>> +				     struct task_struct *task,
>> +				     const char *message__str)
>> +{
>> +	if (oom_unkillable_task(task))
>> +		return -EPERM;
>> +
>> +	if (task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN)
>> +		return -EINVAL;
Hi Matt and Roman
> task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN is also
> representative of an unkillable task, so why not fold this up into the
> above conditional? Also, why not bother checking states like
> mm_flags_test(MMF_OOM_SKIP, task->mm) and in_vfork() here too?
>
> In all fairness I'm a little surprised about constraints like
> task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN being enforced
> here. You could argue that the whole purpose of BPF OOM is such that
> you can implement your own victim selection algorithms entirely in BPF
> using your own set of heuristics and what not without needing to
> strictly respect properties like oom_score_adj.

Just my 2 cents — historically many users rely on setting oom_score_adj 
to OOM_SCORE_ADJ_MIN to protect their critical processes.

If we don't check this here and a custom BPF program happens to forget 
it, users would be quite surprised to find their most important

processes killed despite having explicitly marked them as protected.

So this really comes down to a priority question: when a custom BPF OOM 
policy decides to kill a process that the admin has explicitly

marked as protected via OOM_SCORE_ADJ_MIN, which one should take 
precedence?


> In any case, I think we should at least clearly document such
> constraints.

Fully agree. We need thorough documentation on what 
bpf_oom_kill_process() enforces on the kernel side,

so that custom BPF programs know exactly what's already handled and what 
additional checks they may

need to perform depending on their use case.


Thanks

Best regards.
Hao

>> +	/* paired with put_task_struct() in oom_kill_process() */
>> +	get_task_struct(task);
>> +
>> +	oc->chosen = task;
>> +
>> +	oom_kill_process(oc, message__str);
>> +
>> +	oc->chosen = NULL;
>> +	oc->bpf_memory_freed = true;
>> +
>> +	return 0;
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> +
>> +BTF_KFUNCS_START(bpf_oom_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE)
>> +BTF_KFUNCS_END(bpf_oom_kfuncs)
>> +
>> +BTF_ID_LIST_SINGLE(bpf_oom_ops_ids, struct, bpf_oom_ops)
>> +
>> +static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
>> +{
>> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
>> +	    prog->aux->attach_btf_id != bpf_oom_ops_ids[0])
>> +		return -EACCES;
>> +	return 0;
>> +}
>> +
>> +static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
>> +	.owner          = THIS_MODULE,
>> +	.set            = &bpf_oom_kfuncs,
>> +	.filter         = bpf_oom_kfunc_filter,
>> +};
>> +
>> +static int __init bpf_oom_init(void)
>> +{
>> +	int err;
>> +
>> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>> +					&bpf_oom_kfunc_set);
>> +	if (err)
>> +		pr_warn("error while registering bpf oom kfuncs: %d", err);
>> +
>> +	return err;
>> +}
>> +late_initcall(bpf_oom_init);
>> +
>> +#endif
>> -- 
>> 2.52.0
>>
