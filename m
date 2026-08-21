Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C437E5EF
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352920; cv=none; b=I7thxvvphuaUcoIPv1dJJZ3tgn4syF3nVNz8qPVwiGDH3zEqY6RcWGuVelKbokDkymoFFwI0g5s16hAbJq2ka6UwWLTWQBUWvkH6g95/qJ4aZdMnXs+1leV682y/DxVO4xk5Tnn9HsVfM9ztjntiEBhcNQCHe406vZlCPJRau5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352920; c=relaxed/simple;
	bh=G8Ay/S4Wyf7tJt+rdE5nIH7DBVdcGaB8tRX6IblbxFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvFvz4fA+lDOdBLC2DKgFUzAfOClQor0s2TyfPGbTpytiT+hrNu0i6IIy/hIb2xM9NtPuYppiaigVwbJisM6KdJFQ9VNKMWarxI1wUqrmf8SRGd16I+5bpwuXr7bM624MszdFI9G6/LV76ds3bnan7Q7CAK9ObKAhI++i1jFdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAiblcMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAiblcMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925AC1F000E9;
	Fri, 21 Aug 2026 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352918;
	bh=O+sYJqBLpVf/o6as2O9a2qTV3txPuFwWJ+Hqco1Rkzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAiblcMCjrMm22rc6RzA9LWJfzwDcY+L1cPlE+04LhtU3aAY49+TJ0yborC4ryNPf
	 Ufl5bl+y0HG7v1Au6zgvH5dim5fdK7j3WFzagJNv4zrSbE0/uJH95XPghi6cghemX0
	 Yg8pdT3YO/9o7N6UM3rX/hTfawq0tohceaEeoJcah+/LJVythZ3A6GEHBNO9BAPEru
	 9I3KPSc+1Ycw2F55+9qcD7b7Vc63YTcyOzuEW9L5V28xWoOYpkenOYDNMl5p7FHx2b
	 eEtEKZ/jpLThhl55GjjjlRciLuVWJ6WMeZCgAySoYLxdNo4ulz8ipZcuDGeflN4k9M
	 zJVZWtZj3kkAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 5/9] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260822-kasan-v7-5-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-5-99afee6ef7fd@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 22:55:18 +0000
Message-Id: <20260821225518.925AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Caller-saved register R10 (BPF_REG_AX) is clobbered by KASAN check=
s during BPF atomic fetch operations and constant blinding, causing silent =
memory corruption.
--

--- Patch [5]: [PATCH bpf-next v7 5/9] bpf, x86: enable KASAN for JITed pro=
grams on x86 ---
commit 0c36ddb8d38e85fd1cfe5d79b5382a25c0f86a21
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: enable KASAN for JITed programs on x86

This commit marks x86 as supporting KASAN checks in JITed programs, causing
the JIT compiler to insert checks on translated instructions.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 48ccc3e6059d0..745890d91e99a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -234,6 +234,7 @@ config X86
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> +	select HAVE_EBPF_JIT_KASAN		if X86_64

[Severity: High]
Does enabling this feature expose a register clobbering issue in how KASAN
checks are emitted?

Looking at emit_kasan_check() in arch/x86/net/bpf_jit_comp.c, it deliberate=
ly
skips saving R10 (which is mapped to BPF_REG_AX) before calling the KASAN
helper:

	/*
	 * SystemV ABI states that we should also save r10/r11, but in
	 * practice those registers are _not_ used by the limited set of
	 * kasan helpers we are calling here, so that's fine not to save those.
	 */

However, KASAN helpers are standard C functions following the System V AMD64
ABI, which are allowed to clobber R10. Additionally, if KASAN detects an
issue, kasan_report() is called, which also clobbers R10.

Meanwhile, do_jit() relies on BPF_REG_AX (R10) being preserved across KASAN
checks, such as during atomic fetch operations:

				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
				if (src_reg =3D=3D BPF_REG_0)
					real_src_reg =3D BPF_REG_AX;
				if (dst_reg =3D=3D BPF_REG_0)
					real_dst_reg =3D BPF_REG_AX;

If R10 is clobbered during the KASAN check, won't the subsequent atomic or
memory instruction use a corrupted R10 as a memory address or source value,
potentially leading to silent memory corruption or crashes?

>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA			if X86_32
>  	select HAVE_EXIT_THREAD

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-kasan-v7-0=
-99afee6ef7fd@bootlin.com?part=3D5
