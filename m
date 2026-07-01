Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4451A680A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909631; cv=none; b=LupeE+HkcAQDxlAAmGNelMFuSnrGJwdZaNKe7JjdOi6sMvWyzArye5XeCz/LOlgdEDQIWia9B4SztHGtBTjOAuoBzunVcveWm8pmhXFhGc/srp8Cgqp1K+7tlKPGYnvKurJDFU/qx+YtoU2AKq8OROhYV11xXZq40PsVsVJpUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909631; c=relaxed/simple;
	bh=O/LljOG17DxqVju7q5Vb0yK0zACP1fVUW2jn7og3V8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dlgGVpGdTWBFRx2uEqLUZPXNIDgqY0QrGxb+VLlGRti71HCiwEakqgPhbnClEuE8tYF7w3kn3DxjJRPoTgPC6HXpVpefGiMd3Cw/Mo+cwFyNjvGAr/bbpqdZ4nkOhXR1AwpjJoIMiDzI7s/hcoWxHIyconVO1PVcATS7beiVdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMsuVp17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMsuVp17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B001F000E9;
	Wed,  1 Jul 2026 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909630;
	bh=QidRZOIJNBBD1SziN4aMw9C6d4YXt2sKVR65gsJaJ3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMsuVp17BgMlRAvO5rfRQ69jB9HseLIr4LsA+D6GK0JGFoXWI84pvfUcAYZ7AQtBE
	 jGmj4DWiXO4Kw2l2Vm59564lhdF7fz06n74Ny0muPC298emlLreAUIa77kEPXhwl8b
	 qAs/su7yIDgVIt2qQdw3GdISgqHgT9G2hWPWOKOuaa/qLecRstiXXuzxIubPbR534R
	 92dGa1QzZxFObT0hWqaWLBJ+FCIfXRgSinr4yseKc1ArffU+hw839HxWzpqWusmIq+
	 aKiA+3TyOiDN8BkzBDBdXu2tc0kV8D+LgrHHi44VuOPR8aR3f8zQc6nWYxmhrvgEgi
	 Wovbip1FD2auw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] riscv: io: avoid null-pointer arithmetic in PIO
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701122948.57584-2-cuiyunhui@bytedance.com>
References: <20260701122948.57584-1-cuiyunhui@bytedance.com>
 <20260701122948.57584-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:40:29 +0000
Message-Id: <20260701124030.24B001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect memory barrier used before writing to I/O port in `outsq=
()`.
--

commit 8166082f73bb766f324d8ad444fbd61adbfe4558
Author: Yunhui Cui <cuiyunhui@bytedance.com>
riscv: io: avoid null-pointer arithmetic in PIO helpers

This commit restricts port I/O string helpers to only be available when
CONFIG_HAS_IOPORT is enabled. This prevents clang from diagnosing null-poin=
ter
arithmetic from the PCI_IOBASE expression when port I/O is not supported.

> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 09bb5f57a9d34..92d5f831f3495 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -116,26 +118,32 @@ __io_writes_outs(writes, u32, l, __io_bw(), __io_aw=
())

[ ... ]

>  __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
>  #define writesq(addr, buffer, count) __writesq(addr, buffer, count)
> =20
> +#ifdef CONFIG_HAS_IOPORT
>  __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())

[Severity: High]
This is a pre-existing issue, but does outsq() use the wrong memory barrier?

While outsb(), outsw(), and outsl() correctly pass __io_pbw() as their bfen=
ce
parameter, outsq() passes __io_pbr(). Because __io_pbr() expands to a read
barrier instead of a write barrier, could a weakly ordered CPU reorder
earlier memory writes after the I/O port writes?

>  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, =
count)
>  #endif
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122948.5758=
4-1-cuiyunhui@bytedance.com?part=3D1
