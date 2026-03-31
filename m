Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8843C071
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991911; cv=pass; b=TjF2Qy7wHA+39tE8ftKkJRFifuN1MhYWqOuojg8SFIm4KlJNAZxF3lvGw04sILwfZNxXNwN+U4zaxHrJwOXtY6vH4jv8gSGrKnnGl2+NZvFQcj4cQx78rUHdiTmZztTuvmri2PG5AlPhn6daya2J0ccPfqCfWfqut70FZIswL5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991911; c=relaxed/simple;
	bh=yOl8XPKUYRzVJa5GKexJ6FsBKyukFwr1iD4GyTHeKmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/YytyOTtR3mzLeV3akCX9nyt97wsWyDwBPKsftDTMwssSzgxC8kh4jGvVkeC4LN6jWi6Rn+baDWbPatd3coJ+u37R2iLLVxXlWka7VtArWJ0Jw+dbtQaR86LAnEQRa1ZoFDsy8jnbkRbGyaPRmFjUm+/0+VE2Yj+nJFAHZYt38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgVIhF4v; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgVIhF4v"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2816100a91.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774991909; cv=none;
        d=google.com; s=arc-20240605;
        b=F4v2QxBOxjGauA1vRcu7C3PZtDvq3rZAuQQkmjdqPvyxt0v89z93UGfEgJ6LVUDJDf
         8i2Zo/7CBSCk3qQMzkAC2CA0qTBg+b/MtqZ539wTcP9i5DmGwPd/fclrq6KW7/bvCOIh
         eJ7gWz45XnWzP15KSVzitD6vpEut2j/kZNWuXSnd2mb5ZrLjCELJF2IWyvF14u7mx2V9
         Nq3cwva9T0RtAcAWoXTCxcUJ5FrQIR5g8Dr9Sub4tIecD7moFkf7vmKclOqhWlZCk5XL
         euLR4XM4PIdrhsgiiU0FWkdt1J76s/Wf78Ib4uXFP/ubzFfhx3z4ti+4UT8wEWRVAN+X
         DXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AtxzKdxDA9L1MFMzXUrS4CcunrcZQxbZui6ll3LBTpY=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=Y5avEZL7sMgMt4vhH0OKFF8bgCMsH/VWvypXmhtvjW/QRDUUNnmUA3DraVUz4tdHx7
         +dPIQAP4NlTberLQQZpmRvP9fckMj/bV2GO/lx2Z3366bnfC7htC20gGKZJmjjazev/t
         sOrRyv/NgDRZ7L5RQD7jc1r2TgWDXFvq6xC39wP6/QUV3BqdvQM7THAcW1IFjDb180VJ
         De+/Rsa8W7HQmr8mScxCHvWBElDpdBni7ZhFzT3M1pH6Kvs4pWpv25JvQv99edafl7wm
         yeqaVMAO8prfwNc+WpcEvN/4v4hS/vUcFTGhgqlZmvCbkivczMa5SU5TvRSm0g0AjIbk
         4/jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991909; x=1775596709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtxzKdxDA9L1MFMzXUrS4CcunrcZQxbZui6ll3LBTpY=;
        b=RgVIhF4vadQWDb5EO5LrTLKP6lT7Rah06w3t7vJhhZq/20Ckb8VYgcueqo5qC1mZXS
         +/q4HIPjEvnf+pbSsqjidwR8/AxdUMv7OzcbJyIfI1ga3EOEkqXNcKhkirtcub1SKxVF
         7zXYnick7RhzwqVIr5d/vWJGbYYfXb1bhrhhk0MmZp+V1QZVEqdDqUjj0t4ynCTa1ovi
         L2s8+UeVtAPeATZf84xI6SoBHWIGTpZJVQ/Y6aa+uB52IGTE1w/LynGQFv8auYGU1t9U
         KgD/hDUaR9wPBW8PdCEvaaYuuIwYFKmqtS16e3bgPqWsXwhGlbzitNx1Smu+wboYyHnR
         87Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991909; x=1775596709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtxzKdxDA9L1MFMzXUrS4CcunrcZQxbZui6ll3LBTpY=;
        b=BmmHt6m1XOMl/sH1wT2fEs9xsCoIiWk4ctLtwtjZK18iDI0CUONz4CXTVM6ugnlGZG
         2ox0MpE8Ki6En6uwtJHdczxz7z1FDppvGV4kgc5VFtVCSfTmGU/BKOmUv+zi7MQYs5Am
         WYwi6WwOvInaf82oZZCdXGR3Dzawiltg9VPyQ+675p7u7HWN46l6XjraUMFmcGSTmCRZ
         lP33ka5aqtJ6hp7ljf93SksGtL3RDesd3+LE7sl9X+CIYs4aVUgNhNs864AdSKQ2trUR
         bJRpQuGoNFDtlH/casdm3Pep5ofhzkNmT0MoIp+4eH1YCQOD2mYA4rwJaAO7J5nKKorK
         f+Uw==
X-Gm-Message-State: AOJu0YyoOkZweMdowZ3MC1u3pMg9i9PwtPgYg7AJKgFgvVnRVR2JN+FP
	M8dfrQNNyo1ZMjry8VJz715IzNDOm9JY5e8KYvalcl/5+Oqd9jjLq6oMwEqors5O+UV+x9l+7Ts
	BKLuJOuPgD8bpoH+Hj3GbiW+zGpjhSts=
X-Gm-Gg: ATEYQzymC4hrrQrJQgh1KV7Y75R6RnybuB2Rp0y8nsDTnmCgWEIo1Dz1NQDTSfnk7/W
	PZsVAkgN6qswJLImhk0RGg1HWSQyqnIdOy8XjLM9vC1whfqcQvnyvPxNXuaMug3UG5D4OOeGihH
	PwJM7fmAS6iZvPrrPYXurgOgQOdb8j57UjF8ZEpuygiiEBqEYSHjesnqB8xQ1NP6BO2Pv9wK8c4
	//Kz846it/iclg1t3w8FKZCOKcGNJN0SawB/zPzE20cHN87+Aa6wG/uRAwag5DMLnTHgN/rn/uq
	8+Q0D/x/0nwoNRJl7ggpQHM=
X-Received: by 2002:a17:90b:3f8f:b0:359:fe72:3559 with SMTP id
 98e67ed59e1d1-35dc6f7feacmr733261a91.21.1774991909330; Tue, 31 Mar 2026
 14:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com> <20260330-sleepable_tracepoints-v8-3-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-3-2e323467f3a0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 14:18:17 -0700
X-Gm-Features: AQROBzDQ0vvKfIaJSMBL4AzLsrhhKMjmPctP2S0oxLOLRYPA-4QNd28r3N7lP00
Message-ID: <CAEf4BzYEWOmrQcE_FUkZa4O_4FMd7M49qnY4iJUted2g0eZqgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/6] bpf: Add sleepable support for classic
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
> faultable tracepoints that supports sleepable BPF programs. It uses
> rcu_tasks_trace for lifetime protection and
> bpf_prog_run_array_sleepable() for per-program RCU flavor selection,
> following the uprobe_prog_run() pattern.
>
> Add per-prog recursion check to bpf_prog_run_array_sleepable(),
> skipped for uprobes via the is_uprobe flag, to allow sleepable
> tracepoints to use private stack safely.
>
> Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
> filter before perf event processing. Previously, BPF ran after the
> per-cpu perf trace buffer was allocated under preempt_disable,
> requiring cleanup via perf_swevent_put_recursion_context() on filter.
> Now BPF runs in faultable context before preempt_disable, reading
> syscall arguments from local variables instead of the per-cpu trace
> record, removing the dependency on buffer allocation. This allows
> sleepable BPF programs to execute and avoids unnecessary buffer
> allocation when BPF filters the event. The perf event submission
> path (buffer allocation, fill, submit) remains under preempt_disable
> as before. Since BPF no longer runs within the buffer allocation
> context, the fake_regs output parameter to perf_trace_buf_alloc()
> is no longer needed and is replaced with NULL.
>
> Add an attach-time check in __perf_event_set_bpf_prog() to reject
> sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
> tracepoints, since only syscall tracepoints run in faultable context.
>
> This prepares the classic tracepoint runtime and attach paths for
> sleepable programs. The verifier changes to allow loading sleepable
> BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com> # for BPF bits
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h           |  18 ++++++-
>  include/linux/trace_events.h  |   6 +++
>  kernel/events/core.c          |   9 ++++
>  kernel/trace/bpf_trace.c      |  29 +++++++++++
>  kernel/trace/trace_syscalls.c | 110 ++++++++++++++++++++++--------------=
------
>  5 files changed, 119 insertions(+), 53 deletions(-)
>

lgtm, we'll have a bit of slowdown due to memzeroing fake pt_regs
every single time, but that's probably acceptable

[...]

> @@ -2513,8 +2515,22 @@ bpf_prog_run_array_sleepable(const struct bpf_prog=
_array *array,
>                 if (!prog->sleepable)
>                         rcu_read_lock();
>
> +               /* Per-prog recursion check to enable private stack. */
> +               if (!is_uprobe &&
> +                   unlikely(!bpf_prog_get_recursion_context(prog))) {
> +                       bpf_prog_inc_misses_counter(prog);
> +                       bpf_prog_put_recursion_context(prog);
> +                       if (!prog->sleepable)
> +                               rcu_read_unlock();
> +                       item++;
> +                       continue;
> +               }
> +
>                 run_ctx.bpf_cookie =3D item->bpf_cookie;
>                 ret &=3D run_prog(prog, ctx);
> +
> +               if (!is_uprobe)
> +                       bpf_prog_put_recursion_context(prog);

looking at all this is_uprobe special casing now I do feel like a
separate bpf_prog_run_array_sleepable vs bpf_prog_run_array_uprobe
makes more sense

>                 item++;
>
>                 if (!prog->sleepable)
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 37eb2f0f3dd8..5fbbeb9ec4b9 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h

[...]

> @@ -1411,12 +1411,7 @@ static void perf_syscall_enter(void *ignore, struc=
t pt_regs *regs, long id)
>         int size =3D 0;
>         int uargs =3D 0;
>
> -       /*
> -        * Syscall probe called with preemption enabled, but the ring
> -        * buffer and per-cpu data require preemption to be disabled.
> -        */
>         might_fault();
> -       guard(preempt_notrace)();
>
>         syscall_nr =3D trace_get_syscall_nr(current, regs);
>         if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
> @@ -1430,6 +1425,26 @@ static void perf_syscall_enter(void *ignore, struc=
t pt_regs *regs, long id)
>
>         syscall_get_arguments(current, regs, args);
>
> +       /*
> +        * Run BPF filter in faultable context before per-cpu buffer

BPF program, it's not a filter

> +        * allocation, allowing sleepable BPF programs to execute.
> +        */
> +       valid_prog_array =3D bpf_prog_array_valid(sys_data->enter_event);
> +       if (valid_prog_array &&

[...]

> -       /*
> -        * Syscall probe called with preemption enabled, but the ring
> -        * buffer and per-cpu data require preemption to be disabled.
> -        */
>         might_fault();
> -       guard(preempt_notrace)();
>
>         syscall_nr =3D trace_get_syscall_nr(current, regs);
>         if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
> @@ -1560,29 +1558,37 @@ static void perf_syscall_exit(void *ignore, struc=
t pt_regs *regs, long ret)
>         if (!sys_data)
>                 return;
>
> -       head =3D this_cpu_ptr(sys_data->exit_event->perf_events);
> +       /*
> +        * Run BPF filter in faultable context before per-cpu buffer

again, BPF program, not filter

> +        * allocation, allowing sleepable BPF programs to execute.
> +        */
>         valid_prog_array =3D bpf_prog_array_valid(sys_data->exit_event);
> -       if (!valid_prog_array && hlist_empty(head))
> +       if (valid_prog_array &&
> +           !perf_call_bpf_exit(sys_data->exit_event, syscall_nr,
> +                               syscall_get_return_value(current, regs)))
> +               return;
> +

[...]
