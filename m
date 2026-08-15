Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307A3D16F0
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779281; cv=none; b=aXTCDxx0k5UZwxLDEo3FKcCHyK2xoXpLrxeVqiNJGmLwQShy8/YqpViiVofZ6yF4c22lESG2sz8zkaTJJMPQ+4CfbVF4I2Q/RM24RSyNoAtRY3GwVa7bV0D6pKv3DyBfZ7Q348vQ6RvTJCnNPh3omYbB6EJbZdYLirT5DY/Mnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779281; c=relaxed/simple;
	bh=HTESErdzyZ0rckumhAw+hLtfks/jNSZx+A8Xku4K0dk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n9gSgJRXi/5G/mQEVZPmnuoYbUSl8bGELpJav6DSohDCs5AtuALDaw82fMgvYWU3UYK2sNlyiV4wQoLCwuIEd6bv19Tq/JIYNrtp+vY9bochU/bYZrFfW9xlAS12gOYYbEmdPwtu8ML92oeJjX/Bql+hFQ7L1kqDxpaUlgvTs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djxz3pCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djxz3pCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE2E1F000E9;
	Sat, 15 Aug 2026 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779279;
	bh=88KwFz0B6P7CvONIrt7EMWPu8VjpUWMgx1LkAY7WKh8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Djxz3pCVjvTEsCOJ16J9im/ZAxbChDnlUNqaGkMRhZ2cne2EXqLzIg75ijqGBZeZ6
	 TyhLz0KBD1kUUsoYCXQlyrTWw38A0V9jMHUYOC5JTlTmCYU6xzCiPl5UXjV9dG7qvr
	 dArGTT9iu57u5HVs0UTFkyryO6q5Ysdc9NqAF/zNN9OEe+Onn85vZ28+t9W8j9glDN
	 VaBg4KZpEZQ9zo2178McqWu+DdroBJDGuUZgFNh2PEgTswlzXtRJnL87nz6WVqPaNZ
	 rldQmTHeur5Km9li/DBXUuWK6BQC9xrpH8WIdhOPDnh5vhtJ82ZLY6VoPf1eFZeRMu
	 6a1ECs6haJZwQ==
Content-Type: multipart/mixed; boundary="===============8230519619992626745=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org>
In-Reply-To: <20260815064612.378577-13-memxor@gmail.com>
References: <20260815064612.378577-13-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 12/14] bpf: Report Execution Context Safety errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:38 +0000 (UTC)

--===============8230519619992626745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c067be53106..a81a7ed18d76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13657,6 +13682,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	sleepable = bpf_is_kfunc_sleepable(&meta);
>  	if (sleepable && !in_sleepable(env)) {
>  		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
> +		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
> +		bpf_diag_ctx_forbidden(env, insn_idx, operation,
> +			"Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
>  		return -EACCES;
>  	}

Can this diagnostic produce contradictory output when a non-sleepable
program happens to be inside a critical section?

The rejection condition is !in_sleepable(env), which tests whether the
program itself is sleepable (env->cur_state->in_sleepable), not whether
the current path is in a sleepable context.

But bpf_diag_ctx_forbidden() derives the context kind from cur_state by
checking active_rcu_locks, active_preempt_locks, active_irq_id, and
active_locks in that order (kernel/bpf/diagnostics.c:1084-1093).

When a non-sleepable XDP program calls bpf_rcu_read_lock() (which is
registered without restrictions in kernel/bpf/helpers.c:4887) and then
attempts to call a KF_SLEEPABLE kfunc like bpf_copy_from_user_str, the
path reaches this branch with active_rcu_locks == 1, so the diagnostic
reports:

  Reason: The operation sleepable kfunc bpf_copy_from_user_str cannot
  be used in RCU read lock region because RCU read-side critical
  sections cannot call operations that may sleep. This path is still
  inside an active RCU read lock region (depth 1).

  Suggestion: Mark the program sleepable if the program type allows it,
  or use a non-sleepable kfunc.

The verbose() line says the program must be sleepable, the Reason blames
the RCU region, and the Suggestion says to mark the program sleepable.
These point at different fixes.

Leaving the RCU region as the Reason implies does not clear the
rejection, and marking the program sleepable as suggested does not
remove the reported Reason either (the call would then hit the
!in_sleepable_context check at line 13787 instead).

The other three bpf_diag_ctx_forbidden() call sites added in this patch
(line 9860 in check_func_call, 10768 in check_helper_call, 13787 in
check_kfunc_call) are all gated on !in_sleepable_context(env) and their
verbose() lines call non_sleepable_context_description(env), so their
diagnostics are self-consistent with the rejection reason.

Would it make sense to pass BPF_DIAG_CONTEXT_NONE explicitly at this
site, or to have bpf_diag_ctx_forbidden() take a context kind parameter?
That way diag_context_name(BPF_DIAG_CONTEXT_NONE) would return
"non-sleepable program" and produce the accurate "cannot be used in
non-sleepable program" report that matches the actual failure condition.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============8230519619992626745==--
