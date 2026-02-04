Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336D34D4F1
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770179576; cv=none; b=sx2VcE8GZUhAjf1lkbleF9h8C9Jd7BYkRvC2fWB9PKkKuM3bH+NTTDhn1d9Di4Pg1RP8M5qB34xRSsI8K7fR89iX9XssHkUXhQ17jiOlsxs3o7uLBgVDelL4+QPpv+CK5TvStmap4Tfbqd4ZDtwGxfVm/t8DhqFauDn6hMmRpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770179576; c=relaxed/simple;
	bh=S4hpv3tY6K9QTi6qo3Wo8Z4MvSkB/FBwjj1GZRRR9OA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jJp7YP+DpmavfLhsTCa9bTJ1mSWlO4h0i6iHLo/bNh8XIUXq5jzDQ9+wJQ2zI/dmUMBY752llVAqb+Xn87YBvUQS3xtgEsMHM3Tcm+BCg0PB1V6GrpHmW+FKNor0PKrllVRrYAv2PFmUClRkwgC9K/TglK1q4yDLfi3qmBQT/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBhldtfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBhldtfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0BBC4CEF7;
	Wed,  4 Feb 2026 04:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770179572;
	bh=S4hpv3tY6K9QTi6qo3Wo8Z4MvSkB/FBwjj1GZRRR9OA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BBhldtfYQCCPa9y22QI6MxksXWtJDDfB8xNQPICGMLzL+e7v0AUuc7NkFDJ8wOm2S
	 ErUczS/zy2l5NS6fGowcN7q4Qh1Bw8dcuQr4SZJ3ZzH11QzfYPHYtOX4I+rZu9cTdM
	 tvZbTUsIapdzF32R01ijpLHQZV5PZ5VT1QB8eyTQza+Lwbvn1xoqjmD0ysz2rd+Smd
	 SdfRy99W2S6qbARbZ9dojRSQ7SFJwcZ8tlsAiSOnU74xaO5DrkwjzATi008qS/piSb
	 SGVwEdQCh+64e2Ofa4Z82x8c2FzgSHvR1X22f1w+2UmofSDPMZjZEiDtCFjBlG59IC
	 Nuv+iZsd9AnBw==
Content-Type: multipart/mixed; boundary="===============2398488973595102307=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb0adc9970d86753384e9813ede5972e82bda367a3a9b1f7aa62551c05411e4d@mail.kernel.org>
In-Reply-To: <20260204040834.22263-4-alexei.starovoitov@gmail.com>
References: <20260204040834.22263-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Add a recursion counter to prevent loops in bpf_timer
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,mykyta.yatsenko5@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 04:32:52 +0000 (UTC)

--===============2398488973595102307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 0517e9a8f..0f681a89b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1427,9 +1427,21 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
>  	return 0;
>  }
>
> +static DEFINE_PER_CPU(int, async_cb_running);
> +
>  static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
>  				 u64 nsec, u32 timer_mode)
>  {
> +	/*
> +	 * Do not schedule another operation on this cpu if it's in irq_work
> +	 * callback that is processing async_cmds queue. Otherwise the following
> +	 * loop is possible:
> +	 * bpf_timer_start() -> bpf_async_schedule_op() -> irq_work_queue().
> +	 * irqrestore -> bpf_async_irq_worker() -> tracepoint -> bpf_timer_start().
> +	 */
> +	if (this_cpu_read(async_cb_running))
> +		return -EDEADLK;

Does this early return leak a reference? Looking at the callers:

bpf_timer_start() does:

    if (!refcount_inc_not_zero(&t->cb.refcnt))
        return -ENOENT;
    ...
    return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);

The refcount is incremented before calling bpf_async_schedule_op(). The
existing -ENOMEM path in bpf_async_schedule_op() releases this refcount:

    if (!cmd) {
        bpf_async_refcount_put(cb);
        return -ENOMEM;
    }

But the new -EDEADLK path returns without calling bpf_async_refcount_put(cb).

The same issue affects bpf_wq_start() and bpf_timer_cancel_async(), which
also increment the refcount before calling bpf_async_schedule_op().

> +
>  	struct bpf_async_cmd *cmd = kmalloc_nolock(sizeof(*cmd), 0, NUMA_NO_NODE);
>
>  	if (!cmd) {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21658239378

AI-authorship-score: low
AI-authorship-explanation: The commit follows established kernel conventions, comes from a known BPF maintainer, and addresses a real technical issue with code patterns typical of experienced kernel developers.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: The new -EDEADLK error path does not release the refcount taken by callers, leading to reference leaks that can cause memory exhaustion over time.

--===============2398488973595102307==--
