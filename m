Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3213E5589
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299465; cv=none; b=Gscn8uBHV96J2ktTJ+YuA8+jcGfo1sqXJeee2qa50oVVtk0wEKm5UWyZrM9w7wUtZVPNUrY0q6IftHCErhEsGEHs3PBZKh0nHL/w2WIwsIPFO7uVqKnZJA8NXNzXbnZ392MzGz2ZDK+8vxxWevp9w4K9FnPAXYQePRUq9N74zyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299465; c=relaxed/simple;
	bh=ytSjY5imEW0VOV7oB8g3vlPgH7EfhR4xzOrM0iD/aeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lccpJsTG09hwH1kwXxIb6Kx4guCAYhw0wxMQ72H0PCrxAkgtbrFrjt4+k6F8trezCJsorhMLiMfK7KnIJkqFhC8Ia5ZTCbgnCtRChMpbwLrfhz68NnrUuFKWpSWZBXJ67/+jQd2VaH29YlsRGzHH4euHhoBwoaQO8OlYBmWbYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVof6Pgj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVof6Pgj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso5006555e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774299462; x=1774904262; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSrzFDLGLlgg747vZ1gr3bc+2bStKqFCf8aLH6SAXEw=;
        b=lVof6PgjyiTMtW3dQLOG/T1qp8ifAy3j42mQJDvwoFeAW5ebzTD82o+qmqBgYQJaIW
         orcZuJ4iufe0pU5Z5CPKJ8/7FinhzI0Ok5VuOE9PsY/f4TRV+ZuI6THbBnghxgXAr4Ag
         xOevoX0o01ZCJK5zk02oimZ4QuJqbf3Rh2K8ih0M3Wl2SHgDrf5GEqTY1NGZIL35Uqb6
         k64EhmEHnppcEGWrX+WsuhZW0d6gf0fZZlfrmonsiFYEs07rzaTnhKiFKhi5trES3VLG
         /IBtxZBLnYBgeprvl7QuBGJqMF6GWTT1HVR73tm7tq5pnT/yVG1Em4n78eYza0NJZ4cr
         DOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774299462; x=1774904262;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSrzFDLGLlgg747vZ1gr3bc+2bStKqFCf8aLH6SAXEw=;
        b=jZMItA3nVjdzXvolosfwdlQ8xSFufLwaKjJIsOHQsgYbKlu6MlHSsAaGG9/LfPlH9X
         Sgqrc1cIK661SvnLJEISWZ7/aFMW2+17ZZJQMgwyZAsKXuI7sojxQdO1TLYp7twHgjBV
         IVPAUtqPelxWcUDhTjLvDwiAJk95HC0UZXnPpYBOy1V63s0igFgz5szHevpOAZOlStbq
         T6hP5vnbkywUFr5HLd9TZsida5yLnD836dyHmhkPlAnTjTVTcn2VCSAn3aHs7sEQhaaf
         DNtyc4oBgF4UXFghLKhEgKyUnZofPVUGb/qtSOp+1b1cOZJwi+eEYp2hHdxi/7+pO3n6
         zgXw==
X-Gm-Message-State: AOJu0Ywf5Cr6257+HfLhG0gHfZj7v2QbqDd1d6WzQu9SQNaGtPGeAF4K
	FJxtJUjEE03S7F8UI7qiLJdLM4MWyEkmMIf/JBgKdAvZ/x2Tz4XrNx5U
X-Gm-Gg: ATEYQzzaoY3Ze5QBinP28DmtfncgPnSOzpR/OGV/HR+fynBwldf3G/KhufwMXkuqB3c
	v0NGOnK2x/njNMavuqivDwST1TGpA7wJeHZutjzOZhX9xRp5Q6z1exb6lm0JXWcn2gLWG0JeQaC
	U4PqAr5wYJqgWM2gugz5tJpiN3+wUqlTFg0PcNFKmRk5J4lbewN9TPdNns9+6kS08b8FzhQwaZg
	fyRePhyCFKo4XoIg4Wk1SQSPf9FE764w8lY4hNg30s1h+p/OmrQ9O0dVfe0TXz5wUCMCXzQTIMq
	/9ZngxkG8DIFEEk4YmEE+1l4+jviRxEIVjhHySSKWnxD/4N5FYfgT6wDPnIlI1Qg1Pp7JW4/xSs
	g4DLbvTYsk5+DYuzkIftw8+hU5z6cvul0148S6Lul4zjGklaMMqECw0JnI6+2Vae7oztkKij+s/
	BgKtn11clgneFv4VSz0rtSwFC8FezZX50/znsfps0N3C6a
X-Received: by 2002:a05:600c:4ed1:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-486fede7230mr201671825e9.7.1774299461866;
        Mon, 23 Mar 2026 13:57:41 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c116asm4329265e9.1.2026.03.23.13.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:57:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic
 tracepoint programs
In-Reply-To: <CAP01T75bzeb867EtX52ua2myYOxH15tkXd9P_7=7ACkSdS8wQA@mail.gmail.com>
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
 <20260316-sleepable_tracepoints-v5-2-85525de71d25@meta.com>
 <CAP01T75bzeb867EtX52ua2myYOxH15tkXd9P_7=7ACkSdS8wQA@mail.gmail.com>
Date: Mon, 23 Mar 2026 20:57:40 +0000
Message-ID: <87a4vyjmbf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 16 Mar 2026 at 22:47, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
>> faultable tracepoints that supports sleepable BPF programs. It uses
>> rcu_tasks_trace for lifetime protection and bpf_prog_run_array_uprobe()
>> for per-program RCU flavor selection, following the uprobe_prog_run()
>> pattern. Uses preempt-safe this_cpu_inc_return/this_cpu_dec for the
>> bpf_prog_active recursion counter since preemption is enabled in this
>> context.
>>
>> Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
>> filter before perf event processing. Previously, BPF ran after the
>> per-cpu perf trace buffer was allocated under preempt_disable,
>> requiring cleanup via perf_swevent_put_recursion_context() on filter.
>> Now BPF runs in faultable context before preempt_disable, reading
>> syscall arguments from local variables instead of the per-cpu trace
>> record, removing the dependency on buffer allocation. This allows
>> sleepable BPF programs to execute and avoids unnecessary buffer
>> allocation when BPF filters the event. The perf event submission
>> path (buffer allocation, fill, submit) remains under preempt_disable
>> as before.
>>
>> Add an attach-time check in __perf_event_set_bpf_prog() to reject
>> sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
>> tracepoints, since only syscall tracepoints run in faultable context.
>>
>> This prepares the classic tracepoint runtime and attach paths for
>> sleepable programs. The verifier changes to allow loading sleepable
>> BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  include/linux/trace_events.h  |   6 +++
>>  kernel/events/core.c          |   9 ++++
>>  kernel/trace/bpf_trace.c      |  39 ++++++++++++++++
>>  kernel/trace/trace_syscalls.c | 104 +++++++++++++++++++++++-------------------
>>  4 files changed, 110 insertions(+), 48 deletions(-)
>>
>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>> index 37eb2f0f3dd8..5fbbeb9ec4b9 100644
>> --- a/include/linux/trace_events.h
>> +++ b/include/linux/trace_events.h
>> @@ -767,6 +767,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
>>
>>  #ifdef CONFIG_BPF_EVENTS
>>  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
>> +unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx);
>>  int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>>  void perf_event_detach_bpf_prog(struct perf_event *event);
>>  int perf_event_query_prog_array(struct perf_event *event, void __user *info);
>> @@ -789,6 +790,11 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
>>         return 1;
>>  }
>>
>> +static inline unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
>> +{
>> +       return 1;
>> +}
>> +
>>  static inline int
>>  perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie)
>>  {
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 1f5699b339ec..46b733d3dd41 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11647,6 +11647,15 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
>>                 /* only uprobe programs are allowed to be sleepable */
>>                 return -EINVAL;
>>
>> +       if (prog->type == BPF_PROG_TYPE_TRACEPOINT && prog->sleepable) {
>> +               /*
>> +                * Sleepable tracepoint programs can only attach to faultable
>> +                * tracepoints. Currently only syscall tracepoints are faultable.
>> +                */
>> +               if (!is_syscall_tp)
>> +                       return -EINVAL;
>> +       }
>> +
>>         /* Kprobe override only works for kprobes, not uprobes. */
>>         if (prog->kprobe_override && !is_kprobe)
>>                 return -EINVAL;
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 35ed53807cfd..69c9a5539e65 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -152,6 +152,45 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>>         return ret;
>>  }
>>
>> +/**
>> + * trace_call_bpf_faultable - invoke BPF program in faultable context
>> + * @call: tracepoint event
>> + * @ctx: opaque context pointer
>> + *
>> + * Variant of trace_call_bpf() for faultable tracepoints (e.g. syscall
>> + * tracepoints). Supports sleepable BPF programs by using rcu_tasks_trace
>> + * for lifetime protection and per-program rcu_read_lock for non-sleepable
>> + * programs, following the uprobe_prog_run() pattern.
>> + *
>> + * Must be called from a faultable/preemptible context.
>> + */
>> +unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
>> +{
>> +       struct bpf_prog_array *prog_array;
>> +       unsigned int ret;
>> +
>> +       might_fault();
>> +
>> +       guard(rcu_tasks_trace)();
>> +       guard(migrate)();
>> +
>> +       if (unlikely(this_cpu_inc_return(bpf_prog_active) != 1)) {
>
> This seems a bit heavy handed, why not
> bpf_prog_get_recursion_context()? Esp. since we can potentially sleep
> and other tasks can preempt us on the same CPU.
Agree, the same point was raised by sashiko review. Thanks, though, for
the hint to look into bpf_prog_get_recursion_context(), I was not
aware of it.
>
>> +               scoped_guard(rcu) {
>> +                       bpf_prog_inc_misses_counters(rcu_dereference(call->prog_array));
>> +               }
>> +               this_cpu_dec(bpf_prog_active);
>> +               return 0;
>> +       }
>> +
>> +       prog_array = rcu_dereference_check(call->prog_array,
>> +                                          rcu_read_lock_trace_held());
>> +       ret = bpf_prog_run_array_uprobe(prog_array, ctx, bpf_prog_run);
>
> This confused me a bit, do we need to generalize it a bit? E.g. it
> would now set run_ctx.is_uprobe = 1 for this case too.
> Actually, except that bit, the rest looks reusable, so maybe it should
> be renamed to __ version and expose two wrappers, one that passes
> is_uprobe = false and one passing true?
> Then do bpf_prog_run_array_trace() here?
Thanks, I agree on your point.
>
>> +
>> [...]
