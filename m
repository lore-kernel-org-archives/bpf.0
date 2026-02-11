Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F727FB0E
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793911; cv=none; b=Ahpg2wr/V3GHPkZc/r/b5szLTx6uoPGwyt9o3XtBG5EfRL2pSZcdt2jveRRJC6DdQEMkkN8l6RyvEMiQ7UohP7ZboY6263yaTJLF7u0sLC7ETYVj+mo3GvV2KKheCVVY2Ryldwdr9oFAN4lcTc+dIanY+udRGSeTzhbjxrP3HvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793911; c=relaxed/simple;
	bh=Xa6pXRpo8eL/Zj/aKuglUBdv1xibV6BGl3XxvnxlvsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8UDkr4DmqpHt/KsSDx9FeY+xDJx2nxCDxpf8lr3ESaj5Vb9WG7UP2EtMq7Bv4YURVCPat9fK24wwsDB0KEFXDJ4jhK5tUoWbB6EK6zOMt+VTx21vh7TTA85XT7nNo0L397RHPAfIHGOac/z7ri9B4vHTG+2XE8iYXOjNmajb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhRNe4pt; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FhRNe4pt"
Message-ID: <ecb7df62-d707-43dd-943b-98a452b2268e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770793907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1zHUFg+GFNu5+o59tdpPb0PlUyLlNRiv3e9KkaZ8yY=;
	b=FhRNe4pt3jcWwPK4XZ1HcvxbwcbZwdvmVBXvhZmYP+k6gGueXsWs0CyQBagv2xx5cgVH94
	wlN+uq8CBCrcK+FUHoRRf3OasGDjKY1lRsAePAhZMto0CaEFley7/TKnVVKPs2jXdm2cy4
	2k++i7Jy66kh49VxfHYdV96IAhfdjvw=
Date: Wed, 11 Feb 2026 15:10:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add preempt disable for
 bpf_get_stack
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260206090653.1336687-1-chen.dylane@linux.dev>
 <CAEf4BzbSCbqg6y1KGg_j5xkK1=xsmOyK5ob9uTJiVcWgQ4jAJw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbSCbqg6y1KGg_j5xkK1=xsmOyK5ob9uTJiVcWgQ4jAJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/2/7 01:12, Andrii Nakryiko 写道:
> On Fri, Feb 6, 2026 at 1:07 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The get_perf_callchain() return values may be reused if a task is preempted
>> after the BPF program enters migrate disable mode, so we should add
>> preempt_disable. And as Andrii suggested, BPF can guarantee perf callchain
>> buffer won't be released during use, for bpf_get_stack_id, BPF stack map
>> will keep them alive by delaying put_callchain_buffer() until freeing time
>> or for bpf_get_stack/bpf_get_task_stack, BPF program itself will hold these
>> buffers alive again, until freeing time which is delayed until after
>> RCU Tasks Trace + RCU grace period.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>
>> Change list:
>>   - v1 -> v2
>>     - add preempt_disable for bpf_get_stack in patch1
>>     - add patch2
>>   - v1: https://lore.kernel.org/bpf/20260128165710.928294-1-chen.dylane@linux.dev
>>
>>   kernel/bpf/stackmap.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
> 
> Hm... looking at bpf_get_stack_pe(), I'm not sure what's the exact
> guarantees around that ctx->data->callchain that we pass as
> trace_in... It looks like it's the same temporary per-cpu callchain as
> in other places, just attached (temporarily) to ctx. So we probably
> want preemption disabled/enabled for that one as well, no? And to

see commit "1d7bf6b7d3e8" (perf/bpf: Remove preempt disable around BPF 
invocation)
bpf_overflow_handler is called from NMI or at least hard
interrupt context which is already non-preemptible. So no preemption 
disabled needed.

> achieve that, I think we'll need to split out build_id logic out of
> __bpf_get_stack() and do it after preemption is enabled in the
> callers. Luckily it's not that much of a code and logic, should be
> easy. But please analyze this carefully yourself.
> 
> pw-bot: cr
> 
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index da3d328f5c1..1b100a03ef2 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>
>>          max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>>
>> -       if (may_fault)
>> -               rcu_read_lock(); /* need RCU for perf's callchain below */
>> +       if (!trace_in)
>> +               preempt_disable();
>>
>>          if (trace_in) {
>>                  trace = trace_in;
>> @@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          }
>>
>>          if (unlikely(!trace) || trace->nr < skip) {
>> -               if (may_fault)
>> -                       rcu_read_unlock();
>> +               if (!trace_in)
>> +                       preempt_enable();
>>                  goto err_fault;
>>          }
>>
>> @@ -493,9 +493,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>                  memcpy(buf, ips, copy_len);
>>          }
>>
>> -       /* trace/ips should not be dereferenced after this point */
>> -       if (may_fault)
>> -               rcu_read_unlock();
>> +       if (!trace_in)
>> +               preempt_enable();
>>
>>          if (user_build_id)
>>                  stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen
