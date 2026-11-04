Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783432;
	b=KS1P2/j7m0Hh7Y08t1sMrd+xE8leC3mioTSINiX/8oujYZCt5K34wFvx4LzatMqI11j2
	 o2DvF0riJqXnRyON+gc6a9YE5Wyzg6nfH59+9+aSh05Pn2QQSGhxxmyikQ5P4tBgdErj6
	 dlpANzCjvTPns4SeU76p+HJqvSvPhYMnhqG2glVCNSX8yN/vmXfQPknGpdVI8qKHQ/6aC
	 gb6eI5RxruCxvkH91+1rLa0VViCf5x6/y0WXGMeyg4cM00w8NlkFtQGZAmo1huVTwIeBB
	 WNe+DhvV14NKgW1jCMx9tdjKaZIiYTwW/3PnQ0VNCAL767M48d9PLkkxEw6/Dvd/6Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783432;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=em6h4WnLgw+w4kteMHbh9nKlW/3d5rmAYZtIrKSmPLk=;
	b=IgKlwFOBuAy22gyFv1WJpN3PCg8CKgr5HYgqHJPwCdVIE0Dt1EqONShIH/76v3FVBuOV
	 BdwTFFXkoYObi5L7VReZRDpQunmkaTtc3YMV+WIWevMIRjMZ/XEd4naAR4YhKpv54K1NX
	 FYP6GuL56B1r8Baat1e6XMc7829Pqlo8L7hGNDmNqWeWyOQaHonISGxO6/lmp6eE5MkG7
	 NzrE5/fFkikso62fP2aJs34Ds18XBWAtz8wsm41T4DhgBbrHpUeCRXj/i89q+58pxlrr6
	 OWe729m7pjlIG3O88JNxsHysKjJLgCuOY6E9li5sBkJkjvRDJuEdH4+QOLmceCVUZSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtMWR7bh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52502606A31B;
	Wed,  4 Nov 2026 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtMWR7bh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2BB1F000C1;
	Wed,  4 Nov 2026 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783431;
	bh=em6h4WnLgw+w4kteMHbh9nKlW/3d5rmAYZtIrKSmPLk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jtMWR7bhay/jxUPW/zLFNPHnNDp4dWjLVt4zWHx4WUi23G03FIqU68jSxbO/JqJpD
	 oKiAGQZy6+Z9ijI4weWheuqQtJa+QnyZmiZ2T7/tUn3dNJEGrIzIVNg59VZnRGTKul
	 6tPvfZXQmmSbDYGCFONROeOdocsfXjnogNh1DLvU37fBohuDz75irD5xYbiDOEgjOR
	 LG6rEmx6KUKJobIuPxjV0gLZNfbeUntZvsXcpBxFSriFz0wR5XzWUimyDpCsc/lvY0
	 OHouPfX64AOwz5OFi8C5gxMD07+OhuOBkupaJ0OZSALBy/1nhylUTXhGbCNbFOQ3LL
	 7dNNMM4slebqg==
Content-Type: multipart/mixed; boundary="===============8566523327945068606=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <aaddd3482ab576e9381e2fa2ac1c13fff783075e5b44cca4f1b5bb3667050d50@mail.kernel.org>
In-Reply-To: <20261104083833.971911-1-yangfeng59949@163.com>
References: <20261104083833.971911-1-yangfeng59949@163.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add sleepable version of bpf_get_stack in tracing_prog_func_proto and tp_prog_func_proto
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,kpsingh@kernel.org,matt@bobrowski.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 09:10:31 +0000 (UTC)

--===============8566523327945068606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add sleepable version of bpf_get_stack in tracing_prog_func_proto and tp_prog_func_proto

TL;DR: Commit message and a code comment only: they say
bpf_get_stack_sleepable() uses build_id_parse(), but it appears to use
build_id_parse_file(), and the bpf_spin_lock() rejection claim looks wrong,
since locks already reject helper calls.

> bpf: Add sleepable version of bpf_get_stack in tracing_prog_func_proto and tp_prog_func_proto
>
> bpf_get_stack() has two implementations.  bpf_get_stack() passes
> may_fault == false and resolves build IDs with build_id_parse_nofault(),
> so an IP whose backing file page is not resident falls back to
> BPF_STACK_BUILD_ID_IP.  bpf_get_stack_sleepable() passes may_fault == true
> and uses build_id_parse(), which faults the page in and returns a real
> build ID.
>
> Only kprobe/uprobe programs are routed to the sleepable implementation
> today, so the other program types that can be sleepable keep losing
> build IDs for non-resident pages:
>
>  - tracing_prog_func_proto() serves BPF_TRACE_ITER, fentry/fexit/fmod_ret
>    and BPF_TRACE_RAW_TP programs, and falls back to
>    raw_tp_prog_func_proto() for BPF_FUNC_get_stack, which is also the
>    get_func_proto() of BPF_PROG_TYPE_RAW_TRACEPOINT and is reached by
>    BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL through the default cases
>    of bpf_lsm_func_proto() and syscall_prog_func_proto().
>
>  - tp_prog_func_proto() serves BPF_PROG_TYPE_TRACEPOINT programs.
>
> Route them to bpf_get_stack_sleepable() as well and mark the new
> prototypes might_sleep, following
> commit 9d02927fdf4e ("bpf: Mark faultable stack helpers as sleepable"),
> which did the same for bpf_get_task_stack() and uprobe programs.
>
> The verifier then rejects bpf_get_stack() from these program types
> whenever in_sleepable_context() is false: inside bpf_rcu_read_lock(),
> bpf_preempt_disable(), bpf_local_irq_save() and bpf_spin_lock() regions,
> and in callback subprograms running under rcu_read_lock().  This also
> covers calls that do not pass BPF_F_USER_BUILD_ID and would not sleep;
> such programs load today.  This is the same trade off that making the
> faultable stack helpers sleepable made for bpf_get_task_stack().
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>

Two statements here don't seem to match the code.

The changelog says bpf_get_stack_sleepable() "uses build_id_parse()", and
the new comment in bpf_get_stack_raw_tp_sleepable() says the slot "cannot
be held across the sleep that build_id_parse() may take".  Is that accurate?

With may_fault set, stack_map_get_build_id_offset() takes this path:

    if (may_fault && has_user_ctx) {
            stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
            return;
    }

and stack_map_get_build_id_offset_sleepable() calls build_id_parse_file(),
not build_id_parse().  The only build_id_parse() call is in
fetch_build_id(), reached from the mmap_read_trylock() loop that is never
entered when may_fault is set.  Should the changelog and the comment name
build_id_parse_file() instead?

The changelog also lists bpf_spin_lock() regions among those where
bpf_get_stack() is now rejected, and says such programs "load today".
Is that right?  While active_locks is nonzero, do_check_insn() already
rejects helper calls before check_helper_call() is reached:

    if (env->cur_state->active_locks) {
            ...
                    insn->imm != BPF_FUNC_spin_unlock &&
                    insn->imm != BPF_FUNC_kptr_xchg) ||
            ...
                    "function calls are not allowed while holding a lock\n");

so bpf_get_stack() inside a bpf_spin_lock() region is not accepted today
either, and this patch changes nothing for that case.  The user-visible
change appears limited to RCU, preempt-disabled and IRQ-disabled regions,
RCU callbacks, and non-sleepable async callbacks such as bpf_timer
callbacks.  Could the bpf_spin_lock() mention be dropped from the
changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41802507259
--===============8566523327945068606==--
