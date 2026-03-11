Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76802377028
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272397; cv=none; b=Ldp3k9TxfF+cqor9+hI10V7fn5+zVLR0D3ks7LoFXJfm/c90K4ozWmnCCGP7h7Kp1aovASjnZydNrR8qO6DxV4JzFriNwpKElt+ze5iLlzqrxDPaEO3lhxm2WA67UpHyv3WL6HZx+b/YWKCRuhR0Ff2aiLIJpVRC4zhHdu0hEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272397; c=relaxed/simple;
	bh=Vzj9NUIISvpbA2BylgvIpgR40Ye/EcVqMmJ1q39Id6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6Sm7iaFep8jVhpJN254bApnrdGEshhE4x45eZwcjlygFcUdu1JY5ZMK7ncW31w6yuyELQ12ZrKXuUE3q+Mm6HGCKaQIpZMkYAVOiBsLXls0ZhMNsKbQT/TS1aDkukYOJWGBcW3P0SW4B9eT88nfxcEpPmDPhI4WCjQDCV88+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR7LdgTA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR7LdgTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBC2C4CEF7;
	Wed, 11 Mar 2026 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773272397;
	bh=Vzj9NUIISvpbA2BylgvIpgR40Ye/EcVqMmJ1q39Id6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VR7LdgTAIL0uiFwUC/60JMYr1G+sjCnQEztUbHS78qCYzPOTtQsGqd7EI1E7g7EwX
	 SJWvP6wTc6RZ/FPDKu6WE0PX+vJu0G8awcsXetzWHt12whgygJcv0R6Vlduwq6HKgP
	 MdtayJ51/BKAUqwpHl5iUtDw2C6ho94XtyLhgxMXEIHm1d43aULDhrG45mx9ZOYTTt
	 zaIfreuUp31g3n8olpqOh9x3/Pz7ZwYjt04PgxQApTZlWPhZ9FTQwYMRb93YlR0Wcn
	 M7WsgdWkiE7cfzN94h7Simn2d0aykzBYZqQUyv+PVaLdp/H5IPTClCVpIH9PCm5fJ9
	 tcKt3aWgD5QtQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add sleepable execution path for
 raw tracepoint programs
In-Reply-To: <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>
Date: Wed, 11 Mar 2026 23:39:52 +0000
Message-ID: <m2jyvij5pz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Modify __bpf_trace_run() to support both sleepable and non-sleepable
> BPF programs. When the program is sleepable:
>
> - Call might_fault() to annotate the faultable context
> - Use migrate_disable()/migrate_enable() instead of
>   rcu_read_lock()/rcu_read_unlock() to allow sleeping while
>   still protecting percpu data access
> - The outer rcu_tasks_trace lock is already held by the faultable
>   tracepoint callback (__DECLARE_TRACE_SYSCALL), providing lifetime
>   protection for the BPF program
>
> For non-sleepable programs, rcu_read_lock_dont_migrate() is replaced
> with explicit migrate_disable()/rcu_read_lock() pairing.
>
> Remove preempt_disable_notrace()/preempt_enable_notrace() from
> __BPF_DECLARE_TRACE_SYSCALL. Per-CPU protection and RCU locking are
> now managed per-program inside __bpf_trace_run().
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  include/trace/bpf_probe.h |  2 --
>  kernel/trace/bpf_trace.c  | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
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
> index 0b040a417442..3688a7e115d1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2076,7 +2076,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
>  
> -	rcu_read_lock_dont_migrate();
> +	migrate_disable();
>  	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>  		bpf_prog_inc_misses_counter(prog);
>  		goto out;
> @@ -2085,12 +2085,19 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  	run_ctx.bpf_cookie = link->cookie;
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  
> -	(void) bpf_prog_run(prog, args);
> +	if (prog->sleepable) {
> +		might_fault();
> +		(void)bpf_prog_run(prog, args);
> +	} else {
> +		rcu_read_lock();
> +		(void)bpf_prog_run(prog, args);
> +		rcu_read_unlock();
> +	}
>  
>  	bpf_reset_run_ctx(old_run_ctx);
>  out:
>  	bpf_prog_put_recursion_context(prog);
> -	rcu_read_unlock_migrate();
> +	migrate_enable();
>  }
>  
>  #define UNPACK(...)			__VA_ARGS__
>
> -- 
> 2.52.0
