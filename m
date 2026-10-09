Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BEB4DEC08
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546367; cv=none; b=crI0uuHPq6hFi483/ZuwI18pht5pHBAfrMNFk2AmVLPVF80CVaeBjKGCbWQ6ej5jCLzP1EKBUam2KzfY0R+3lULvu0kypUr8Ljwwb7yyMkLw9efhPDcK0mhwpeca4ExwQznGFowUEE6r4c8+Kmth7m9bxgOoalkP525QpjL0gmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546367; c=relaxed/simple;
	bh=nPMUZP+TYrGcPHZ8/4vtGMxqr9nDS1H0Q/hJ74uCJWQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uqypKQgUHA5zLJ/rA8F1DmCSCHIySbo76SaP8S8gdsqf7AGEY2hiQaYsbsPPePnfDA7duQiIBMDy42yoDCWBIn5F23I8Egdzg47OEvu7Z1oXJe1HrL7FuPKyYaL8nVVp9odOapHmWc2u2nqflP75BYm4Xt5xaqXQe1OoJd0edEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ22Nkkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ22Nkkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D7A1F00893;
	Fri,  9 Oct 2026 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546359;
	bh=pQslkokFxIucEeA8QayPvM30ug1P+reXnq1Mbzrbt1w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lQ22NkkvJr/lRFQ1F8CL5EKqknzDfA5ZRnkUIUUEGD49pYuzn6p79eEpQi0xF5ufD
	 jz3v6k++Mv8zu250h9Q6MzdO4LJO0YLkU59m7+JHumBWNhQiDrUv4yb1lrBKW2MNVQ
	 IQELddzgR1l7E6eaMmE6dVZZAAjhXSI1794K9IuSeJ+PLo36Ri/TvV8HGB6v/d74Yr
	 K4vlQKKGRKK//CbKeej9i/kKUwykv7FQJPnBhWC4DI5tSOtHLI9it+pS4xsAotHSJb
	 zUi3NVN8O6rWJmbUv4sHg0N4BILpiyiNmo9Yu6Uwa6F1lBIWqV0Al2nplu7sPHF02R
	 JFHNaOcfoxDIA==
Content-Type: multipart/mixed; boundary="===============8559163876320752946=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0975ea50cfd211e9568f82b3ea75cc9f0bd57cb5332254d25784e6a7e0731ea@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-44-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-44-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 44/51] selftests/bpf: tests for BTF-based global subprog stack liveness
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 11:45:57 +0000 (UTC)

--===============8559163876320752946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for BTF-based global subprog stack liveness

TL;DR: Test issue: the "no stack effects" check in global_callee_btf_arg may
never fail, since the call-line __msg pattern also matches the main verifier
pass log, so a liveness regression could go undetected.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> @@ -159,6 +159,52 @@ static __used __naked void write_first_param(void)

[ ... ]

> +struct task_struct { int pid; };
> +
> +__noinline int global_noop_btf_arg(struct task_struct *p __arg_untrusted)
> +{
> +	return 0;
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +/* Untrusted BTF pointer arguments need no caller stack state. */
> +__msg("stack use/def subprog#0 global_callee_btf_arg (d0,cs0):")
> +__msg("3: (85) call pc+{{[0-9]+}}\n")
> +__naked void global_callee_btf_arg(void)

This isn't a bug, but can the absence check in global_callee_btf_arg ever
fail?

The pattern __msg("3: (85) call pc+{{[0-9]+}}\n") is matched against the
whole verifier log, not just the liveness dump.  If
bpf_global_subprog_stack_access_bytes() regressed and the call picked up
marks, print_instance() would emit:

  3: (85) call pc+1   ; use: fp0-8 may_def: fp0-8

which no longer matches.  But bpf_compute_live_registers() runs before
do_check_main(), and do_check() later logs the same instruction as:

    verbose(env, "%d: ", env->insn_idx);
    bpf_verbose_insn(env, insn);
    verbose(env, "\n");

That produces "3: (85) call pc+1\n", which satisfies the pattern regardless
of what the liveness dump printed.  The test is also __success, which does
not depend on the liveness marks.

The commit message says this test verifies "No stack effects for an untrusted
BTF pointer argument".  Would a __not_msg for the "call pc+" line with the
"; use:" / "may_def:" suffix, placed between the header __msg and a following
__msg, make the check effective?  That way the main-pass trace falls outside
the checked span.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============8559163876320752946==--
