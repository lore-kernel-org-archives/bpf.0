Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F14ABBB8;
	Mon, 12 Oct 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821516; cv=none; b=IbONGcJiw9eFnoePhUKSZIyCWcWtY89JMXNBkjcR55UKP+c9TD0YV0cUXSOuAt0BH2wRwjqTYfKFYaTY4vajsLg3zCKq4iVCDeFKWsN6FSN8qkv0BKG4xYGfcXW12GK2g22nWf9pt5JC102f8DR7KUwf8hwQH/MWGDTHjDPGIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821516; c=relaxed/simple;
	bh=etQEV/62subeHUSfHFRkYVbdp3u2A0a8bVZCelcGd6I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aJjbkuBdGkLpWyiqJJwsakcfB3hYpQAAJ2X551ELgU3zVlqDGAYW5/IcKCBXn5Ctjs2aVjXv4eS6paJx0Ig9V+TOlrH7a7RGyHrTu2zXxszMgkAW2DDjP6qqTZQprHHldzF7SsBn1BK9pQDWT2cP3/tvMUeIacGD9r1o0FKuJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+JbIG/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+JbIG/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352B71F0089C;
	Mon, 12 Oct 2026 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821513;
	bh=oHMngNea3ThDSRS18NpTPABrzpXh0+1e1D1cwHmHRvU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l+JbIG/4jjrneTxf+w8rglNeBTCfnmjGClrDoksnxWTPz1QTrfsZaCX8N2ZPl+/c2
	 cnggf5CeraJzu5RFbuJ21bhkoZTbVOvHkv7CjkPABNLQVKqiXEWNo3uihuA6G+l1+X
	 jYn81aBOA3Wmgs+ACz7mJN+U4YK6EKojo9A2xChnWNBXReNgCQGi9izl0Bas6N/rX9
	 gFt88qSEwt+fWWHSp1n4NetXZFVkOJh2HyKbcpxUFKVeE1B9QP+YoKL0zle9s1qddc
	 T2T+AUo20748IwjNtZWmKzRrPWX4k5XePNqSSxzMBBMMtgWKjMIW/aD4gp0e4btllp
	 OZ1VvW67v2Dug==
Content-Type: multipart/mixed; boundary="===============4316976094327861682=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6dde27849db2f38caae71422579693dde1a24c280e22c3174a770be74f877787@mail.kernel.org>
In-Reply-To: <20261012154024.29423-9-leon.hwang@linux.dev>
References: <20261012154024.29423-9-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 08/21] bpf: Move helpers out of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard in trampoline
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:11:50 +0000 (UTC)

--===============4316976094327861682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Move helpers out of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard in trampoline

TL;DR: Moved trampoline helpers may trigger unused-function warnings (build
failure with CONFIG_WERROR) on non-x86_64 configs with CONFIG_BPF_SYSCALL
until a later patch adds callers; only this commit is affected.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a2fd0bd8c685..bb832af8703f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -60,6 +60,32 @@ static void trampoline_unlock(struct bpf_trampoline *tr)
>  	mutex_unlock(select_trampoline_lock(tr));
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +static void trampoline_lock_all(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
> +		mutex_lock(&trampoline_locks[i].mutex);
> +}
> +
> +static void trampoline_unlock_all(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
> +		mutex_unlock(&trampoline_locks[i].mutex);
> +}
> +
> +static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
> +{
> +	tr->multi_attach.old_image = tr->cur_image;
> +	tr->multi_attach.old_flags = tr->flags;
> +}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +

Can this add a new "defined but not used" warning on configs that have
CONFIG_BPF_SYSCALL but not CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS?

These three helpers are static and are now guarded only by
CONFIG_BPF_SYSCALL, but their only callers at this point in the series,
bpf_trampoline_multi_attach() and bpf_trampoline_multi_detach(), are still
inside:

#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS) && \
    defined(CONFIG_BPF_SYSCALL)

trampoline.o is built for CONFIG_BPF_JIT, and only x86_64 selects
HAVE_SINGLE_FTRACE_DIRECT_OPS.  On arm64, riscv, s390, x86_32, or x86_64
without DYNAMIC_FTRACE_WITH_DIRECT_CALLS, a CONFIG_BPF_JIT=y,
CONFIG_BPF_SYSCALL=y build would define trampoline_lock_all(),
trampoline_unlock_all() and bpf_trampoline_multi_attach_init() with no users,
and -Wunused-function would warn for each of them.  With CONFIG_WERROR=y that
becomes a build failure.

The commit message says the CONFIG_BPF_SYSCALL guard is kept "to avoid
compiling warning when CONFIG_BPF_SYSCALL is disabled", but this seems to
trade that warning for the same kind of warning when CONFIG_BPF_SYSCALL is
enabled.

The helpers only get callers outside the old guard in a later patch of the
series, commit 59e80b53cc6b ("bpf: Add
bpf_trampoline_multi_prog_attach/detach()"), which adds users under
#ifdef CONFIG_BPF_SYSCALL.  So the final state looks
fine, but this commit on its own does not build warning-free on those configs.

Would it make sense to fold this move into that later patch, or mark the
helpers __maybe_unused for the interim, so each commit in the series builds
cleanly?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============4316976094327861682==--
