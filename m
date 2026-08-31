Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550283AE6F4
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213039; cv=none; b=G6YEXT4gdwq/0teut2CVKnDB/cZyqlmlybBk4AAo9zZrosGtlraRojAtwwfzzxEMOOTgJgx009O5KbKYVOgTC+8Mgmh05PMmgkX1QK9anGO7Y8df0wNDhOSeXjX4IJnzYhGM6qHh6LX51iZPLXHD2UjNXLigwDtjnYPt2FJ5nf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213039; c=relaxed/simple;
	bh=1JE1Q5IMYB3THBIINpBG7i7qBvwp1+3K4LXsAeoPbjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNw1V8aelSgyk+3M5MEkLMnpioNTORL2MBpxV1BrQYKn6H0D3CLyUB9gK5uuwUk8SLQ6JxHP425UPkKOdA04Vyw7odUoTX1DXbDbb770dStfwLjbvLHeRhm2n7t6aeIqA2mTRZ2wBfPcruQMr/6sZEz8YEWbB61NZotDnuyYszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8bdjnLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8bdjnLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745441F000E9;
	Mon, 31 Aug 2026 21:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213035;
	bh=yVY41gC+sZS5Ra256JfAL4qmWOXa6uCMQMeZgAhd7nU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8bdjnLw8xI8jpQ0mJiaY+86OXYXuJIZyUVECCIy29ROdyyYjIhG5LgEcOFrsXo3W
	 dmKZl4N7zSuke0g3hfY9XMRWzex/zQprimcZSQyCm/cgLYfabOmqNNb0cAs/yPaeE5
	 BgCzww1t2Vtef0+5ZAPW7YV0/W+eo6NwrR3sS6tqCkFfDFY7+gdz1dXrzr8vHjVFOe
	 Lo1z5ZLljGZQr5O8UFFmjPbk4xqLCJcA+ZuFJ222Lii78b4+2RyMuf9pz4VLn6ie8T
	 J4ksr7XHuCwoHOlyHtSe2VgAO2jS9rar3WowzGK6g8/3pDWuZiSDKiyoBM9G0O66HQ
	 nrCAVh3Dz7C1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/16] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-2-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:50:35 +0000
Message-Id: <20260831215035.745441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional 1 microsecond hardware stall for very short or zero =
timeouts.
- [High] Redundant clock evaluation delays loop exit upon successful hardwa=
re wakeup.
- [Low] Implicit dependency on `NSEC_PER_USEC` without including time heade=
rs.
--

commit b4e52f4320fa73ae0869ca7d777ad60945812b82
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

This commit introduces smp_cond_load_relaxed_timeout() which extends
smp_cond_load_relaxed() to allow waiting for a duration. It defers the cost=
ly
time evaluation to the slow path to minimize the fast path penalty, using
cpu_poll_relax() to yield between condition checks.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index b99cb57dfcccc..8c37de1929443 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
[ ... ]
> +#ifndef smp_cond_load_relaxed_timeout
> +#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +					time_expr_ns, timeout_ns)	\
> +({									\
> +	typeof(ptr) __PTR =3D (ptr);					\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	u32 __scl_count =3D 0, __scl_spin =3D SMP_TIMEOUT_POLL_COUNT;	\
> +	s64 __scl_timeout =3D NSEC_PER_USEC;				\

[Severity: Low]
Does this introduce an implicit dependency on NSEC_PER_USEC without includi=
ng
the required time headers?

Callers using this macro in files that do not include <linux/time64.h> or
<vdso/time64.h> might face build failures.

> +	s64 __scl_time_now, __scl_time_end =3D 0;				\
> +									\
> +	for (;;) {							\
> +		VAL =3D READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);		\

[Severity: High]
Does this unconditionally initiate a 1us hardware stall on the first iterat=
ion,
even if the user requested a zero or very short timeout?

When timeout_ns is less than 1000ns, __scl_timeout is still initially set to
NSEC_PER_USEC. On architectures with precise waits (like ARM64 wfet), this
could force the CPU to sleep for 1 microsecond, degrading fast-path polling
performance.

> +		if (++__scl_count < __scl_spin)				\
> +			continue;					\
> +		__scl_time_now =3D (s64)(time_expr_ns);			\

[Severity: High]
Is it necessary to unconditionally evaluate the clock after waking up?

When cpu_poll_relax() wakes up because the lock was released, evaluating
time_expr_ns (which could be an expensive clock read) adds latency to the l=
ock
handoff before checking the condition again.

Would it be better to re-evaluate the condition immediately after waking up,
bypassing the time check if the condition is met?

[ ... ]
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	s64 __scl_timeout_ns =3D (s64)(timeout_ns);			\
> +									\
> +	if (__scl_timeout_ns < 0)					\

[Severity: High]
Should this condition also include the zero timeout case?

By using __scl_timeout_ns < 0, a timeout of exactly 0 is passed to
__smp_cond_load_relaxed_timeout(), falling through to the slow path and
triggering the 1 microsecond delay discussed above.

> +		VAL =3D READ_ONCE(*(ptr));				\
> +	else								\
> +		VAL =3D __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
> +						      time_expr_ns,	\
> +						      __scl_timeout_ns);\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D1
