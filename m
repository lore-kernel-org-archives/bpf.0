Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB6419FB2
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135303; cv=none; b=YsPiHcG1kpu6aUlPXFhEM5ED/rpzS92WGql585A7pqxnbM+iEg1OeVuUFVK6HpojKtmZkyjqBwUFZd4dkvN/V7sleix6brInoE96VKF7nj2QvZ+B1yGDw8aUzwlm+C3HugkeK+QuetqXgImOSIvHDQ7NR1J7FZGBD4HTjxmZfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135303; c=relaxed/simple;
	bh=dU/WiJQvE24dgcn+sWIeDLfML5M8VB3DNucn6vFWfIU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=boD9gzM29LY5EtQ7YF8Rio/1C/6PCaXagt3YTm0jDRn1q2Out6nr7AV1/zeiZwzM16lHWQrkCCyxtBOrOcgRfxYxjbhYvCEI7OysCocyS8NKhZ/rsSG/viZDDLYvTuru2rqvXfBdekMRYre1QC5dbp2NjqY1yQjyZs7m58a0J2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5AmNHnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5AmNHnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479951F000C5;
	Fri, 16 Oct 2026 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135302;
	bh=7exJ8pBfZYTR+ejw+O6fnjy6ZVjx2OvhGorT/PbNGCc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=i5AmNHnuvL78WwtxS7zesfMAPvAp0+3F+tzASZUL+T7fMGrg74q3aXe57BFXP/31h
	 ACjA8F3bHIuPt9dsxTrEBvQF0WApNXiTqOn/bVkdPIqkEGyyB54+sG10aZfT7ee9ZL
	 P5cEq56GGBeJ2CzicT+a0+J6elrQiHCVwAKp4vktBMDmjDkfXl4S20lQwyHqtXTybw
	 9Yp6esjeFYOSu4VM76XogdzZZLff6ZFs59O4LvNkOpR/ERWYFjawDtgn2aO9WlFLeI
	 e1lAF/0InOOCeNnr2VGVpDVb77Kij7Zx2lsnDDG8cgwGs7JONQP+EQkApBOb5OfneM
	 rr+IbPvjXh0Nw==
Message-ID: <sashiko-outbox-173919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 01/16] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-2-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:21:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] locking: smp_cond_load_relaxed_timeout breaks control dependency f=
or ACQUIRE semantics
--

commit 33828050548c87a2007a049070718fdd9167df34
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

This commit adds smp_cond_load_relaxed_timeout(), extending
smp_cond_load_relaxed() to allow waiting for a duration with a periodic
time-check. It uses cpu_poll_relax() in a loop and defers the potentially
costly time evaluation to a slowpath.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index b99cb57dfcccc..ac0a8b5e0ffe7 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
[ ... ]
> +#ifndef smp_cond_load_relaxed_timeout
> +#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	typeof(ptr) __PTR =3D (ptr);					\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	u32 __scl_count =3D 0, __scl_spin =3D SMP_TIMEOUT_POLL_COUNT;	\
> +	u64 __scl_timeout =3D NSEC_PER_USEC, __scl_time_end =3D 0;		\
> +	s64 __scl_time_now;						\
> +	bool __scl_timed_out =3D false;					\
> +									\
> +	for (;;) {							\
> +		VAL =3D READ_ONCE(*__PTR);				\
> +		if (cond_expr || __scl_timed_out)			\

[Severity: High]
In include/asm-generic/barrier.h, __smp_cond_load_relaxed_timeout() evaluat=
es
cond_expr alongside __scl_timed_out. Does this break the control dependency
required for ACQUIRE semantics?

If __scl_timed_out is true from the previous iteration, this branch is taken
independently of cond_expr. Because the branch outcome is independent of the
loaded value VAL, the compiler can optimize the exit into an unconditional
break, meaning the CPU has no hardware-level control dependency to enforce.

Since smp_cond_load_acquire_timeout() (added in a subsequent patch) relies =
on
smp_cond_load_relaxed_timeout() to provide a control dependency on the load=
ed
value which is then upgraded to an ACQUIRE barrier by
smp_acquire__after_ctrl_dep(), this could allow subsequent critical section
memory accesses to be reordered before the lock acquisition load.

If the returned VAL concurrently satisfies the caller's acquisition check
at the exact moment of timeout, the caller will enter the critical section
without hardware-enforced LOAD-STORE ordering.

> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);		\
> +		if (++__scl_count < __scl_spin)				\
> +			continue;					\
[ ... ]
> +		if (__scl_time_now <=3D 0 ||				\
> +		    __scl_time_end <=3D __scl_time_now) {			\
> +			__scl_timed_out =3D true;				\
> +			continue;					\
> +		}							\
[ ... ]
> +	}								\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	s64 __scl_timeout_ns =3D (s64)(timeout_ns);			\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +									\
> +	if (unlikely(__scl_timeout_ns < 0))				\
> +		VAL =3D READ_ONCE(*(ptr));				\

[Severity: High]
In include/asm-generic/barrier.h, smp_cond_load_relaxed_timeout() handles
negative timeouts. Does this negative timeout path also bypass the control
dependency?

Because this path executes VAL =3D READ_ONCE(*(ptr)); and returns without
executing a conditional branch on VAL, no control dependency is established
for the acquire barrier to upgrade.

> +	else								\
> +		VAL =3D __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
> +						      time_expr_ns,	\
> +						      __scl_timeout_ns);\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D1
