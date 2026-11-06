Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938092;
	b=pFneSKOu6oARj3GM8Yd8FGuVXO3UnLv4iRapwDOHg2B57UyIZbbAbz8ciqP8G/oGlO7c
	 mmwaeaNYT7tlN3vF6hY8ilB9WR/pOTR8kFMHOwLj62+vLvCw5wTzv4on4up4iU4RsJyWC
	 Di5uUhbixHXFdf6FrSrMsom28jAeq62jtZ0bYVfE+xngidIzdKx3e95KrPyCHgJA7GwCq
	 M9MCbnTxOWc2v0urthZ1IwHIb9DLCEx39PfD2cPNyKWbgE1ad33kuxHNfKN/55Obm4SUF
	 KLRYZuDdwczKxToCd4JhVYh5eBsrnsCH6HXpCLIzghrTk8wP62/9kh9HdzzfeQBedNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i9X7dZWJFWaa7U80xbI3mzrnR03g0KslzTCfplsFySY=;
	b=BEWZppLQZa04ZDvx4dAt0tXhEm+aIHtD5iytCzyZEnZ3wPAGetqM0adhGcHR5hyhtK+J
	 2jXa5OCd4Rb9S17qgsoLy1r0ddYJ+MxglAxJoVZUBqeEjb96q0z2DSs3xLIOueWJbSnHp
	 DA5lPXYn1tIq5T1jJ4Fkmy03MysP6U2vLP3bpuvIlwW0rkNADJtN+40MOI7I52HufauNH
	 ICgOORBW0a4Kx7e2UMD6iBdsZA+jC0PFnmiiiFfSwfOnp3E0zU3SKsivJJfP9c766FuLq
	 COgys8g/6qsoBeFi02gyASFpcDMKmR6vyVG0FmZQC21qGt5bQoD/0Z/AbE2xoHNm2aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZqJEQgx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901E606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZqJEQgx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E61F0089F;
	Fri,  6 Nov 2026 04:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938091;
	bh=i9X7dZWJFWaa7U80xbI3mzrnR03g0KslzTCfplsFySY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GZqJEQgxh1oZKDFzJQr64kfVmwkgjVq3/vtwLIa+tjN4rj9jSOsh/Kmm9BGKE93OZ
	 gcTugIFf680nmMSVBim/DqYKfSfGtrfto24IfNMhNYwPzAae/RwZwenj9L7SlFXfgs
	 5LIo/YfOwOOKgQLddkK8Qu8C3rMt8laZc1WT1651mLC1utGG/BulaEnMKGY8+3rzsu
	 t2PyvZyQ9hfARXAJVIYT8dtNWfEGtlnrfD/hANXAS/VJotTuECUcyDZzH5mG8yAaXS
	 I4EBUHZET/nThxZxFrKa2EHn3sD1+nLWRo4mGYFlOpuw2kD9d/0xuZ4b/zG2jb8/0R
	 f/nbVRoBXF9YQ==
Message-ID: <sashiko-outbox-200685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 10/45] bpf: Find the registers and stack
 slots that later checks depend on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-11-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:08:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: false R0 dependency for BPF_END | BPF_TO_BE in flow_compute=
_need_const()
--

commit 6774fce732def6414deae7e4151e138be57cfe46
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Find the registers and stack slots that later checks depend on

This commit adds backward dataflow analysis in kernel/bpf/flow.c to identify
registers and stack slots that subsequent verifier checks depend on, used b=
oth
to prevent joining states with differing constants and to determine whether
loop-modified values are needed after a counted loop.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index 837d5054c2a3d..1eecd9ee5123b 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> @@ -821,3 +889,259 @@ int bpf_flow_compute_kinds(struct bpf_verifier_env =
*env)
>  	kvfree(ret);
>  	return err;
>  }
> +

[ ... ]

> +static int flow_compute_need_const(struct bpf_verifier_env *env, struct =
flow_need **pneed,
> +				   enum flow_need_kind kind)
> +{

[ ... ]

> +			} else if ((class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) &&
> +				   (out.regs & BIT(insn->dst_reg))) {
> +				op =3D BPF_OP(insn->code);
> +				reg =3D BPF_SRC(insn->code) =3D=3D BPF_X;
> +				/* the result is known when what it is made of is */
> +				keep =3D op !=3D BPF_MOV;
> +				from_src =3D reg;
> +				if (jump)
> +					from_src =3D flow_is_copy(insn);
> +				if (kind =3D=3D FLOW_NEED_JUMP)
> +					keep =3D flow_is_shift(insn) && !reg;
> +				if (kind =3D=3D FLOW_NEED_BASE) {
> +					keep =3D !reg && (op =3D=3D BPF_ADD || op =3D=3D BPF_SUB);
> +					from_src =3D reg && op =3D=3D BPF_MOV;
> +				}
> +				if (!keep)
> +					in.regs &=3D ~BIT(insn->dst_reg);
> +				if (from_src)
> +					in.regs |=3D BIT(insn->src_reg);

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [1], in flow_compute_need_const()
in kernel/bpf/flow.c, does a BPF_ALU | BPF_END | BPF_TO_BE instruction fals=
ely
mark BPF_REG_0 as needed in in.regs?

Because BPF_TO_BE (0x08) shares the same bit value as BPF_X (0x08) in
BPF_SRC(insn->code), reg evaluates to true on a big-endian byte-swap
instruction even though BPF_END is a unary in-place operation on dst_reg wi=
th
insn->src_reg =3D=3D BPF_REG_0.

For FLOW_NEED_ARG, FLOW_NEED_STACK_OFF, FLOW_NEED_PTR_OFF, and
FLOW_NEED_VALUE_OFF, from_src remains equal to reg, so:

	if (from_src)
		in.regs |=3D BIT(insn->src_reg);

sets BIT(BPF_REG_0) whenever the byte-swapped dst_reg is needed downstream.
Wouldn't this prevent joining states where R0 holds different constants pri=
or
to a byte-swap and cause bpf_flow_is_needed() to report R0 as needed at loop
headers?

Should reg exclude op =3D=3D BPF_END (for example, reg =3D BPF_SRC(insn->co=
de) =3D=3D
BPF_X && op !=3D BPF_END)?

[1] https://lore.kernel.org/r/506d7ef52474ac7df140bd5f84ac7b7bcf359769a1a46=
b05aba0751fcdf065af@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D10
