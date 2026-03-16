Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9410346FA9
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699749; cv=none; b=Ebg7rbBbsIeg3p2+NzvSVNGP6/6uF0H1Rb+DJ7D7OgVIJTJwQFJ2sNVf6SweoEguS/bELlJAmGmxnGxlo51pBU0DBPqyViBPIPdps1IScf0Er9biUXZP7oVrZhUPw/Lb0I1Z2boI/JVgNhiRxRJXkZziRTNrCsum8SgOiKGyqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699749; c=relaxed/simple;
	bh=p1fOV5KYN5slEUV2Dm6egotAnQlzmjDFG3Fx97s+3mY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RuuUxYDmhKIoaJg6zytXH4at2BzS0ojCl7LlkMgQeL5XDdB8QFIm4sNhebrU5X0qYJs6TByICX/FIhIGNMxpR9U3WsVDmhAlJPUEmhIxL+FvNwqRtyvipLNAou9p9d37O4Lb8SiU/a8RCuiftPZuBAyp8X0KaF7FlfG4u/8Kd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZuHEhVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZuHEhVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BC7C19421;
	Mon, 16 Mar 2026 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773699749;
	bh=p1fOV5KYN5slEUV2Dm6egotAnQlzmjDFG3Fx97s+3mY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mZuHEhVrWNDJevHPZzC3KvsGPdzZTeY7QIQBau4kpSy3RIgOGLE1UT20W0V/U+rX4
	 NQ3lsegOfeGmD5WKLyfsVC2lJWBfKSQwBKWUmyCPo8YRYJFwiO4w54hgDKrXvEIaK0
	 AeL6AFbE0Fg1rSLQd0ZaDMRIy5Lx4R0k98PkBofXwAIUlHwXKKP388mLyWCgYbIRjn
	 qIr19ggLgUuF+F0epfUQLbiJeDxgf0a4aG0WgDjRJ9F66cm4kEBc2VNpmXnr9+ruk2
	 jEtp+0DB93mIq+kqjBOLJ5XrgqsrGEyiVbKfL1fWHT7MK/P9nZvC8N7u7JGIZ6EXio
	 TopkPl2wo8fzw==
Content-Type: multipart/mixed; boundary="===============3712691076000029305=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <343cef31e681819b4e1f5a861e3aee63cdf693b6af069da87fdc546472230b3a@mail.kernel.org>
In-Reply-To: <20260316-sleepable_tracepoints-v5-2-85525de71d25@meta.com>
References: <20260316-sleepable_tracepoints-v5-2-85525de71d25@meta.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 22:22:28 +0000 (UTC)

--===============3712691076000029305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 37317b81fcda..8a7677c15f93 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c

[ ... ]

> @@ -1411,12 +1412,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	int size = 0;
>  	int uargs = 0;

perf_syscall_enter() still declares fake_regs:

    struct pt_regs *fake_regs;

and passes it to perf_trace_buf_alloc():

    rec = perf_trace_buf_alloc(size, &fake_regs, &rctx);

but the value is never read after that. Previously it was passed
to perf_call_bpf_enter() for perf_fetch_caller_regs(), but
perf_call_bpf_enter() now creates its own stack-local pt_regs.

The same applies to fake_regs in perf_syscall_exit().

Could these be cleaned up, perhaps by passing NULL to
perf_trace_buf_alloc() since it already handles that case?

    void *perf_trace_buf_alloc(int size, struct pt_regs **regs, ...)
    {
        ...
        if (regs)
            *regs = this_cpu_ptr(&__perf_regs[rctx]);
        ...
    }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23167661157
--===============3712691076000029305==--
