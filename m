Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959B33BBB1
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970809; cv=none; b=EJp03hLErnFLwUhQUtHZ/u3wycNNb/189GZCcrapQC1UtT8YF0wolrP/7QP4ajTASrQ+/Tdi7MqwqWpgroN1q4U4TkrVE4hUIlXhltO38xSgytdJHEFhCk1PXZna6hFxi+Z1psncXhvlQoWPDKHMtPWk8fPjvtZfBiRyfts/848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970809; c=relaxed/simple;
	bh=wqbWE0rwSUZBslS+uzFuRAKeQEu2q8xkj/2gGLpqr8U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KAzNI5ZkLZTGhjPD3Hr2mn21SVaMt36OiBuKfdmPDNpsinShyHoawwYcxMGUdF6nx56D5YU3v+ZaLfVtGcbisyLt1zFcncBgA69I2qS3/nO+gz/V7oxktYQ8YSBUnJ+wpHc6DvW11qOvOt79VyILQKEAmOrdS3CTCXY1sHUco1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqVwN9Of; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqVwN9Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9895C116D0;
	Tue, 24 Feb 2026 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771970809;
	bh=wqbWE0rwSUZBslS+uzFuRAKeQEu2q8xkj/2gGLpqr8U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nqVwN9OfVHSUvDecQLSkK7ZZCWfJgeadRQ1ecC+vdOrfyq7tZWUMS2O99MF2F+67P
	 PuqXKzwzfTDoRuUDhKKcC724UW5lHIfquoIIyVw//pKUUtSfYoj4YQ0iazt0cIB50k
	 oxEghx3H+qtrolsQ2Kzq1pN+ArpYR7i1ABBi7Az6uKcUi/cjOE71QV9CvbHPLWKqPC
	 YF4n9JbtEAVm72Rqp8CXJxKbG8EWlgIzqQI7VMIpBdAXuSZVTVmcVVTGr33oo0rIMf
	 NBBFBkjC0Kf0vujbCrJX1cMkLr50aFotjqdEdaNTq8YlYDfUIxEttoi7MV+Z7pV4n8
	 9QU6NrsJe0AYw==
Content-Type: multipart/mixed; boundary="===============8186444009712332254=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80375dd0a944f4c089b9fe20872b85be6060d91fede8ca36ee314d3b317e64b5@mail.kernel.org>
In-Reply-To: <20260224212535.1165151-5-puranjay@kernel.org>
References: <20260224212535.1165151-5-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Feb 2026 22:06:47 +0000 (UTC)

--===============8186444009712332254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10852,9 +10860,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			return -EINVAL;
>  		}
>
> -		if (env->subprog_info[subprog].might_sleep &&
> -		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
> -		     env->cur_state->active_irq_id || !in_sleepable(env))) {
> +		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
>  			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
>  				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
>  				     "a non-sleepable BPF program context\n");

The condition here now uses in_sleepable_context(), which also
checks forbid_sleep_count. If the rejection is due to
forbid_sleep_count being non-zero, the error message will tell the
user it is a "RCU/IRQ/preempt-disabled section" rather than a
nosleep region.

Both check_helper_call() and check_kfunc_call() use
non_sleepable_context_description() for this purpose:

check_helper_call():
    verbose(env, "sleepable helper %s#%d in %s\n",
            func_id_name(func_id), func_id,
            non_sleepable_context_description(env));

check_kfunc_call():
    verbose(env, "kernel func %s is sleepable within %s\n",
            func_name, non_sleepable_context_description(env));

Should check_func_call() also use non_sleepable_context_description()
to keep the error messages consistent?

[ ... ]

> @@ -11578,6 +11584,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
>  	       !env->cur_state->active_preempt_locks &&
>  	       !env->cur_state->active_locks &&
>  	       !env->cur_state->active_irq_id &&
> +	       !env->cur_state->forbid_sleep_count &&
>  	       in_sleepable(env);
>  }

[ ... ]

> @@ -11591,6 +11598,8 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
>  		return "IRQ-disabled region";
>  	if (env->cur_state->active_locks)
>  		return "lock region";
> +	if (env->cur_state->forbid_sleep_count)
> +		return "nosleep region";
>  	return "non-sleepable context";
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22371254221

AI-authorship-score: low
AI-authorship-explanation: The commit shows deep understanding of BPF verifier internals, iterates on maintainer feedback across multiple versions, and follows established kernel patterns consistently with the author's history as a BPF maintainer.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The error message in check_func_call() does not use non_sleepable_context_description() and will misleadingly report 'RCU/IRQ/preempt-disabled section' when the actual cause is a nosleep region from KF_FORBID_SLEEP, unlike the consistent pattern in check_helper_call() and check_kfunc_call().

--===============8186444009712332254==--
