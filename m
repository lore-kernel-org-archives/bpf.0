Received: from mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D32877DE
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557702; cv=none; b=W2iMkkra4x8UHDlbASYxxGxz13pgDyeeYa3/D9PBamuhMFYSsZ4oZQ6s4b+NHfuwRxmkUcKJeFwuO4H5feldaX621wNCWBFaDXjGeX2ner1A4BurpwSNVlpI2gdQdUQVzOlymAlyzdlCPAK+0yPzgRh30x0iO4O0UAaJ6r5yQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557702; c=relaxed/simple;
	bh=Hg8hAJfKfAcK3ZW/+fuHjcyL6qj/9VtB2e8X7W6rU+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZ+RyXD7GcDRJjX1Ux13YoJUBe7ttJS6sVvu3r8GIqsjQcN99OwcokfSjD88fW1I8NkiobTF+TSFRVbMwBeXkZ0wwXPmbrgf8ZBDG9uydriDPTaeu5mLi36O2Bc1xPrXidyI9rFMi18bUc2vB0KP6nziZ/926iuZfcLg5RFfeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b2LUFocU; arc=none smtp.client-ip=91.218.175.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b2LUFocU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Hg8hAJfKfAcK3ZW/+fuHjcyL6qj/9VtB2e8X7W6rU+0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790557696; v=1; x=1791162496;
 b=b2LUFocUywxEok03K1pQjK1swIsa54VXy8GNGZLvVJAgCHGqmC95bi8QxPqaHiydlpyyc6aB
 lumWKZWd98qsXs/CBavI4AfP09rG3/ZVq4X+1guxqABsahMjvayFZi/4tXXyTug1MQgNw7mxq7c
 e1/tUYLydKtVOtY2LGRlej/U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1cc3a937fb38fd8f;
	Mon, 28 Sep 2026 01:08:15 +0000
X-Mizu-Trace-ID: 1cc3a937fb38fd8f
X-Migadu-Flow: FLOW_OUT
Message-ID: <2850d0a2-b293-4502-b14d-7552ce0b8cd6@linux.dev>
Date: Sun, 27 Sep 2026 18:08:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 10/21] bpf: Dispatch cleanup pads by rewriting
 return addresses
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050057.2217436-1-yonghong.song@linux.dev>
 <52fc5f40733390fb8ab1309d868744cef387c0c24b95df383a4dcf6c66a3fdb9@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <52fc5f40733390fb8ab1309d868744cef387c0c24b95df383a4dcf6c66a3fdb9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/27/26 1:40 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 4bae3796c42f..98de251037df 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
> [ ... ]
>
>> @@ -1885,6 +1928,8 @@ struct bpf_prog_aux {
>>   	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>>   	u16 stack_arg_sp_adjust;
>>   	u16 freplace_link_cnt; /* counts freplace links extending this prog */
>> +	struct bpf_exception_info *exc;
>> +	u64 epilogue_ip; /* native address of this (sub)program's epilogue */
>>   #ifdef CONFIG_SECURITY
>>   	void *security;
>>   #endif
> The commit message says epilogue_ip "is recorded for every program", but
> can a caller that only calls subprogs which always unwind end up with
> epilogue_ip still zero?
>
> Looking at bpf_exc_keep_exits(), it only patches an exit after
> bpf_unwind() kfunc calls:
>
> kernel/bpf/fixups.c:bpf_exc_keep_exits() {
>      for (i = 0; i < insn_cnt; i++) {
>          if (!bpf_is_unwind_kfunc(insn))
>              continue;
>          /* patch exit after call */
>      }
> }
>
> It doesn't patch exits after calls to subprogs that can only unwind.
> The verifier ends that path at the subprog's bpf_unwind()
> (process_bpf_unwind() returns PROCESS_BPF_EXIT), so code after the call
> is never seen and gets swept. If that was the caller's only exit, it
> never emits a BPF_EXIT, so the JIT never sets epilogue_ip.
>
> At run time bpf_unwind_rewrite() would then reach:
>
>      } else if (prog->aux->epilogue_ip) {
>          *ra = prog->aux->epilogue_ip;
>      } else {
>          WARN_ON_ONCE(1);
>          return false;
>      }
>
> with epilogue_ip still 0. The return address stays pointing just past the
> call, which is the end of the JIT image.
>
> Example: main calls a static subprog that only has `call bpf_unwind; exit`.
> With no cleanup table (or no record covering either call), the main frame
> would be redirected to epilogue_ip, but that field was never set.

Yes, this is indeed a bug. Will fix to find at least one 'exit'.

>
> [ ... ]
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index d813fdde29e3..60905643cb9c 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> [ ... ]
>
>> @@ -3511,6 +3523,12 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
>>   {
>>   }
>>
>> +void __weak arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp,
>> +						      u64 *ra),
>> +				   void *cookie)
>> +{
>> +}
>> +
>>   bool __weak bpf_jit_supports_cleanup_pads(void)
>>   {
>>   	return false;
> Does bpf_unwind() produce correct behavior on architectures that keep this
> weak stub?
>
> At this commit no architecture implements the walker. At the end of the
> series only x86-64 with CONFIG_UNWINDER_ORC and arm64 do. x86 with the
> frame-pointer unwinder, riscv, s390, powerpc and loongarch keep the stub.
>
> Nothing stops those architectures from using bpf_unwind():
>
> - It is in generic_btf_ids, registered for TRACING, SCHED_CLS, XDP,
>    STRUCT_OPS, SYSCALL, CGROUP_SKB and others.
>
> - bpf_prepare_cleanup_exceptions() only checks bpf_jit_supports_cleanup_pads()
>    when a table was supplied:
>
>        if (!env->cleanup_info_cnt)
>            return 0;
>
> - An uncovered call is a terminator for the verifier:
>
>        if (pad < 0)
>            return PROCESS_BPF_EXIT;
>
> At run time the weak stub does nothing, so bpf_unwind() returns. The frame
> returns through the patched 'r0 = 0; exit'. Each caller then resumes at
> the instruction after its call, in a state the verifier never explored for
> that path, or in code the dead code sweep already removed.
>
> Concrete case: a static subprog that returns a checked non-NULL map value
> pointer on its normal path and calls bpf_unwind() on another path. The
> caller dereferences the returned pointer without a NULL check, since the
> verifier only saw the pointer-returning exit. At run time the subprog
> returns 0 and the caller writes through NULL in kernel context.
>
> The commit message says the separate entry point exists "so that the
> architectures which do not dispatch pads keep the walker they have."
> Does bpf_unwind() need to be gated on bpf_jit_supports_cleanup_pads(), or
> should the stub have a fallback that doesn't leave callers in unverified
> code?

Okay, you are correct. condition env->cleanup_info_cnt is not enough
to allow bpf_unwind() since bpf_unwind() typically won't be in cleanup
region. Will fix it by checking whether any function is might_unwind
or not.

>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index f291611fe578..ea5c4d81f8b7 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> [ ... ]
>
>> @@ -3424,8 +3426,51 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
>>   	return false;
>>   }
>>
>> +struct bpf_unwind_ctx {
>> +	u32 cnt;
>> +};
>> +
>> +static bool bpf_unwind_rewrite(void *cookie, u64 ip, u64 sp, u64 bp, u64 *ra)
>> +{
>> +	const struct bpf_cleanup_range *rec;
>> +	struct bpf_unwind_ctx *ctx = cookie;
>> +	struct bpf_exception_info *exc;
>> +	struct bpf_prog *prog;
>> +
>> +	rcu_read_lock();
>> +	prog = bpf_prog_ksym_find(ip);
>> +	rcu_read_unlock();
>> +	if (!prog)
>> +		return !ctx->cnt;
>> +	ctx->cnt++;
>> +
>> +	exc = prog->aux->exc;
>> +	rec = (exc && exc->nr_ranges) ? bpf_exc_pad_for_ip(prog, ip) : NULL;
>> +	if (rec) {
>> +		*ra = rec->pad;
>> +	} else if (ctx->cnt == 1) {
>> +		/*
>> +		 * The frame that called bpf_unwind(). Its return address
>> +		 * always names the 'r0 = 0; exit' that bpf_exc_keep_exits()
>> +		 * put after the call, so leave it alone and let the frame
>> +		 * return through that: running it is what sets the value
>> +		 * the unwind returns.
>> +		 */
>> +	} else if (prog->aux->epilogue_ip) {
>> +		*ra = prog->aux->epilogue_ip;
> Does sending a frame to epilogue_ip work correctly when the verifier
> treats the resume as returning to the instruction after the call?
>
> At run time, a caller frame whose call site no cleanup record covers is
> sent to aux->epilogue_ip, so it returns straight away. The verifier does
> not model that: it treats a pad's bpf_unwind_resume() as an ordinary return
> into the caller, at the instruction after the call. The code after the call
> is therefore verified but never runs, and the return-at-once path is never
> checked.
>
> kernel/bpf/verifier.c:do_check_insn() with curframe > 0:
>
>      cur_func(env)->in_pad = false;
>      return process_bpf_exit_full(env, do_print_state, false);
>
> process_bpf_exit_full(..., false) goes to prepare_func_exit(), which
> continues the caller at callsite + 1 with r0 known to be zero. Only a
> covered call site gets its pad pushed as another branch
> (push_cleanup_pad_branch()). Nothing requires a call to a might_unwind
> static subprog to be covered, and bpf_exc_check_insn() only restricts global
> subprogs while an unwind is in flight.
>
> Concrete case (x86-64 with ORC, or arm64, at the end of the series):
>
>      main:  t = bpf_task_acquire(p); if (!t) return 0;
>             sub();                 /* call site not covered */
>             bpf_task_release(t); return 0;
>      sub:   bpf_unwind();          /* covered by a record in sub */
>             pad: bpf_unwind_resume(0);
>
> The verifier accepts this because it walks main past the call and sees the
> release. At run time sub's pad runs, resumes, and returns into main's
> epilogue, so the task reference is leaked.
>
> The same shape with bpf_rcu_read_lock()/unlock(), preempt disable/enable,
> or bpf_spin_lock()/unlock() leaves the lock held when the program returns.
> Static subprog calls are allowed under a spin lock, and the bpf_unwind
> check comes before the active_locks check. bpf_spin_lock is taken with IRQs
> disabled, so the next locker deadlocks.
>
> Does the verifier need to model the epilogue_ip redirect for uncovered
> callers, or should uncovered calls be refused when the callee might unwind?

I think proper resource checking at every level is needed.

>
> ---
>
> On x86-64 with a private stack, does this redirect skip the pop r9 that
> follows the call?
>
> With a private stack, the JIT wraps every call in push_r9/pop_r9
> (arch/x86/net/bpf_jit_comp.c). When bpf_unwind_rewrite() sets
> `*ra = prog->aux->epilogue_ip` for a caller frame, the callee's ret lands
> on the epilogue with the pushed r9 still on top of the stack. The epilogue
> is `add rsp, outgoing_rsp; pop_callee_regs(); leave; ret`.
> pop_callee_regs() therefore pops the saved r9 into the first callee-saved
> register and shifts the rest by one slot. leave then fixes rsp, so the
> function returns normally, but with the kernel caller's rbx/r13/r14/r15
> corrupted.
>
> check_max_stack_depth() refuses a private stack only when a table is
> present:
>
>      if (env->cleanup_info_cnt)
>          priv_stack_mode = NO_PRIV_STACK;
>
> Its own comment describes this exact problem for pads ("on x86-64 that
> skips the pop which restores r9"). A table-less program can still reach the
> redirect.
>
> Example: an fentry or kprobe program whose main prog uses at least
> BPF_PRIV_STACK_MIN_SIZE bytes of stack and holds a value in r6 across a
> call to a static subprog that calls bpf_unwind(). This applies on x86-64
> with ORC after the x86 enablement patch. Should the refusal cover
> might_unwind programs, not only programs with a table?

Yes, we should refuse might_unwind programs with private stack.

>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 677bab92f624..f2a59716fdab 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -22781,6 +22781,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>>   		/* program is valid, convert *(u32*)(ctx + off) accesses */
>>   		ret = bpf_convert_ctx_accesses(env);
>>
>> +	if (ret == 0)
>> +		ret = bpf_exc_keep_exits(env);
> Do the exits this patch adds skip a struct_ops program's BPF-level
> epilogue?
>
> bpf_convert_ctx_accesses() is the only place that epilogue is inserted:
> every BPF_EXIT in the main prog is replaced with the epilogue or a jump to
> it (fixups.c, "Generate epilogue for the main prog"). But
> bpf_exc_keep_exits() runs after that pass and emits a plain
> `r0 = 0; exit` after every bpf_unwind() call. bpf_do_misc_fixups() runs
> later still and lowers each bpf_unwind_resume() to a plain `r0 = 0; exit`
> too. In the main prog, both of these exits go straight to the JIT's native
> epilogue. So does the `*ra = prog->aux->epilogue_ip` redirect in
> bpf_unwind_rewrite().
>
> Does this break bpf_qdisc? bpf_qdisc_gen_epilogue()
> (net/sched/bpf_qdisc.c) adds a call to bpf_qdisc_reset_destroy_epilogue()
> to every .reset and .destroy program. That call is the only thing that runs
> qdisc_watchdog_cancel(&q->watchdog), and bpf_qdisc_validate() requires
> .reset and .destroy to be BPF programs for exactly that reason.
> bpf_unwind() is in generic_btf_ids, which is registered for
> BPF_PROG_TYPE_STRUCT_OPS with no filter. With no cleanup table,
> process_bpf_unwind() simply returns PROCESS_BPF_EXIT, so no gating applies.
>
> Failure path:
>
> 1. A .destroy program runs `if (cond) bpf_unwind();`.
>
> 2. On any arch, bpf_unwind() either leaves the first frame's return address
>     alone (bpf_unwind_rewrite(), cnt == 1) or does nothing (the weak
>     arch_bpf_stack_walk_ra()). Either way the frame returns through the
>     `r0 = 0; exit` that bpf_exc_keep_exits() inserted, which is not the
>     gen_epilogue.
>
> 3. qdisc_watchdog_cancel() never runs, so an hrtimer that .enqueue armed
>     through bpf_qdisc_watchdog_schedule() stays armed inside
>     qdisc_priv(sch).
>
> 4. The qdisc is freed, the timer fires, and qdisc_watchdog()
>     (net/sched/sch_api.c) dereferences wd->qdisc in freed memory. The
>     hrtimer base also still links the freed timer.
>
> The same bypass happens when a .reset/.destroy main prog resumes from a
> landing pad (lowered resume), or when a covered or uncovered subprog unwinds
> and the main frame is sent to epilogue_ip.
>
> Should bpf_unwind()/cleanup tables be rejected for programs whose
> verifier_ops has a gen_epilogue, or should these exits be inserted before
> bpf_convert_ctx_accesses() and point epilogue_ip at the BPF-level epilogue?

Indeed, for such cases, we should disable cleanup exceptions to avoid
early return for qdisc epilogue.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

