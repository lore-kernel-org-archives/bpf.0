Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901925B0BD
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014959; cv=none; b=g69iMxas3SpIFOFW5kCFXTzyQLF0mtFlNvFQCoSzyHqfkMm+J2VQ/yR3WDUTc9N0xRIhwM/J6grMTue3VrhcvuMVWVNOi0WlPXOjfZjuOVANCQz2TE8wnsa7i0cIlLcpFM1/D56e7pOJ+37ewxJr87smeMgWBR6woczj1QS47jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014959; c=relaxed/simple;
	bh=QNCrW7vy4nmJDHA8keuOQWZ1wvuLEsm04ExcMMCnKs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KlahUwhPOusAEiMJjOteywjtGbbQYPGLaWI5w2Ty0eywE0TOtHSwpwZoSVV6SrGTV+UiPoXe0WSVsl04nQxFb8AyrI4eF4idKzP12ku9K/ksn20qig/x4CJPkUy7wJ//ynNgjTdsB5Ol1JWMvhf4KnzNrTUPh4+w7GHmophY5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+9ElNED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+9ElNED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3989E1F000E9;
	Tue, 14 Jul 2026 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784014958;
	bh=fRBvVmENgn6LAMthM/NA7HK7da1aXniyKMEWYcPE5GM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+9ElNEDqe0zr48eQKwzJ6xJzYIOqdfqPjgDoblgJlUp/cpM+o7co0TmpC9g7ruba
	 cLuRQhMN6PEhrxYzr9U2G04IB+hO6iJPz+9tzxIT1Qx6bCeOhEyZlZZH99XqB8EUMy
	 CNkgLJXLKtSSBW5GFPtK+2yyS5g9YZv+lT1vGihBPF4MxAPXICZdXhUVtQIfTpx0fh
	 T7xCQtkVGAVn5t74DE9UmUUIQJwF86i/gvvO5EIGUNgAjybCSBxbp5IKmMCjKT72wg
	 qzUI2rO4MK5OZJj02V0Qy0m2YfIDOeDysL+vFBJlMR0j2KLFiocHjxC4KLValLwP6c
	 rEO5cRa5faXzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/15] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-2-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:42:37 +0000
Message-Id: <20260714074238.3989E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Deferred time check causes massive timeout multiplication on archi=
tectures with precise waits.
- [High] Unchecked negative initial timeout leads to an infinite hardware s=
leep.
- [High] Generic local variable names in the macro cause dangerous variable=
 shadowing.
- [Medium] Missing parentheses around the `timeout_ns` macro argument.
--

--- Patch [1]: [PATCH v14 01/15] asm-generic: barrier: Add smp_cond_load_re=
laxed_timeout() ---
commit fd56d26a441207368c7c3704e10f44093698b198
Author: Ankur Arora <ankur.a.arora@oracle.com>
Subject: asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

This patch introduces smp_cond_load_relaxed_timeout, extending the relaxed
condition loader with a timeout mechanism. It implements a loop with
cpu_poll_relax and defers time checks to a slowpath to minimize performance
overhead.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21da..ecdaddbbd7b64 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
[ ... ]
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	typeof(ptr) __PTR =3D (ptr);					\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	u32 __count =3D 0, __spin =3D SMP_TIMEOUT_POLL_COUNT;		\

[Severity: High]
Could these generic variable names cause variable shadowing issues?

If a caller passes an expression for time_expr_ns or cond_expr that uses a
variable named __count or __timeout, would it evaluate using the macro's
internal variables instead of the caller's? For example, if the caller's
timeout variable is named __timeout, might it initialize the macro's local
variable with its own uninitialized value?

> +	s64 __timeout =3D (s64)timeout_ns;				\

[Severity: Medium]
Is it possible for operator precedence to cause incorrect timeout calculati=
ons
here?

Since the timeout_ns macro argument is not enclosed in parentheses during t=
he
cast, if a caller passes an expression like a << b, the cast would apply on=
ly
to the first operand instead of the entire expression.

> +	s64 __time_now, __time_end =3D 0;					\
> +									\
> +	for (;;) {							\
> +		VAL =3D READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\

[Severity: High]
What happens if the initial timeout_ns passed by the caller is zero or
negative?

Because the time validation is deferred for SMP_TIMEOUT_POLL_COUNT iteratio=
ns,
a negative initial timeout is cast to u64 on the very first loop iteration.=
 On
architectures that implement a precise hardware wait, could this extremely
large unsigned value cause an infinite hardware sleep instead of returning
immediately?

> +		if (++__count < __spin)					\
> +			continue;					\

[Severity: High]
Does this loop inadvertently multiply the wait time on architectures with
precise waits?

Since __timeout is repeatedly passed to cpu_poll_relax without being
decremented inside the SMP_TIMEOUT_POLL_COUNT deferral loop, if the CPU wak=
es
up spuriously, it appears it will sleep again for the full initial timeout
duration up to 200 times. Could this cause significant latency spikes?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D1
