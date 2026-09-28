Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABF361947
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565044; cv=none; b=K2/h9G6KNIf/chVAXDy+XujgUrFDZ6pvr0EG5ZxPkZD/hNfJPGDvTtNHj8TxUBYRh5YqDVVlzd8BX5h4rijX6WOcNioFoBlBeYt0L0JrnCZt9VlAA6vA6rwYUhJFK213xZ+flFnuKwmZkXIgKIBfuguQvBEldmRykvByBueRSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565044; c=relaxed/simple;
	bh=k0YHNB9R9CPLsOduJLwbiWt1z2+vcwvZN7BZGJWl3j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU6zz6T41WIQMhVKPxzVX75SG0co1BzhRGwDBNkYfZC636X4NylbuYK7tErmjKXvr1aj7yOYzszKvF9wUJjAF5hHzXsyBBdQfgfsF/M9OgmssVOfoQcbVsS4n4YLdsA0nlzEEkoM7+tJ/QInu2503s8jsAeQ31ZtIc5jcUeYl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pa4vIJu6; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pa4vIJu6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k0YHNB9R9CPLsOduJLwbiWt1z2+vcwvZN7BZGJWl3j8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790565040; v=1; x=1791169840;
 b=pa4vIJu6fHqLAzQVuQwIsmDfd2KLfdigsSUBMtD0V/2MH/picjt00w6F2dJrXTmDTFPCQS7Y
 DAvhK7XxjrOFfPOtSJtyd1/Z1pIgXIRfakPhcw1Wm1z9p16bE1rmNs08IGbEFpnZ/WFgSZe8F9+
 6Ia7Gxksn50WDStCUtEae/p4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 71863c4a9f5cca80;
	Mon, 28 Sep 2026 03:10:39 +0000
X-Mizu-Trace-ID: 71863c4a9f5cca80
X-Migadu-Flow: FLOW_OUT
Message-ID: <f975aa30-a056-4f48-8f65-abcff0e7cc70@linux.dev>
Date: Sun, 27 Sep 2026 20:10:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 11/21] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050102.2218021-1-yonghong.song@linux.dev>
 <699b29ac22154d64cba9488294b7931090b0c50650e99e555f278a1da854647e@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <699b29ac22154d64cba9488294b7931090b0c50650e99e555f278a1da854647e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/26 1:39 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git arch/x86/net/bpf_jit_comp.c arch/x86/net/bpf_jit_comp.c
>> index 6c7a0578760e..fb7e8ca1aab2 100644
>> --- arch/x86/net/bpf_jit_comp.c
>> +++ arch/x86/net/bpf_jit_comp.c
>> @@ -2150,7 +2150,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   			dst_reg = X86_REG_R9;
>>   	}
>>
>> -	if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>> +	if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1) ||
>> +	    bpf_exc_insn_is_pad(env, bpf_prog, i - 1))
>>   		EMIT_ENDBR();
> Landing pads are only ever entered by a ret whose stack slot
> bpf_unwind_rewrite() rewrote. Nothing jumps or calls to a pad indirectly
> since bpf_unwind_resume() is lowered to 'r0 = 0; exit', and
> bpf_exc_check_insn() forbids gotox inside a pad. IBT only checks
> indirect JMP/CALL targets, not RET targets, so the ENDBR at each pad
> head should not be needed.

Yes, you are right. ENDBR is not needed here.

>
> The same patch sends pad-less frames to aux->epilogue_ip through the
> same kind of rewritten ret, and emits no ENDBR there. That shows the pad
> ENDBR does no functional work. Each extra ENDBR in the middle of a JITed
> function is one more valid IBT landing site in executable kernel memory,
> and the kernel normally keeps those to a minimum (objtool seals unused
> ENDBRs).
>
> Is there an indirect-branch path to the pad that is not visible here?
>
>>   	ip = image + addrs[i - 1] + (prog - temp);
> [ ... ]
>
>> @@ -3278,6 +3279,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   		seen_exit = true;
>>   		/* Update cleanup_addr */
>>   		ctx->cleanup_addr = proglen;
>> +		/* Where an unwind sends a frame with no pad. */
>> +		bpf_prog->aux->epilogue_ip = (u64)image + proglen;
> Eduard Zingerman raised an optimization suggestion in v5: use register
> liveness information at landing pads to avoid spilling all registers
> unnecessarily. The suggestion was to use register liveness information
> at call sites and collect a union of registers alive at landing pads for
> all callers of this particular function.
>
> You acknowledged and said you would try to fix it to avoid saving
> unnecessary callee saved registers. However, the current v6
> implementation still appears to unconditionally spill registers for
> exception_boundary programs without optimizing based on which registers
> are actually live at landing pads.
>
> Note: v6 significantly changed the implementation approach from v5, so
> this suggestion may need re-evaluation in the context of the new design.
> Does this optimization still apply, or does the new design address this
> differently?

Alexei suggested a new approach in v6.

>
>>   		if (bpf_prog_was_classic(bpf_prog) &&
>>   		    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>>   			if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
> [ ... ]
>
>> @@ -4614,6 +4629,24 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
>>   #endif
>>   }
>>
>> +void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp, u64 *ra),
>> +			    void *cookie)
>> +{
>> +#if defined(CONFIG_UNWINDER_ORC)
>> +	struct unwind_state state;
>> +	unsigned long addr, *ra;
>> +
>> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
>> +	     unwind_next_frame(&state)) {
>> +		addr = unwind_get_return_address(&state);
>> +		ra = unwind_get_return_address_ptr(&state);
>> +		if (!addr || !ra ||
>> +		    !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 *)ra))
>> +			break;
>> +	}
>> +#endif
>> +}
> arch_bpf_stack_walk_ra() pairs the unwinder's recovered return address
> with the raw stack slot. On x86 ORC, unwind_next_frame() does
>
> arch/x86/kernel/unwind_orc.c:unwind_next_frame() {
>      ...
>      state->ip = unwind_recover_ret_addr(state, state->ip, (unsigned long *)ip_p);
>      ...
> }
>
> which turns return_to_handler (function_graph / fprobe exit on fgraph)
> or the rethook trampoline (kretprobe) back into the original caller
> address. But unwind_get_return_address_ptr() returns `(unsigned long
> *)state->sp - 1`, i.e. ip_p itself, and that slot still holds the
> tracer's trampoline address. Nothing checks that *ra == addr before
> handing ra to the consumer.
>
> bpf_unwind() is a normal __bpf_kfunc in kernel/bpf/helpers.c with no
> notrace, so function_graph, kretprobe:bpf_unwind, or a kprobe.multi
> return probe can hook its return. In that case the prologue replaces the
> slot holding bpf_unwind's return into the BPF program. Then:
>
>    bpf_unwind() -> arch_bpf_stack_walk_ra() -> bpf_unwind_rewrite()
>      cnt == 1 frame, and the bpf_unwind call is covered by a cleanup record
>      (mark_call_sites() marks bpf_is_unwind_kfunc() calls)
>      -> *ra = rec->pad;   /* overwrites return_to_handler / rethook trampoline */
>
> bpf_unwind() then returns straight into the pad and skips the tracer's
> return trampoline. Its fgraph ret_stack entry (or rethook node) is left
> behind. The next hooked function further up that returns through the
> trampoline pops that stale entry.
>
> For fgraph, ftrace_pop_return_trace() has no frame-pointer check on x86
> (HAVE_FUNCTION_GRAPH_FP_TEST is not defined there). For rethook,
> __rethook_find_ret_addr() picks the top node. Either way execution jumps
> to the old BPF address after the bpf_unwind call, running on a different
> function's stack, which leads to an oops or arbitrary control flow.
>
> The arm64 version of this same walker, added later in the series
> (8bd2af30a28e "bpf, arm64: Dispatch exception cleanup pads at run
> time"), handles exactly this case:
>
> arch/arm64/net/bpf_jit_comp.c:arch_bpf_stack_walk_ra() {
>      ...
>      if (state->flags.fgraph || state->flags.kretprobe)
>          return false;
>      ...
> }
>
> Its changelog says: "a frame whose return the function graph tracer or a
> kretprobe has hooked holds the tracer's trampoline in its slot rather
> than the address the unwinder reports, so the walk stops there." The x86
> walker has no such check, and no later commit in the series touches
> arch/x86/net/bpf_jit_comp.c.
>
> Should the x86 version also check state flags or compare
> READ_ONCE_NOCHECK(*ra) against the value the unwinder read, and stop the
> walk when they differ?

Okay, will do this since arm64 has a different guard.

>
>> +
>>   void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
>>   			       struct bpf_prog *new, struct bpf_prog *old)
>>   {
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

