Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628385;
	b=2uxc3crFAzLqY6khUrUDNXWsZHanGCmWMdvCUY68uBVMNvoVVyf1e4tkXFEA38ln7tMt
	 KbRrQBcIlhn0fSi/Qu8wbcWOB5hKFSuherq2044AUDhpiezWpMIEC5RmtMa1qTtKtT0UD
	 WknHoGtRrFP1zmjBQugj3Wie+LVIShp/GPPXcXv2ntMTmiKEn9P08CHzFUjaQ4y3cuNIP
	 SPT5Xux/aUkSeGxdMBeRsnnQjnjqmOeo6ab6ZuCcJvW8AWdqPg8IgtSCU6QOjZPGL4Igb
	 4r17Kvz9Urmfa4x21SE/jjoZYQ2o/uV2EW9KAkizsm3Vej/pSW8DuN/2NsMSVM4V9Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hbtroqlHKVtAAUtHCA55MxKDmxGUEdLCC1/fEVnGaXw=;
	b=MMxM7D6WgDPhquDAKfPZ5rm79RaY0R263noRdjo2l4qMJMzZacq/grjBPAP9X293VNyK
	 j2lvbdTt2C4mar67aoOKu9YxfPu9yxbcfVui7SWoKMp9QlpIVvZrYRxCVE3n931e7j3YJ
	 Py7iWvGnRMK0lROEJBsKrn4KvaGRHrFw0rHwuxPLQL5SD5NZ39Z0eH13Thgx/0/dCcCoJ
	 t66TY3nhAai7esr1RUviKVqkmD+CR4kzFn1AARKCe1O0fpoc9r9VPuYcg5W3JzfUapHZy
	 3hSKq4R4sGw1eRtXUGl7XTJeBgl2uY9DkmScvERH3GLRv758gauGBTi1Wkuyhat5NZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WO16Q+/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D592606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WO16Q+/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB10F1F000C4;
	Wed, 25 Nov 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628384;
	bh=hbtroqlHKVtAAUtHCA55MxKDmxGUEdLCC1/fEVnGaXw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WO16Q+/kVNAOFICjGGEYRci+DVk05Ndb5ZEEdIFWiHBNfCe6LpozfIJO/DKTvUrJ+
	 WZURzuTUgjFjaTzNvLvIaYU5QbVQgPD1VdjDwVtIR3R/+c94dxK43jSssHBE3F7Rfq
	 LM8JGe3wuB9WTICLSRQK3pWHPAxJihNvwF1eiWDIxk5uo7oZf6yGzNRQ9DkTTqmWbS
	 4RPcXgrTo9wnRVAolrANJr557euj8mZVnc+wpcgnjJomBoJe3/kc6JZHHbu68qUgKS
	 X7FBn7cOb4eT84W2x6xQbsGShhL9zgRzOGN/vA89AlDZYiVBSlQqIlVabSZ9oAUXFF
	 xWrhWOB7GJRkA==
Message-ID: <sashiko-outbox-233852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Test the insns that
 bpf_insert_insns() inserts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luis Gerhorst" <luis.gerhorst@fau.de>, bpf@vger.kernel.org
In-Reply-To: <009289699441bb2f2f7d05ade781e8644b23d04e.1795625597.git.luis.gerhorst@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
 <cover.1795625597.git.luis.gerhorst@fau.de>
 <009289699441bb2f2f7d05ade781e8644b23d04e.1795625597.git.luis.gerhorst@fau.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:39:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: rnd_hi32_patch on w0 in
  zext_cmpxchg32_jump_out_of_range()
--

commit 05c2252db292a3024a0c209b16a5310701e3d6bb
Author: Luis Gerhorst <luis.gerhorst@fau.de>

selftests/bpf: Test the insns that bpf_insert_insns() inserts

This commit adds BPF verifier selftests covering upper-32-bit randomization
under BPF_F_TEST_RND_HI32 and jump range overflow when inserting zext or
per-CPU address instructions via bpf_insert_insns().

> diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/te=
sting/selftests/bpf/progs/verifier_zext.c
> index 572017fe28fbe..d06a02242c555 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_zext.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
> @@ -415,4 +415,61 @@ __naked void probe_mem(void)

[ ... ]

> +/*
> + * The zext is inserted behind the cmpxchg, between a jump with the smal=
lest
> + * offset and its target. The program is valid, it is only rejected beca=
use the
> + * verifier can not widen a jump when it patches a program.
> + */
> +SEC("tc")
> +__description("zext does not fit behind a cmpxchg")
> +__failure __msg("cannot be patched due to 16-bit range")
> +__naked void zext_cmpxchg32_jump_out_of_range(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 =3D r0;					\
> +	r7 =3D 0;						\
> +	goto l1_%=3D;					\
> +l0_%=3D:	r0 =3D 0;						\
> +	exit;						\
> +l1_%=3D:	r1 =3D 0;						\
> +	*(u64 *)(r10 - 8) =3D r1;				\
> +	w0 =3D 0;						\
> +	w1 =3D 1;						\
> +	.8byte %[cmpxchg32];				\
> +	r2 =3D r0;					\
> +	.rept 32759;					\
> +	r1 =3D 0;						\
> +	.endr;						\
> +	if r7 !=3D r6 goto l0_%=3D;				\
> +	r0 =3D r2;					\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32),
> +	  __imm_insn(cmpxchg32,
> +		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8))
> +	: __clobber_all);
> +}

[Severity: Medium]
Does zext_cmpxchg32_jump_out_of_range() fail while patching w0 =3D 0 with
rnd_hi32_patch instead of reaching cmpxchg32 to test zext_patch?

test_loader sets BPF_F_TEST_RND_HI32 by default via testing_prog_flags().
Because the 32-bit BPF_CMPXCHG only reads the low 32 bits of r0 and r1, the
upper 32 bits of w0 =3D 0 (insn 8) and w1 =3D 1 (insn 9) are dead
(zext_dst =3D=3D false).  When bpf_opt_subreg_zext_lo32_rnd_hi32() iterates
forward through the program, it visits w0 =3D 0 first and inserts
rnd_hi32_patch there, which fails with "insn 8 cannot be patched due to
16-bit range" and aborts before reaching cmpxchg32 at insn 10.  Because
__msg("cannot be patched due to 16-bit range") omits the instruction index,
the test passes without exercising the zext_patch insertion path.

Using 64-bit moves (r0 =3D 0 and r1 =3D 1) and matching "insn 10 cannot be
patched due to 16-bit range" would ensure the failure happens on the
zext_patch insertion after cmpxchg32.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795625597.gi=
t.luis.gerhorst@fau.de?part=3D2
