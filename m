Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBF33A9FE
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316670; cv=none; b=C/KBZnequUVtCvsalXUCfe8jS0sxNBq6sndfr9RQ2DKJOhUAyZbpTZ47afVSUaFz84FTuutVodPRBgvJ1yS4EpySA7muNJ12o2dS0/n1VcWwTz3ZL3bK1MlkpCUrE4L4/YmXvD2ImS7panLCSdpWB8savkQPDoiXcNQBZDyxrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316670; c=relaxed/simple;
	bh=YZ+9pEpO3xAaWwYZXt9PMnVIah1kH2zUFhTMvoHYcLU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oiQ4iSwMnFIVTn8b3/CtUulRa+hhk2rpuPMyxwXxUd9Rh08bye8HQt//Rs2j+1QvNxq7PmEUt1IbWyBPgGOdByLNFMVG36tMXvH5IT2htPmlmwNmim54h60DySnOT4L7CE4bprbF73QJD/XvZXDYIQmx3UTZB/e+nYkgIV8SxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fee0h1uY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fee0h1uY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E0C1F000E9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779316666;
	bh=2XJlbX3V/2pNtycxC3xcPkeixMXAx3QcgcjAcwmmWIs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fee0h1uYY7PsP/4joBkaArp4sOX5n+GTA16IoE7TwKhUUc5O2qtrL55IG9CRinmqQ
	 GJopfV43FqBpux7qymz3K3bPlr8o17OngDAKxdVgaYmMCBvZ7kOzYf4M4fdMj9bQ8W
	 Z1yM/+5uPbwZcZj3A6Cy3KHXH+jJ7Dixbj8enbelT6OKOzMchml1pfF9EMic7eLENZ
	 kALbn8QwpaoRisyeCQ0vXC9zmGo8NAP1Vm2yRCigLP1yvdZ9SeYI9JbyosG3CIL0Kf
	 L/wuQH+jMbVyjJZuXH/fLvD8/vlI+C4R74ZEOjEaHll7KIKZ5zOEqNIE+O9Z0IVIwR
	 8O/GyrUsCbthA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:37:46 +0000
Message-Id: <20260520223746.A1E0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The newly added 8-bit and 16-bit atomic instructions lack an exp=
licit conformance group assignment.
- [Medium] The documentation omits the use of the `offset` field for LOAD_A=
CQ address calculation and lacks explicit pseudo-code for both instructions.
- [Low] The documentation explicitly states that 8-bit and 16-bit LOAD_ACQ =
values are zero-extended, creating an ambiguity regarding 32-bit values.
--

commit 442218b588f0cff62adb7ca3a7b372a864af4450
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, docs: add LOAD_ACQUIRE and STORE_RELEASE instructions

This commit updates the BPF instruction set documentation to include the
LOAD_ACQUIRE and STORE_RELEASE atomic instruction modifiers. It adds the
missing entries for these instructions, including 8-bit and 16-bit widths,
and explains their complex atomic encoding.

> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 39c74611752b6..e8b33374bd090 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -668,7 +668,8 @@ that use the ``ATOMIC`` mode modifier as follows:
>    part of the "atomic32" conformance group.
>  * ``{ATOMIC, DW, STX}`` for 64-bit operations, which are
>    part of the "atomic64" conformance group.
> -* 8-bit and 16-bit wide atomic operations are not supported.
> +* ``{ATOMIC, H, STX}`` (only for LOAD_ACQ/STORE_REL)
> +* ``{ATOMIC, B, STX}`` (only for LOAD_ACQ/STORE_REL)

[Severity: Medium]
Since unassigned instructions default to the base32 conformance group, does
this inadvertently make these 8-bit and 16-bit instructions mandatory for a=
ll
implementations?

Should these be assigned to the atomic32, atomic64, or a new conformance gr=
oup
to avoid imposing this requirement on runtimes that may not support them?

[ ... ]

> @@ -721,6 +724,14 @@ The ``CMPXCHG`` operation atomically compares the va=
lue addressed by
>  value that was at ``dst + offset`` before the operation is zero-extended
>  and loaded back to ``R0``.
> =20
> +The ``LOAD_ACQ`` and ``STORE_REL`` operations allow using lighter load a=
nd
> +store memory barriers rather than full barriers. The corresponding acces=
ses
> +must be aligned, but are allowed for any access size (8-bit up to 64-bit
> +operations), with 8-bit and 16-bit ``LOAD_ACQ`` loaded values being
> +zero-extended. As atomics are encoded as stores, the meaning of dst and =
src

[Severity: Low]
Does explicitly singling out 8-bit and 16-bit sizes for zero-extension crea=
te
ambiguity for 32-bit operations?

While 32-bit operations writing to a register zero-extend to 64 bits by def=
ault,
readers might assume 32-bit LOAD_ACQ values require different handling if o=
nly
the smaller widths are explicitly mentioned.

> +are different for ``LOAD_ACQ``, effectively using src as memory based
> +pointer and dst as destination register for the fetched value.

[Severity: Medium]
Does the LOAD_ACQ instruction also use the offset field for the address
calculation?

The text states it uses src as the memory pointer, but omits the offset fie=
ld.
Other atomic operations explicitly use dst + offset.

Would it also be clearer to provide explicit pseudo-code definitions for bo=
th
LOAD_ACQ and STORE_REL (e.g., dst =3D load_acquire((size *)(src + offset)))=
 to
remove ambiguity for JIT compiler and emulator implementers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-bpf-insn-d=
oc-v2-1-8c43c037d599@bootlin.com?part=3D1
