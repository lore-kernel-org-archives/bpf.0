Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009525B2F4
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938221; cv=none; b=Blr9WdxkzBntxw5KqaKW5o+4TcJ3Lihec38OpZA/w7ndRue7OQksHkwUtR59cdyCTcAgDPer9BQ7MqG8zOEXDg9AxYNhqVBhQh0B0tQ0O1DqX5lyoY7xiBawArmxJSwOAOIxUmOmZ9Fc3cJuX1f+dINscLwG955Pv5Mt757hTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938221; c=relaxed/simple;
	bh=m6On8/Xz7nt+lOgAzAN8fsqzLdQhut7Ogs8GOrisyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUyZFH3cAqGSrNLWmJAr3o2YwimOdUdDFE8p9akoB5jMowd7JB7GWwbJu9/CgwqAJj8lTTJ6JXBTbttwZI5O1murgQrpNGn7ITNHtXLBtl3pwRGa90lEtVE6MHBRoVSbizIBp0YKWvnDkwpahUc9n9z7BCVadB8gzZX2pki0BWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dVVQbVzM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dVVQbVzM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qFa0hlmuMg6MAi2uBAEOG6o78ndrCNQAqhG7WPUKbDI=; b=dVVQbVzMGmK4dcIbjRGLlE1g4p
	VqXHYM1FAiOIFKj3csV6unZ3vKSaq4z1ZRGonG1HqXqg8+dd9mt3U4LwO2wen+Hzl7Wru56td4naU
	hyW3Yq5xQyqlJC1MQpdf3q2GoQnW1QyBx7kYej09TQgUBCG/T4FYewOr5xUqzGivWfkA/D9JEi5Ft
	q9s/Zy2K3nNd22SI+9BhMJAJlvLuHkSYKUKB79HYo1D68bR+iIyg633E2Y47emerRBd74fEQ7EVFo
	uepF2gtUgoU+LUwtr18SJf/ZsaNj7kDcDf/UmXQBFvr8+7SxI+W2lHaShh+h3hLfkWUvFKUQQ9Ncq
	E8ieva0g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFqnj-0000000Cmsl-3C2E;
	Thu, 23 Apr 2026 09:56:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A928302DA9; Thu, 23 Apr 2026 11:56:50 +0200 (CEST)
Date: Thu, 23 Apr 2026 11:56:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v11 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Message-ID: <20260423095650.GA3126523@noisy.programming.kicks-ass.net>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-1-d8ff138d6f05@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-sleepable_tracepoints-v11-1-d8ff138d6f05@meta.com>

On Tue, Apr 21, 2026 at 10:14:17AM -0700, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Rework __bpf_trace_run() to support sleepable BPF programs by using
> explicit RCU flavor selection, following the uprobe_prog_run() pattern.
> 
> For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
> protection with migrate_disable().

Why the migrate_disable() ? This is a new kind of BPF program; would it
not be a good opportunity to not have this constraint?

> For non-sleepable programs, use the
> regular rcu_read_lock_dont_migrate().
> 
> Remove the preempt_disable_notrace/preempt_enable_notrace pair from
> the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
> migration protection and RCU locking are now handled per-program
> inside __bpf_trace_run().
> 
> Adapt bpf_prog_test_run_raw_tp() for sleepable programs: reject
> BPF_F_TEST_RUN_ON_CPU since sleepable programs cannot run in hardirq
> or preempt-disabled context, and call __bpf_prog_test_run_raw_tp()
> directly instead of via smp_call_function_single(). Rework
> __bpf_prog_test_run_raw_tp() to select RCU flavor per-program and
> add per-program recursion context guard for private stack safety.
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/trace/bpf_probe.h |  2 --
>  kernel/trace/bpf_trace.c  | 20 ++++++++++++---
>  net/bpf/test_run.c        | 65 ++++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 67 insertions(+), 20 deletions(-)
> 
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 9391d54d3f12..d1de8f9aa07f 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -58,9 +58,7 @@ static notrace void							\
>  __bpf_trace_##call(void *__data, proto)					\
>  {									\
>  	might_fault();							\
> -	preempt_disable_notrace();					\
>  	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
> -	preempt_enable_notrace();					\
>  }
>  
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e916f0ccbed9..7276c72c1d31 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2072,11 +2072,19 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>  static __always_inline
>  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  {
> +	struct srcu_ctr __percpu *scp = NULL;
>  	struct bpf_prog *prog = link->link.prog;
> +	bool sleepable = prog->sleepable;
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
>  
> -	rcu_read_lock_dont_migrate();
> +	if (sleepable) {
> +		scp = rcu_read_lock_tasks_trace();
> +		migrate_disable();
> +	} else {
> +		rcu_read_lock_dont_migrate();
> +	}
> +
>  	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>  		bpf_prog_inc_misses_counter(prog);
>  		goto out;
> @@ -2085,12 +2093,18 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  	run_ctx.bpf_cookie = link->cookie;
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  
> -	(void) bpf_prog_run(prog, args);
> +	(void)bpf_prog_run(prog, args);
>  
>  	bpf_reset_run_ctx(old_run_ctx);
>  out:
>  	bpf_prog_put_recursion_context(prog);
> -	rcu_read_unlock_migrate();
> +
> +	if (sleepable) {
> +		migrate_enable();
> +		rcu_read_unlock_tasks_trace(scp);
> +	} else {
> +		rcu_read_unlock_migrate();
> +	}
>  }

Since you have a clear distinction between __BPF_DECLARE_TRACE() and
__BPF_DELARE_TRACE_SYSCALL(), would it not make more sense to have
different versions of __bpf_trace_run() instead of having a runtime
condition on ->sleepable ?
