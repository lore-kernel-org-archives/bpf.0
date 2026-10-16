Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38643785F
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135541; cv=none; b=LVUSHg8juPFMo3Py6WeXm36AQez10XqSMT2ThCiWdXWCMYpzngodl8d3ZOVoI/RdAx3DVHfG2680vQYJXwBUJ1hNYug8g7kW9/tEydiq3as2AdC7NyjMhntSMxoHhWE+GmFJuUPrEZHoFo4dM4yHYsn1T/iI5G1zn9IoKiBeb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135541; c=relaxed/simple;
	bh=thtT7M8tbAo8v/mM4FvFF4+xeKQRqhaWfyMDK7zRGQI=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=PbI3bghPfgHh81/n237PNUg+JfefGgmG4muusCFhHbX1EZBu+bN41ng2OEb0o42Jxb+jxIMbELhXZ+FPD7G2bEuu+88lamRZsKvTldS1QWbJrve/JzjW3IYcIRP2ZV3oYwt+Zut9aq93r0eWGCt6PdoG+6f6UYtk3fFOBVjJmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRky6pdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRky6pdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE4D1F000C4;
	Fri, 16 Oct 2026 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135540;
	bh=1gADQSA9u36aIRpKghk2hmcYU8P3ruNTwr932cSiRCU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jRky6pdHvLg23+8wyF66vRwqbRslNs0nnQV6NflbYC72/dKcbcVYBX9ItlVBJbqaU
	 yoVXyNSNylzMYRFYwI6K1J4DPsW2Xb5ga7bSRbh1rYicEdhYVc8tGznmX7lKqD6qn3
	 gsuwF3rTiG3Mp+tQ67Feb2vh2POP9QE/3QtVIKIixcnijeVL7ztryTjXU/BpXv6+Rv
	 K/h+bSsGQdXuDfX4Vl20vNNBwhkKfXDIrIKLtbJNHc0/NUxWCtntdML2f5oGyN0T/t
	 Td56DKKEVoKCHcHlfXo92p5N/Z+8+mFgEKwfFOfGuhyviYkNVvs/U5TZ+3WQIjAjfs
	 vOtQ0ptR4oDIg==
Message-ID: <sashiko-outbox-173924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/16] atomic: Add atomic_cond_read_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-8-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:25:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] atomic: torn reads in atomic64_cond_read_*_timeout on 32-bit
- [Low] docs: incorrect categorization of atomic_t operations
--

commit 9e35fd2167c99d05e59317145e35667a8118c80e
Author: Ankur Arora <ankur.a.arora@oracle.com>

atomic: Add atomic_cond_read_*_timeout()

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index bee3b1bca9a7b..0e53f6ccb5580 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -16,6 +16,10 @@ Non-RMW ops:
>    atomic_read(), atomic_set()
>    atomic_read_acquire(), atomic_set_release()
> =20
> +Non-RMW, non-atomic_t ops:
> +
> +  atomic_cond_read_{relaxed,acquire}()
> +  atomic_cond_read_{relaxed,acquire}_timeout()

[Severity: Low]
Does this section header miscategorize these operations?

These macros explicitly take an atomic_t pointer as their primary argument =
and
operate on atomic types. Was the intention to denote them as conditional wa=
it
operations instead of non-atomic_t operations?

[ ... ]

> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9b..5bcb86e077845 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -31,6 +31,16 @@
>  #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->cou=
nter, (c))
>  #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->cou=
nter, (c))
> =20
> +#define atomic_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
> +
> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))

[Severity: High]
Could passing the address of the 64-bit counter directly to the unlocked
polling macro lead to torn reads on 32-bit architectures?

The generic atomic64_t implementation for 32-bit architectures (used when
lacking native 64-bit atomic instructions) updates the counter via two 32-b=
it
stores protected by a hashed array of spinlocks in lib/atomic64.c.

Because smp_cond_load_acquire_timeout polls the variable using an unlocked
READ_ONCE(), concurrent updates to the counter will bypass the spinlock.

On 32-bit architectures, READ_ONCE() on an 8-byte value evaluates successfu=
lly
but compiles into two independent 32-bit reads, which can result in data
corruption.

Additionally, smp_cond_load_acquire_timeout relies on smp_load_acquire() wh=
en
timeout_ns < 0. Can this cause a build failure on 32-bit architectures due =
to
compiletime_assert_atomic_type() preventing 8-byte acquire loads?

The pre-existing atomic64_cond_read_acquire and atomic64_cond_read_relaxed
macros share this identical architectural flaw, and it looks like the new
API macros propagate the same vulnerability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D7
