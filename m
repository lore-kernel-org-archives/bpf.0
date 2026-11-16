Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810006;
	b=AXJ1piWwPk6jTH/o0Zp3FmEmWFa15k6HQUQzrmWCt3VQquZ5yylPfnYbV2e9tuFizUGu
	 3abZb1beZm6MzFhrcs3OdGe8GfzY7dvVv96kSoAigzeslgDC0n1M/VCeLi+jN8xmNxiAR
	 hfA8Wu1TX3phW9msoDBK+qJovsiEygzCSCd4FtdaNroiPnYCaLzLQZOQplOGcHOu2Zpeu
	 sL8yUTVh0CTVFqwu7pbUIYPkgsXzP8d12dbfIiJl0sior1WYBPsRHI7Cdm8nZGgFOtJ1e
	 uMEO5V3u2rbKCNjAKrujgk2gSIgUyjPG+siUCHJzI7TxFSLsJXj8ZSVEAmDULhkH+jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AFezbAGYbwpztDIlTc28Vrh8mASElApTiqeOHUMwVug=;
	b=2lwxfSyI2PyFB36tmChL6xo7bi+f0sLANs3C2hF1Hm89rcI9hinzT25p4z1/nU39mkuM
	 quB4Lc3qCrRn9kc7KVGn80R1hTi7p15pxXdMTyjcmUFFsoCw6CM5RxXHO4wzMAwseGGqD
	 AODtTHHIvT2TqnUJiIURo1FyD5Ey7ciFXDHwKZVIsAK0yWlS3G1V4SU0gWTWxqrXY9mpF
	 8Trpi4xi2BxbgfKj02gcancodE0iLQtmVC8K6Y5DVeUrZuMIYV3Rg2PN30rLcHaWQjx4k
	 cEGKALGhSDYYCTWl/7HlsqTz0YaUV/L3MHkzqhahBRX3ZUNGL7Z6dbwkpXzgxmv6Q7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwOIYLSo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB28606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwOIYLSo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2375B1F000C4;
	Mon, 16 Nov 2026 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810006;
	bh=AFezbAGYbwpztDIlTc28Vrh8mASElApTiqeOHUMwVug=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GwOIYLSobwGR+e7ICxfDxIgDOoCCqzZBM6YTQAd6hazYiiDN+jAuM12nuUqwuUHW/
	 87YQqfRPXCzD5yQzrfaFtVW0XjT6ZLQr6YqyTWur+tS2tLY0CJfo3IhaWjqeVGbq6I
	 PIGfFfIXf7gRmX3ctWII6L5sedWpTNnHtBsb8d941QNqwv+18SggI6KsZsV2NUseXU
	 8mt0Fh4vdJp6koey0L2I9XUTUN/OkA67DOSiB5vbvfpUmqCeLRwtqiNWGqQPjDk8gC
	 VzwJymQgfBxzxxq3piJ1ZlDvueMKzCVCDTQwyh6OQe+mIGOY5c8DaFJaK2T+Q+O9Uo
	 SDNtFwIMOKWow==
Message-ID: <sashiko-outbox-216265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/21] libbpf: Size the tables of the loader
 program from the object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-12-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-12-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:20:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Medium] libbpf: skeleton prog_fd corruption in
  bpf_object__gen_loader() [1]
- [Medium] libbpf: unhandled copy error in bpf_gen__map_update_elem()
  [2]
--

commit 90aed32e47532de6cf9729d6808a9ae7a545ec5c
Author: Alexei Starovoitov <ast@kernel.org>

libbpf: Size the tables of the loader program from the object

This commit sizes the loader program's fd_array and prog_fds tables from
the BPF object's counts instead of fixed maximum constants, moves prog_fds
from the loader stack into the data blob, and handles >16-bit offsets via
BPF_JMP32_A and a temporary context register.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 555d4757a898c..27b4bc9e55acd 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
[ ... ]
> @@ -401,12 +386,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_pro=
gs, int nr_maps)
>  	for (i =3D 0; i < gen->nr_func_ptr_maps; i++)
>  		emit_sys_close_blob(gen, blob_fd_array_off(gen, gen->nr_obj_maps + i));
>  	for (i =3D 0; i < gen->nr_progs; i++)
> -		move_stack2ctx(gen,
> -			       sizeof(struct bpf_loader_ctx) +
> -			       sizeof(struct bpf_map_desc) * gen->nr_maps +
> -			       sizeof(struct bpf_prog_desc) * i +
> -			       offsetof(struct bpf_prog_desc, prog_fd), 4,
> -			       stack_off(prog_fd[i]));
> +		move_blob2ctx(gen,
> +			      sizeof(struct bpf_loader_ctx) +
> +			      sizeof(struct bpf_map_desc) * gen->nr_maps +
> +			      sizeof(struct bpf_prog_desc) * i +
> +			      offsetof(struct bpf_prog_desc, prog_fd), 4,
> +			      blob_prog_fd_off(gen, i));

[Severity: Medium]
This problem wasn't introduced by this patch, but can a non-autoloaded
program (such as one marked with SEC("?...")) shift the prog_fd slots in
the loader context [1]?

bpf_object__load_progs() skips programs with !prog->autoload without
calling bpf_gen__prog_load(), so gen->nr_progs only counts loaded programs
while the generated light skeleton includes descriptors for all main
programs.  Because bpf_gen__finish() only rejects nr_progs < gen->nr_progs
and then copies gen->nr_progs file descriptors sequentially starting at
index 0, any skipped program shifts subsequent prog_fd values into the
wrong skeleton slots.

[ ... ]

> @@ -1159,10 +1135,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>  static void emit_copy_initial_value(struct bpf_gen *gen, int map_idx, in=
t value,
>  				    __u32 value_size, int nr_more_insns)
>  {
> -	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
> -			      sizeof(struct bpf_loader_ctx) +
> -			      sizeof(struct bpf_map_desc) * map_idx +
> -			      offsetof(struct bpf_map_desc, initial_value)));
> +	int off =3D sizeof(struct bpf_loader_ctx) + sizeof(struct bpf_map_desc)=
 * map_idx +
> +		  offsetof(struct bpf_map_desc, initial_value);
> +	int ctx =3D emit_ctx_reg(gen, BPF_REG_3, &off);
> +
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, ctx, off));
>  	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8 + nr_more_insns));
>  	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
>  					 0, 0, 0, value));

[Severity: Medium]
This problem wasn't introduced by this patch, but should
emit_copy_initial_value() check the return value of BPF_FUNC_copy_from_user
and BPF_FUNC_probe_read_kernel [2]?

tools/lib/bpf/gen_loader.c:emit_copy_initial_value() {
	...
	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
}

If copying initial_value fails at runtime, the error in BPF_REG_0 is
ignored and the loader proceeds to update or populate the map with stale
or uninitialized data from the value blob.

[1] https://sashiko.dev/#/bug/linux-2d41a5d8-8f8a-4d8a-830c-c6296f3d3c04
[2] https://sashiko.dev/#/bug/linux-fccc70c7-8ac5-4839-9aed-2cbf7835e292

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D11
