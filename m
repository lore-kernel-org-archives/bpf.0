Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A63ED3CE
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779279; cv=none; b=kQ5Gkmexiyc0Mw3Z3q9hKyXXQeQ8TNI+ZuBGWhWZ5NBEEsjgVWcNey7uIXZ0+KBcWp7P/09GCxpFRxn5cbbCVdpWgnMM7DFPRAt/65oIbfBl7/lqf7u1XedBR5AkTvPf9aIhG/LEGegiE3eZ7qGHaI4i2NbIBGz7cnl1jRwer1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779279; c=relaxed/simple;
	bh=ujxAgRDyKxz1k/ec+iXLqxqRx5c3bG+GLFHjFcHM/qI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b0xXzxegyskY/qW+Nix60rUgcQ93jTXbeNJQb6ErkjLqOLMM8eB7dpgcYi0VoCvX/apdvlUQfZJTkNf+FtI7+lthGlc8fjzPZvAKv3wHMHcYK2WkWiYtlZLPs2H01fb1ghrAOWoQ4HEYWn4g+M34KeyIuoKGTnYUYO3JhAWxEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJO2zki3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJO2zki3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134721F00A3A;
	Sat, 15 Aug 2026 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779277;
	bh=VuMS+b+jwmaalIGqgwMvrdVoXFxwmcJC/jjhRBiV+WA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DJO2zki3cE7mE3mWUusAc9MRo1RrL9YhpwS1i9ymws/pKLnKzGRUnBC/3wGIZjPvc
	 vQ+j/AR8BdvJk/9X5XLdvHNt+tsmxja2zeXvCZJmD7wTjqCGWB3K536UnQ4hB3QORX
	 IPNB9Mrr82pmpkMvi9A573j8KWgEJrh0urYyHOurgaJ+WmsLYLP4OfHbJoc+kTnQUg
	 p0YZF0gqZXam5+YfkPdgT2+0e/YRyMRITH8wcuEHjEcSX+uROCkmRAHc3cf6O+d+5m
	 wMamElLx12hMnZEp9kBnO5i3CHDncU0fTsUi7K42wkj1gn0kcIqk+7fdGuItDCjl1/
	 aWjzknktld+og==
Content-Type: multipart/mixed; boundary="===============0329448137327177652=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c6f4191cbeb46ebbb55441a67f95e48778ad1ae155d493fdb03cc7c3813e84d@mail.kernel.org>
In-Reply-To: <20260815064612.378577-11-memxor@gmail.com>
References: <20260815064612.378577-11-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Report Resource Lifetime reference leaks
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:37 +0000 (UTC)

--===============0329448137327177652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 058574a1411e..5d20ea9e470e 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -1735,6 +1736,96 @@ void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
>  		env, "Add or adjust a bounds check that proves offset + access_size stays within the object.");
>  }
>
> +static const char *diag_lock_name(const struct bpf_reference_state *lock)
> +{
> +	switch (lock->type) {
> +	case REF_TYPE_LOCK:
> +		return "bpf_spin_lock";
> +	case REF_TYPE_RES_LOCK:
> +		return "resource spin lock";
> +	case REF_TYPE_RES_LOCK_IRQ:
> +		return "IRQ-saving resource spin lock";
> +	default:
> +		return "lock";
> +	}
> +}
> +
> +static void diag_res_report(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
> +			    const char *reason)
> +{
> +	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, problem);
> +	diag_reason(env, "%s", reason);
> +
> +	diag_section(env, "At");
> +	bpf_diag_source(env, insn_idx, "error", "%s", problem);
> +}

[ ... ]

> +void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn)
> +{
> +	struct bpf_diag_history_opts opts = {
> +		.scope = BPF_DIAG_HISTORY_SCOPE_REF,
> +		.ref_id = ref_id,
> +	};
> +
> +	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, "unreleased resource");
> +	diag_reason(
> +		env, "Owned resource (id=%u) was acquired at instruction %u and still needs to be released before this exit path.",
> +		ref_id, alloc_insn);
> +
> +	diag_section(env, "At");
> +	bpf_diag_source(env, fail_insn, "error",
> +			"owned resource (id=%u) still needs release", ref_id);
> +
> +	diag_print_history(env, &opts);
> +
> +	diag_suggestion(
> +		env, "Release or transfer ownership of the acquired resource on every path before the program exits.");
> +}

Does the exit-path wording fit all three call sites?  bpf_diag_leak()
says "still needs to be released before this exit path" and "before
the program exits", but check_reference_leak() is reached from three
different code paths via check_resource_leak():

  process_bpf_exit_full()  <- actual program exit
  check_helper_call()      <- tail_call rejection
  check_ld_abs()           <- BPF_LD_[ABS|IND] rejection

For BPF_LD_[ABS|IND], the reference is not lost at an exit at all.
LD_ABS/LD_IND clobber caller-saved registers, which is why the verifier
refuses them while a reference is held.  The existing verbose() message
says "BPF_LD_[ABS|IND] would lead to reference leak", and the
diagnostic annotation is placed on the LD_ABS insn, but then the report
says "still needs to be released before this exit path" and to release
it "before the program exits", neither of which describes this case.

The tail_call case is similarly not an exit of the current program in
the sense the diagnostic implies.

Both non-exit paths are reachable: LD_ABS is permitted for
socket-filter, sched_cls, and sched_act programs, which can hold a
REF_TYPE_PTR reference from bpf_skc_lookup_tcp(), and any program can
reach a tail call while holding a reference.

Could the diagnostic text be parameterized by the caller, or use neutral
wording that covers all three situations?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cfc14167cad1..f5bf8cf644b8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10274,6 +10349,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
>  			continue;
>  		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
>  			state->refs[i].id, state->refs[i].insn_idx);
> +		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->insn_idx);
>  		refs_lingering = true;
>  	}
>  	return refs_lingering ? -EINVAL : 0;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============0329448137327177652==--
