Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717929B795
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433759; cv=none; b=P4W2tSe0KttaNMirmEfKghSR/5FuMvocBIUeNEWO6QVwmtbOC8HX2bp1pLiuna0vVFAQkKDJTaEjqY+7paV8mtjlaVfScBEyTKuOUyYvsbl4tWRb0FdVg8QrlNfJk3OsnwFu0rIwPNRU/UGIaWigRaWj1UGCt5eeAQrgn4/Uk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433759; c=relaxed/simple;
	bh=8LEJ0YcSxaBKhiCUpJOi/hAe1dmU8zSzi/LqXcGHf9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sz+Zvnk2A/GzVAGftyZngGD3Mo9qWjsacN0lV9F3xHujNxb402nPQOljRYAWm0QWnXBdUKKHXklNuuhHSQO8duFtiEo2FkUNxPTJ/IKjMg1Ew/tmdkzOo0a9CQe7juhCNf98tDr+hI+XmafzAdbv8IENOyyDZaJE0PlPPHF2Tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzM239tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzM239tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599681F000FF;
	Sat, 26 Sep 2026 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433758;
	bh=7kI+MOL7pas7PBw2A2Zw1xrLPdARQxDiljaOCgMxino=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RzM239tMJji6+Y2d49PTFRqCa6ETNWHkFIlaqVeHkvETtF7tS3MsUQ2SnPqlLoBkI
	 SvA8OrAAJDmiqg6umh7r8XqOcCdVxNBz5tQwSQSa0SnKy7cALJNIDpuhUeGPFMT1Fq
	 eppU5+Uuw8XaW9DfdQ04L39CtWu0unfr7wnNppLLlUZAj5ODPsn6I/Qge/xldUWxzU
	 kivNGNNJLXs15RxRwf4KDjFVKAvtJeuV9i2eJKqdpc3nYnJ9txLpmP3ESHIKLmcf27
	 4UOVOGbeC6qSPMHU8Bxk+RKFtw7dpxKoAZB0JPzkaypxaGRaf2Qv+/zP88VOd7ZTMv
	 oXSQttI9zqhFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 25/36] bpf: use SCEV to widen bounded loops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-25-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-25-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:42:37 +0000
Message-Id: <20260926144238.599681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: verifier bypass due to signed algebraic inversion of unsi=
gned loop conditions
--

commit 457e66d0b00c63117d606a731e93743130f1e826
Author: Eduard Zingerman <eddyz87@gmail.com>
Subject: bpf: use SCEV to widen bounded loops

This commit introduces scalar evolution (SCEV) to the BPF verifier to
estimate loop iteration bounds and widen induction variables. This allows
the verifier to support bounded loops with linear latches and bounds.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
[ ... ]
> +static bool compute_max_iters(struct bpf_verifier_env *env,
> +			      struct bpf_func_state *st,
> +			      struct linear_latch *latch,
> +			      struct bpf_loop_iters *iters)
> +{
[ ... ]
> +	if (step =3D=3D 0)
> +		return false;
> +	if ((s64)step =3D=3D S64_MIN)
> +		return false;
> +	if ((s64)step < 0) {
> +		/* Multiply both sides of the equation by -1, e.g. -2*i > -3 becomes 2=
*i < 3 */
> +		op =3D bpf_flip_opcode(op);
> +		step =3D -step;
> +		swap(bound, initial);
> +	}

[Severity: Critical]
Does this logic improperly apply a signed algebraic identity to unsigned
comparisons?

Looking at compute_max_iters() in kernel/bpf/scev.c, if a BPF program
constructs a loop with an unsigned continuation condition, initializes
the register to a positive value, and decrements it, the algebraic
inversion treats the counter as if it crosses into negative space.

Could this incorrectly calculate a small iteration count, while at runtime
the unsigned subtraction wraps around to U64_MAX and allows the loop to
continue?

If this wraps, it appears the verifier might widen the register bounds to a
narrow range and prune branches targeting the wrapped values as dead code,
potentially allowing unverified payloads to execute.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D25
