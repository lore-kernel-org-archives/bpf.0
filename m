Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997183;
	b=Tz958/L0x3yAvPpgSNYIy4WiNYUGwcop857MZVyMvMNRq60mbUYEuG2INsGG9c79ob1r
	 QOzYGY2GXWOhAqKe0V4tR+YgwVVQ7DXfjvf+Q9tsWD6DLYO8OEENiDQuG3xiSxPeKrfHL
	 qCSIIl1yfu2+62LPeUc/H08adiK9Gh5mM2CVMWC2+VehPg5xU3XsHLlvL3Qx2/5heAnIl
	 oqTEssjtMmLoNpPk62Qju3z8zjB7qkU0zLQKIt75aYDbbhnL39ZZ2cfhQ4wasVNuvwzby
	 iJoR0oG+CMudnArtbKmPnxSQZz1KRqyzQANy9d8x+6fCHY3+S09D4q8xKRazGl97fFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jSfjFLoS/AgIEvntlVuKCAJJe1sMNPZnNiqjAgshnHg=;
	b=Udt7+XgDO+EGchPcwb0w7G1lDqBKor2yK2Gaux4f95hoXaqPA9dWAhA75ubsebCG/QzQ
	 8xo69dkFen02EETx1Cfsc+GnXGW6KrjXlNfRTyAO3b+5TEV1BQzR3RjSstHuV2w6OeTM7
	 FkXGtX1R8IFOTMbb6JmVCurzKF1yUu5BADF1V2C5RdWURYLQpMghm19tZ6FGzNxoMSaEM
	 WhYInbRuNIqEvzwV8UzmxewiaJO3o4YGg3Oc82dTKz6UsnTcqcXzh5vWCtxswXmyI+98U
	 A7igd6PW2R0Xzo79Hw6kaUPqkrxMr0Gyi+zeHjCZfRg77FoCgg8o9hCdZtQfqA27Nsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZ1HQcDr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2F606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZ1HQcDr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829941F0089F;
	Fri,  6 Nov 2026 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997182;
	bh=jSfjFLoS/AgIEvntlVuKCAJJe1sMNPZnNiqjAgshnHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZ1HQcDrsw6Sg3Yj/fKX9Ikk9hBQOLSkAeQvHGHsiQwONxLDWCx4T89tIprPv9ySx
	 35UjOqsBl3ow8702fwobmZ674chF7RsOTzo0DwDU4cdiQWPMNWO4V7P+7gKXWRHfjA
	 lcKt5Y4UGt0DVMFtlwRh1zzJAf+V/uaJ/8vkPWje1YLxOkllN7kuH9VytE5PABiNDI
	 SfhWRofMEKOQRfiMqCIXwl4jYsnov9UJH1JGB4pDYOue9jhlIw1qAXWoUnRCSwaiI0
	 jnazrPxHi7g6kK2pDt2do7qnW3kHHaaWVT5d4Lcj7ayDSj1wLol37H//Af4WGTj5Uy
	 /kVI/NVGSU7Og==
Message-ID: <sashiko-outbox-202213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/7] libbpf: Support
 BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106-lskel-struct-ops-v1-3-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
 <20261106-lskel-struct-ops-v1-3-a4486ffc79cb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:02 +0000
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
- [Medium] libbpf: double byte-swap of BPF_F_VTYPE_BTF_OBJ_FD in
  bpf_gen__map_create()
--

commit 504179d2d83634dc1591a224d0263ff3b4a9b9cf
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: Support BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()

This commit adds support for BPF_MAP_TYPE_STRUCT_OPS maps in
bpf_gen__map_create() when generating a BPF light skeleton, including
handling kernel module BTF object FDs.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 09713c39f71ec..6027a2762c352 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -543,6 +543,27 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  				stack_off(inner_map_fd));
>  		close_inner_map_fd =3D true;
>  		break;
> +	case BPF_MAP_TYPE_STRUCT_OPS:
> +		move_blob2blob(gen, attr_field(map_create_attr, value_size), 4,
> +			       value_size);
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, map_attr->btf_vmlinux_value_type_id));
> +		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0));
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, map_create_attr));
> +		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> +				      offsetof(union bpf_attr, btf_vmlinux_value_type_id)));
> +		emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32));
> +		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4));
> +		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> +				      offsetof(union bpf_attr, value_type_btf_obj_fd)));
> +		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
> +				      offsetof(union bpf_attr, map_flags)));
> +		emit(gen, BPF_ALU32_IMM(BPF_OR, BPF_REG_0,
> +					tgt_endian(BPF_F_VTYPE_BTF_OBJ_FD)));
> +		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> +				      offsetof(union bpf_attr, map_flags)));
> +		break;

[Severity: Medium]
Does wrapping BPF_F_VTYPE_BTF_OBJ_FD in tgt_endian() double-swap the
instruction immediate when generating a cross-endian light skeleton?

Unlike data blob fields, emitted BPF instructions are built in host byte
order and later byte-swapped in bpf_gen__finish() via bpf_insn_bswap()
when gen->swapped_endian is set:

tools/lib/bpf/gen_loader.c:bpf_gen__finish() {
	...
		if (gen->swapped_endian) {
			struct bpf_insn *insn =3D (struct bpf_insn *)opts->insns;
			int insn_cnt =3D opts->insns_sz / sizeof(struct bpf_insn);

			for (i =3D 0; i < insn_cnt; i++)
				bpf_insn_bswap(insn++);
		}
	...
}

Pre-swapping the immediate here causes bpf_insn_bswap() to swap insn->imm
back to the wrong byte order, setting 0x00800000 instead of
BPF_F_VTYPE_BTF_OBJ_FD (0x00008000) in attr.map_flags on the target and
causing BPF_MAP_CREATE for kernel module struct_ops maps to fail with
-EINVAL.  Passing BPF_F_VTYPE_BTF_OBJ_FD directly without tgt_endian()
avoids the double swap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lskel-stru=
ct-ops-v1-0-a4486ffc79cb@google.com?part=3D3
