Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407835E948
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187272; cv=none; b=iWX2PsmvnP4T/HHK4zKdkg384dy8uwa1zHhn/Owyx9GugrkDAiUh8xYPQOLW2LJPuFyG8kuWhJzZx14sRYpigcYrCnBC3Nc27FMkYubbjSopC21cFo1Y5dwISge2z9g4BbH+yweNXllCJTxRszpaa08AtGZVRHxxX1tLviOjHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187272; c=relaxed/simple;
	bh=qyc+kkcySSiaks4GtPyyluU2MSkweVp+Xx/6eq1ws6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2/UjvgPJ/OmalpjE9ymJ9QfmroaHR3JG+Okgys7bHtFnBD1Z8PjYxUOWq/UweKcM4hfFsLYMvmp095OHuG5HpUKplPjBWx8kj0nEwc+pewpdOHwm7R3ihQL9aZ+4+4wmYF4LbE69ANmP4MLUMBxI/iVwRf96pfCPCfY18It3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p6I7Grsl; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p6I7Grsl"
Message-ID: <f8abb228-f46a-4574-98e7-e7af75680537@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782187258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJthxnYdR1YFK0HF9IBA7wG8cov7ZcDLgwvvsP4R+aQ=;
	b=p6I7GrslX4G+q88H4I75u2WxBW6W0PHvniIugTwiiUdikTYH/g18xtpgCSgRZnGxjexoS2
	zsJ3SjS/7eQNdpmO9yHKq27L4GKDXgCkWugKqG5XGvInCgYW1VgU37M2thV2Wq/o8YYD6r
	6FXRvnG/sutf2WmzbePgSdxUCthRU/c=
Date: Tue, 23 Jun 2026 12:00:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 02/11] bpf: Disallow interpreter fallback for
 user BPF_ADDR_SPACE_CAST insn
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-3-leon.hwang@linux.dev>
 <20260622150759.EC9071F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260622150759.EC9071F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/6/26 23:07, sashiko-bot@kernel.org wrote:
[...]
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 649cce41e13f3..49398b5bd172d 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2620,6 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>  		goto finalize;
>>  
>>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> +	    fp->aux->has_addr_space_cast_insn ||
>>  	    bpf_prog_has_kfunc_call(fp))
>>  		jit_needed = true;
> 
> [Severity: Medium]
> If JIT is disabled or fails, returning -ENOTSUPP here will reject the
> program load silently without a verifier log message. Unlike
> bpf_prog_has_kfunc_call() which provides a helpful verbose() log in
> bpf_fixup_call_args():
> 
> 	if (has_kfunc_call) {
> 		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
> 		return -EINVAL;
> 	}
> 
> Users encountering this for has_addr_space_cast_insn will not see an
> explanation for the EOPNOTSUPP error. Could we add a verifier log message
> explaining why JIT is required here?
> 

No verifier log support here.

The verifier log has been finalized before calling
__bpf_prog_select_runtime() in bpf_check().

>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 3cf2cc6e3ab66..2d5958774b61b 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1523,6 +1523,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>>  				insn->off = 0;
>>  				insn->imm = 0;
>>  			} /* cast from as(0) to as(1) should be handled by JIT */
>> +			if (insn_is_cast_user(insn))
>> +				prog->aux->has_addr_space_cast_insn = true;
> 
> [Severity: Critical]
> This is a pre-existing issue, but the patch attempts to fix interpreter
> fallback for BPF_ADDR_SPACE_CAST and fails to address the underlying panic
> with arena programs.
> 
> If a program uses an arena and obtains a PTR_TO_ARENA without a cast_user
> instruction (for instance, using cast_kern), or if the arena map has
> BPF_F_NO_USER_CONV set, has_addr_space_cast_insn will not be set.
> 
> In the case of BPF_F_NO_USER_CONV, the instruction is rewritten to
> BPF_ALU | BPF_MOV | BPF_X right before the insn_is_cast_user() check.
> 
> Memory accesses using PTR_TO_ARENA are rewritten by bpf_do_misc_fixups()
> to use BPF_PROBE_MEM32 or BPF_PROBE_MEM32SX. If these arena programs fall
> back to the interpreter, wouldn't they hit the BUG_ON(1) in ___bpf_prog_run()
> because it lacks handlers for these opcodes?
> 
> kernel/bpf/core.c:___bpf_prog_run() {
>     ...
> 	default_label:
> 		pr_warn("BPF interpreter: unknown opcode %02x (imm: 0x%x)\n",
> 			insn->code, insn->imm);
> 		BUG_ON(1);
>     ...
> }
> 
> Should jit_needed be enforced in __bpf_prog_select_runtime() for all
> programs using fp->aux->arena instead?
> 

Sounds reasonable.

However, I think such similar issues should be fixed using separate
patches: all interpreter-unsupported insns should be marked as JIT-needed.

Like the way of "bpf: Fix unaligned interpreter panic on JIT fallback
path" [1], we can verify whether there are the following insns in the
prog by scanning prog->insnsi:

* user ADDR_SPACE_CAST
* PROBE_MEM32, PROBE_MEM32SX
* ADDR_PERCPU
* PROBE_ATOMIC
* indirect jump using insn_array map

I think these insns are not supported by interpreter.

Link:
[1]
https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn/

Thanks,
Leon

