Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8538C421
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425108; cv=none; b=mXC8a+knyfILht60ROPF/W0r5K5CQl72SnQ6fna+W0yfyrxTrjww3niLd3MmjRSkeCDhAsEuE9MVt4k7t3OuPiIZmX2Ko3iFhKCTL0eWee+rIPI0+Jt6IQ1cSvMHz+L8PoApC9wXyiElnw/lDAbUy+3pwSJgA4gxOP0BHeRY84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425108; c=relaxed/simple;
	bh=beE2I8wKPsK6hlJSq+isJy35oqH4MH8LqUcuVqVZ/UA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PtB/4Z7sOvVvoaURriQ1E3YyMKuzIEEVFdbeu2lO0bsJPA05R4FwzKiFbWGUQK5j+z3GgO6RP9S1okCigFOnZrIZye483ZKxeuax/Dxwh565Px7XvswtL6vQiVVZrfJ+KYuDKV4PUNzS7pae7zpVLHHPfFvtWVk9H+mIE2mR+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clqRclnh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clqRclnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D7C19425;
	Fri, 17 Apr 2026 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776425107;
	bh=beE2I8wKPsK6hlJSq+isJy35oqH4MH8LqUcuVqVZ/UA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=clqRclnhElNXX8gafaPKHgK42/G9GwEU/8NEFpmw5c7DulWUgPTGBsKYoSXd9n2JY
	 M1tXp/ihhZ5n5z6AfY54nUzh+RtDACcwJVVOMSjDqoGSxbkPlnJ8KkvzCQ157OEeqw
	 0hNjLzG56GK/Ngy8KGfiktqKuizQyhzMJQzCyp+T+WGh5yHSPhC0bAMeFZQL7AnMhl
	 EIlkqR4kndlMVSF1x2nlY4sb55K5NGStOyL0mox7h/nwyVjw1YvfRN8P+x3QpTeVZF
	 0MECe+wg80YXJcqyRiR9K2tusqXqpfYRdJLoV8YFKvHzQer6qRebJNAmHMJ0gWfI6n
	 EQLRbsCzlxW/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417103004.3552500-1-puranjay@kernel.org>
References: <20260417103004.3552500-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 11:25:07 +0000
Message-Id: <20260417112507.A99D7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The patch leaves the memory leak unpatched for BPF programs utiliz=
ing callbacks (BPF_PSEUDO_FUNC).
- [Low] The patch introduces a C90 'declaration after statement' violation =
that will cause build failures on stable backports.
--

commit 5b49d0ae3429d9aefefa73b4cf12e6c41845458c
Author: Puranjay Mohan <puranjay@kernel.org>

bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT

The ARM32 BPF JIT does not support subprograms. This patch rejects
BPF_PSEUDO_CALL early in the JIT to prevent leaking a JIT binary
allocation during the second pass in bpf_jit_subprogs().

Link: https://lore.kernel.org/bpf/b63e9174-7a3d-4e22-8294-16df07a4af89@peng=
utronix.de

> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index deeb8f292454b..91fef10e88bc4 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx)
>  	/* function call */
>  	case BPF_JMP | BPF_CALL:
>  	{
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> +			goto notyet;
>  		const s8 *r0 =3D bpf2a32[BPF_REG_0];
>  		const s8 *r1 =3D bpf2a32[BPF_REG_1];
>  		const s8 *r2 =3D bpf2a32[BPF_REG_2];

Will this cause a build failure on older stable branches?

This patch is a bugfix tagged for stable backports, but placing code before
declarations violates the -Wdeclaration-after-statement rule enforced in
kernels before 6.5. Should the check be moved below the local variable
declarations?

Also, does this leave the memory leak unpatched for programs utilizing
callbacks like BPF_PSEUDO_FUNC?

When a program uses a callback, the verifier creates a subprogram. During t=
he
first JIT pass, the ARM32 JIT ignores insn->src_reg and compiles the
instruction successfully as a 64-bit immediate load.

Because the first pass succeeds, bpf_jit_subprogs() executes its second pas=
s,
allocates a new binary, overwrites prog->bpf_func, and aborts with -ENOTSUP=
P,
leaking the first allocation exactly as it did before this patch.

Is an equivalent rejection needed for BPF_PSEUDO_FUNC in the
BPF_LD | BPF_IMM | BPF_DW handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417103004.3552=
500-1-puranjay@kernel.org?part=3D1
