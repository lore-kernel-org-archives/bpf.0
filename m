Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205882DB7BD
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015048; cv=none; b=nZVHWduqnZ0J/uNUr+WdLj95a+QyUbIHdK1nAJMHOxSkYYKmrCJp+hPaBYd/Va8wpDaLDNLPKya6c0HIrQSTV3Sag/U55nAhi02CZfCRQnepdXb3+xk6q3BTtIQILbmC4NuPndGSeKGVuX5yWsbvruV/r4ijZTwQyH0O6RSrA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015048; c=relaxed/simple;
	bh=twgFHp23//RTwnlp+Jeb5pbr6gcTZJuCDRl7J0nvuJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJrs61D57e1vojLjMU3Od+2QP2NzN2F88kSBV/hVTsLsKTL+IHdTaHKfjXZgwFqi8F1MsmEWJvqWu8S0Jsu6+Uf/1FAfDQl4ccyyU1IK+WxRf+Kw3ZzUAmN8j2y1ohcJ//tFqRFfT9VUFnNnndYjKboaITh+hlX98bXRqkJoagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjCD/jEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjCD/jEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EDF1F000E9;
	Tue, 14 Jul 2026 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015046;
	bh=cFXjVtkjsEZ2BRnACaQ45sFXXtdweLfShiF9KjDYrHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjCD/jEig8LUST30ufOqJcPXeRAjfEzQw64RvS0RYxovWbXAND8YizSrU/28J1X+b
	 SuExTgQ1ugXa5dq29uX+bZ+WNlR6nJ6qYsr57JjzJJbiReNYJ7uM0eYwp8PYbxx+3x
	 +A4gCYT73QmyPP2ZcsD/gtsnBTXngxPuh0L/QxDKlP+O48zFt4TuCIJWF29GEOhfB4
	 584ktPqUuH/8wb9lMjlwUdhMvga1QH9i3qRrP9hcc9P6VGtSakaKt4IErnkd6Q6dz6
	 xB6X4bvI2ajxeG0NNGRP5dQAMhig22bXMDdE9MeZNoH7+g7dPnvZPci8pTD096klkF
	 uHqHWaVTs0pcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/15] arm64: rqspinlock: Remove private copy of
 smp_cond_load_acquire_timewait()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-6-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-6-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:44:06 +0000
Message-Id: <20260714074406.95EDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the ARM64-specific `smp_cond_load_acquire_timewait()` fal=
lback before replacing it with a working alternative breaks BPF `rqspinlock=
` timeout functionality, causing indefinite hangs on platforms without a ti=
mer event stream.
--

--- Patch [5]: [PATCH v14 05/15] arm64: rqspinlock: Remove private copy of =
smp_cond_load_acquire_timewait() ---
commit e150f6dc634a9b6af6666a67d9bc5ea262bedad7
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()

This commit removes the private definition of smp_cond_load_acquire_timewai=
t()
and its helper macros from arch/arm64/include/asm/rqspinlock.h. The commit
message notes this is in preparation for defining
smp_cond_load_acquire_timeout(), allowing rqspinlock to fall back to using
smp_cond_load_acquire() in the interim.

> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm=
/rqspinlock.h
> index 9ea0a74e58927..a385603436e98 100644
> --- a/arch/arm64/include/asm/rqspinlock.h
> +++ b/arch/arm64/include/asm/rqspinlock.h
[ ... ]
> -#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
> -				      time_expr_ns, time_limit_ns)	\
> -({									\
> -	__unqual_scalar_typeof(*ptr) _val;				\
> -	int __wfe =3D arch_timer_evtstrm_available();			\
> -									\
> -	if (likely(__wfe)) {						\
> -		_val =3D __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
> -							time_expr_ns,	\
> -							time_limit_ns);	\
> -	} else {							\
> -		_val =3D __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
> -							time_expr_ns,	\
> -							time_limit_ns);	\
> -		smp_acquire__after_ctrl_dep();				\
> -	}								\
> -	(typeof(*ptr))_val;						\
> -})
> -
> -#endif
> -
> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v=
, c, 0, 1)

[Severity: High]
With this custom fallback removed, the BPF rqspinlock code will use the gen=
eric
smp_cond_load_acquire(). Does this mean on platforms without a timer event
stream (arch_timer_evtstrm_available() is false), a CPU could get permanent=
ly
stuck in a WFE instruction during a lock timeout?

In kernel/bpf/rqspinlock.c:resilient_queued_spin_lock_slowpath(), the timeo=
ut is
evaluated as part of the condition expression:

    res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, =
ret, _Q_LOCKED_MASK));

But smp_cond_load_acquire() calls __cmpwait_relaxed() which executes WFE:

    __cmpwait_relaxed(__PTR, VAL);

If no stores occur to the locked byte, WFE will wait indefinitely, and the
embedded timeout check won't be evaluated while the CPU is asleep.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D5
