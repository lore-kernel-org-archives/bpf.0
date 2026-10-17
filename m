Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761652E266C;
	Sat, 17 Oct 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257445; cv=none; b=orvlUxbz9OpRRx5apE9QEzRvedrK2YIz5M7OIy1iCrYtULXRfkX6Ip7JfJsWFs4GTitkcnerUeR+RlytDgVxdf+4HIcq9T1TPDCQrMfrH4xxyvFvjSLAgDlMbPg7ycFjYjiU2j4nx3WVLFtSYSe2tazlEaRfCU8QDIbKuw0GmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257445; c=relaxed/simple;
	bh=agg6kSA5A1TJKFbdCXfcyeVtWdACev3CUNtBFxbiGPw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hQm15e2LahHXyTEdHMpOB/X/impf4fiO1SJPqCVNdnzzByTICI2UJj7f6+Yzt5C3cum9bjCSZYQ36ZiIh5a0o4afNnF+MR7L9k2KT7E2wRaTiv7UoCulCjl+rBuLuN2ar69A58D/v++04VudSCo+anGAJAdkbdYNOjtjBkqSeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjojCDGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjojCDGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E1B1F000C4;
	Sat, 17 Oct 2026 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257444;
	bh=DdtFdMm6CuE8z0aS3OG6NS2bFb3i4ms5iebYVmRrVQ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mjojCDGaLyZIXU1mklqTRSaGs3FUEPw4kuqhqJkoWg83v9UVWYnd0GloWWHNlCLSp
	 zH14Kx9iaf6196vlyY6x3g9NWt+HnXs+KCLg5AQkJMXqQipAYjxapcAIQemt6A4Mg2
	 VIuUykMc1HQuxdMpNTzsfROEwtrcx/GhnxGUYQwRwbPiRMtRNZzRXxiLgypk5sxo1T
	 CoNDytEYbQJbqMQJbOLuZrYlzAyCUKo2ujtDorh7qlDJFRBWnpQtF/8tb/tznQx9zO
	 Kfq5+UbQ/NoFhG3SdlyeA/9vLa+Dc931O8QlSKdMzcqwNT5vf83aVgaUAiN1HJLtN2
	 N4SMghaOOZUUQ==
Content-Type: multipart/mixed; boundary="===============0715484792088937103=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <57305a277662e379e842afdc22aeb380e4114f06b5f0f7d9db1e16f8edaa6f45@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-34-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-34-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 33/43] bpf: Keep the symbols of a program until it has ended
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:22 +0000 (UTC)

--===============0715484792088937103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the symbols of a program until it has ended

TL;DR: Design question: kallsyms removal now happens after the RCU callback
frees btf and linfo, so a symbol lookup in that window might touch freed
memory. The review found no such reader.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e1216927373a..6e32db9777c2 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3085,12 +3085,40 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)

[ ... ]

> +static void bpf_prog_free_deferred(struct work_struct *work)
> +{
> +	struct bpf_prog_aux *aux;
> +	bool ksyms;
> +
>  	aux = container_of(work, struct bpf_prog_aux, work);
> +	/*
> +	 * A prog that still runs when its last reference goes needs its symbols,
> +	 * by which its exception table is found.  It has ended by now.
> +	 */
> +	ksyms = aux->real_func_cnt || !list_empty(&aux->ksym.lnode);
> +	bpf_prog_kallsyms_del_all(aux->prog);
>  #ifdef CONFIG_BPF_SYSCALL
>  	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
>  #endif

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c412bcd1903f..ddb986324f2f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2461,6 +2461,8 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
>  	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
>  
>  	btf_put(aux->btf);
> +	kvfree(aux->jited_linfo);
> +	kvfree(aux->linfo);
>  	kvfree(aux->func_info);
>  	kfree(aux->func_info_aux);
>  	free_uid(aux->user);
> @@ -2485,10 +2487,7 @@ static void __bpf_prog_put_rcu_tasks(struct rcu_head *rcu)
>  
>  static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>  {
> -	bpf_prog_kallsyms_del_all(prog);
>  	module_put(prog->aux->mod);
> -	kvfree(prog->aux->jited_linfo);
> -	kvfree(prog->aux->linfo);
>  	kfree(prog->aux->kfunc_tab);
>  	kfree(prog->aux->ctx_arg_info);
>  	if (prog->aux->attach_btf)

A subsystem pattern flags the ordering here as potentially concerning, so
this is a question rather than a confirmed bug.

__bpf_prog_put_noref() still issues call_rcu() (or call_rcu_tasks() or
call_rcu_tasks_trace()) on &prog->aux->rcu:

	if (deferred) {
		if (IS_ENABLED(CONFIG_TASKS_RCU) && prog->aux->tramp_linked)
			call_rcu_tasks(&prog->aux->rcu, __bpf_prog_put_rcu_tasks);
		else if (bpf_prog_runs_sleepable(prog))
			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
		else
			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
	}

but with bpf_prog_kallsyms_del_all() gone from this function, aux->ksym is
still linked in the RCU-protected bpf_tree latch tree and the bpf_kallsyms
list when the callback is queued.

The removal now happens in bpf_prog_free_deferred(), which is a work item
scheduled from inside the callback chain:

__bpf_prog_put_rcu()
  bpf_prog_free()
    schedule_work()
      bpf_prog_free_deferred()
        bpf_prog_kallsyms_del_all()

In between, __bpf_prog_put_rcu() has already done:

	btf_put(aux->btf);
	kvfree(aux->jited_linfo);
	kvfree(aux->linfo);
	kvfree(aux->func_info);
	kfree(aux->func_info_aux);

and bpf_prog_free() has dropped aux->dst_prog and aux->token.

Can a tree reader that runs after the grace period but before
bpf_prog_free_deferred() still get the prog from bpf_prog_ksym_find() and
then dereference those fields?  For example:

dump_stack_cb()
  bpf_prog_get_file_line()
    prog->aux->btf, prog->aux->linfo, prog->aux->jited_linfo

The final free of aux and of the JIT images does look to be behind the
second grace period from queue_rcu_work(), so the exposure would only cover
the fields freed in __bpf_prog_put_rcu().

Looking at the callers of bpf_prog_ksym_find() that go past the ksym
fields (search_bpf_extables(), dump_stack_cb(), find_from_stack_cb(),
bpf_stack_walker(), bpf_prog_report_arena_violation()), they resolve
either the IP of a frame on the current stack through arch_bpf_stack_walk()
or the faulting IP.  In both cases the program is still running, so the
grace period chosen in __bpf_prog_put_noref() should not have finished.

The name-only readers (bpf_address_lookup(), bpf_get_kallsym(),
is_bpf_text_address(), bpf_has_frame_pointer()) read only aux->ksym, which
stays valid until the extra grace period.  I did not find a reader that
reaches the freed linfo or btf for a program that is not running.

Is the ordering of call_rcu() before the ksym removal intended, given that
the pattern of queueing an RCU callback on an object that is still
reachable through an RCU-protected structure is normally treated as a bug?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============0715484792088937103==--
