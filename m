Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA672631
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780714928; cv=none; b=DvJcMBIPqs3rhsZw+b8AIEBCa7TxaCqpg+bRgbp5BMRwDC1N+P2jPaMleKngCHF7pe26vry+7brlWX9sMo2E+SLa1o5jx+3PvRjfHC+gM6cUUW5FvtQqABOH9hpBK8D/9+hQKlbhLDtv840InWF9oFxoCqs9T2911ZoMASkOBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780714928; c=relaxed/simple;
	bh=AT7YNiHmcNFVfoOHu82sqYsKmRV1Iy4gAIJWEa8vU7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ga9/Xdy1do1wLiW5kTeuYoKcqKiHNRCuX6VM4WzF3OM77CxZyiPDiFGxl4aK3I8duf8YqnmQL0aU0bKYiEqkI/LQklBN59xn8pUVv5h2bPbOGZO/b4viWwiLhoJ5GjdhG9fRr+fbZ/SE9mDKHI1uIwwvQDvbNN/ZjUrJzaxINto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2e8aB6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2e8aB6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED451F00893;
	Sat,  6 Jun 2026 03:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780714927;
	bh=LnilTSWJNKuBd+o5nlcfESl+w+vt2Vv07vAZ0L2kg+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2e8aB6QVVYm24Ao7wjPqGgN8COBemNHKWDjzKZ8ykCts70Z2NmRu5mD79tfx3/6v
	 J41gYtHcCNJqTzia+sA5P+c0k+M5y1Gv9BrYNFrPpJkShkr2BQABS9IpVte7GdbyfS
	 DWR6EXbDCQKve3/sXqjfBcIizfEV6lVJ49rUIUAG+X/MA+olwHlQvBQbUSlb6CiZ3j
	 eoNW9M1+mZCwLQF2zuL+YGvY0bDQxYeFrHpOwCTVjhscLH/JV8OgB3i45qGQktf/ei
	 KmWuCHURZbaxrGkE01gZCu9PYVQi/Og0XwMl/qMawQcUerPFPRvtKqtzMmA+HhQtDW
	 eLAtGlvSk+jLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix signedness bug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Tidmore" <ethantidmore06@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606024540.47362-1-ethantidmore06@gmail.com>
References: <20260606024540.47362-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 03:02:06 +0000
Message-Id: <20260606030207.1ED451F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message falsely claims that the variable 'id' is an u=
nsigned integer, making the error check `(id < 0)` impossible. This claim i=
s demonstrably incorrect; 'id' is declared as a signed integer, meaning the=
 patch fixes a non-existent bug.
--

commit c4f0a14bac5d07880856111e136127510f48012c
Author: Ethan Tidmore <ethantidmore06@gmail.com>

bpf: Fix signedness bug

This commit refactors the error handling for acquire_reference() by using a
separate err variable, claiming that the id variable is unsigned and cannot
be checked for negative error codes.

> The function acquire_reference() returns negative error codes and 'id'
> is an unsigned integer, so the check (id < 0) is always impossible.
>=20
> Detected by Smatch:
> kernel/bpf/verifier.c:13115 check_kfunc_call()
> warn: unsigned 'id' is never less than zero.

[Severity: Medium]
Is this description accurate? Looking at check_kfunc_call(), id appears to
be explicitly declared as a signed int, not an unsigned integer.

Since acquire_reference() can return negative error codes like -ENOMEM,
wouldn't the original check (id < 0) work correctly?

It looks like the Smatch warning might be a false positive, and the original
code was already handling the error properly.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 935595138aa01..be528a0be13cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13167,9 +13167,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		}
>  		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
>  		if (is_kfunc_acquire(&meta)) {
> -			id =3D acquire_reference(env, insn_idx, 0);
> -			if (id < 0)
> -				return id;
> +			err =3D acquire_reference(env, insn_idx, 0);
> +			if (err < 0)
> +				return err;
> +			id =3D err;
> +
>  			regs[BPF_REG_0].id =3D id;

[Severity: Medium]
Is this change necessary? If id is actually a signed int, the original code
would have properly caught the negative error returns from
acquire_reference() without needing to introduce the err variable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606024540.4736=
2-1-ethantidmore06@gmail.com?part=3D1
