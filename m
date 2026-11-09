Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208108;
	b=QGPqM6MdpeBTwswtI0PpqFheQ86mbqp7R97ZaCeX4X5SgJs06TZP1q4Gfxt0RoIm5Nfc
	 p5gwunzIzYxTQL25103VCxv+eJX0lLAXR1QKZQgPw/+6zfPyh1SoFU5feCkkoviZ5fKbR
	 9pOONGyF5c/kXA5b0Rh6LU1bH+TzkLR8y9Uti3lhD8Q/g31zMD60v4GCCfw0qJT3rcOsr
	 kqgHHKDfJTfzRsMmhYc8DLgFYnmkBeT3aQp75Fs6Pe79q1weoQ4tgge8dz6sluxrjvIh3
	 O/hQ16kyHzEQLv2Srp8wa7uIPsBWLgVsU0IUcAJtrlQwLvlN5FFuUX+Ufzjz69u5SpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PUJIHGy6vNrPOSKoKL8LnIUQhbXPd1YZ+0eesCmWEM8=;
	b=EKCRwlnOgjdiSG5hYfiDtUOCr1+UtratNhBCltzqswVtYDdVZdimHxTc9pOslagW3qWI
	 WYcaKqcWBEtfEoBZclSKGrLtY4Y4kP9TLMWPcwQlG8v6Afoa1IwCIQSXXkIeVV5nsJZlU
	 ZXhzmadw6G3KYzcdEN1Lldn1caFDSvxIeL7URK3hwcYwbd/5bc6wtT27IXdWbYVEisyyp
	 yBLb2L1hLJfGOrhBV4/Gj9cbYzgk2x9WK6iOO2DF+KWsQ6nvIogtTWd5MP+kPByNzJXBy
	 xRCjHvksB/GEyspSVpNJz76GMq2QPhqDEYZ7DPKsY0gQomx70yGejHbFsM/ungPz54A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnAs+Inv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812F606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnAs+Inv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7076D1F0089F;
	Mon,  9 Nov 2026 07:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794208107;
	bh=PUJIHGy6vNrPOSKoKL8LnIUQhbXPd1YZ+0eesCmWEM8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CnAs+Inv9UPqRLHYZJWEXtCg/LAUe92N14BlimGmh36PWzx98nacXupHQmf5oaitN
	 0oHr62rQ+ui9OgDYYRDJsrC+79gHuuKl2ZIydYN0JkioZ4VoXKk2smZArYu8mYH5Ts
	 AqEI9q0gSu9w2wMvg7OqBHdZvrcZlieSfuP2YkNUSMTTxPa5MGGNrlCMfe9MSUkNDh
	 WLBvW6zS9XzDO+YzbHnYtRpzYwK0WQsN16gFWKy49jrpT5aEAv366J64EZQ9OeRjEQ
	 oL9vEHHmVyavqSGXGhOhefJUIrbByCpPB3N4Ama++HCO08IyqgLoaJcdohXNcwNxbj
	 QEMYseFF2ZKAg==
Message-ID: <sashiko-outbox-204528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 21/26] bpf: Stop assigning ids to scalars
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109064715.2382452-22-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
 <20261109064715.2382452-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:08:27 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: missing arena pointer scalar check in
  adjust_reg_min_max_vals() [1]
--

commit 3c630c864568ebd00223455e2f9580fa8ae14a89
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Stop assigning ids to scalars

This commit stops assigning and maintaining IDs and constant deltas on
scalar registers and stack slots in the BPF verifier, as scalar evolution
and flow joining now handle linked-register refinement and copy detection.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 103e83cd23ef0..3d1be990123ba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18226,10 +18150,8 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
>  	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
>  	struct bpf_reg_state *regs =3D state->regs, *dst_reg, *src_reg;
>  	struct bpf_reg_state *ptr_reg =3D NULL, off_reg =3D {0};
> -	bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);
>  	struct bpf_insn_aux_data *aux =3D cur_aux(env);
>  	u8 opcode =3D BPF_OP(insn->code);
> -	int err;
> =20
>  	dst_reg =3D &regs[insn->dst_reg];
>  	if (BPF_SRC(insn->code) =3D=3D BPF_X)

[Severity: Critical]
This problem wasn't introduced by this patch, but can the PTR_TO_ARENA
fast-path in adjust_reg_min_max_vals() allow pointer-to-pointer arithmetic
and leak kernel addresses [1]?

kernel/bpf/verifier.c:adjust_reg_min_max_vals() {
	...
	/* Case where at least one operand is an arena. */
	if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->type =3D=3D =
PTR_TO_ARENA)) {
		...
		if (dst_reg->type !=3D PTR_TO_ARENA)
			*dst_reg =3D *src_reg;
		...
		/* Any arithmetic operations are allowed on arena pointers */
		return 0;
	}
}

When one operand is PTR_TO_ARENA and the other is a kernel pointer such as
PTR_TO_MAP_VALUE, this block overwrites dst_reg's state with the
PTR_TO_ARENA state and returns 0 before reaching the pointer-to-pointer
checks below.  A program can then use addr_space_cast on the resulting
PTR_TO_ARENA register to turn the truncated 32-bit kernel pointer value
into a scalar, bypassing !env->allow_ptr_leaks.

[1] https://sashiko.dev/#/bug/linux-d1a28821-a6c7-4535-946a-d82f1ba22e63

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109064715.2382=
452-1-alexei.starovoitov@gmail.com?part=3D21
