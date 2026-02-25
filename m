Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6A3B8BC9
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039541; cv=none; b=ZQ1Xfh6gX6oE4ngrGa9uF6CvQS+NQ34v35Xp8BJsITOgdQ2KRVOCb6wPiwuOwEIekfU0IHnZvsIj7LcP822GbjqC6tfg3a2UwsdYRg7cGcuxQGyAnJVMw71P5RUTe9l9vYHGepD60a3TEtcMlgHm6yT0DqcZzxmqLCDO6TNTnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039541; c=relaxed/simple;
	bh=QhbytVmJ3nJe2Z4b8rb1kWQPqCNXVmyGpkPGWAdyGAQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JrBOMhyWc7eomkOSTDaGQ9DFF4Oct+r1vUO8u3Lhkf5Hv6kh8C2Df8ljxr2WX7jIv6gKUKUXVugQwROY6cJAwmPJqHwDc04RAxrm84t39aGen1fAPUQ7wWRCTuFQD8i1FsBv4mFMRHNCJ23Zrf9JuC9Fd1OTa4p6fpFTL34DqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adI4/nJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adI4/nJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9046FC116D0;
	Wed, 25 Feb 2026 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039540;
	bh=QhbytVmJ3nJe2Z4b8rb1kWQPqCNXVmyGpkPGWAdyGAQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=adI4/nJ0NZCUVYL+NpQEOHf/W/TlY7d4qLiCdIQOHAYGKDk4epHUuJEftjWieifRc
	 2H+YEr6hvuFnot1T+yVxJLbzAFBoJp8RCkEDF55nbTmffadCsBxFcs8XoOa+XZrgh0
	 UaI+LvVt3SRjVZAgvNyywHu9R+CeW0OA53il/biwF+2KEDV5jNpCsnls+dBR0yHvF1
	 vXANf5dxCjVthLh4EazmIWyYozjTEGvlby3CkTa2C2tQ4rPP+OU0w3K/Zsahr2gbjJ
	 KBKHmpbFDn2el5D10dSuX+gAAdKupJZoNsZEgtg3udD5udAx4xEHD5YmEfBHFSmUkZ
	 JcJiUjf7BAm5Q==
Content-Type: multipart/mixed; boundary="===============0759400336518936477=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a841572b63b4a741b20e14452a230a34203a2fb325275ad57fc5c0568a30c58@mail.kernel.org>
In-Reply-To: <20260225-sleepable_tracepoints-v2-2-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-2-0330dafd650f@meta.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add sleepable execution path for raw tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 17:12:19 +0000 (UTC)

--===============0759400336518936477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9bc0dfd235af..2dd345e0fdb0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -2085,12 +2085,26 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  	run_ctx.bpf_cookie = link->cookie;
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>
> -	(void) bpf_prog_run(prog, args);
> +	if (prog->sleepable) {
> +		might_fault();
> +		(void)bpf_prog_run(prog, args);

At this commit, __BPF_DECLARE_TRACE_SYSCALL in include/trace/bpf_probe.h
still wraps the BPF callback in preempt_disable_notrace() /
preempt_enable_notrace():

include/trace/bpf_probe.h:__BPF_DECLARE_TRACE_SYSCALL() {
    might_fault();
    preempt_disable_notrace();
    bpf_trace_run##x(__data, ...);
    preempt_enable_notrace();
}

Since __bpf_trace_run() is inlined into bpf_trace_run##x(), which is
called between the preempt_disable_notrace() and
preempt_enable_notrace(), the might_fault() here will execute with
preempt_count > 0, producing a warning on CONFIG_DEBUG_ATOMIC_SLEEP
kernels.

More importantly, if the sleepable program calls a helper like
bpf_copy_from_user(), the page fault handler will see in_atomic()
and return -EFAULT for any non-resident page instead of faulting it
in, defeating the purpose of sleepable programs.

The v1 RFC series included a separate patch to remove
preempt_disable_notrace() from __BPF_DECLARE_TRACE_SYSCALL.  Should
that change be folded into this commit so the sleepable path works
at each bisect point?

> +	} else {
> +		/*
> +		 * Non-sleepable programs may run in the faultable context,
> +		 * do cant_sleep() only if program is non-sleepable and context
> +		 * is non-faultable.
> +		 */
> +		if (!link->link.sleepable)
> +			cant_sleep();
> +		rcu_read_lock();
> +		(void)bpf_prog_run(prog, args);
> +		rcu_read_unlock();
> +	}

[ ... ]

The commit message states:

> For non-sleepable programs, behavior is unchanged: cant_sleep() check,
> rcu_read_lock() protection.

The parent commit does not have a cant_sleep() call in
__bpf_trace_run() -- it uses rcu_read_lock_dont_migrate().  The
conditional cant_sleep() is new in this commit.  Could this sentence
be updated to reflect the actual change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22406522761

AI-authorship-score: low
AI-authorship-explanation: Natural, domain-specific language with a small inaccuracy in the commit message that is more characteristic of human writing; code shows deep subsystem expertise.
issues-found: 2
issue-severity-score: medium
issue-severity-explanation: Sleepable BPF programs on faultable tracepoints cannot actually sleep because __BPF_DECLARE_TRACE_SYSCALL still wraps execution in preempt_disable_notrace; this defeats the purpose of the feature and produces debug warnings, but does not crash the system.

--===============0759400336518936477==--
