Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C8235045
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788583157; cv=none; b=C5E4Y6oXOI5dV7/Z9APwDcEU9cd5u/V0msuxTaamM54kmDf2RzSrpoPFe5yGSy72GVJ5dXmJ1p5v+/NFDYvTLz/3RnwA4rxJW9ytoKK4v1A7N/CkNWyMb27y/AgrgHt8W2yVgo18oxEqkAvExRXxCYSn54otZp+bqqD2zsJmLeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788583157; c=relaxed/simple;
	bh=4qU7d7Kwin4JiDfDNvFMOMhpb+xMrSnoMgF1UogpnPI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cw0o/Ghyv64NGfysH3XQ/mVceRuTooKAdYfKvJFUWF5u8UkAgiH9kQMl3YpCoGLwFp0jUKjQW3Ij3e9aiwk+ti/GMVNsLiyh7sKTjsyQ4OpGbYBiPQTHoHsVfD/nVvqbMOCbnjCPbAuuNlj4h4rUB2nlP831PJjffmBcdFh1NPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtWwshjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtWwshjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5200C1F00A3D;
	Sat,  5 Sep 2026 04:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788583156;
	bh=dLE9YFjE3CV2Y23T7LUl4uCiYrCk8oaVWberoLn8scE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FtWwshjXZPmVhpBIh6xGUG5s1bR+I/vRhTfx4vnFxmaZBlF8ROfkPe0lbC3cjKlQq
	 /u1+Ivk2s26OAhIRLYrgwh0QxAYIpro0i4KDNBVBeJR0Y5EjwkkbtRvbu0HV4cJFzB
	 +Qf71A6UoXaf+qIg+r3l0gbd2jIFcWmMwrIW825recpm69VxF7T59Zj8F6ppqQCT2I
	 ZU7L777s8YZBheW7MLxyzm1g1wQPytU4XWpRqs8evex1E+G51b/sJX6q2AOL+UMzGk
	 4E7mtYPQLkNP2hNDhF9IFkxgzGE+hI/mn372sUGWyvlX4RfF3UB+ntb7K3GB3hj2Nk
	 Asw0+Gj2arWYQ==
Content-Type: multipart/mixed; boundary="===============8407984580853000084=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2fc54e3d38f0f3ef2f419f35678a35d39a498c6ee8d8be6358a3a7ca5bb24587@mail.kernel.org>
In-Reply-To: <20260905034018.2095649-3-memxor@gmail.com>
References: <20260905034018.2095649-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test global subprog callback contexts
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 04:39:15 +0000 (UTC)

--===============8407984580853000084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> index 6bf95550a024..9ce7359913f8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> @@ -9,6 +9,11 @@
>
>  char _license[] SEC("license") = "GPL";
>
> +struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
> +void bpf_task_release(struct task_struct *p) __ksym;
> +void bpf_rcu_read_lock(void) __ksym;
> +void bpf_rcu_read_unlock(void) __ksym;
> +
>  /* Timer tests */
>
>  struct timer_elem {

[ ... ]

> @@ -66,6 +71,7 @@ int timer_sleepable_prog(void *ctx)
>
>  struct wq_elem {
>  	struct bpf_wq w;
> +	struct task_struct __kptr *task;
>  };
>
>  struct {

[ ... ]

> @@ -119,6 +125,105 @@ int wq_sleepable_prog(void *ctx)
>  	return 0;
>  }
>
> +__noinline int wq_global_acquire(void)
> +{
> +	struct task_struct *task, *acquired;
> +	struct wq_elem *val;
> +	int key = 0;
> +
> +	val = bpf_map_lookup_elem(&wq_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	task = val->task;
> +	if (!task)
> +		return 0;
> +
> +	acquired = bpf_task_acquire(task);
> +	if (acquired)
> +		bpf_task_release(acquired);
> +	return 0;
> +}
> +
> +static int wq_global_rcu_cb(void *map, int *key, void *value)
> +{
> +	return wq_global_acquire();
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +__failure __msg("R1 must be a rcu pointer")
> +int wq_global_rcu_prog(void *ctx)
> +{
> +	struct wq_elem *val;
> +	int key = 0;
> +
> +	val = bpf_map_lookup_elem(&wq_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_wq_init(&val->w, &wq_map, 0);
> +	bpf_wq_set_callback(&val->w, wq_global_rcu_cb, 0);
> +	return 0;
> +}
> +
> +static int wq_global_rcu_lock_cb(void *map, int *key, void *value)
> +{
> +	int ret;
> +
> +	bpf_rcu_read_lock();
> +	ret = wq_global_acquire();
> +	bpf_rcu_read_unlock();
> +	return ret;
> +}

Does wq_global_rcu_lock_cb() verify with this return value?

Workqueue callbacks must return exactly 0. When bpf_wq_set_callback is
processed, the callback's return range gets constrained to [0, 0] in
set_timer_callback_state() via:

kernel/bpf/verifier.c:set_timer_callback_state() {
    ...
    callee->callback_ret_range = retval_range(0, 0);
    callee->in_async_callback_fn = true;
    ...
}

Later when the callback returns, check_return_code() enforces this:

kernel/bpf/verifier.c:check_return_code() {
    ...
    if (frame->in_async_callback_fn) {
        range = frame->callback_ret_range;
        goto enforce_retval;
    }
    ...
}

A call to a global subprogram leaves R0 as an unbounded scalar. In
check_func_call(), the bpf_subprog_is_global() path does:

kernel/bpf/verifier.c:check_func_call() {
    ...
    if (bpf_subprog_is_global(env, subprog)) {
        ...
        mark_reg_unknown(env, caller->regs, ret_regs[0]);
        ...
    }
    ...
}

So returning ret here only verifies because the compiler constant-folds
wq_global_acquire()'s return to 0 (every path returns 0). The same issue
appears in wq_global_rcu_cb() above, which also returns the result of
wq_global_acquire().

If wq_global_acquire() ever gets a non-zero return path, or if the
optimizer doesn't fold it, wq_global_rcu_lock_prog's __success
annotation fails with "At async callback return the register R0 has ...
should have been in [0, 0]", and wq_global_rcu_prog's
__msg("R1 must be a rcu pointer") never appears because bpf_check()
runs do_check_main() before do_check_subprogs() and the callback's
return-code error aborts verification early.

The existing callbacks in progs/wq.c all return literal constants
(wq.c:wq_cb_sleepable() and wq.c:wq_cb()). Would
`wq_global_acquire(); return 0;` in both wq_global_rcu_cb and
wq_global_rcu_lock_cb remove the dependency on optimizer behavior?

> +
> +SEC("fentry/bpf_fentry_test1")
> +__success
> +int wq_global_rcu_lock_prog(void *ctx)
> +{
> +	struct wq_elem *val;
> +	int key = 0;
> +
> +	/* Verify the same global subprog in non-sleepable and protected contexts. */
> +	wq_global_acquire();
> +
> +	val = bpf_map_lookup_elem(&wq_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_wq_init(&val->w, &wq_map, 0);
> +	bpf_wq_set_callback(&val->w, wq_global_rcu_lock_cb, 0);
> +	return 0;
> +}
> +
> +__noinline int wq_global_no_rcu(void)
> +{
> +	return 0;
> +}
> +
> +static int wq_global_no_rcu_cb(void *map, int *key, void *value)
> +{
> +	return wq_global_no_rcu();
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +__success
> +int wq_global_no_rcu_prog(void *ctx)
> +{
> +	struct wq_elem *val;
> +	int key = 0;
> +
> +	/* Verify the same global in non-sleepable and unprotected contexts. */
> +	wq_global_no_rcu();

Can the calls to wq_global_no_rcu() get optimized away?

The function has an empty body (return 0), takes no arguments, is not
__weak, and its address is never taken. At -O2 (which selftests always
use via tools/testing/selftests/bpf/Makefile), LLVM can infer
memory(none)/willreturn/nounwind and constant-propagate the return
value. Both call sites then become dead: the direct call here (result
discarded) and the call in wq_global_no_rcu_cb() (whose result IPSCCP
replaces with 0). The __noinline attribute only blocks inlining, not
interprocedural attribute inference or DCE.

If the calls are elided, there is no relocation to the subprog, libbpf
never appends it to the program, check_func_call() never runs the
bpf_subprog_is_global() path:

kernel/bpf/verifier.c:check_func_call() {
    ...
    if (bpf_subprog_is_global(env, subprog)) {
        ...
    }
    ...
}

and do_check_subprogs() never calls do_check_common(env, subprog, 0) or
do_check_common(env, subprog, 1) for it:

kernel/bpf/verifier.c:do_check_subprogs() {
    for (i = 1; i < env->subprog_cnt; i++) {
        ...
        if (sub_aux->called[0])
            ret = do_check_common(env, i, 0);
        if (sub_aux->called[1])
            ret = do_check_common(env, i, 1);
        ...
    }
}

The test still passes __success because wq_global_no_rcu_prog loads
successfully, but it covers nothing. This is the only test that
exercises successful sleepable-root verification of a global subprog and
the caller-before-callee/repeat loop that patch 1/2 adds. The changelog
claims "call the same harmless global subprogram directly from the main
program and from an unprotected callback. This requires both
non-sleepable and sleepable verification roots and proves that global
calls from callbacks are not rejected wholesale", but this coverage
would silently not happen.

Searching progs/ for a zero-argument global subprog returning a constant
matches only the two functions this patch adds. Every other
plain-__noinline global subprog either takes pointer/scalar arguments or
performs memory accesses (so memory(none) cannot be inferred), and files
that need an opaque global subprog use __weak __noinline for this
reason:

progs/verifier_global_subprogs.c:__weak __noinline int noop_global_func()
progs/summarization.c:__weak __noinline int noop_global_func()

wq_global_acquire() survives only because it calls bpf_map_lookup_elem()
through the constant function pointer from bpf_helper_defs.h, whose
memory effects LLVM cannot infer.

Would declaring wq_global_no_rcu() as __weak __noinline, or giving it an
observable side effect, prevent the calls from being removed? This could
be confirmed by checking llvm-objdump -d on the compiled .bpf.o to see
if any `call -1` relocation to wq_global_no_rcu remains in
wq_global_no_rcu_cb.

> +
> +	val = bpf_map_lookup_elem(&wq_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_wq_init(&val->w, &wq_map, 0);
> +	bpf_wq_set_callback(&val->w, wq_global_no_rcu_cb, 0);
> +	return 0;
> +}

[ ... ]

> @@ -179,3 +284,29 @@ int task_work_sleepable_prog(void *ctx)
>  	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb);
>  	return 0;
>  }
> +
> +static int task_work_global_rcu_cb(struct bpf_map *map, void *key, void *value)
> +{
> +	return wq_global_acquire();
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +__failure __msg("R1 must be a rcu pointer")
> +int task_work_global_rcu_prog(void *ctx)
> +{
> +	struct task_work_elem *val;
> +	struct task_struct *task;
> +	int key = 0;
> +
> +	val = bpf_map_lookup_elem(&task_work_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	task = bpf_get_current_task_btf();
> +	if (!task)
> +		return 0;
> +
> +	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map,
> +				      task_work_global_rcu_cb);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33943332260
--===============8407984580853000084==--
