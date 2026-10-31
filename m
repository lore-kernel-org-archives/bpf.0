Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486235;
	b=uI3It1TrhSX0wlfBPfVoJTFLSG1lO61fnjvqOXJoUee7f0cCIhPMXHWwmo34vhx0XGOU
	 1/W3Ucdx80tlDFybSswieAWMiPyZJyHKKmfvF56Zson/ESQJ2hRwwt0v0qE6WW945/tpl
	 nz/zmIMNv3BBpJkQtMo9dti8fkvbeuzWlIsnaSPH7ZnAK9kzynt8z8LrIAKQEyh8ba/A7
	 5HSiB+40MwbgUJxdAmEsIvGXfkel5oWJV6m0g4jXxTU0Ig3rTF6vbEo+/A7hyfnXoAkJv
	 uTcRaoKl4lOX5/lVbbgwuIcusiy2HQPWPwSk7ODi5EmY04v0tIW2bwea+52ufP+dXXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486235;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=3V+G99mf0mZJVX2bsANp32lmmuQTTNG42VRqGNz+0R4=;
	b=pkk9cPeQAkAtsqSWoLggpVAU4HqKb7wBzHPveMnvG0C9ywOicSdSIGGnUYuIGEtDPOgf
	 iCVBIb0TpWXXootWO7vkXqpWtpSL9fqzn8RJ/SHzzCGB8leiuKcOP7eWU3tlO1+FP+/Q5
	 mMLjgbutKkt/raauodX2my/410jDzhplvHXBCqpxUR8jxzMnXijB13M4KuOxatdoSbgMh
	 5UCRLggJv206GFxU2EtY/GqTUfZSNpzM2IgXTcF3+eLZA5DTzLu/5W2R3JP8Q0KwGYBOn
	 H9AohNOMczp513aEiEMKlR7xhJuTU2OmXhuhTCRcsq4ASsSsTcuBxS+F6TueJUyVQwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcjLmMcX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CA606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcjLmMcX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D991F000C1;
	Sat, 31 Oct 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486234;
	bh=3V+G99mf0mZJVX2bsANp32lmmuQTTNG42VRqGNz+0R4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CcjLmMcXL80Gqnqu8Zoq1falrXpq/JxD6mV3FPfmuTxysJPIzxcjEkti5q5RucKE/
	 SQIaoWFVxzuJo4aCmZ/G6hLHNBlE3wWbcZe+A4zFkixxEwaesLHMhcLn73Ak+vdVBk
	 7PFXamHyy7sWdk0D7yBX9+qx1xmRpqjSsE608NcznsdHWngmjkOjTfWLoBSRTfMJKy
	 e7pBUNgpDT15Em+gbnWPIZCk8sqv7mszBgdrv9zxnmZwO+tLXBM1q7WuuxPCsKKtQh
	 gTJaMqypE8z4jtYXv08vuSrN4lwthBGbb2AiI7J5/OdOTS+Da+B+hZqiVVYRWMh1eG
	 zzYsMreHWNmrQ==
Content-Type: multipart/mixed; boundary="===============1416503460861640838=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <73b8a2912eb3c15e4721bb685bf2231afec7537b620367e257ee1a0d41058a19@mail.kernel.org>
In-Reply-To: <20261031215543.682284-8-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf v2 7/9] bpf: One may_goto time slice per prog invocation
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 22:37:14 +0000 (UTC)

--===============1416503460861640838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: One may_goto time slice per prog invocation

TL;DR: Each main-prog entry resets the shared per-cpu may_goto state, so a
nested invocation (or one interrupting an async callback) may restart the 250
ms slice repeatedly, letting loops spin unbounded and causing soft lockups.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 5cbab55d84be..66b9d1d9e961 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -2734,24 +2767,36 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>
>  	env->prog->aux->stack_depth = subprogs[0].stack_depth;
>  	for (i = 0; i < env->subprog_cnt; i++) {

[ ... ]

> +		/* an invocation begins, see bpf_timed_may_goto_save() for async callbacks */
> +		bool main_prog = tmg && !i;

[ ... ]

>  		stack_depth = subprogs[i].stack_depth;
>  		if (timed_may_goto) {
> +			struct bpf_insn ld_tmg[] = {
> +				BPF_LD_IMM64(BPF_REG_0, (__force unsigned long)tmg)
> +			};
> +			int count_off = offsetof(struct bpf_timed_may_goto, count);
> +			int timestamp_off = offsetof(struct bpf_timed_may_goto, timestamp);
> +			int owner_off = offsetof(struct bpf_timed_may_goto, owner);
> +
> +			/* R0 has nothing at the entry */
> +			insn_buf[cnt++] = ld_tmg[0];
> +			insn_buf[cnt++] = ld_tmg[1];
> +			insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
>  						     BPF_MAX_TIMED_LOOPS);
> +			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
> +			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);

Can a nested invocation of the same prog extend the time slice of the
invocation it interrupted without bound?

Every entry into the main prog now writes count = BPF_MAX_TIMED_LOOPS and
timestamp = 0 into the per-cpu struct bpf_timed_may_goto that is shared with
every other invocation of that prog on the same CPU, and nothing puts the
old values back when that invocation returns.  Only the async callers,
bpf_timed_may_goto_save() and bpf_timed_may_goto_restore(), save and
restore.

bpf_check_timed_may_goto() treats timestamp == 0 as "start a new 250 ms
window", so after each nested entry the interrupted loop gets a full new
slice.  If nested entries keep coming more often than every 250 ms, the
interrupted loop never reaches the timeout.  Before this patch the count
and timestamp were in the stack frame of each invocation, so nesting could
not touch them.

There are two ways the same prog can nest on one CPU.

First, an async callback interrupted by the main prog.  bpf_timer_cb()
(softirq), bpf_wq_work() (kworker, migration disabled) and
bpf_task_work_callback() run callback_fn without taking prog->active.  So
bpf_prog_get_recursion_context() in __bpf_trace_run(), or the trampoline
recursion check, does not stop a main invocation of the same prog from
running in hardirq or softirq on top of the callback.  Each such entry runs
the prologue above, which sets owner = 0 and resets count and timestamp.
The callback's while (can_loop) loop then starts over, and its restore is
skipped because cur->owner != &saved.  Example: a tp_btf prog on a frequent
hardirq tracepoint with a bpf_timer callback, or an XDP prog with a bpf_wq
callback while traffic arrives on that CPU.

Second, main over main, for prog types without per-prog recursion
protection.  For example, a cgroup_skb egress prog runs from process
context with BH enabled (bpf_prog_run_array_cg() only does
migrate_disable() and rcu_read_lock()) and also from softirq (TCP ACKs and
retransmits, or ingress when the same prog is attached there too).

In both cases the outer loop can spin with no bound.  On
PREEMPT_NONE/VOLUNTARY that is the soft lockup this commit is meant to
prevent.

The commit message says "A second invocation of the prog on the same cpu
gives more time to the first one".  But each nested entry restarts the
whole window, so the extra time is unbounded, not a one-off extension.  The
later commit 954996f5c8be ("bpf: End bpf_loop() when the time of may_goto
is up") in the same series does not change this.

Should the main prog entry save and restore the state the way the async
callers do, or only reset it when no invocation owns the state?

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 58e357302850..2b75f7ba07a5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1222,6 +1222,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  {

[ ... ]

> @@ -1242,8 +1244,10 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>
>  	key = map_key_from_value(map, value, &idx);
>
> +	bpf_timed_may_goto_save(prog, &saved);
>  	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
>  	/* The verifier checked that return value is zero. */
> +	bpf_timed_may_goto_restore(prog, &saved);

Does the save/restore pair here protect the callback from an invocation of
the main prog that interrupts it?

Before this patch an async callback subprog containing may_goto set up its
own count and timestamp in its own stack frame, so nothing else could reset
them and its loops ended after 250 ms.  After this patch the callback has
no prologue.  It uses the per-cpu prog->aux->timed_may_goto that
bpf_timed_may_goto_save() resets here, and the first insns of the main prog
of the same prog write to that same memory on every invocation
(bpf_do_misc_fixups(), the main_prog prologue):

    insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off, BPF_MAX_TIMED_LOOPS);
    insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
    insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);

The save/restore pair protects an invocation that the callback interrupts.
It does not protect the callback from an invocation of the main prog that
interrupts it.  Each such invocation sets timestamp back to 0, and
bpf_check_timed_may_goto() then just takes a new timestamp:

    if (!p->timestamp) {
        p->timestamp = time;
        return BPF_MAX_TIMED_LOOPS;
    }

So if the prog is invoked on the CPU at least once every 250 ms while the
callback is looping, the time check never fires and the loop never ends.
Nothing stops this nesting: bpf_timer_cb() increments neither
bpf_prog_active nor prog->active, so trace_call_bpf() and
__bpf_prog_enter_recur() let the same prog run in hardirq while its timer
callback is running in softirq.

Example: a kprobe or fentry prog P on a function in the tick or irq path
(bpf_timer_* are in bpf_base_func_proto, and nothing in the verifier keeps
tracing progs from using timers any more) arms a timer whose callback runs
while (can_loop) {...}.  The tick invokes P every 1-4 ms on that CPU, the
callback loops forever in HRTIMER_SOFTIRQ, and the result is a soft lockup
or an RCU stall.  That is the failure this patch is meant to fix.

The same applies to the other three callers changed in this file:

- bpf_wq_work() and bpf_task_work_callback() run in task context with BH
  enabled.  A TC or XDP invocation of the same prog in NET_RX softirq on
  that CPU resets the state on every packet (common_kfunc_set, which holds
  bpf_wq_* and bpf_task_work_*, is registered for BPF_PROG_TYPE_UNSPEC).
  The kworker then runs forever with migration disabled and
  rcu_read_lock_trace held: a soft lockup on non-preemptible kernels, and a
  tasks-trace RCU stall on any kernel.

- bpf_rcu_run_callback() has the same problem with hardirq invocations.

The commit message says "A second invocation of the prog on the same cpu
gives more time to the first one", but with periodic invocations the extra
time has no bound.  Neither 954996f5c8be ("bpf: End bpf_loop() when the
time of may_goto is up") nor 837f057a25f6 ("selftests/bpf: Test one
may_goto time slice per prog invocation") later in the series changes this.

Should an async callback be protected from main-prog invocations too?  For
example, the main prog prologue could leave count and timestamp alone while
owner is set, or the async callers could mark the prog as active so that a
nested invocation of it is skipped.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41246505049
--===============1416503460861640838==--
