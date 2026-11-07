Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024702;
	b=vCzBE8jyBMbPEzmFI82ra6xEB9Troc1ic2kSXbIptunXQwhsLS+BAU3nA56FL92Bc0Cn
	 Dfs/BvHFyCmsYtLXx8ciufO03JYwYDy8tcWaqGMbj6H3RYNqGI71+jPVmsdglohGDmTb8
	 s7c6VBVnvcFTXG6/Ga5wJu2UNcjxoBspzvPwBpaFTmERt2KaX5r0zg1CW9opzd5GXmgRt
	 2s24Cq5OoaeNtro+yRWuRZ1d0ZT3FGDHaRQlcipX7TWVtSeSHtnizSkuo9604t4Aoq00H
	 xYHMm6g0FyscIZOTjpjj5jLPHUNXDozHxLcclt9u0cGi/zo6/ygy7FVJ7bXzdvKLxog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XSj9E26EsDE7L9aQoiTzqrC+EcCczS7MuvGpx1KiH70=;
	b=zR/fnEJE5CSr1lnEmH1EaBT6r/bba+4TB05WLnJvAn9QXritvqopuenRZdx0M0FRNLlA
	 QN0cD97l8ijMhXQd4hylPm6jilRLaSxNisENQGfAUT4WkRme+0yw62CzHvmvsHsjSAq+z
	 6SbPFe9tub2I8qQPZ7eoUvO5aBcBG5PnwIkCUeuiKkXWPZhRLhBCwm90AoxAceQuV3/Q7
	 YVNYRa6Gq/rBJueUI1kL8ZBjERqqPGaZalU8l0pKOTUtnmB1qK5uRklbrQHhe6b4wLDQi
	 oVNIZUhgPCt+gvh6pNydNGc5itLgcsvU7qk9+eMwXVmPKqU14L4mU5Js+jGoB3j7M8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RpO+4Q0v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F5606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RpO+4Q0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F631F0089F;
	Sat,  7 Nov 2026 04:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024702;
	bh=XSj9E26EsDE7L9aQoiTzqrC+EcCczS7MuvGpx1KiH70=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RpO+4Q0vMa+Y4txONDXkz+ENjCsHM00k9B03Nt23VZfHPDUGuHn4LTfSfKsKQMOCV
	 K3drucZvTrl3i0+uWNjfN+ri35KIFN8yWNAn3hwk+iACVyFdUt0h315fwwjHk9DhF9
	 6fdDKsGPyp4YdxF2M6p8C7kgFfHTq7nNnDqiEPXLgmlxxv7mBzLgjVzjK9A6WDbSXh
	 snfGUQ4LCIylCHUxAKySsZpEzmDWeT5dLFfPreHwHc3TYuK4Sfu8eWyBq0sT6D4iXk
	 VRmosTaHvguCUC6diRtJ0etMq/eBHp8lPVkN1hXuZRGMEzZBU3dLoWqFQYwXBR6Fhp
	 /y6fjibbPL5uQ==
Message-ID: <sashiko-outbox-202559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 09/46] bpf: Find the registers that hold a
 number or a pointer to arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-10-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:11:41 +0000
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
- [Medium] bpf: missing propagation of loads_pkt_end to callers in
  bpf_flow_compute_kinds()
--

commit 56842cec67f7566ca6cea05c44634e53a6e064fc
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Find the registers that hold a number or a pointer to arena

This commit adds bpf_flow_compute_kinds() to track which registers and stack
slots hold plain scalars, map value pointers, or the context before each
instruction, and records subprograms that load the packet end pointer in
sub->loads_pkt_end.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index 0f5acdf1cb946..f039cc9498542 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c
> @@ -514,3 +514,317 @@ int bpf_flow_place_guards(struct bpf_verifier_env *=
env)

[ ... ]

> +/* What @insn loads through the register @base */
> +static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, con=
st struct flow_kinds *k,
> +				       const struct bpf_insn *insn, u8 base)
> +{
> +	struct bpf_insn_access_aux info =3D { .reg_type =3D SCALAR_VALUE };
> +	int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +	bool tstamp =3D env->prog->tstamp_type_access, valid;
> +
> +	/* a number that is good for a load is an address in arena */
> +	if (test_bit(base, k->is[FLOW_IS_VALUE]))
> +		return FLOW_IS_PLAIN;
> +	if (size =3D=3D BPF_REG_SIZE && !test_bit(base, k->is[FLOW_IS_CTX]))
> +		return FLOW_IS_OTHER;
> +	valid =3D env->ops->is_valid_access &&
> +		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
> +	/* it notes what the prog reads, and this is a question */
> +	env->prog->tstamp_type_access =3D tstamp;
> +	if (valid && info.reg_type =3D=3D PTR_TO_PACKET_END)
> +		bpf_find_containing_subprog(env, insn - env->prog->insnsi)->loads_pkt_=
end =3D true;

[ ... ]

> +	} else if (class =3D=3D BPF_LD || (class =3D=3D BPF_JMP && op =3D=3D BP=
F_CALL)) {
> +		s =3D bpf_pseudo_call(insn) ? bpf_find_subprog(env, idx + insn->imm + =
1) : -1;
> +		if (s >=3D 0 && !bpf_subprog_is_global(env, s)) {
> +			lost =3D flow_kinds_enter(&kinds[sub[s].start], k);
> +			regs =3D ret[s];
> +		} else if (bpf_is_callx(insn)) {
> +			regs =3D 0;
> +		}

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v3 [1], does loads_pkt_end need to
be propagated from a static callee to its caller?

flow_loaded_kind() sets loads_pkt_end only on the subprog that directly
contains the ctx->data_end load, and neither flow_kinds_step() nor
merge_callee_effects() passes it up the call graph.  In commit "bpf: Verify
static subprogs on their own", func_is_on_its_own() and arg_needs_caller()
check sub->loads_pkt_end on the immediate callee to decide whether a static
subprog that receives a packet pointer must be verified in its caller's
frames.

If a caller passes ctx and a packet pointer to a static subprog that
delegates the ctx->data_end load and bounds check to a nested static
subprog, the outer subprog has loads_pkt_end =3D=3D false and is verified
without its caller's frame.  find_good_pkt_pointers() in the inner subprog
then never widens the packet pointer in the outer caller's frame, causing
valid packet accesses after the call to be rejected.

[1] https://lore.kernel.org/r/c5cd652a5014ef6157278403838481eb2f4a8c5add5e6=
de5a2837b3121f30074@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D9
