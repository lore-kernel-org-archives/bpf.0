Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB93644A2
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849978; cv=pass; b=QAjK2H9MhcnGyUuPonoufTptusHrfMf53sYRxdCfnVthoDgRpkk+4b41i5wRw4EtDwPkjjDHoS5Yu+w3666tfnms8GYN3xWdB9hyj7yruEUVIqmxGh2Ky9B0uiphHtW84Can7OFhgjccyOM8IGaOHTViGqq1pZ0qCoqvyK142/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849978; c=relaxed/simple;
	bh=9uxDrH0MEGEAE2LTyHmAvtEu1BGXFGpctoLSKNV5AIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2BCPKD5br8MDD7Pas7tyymKqdEzUOLaOww9kqJJakz+MkAkPdEdEP8zcPWRy/nrvXFvC+ynpYsakA8F6L4XH0sO1UGe/aMBgf5lznNzgeDm8e9scBvCI/mQT9BiTnFpOypwoQd1UhCLJSUWmlw2FUTv+XSr6Apwq6JKuV0V9z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDO+9Dpk; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDO+9Dpk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488c21c636dso14441055e9.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 12:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775849975; cv=none;
        d=google.com; s=arc-20240605;
        b=kXePOUNdZkwJBpEDWEuiKptjMucle2U8d0jxOegDpXQ0OpByMfwo/pmIOEjLt0TjhR
         1dPbxl+CBUy/jTf/qxam8RUYv2SQXmD36C0zdpD4q0+yiPCUqUOOm4mibC2MmykCXB/3
         IYMx3u/axzW8gdDJ4LQ7pvjj5qTPj4EgGAzaM5bOF9p1T4+Hd1i8ex7gdaaawOfdscgE
         cxb1jxDOeEB3oBgzM8S+UkSzUs07lk43Ly6fC3nozK3aSubqzOkpvEYWv6KYJoyEAmqo
         vebHXwgHeSvM4XYttX72yswCP4E+vmUlu5FXYn80NKPIwrynd8HRGpjfUvF6zyf+uc4q
         QiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8TIEzTj4wFUIVsZShw4BXebRWW0JnbKN8Tko3qZMPBA=;
        fh=w9paX8TUTjpUD+DoFbhOt1TKmN2uoKLuFUUpp09tRys=;
        b=cvlDkUwFxasCJkSHxC8bpgAVqoIy1CdQYPB1TYSeTtflrnWWA3D4saBR2inoIxefFb
         /zn4dCK81P3ptRZzDBo+rJSyexxp+l/NgKs1aFzsHn8Pg7SqMebcWjeqeCOsW28G0zjh
         GOIdnRiSCA87vVuCsUceFaObuWjyK9bw/S/paa/wh9Ytu5wrwhEKaYupyQuN1wSHLbl8
         IkqheeX6GcyHiyfDEiYOw6m2FUYEpUIvH/2kyZnPgTRmQhHsimwEuzaTQnvIHwJB6IIY
         hvcNR4hj2pcS8ibq4mN/sP6lNX49XTesKyHnIFEi21tDqWG8vhq4tLtwxdjRbor7HaxX
         +1Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849975; x=1776454775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TIEzTj4wFUIVsZShw4BXebRWW0JnbKN8Tko3qZMPBA=;
        b=gDO+9DpkOx2lGtUHVgAp9maCB4OtQ/9DFUxL7kRWxNEkW0VbHq9pwI6RHN8O/lKnKp
         /FVPW/lNYoqFtlwQPTnT6VxZpRjt7SRfOsKlpbL9NZ8ka0ruE9hvDgVCQlJiUZ16bj3f
         wDIfPwqVuQszePWbqZAHTg008i5DVuTJSmsSBeBYncfkCJvjoOOOAPqirz0JPdZHmqvo
         2Ax+uNCAp2poJ9tnoLbfe+z8wcILuekX2PjLLCpRW5MIVFRxvlf2ja3PEizwgyXufQWl
         16t8KpCOl/DS3a6iHln6x/RD60kkVAjcGLO+YCaPxMTN1ORlZvLlydI0cZfQT4/JnJBJ
         2Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849975; x=1776454775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TIEzTj4wFUIVsZShw4BXebRWW0JnbKN8Tko3qZMPBA=;
        b=LKvTHpxTxyxDtSuUHTy/ZN1R3IE+ykCMUCGnpsukdkkSSs6MGXgxm28/JA9RW+EWWw
         ezNDc8FotfD1S/prd7KIOSSvaHRNsN/HsStlvjlh3+Fp45BJzP5m+GVznsdi9Sib2kVQ
         XCTGH2cf40BkBgDGjAW5IjUeJGo4WTiQntN6pwrHxVmBV8yJYjOANyePFxVaKqKGraEd
         NGHngrT8aNcKclfduK7NCLGkZWFHb9Nttbhxp0rQX+kmf4wjGV1tGIQXZ0JUyzh3aHPv
         4pQh47aIPo7NI9WpKgUUeMz6gaUhNX95TUb56hPI+ONQ7wPkafXbT1Lib/frXhSuns55
         QhNQ==
X-Gm-Message-State: AOJu0Yxlxp9LNHh9lUTIRep+uejNo8D78a0RM7zxXHXxgYZAPKScSDxS
	QdXIqavLF0mWE2YHpA1EewdAeZstZOM5Wun5eRK6BDXwlIZCurA/MjyFgJydaiG8bQ8xqAVT3J/
	QqpFFWgUQ/K39VKl+dzvEjVtvZkuU8l0=
X-Gm-Gg: AeBDietVQHpxr6tGh2YOgY3oCPyJuPaUacmaif4r6ESsiBsYDeZRsA9gh5LeTpVmL53
	w+Juf6829bFoZ6NI1fMpHla/j8vZfS5qLU2K/CebJ+4coQTBYHY+YkmXDD6XLAk8tZ/HFnTP9Rj
	UyP3E5p/SPrz51OoCjLrtTQpANDMGYCqSxfl+S+WRqCSa53ILHKZllF6qfYvY3kG4zsEbBx25RL
	k3LBJkUWsWtYx4ZuEf8NeMy/5WW8IHEqiL7GzSoF7PosTDO1NEDCAxjg6MiIsJVEOg7tZFMgztx
	JAW45wAeFgk9n+H5T0R0rMvVJqzFWkSHh+bLidwn6UaOD8rh02a9ezk8pDMjjxA2oibbb328tAE
	2JnnzewXoroyNpFkcvtzZSlelyw==
X-Received: by 2002:a05:600c:8595:b0:485:3b00:f93b with SMTP id
 5b1f17b1804b1-488d6ab8082mr44650605e9.31.1775849974767; Fri, 10 Apr 2026
 12:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com> <20260410-sleepable_tracepoints-v9-3-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-3-e719e664e84c@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 12:39:23 -0700
X-Gm-Features: AQROBzCl2D1yQorRpyT4X00u6z2hOqpi6mEhIMnn30B0FE7MELkRykqFTu3g6c8
Message-ID: <CAADnVQLg+UhSG0hUBZdrO2bkLkHm0dukor7pi8HLQi0GKkmkag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/6] bpf: Add sleepable support for classic
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:09=E2=80=AFAM Mykyta Yatsenko
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
> Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
> programs before perf event processing. Previously, BPF ran after the
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
>  include/linux/trace_events.h  |   6 +++
>  kernel/events/core.c          |   9 ++++
>  kernel/trace/bpf_trace.c      |  28 +++++++++++
>  kernel/trace/trace_syscalls.c | 110 ++++++++++++++++++++++--------------=
------
>  4 files changed, 101 insertions(+), 52 deletions(-)

Peter,

I'm taking it into bpf-next, since the refactor is minor and looks
correct to me.
