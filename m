Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273272BF3D7
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619261; cv=none; b=LGkSUD3mMWN/kIwMpjF6x+6LDntz4Y+ZL0D+GoQTGmVQtQ67SwSF8ImKaylhOxwbxq8wD65rZwvK9fvS2fL6JjVtyQDApVwbvcGaZtOu35lVp31vm6RV9GGl8sZMyE4rt9utoL9l15HFiW80+rQPCiZD+ayPbrzOAHmidRO2rWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619261; c=relaxed/simple;
	bh=zBLBhXa+Fb2nAN+l0ZHDlHUj4REOI84iD9fFvjalOf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7Ig8yXcYOIuB6a38V4g1ir1Upif3Yl2K2PrSzOlJb6qooLfWU8afkbcJDTInOOCYHmVCnqJbPVppRZj6N1rfzxrvqBK4EUyCPKTBhN6Qp9gtQps0l6XE2qnA98ENiWqvjJlY1Sn4MoEE18G7bI6leFZCoPzjoVIBTkeT/c/lTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXKVUMgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXKVUMgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89FEC2BCAF;
	Sun, 19 Apr 2026 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619260;
	bh=zBLBhXa+Fb2nAN+l0ZHDlHUj4REOI84iD9fFvjalOf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cXKVUMgH9jFimk4XqXcWwgEr9t/vJR8oFK61NQZskWDC06yLV1YM+JzuiMEvMocgA
	 KA5q9KEBQ56Z/Ecry1AEqzO20RzvVsaT+h371uPeoPtxsLJUymUOvMBJAT9KqOi4GO
	 0VA8C+MeB3D5MnzssP4w8uu37JCNDX2PQUCm3w1G+sZ1XDM9x41gJqJo9enZNUk31o
	 6zvX9Bl9TzXaiTpLAsOs+Hio8JYRSTd0mSiKfMZ0wfBdL/VJFFLRY5N8aXb6OpWGT1
	 PwdiSd9m21M+C70cdm6dAKZM10etXVRFGvlN6NHMEet7/qFS7eXKVzGNcqOrI1RERM
	 Qe2zDhat9RfVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 17/17] selftests/bpf: Add verifier tests for
 stack argument validation
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163445.740437-1-yonghong.song@linux.dev>
References: <20260419163445.740437-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:21:00 +0000
Message-Id: <20260419172100.A89FEC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Test fragility in `subprog_deref_arg6` error matching due to com=
piler register allocation
--

commit 3936b0a6dea45627278be80c25b20ff18f2821d4
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add verifier tests for stack argument validation

This commit adds inline-asm based verifier tests to exercise BPF stack
argument validation logic directly, including both positive and negative
tests for tracking pointers, references, and null propagation.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
> new file mode 100644
> index 0000000000000..66dd11840a63e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c

[ ... ]

> +__noinline __used
> +static long subprog_deref_arg6(long a, long b, long c, long d, long e, l=
ong *f)
> +{
> +	return *f;
> +}

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pruning with different stack arg types")
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__arch_x86_64
> +__msg("R1 invalid mem access 'scalar'")

Does this hardcode an assumption about Clang's register allocation?

Since subprog_deref_arg6 is standard C rather than a __naked inline
assembly function, the compiler determines which register is used to
dereference f. If a future LLVM version chooses a different register, the
tests will fail because the verifier error will mention the new register
instead of R1.

Could these tests use __regex to match the register dynamically, or be
rewritten so subprog_deref_arg6 is a __naked function to guarantee the
register choice?

> +__naked void stack_arg_pruning_type_mismatch(void)
> +{
> +	asm volatile (
> +		"call %[bpf_get_prandom_u32];"

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D17
