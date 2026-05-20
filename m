Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E83E9F9E
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315800; cv=none; b=PnjW0wslEYib/suWtgEWfOftH+L+r74g1UG94z1b8DK1L7jJ8P68GaSFQjQzBFU7SIc9MBjOrVYggWcprsmm7QX0yRDRVKG6tkON9KGmLUv3X3ry01NQtI+cB7S4W9eKrzpIbPFg1VT26mVu4NbhQcC81m6+Cu7/RRjAnHBLC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315800; c=relaxed/simple;
	bh=c5KtuVJEypQNmBDqrABErzwHMWlU4J/n/nIIXwtvdkQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tx/OKy2lgXXA3B2swgzbnwddHrRKmsXcIOBE4vLYxd0aB7uV9ZTeNCr360ugafuVn/jXLrYaXdL2H73N7tfzxhPqf1HJUSO5ZfLUO2B8ONU048dRt7L/DxpkbrpBCmNMmAJmDOq7T5WEoHiQfAb39PNmciaBiOHcg8ok8TpmCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTs47eX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTs47eX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890CD1F00A39
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315798;
	bh=DRgENr5M4QCWCDwxotBgWIaFYD8id1+T9evlq1gW2Zs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PTs47eX4mMkhNHgLaSM15miXr1uP8zP9I0JwmDuECLLnHESmIGU1FSzFr+7xRsWJb
	 FBYbq94gavXDDZfqKQ9FAr9c4uzEKAtOkIL8S9W0vAB5Sdx9MbH8nvgolLfMZR9Z2d
	 2dWnQ+7c0FMYih8R+pVmlBXflAlASVTA6w75I7goj3l/WIxeXZmSVgxVab5DLRtp4H
	 6su9mzQ/KXiv9AyMBA6CGyVUX1OTGsBWvgcWpak6Q9bGxTXii8L3p8vD0l2lvsRt/k
	 kN37uhQqJB+e+kIFMGfif39xWRaEeoMOJSZsx5Fq8geRL+fnn5lkrZDxKUq6rqPUoS
	 llshIAuSbjSGw==
From: sashiko-bot@kernel.org
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520220911.CFvlnyVcHmbbf-7TW9sOJLUFR5zWx_ZUaYCOvpNAHpc@z>
References: <20260520220911.CFvlnyVcHmbbf-7TW9sOJLUFR5zWx_ZUaYCOvpNAHpc@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:23:18 +0000
Message-Id: <20260520222318.890CD1F00A39@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The newly added 8-bit (BPF_B) and 16-bit (BPF_H) atomic instruct=
ions are not assigned to any conformance group.
- [Medium] The documentation fails to specify that 32-bit LOAD_ACQ operatio=
ns zero-extend the loaded value into the 64-bit destination register.
- [Low] Commit message typo: 'instroduced' instead of 'introduced'.
- [Low] Subject-verb agreement mismatch in documentation addition.
--

commit 0d39d0f059fd9242ec286f0067c48e70de5d5dc6
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, docs: add LOAD_ACQUIRE and STORE_RELEASE instructions

This commit updates the BPF standardization documentation to include the
LOAD_ACQUIRE and STORE_RELEASE atomic instructions. It adds the missing
entries for these instruction modifiers and describes their behavior.

> bpf, docs: add LOAD_ACQUIRE and STORE_RELEASE instructions
>
> Commit 880442305a39 ("bpf: Introduce load-acquire and store-release
> instructions") instroduced the LOAD_ACQUIRE and STORE_RELEASE atomic

[Severity: Low]
This isn't a bug, but there is a typo (instroduced) in the commit message.

> instructions modifiers. Those are currently not described in the
> documentation, despite being used in the verifier and the various JIT
> compilers supporting them.

[ ... ]

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
Do these new 8-bit and 16-bit instructions need to be assigned to a
conformance group?

The BPF instruction set specifies that instructions not explicitly assigned
to a conformance group fall into the base32 group.=20

By not adding these to atomic32, atomic64, or a new group, does this implic=
itly
force minimal BPF runtimes to support 8-bit and 16-bit atomic load/store
operations even if they don't support atomic32 or atomic64?

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
> +zero-extended.

[Severity: Medium]
Should the documentation also specify that 32-bit LOAD_ACQ operations are
zero-extended into the 64-bit destination register?

Because LOAD_ACQ is encoded as an atomic store (BPF_STX) rather than a memo=
ry
load (BPF_LDX) or an ALU32 operation, it does not strictly inherit the gene=
ral
zero-extension rules.=20

Omitting the 32-bit behavior while explicitly calling out 8-bit and 16-bit
could create an ambiguity that leads to divergent JIT implementations.

> +zero-extended. As atomics are encoded as stores, the meaning of dst and =
src

[Severity: Low]
This isn't a bug, but there is a subject-verb agreement mismatch here.
"meaning" is singular but "are" is plural. Could this be updated to
"the meanings of dst and src are different" or "the meaning of dst and
src is different"?

> +are different for ``LOAD_ACQ``, effectively using src as memory based
> +pointer and dst as destination register for the fetched value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520220911.CFvl=
nyVcHmbbf-7TW9sOJLUFR5zWx_ZUaYCOvpNAHpc@z?part=3D1
