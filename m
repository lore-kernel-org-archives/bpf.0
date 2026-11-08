Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167106;
	b=lQ+AzNBY4ty6xCBjsNzuMgfyRHCnB28QGheu3mCnsmSH3vne6Y3GC55Mv9OlI5rpApUk
	 73dQ0t2MHQAWnYlgq8hDCeHdpP0qQGbbhyKlV9hRZY3IOWKEabV5ji4+oO2wmzSVB6J4W
	 UceawZViTCDQyyUFteZN9Q/HxZ9OOWzye1g60xLeLkODHYcUv6S6XqIYo7hh/lZYEKsrL
	 HFN6v6DDdEvI5UN8HaQ+2c3dW9LgzACp8SIe4PqafGPHiJVKhxqlNd0ZHNYtKrjEX0s9V
	 iQdMTAKUAabivj3NVZbKIdAUscOoJRgXFk/k41ivSX9IeHZIMFHCDYbTkTQh0GU1zBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167106;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qjhXFTseJw25hJYdOAUmtw5JT5y74733kdd4/V/AdA4=;
	b=PxO66TccMvUKpJLsGjzZNnJdvZ6BfpJ405DfC3XpTv8Ka2kzkxuFW+Q/4a3lLy8+IrVz
	 HKHwLBGjA+OwkFrRxwFY3oW8jelSzHeo7/h/jilw+duppR0vnsLSO2Dk5KOACTMQlt/Rm
	 HTHa2QbYWHkU++MVVvp7IBib5plOmNDfv8vwIUV8Hybbp+0tznu+sn1XJQo2QIRmKnAdk
	 oOMzaelPhOQanjzemqy+Udnlab6QTAv0ne9hBzCvr0KviZcGhBw/uY5VdIVLQXwUvkS0B
	 NnpcTwcGh9zk62jz5f2t9MiZFgU4PFNK2eVZXzaVloPFeW43u0RbHQHaC1TxCEag7zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FizZeE7k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD83606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FizZeE7k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE471F0089F;
	Sun,  8 Nov 2026 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167105;
	bh=qjhXFTseJw25hJYdOAUmtw5JT5y74733kdd4/V/AdA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FizZeE7kwFDlb5f43OwOSaBNAVlvRRfkqmwxwameevoOGdGyPXK8jcdGaJLMcs2Sg
	 GbJgM5uBcDLgWbzSDJfcmaC21gM35LzbK2vxM2Q+zS0NlN1xSkgrGfkyBAmJAOHifU
	 G1wAZe89ad5v1SBs0e9HHVhrs6B3vvSl+V+MU1pz6ZnpbLIZnQt+IC/IGbKuqIPYhA
	 pYXGDosFVs9CH3FzvDsYjFqONLxdqoBka+bcuWGXknYIua3G3epeqf5/ZRUsPjRbWx
	 9zAd13/oFZsyAnibsbGgyrvRep5CAnZeguExzWzeOnhGQxPhFIMwa9n6nauKTbCMPS
	 rO7Ztlu1gRvRg==
Message-ID: <sashiko-outbox-203993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 24/24] selftests/bpf: Extend the JIT
 instruction tests for arm64 encodings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <f16feeec21ead88b0459d967f976fad4f60b750b.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
 <f16feeec21ead88b0459d967f976fad4f60b750b.1794165614.git.daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:45:04 +0000
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
- [Medium] selftests/bpf: misaligned XDP packet load in test_tail_call()
--

commit 3e5456182ae6e38cbc6f04091b8df4d4e305b794
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Extend the JIT instruction tests for arm64 encodings

This commit extends the BPF JIT instruction selftests with additional test
cases covering compares, bit tests, constant arithmetic, immediates, sign
jumps, arena and PROBE_MEM accesses, and tail calls.

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/t=
esting/selftests/bpf/prog_tests/jit_insns.c
> index 5fd1c856ded72..0aaab23a2eef8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c

[ ... ]

> @@ -3093,6 +3598,94 @@ static void test_helper_calls(void)
>  	close(map_fd);
>  }
> =20
> +/*
> + * A tail call with the index from the packet, which the JIT scales and =
takes
> + * the low 32 bits of: the entries return their index plus one, an empty=
 one
> + * and an index from the array size on TAIL_FALL, the upper 32 bits igno=
red.
> + */
> +#define TAIL_ENTRIES	7
> +#define TAIL_FALL	0xfa11
> +
> +static void test_tail_call(void)
> +{

[ ... ]

> +	LIBBPF_OPTS(bpf_prog_load_opts, lopts,
> +		.log_buf =3D log,
> +		.log_size =3D sizeof(log),
> +	);

[ ... ]

> +	/* The index from the packet, a call which comes back returns TAIL_FALL=
 */
> +	n =3D 0;
> +	insns[n++] =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +	insns[n++] =3D BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct=
 xdp_md, data));
> +	insns[n++] =3D BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct=
 xdp_md, data_end));
> +	insns[n++] =3D BPF_MOV64_REG(BPF_REG_4, BPF_REG_2);
> +	insns[n++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8);
> +	insns[n++] =3D BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 5);
> +	insns[n++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, 0);
> +	insns[n++] =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> +	insns[n++] =3D BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_2, BPF_P=
SEUDO_MAP_FD, 0,
> +				  map_fd);
> +	insns[n++] =3D BPF_RAW_INSN(0, 0, 0, 0, 0);
> +	insns[n++] =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_=
call);
> +	insns[n++] =3D BPF_MOV64_IMM(BPF_REG_0, TAIL_FALL);
> +	insns[n++] =3D BPF_EXIT_INSN();
> +	fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, n, &lopts);
> +	if (!ASSERT_GE(fd, 0, "tail call")) {

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [1], will the verifier reject
this BPF_DW load from the XDP packet pointer on architectures without
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS?

When strict alignment is enabled and lopts does not set
BPF_F_ANY_ALIGNMENT, check_pkt_ptr_alignment() adds NET_IP_ALIGN (2) to
the packet offset and rejects the 8-byte load at offset 0 with -EACCES,
causing the tail_call subtest to fail on strict-alignment targets.

[1] https://lore.kernel.org/r/eadd9b884e7ca42ebd241f55d6bfd3dd1c9628927b142=
5e46db2f7197efaeecc@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794165614.gi=
t.daniel@iogearbox.net?part=3D24
