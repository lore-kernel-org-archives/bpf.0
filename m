Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626990;
	b=tQowuSazJ27UMguH3uPOT2zVjw8MxL6aHWhVZkipZDNurljbxtc6FV3pQrD1ddp8YZTv
	 EWZ+G5QH1jlBe/P4ljMuL6IKaAs8ODGcl+zq0nmjNS7tBXJcB/d8DrU5L4W7wkX15DGNe
	 QcUbbuaGZ9ZLoobkda0lMw1mTIldEX3u0vPnMUyZyOuQHvm9vllXUF2JW3Gxlqehm6hV1
	 VlCXO92sB6h3UiFhd1nzEvdixO1N3BXL/HyyrJ+bQ8cWtvAHu84tlL+xwUpxhOP/P1aVT
	 pKscnTBq6mg8AMuGSc/y+4BNBzJx/T9Cgdt5DmEm3APyEve2uE9OPKl8TQ22XMbUPtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LOqcNtSLKgFntVFqe4x7jk/UfjKIsLCAgG0vuuYjBjg=;
	b=JH9yi4pR9QLz+PphFSVeasgNUt+yIujlQBc1Msj3oUaGO5WlXniHBYxEZkvIgTxaibz6
	 AfnWmzzkCiNEAXhq5RfrA1rb113UczLLmD8RBsarS7wuzf9K2CJUCUbp5P1YU4Ye4jwxU
	 gwYpB66hUl8Errq72qn/EhcX7z4m4EXfnKUMfRUj8dzN7V/EB+oRcymhwp5FVfln+BR1g
	 1R7IHeJBSCuTWZPZjCHMew65mcElmQkcSYvvgI2ywnlOQb7wO4YNEB7HKYfcI2U54kr7X
	 FdhrERdEpMbbwGVEP1Hbfy+S+Y7qSgbVgVTWSlCnu9gi1WX517Iq6K0SblFCRJdC4oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqLpfd7A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D00606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqLpfd7A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9704F1F000CA;
	Wed, 25 Nov 2026 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626989;
	bh=LOqcNtSLKgFntVFqe4x7jk/UfjKIsLCAgG0vuuYjBjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqLpfd7A8IGq/nCegVH3g8gm3rYSp7CuG/4Oul0gGOzslAhClZHBaYH2FBayggKTp
	 Yjy8A/idEzgJkL8AOi9wUz0GXCmvuhxTccDU9m43heaKiV0uSXlL2qqb5oS7CaqAui
	 4xLApof4+5uF5zgkYN3UhPWYiXvzjCpAbJrjO0uFLoLlz1Aj6JAn+5Ph8ZNwuUFNl7
	 V7d3tR0XY8oEEr/zTwOXCiin0b3aQRAdYEI7yGHQn7GXI1XIPgzVBJwnHNzietgCOJ
	 gZ1zGyGoinMHaZUahMxiEDbe51zW7C8TaHYnI/e3SmgAq+oNTlxYyPp6lr/5OA86Gm
	 oirmVUNM/jEXQ==
Message-ID: <sashiko-outbox-233822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 2/5] libbpf: Support CO-RE relocation of
 tracing program arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125165845.45806-3-almagui@kernel.org>
References: <20261125165845.45806-1-almagui@kernel.org>
 <20261125165845.45806-3-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:16:29 +0000
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
- [Medium] libbpf: missing 8-byte pointer size on split BTF in
  bpf_prog_func_args_btf()
--

commit 48b370da5eb67f95ec57705bfbaef14039ba87cd
Author: Alan Maguire <almagui@kernel.org>

libbpf: Support CO-RE relocation of tracing program arguments

This commit adds CO-RE relocation support for tracing and LSM program
arguments described through a struct bpf_func_args___<flavor> context type
by synthesizing a matching candidate struct in a split BTF on top of the
attach target's BTF.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1efc0dd37b2e6..b452bda266da6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -11641,6 +11768,210 @@ static int libbpf_find_attach_btf_id(struct bpf=
_program *prog, const char *attac
>  	return 0;
>  }
> =20
[ ... ]
> +/*
> + * Add a member for an argument or the return value to the struct being =
built.
> + * Each takes up a whole number of u64 slots in the context, as laid out=
 by
> + * btf_ctx_arg_idx() in the kernel.
> + */
> +static int func_args_add(struct btf *btf, const struct btf *targ_btf,
> +			 const char *name, __u32 type_id, __u32 *off)
> +{
> +	const struct btf_type *t;
> +	__u32 pad =3D 0;
> +	__s64 sz;
> +	int err;
> +
> +	t =3D skip_mods_and_typedefs(targ_btf, type_id, NULL);
> +	sz =3D t && btf_is_ptr(t) ? 8 : btf__resolve_size(targ_btf, type_id);
[ ... ]
> +static int bpf_prog_func_args_btf(const struct bpf_program *prog, const =
char *name,
> +				  struct btf **res)
> +{
[ ... ]
> +	btf =3D btf__new_empty_split(targ_btf);
> +	if (!btf)
> +		return -errno;

[Severity: Medium]
Should bpf_prog_func_args_btf() call btf__set_pointer_size(btf, 8) on the
split BTF?

btf__new_empty_split() initializes btf->ptr_sz to sizeof(void *), which is
4 on 32-bit hosts.  While func_args_add() hardcodes pointer sizes to 8 when
laying out context slots, bpf_core_calc_field_relo() later calls
btf__resolve_size() on the candidate split BTF and resolves BTF_KIND_PTR
fields to 4 bytes.  That causes bpf_core_patch_insn() to downsize 8-byte
BPF_DW context pointer loads to 4-byte BPF_W loads, which the kernel
verifier rejects in btf_ctx_access() because pointer loads from the u64
context array must be 8 bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125165845.4580=
6-1-almagui@kernel.org?part=3D2
