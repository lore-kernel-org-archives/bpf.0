Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEB3A7584
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431665; cv=none; b=QpOJ3z1qg2xBMB1CUzI3TrBugWFUZ7kHdcEgLc0B1gaLyiyhK7g71M5Yy7RHKwqmtuu45zoOux+7imS3b2xxfrfFigef0caBvpM6yp3Ml9knXFrQTURagw/qaiGABwHJxFvmuoUe+WrxiN1UqxZCmec/kfLZxstGnALuwJzpaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431665; c=relaxed/simple;
	bh=v9ic3i2Ojj7qslrLK6Pg1tVAxKhA6dpWmMslwhh1yjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTJh0Guc3KzcDOPcCBhklva2IHVuTVeUcWYG5vRhpMt8sDsVXLU509xk5nuEnBuMhFULN+tZXchWhxcWVVx5xyjZ8FBSnyLzhLavJSYjAZgUL6dS6Q6ZZCtgmdrVv8zedddW3l3txZFwfn0WSi9piW8CXgb/uZDIO1tl5OlVbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=azrHYVas; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="azrHYVas"
Message-ID: <19287dff-648c-4721-b8af-1beb75267b52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778431661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRk826Wgf+u3SOUBqGt75iN3jg0GqcF68Va4lRIKWpQ=;
	b=azrHYVasved1wOyqgPn8E+W7ctsrjaqM7b9fStAc+nxMWBuvdEFPydN01vTZ9ApxkhkNd7
	iXiqGKufZBFb3M1dj+XVpgMUsPaiPlkojnQSKBKkMTbniMxrHs5sWpFFU5bS3yPvLhyrjn
	WmS1DKxBSXVqZtt2SJX4NIYmXwZPazM=
Date: Sun, 10 May 2026 09:47:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 09/23] bpf: Extend liveness analysis to track
 stack argument slots
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213029.1130085-1-yonghong.song@linux.dev>
 <20260509005916.E22DAC2BCB4@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509005916.E22DAC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 2:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] record_load_store_access() mistakenly uses the tracking state of stack argument slot 0 as the base pointer for R11-based memory accesses, leading to spurious liveness marks.
> - [Low] Missing verifier logging for stack argument liveness state transitions.
> --
>
> commit 00a5fce117daa13f26c61ec5ffa3622241608fc1
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Extend liveness analysis to track stack argument slots
>
> This commit extends liveness analysis to handle stack argument slots, preventing
> pointers passed through stack args from incorrectly poisoning the pointed-to
> stack slots. It explicitly handles BPF_REG_PARAMS (R11) to avoid out-of-bounds
> accesses and extends tracking arrays.
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index de0b4c6263ff2..eed7260f2bb0a 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
>> @@ -610,6 +610,24 @@ enum arg_track_state {
>>   /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes each) */
>>   #define MAX_ARG_SPILL_SLOTS 64
>>   
>> +/* Track stack arg slots: outgoing starts at -(i+1)*8, incoming at +(i+1)*8 */
>> +#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
>> +
>> +/*
>> + * Combined register + stack arg tracking: R0-R10 at indices 0-10,
>> + * outgoing stack arg slots at indices MAX_BPF_REG..MAX_BPF_REG+6.
>> + */
>> +#define MAX_AT_TRACK_REGS (MAX_BPF_REG + MAX_STACK_ARG_SLOTS)
> Could this repurposed index cause a spurious liveness mark in
> record_load_store_access()?
>
> Because at[MAX_BPF_REG] is repurposed to track the value stored in outgoing
> stack argument slot 0, what happens when record_load_store_access() processes
> stack argument instructions like is_stack_arg_stx()?
>
> record_load_store_access() does this:
>
> 	case BPF_STX:
> 		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
> 			...
> 		} else {
> 			ptr = &at[insn->dst_reg];
> 			sz = -sz;
> 		}
>
> If the instruction is a stack argument access, insn->dst_reg is BPF_REG_PARAMS
> (which equals MAX_BPF_REG). It will fetch &at[MAX_BPF_REG]. If a BPF program
> previously stored a frame pointer (FP) into slot 0, at[MAX_BPF_REG] will reflect
> that FP.
>
> Does this mean record_load_store_access() will spuriously treat this FP as the
> base pointer and incorrectly mark the resulting local stack frame slot as
> accessed, corrupting the local stack liveness mask?

In this case, if the insn is r11-based insn in record_load_store_access(),
we should just return since record_load_store_access() is for fp based stacks.

>
> [ ... ]
>> @@ -1616,7 +1663,8 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
>>   		memcpy(at_out, at_in[i], sizeof(at_out));
>>   		memcpy(at_stack_out, at_stack_in[i], MAX_ARG_SPILL_SLOTS * sizeof(*at_stack_out));
>>   
>> -		arg_track_xfer(env, insn, idx, at_out, at_stack_out, instance, callsites);
>> +		arg_track_xfer(env, insn, idx, at_out, at_stack_out,
>> +			       at_stack_arg_entry, instance, callsites);
>>   		arg_track_log(env, insn, idx, at_in[i], at_stack_in[i], at_out, at_stack_out);
> Are the state transitions for stack arguments logged here?
>
> In arg_track_log(), the loop for logging register transitions is strictly
> bounded by MAX_BPF_REG:
>
> 	for (i = 0; i < MAX_BPF_REG; i++) {
> 		if (arg_track_eq(&at_out[i], &at_in[i]))
> 			continue;
>
> Since the tracking arrays at_in and at_out were extended to MAX_AT_TRACK_REGS to
> include state for outgoing stack arguments at indices MAX_BPF_REG through
> MAX_AT_TRACK_REGS - 1, does arg_track_log() silently omit logging their state
> transitions?

Missed the logging issue for stack argument tracking. Will fix.

