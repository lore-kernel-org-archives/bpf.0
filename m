Received: from mta1.migadu.com (out-207.mta1.migadu.com [95.215.58.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE1395ADD
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214434; cv=none; b=TzvUBVTvN33DZcR3qfNlQUYgSZXlIlantK0dbQGTb9f7/yXq7S8nbhLu1Z2dz5mquXR/GlhF3huaQPh4Q2i/kgSuDoNfAyVgukYZQgI3GP4Meh/U0VsH1fzVrlaB+DJ9tu4Sd7pOxO3oN8wGAQ/XMbEMoay19E+ra62NJK9X0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214434; c=relaxed/simple;
	bh=Pzx/g8i/WMKeYmOUaBcG+KTWXyYcvBMeLjRTqshJCPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W1ak34zvSc3yfiWR6MHW8qSSpIWKfk99LWvJlzb8aSH8tU6wYJm7PMGk34nYCWYkUVDLA0/39JBT7kYNkwLvM/jSSHyDf98RdAr6LIzVLQLQrqPFpvk3jFV1gonun5WDcyPo8AzBcenJaEFhzYfezrNvrvYxMk3mV0qjY1IRk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o7WWwCwt; arc=none smtp.client-ip=95.215.58.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o7WWwCwt"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Pzx/g8i/WMKeYmOUaBcG+KTWXyYcvBMeLjRTqshJCPM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792214430; v=1; x=1792819230;
 b=o7WWwCwtWeuuWEpQWiZT1LNctjcUte+mNYgXGeeiL4HpnUK+MG1XgvxXfxSSUTXEE1OB9Hlo
 q/KjE7oA+1sAQg0hoTo+PjFsB+odmR7Zri0p5n+JAEkzLU1ZoYnqD///PoQGdkaCgiJ5A7cxV0o
 ZYIjzT5IRllDweHzm0aAZEuI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 20083f5432ebd620;
	Sat, 17 Oct 2026 05:20:23 +0000
X-Mizu-Trace-ID: 20083f5432ebd620
X-Migadu-Flow: FLOW_OUT
Message-ID: <bc2baddf-e29d-4591-ad70-9b9625a07fcd@linux.dev>
Date: Fri, 16 Oct 2026 22:20:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 06/25] bpf: Verify an unwind through landing
 pads and epilogues
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
 <20261017025201.1919939-1-yonghong.song@linux.dev>
 <sashiko-outbox-175243@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-175243@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 8:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: missing might_unwind propagation in mark_callx_might_unwind()
> --
>
> commit c4002615f0bb137c4f685915b07888fb1dc5bbea
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Verify an unwind through landing pads and epilogues
>
> This commit teaches the BPF verifier to follow stack unwinds from
> bpf_unwind(), bpf_unwind_resume(), and unwinding global subprograms
> through caller landing pads and epilogues, including CFG effect
> propagation and precision backtracking.
>
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index ad7ea08f3b15e..9608293bdc069 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
> [ ... ]
>
>> @@ -91,6 +99,7 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
>>   	caller->changes_pkt_data |= callee->changes_pkt_data;
>>   	caller->might_sleep |= callee->might_sleep;
>>   	caller->might_throw |= callee->might_throw;
>> +	caller->might_unwind |= callee->might_unwind;
>>   }
>>   
>>   enum {
> [ ... ]
>
>> @@ -705,6 +716,82 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
>>   	}
>>   }
>>   
>> +static bool addr_taken_subprog_might_unwind(struct bpf_verifier_env *env)
>> +{
>> +	struct bpf_insn *insns = env->prog->insnsi;
>> +	struct bpf_subprog_info *callee;
>> +	struct bpf_func_ptr *ptrs;
>> +	u32 cnt, j;
>> +	int i;
>> +
>> +	for (i = 0; i < env->prog->len; i++) {
>> +		if (bpf_pseudo_func(&insns[i])) {
>> +			callee = bpf_find_containing_subprog(env, i + insns[i].imm + 1);
>> +			if (callee->might_unwind)
>> +				return true;
>> +			continue;
>> +		}
>> +		ptrs = insn_func_ptrs(env, i, &cnt);
>> +		for (j = 0; j < cnt; j++) {
>> +			callee = bpf_find_containing_subprog(env, ptrs[j].xlated_off);
>> +			if (callee->might_unwind)
>> +				return true;
>> +		}
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * merge_callee_effects() does not carry might_unwind to a subprog that calls
>> + * through a pointer it was handed. So if any subprog a callx can reach may
>> + * unwind, mark every subprog with a callx, and its callers.
>> + *
>> + * This is conservative: a subprog with a callx is marked even when nothing it
>> + * calls unwinds. The main walk knows each callx's target and could tell those
>> + * apart.
>> + */
>> +static void mark_callx_might_unwind(struct bpf_verifier_env *env)
>> +{
>> +	struct bpf_insn *insns = env->prog->insnsi;
>> +	struct bpf_subprog_info *caller, *callee;
>> +	int i, j, len = env->prog->len;
>> +	struct bpf_func_ptr *ptrs;
>> +	bool changed;
>> +	u32 cnt;
>> +
>> +	if (!addr_taken_subprog_might_unwind(env))
>> +		return;
> [Severity: High]
> Can addr_taken_subprog_might_unwind() return false prematurely here when an
> address-taken subprogram calls back into an unwinding subprogram whose
> entry instruction is still in the DISCOVERED state during the CFG walk?
>
> In bpf_check_cfg(), visit_insn() traverses insn_func_ptrs() (for example,
> an ld_imm64 referencing a read-only map such as .rodata that holds function
> pointers) and bpf_pseudo_func() as CFG edges. Because neither
> sort_subprogs_topo() nor check_max_stack_depth_subprog() rejects cycles
> through insn_func_ptrs() or async callback bpf_pseudo_func() edges, a
> subprogram cb whose address is in .rodata or taken via bpf_pseudo_func()
> can call a subprogram G via BPF_PSEUDO_CALL while G references .rodata or
> &cb on one branch and calls bpf_unwind() on a second branch.
>
> If bpf_check_cfg() explores G before cb:
>
> 1. G's entry instruction is marked DISCOVERED and pushes branch 1 onto
>     insn_stack while G->might_unwind is still false.
> 2. Branch 1's insn_func_ptrs() or bpf_pseudo_func() edge pushes cb onto
>     insn_stack.
> 3. cb's BPF_PSEUDO_CALL to G runs merge_callee_effects() while
>     G->might_unwind is still false, and push_insn() sees G's entry is
>     already DISCOVERED and returns DONE_EXPLORING, so cb finishes exploration
>     with cb->might_unwind == false.
> 4. bpf_check_cfg() later explores branch 2 of G and sets
>     G->might_unwind = true.
>
> When mark_callx_might_unwind() then runs, addr_taken_subprog_might_unwind()
> sees cb->might_unwind == false and returns early before the fixed-point loop
> below can propagate G->might_unwind to cb and its callers.
>
> As a result, a global subprogram calling cb (via callx or BPF_PSEUDO_CALL)
> will have might_unwind == false, causing process_global_call_unwind() to
> skip verifying the unwind path at the caller and allowing acquired
> references or locks to leak on unwind.

I think you are right, inside mark_callx_might_unwind(), before
addr_taken_subprog_might_unwind(), we indeed need to do one pass
for the below do loop as it may actually mark might_unwind as true.

>
>> +
>> +	for (i = 0; i < len; i++)
>> +		if (bpf_is_callx(&insns[i]))
>> +			bpf_find_containing_subprog(env, i)->might_unwind = true;
>> +
>> +	do {
>> +		changed = false;
>> +		for (i = 0; i < len; i++) {
>> +			caller = bpf_find_containing_subprog(env, i);
>> +			if (caller->might_unwind)
>> +				continue;
>> +			if (bpf_pseudo_call(&insns[i]) || bpf_pseudo_func(&insns[i])) {
>> +				callee = bpf_find_containing_subprog(env, i + insns[i].imm + 1);
>> +				if (!callee->might_unwind)
>> +					continue;
>> +				caller->might_unwind = true;
>> +				changed = true;
>> +				continue;
>> +			}
>> +			ptrs = insn_func_ptrs(env, i, &cnt);
>> +			for (j = 0; j < cnt; j++) {
>> +				callee = bpf_find_containing_subprog(env, ptrs[j].xlated_off);
>> +				if (!callee->might_unwind)
>> +					continue;
>> +				caller->might_unwind = true;
>> +				changed = true;
>> +			}
>> +		}
>> +	} while (changed);
>> +}
> [ ... ]
>

