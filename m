Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4F632
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956794; cv=none; b=tl6GpwDDIOpkSCp23m99YYwJELoXs2/A4ZT827vixqRHlNZkxS4/SkVTpMEVC1+VRpr5LH+znN++wAiL9NORfaGLOSlww4KG6bajOnTNfoCeiNK+mKBZQMZl3KR2KrnLk0bIjyUoEv+TzLnCBCN+CpYBQo/kREApPfdZXBhaDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956794; c=relaxed/simple;
	bh=e9jDFNyLvznzmWaNdrxTCApdD+U7+1bfW+CwBFVUdXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjGN3iiY9OgjHqI4oIIxO0XPXHYDdYhH/jFFSde5oi9kRGe225v1mteBftjHSJZTb5GfAdFtVpXkcfh6tAIWrtKfo6Ua0w0ziwP93w5hYbg7lD9i9YWIrpWAMIb1xvKCpXsh84GPNtSTeI6sjADOu1MPza5m7iD/qzPiqt/R604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deXP63m9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deXP63m9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114B11F000E9;
	Thu,  2 Jul 2026 01:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956793;
	bh=KVRrmmWOtaieTfaREzOx3Ak+SVlFA0gq2mAXmv/lDwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deXP63m9uYXUWLQuEatQt4FNf0JSaM+7eR9BEuGAioNyLZcwOgnGYx5aGWfrZgTjk
	 951KbFnE1OovlTvuCjW5TrRvgujgi4tosSluEJm1+TVa+y/EseFr21CHvjaR56isdW
	 C28gh5jHBGKafTCRo3qOze+5JBMVA3WVBE5nAehX2LYMxDDDydTXh2PQyuagW/+TSH
	 vzLxKuX3R0PoF1f/k5cjYet46j/dGUZeFYsW5J3I9BF0cVtdUzmbwdJwTVYDW29S6g
	 L7NPwjSKW3YRyyeCgCOig+ZQW1Fpo/31DF2qy44h99yrMBt4411reaOKvuWhvsLJaC
	 sB4Lnrf6W7EIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/15] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-2-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:46:32 +0000
Message-Id: <20260702014633.114B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Logic Error / Timeout Multiplication on ARM64
- [Medium] Macro Hygiene / Variable Shadowing with Dual Evaluation Scope
--

commit a201cc27e79e55a5c14c260c860376ce7d87a0d3
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

This commit adds the smp_cond_load_relaxed_timeout() macro to allow
waiting for a condition variable to change while enforcing a timeout.
The implementation uses cpu_poll_relax() to slow down the busy-wait
and periodically evaluates the timeout condition.

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
> +	s64 __timeout =3D (s64)timeout_ns;				\
> +	s64 __time_now, __time_end =3D 0;					\

[Severity: Medium]
Could these generic local variable names cause shadowing issues?

If a caller references a variable named __timeout or __count in their
cond_expr, the macro will evaluate its own loop-mutated local variable
instead of the caller's variable.

Additionally, if a wrapper like smp_cond_load_acquire_timeout evaluates
cond_expr both inside and outside the loop, the same condition expression
could evaluate differently in the two scopes. Using more unique prefixes
(e.g., ___smp_cond_timeout) might prevent this.

> +									\
> +	for (;;) {							\
> +		VAL =3D READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
> +		if (++__count < __spin)					\
> +			continue;					\
> +		__time_now =3D (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end =3D=3D 0))				\
> +			__time_end =3D __time_now + __timeout;		\

[Severity: High]
Does this sequence result in doubling the expected timeout duration on some
architectures?

On platforms like ARM64 supporting WFET, cpu_poll_relax() can be mapped
to instruct the CPU to sleep for the provided __timeout duration. Since the
absolute deadline __time_end is not initialized until after this first
cpu_poll_relax() call, the initial sleep is excluded from the timeout windo=
w.

When the macro then computes the new deadline:
    __time_end =3D __time_now + __timeout;

and loops again, it could wait for another full timeout_ns, effectively
doubling the wait time.

> +		__timeout =3D __time_end - __time_now;			\
> +		if (__time_now <=3D 0 || __timeout <=3D 0) {		\
> +			VAL =3D READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__count =3D 0;						\
> +	}								\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D1
