Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359B38C2A7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960884; cv=none; b=h5ww5q7rrWlf/BI387aiNhDyKPMiKmROalv1EC7VtPUtnEBuayMcUJ/dfGZrRHjxoNJzbgfMKLv8DxAtoOTrzOFoi/tJMpWL0431uZj6LEV6DH6t83MeljTaJb70gLaZPE+CzR00Sabcf40xU8V43pXa7B+ioQaZH5k4G+ser6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960884; c=relaxed/simple;
	bh=V6Pm0+UHX5Odbs2X/y8TK9kSz7ATPxDLmHJCWhc8L/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ffm94HE0nAHGr3U/8w22yvPd0poTE5OOnaCc9wpPPSqaAtG7b2VEe8M6WO+gNx3oKHl8vG7T0T5mc+R/RSsVTJGfJSYm2N/fOiEKQiGEkS6lOTAVFrCtThCuM0bbshzc6by8dztrI2Cj9XkHf8TxEiHn4XzK0RQdPzbiSxYtT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4qgruaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4qgruaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8A01F000E9;
	Wed,  5 Aug 2026 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785960882;
	bh=l97wcBigkUzReQEej5VeN1alHx1rQgpr+dsThChCoQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g4qgruaM0s4zLQjdMbc5ORJLZYVP9ZWy6HXIOVyicS/4AYalLtrqLIbsC7S5wo38+
	 1k91Nxcw9iDIAZ4t47kbjEovv1CequRnQn6fjteGtINUupeZV1suNerGVDeall4bGZ
	 ZUIEwqCkGkeA5VaYCZac2sK02kNG00Y5uVVLOjsYIOlpk3pHYpvTFHoH33w3FMONUL
	 xTzc6gjF0X8G0fAPOmTLPzs8m/EcGdkLEMhP8d82pY5gd/L9pj9U6En/IAtCgi5NB4
	 E/RbAK1wzaWgPylFIZfo/Bh7ShLXdN5jfD71Obr6qz9YZJM8ydnmbLhVNDzqTrZsGQ
	 LqaAYHmt06qfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add test for arena pointer
 zext across state pruning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805184444.292828-4-daniel@iogearbox.net>
References: <20260805184444.292828-1-daniel@iogearbox.net>
 <20260805184444.292828-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:14:41 +0000
Message-Id: <20260805201442.5A8A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The selftest uses a 64-bit instruction (`r6 =3D 0`) instead of a=
 32-bit instruction (`w6 =3D 0`), which zeroes the upper 32 bits and bypass=
es `BPF_F_TEST_RND_HI32` randomization, masking the bug it intends to catch.
- [Medium] The test's exit logic masks wild pointer faults via BPF exceptio=
n tables, causing it to always return 0 (success) even if it successfully r=
eproduces the bug.
--

--- Patch [4]: [PATCH bpf-next 4/4] selftests/bpf: Add test for arena point=
er zext across state pruning ---
commit 230d6f79c5ec9b66b6dcd9f9c3cb999533024b62
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add test for arena pointer zext across state pruning

This patch adds a selftest to verify that the BPF verifier correctly marks
zero extension for arena pointers across state pruning. The test uses an
addr_space_cast and relies on BPF_F_TEST_RND_HI32 to ensure proper zero
extension on architectures like s390x.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index b241bbcf54a8a..b5f5b81a27e71 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
[ ... ]
> @@ -635,6 +635,41 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
[ ... ]
> +	if r7 !=3D 0 goto l1_%=3D;				\
> +	goto l0_%=3D;					\
> +l1_%=3D:	r6 =3D 0;			/* 32-bit define */	\

[Severity: Medium]
Does using a 64-bit assignment here bypass the BPF_F_TEST_RND_HI32
randomization framework?

Since r6 =3D 0 translates to a BPF_ALU64 instruction, bpf_is_reg64() returns
true and the verifier's bpf_opt_subreg_zext_lo32_rnd_hi32() pass skips
instrumenting it. This prevents garbage from being injected into the upper =
32
bits, masking the missing zero-extension bug the test intends to catch.

Would using a 32-bit assignment like w6 =3D 0 correctly trigger the
randomization?

> +	r6 =3D addr_space_cast(r6, 0x0, 0x1);		\
> +l0_%=3D:	r0 =3D *(u32 *)(r6 + 0);	/* 64-bit read */	\
> +	r0 =3D 0;						\
> +	exit;						\

[Severity: Medium]
Will this exit logic mask wild pointer faults?

Because r6 is a PTR_TO_ARENA, the verifier converts the out-of-bounds read
into a BPF_PROBE_MEM32 load. If r6 contains a wild garbage pointer and trig=
gers
a page fault, the kernel's exception tables will silently catch it, zero r0,
and resume execution.

Since the test then explicitly executes r0 =3D 0 and exits, and the framewo=
rk
expects __retval(0), it appears the test will unconditionally pass even if =
it
successfully reproduces the bug.

> +"	:
> +	: __imm_addr(arena),
> +	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805184444.2928=
28-1-daniel@iogearbox.net?part=3D4
