Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA7329E70
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432793; cv=none; b=RvWOHl/R031vmZWWIW4YJXZAJx6rFsLz4lLDi5mMdV6Ut14kW8iBXnLaAcD/oLCnXeF83/mLL7iJnXdAOpy/AJDE62D8aBQwB47VG0a4+6pkr58j0oyR0kNzk5TFFITZIivksZrSv1a6UMpAgk5phSbNLR96LoBVy2zRuRZGDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432793; c=relaxed/simple;
	bh=B/3/8L4+CAGl98Z/pNpGGWjEAg81ivOoiLbgFDxO7go=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GLYnDhrzEk8cnq8B88yyE46ffDk0iodSVd0dInm1bRIZE7CtwTP+lxOTBzbITKi6RgGRxbFuFPs1hAIuEGo2OBJ0+srUFfF0V8fYVpKU6vlbNhhU4Yu9VVO8CNrKUvZhtO8PBH/t0oeVBKxa8C24RRgIAQ5i/j0Il+xguIKk7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpjUuwf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpjUuwf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002F7C19422;
	Wed, 18 Feb 2026 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771432793;
	bh=B/3/8L4+CAGl98Z/pNpGGWjEAg81ivOoiLbgFDxO7go=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gpjUuwf+I5g5EPks0mfBTBUftvLdV5HVS28z/3WAjXOzBf2dEszw2nIqOvSiwv1O6
	 2kir/kAEa0Nkd3eybf3H4TMnHxT4FnPwemRgpu7qJdj1KYvNsj0LvLcqN5CH2xDczy
	 y22cLsHqaJrHgwgzTnFzfQe4usbV8GZ3/47RueoEQl6WTHk5dAW28k6B/2TbB9+3gb
	 ENMKfFfJJiNnZfiDF1MiLN7R/3+0spjq+DhPQ49j+zdJTY3J1akf1q8X1z6NPAQgNN
	 tcFxq7zk/S3NjFaq8kMh8w6EeNmOw2whV28I2yvNOu+xWjGiaP2iXzTadk8qRzTP7w
	 Yp241IgAKsV7A==
Content-Type: multipart/mixed; boundary="===============5825352445138964626=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b6f45f4af6b2ed6a5b3b39e734cc88490c9bbd0f2d63d67601895d8b31ba0bb@mail.kernel.org>
In-Reply-To: <20260218-sleepable_tracepoints-v1-3-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-3-ec2705497208@meta.com>
Subject: Re: [PATCH RFC bpf-next 3/6] bpf: Remove preempt_disable from faultable tracepoint BPF callbacks
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Feb 2026 16:39:52 +0000 (UTC)

--===============5825352445138964626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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

At this commit, __bpf_trace_run() still uses cant_sleep() and
rcu_read_lock() without any migrate_disable():

kernel/trace/bpf_trace.c:__bpf_trace_run() {
    cant_sleep();
    if (unlikely(!bpf_prog_get_recursion_context(prog))) {
        ...
        goto out;
    }
    ...
    rcu_read_lock();
    (void) bpf_prog_run(prog, args);
    rcu_read_unlock();
    ...
out:
    bpf_prog_put_recursion_context(prog);
}

The per-cpu recursion counter in bpf_prog_get_recursion_context() uses
this_cpu_inc_return(), and bpf_prog_put_recursion_context() uses
this_cpu_dec(). Both operations are outside the rcu_read_lock() region.

Faultable tracepoint callbacks run under guard(rcu_tasks_trace) which
does not disable preemption. With the preempt_disable_notrace() removed
and no migrate_disable() added yet, can the task be preempted and
migrated between the per-cpu increment and decrement on PREEMPT_RCU
configs, corrupting the recursion counter?

The next commit in the series (3c61c093bde8 "bpf: Add sleepable
execution path for raw tracepoint programs") adds migrate_disable()
to __bpf_trace_run(), which would address this. Should these two
patches be reordered, or combined, so that the protection is not
removed before its replacement is added?

> The preemption management is now handled inside __bpf_trace_run()
> on a per-program basis: migrate_disable() for sleepable programs,
> rcu_read_lock() (which implies preempt-off in non-PREEMPT_RCU
> configs) for non-sleepable programs.

This description does not match __bpf_trace_run() at this commit.
The function has no migrate_disable() and does not differentiate
between sleepable and non-sleepable programs. Should the commit
message describe the state at this commit rather than after the
subsequent patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22147696553

AI-authorship-score: medium
AI-authorship-explanation: The commit message describes per-program preemption handling (migrate_disable/rcu_read_lock) that does not exist at this commit, reading like an auto-generated summary of the series rather than this specific patch; the code change itself is a simple two-line deletion consistent with human authorship.
issues-found: 2
issue-severity-score: medium
issue-severity-explanation: Patch ordering leaves per-cpu recursion counters unprotected from migration on PREEMPT_RCU configs between this commit and the next, which could silently disable BPF programs on affected CPUs; the issue is fixed by the subsequent commit in the series.

--===============5825352445138964626==--
