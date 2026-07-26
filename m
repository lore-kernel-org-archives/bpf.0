Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCE221739
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030076; cv=none; b=jnSZtfUdoEkI9CrnEcTRlzk9zkZCmiGf+dIA2XrjyJvdzMPDX+P6dm0ipquKQodvD4Sa+dlIpkAAQyIjkU1XL+opkgyPqakDovdIgjVoswdsg1qibeJs0MEvRjriFwtDrUwB/6o4lD65jkI9rbOCW2rj4LHx5imdNdMPJbmc/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030076; c=relaxed/simple;
	bh=N3hVz/fFcYyRqdX0d6Seoa/zuZM18bNANix/XFfpDdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AA386C0n4SGDxekwu3cx440hRJnkPT8S7FWwnb/fDTF861L3qt4MfVcVglPQzPlvGQjUzqT80UFNR1I6/D6lBwago5HIzaYFBd8VwEZWwqVN9OQodV9fZp1Nqm1nqliBcr9qEEvbwUIQcERAGd0I+YrYnajP0zYwF5spgxtS4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOj3InPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOj3InPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A795D1F000E9;
	Sun, 26 Jul 2026 01:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785030074;
	bh=HkZYhjd1T2D5Be5qPIpMdu6+jHdwxxQzVQ2SFMDNqqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOj3InPwnyQTkSizHUIjM+5fZ87YQrJJ2ep1gwXANw/nnm7w7WFsJfqBjBpRR2cau
	 zv09St0f2nOzpg5kiGC6V4eyI4vmKc3WTns7D8fDVe5PG9eBgHXEIu9ALB5rVFVGuV
	 6taGY9m6BwZLk/TrhfSHc7YT/zkVKiPkhLAzGwEtCEuPiTJ4aSK3G9KNuYzTBmxNwJ
	 24B0xEjKyWYM1n7u1mVTGmzmoG1tF1TBBr0xKs9K7C2exHtkDqfncDlNjQJ8Ct6SYy
	 LN529Hxt00z3cY8WBf8wmTbWDfg/1BybsDMojaIu11w9hbqB/SjBagblCPNLaW0Ixz
	 TGINE5hmJbjaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726013105.3689867-6-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
 <20260726013105.3689867-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 01:41:14 +0000
Message-Id: <20260726014114.A795D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `arena_arg_stack` failure test is conditionally compiled out=
 on compilers missing `__BPF_FEATURE_ADDR_SPACE_CAST`, causing a false test=
 suite failure.
--

--- Patch [5]: [PATCH bpf-next v2 5/9] selftests/bpf: Add kfunc __arena and=
 __arena_nullable argument tests ---
commit b7abeb2e41481276f90bb3144448d08e3c6e2c96
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add kfunc __arena and __arena_nullable argument tests

This commit adds kfunc arena argument tests to bpf_testmod to exercise
argument rebasing, various accepted argument forms, and verifier rejections.

> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/test=
ing/selftests/bpf/progs/arena_kfunc.c
> new file mode 100644
> index 0000000000000..e7250c5197ab4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c

[ ... ]

> +SEC("syscall")
> +__arch_x86_64
> +__failure __msg("arena pointer cannot be a stack argument")
> +int arena_arg_stack(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
> +#endif
> +	return 0;
> +}

[Severity: Medium]
Does this conditional compilation cause the test suite to fail on older
compilers missing __BPF_FEATURE_ADDR_SPACE_CAST?

Because this test is marked with __failure, the test runner expects the
verifier to reject it. If the macro is not defined, the program compiles
to just return 0. The verifier will successfully load the empty program,
causing the test runner to report a failure because the expected rejection
did not occur.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726013105.3689=
867-1-memxor@gmail.com?part=3D5
