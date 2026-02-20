Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E633E37B;
	Fri, 20 Feb 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585072; cv=none; b=TmPh8f4n0pQLi1RTrnOvUDSY0Gpyqo01/Gonz78SU/QUg7FxjE4oVvfwope3X0FR/Bk+8tA/Jmf+vTGpZ9Mv30SK59m+ytrhUgiQZJcTTfLgeR7GE7uuGHGCuPJX4ikahVa3gVwnEI6jzP0ExsWIQ4PkLEBAqFnMKsZxYnyWAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585072; c=relaxed/simple;
	bh=4c80v6awvG+NSVEF4d+5rGgWDXwN4Z7Mi3MKZaeXv8I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=orii9W+6dquBXzYF1VWtFqolfUh3LsJP+v3P97QReEYFj+NJ34onGqrB+KCqgQQvggdak/zvvJvmDUMpZ2vFpWR1v8/Xdx25gij3tqSl27yK8ClAIBgLPdfNZLu7BPKnwcOKAJpIc85bwKF4LYrVGdu53FP1OLphGDDeB6pmCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkNoXj0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkNoXj0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD79C116C6;
	Fri, 20 Feb 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585071;
	bh=4c80v6awvG+NSVEF4d+5rGgWDXwN4Z7Mi3MKZaeXv8I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VkNoXj0GyYx0bj8RwSRvg0RtzjdsMNWAKYaYk2Uj+DD7s8dhWdJQdIkIvwks9Y1Bz
	 uYVfv7QgZCJDE6N49gKUrrHPuifNxUbN7bGDuBcToKxwEIi9LwEXE5dtPhxwClLtQg
	 LJTkruTUGHyzfuz8rkn1q6EGcNWXSsTKhcYO8s3lUse+ucf4iPWWknwJS9rOZtfTkA
	 ZE2SKi1bTEkGRpu/l0MsIICo4PoN1ylVuhMP34mLMJsW+7uZw4RdpHuYETMk3izjD1
	 sL7nl1chRIaAZaCNc0NYTqYcaXp35YXT5hItcBuPLi5lxdMIHsuDSIooamTuEPOXZP
	 G8n5swLtcrJtw==
Content-Type: multipart/mixed; boundary="===============5719890851182572125=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa8d95a4f3b4fa59b0cca8b65faa300ab18d956d32443985e8e09f506a8cb1ad@mail.kernel.org>
In-Reply-To: <20260220100649.628307-3-jolsa@kernel.org>
References: <20260220100649.628307-3-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 10:57:51 +0000 (UTC)

--===============5719890851182572125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -71,7 +110,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
>  		/* This is called inside register_ftrace_direct_multi(), so
>  		 * tr->mutex is already locked.
>  		 */
> -		lockdep_assert_held_once(&tr->mutex);
> +		lockdep_assert_held_once(trampoline_locks_lookup(tr));

This comment still references tr->mutex, but the field was removed from
struct bpf_trampoline by this patch. Should the comment say the
trampoline pool lock is already held instead?

[ ... ]

> @@ -102,7 +141,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
>  	/* The normal locking order is
>  	 *    tr->mutex => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
>  	 *
>  	 * The following two commands are called from
>  	 *
>  	 *   prepare_direct_functions_for_ipmodify
>  	 *   cleanup_direct_functions_after_ipmodify
>  	 *
>  	 * In both cases, direct_mutex is already locked. Use
>  	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
>  	 * (something else is making changes to this same trampoline).
>  	 */
> -	if (!mutex_trylock(&tr->mutex)) {
> +	if (!mutex_trylock(trampoline_locks_lookup(tr))) {
>  		/* sleep 1 ms to make sure whatever holding tr->mutex makes
>  		 * some progress.
>  		 */

The locking order comment and the two references to tr->mutex in this
block also appear to need updating. The locking order is now pool lock
rather than tr->mutex, and the trylock and sleep comments still name the
removed field.

[ ... ]

> @@ -1026,11 +1065,11 @@ struct bpf_attach_target_info tgt_info = {};
>  	/* note, we're still holding tr refcnt from above */
>
> -	mutex_unlock(&tr->mutex);
> +	trampoline_unlock(tr);
>
>  	return 0;
>  err:
> -	mutex_unlock(&tr->mutex);
> +	trampoline_unlock(tr);
>
>  	if (shim_link)
>  		bpf_link_put(&shim_link->link.link);
>
>  	/* have to release tr while _not_ holding its mutex */
>  	bpf_trampoline_put(tr); /* bpf_trampoline_get above */

Similarly, this comment in bpf_trampoline_link_cgroup_shim() references
"its mutex" which no longer exists as a per-trampoline field.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181

AI-authorship-score: low
AI-authorship-explanation: Well-motivated infrastructure patch by known BPF maintainer with collaborative development history (Suggested-by tag) and idiomatic kernel coding patterns; stale comments are a typical human oversight.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Stale comments in bpf_tramp_ftrace_ops_func reference the removed tr->mutex field in locking order documentation, which could mislead future developers but has no runtime impact.

--===============5719890851182572125==--
