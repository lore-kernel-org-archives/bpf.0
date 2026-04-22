Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446A3446AD
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891472; cv=none; b=sbrjthWLIuzW3B7/ZgSBGZ5fWkr7fDHCGjXmrg5Dm3e5M54IXYsUY0Gyo0LoU71JlnhvzlnCH75VvbliWX/vb+elJ/xp7gP36bK7gOUdAyu0E46pM07k/Uz+7LuaIRUdAVHxiv/SKYLMEqoUxbOlH/d78dvLP/Btw1Y1OsFzFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891472; c=relaxed/simple;
	bh=1dg2cl6XpAjdSoScLHkc1XvzBpnl8qm8uO167b0bbq0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kx2yjuX7qn4MqjHP7PqxHZG7rCWqD1/DpInUjEh81zR77L/UwhmUfLxIaLvNuXNNMnVRcylkZWvr0k5pYkUzyjQXQnvC6JUAJTDWqvVvuUBNR2jcl1v8clPJm/POKqlejOYBhn1JaMRWZdS1LTKnbG5K8LGhkC7qcq0hUS+2OWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQUW2mB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQUW2mB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D33C19425;
	Wed, 22 Apr 2026 20:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776891472;
	bh=1dg2cl6XpAjdSoScLHkc1XvzBpnl8qm8uO167b0bbq0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lQUW2mB2EfHKi6106mYGkcnY0fbSS5jMo60IVukjT0/QgInSrWrGEeej2mJtoWq0e
	 RDcU1zsnqxDLyZuoYgx1hqQ3FHxQkSxHZfn7l21mgdN2sSvS+ZWpSfNwePuA8D5EY6
	 Qm04OYazvlUkFB8aoJhJlMeiHNkuYK0NY5NImQcZFFp9IFx0506frJgda6Oj3BLuhQ
	 6up7pE8RthLYHh2XefjgT8YG4oPuixbMXs+F5O0sMN1K5OH7pQ3r/BLNEJVbBeMf/Y
	 5fyJ3B5VXq62sqGkFhjixe5nyrxUE4zpkvIvzrk/ALVsjB/L3ZgmMAXrvzb3foB3u1
	 DI17F1LY0vWCg==
Content-Type: multipart/mixed; boundary="===============0642452304328940609=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <869b8823e672ed52c7cca6ed2d188130f66cb23cb0be1d6f821247b7f6d7da99@mail.kernel.org>
In-Reply-To: <20260422-sleepable_tracepoints-v13-3-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-3-99005dff21ef@meta.com>
Subject: Re: [PATCH bpf-next v13 3/6] bpf: Add sleepable support for classic tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,peterz@infradead.org,rostedt@goodmis.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 20:57:51 +0000 (UTC)

--===============0642452304328940609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 8ad72e17d8eb..e98ee7e1e66f 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c

[ ... ]

> @@ -1410,12 +1410,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	int size = 0;
>  	int uargs = 0;
>
> -	/*
> -	 * Syscall probe called with preemption enabled, but the ring
> -	 * buffer and per-cpu data require preemption to be disabled.
> -	 */
>  	might_fault();
> -	guard(preempt_notrace)();
>
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> @@ -1429,6 +1424,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>
>  	syscall_get_arguments(current, regs, args);
>
> +	/*
> +	 * Run BPF program in faultable context before per-cpu buffer
> +	 * allocation, allowing sleepable BPF programs to execute.
> +	 */
> +	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
> +	if (valid_prog_array &&
> +	    !perf_call_bpf_enter(sys_data->enter_event, sys_data,
> +				 syscall_nr, args))
> +		return;
> +
> +	/*
> +	 * Per-cpu ring buffer and perf event list operations require
> +	 * preemption to be disabled.
> +	 */
> +	guard(preempt_notrace)();
> +
> +	head = this_cpu_ptr(sys_data->enter_event->perf_events);
> +	if (hlist_empty(head))
> +		return;
> +

Could this lead to unnecessary buffer allocation in a race scenario?

The patch moves BPF execution before preempt_disable to enable sleepable
programs. The new code checks valid_prog_array outside preempt_disable
and runs BPF if true. Then it enters preempt_disable and checks if the
hlist is empty.

Between the BPF check (outside preempt_disable) and the hlist check
(inside preempt_disable), another CPU could unregister the last perf
event, making the hlist empty. In this window, the code would:

1. Run BPF and pass the filter (before preempt_disable)
2. Check valid_prog_array and find it true (before preempt_disable)
3. Enter preempt_disable via guard(preempt_notrace)()
4. Check hlist_empty(head) and find it false (inside preempt_disable)
5. Allocate buffer via perf_trace_buf_alloc()
6. Submit to an empty or nearly-empty hlist

The old code checked both conditions together under preempt_disable
before buffer allocation:

    head = this_cpu_ptr(sys_data->enter_event->perf_events);
    valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
    if (!valid_prog_array && hlist_empty(head))
        return;  /* Early exit before buffer allocation */

If the perf event is unregistered between the new code's BPF execution
and the hlist check, would the buffer allocation and data copying be
wasted work?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24799223877
--===============0642452304328940609==--
