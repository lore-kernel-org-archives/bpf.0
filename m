Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF43D3F210A
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015631; cv=none; b=Ikvfsbv8u1zDzb2pG1H5sq/1bVhoEcdvUi597dabfXUg5KJo5Itv4CSH8nVOAZkva9OdLlADoXlbYiGdUh+Dv1UJFqlIHEo1rJTl9ZH+g+lrf88SSARbBwdHPJlk3NxI58WH/tGXr1QoYtjCADIe23epULXgK0TYEADDcnt2QMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015631; c=relaxed/simple;
	bh=eOQZSJdXsQLGIUUV9MqQ+OWxWkMNqb13/qo66E5KSNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXuE9cLqDPw1Z2CMgGXNHpfNV76f9B/J1Tw8NsybDtL7Ffd3M7W6K1SVcCrav9d5tNKMJYCd/GtJXQukWimMn8WZelym61FVQcEbTq6oTvNJuqvVSrJN43gni8CKrpo58fz+CTLQvaezw0h+D9C8RziaCWxFBFA/42Fb5g7PADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxD4eItr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxD4eItr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DE51F000E9;
	Tue, 14 Jul 2026 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015630;
	bh=IcK188Zz61I8hEI3THVK1U9iIvAfujHcpJotpDp5uFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxD4eItrNOOw0oAByhwn5Ox2p0e2rwYaypiFkZXhNewYvfK0512HBl2j8Z6kvxqeF
	 TWdunFIToo2Hh6iS7q158uzQKtEDbZ326gTtV2CmycdUUZE+h0+oJNE6a+5dYdtwYr
	 cTm4IG3caF2Zc0dBprlIl7hAWgbE9+W9GUyEN2GZnnA4LWJXlnvAMbGS+YM6o0ORs9
	 8eKmSvjdT3Vkcc/qAVB3wt0jRliO+FZtykp8MqyZDbXD/xQ0X7nY/5Ny2Z63wOqNCI
	 K1myYJ3iLV725nGEOMaBlT0i34zj8sc5piMeZsaecguZOq2N0UxW4Rn+2aHOQWLywg
	 D2/2DckRhqseA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/15] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-5-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:53:49 +0000
Message-Id: <20260714075350.43DE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Using `NSECS_TO_CYCLES()` for large macroscopic timeouts causes =
a 64-bit integer overflow, resulting in a premature return and a CPU-burnin=
g spin loop.
- [Low] Any loadable kernel module using `smp_cond_load_relaxed_timeout()` =
will fail to link due to the unexported symbol `__delay_cycles()`.
--

--- Patch [4]: [PATCH v14 04/15] arm64: support WFET in smp_cond_load_relax=
ed_timeout() ---
commit 7ff3bc2dcc6f4fa787700453b8fc2f2fe6133304
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: support WFET in smp_cond_load_relaxed_timeout()

This commit introduces support for the WFET instruction in=20
smp_cond_load_relaxed_timeout(). It adds __cmpwait_timeout() and related
architecture-specific macros to handle the wait state with a timeout.

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cm=
pxchg.h
> index 6cf3cd6873f5f..9e4cdc9e41d1b 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
[ ... ]
> @@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
> =20
>  #undef __CMPWAIT_CASE
> =20
> -#define __CMPWAIT_GEN(sfx)						\
> -static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
> -				  unsigned long val,			\
> -				  int size)				\
> +#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
> +static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
> +					       unsigned long val,	\
> +					       u64 timeout_ns)		\
> +{									\
> +	unsigned long tmp;						\
> +	u64 ecycles =3D __delay_cycles() +				\
> +			NSECS_TO_CYCLES(timeout_ns);			\

[Severity: Low]
Will loadable kernel modules fail to link if they use=20
smp_cond_load_relaxed_timeout()?=20

It appears __delay_cycles() is not exported to modules, which might cause=20
an undefined symbol error during the modpost build stage.

[Severity: Medium]
Can NSECS_TO_CYCLES() overflow if passed a large macroscopic timeout?=20

Because its internal fixed-point arithmetic caps at 32 bits, passing a=20
large timeout (e.g., > 4.29 seconds on a 1GHz timer) might overflow and=20
produce a small truncated cycle count.=20

Could this cause the WFET instruction to complete prematurely and degrade=20
the wait into a CPU-burning loop, leading to a performance regression?

> +	asm volatile(							\
> +	"	sevl\n"							\
> +	"	wfe\n"							\
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D4
