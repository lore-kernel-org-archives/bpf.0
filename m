Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086894;
	b=zIiD4XQHoKvt+N92ptSnSJ5CSmvts2dMLQsUPmOM/sXM78oIns8pqj2ipI/Niv2paz+O
	 bvcnX6kmPmSf0Cd4AiJvuH9Uw+MpoiVveFbiaMmtgMHYSMSTKr1ojVO4v+rxRRP+ZMEAK
	 gDEJmAvzO+tearnNjNeuLY/dCl1vL8xn1Z8iWq7398BDlEyYJ1aHmfho9JIh00B9w2CQF
	 5rUVecx+sGErL3gP2/vswiqjGLkHB97fN4zyaV41qlC/VhxBleqeUfryNxMuJBDiTDCV0
	 B2e6bMtqD6Y/GA+izKphR53JFrDSant6oDBFifklByEB4j+G83V0Ou+7BE9NoKyvkug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086894;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DYwwS3RjGFhHe7GQGIU2RiD97iNHq+hyhTB0qLqdGVk=;
	b=xrbcLc5pZ/NSyqkHQhRQoblNmZ7f9BdOdwVl5triLs5lHFtGmFl2doiPXTZHQxGn8Mi0
	 YrAzK7T+u7Ih+yhNBogtpiAZPoylJITT9hBAEQj3hFXcbnSXQpdrG0th/a300q10i0YfM
	 Zh/r0cisZaI946DDFBxnW3/RztuL9uND8eVgTSPECRWRLhEDPi+4sCWLZvB2tfu3wxy22
	 wNBKWE6gO5lh8Wb8TyVZ+mGR3c2pkB9cikD+35LLQSLlJMULG8KRcVvb7kJVmneeqFRL0
	 o0lq5vqQH9V/lJYzv+oLASdJVwkeD/Kg9nI8Pc6BjtrVbDdiz7RqJbl/K0+15hPwyQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUQnG7Ei;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA18606A320;
	Thu, 19 Nov 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUQnG7Ei
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D6E1F000C4;
	Thu, 19 Nov 2026 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086894;
	bh=DYwwS3RjGFhHe7GQGIU2RiD97iNHq+hyhTB0qLqdGVk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CUQnG7EiABomIGTHDj88SO6aR6SQwk3GEgzTKDFJm06uSHpJNvj7HxwnTLOoYNFZn
	 l+SeaiuX+fI2xukjF78GW+JBa0eTeMUhM4DlK39Y9GPpSwGQSJnE/sx9XAo1SNKg21
	 mipDFhMKFaJmnhi4bhgNCD/Wfi+QThhCkCmxCI22YBE+wJAXwAzkVUXlfqRZmeqHDr
	 0hOL8xRf0tUzsTVfKXP4xxzUwcU1DzUi7P0nGOU7h8XRxETPm0F1ISstbqEO0ESXJs
	 ZeAcvdOR9ZodeNy8HIY3Ri6KcxFzhF/zaQXPmBlzEjemt27CzsWBUz0Tt2y2p5pJSO
	 IwhzCbyaiWWMA==
Content-Type: multipart/mixed; boundary="===============1667663467959058832=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <77d978d7f9343e907651b4d4d81ec1c1405dce42f75e33b169f729f208029fcc@mail.kernel.org>
In-Reply-To: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
References: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Use an on-stack pt_regs in the raw tracepoint helpers
From: bot+bpf-ci@kernel.org
To: mike.bazov@gmail.com,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,kpsingh@kernel.org,matt@bobrowski.net,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,mike.bazov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 11:14:51 +0000 (UTC)

--===============1667663467959058832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use an on-stack pt_regs in the raw tracepoint helpers

TL;DR: Without the per-CPU slots, nested raw_tp/fentry programs may hit the
WARN_ON_ONCE in bpf_perf_event_output() (panic with panic_on_warn); the commit
message's claim of no more -EBUSY also looks wrong.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

>  BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args *, args,
>  	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
>  {
> -	struct pt_regs *regs = get_bpf_raw_tp_regs();
> -	int ret;
> -
> -	if (IS_ERR(regs))
> -		return PTR_ERR(regs);
> -
> -	perf_fetch_caller_regs(regs);
> -	ret = ____bpf_perf_event_output(regs, map, flags, data, size);
> +	struct pt_regs regs = {};
>  
> -	put_bpf_raw_tp_regs();
> -	return ret;
> +	perf_fetch_caller_regs(&regs);
> +	return ____bpf_perf_event_output(&regs, map, flags, data, size);
>  }

Can this reach the WARN_ON_ONCE() in bpf_perf_event_output() using only
raw_tp and tracing programs?

bpf_perf_event_output() still has a three-level limit:

    nest_level = this_cpu_inc_return(bpf_trace_nest_level);

    if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
        err = -EBUSY;
        goto out;
    }

Before this patch, every raw_tp/tracing caller first took a
bpf_raw_tp_nest_level slot, so a fourth nested caller got a silent -EBUSY
from get_bpf_raw_tp_regs().  That function's WARN_ON_ONCE was removed by
commit 3880cdbed1c4 ("bpf: Fix WARN() in get_bpf_raw_tp_regs") after a
syzbot report of this kind of nesting.  The WARN above could only fire if a
kprobe, tracepoint or perf_event program was also in the chain.

With the slots gone, a chain of only raw_tp/tracing programs can get there.
For example, a raw_tp program A calls bpf_perf_event_output() (nest 1),
and its __bpf_perf_event_output() calls perf_event_output().  Fentry
programs B, C and D attached to perf_event_output() also call
bpf_perf_event_output(), and each is let through once by its own
prog->active check, so they run at nest 2, 3 and 4.  At D the WARN_ON_ONCE
fires, and with panic_on_warn the kernel panics.  The same depth is
reachable across task, softirq, hardirq and NMI context.

This also seems to contradict the commit message:

> the helpers no longer fail with -EBUSY when nested more than three deep

For bpf_perf_event_output() the three-level limit remains, coming from
bpf_trace_sds and bpf_trace_nest_level.

Should the WARN_ON_ONCE in bpf_perf_event_output() be dropped, as
3880cdbed1c4 did for get_bpf_raw_tp_regs(), and should the commit message
say that bpf_perf_event_output() keeps its three-level limit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44508926690
--===============1667663467959058832==--
