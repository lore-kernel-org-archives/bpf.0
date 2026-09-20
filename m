Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB23002DD;
	Sun, 20 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889451; cv=none; b=edvkCPfeF1SazAEvp2fwIU/q6IQGpOQ+dXZYJ8/zOT4kLBcX3ocIwsHddevs9kzTJ22ZzipRcInbhjly70FT0TeS8DeuSbtnKmvCrVXIVSUtAlKY3vy51AulSI4c62m6Ta8MQrYO6Tl/cs3U4g4MWmPidFbY2enmCh7HGfaOHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889451; c=relaxed/simple;
	bh=hmw7PL6rA600kATIzt8ky7c+Ug3B0QKSJP/gM/Lp/sQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KakmugWpWB4G4qjVuP6zv9udPUwhuB+ta4n0dPQfO0LXT3lsRy4b5cXwpx0CSkkup/fU+Xr5SoL0z3nE/QF8YJnqbjtyylV7uJp+eD3y5S+9uHHHg9Nid38usVua1r7I3w4g/bxZmBwsEY9R0OlAjgS7tL5MRojnqDuKNjRAGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuD+4cwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuD+4cwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751E41F000FF;
	Sun, 20 Sep 2026 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789889450;
	bh=NlcQPH+hnV8k+jkyyiuMykhGBZ8m+4m85Q2Yy0P4LsI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EuD+4cwI1om3+k6trMDbGR6lIg817UZgwYUOnfM8yDv81K9zWwxeJbpxsmu1jYmGU
	 0ulrGgk8F9dAAxpHHlLBET0+gh0QZQcHDW+NbacBiQ+c2tUOHa1f+0mZ6kqT4jXNM3
	 KbzM3XlPoS4m8kHdy+0Kivl3nL06N/41gDi4KXqsb82sdWuTsf3k8hXOhlhEbZ5xKf
	 TClEBYzPuhBHCrl1HXDKleAgiqGsh7dtFSNWQGvUk2E0L+JMsUZNkkZtRX9l3G4lr/
	 coJG6B8W/j0BEM2R3qSlBJLITnuNPOzDlNmIink8/iZ6GlJJcMk0IkoXZlNndymkMm
	 g5DB3VXB9cVfg==
Content-Type: multipart/mixed; boundary="===============8035067619570924591=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4a411cdeff7f7ac68d0c938b22e0acf2c8beb96db88ba1ee7961c981efb3394c@mail.kernel.org>
In-Reply-To: <20260920063442.499577-1-yangfeng59949@163.com>
References: <20260920063442.499577-1-yangfeng59949@163.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject bpf_skb_output() from return-side tracing
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 07:30:47 +0000 (UTC)

--===============8035067619570924591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..cdede3926e5d6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1339,6 +1339,20 @@ static inline bool is_trace_fsession(const struct bpf_prog *prog)
>  		prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI);
>  }
>
> +static bool tracing_prog_may_run_after_target(const struct bpf_prog *prog)
> +{
> +	/* The target may consume pointer arguments before these programs run. */
> +	switch (prog->expected_attach_type) {
> +	case BPF_TRACE_FEXIT:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +

Does this new helper need to be static inline? The function is defined
unconditionally here but only referenced inside the CONFIG_NET block of
tracing_prog_func_proto():

kernel/trace/bpf_trace.c:tracing_prog_func_proto() {
    ...
    switch (func_id) {
#ifdef CONFIG_NET
    case BPF_FUNC_skb_output:
        if (tracing_prog_may_run_after_target(prog))
            return NULL;
        return &bpf_skb_output_proto;
    ...
#endif
    ...
}

bpf_trace.c is built from CONFIG_BPF_EVENTS (kernel/trace/Makefile) which
depends on BPF_SYSCALL and (KPROBE_EVENTS || UPROBE_EVENTS) and PERF_EVENTS
(kernel/trace/Kconfig) -- none of which imply CONFIG_NET.

CONFIG_BPF_EVENTS=y with CONFIG_NET=n is valid, and in that configuration
tracing_prog_may_run_after_target() becomes a defined-but-unreferenced
non-inline static:

  kernel/trace/bpf_trace.c:1342:13: warning: 'tracing_prog_may_run_after_target' defined but not used [-Wunused-function]

With CONFIG_WERROR=y (init/Kconfig) this becomes a build failure.

The pre-existing predicates immediately above (is_kprobe_session(),
is_uprobe_multi(), is_uprobe_session(), is_trace_fsession()) are all
written as static inline, which is why they don't trigger this warning.

Would declaring tracing_prog_may_run_after_target() as static inline fix
this?

>  static const struct bpf_func_proto *
>  kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -1730,6 +1744,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	switch (func_id) {
>  #ifdef CONFIG_NET
>  	case BPF_FUNC_skb_output:
> +		if (tracing_prog_may_run_after_target(prog))
> +			return NULL;
>  		return &bpf_skb_output_proto;
>  	case BPF_FUNC_xdp_output:
>  		return &bpf_xdp_output_proto;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35495259029
--===============8035067619570924591==--
