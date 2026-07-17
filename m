Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20684175A6A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269555; cv=none; b=JLkZBguOSpUmE0AVsYwwoM5mJHecUKv9sEcvAvP2UKSDzek1usJEcj1bKWmKG0gTdGkYxLLGMd0zvv1QIXl+jryVwAnUp0CJI/OlODyG4AAHPnG3oPl3173MjEPmcIrlyoOgRlIfzQSNv6jAy6iZO90/aqPk8ZlW6PGKhZ6sNt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269555; c=relaxed/simple;
	bh=JXCK98S5ush9FRO4JXgkY5QcfDVsYcRDHCnJI+hdsFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Ezpy79RxQ/KHlenac80Iz9NuiH8QTpNIyZvM6pbJJ4m3893gycHB3bw2kmLcx0TIRrx8EWU21JdxH/Ih0Klv1bmCLnwEvEfMgjSqmXqblbW7qnAoRUJr61YB00T+VqBEiwQk4eoDaZKeaHCPts3WVtW681Lz0upjrmA+4IRXqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QM13GwnF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QM13GwnF"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a2c90e383so788207b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784269550; x=1784874350; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Li6biZSUmTb6F1p0d3ByCnt/7xGP35I/zF6ghKI8Qag=;
        b=QM13GwnFZ8j1QN8zgyhEJesjunI9gDpmXxDpIddSh9ZMqH0CcFKV/+HooVnGMr1PMU
         vEO9J2pDMXSoTWBVuIYOLFxlrRJ23lN9GQK+6idOr22eKcuKModON2eoVcrizBvHmnGP
         wCmzR3yxjeXmQhEobpRcgZfEyCQi0wORS5rEhJ0YjqtpiVx/MEdBOoJAFm1YkTMZx9vF
         PJUQtS5xoiT8YVJhHFkue7R9irRE6/dIG6bgyYSLKm5QfbPHnFEx7fRE+OIeYGbsjXT0
         0l9FAd8G99ASXM3hfcA4+j78qvilpCgFUBAPGZBhUbm8uNG4Qn1dRhFyDFYv1VB2oqWt
         PFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784269550; x=1784874350;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Li6biZSUmTb6F1p0d3ByCnt/7xGP35I/zF6ghKI8Qag=;
        b=J632FndNa0TPC+WTrQejtFskDXyt1jK1oqwsNRviclAbXpbYJOoGZT4fvGNa9uyqt7
         /bhmEf0PiheQC+0yEmnDY5FxLDgrKZihK2lYu2QLA5kKcua6Is5Rlgp9Tq4Y3OaybaSL
         bjUx0e8uRWrB0F1txAKb67fphBLbVvXoA3uILMY7rZ8VBA+d2AZ0HEBk4ySRPkhujAof
         A3vdXm4m5BS/lEeamTESXDG9oHQIZ2phcV2e8r3GKmyL25gJ8/HwrIxMuYJ/o4trgch4
         V3ZjJcMfrtT+bBfXC84cboibFRRVi9Zwj/7q1Y/B/RNcniAlvK1FRSoTtxHg9dvqyBKV
         IoMA==
X-Forwarded-Encrypted: i=1; AHgh+RoAjjSPOqaq/40siLVRqH9tvBEH9/eEZY6kve50Owla32nYG18DlZesbhIH7OKDknh3r/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRG8SA5HHinYuqqpb+fINJKVnvtqciRDZrTw8f3hOtBJB3w8Ht
	Qp+Q+inlhNxQQBKyRKxCnoglL3c2D7eCOe4Chn44dExLMS7YGpoS9LrggM6Lc/LAWTI=
X-Gm-Gg: AfdE7clYgm+3TUawA7S3ANy1pfXbB1WPxm2J6hxGu4WVJ7Qgc8y9MVT+dKCMCpnbsXg
	sMsDP2DdUrRmkY3n5lHjrADGOVR5b88Wks9JbIdh6lcQV0Mt67rwPhfDzCaBQAUcTwqo37CS0JR
	6r5OLxai/r6VXMpGt+U1ofrzoiazM/vkd33Mksy2Olq+dLCJFQYondrxELPU39e2vEGNYqcaVtU
	NPAvpp45rcxDkuYXNU07j4kXiIlk/hbPNz/h4aeIxzuqB39tgs0O/5nRw+NLEjY/bN84Uo/SVCi
	DIm1shTdpEP0zWnyiLUTBw1TmDg9H44FlZt3HFbz7m68UHMnn0xPHF6HwUo3UXa0mEaEAEijiB4
	iyx6+WCxNBAFY+hDnJ8TgTovfLIiOlIojiFlTHi3OZraaTXYikNK9ja0StFsjycUdqINz7LTO05
	a4js2Cy4IaeuRi59xGbo2dbbamwONqCyk=
X-Received: by 2002:a05:6a00:3e17:b0:848:2f58:e1eb with SMTP id d2e1a72fcca58-84beb57a9bemr5725180b3a.38.1784269550220;
        Thu, 16 Jul 2026 23:25:50 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e9a3sm373999b3a.41.2026.07.16.23.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 23:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 02:25:48 -0400
Message-Id: <DK0MRMWIAE1T.20UJQKK2YN3VY@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v10 2/9] bpf: Introduce global percpu data
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-3-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-3-leon.hwang@linux.dev>

On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
> Introduce global percpu data, inspired by the commit
> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
> definition of global percpu variables in BPF, similar to the
> include/linux/percpu-defs.h::DEFINE_PER_CPU() macro.
>
> For example, in BPF, it is able to define a global percpu variable like:
>
> int data SEC(".percpu");
>
> With this patch, tools like retsnoop [1] and bpfsnoop [2] can simplify
> their BPF code for handling LBRs. The code can be updated from
>
> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs"=
);
>
> to
>
> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".percpu.lbrs")=
;
>
> This eliminates the need to retrieve the CPU ID using the
> bpf_get_smp_processor_id() helper.
>
> Additionally, by reusing global percpu data map, sharing information
> between tail callers and callees or freplace callers and callees becomes
> simpler compared to reusing percpu_array maps.
>
> Links:
> [1] https://github.com/anakryiko/retsnoop
> [2] https://github.com/bpfsnoop/bpfsnoop
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/arraymap.c   | 38 ++++++++++++++++++++++++++++++++++++--
>  kernel/bpf/const_fold.c |  1 -
>  kernel/bpf/fixups.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c   | 15 +++++++++++++++
>  4 files changed, 89 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178c..c4e9430941e5 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -259,6 +259,37 @@ static void *percpu_array_map_lookup_elem(struct bpf=
_map *map, void *key)
>  	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  }
> =20
> +static int percpu_array_map_direct_value_addr(const struct bpf_map *map,=
 u64 *imm, u32 off)
> +{
> +	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> +
> +	if (map->max_entries !=3D 1)
> +		return -EOPNOTSUPP;
> +	if (off >=3D map->value_size)
> +		return -EINVAL;
> +	if (!bpf_jit_supports_percpu_insn())
> +		return -EOPNOTSUPP;

Nit: This should be first, if the JIT doesn't support the instruction
all else is moot. Same below.

> +
> +	*imm =3D (u64)(__force unsigned long) array->pptrs[0];
> +	return 0;
> +}
> +
> +static int percpu_array_map_direct_value_meta(const struct bpf_map *map,=
 u64 imm, u32 *off)
> +{
> +	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> +	u64 base =3D (u64)(__force unsigned long) array->pptrs[0];
> +
> +	if (map->max_entries !=3D 1)
> +		return -EOPNOTSUPP;
> +	if (imm < base || imm >=3D base + array->elem_size)
> +		return -ENOENT;
> +	if (!bpf_jit_supports_percpu_insn())
> +		return -EOPNOTSUPP;
> +
> +	*off =3D imm - base;
> +	return 0;
> +}
> +
>  /* emit BPF instructions equivalent to C code of percpu_array_map_lookup=
_elem() */
>  static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_i=
nsn *insn_buf)
>  {
> @@ -551,9 +582,10 @@ static int array_map_check_btf(struct bpf_map *map,
>  			       const struct btf_type *key_type,
>  			       const struct btf_type *value_type)
>  {
> -	/* One exception for keyless BTF: .bss/.data/.rodata map */
> +	/* One exception for keyless BTF: .bss/.data/.rodata/.percpu map */
>  	if (btf_type_is_void(key_type)) {
> -		if (map->map_type !=3D BPF_MAP_TYPE_ARRAY ||
> +		if ((map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
> +		     map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY) ||
>  		    map->max_entries !=3D 1)
>  			return -EINVAL;
> =20
> @@ -832,6 +864,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
>  	.map_get_next_key =3D bpf_array_get_next_key,
>  	.map_lookup_elem =3D percpu_array_map_lookup_elem,
>  	.map_gen_lookup =3D percpu_array_map_gen_lookup,
> +	.map_direct_value_addr =3D percpu_array_map_direct_value_addr,
> +	.map_direct_value_meta =3D percpu_array_map_direct_value_meta,
>  	.map_update_elem =3D array_map_update_elem,
>  	.map_delete_elem =3D array_map_delete_elem,
>  	.map_lookup_percpu_elem =3D percpu_array_map_lookup_percpu_elem,
> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index b2a19acadb91..5787246bef30 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -182,7 +182,6 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>  		u64 val =3D 0;
> =20
>  		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
> -		    map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY ||
>  		    off < 0 || off + size > map->value_size ||
>  		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>  			*dst =3D unknown;
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index d3be972714b2..02642bba73e5 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1818,6 +1818,44 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
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
> +			prog->jit_required =3D true;
> +
> +			/*
> +			 * We are *skipping* first half of ld_imm64 insn
> +			 * with 'i++;', patching over second half of it
> +			 * with that same half + mov64_percpu_reg insn.
> +			 * All because bpf_patch_insn_data() can only
> +			 * replace one 8-byte insn, which does not work
> +			 * well for ld_imm64 insn.
> +			 */
> +
> +			insn_buf[0] =3D insn[1];
> +			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
> +			cnt =3D 2;
> +
> +			i++;
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    +=3D cnt - 1;
> +			env->prog =3D prog =3D new_prog;
> +			insn      =3D new_prog->insnsi + i + delta;
> +			goto next_insn;
> +		}
> +
>  		if (insn->code !=3D (BPF_JMP | BPF_CALL))
>  			goto next_insn;
>  		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e1244a721194..ae442ea217c4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5615,6 +5615,8 @@ int bpf_map_direct_read(struct bpf_map *map, int of=
f, int size, u64 *val,
>  	u64 addr;
>  	int err;
> =20
> +	if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY || map->map_type =3D=
=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return -EINVAL;
>  	err =3D map->ops->map_direct_value_addr(map, &addr, off);
>  	if (err)
>  		return err;
> @@ -6174,6 +6176,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>  			if (tnum_is_const(reg->var_off) &&
>  			    bpf_map_is_rdonly(map) &&
>  			    map->ops->map_direct_value_addr &&
> +			    map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY &&
>  			    map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {

An issue I have with the patch is that it takes the special-casing we
already have for INSN_ARRAY and makes it worse. The instruction arrays
implement direct_value_addr, but it's not actually valid to call
direct_value_addr from a bunch of places where it's called, so we have
to special case check the map type to prevent it. Case in point the
special casing in check_arg_const_str in the thunk below.

Imo we should consider making a different map method different from
direct_value_addr that INSN_ARRAY and PERCPU_ARRAY implement. That way
we remove most of the map type checks in those paths. I'm not exactly
sure how that would look like, but I could take a look at it tomorrow.

>  				int map_off =3D off + reg->var_off.value;
>  				u64 val =3D 0;
> @@ -8176,6 +8179,12 @@ static int check_arg_const_str(struct bpf_verifier=
_env *env,
>  		return -EACCES;
>  	}
> =20
> +	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> +		verbose(env, "%s points to percpu_array map which cannot be used as co=
nst string\n",
> +			reg_arg_name(env, argno));
> +		return -EACCES;
> +	}
> +
>  	if (!bpf_map_is_rdonly(map)) {
>  		verbose(env, "%s does not point to a readonly map'\n", reg_arg_name(en=
v, argno));
>  		return -EACCES;
> @@ -18279,6 +18288,12 @@ static int check_and_resolve_insns(struct bpf_ve=
rifier_env *env)
>  					return -EINVAL;
>  				}
> =20
> +				if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY &&
> +				    !env->prog->jit_requested) {
> +					verbose(env, "JIT is required to use global percpu data\n");
> +					return -EOPNOTSUPP;
> +				}
> +

Another place where we add map-specific checks where there are none.

>  				err =3D map->ops->map_direct_value_addr(map, &addr, off);
>  				if (err) {
>  					verbose(env, "invalid access to map value pointer, value_size=3D%u =
off=3D%u\n",

