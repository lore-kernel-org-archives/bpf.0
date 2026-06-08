Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4038888F
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907103; cv=none; b=gOmtVrhSHcI17aJjyDbJIZ+iMkZwm/txRIh218VDFXTw0jMbuqv2qqOe3aj/4su6ic2bVvrQPIonLbsUNsFFpEHA2Ae/BJJWfVIigjqpzNXDNhR/p23dKQd8fz5gJOjJcUUsEqy2ZNmQ2L8hD2uL0faqL2t3e//OwyPg+UYJLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907103; c=relaxed/simple;
	bh=J7KIJbJoPaexbqJh/8sT08pQZYvywwsGNU0wHo3b6Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHN9szOHzAii39U6fwakmr+I9KRAmIaXeeudXNZdN238d6qcfeP+Xi5yllcO+rNl8WYkwEKqbVfd6cjBIiaRefLvdxw67pEENZt6XzDr8pm/I+lPJqLGpVpHft4Bh1S5OdUdYeVuGfNzmakmZMkNpRwKdI1ymVY99KcH3QFv0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7Ur3Dwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7Ur3Dwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5A91F00898;
	Mon,  8 Jun 2026 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907101;
	bh=z7ItMcSHVliTSoNNUM8CPf7MAbtvoR6YpJE1xSTK2sA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7Ur3DwedtqeD7RseGZSFj6e/0cYQIfWYRsD+zF2pRIxe2bYwYwyTxU8BKTAgPAj5
	 3ggs3GizVrPKR9+NTR5O1jidJ4RMFx6b8q5OgXAmVkLjdZtbOyNDLnpDhXok2OPN3D
	 1X90rgCkxdlycl4YUOv2VRMVIyLRVV4l4PZht+7gY11XXICwD/WCePVvrLfRRn4OvM
	 ZEwr+kwxThR3XMRFFs0pSGvLfU1N56wqbfaRQvF5vzq66IagBeD9OdcPVDh89fKrxh
	 Rm5k/KZ826Sr/49H2/Gxw1/Y5Uc0jS9ov1GGcHzBAXXTmbfVLgWPwL5m1HBOTpAief
	 J3yREV1XKwjYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/15] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-2-ankur.a.arora@oracle.com>
References: <20260608080440.127491-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:25:01 +0000
Message-Id: <20260608082501.BC5A91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Valid timestamp of exactly 0 is incorrectly treated as a clock fai=
lure.
- [Medium] Negative timeout causes unintended long hardware sleep due to u6=
4 cast.
- [Low] Macro variable shadowing due to generic local variable names.
--

commit 7f28757f0549fdb8beb7da7fa09e815a4f266f53
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

This commit adds smp_cond_load_relaxed_timeout(), extending the relaxed
condition load to allow waiting for a condition or until a timeout expires.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21da..c56df9513a084 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h

[ ... ]

> +/*
> + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementat=
ion
> + * that is expected to be cheaper (lower power) than pure polling.
> + */
> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no orderi=
ng
> + * guarantees until a timeout expires.

[ ... ]

> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	typeof(ptr) __PTR =3D (ptr);					\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	u32 __count =3D 0, __spin =3D SMP_TIMEOUT_POLL_COUNT;		\
> +	s64 __timeout =3D (s64)timeout_ns;				\

[Severity: Low]
Does this code risk silent macro variable shadowing? The generic names like
__timeout, __count, __time_now, and __time_end do not have unique prefixes.

If a caller passes a variable named __timeout as the timeout_ns argument,
this expands to s64 __timeout =3D (s64)__timeout, silently masking the call=
er's
variable and initializing the internal variable with uninitialized garbage.

> +	s64 __time_now, __time_end =3D 0;					\
> +									\
> +	for (;;) {							\
> +		VAL =3D READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\

[Severity: Medium]
Will this result in an unintended long hardware sleep if a caller provides a
negative timeout_ns value?

If a negative value (such as an already expired deadline) is stored in the
signed __timeout variable, casting it to u64 results in a massive unsigned
value near U64_MAX. On architectures where cpu_poll_relax() uses this for
cycle counts, this might cause the CPU to sleep indefinitely instead of
failing fast.

> +		if (++__count < __spin)					\
> +			continue;					\
> +		__time_now =3D (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end =3D=3D 0))				\
> +			__time_end =3D __time_now + __timeout;		\
> +		__timeout =3D __time_end - __time_now;			\
> +		if (__time_now <=3D 0 || __timeout <=3D 0) {		\

[Severity: High]
Does this code mistakenly treat a valid timestamp of exactly 0 as a clock
failure?

During very early boot, a valid monotonic clock like local_clock() can retu=
rn
exactly 0. If this occurs, the wait spuriously aborts on its first time che=
ck,
which could cause callers to falsely assume the lock condition was met and
lead to lock queue corruption.

> +			VAL =3D READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__count =3D 0;						\
> +	}								\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D1
