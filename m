Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87F223323
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438090; cv=none; b=bL1yEj7OhQkSEGCX+mSyEqm+OTBzE2ahGOBOK4/W+jHuZXqApnSjBl4rMvJkH4IaCkYY/+M7B+kxExNXbnAvcBMO4TPNkN4yWfew7YW4R0Z6/BFdFCOWwQJcc747vpT1A0YWAZFSzvdyRqBAHfcd0F2CqbdDpTw1CEAxN2Faj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438090; c=relaxed/simple;
	bh=RAQx+Emt6GfSxsFf4gWYK7iOpXQbGUzP/YnvQ4OxLWI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CC2TXCzk02xn+bMcslQwdx3uU3PzUtnIezvxZd/w1Ybyy8xCEGCE9ftxjpvfXF8f2K6eiP/vCFt1dPxDmpBcSzr7axm4MO0wAgMhZmMzvN7l8w2hGqcbXKgfVUY9Z6f+XGp6ppO334Ti6UpEtxNnfF0FVqMDA2XjmJAdFSquwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbYNjnuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbYNjnuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831F8C19421;
	Fri, 13 Mar 2026 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773438089;
	bh=RAQx+Emt6GfSxsFf4gWYK7iOpXQbGUzP/YnvQ4OxLWI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sbYNjnuLXnk/PBZhBdkzBcrcxuy6fgTftTo1nyqCJ3vPkOHMZVpbZiSYyRwOvoNVE
	 EjileyCBqAquWLxbBBQywjarAbercgQbOqXe85Juz8ZfXsNpq/eEoNaLkRSVJqz1dF
	 X2B5DwcBu5iiVzx1IHHqgJEKcQjiw41CLtt8JEV72IWjxoDCD1hfdvll2Ta58LcqZp
	 sBUCTDzpNkr/OIQpmXCMFpZrL9OUxOicyvunE8X8tRN569BK+UQ3rQEbIbijiKcqIC
	 7ooDtO4ge+HfSS9MAjmToGkOu1SiLxaf4HtA1Xiwao3EPuxxowbUifn9psLE/GKQFF
	 hTr6liM7ecR4w==
Content-Type: multipart/mixed; boundary="===============0472075779639375511=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b72de8b719f8d7d01f3c90c05fe8c0c3640dce8164cd89c65433085593e0e856@mail.kernel.org>
In-Reply-To: <20260313-sleepable_tracepoints-v4-2-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-2-debc688a66b3@meta.com>
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Add sleepable support for classic tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 21:41:29 +0000 (UTC)

--===============0472075779639375511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 37317b81fcda..e9ddf9db2b56 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -1372,26 +1372,27 @@ static DECLARE_BITMAP(enabled_perf_exit_syscalls, NR_syscalls);
>  static int sys_perf_refcount_enter;
>  static int sys_perf_refcount_exit;
>
> -static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *regs,
> +static int perf_call_bpf_enter(struct trace_event_call *call,
>  			       struct syscall_metadata *sys_data,
> -			       struct syscall_trace_enter *rec)
> +			       int syscall_nr, unsigned long *args)
>  {
>  	struct syscall_tp_t {
>  		struct trace_entry ent;
>  		int syscall_nr;
>  		unsigned long args[SYSCALL_DEFINE_MAXARGS];
>  	} __aligned(8) param;
> +	struct pt_regs regs;
>  	int i;
>
>  	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
>
> -	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
> -	perf_fetch_caller_regs(regs);
> +	/* bpf prog requires 'regs' to be the first member in the ctx */
> +	perf_fetch_caller_regs(&regs);

Should regs be zero-initialized here? The perf_fetch_caller_regs()
comment in include/linux/perf_event.h states:

    NOTE: assumes @regs is otherwise already 0 filled; this is
    important for things like PERF_SAMPLE_REGS_INTR.

The function only sets ip, sp, cs, and flags, leaving all other
register fields at whatever happened to be on the stack.

Previously, the regs pointer came from perf_trace_buf_alloc() which
returned this_cpu_ptr(&__perf_regs[rctx]), a per-cpu variable that
is zero-initialized at boot. The new stack-local struct does not
get that zeroing.

If a BPF program calls bpf_perf_event_output(), bpf_perf_event_output_tp()
extracts this pointer:

    struct pt_regs *regs = *(struct pt_regs **)tp_buff;

and passes it through to perf_event_output(), where uninitialized
register fields could end up in perf samples.

Would initializing to zero fix this?

    struct pt_regs regs = {};

> +	*(struct pt_regs **)&param = &regs;

[ ... ]

> @@ -1515,21 +1519,22 @@ static void perf_sysenter_disable(struct trace_event_call *call)
>  		syscall_fault_buffer_disable();
>  }
>
> -static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *regs,
> -			      struct syscall_trace_exit *rec)
> +static int perf_call_bpf_exit(struct trace_event_call *call,
> +			      int syscall_nr, long ret_val)
>  {
>  	struct syscall_tp_t {
>  		struct trace_entry ent;
>  		int syscall_nr;
>  		unsigned long ret;
>  	} __aligned(8) param;
> -
> -	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
> -	perf_fetch_caller_regs(regs);
> +	struct pt_regs regs;
> +
> +	/* bpf prog requires 'regs' to be the first member in the ctx */
> +	perf_fetch_caller_regs(&regs);

Same uninitialized regs concern as perf_call_bpf_enter() above.

> +	*(struct pt_regs **)&param = &regs;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23070834076
--===============0472075779639375511==--
