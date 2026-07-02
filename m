Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B829D26B
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957189; cv=none; b=sNidWJy2YEcaLNTZkI9yK4LzUp3RgtZnAvw6PXPH2t2Hzc8h7EdRpmoff3uumR3fSh5Zi638VGbmvAnSKfE3djICUT9fZo6kEl/UWO2SvkMwq/HhpG5KUg5r0PNFq/IIuIg6dhLsfm6snlncPeR3n3HsyJ3KlG0tlACCb1WynKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957189; c=relaxed/simple;
	bh=U0uoOaKSN5COZKpEzEcUltdOxXZQXK94sjAMdVD+fhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PpwK4RfceguEsITxtcJ8LHZ4oUtqVknjaBU9N2JzhGLQuxHUK+ZxcyTrx+dOkDVFbaTASuVcFi+z4xBbw7NQd9idbxDlSSQHGHUGed1xWOIQB3P4G81+94jXsvryFHdFpGG9F3IAbP4DS92szHAuEqxwlTtin0q4Qe5vZblPAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxwVFkPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxwVFkPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A281F000E9;
	Thu,  2 Jul 2026 01:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957187;
	bh=feC/XZ00c2S9zQv6PTSrPpTpdNPs8tRYFKiRacD1c4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxwVFkPpL17mPdcudReoESy3STCBPPL9xg+u09sxwDGJYTdUSLrAE97wGP8fLFqzs
	 Fm/UCWDTu1cdzc7wZtYvbBAsZ3axOxfsaJZomjjKQyQ0nnX03AhbebP1yuGw8eYkm1
	 Snvq6rzGiyuDGaVRtVu6iayEi0/aJLycCnD7elN8gzDaAJ913SHWCyNjR3QDXre9TJ
	 KyWJoHTXdkrA3ptAHux7tD9VOBbVcJRPkv1taGMo/lC5nfA6xr6zycNpmP5q9so+U+
	 48T6njcRhqLL4D96i9NxB0B+ZNYEWx0BdwegP0WsaRjN6RTG/jC8CVrWHPQfs72Zz0
	 ASvF/g8VILqzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/15] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-7-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:53:07 +0000
Message-Id: <20260702015307.77A281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `smp_cond_load_acquire_timeout` fails to provide LOAD->STORE order=
ing on the timeout path, violating its documented ACQUIRE guarantees.
- [Medium] The macro `smp_cond_load_acquire_timeout` evaluates its `ptr` ar=
gument after declaring a local variable named `VAL`. If the caller's `ptr` =
argument contains the identifier `VAL`, it will bind to the uninitialized l=
ocal variable instead of the caller's variable.
--

commit c2af0d66e1b775084dedb2d6b232b40a8a269de9
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_acquire_timeout()

This commit adds the acquire variant of smp_cond_load_relaxed_timeout().
It reuses the relaxed variant and adds LOAD->LOAD ordering via
smp_acquire__after_ctrl_dep() to ensure ordering on the timeout path.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index ecdaddbbd7b64..ad3c73da3cb6d 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h

[ ... ]

> @@ -352,6 +352,46 @@ do {									\
>  })
>  #endif
> =20
> +/**
> + * smp_cond_load_acquire_timeout() - (Spin) wait for cond until a timeout
> + * expires. ACQUIRE ordering when @cond_expr is satisfied.
> + * @ptr: pointer to the variable to wait on.
> + * @cond_expr: boolean expression to wait for.
> + * @time_expr_ns: monotonic expression that evaluates to time in ns or,
> + *  on failure, returns a negative value.
> + * @timeout_ns: timeout value in ns
> + * (Both of the above are assumed to be compatible with s64.)
> + *
> + * Equivalent to using smp_cond_load_acquire() on the condition variable=
 with
> + * a timeout.
> + */
> +#ifndef smp_cond_load_acquire_timeout
> +#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	VAL =3D smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
> +					     time_expr_ns,		\
> +					     timeout_ns);		\

[Severity: Medium]
Could this local VAL declaration cause macro shadowing if a caller passes an
expression for ptr that contains VAL (such as &locks[VAL])?

If this occurs, it might bind to the uninitialized local VAL variable inste=
ad
of the caller's variable, causing the loop to poll on an incorrect memory
address.

> +	/*								\
> +	 * We arrive here once the loop condition is hit, on timeout,	\
> +	 * or, if we hit both the timeout and the loop condition.	\
> +	 *								\
> +	 * The last case is low probability, but possible in the last	\
> +	 * iteration, especially on architectures with waiting		\
> +	 * cpu_poll_relax() implementations (ex. arm64).		\
> +	 * Now since the loop condition is not evaluated on timeout,	\
> +	 * we have a missed control dependency.				\
> +	 *								\
> +	 * So, force a re-evaluation of the control dependency to	\
> +	 * provide an ACQUIRE ordering for that case as well.		\
> +	 */								\
> +	if (cond_expr)							\
> +		smp_acquire__after_ctrl_dep();				\
> +	(typeof(*(ptr)))VAL;						\
> +})

[Severity: High]
Since control dependencies only order stores that are executed within the
body of the if-statement according to the memory model, is LOAD->STORE
ordering missing on the timeout path?

The caller's subsequent code executes outside of this if (cond_expr) block,
so could this allow critical section stores to be hoisted above the lock
acquisition read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D6
