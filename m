Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2154705E
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848059; cv=none; b=oauyJQgP+zHVk5cjhsNFdTjGXl1VGelpLhWzWoL3wbGfP6An7snZCBsbvERFg6I7BNgCcKbMM+o6+ktd1XVkTK4ji1iDD1ncaHxiRG3JgwObbsFm8kde/LBBiQPW7KY7JqWV/fhQfBpTS8eNBWp9meHgHpEGg8SmLxOa4EF5V7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848059; c=relaxed/simple;
	bh=LKS8Jmw+s7q1zJLYx3MSCn1eYJhzAI8W4+0dN/qN5Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHlPMZMIOMTCl62yVk9hxd4HeLFaGgz56YIz7dCZFSu7LQ7teIeTxUBWT+023o337+HemkEcdbdJHuPe747Qw1mXtJsweojG+ddK+UnWfJNR6eDRJABV50NIU/tyIvnY2PWFix/1p+7lud6rRaZwWGqlsmgdqCbN9GvSHIDasHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sXPkaRsZ; arc=none smtp.client-ip=95.215.58.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sXPkaRsZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LKS8Jmw+s7q1zJLYx3MSCn1eYJhzAI8W4+0dN/qN5Xk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789848055; v=1; x=1790452855;
 b=sXPkaRsZDNlkTSQ3Kzlu8vJo1RbdchO+K/DWwh//GlpGVtAXAJYhVAIpvBXB0DKp2vkiuvcB
 5BOx0Ka4MBYkob96sC0J2yUYJJ8yIUK2rfn5vPNs2OkMAYX8TqkK/sJg+3LKJxpFImptkk4s7pF
 Rra4JuaeNTO2Ma40p0ViJxvc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 57d71d9abb75c589;
	Sat, 19 Sep 2026 20:00:55 +0000
X-Mizu-Trace-ID: 57d71d9abb75c589
X-Migadu-Flow: FLOW_OUT
Message-ID: <b278f3e2-a000-4b9a-af16-806eb75b03fc@linux.dev>
Date: Sat, 19 Sep 2026 13:00:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 11/20] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044253.3289522-1-yonghong.song@linux.dev>
 <20260918050339.415601F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260918050339.415601F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf, x86: garbage kfunc stack arguments in exception cleanup pads
> --
>
> commit 1e32297a3c2c4f6bbc4d458bc25563bed8167f6c
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Dispatch exception cleanup pads at run time
>
> This commit provides the architecture-specific support for x86-64 exception
> cleanup pads. It forces a full callee-saved spill for programs with a cleanup
> table and introduces arch_bpf_run_cleanup_pad to execute the pads.
>
>> diff --git a/arch/x86/net/bpf_cleanup_pad.S b/arch/x86/net/bpf_cleanup_pad.S
>> new file mode 100644
>> index 0000000000000..da4b448ecf095
>> --- /dev/null
>> +++ b/arch/x86/net/bpf_cleanup_pad.S
> [ ... ]
>
>> +SYM_FUNC_START(arch_bpf_run_cleanup_pad)
>> +	ANNOTATE_NOENDBR
>> +
>> +	pushq %rbp
>> +	pushq %rbx
>> +	pushq %r12
>> +	pushq %r13
>> +	pushq %r14
>> +	pushq %r15
>> +	/* Keep the pad's entry rsp congruent to a normal call's. */
>> +	subq $8, %rsp
>> +
>> +	movq 0(%rdx), %r15
>> +	movq 8(%rdx), %r14
>> +	movq 16(%rdx), %r13
>> +	movq 24(%rdx), %rbx
>> +	movq 32(%rdx), %r12
>> +	/* rbp is BPF r10, so this is the whole of the pad's frame setup. */
>> +	movq %rsi, %rbp
>> +
>> +	/* CALL_NOSPEC needs the target in a register; rcx is BPF r4, dead. */
>> +	movq %rdi, %rcx
>> +
>> +	/* BPF r0 on the way into a pad, not whatever the kernel left in rax. */
>> +	movl $BPF_PAD_ENTRY_R0, %eax
>> +
>> +	CALL_NOSPEC rcx
> [Severity: High]
> Does this execution environment cause kfuncs with more than 5 arguments
> to read uninitialized garbage stack arguments?

We should be okay since we already have:

+       if (bpf_pseudo_kfunc_call(insn)) {
+               struct bpf_call_summary cs;
+
+               if (bpf_get_call_summary(env, insn, &cs) &&
+                   cs.arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {
+                       verbose(env,
+                               "insn %u passes an on-stack call argument in an exception cleanup landing pad\n",
+                               i);
+                       return -EINVAL;
+               }
+       }

>
> In arch_bpf_run_cleanup_pad, the pad is executed on the unwinder's
> stack (rsp), while rbp is set to the original BPF frame.
>
> However, the JIT unconditionally writes outgoing kfunc stack arguments
> relative to BPF_REG_FP (rbp), as seen in emit_kfunc_arg_moves in
> arch/x86/net/bpf_jit_comp.c:
>
>                  else if (dst_mem)
>                          emit_stx(&prog, BPF_DW, BPF_REG_FP, reg,
>                                   stack_base + (dst - nreg) * 8);
>
> Because rbp and rsp are desynchronized in the pad, the arguments are
> written to the old frame. When the kfunc is called, the C calling
> convention requires it to read stack arguments from [rsp], which points
> to the unwinder's stack instead of the original frame, leading to
> garbage reads.
>

