Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC637AA72
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748222; cv=none; b=lgkPdsOehWyWquMpPLcaE7ZIQlIe0DzeVVueHmdt8LZ2/Slhn4FR5n8OTLeiy3VbXVhMNbF0HJhpY7+UDYEC6BFW7mJQV2BVe8n1TFCbQj/4esyZm2P4uM1mDNB3640SRDGzGO/mZDkwptQF53hKpqGyXAnF6pJZzeP5+TpBSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748222; c=relaxed/simple;
	bh=MTEOzBw8NclU45ZupfLIVi3/KKbScRS8NxoqBQmzOUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eyqSexwgnB3VXvOfD8x/F/36Mz0mcD3tsisyMPGxaDS2AzHZmSRymlJ0EkPiZ+gRyj+hnGWUPcH/CssD8w5QlwwB0CU284e5I+cHUauDGEXALCpuz+hJYgJPY6ki2VHhLO11KK45LpvjuqZqZ4Q1PI9eQ/ZABG/8sM2ESViCVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eou+7ZlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eou+7ZlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8D01F000E9;
	Mon, 29 Jun 2026 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748221;
	bh=yoTKv2YgcOtGOZk25YPrZVcnavuI4T25FKeIg4n9oNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eou+7ZlHoFFfbljBPjuFMJOoiFsWPOIFFHS0aQ8QNanmjdbJxroopzbPEmxA3QG2Y
	 0Z4Et/PS4dS+TIwFzY0lYWyckSbHhrzdoVhoa1uKP49BX4nPrh8by3oy4nT9GpfryG
	 lRMGX49As+ay9XQn9C4h3/h4tG89q4Y61AcBDYjGAa5HRkS1Rqdg6S9HFLat3zlVm+
	 vebN2b9R+cO3mN3vY4SvfazS/X82NbWORDr60Ca6QP6u3QQXz44f6s+3rpXAt5BmY5
	 ZpuS9fFLEER4+mNSifGCu1DSDHeCECx9yQlDdbi5q52e+Py8V4eAB3WaLagzw5wQGf
	 JQpMXcOf+/iJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 2/9] bpf: Introduce global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629152406.52582-3-leon.hwang@linux.dev>
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:50:20 +0000
Message-Id: <20260629155020.AF8D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Interpreter fallback vulnerability due to missing BPF_MOV64_PERCPU=
_REG support
--

commit a68c25810c5f3ada3bbae32b3967070021ca8848
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Introduce global percpu data

This commit introduces global percpu data support for BPF, allowing
definition of global percpu variables similar to DEFINE_PER_CPU(). This
enables tools to simplify their BPF code by avoiding percpu_array maps
and manual CPU ID lookups.

Links:
[1] https://github.com/anakryiko/retsnoop
[2] https://github.com/bpfsnoop/bpfsnoop

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 3cf2cc6e3ab66..4f84d087ca69e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -1819,6 +1819,38 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>  			goto next_insn;
>  		}
> =20
> +		if (env->prog->jit_requested &&
> +		    bpf_jit_supports_percpu_insn() &&
> +		    insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +		    (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +		     insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE)) {
> +			struct bpf_map *map;
> +
> +			aux =3D &env->insn_aux_data[i + delta];
> +			map =3D env->used_maps[aux->map_index];
> +			if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +				goto next_insn;
> +
> +			/*
> +			 * Reuse the original ld_imm64 insn, and add one
> +			 * mov64_percpu_reg insn.
> +			 */
> +
> +			insn_buf[0] =3D insn[1];
> +			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);

[Severity: High]
This is a pre-existing issue, but does the BPF interpreter properly handle
BPF_MOV64_PERCPU_REG?

The verifier correctly checks bpf_jit_supports_percpu_insn() before inserti=
ng
this instruction. However, if JIT compilation fails later (e.g., due to mem=
ory
limits) and the system falls back to the interpreter, what happens to this
instruction?

Looking at ___bpf_prog_run() in kernel/bpf/core.c:

    ALU64_MOV_X:
        switch (OFF) {
        case 0:
            DST =3D SRC;
            break;

The interpreter appears to silently ignore OFF =3D=3D BPF_ADDR_PERCPU, esse=
ntially
treating it as a no-op or standard move.

Would this leak the raw __percpu pointer (which is often a small integer
offset on architectures like x86) into subsequent memory access instruction=
s?
While this patch didn't introduce the interpreter fallback behavior, it see=
ms
to expand the surface area by allowing direct read/write accesses to arbitr=
ary
percpu arrays. Could this lead to out-of-bounds memory accesses if JIT fail=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629152406.5258=
2-1-leon.hwang@linux.dev?part=3D2
