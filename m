Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C23DB63D
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298342; cv=pass; b=usY1t8ml77UEZlEz9wbOC4FB3p8ezQJTmhFvATuj0Snk0+VLddV74N1qaS1p+JzboWy4cH6EosvVLxeMUDNcqPizqkTovkGBaBnTkOLeUKegDJHj0B4VcfLllkdcKaHQMfypn8IA9+DKz6XUmem/pkbYilc1moOjCUcb2RzXRdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298342; c=relaxed/simple;
	bh=ENXpiazFrpwFv6KenmptNlfnYUVc9xxq26irvUl5Cik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTbF7IIbHOKpx2WAcZP3LK+71zxXdzY6SrCS42AU1udloUZ4HjdgVncJzqJVhSxAuOj/SiMRWchEjLJDCuZopSBbFEDNVac104Gs99lVgom4NkEy3OkzoNMu0LQ2wzdkkL3QkVo6sKZr0x0PKDyxmFHBfNfuTJg9J24BX8QvzJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLIfI9ue; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLIfI9ue"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48538c5956bso42790825e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 13:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774298340; cv=none;
        d=google.com; s=arc-20240605;
        b=TpTCdPyZzIy54zj0DgxYH3HAc6/QshAVSNui/IciNewv41ZKLf5fA5zNq7FFpMNjRE
         /J28camSoQRBCvncOiAdq4UMtj1scQ9wHHcPc8ru18mBvxFtjclVlFXRNsYqop9HUuwk
         EMw/KkCG0xgfPFpio4y2qA5K/OVOQLh7qResnjjM0ulD/gS1YuOqIguk8KsJwPCyg9j3
         VmFC5xsu/TeE0L6cym/cC9fnn6keqgRp2bOHLnD+DoKWMeDM87kDpWfWsFoJId1jGQ+D
         aUJACutOwyppLm19H6jD7qeYj0//buK8H3eYFjweIjuZ0FXrFkJ3lcUGyXo7RoUqyTQ2
         vuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dn8G8qPr5DtbD0azvIFGzPUcfi+UopZ/sj044tMrstA=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=De66FgdUqOE2nv/8CRJB9eXnyAK06DQbmQZyJgJs9rsjxDNtSz2/UqZgTMWN50L4y3
         JK1MTEvxGNo5+MIB8rLhGbLfO/QU3LSyANK7AOLByvvxV3y6czDYazRseg0hIBnHRM6v
         EDVAh0NmG6MJVwzYJx4bSw4FvCzAgzsF3aeXdJIEuBWpEGxvpyAzX6haZBXIAFXdtXv5
         IVC5KxaDD4chWjtZnDwxF/55Q7cFlwKt2ysaSU+TkKPnZzWfozp9t24IrJkQsVit4eHH
         3r4Ytxhc63KxIJMoknUnxVHcNB1OWir3ZQH5rE6Ia4Z7DVVZ786jK5To/vb3rYppb4oI
         cUxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774298340; x=1774903140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dn8G8qPr5DtbD0azvIFGzPUcfi+UopZ/sj044tMrstA=;
        b=kLIfI9ueKhsSmng2PDaNOdhESi3z4ES1ofs8wjRm97wZtHNHwQMRqV+nBOX6st5Ka/
         o9rHjI8haOx0YWUXWB6VcAiVWE9KCD0cXip4KaSweLOS0XYgD0VH2nsklRizXeZ6ROFO
         1HYup9aaICFbi9sJs5KoeW+ZSD1UqU89EWO1XVFQNJQE9J8t1FgyMAlhULovXjIm+af7
         8VubKZrHcn1TxiMRHJm60LWKVJXWqGHEqWZgdEGjGXJXCT0WJZSE4Id8ug1ZZ2YiO8Fx
         k/sHlb9GilmhyxIFLWGj/CdByY281q2Hb9dvYSZHCQ9v8vT86JOPsLMtZ5vzwnTThuED
         yS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774298340; x=1774903140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn8G8qPr5DtbD0azvIFGzPUcfi+UopZ/sj044tMrstA=;
        b=H01L/zmyA1ATWRTAFAVQifzldN7Zk8Eo41VhiD2JxzgcvsV2PKW06GgJLA/udYtszO
         Kt8JD7qHKR35pbMih2Y8YMSV9ybnO/FOa02ze12Yc/Zq5zoDtUg/vY92kO6LRfQOqiDz
         AVooU7AGHeR8ufB+yqC6+UCSYAXp4ZM2HpToCE9K1YephHqoww9BzJpM0vtg+xCCZWJt
         dM3OKYybQ6hv2T/B48DcGhq7crIsz8vgDSbwvA8+Bz8TaCDK9uMsp2spBVdrs/xqWgji
         QiJDbLcM3TqD+rbNxLQrETlh43vtOO94BZWH2KYmz2vFgFpgDSUTqVebfeDamNckyQjQ
         jWmQ==
X-Gm-Message-State: AOJu0YxBmps1EKp2ayaalpPzIVoO3cp+BtZoo9xZec/G3THvbpgezBwU
	y8FLp3t201Take3r8hdAiLDZJOGLUmi/UY1AxJnxQKhKVlM/J3AqIT/sloPmwe0NVTFIJSG+EN1
	M7gxPo0ioL+lzu7r2H/icCZA5aaimT+g=
X-Gm-Gg: ATEYQzyEGQLoDaSCEea4CfBXpMgAatgJE3oRbZr9VAqcnq5aKqQiR5xP13fMtQOiAZA
	N197w0l/6as6zk8yCsi0tP75lT9raIpkPHQ0BQJnuUjTq5dU5gGewHNhywTn64L1ac+9vjnPVjT
	DAL5zLCxGz3p9Sfa7s9ghumtCxCQaWRWMzQOHYrjJG7t0/Fi5vpo3hBrwEqy+e5KBAcDfyHZNYI
	H3E8uwhug4J6WjN6heK9WrPIKiHHDL9kKM/saGtxECYxmWaltjXhmHLvm7L8uqtbEXS6HSCmRnb
	TfvtmzDfWH6G8tK3jqM407Lmpr2fLCqSUxQvx/aBIpsSPh4ALx6HNWOWUIA=
X-Received: by 2002:a05:600c:2904:b0:486:fdef:c3e0 with SMTP id
 5b1f17b1804b1-4870f1f205bmr12015425e9.6.1774298339235; Mon, 23 Mar 2026
 13:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com> <20260316-sleepable_tracepoints-v5-2-85525de71d25@meta.com>
In-Reply-To: <20260316-sleepable_tracepoints-v5-2-85525de71d25@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 23 Mar 2026 21:38:21 +0100
X-Gm-Features: AQROBzB6wt-UpN5uua262ccRLwQU8li8b7ETqLNRsOa6sQzCZuRr7tLSpW3alFM
Message-ID: <CAP01T75bzeb867EtX52ua2myYOxH15tkXd9P_7=7ACkSdS8wQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 22:47, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
> faultable tracepoints that supports sleepable BPF programs. It uses
> rcu_tasks_trace for lifetime protection and bpf_prog_run_array_uprobe()
> for per-program RCU flavor selection, following the uprobe_prog_run()
> pattern. Uses preempt-safe this_cpu_inc_return/this_cpu_dec for the
> bpf_prog_active recursion counter since preemption is enabled in this
> context.
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
> as before.
>
> Add an attach-time check in __perf_event_set_bpf_prog() to reject
> sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
> tracepoints, since only syscall tracepoints run in faultable context.
>
> This prepares the classic tracepoint runtime and attach paths for
> sleepable programs. The verifier changes to allow loading sleepable
> BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/trace_events.h  |   6 +++
>  kernel/events/core.c          |   9 ++++
>  kernel/trace/bpf_trace.c      |  39 ++++++++++++++++
>  kernel/trace/trace_syscalls.c | 104 +++++++++++++++++++++++-------------------
>  4 files changed, 110 insertions(+), 48 deletions(-)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 37eb2f0f3dd8..5fbbeb9ec4b9 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -767,6 +767,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
>
>  #ifdef CONFIG_BPF_EVENTS
>  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
> +unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx);
>  int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>  void perf_event_detach_bpf_prog(struct perf_event *event);
>  int perf_event_query_prog_array(struct perf_event *event, void __user *info);
> @@ -789,6 +790,11 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
>         return 1;
>  }
>
> +static inline unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
> +{
> +       return 1;
> +}
> +
>  static inline int
>  perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie)
>  {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f5699b339ec..46b733d3dd41 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11647,6 +11647,15 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
>                 /* only uprobe programs are allowed to be sleepable */
>                 return -EINVAL;
>
> +       if (prog->type == BPF_PROG_TYPE_TRACEPOINT && prog->sleepable) {
> +               /*
> +                * Sleepable tracepoint programs can only attach to faultable
> +                * tracepoints. Currently only syscall tracepoints are faultable.
> +                */
> +               if (!is_syscall_tp)
> +                       return -EINVAL;
> +       }
> +
>         /* Kprobe override only works for kprobes, not uprobes. */
>         if (prog->kprobe_override && !is_kprobe)
>                 return -EINVAL;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 35ed53807cfd..69c9a5539e65 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -152,6 +152,45 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>         return ret;
>  }
>
> +/**
> + * trace_call_bpf_faultable - invoke BPF program in faultable context
> + * @call: tracepoint event
> + * @ctx: opaque context pointer
> + *
> + * Variant of trace_call_bpf() for faultable tracepoints (e.g. syscall
> + * tracepoints). Supports sleepable BPF programs by using rcu_tasks_trace
> + * for lifetime protection and per-program rcu_read_lock for non-sleepable
> + * programs, following the uprobe_prog_run() pattern.
> + *
> + * Must be called from a faultable/preemptible context.
> + */
> +unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
> +{
> +       struct bpf_prog_array *prog_array;
> +       unsigned int ret;
> +
> +       might_fault();
> +
> +       guard(rcu_tasks_trace)();
> +       guard(migrate)();
> +
> +       if (unlikely(this_cpu_inc_return(bpf_prog_active) != 1)) {

This seems a bit heavy handed, why not
bpf_prog_get_recursion_context()? Esp. since we can potentially sleep
and other tasks can preempt us on the same CPU.

> +               scoped_guard(rcu) {
> +                       bpf_prog_inc_misses_counters(rcu_dereference(call->prog_array));
> +               }
> +               this_cpu_dec(bpf_prog_active);
> +               return 0;
> +       }
> +
> +       prog_array = rcu_dereference_check(call->prog_array,
> +                                          rcu_read_lock_trace_held());
> +       ret = bpf_prog_run_array_uprobe(prog_array, ctx, bpf_prog_run);

This confused me a bit, do we need to generalize it a bit? E.g. it
would now set run_ctx.is_uprobe = 1 for this case too.
Actually, except that bit, the rest looks reusable, so maybe it should
be renamed to __ version and expose two wrappers, one that passes
is_uprobe = false and one passing true?
Then do bpf_prog_run_array_trace() here?

> +
> [...]
