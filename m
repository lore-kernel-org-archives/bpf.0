Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482F2459FE
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934305; cv=pass; b=BeoJ/rDskP3+QPPiwdjrfy4Hby+FkM3OJKkgJQD2JSsxgSVwIDMwws1GVnu85TX6YOWzjyhKZs+zQ/HZXpFiVNjaXvmXT8N80njmzy0XzWQAryNCyokKvWa77hSE0RuTTWB9s71GxOpkXhvugYF8ARs46quN3GAYWjS3tPpFtAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934305; c=relaxed/simple;
	bh=0htn+i6mZf40baffKEjWV+OIatlEsQ+WzRyInGMs21E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fojJytjH1Svuixqs4igYUMVDGvGkBoSeJxEDvykIazZjEscOpVTUcMvEH/u+HSvbl/TaEGemdElhi1HsCpV6+jTTkx8u7aImf21U2OpoGWi8qVuWVa/zg3MMhYfmvT0o7xx5Dlm2N8o9Zk7S1lucfbqvcRWFGQ+m/yGmZ9rdWSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC87zF4w; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC87zF4w"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c825c88744so9686785ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782934302; cv=none;
        d=google.com; s=arc-20260327;
        b=ChYEE9RAJK3FSq2kcV9DCPs3xfKcDiVuRcNDW6okThJ/4ZH5ej0HOUdvkSam9jey0c
         baYFVPjwu32MXsT3MlgHEIkWqjed5MtMhKqr3bx2t1oo12aOpzZWaZnF2otWZJpqez8i
         P/FprIEX/1hkSuCqlFqgF5X7CMRRwUzg1BcFFc7Tk8SrA0B/6VOylJxU4TnvyfUfuyjU
         VGcpMCMm09cFMpA+S77EgBf2cfxj2LfNIMb8Mf4pelO6QlPjnJYzPs8J6Im7dLhAt2Ks
         kMy18/Ef3LcByJYvem2sd+2M31f9xnrHnpitRcyCJtq1qhwYEx9sLtdUHkzZA4/KTQeI
         cwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zWveFEax5PQ0FUJTFYBA4Bx2MhWUvxu8QAilhVWWOk=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=YSKUhDNoOXoJJh/y/EenU3YAoZ9o/acCwQcS9u1pA+lLq8xSLiAr6qFExLemiekI3y
         kW5rNDYWdNfcpBoXPsVkrWzxDml9Fs0mBy590FG6ygxzGOu/smYFUPuJLhTZ/QeDV7K8
         mHZuGckTauAcPk2ICxL6OQdnXpcRGaVRvu8VLEMArkj41d+sFMaeygDAwXaPGNp196/w
         02aFKiQdpUTpRZFHbBLWZyr/lj2ayu+J0mVSDvfK+VFZn72Imu2qxl90scIYqhvezrYZ
         og2g5G0ifDcgFhYcd0TJl9zCAu+XPZt0kLtIiETi5knY4aqdclaKs51SQRdDc4mBjVzc
         oRCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782934302; x=1783539102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zWveFEax5PQ0FUJTFYBA4Bx2MhWUvxu8QAilhVWWOk=;
        b=lC87zF4wYG2iwUWnDjT+EmrS3uLQKS0eawyE1+b4yczDRy03arxHMtzJ0h2Jj8OIW1
         SRrsyT/wjJN94yg8p+duquXppS5N0UaaYXABRb79UV95QdlasRY/nMmBWb/mw/2utW3h
         3dmzA3A+ArF1+keIAd8i/gUIIlSkWiqulBxJBKfe3MS2RuOqWAQzcrxf9Yf8gWamQy2T
         2XDf+lk6hq26npMNQTKfpurJn2KJ3K3Bdr0gbaxyZmcPHNKZmVv//s6NpkgnOv6l0ZZH
         YcZpP5rTXCSQ5kaP/Gl+0I9H+Tc5nhwpP666cRTr/EcEk+4DRRz3NQyZI7mTacrvI1es
         k+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934302; x=1783539102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zWveFEax5PQ0FUJTFYBA4Bx2MhWUvxu8QAilhVWWOk=;
        b=VRnC6tN4uimg6LYUwSFKClpO5Bx+lv4T8KE0XHPr2vP6myMAZvLVNdSYyKrPqcONe9
         BLMyMp4J2Un02B4TxTFp6/S8PIrsuhDakUPSEjBA0hEhduSrgCunBg1sr8z8lPBtowXM
         MKxwDmUa/dtvIpfmihvMkRL7jGcmMqJB6Iir1bcUesNkesQtTQW7LLOmR4eXsuT8IQ/7
         ardVx8GwQpSojyS38br3NhsNDVZgCBgDlUcpwN5MtishZlc+/Lm+/AQquUiKDCAYMOGq
         dh+pojpLSfpSNmJEjYHuqtcQot09GM8QK+d3u6ABB2IkIOKoZ2bCsiVH7Y4HwhxEKR+Z
         ORQw==
X-Gm-Message-State: AOJu0Yy4tiAcHJtsGOlYy/L5XYbLex/P49LO5p8QmRIacwUIOyE3fwv5
	z7OLET7Et9Z6aoF+HBAmhCWI6JJ32PpO+P34CUiXRJIn+lUuRZYPHyZFxxWWuBvItfX1sPWn29W
	//91irBE3wpp2Bd9YFXrRjDy4XjKlToY=
X-Gm-Gg: AfdE7cn4PgUnOVZUGBuBBeEIUDaXlUGhTK9C4OMvVAakgyZAJWJSrvT6BlLdF46djYv
	86/cu10gTb3xcQcbg2gCnjnRz1rOE7jv/ypT3a0/snkJXMtMv+sb/YLw9QrEeW2mvg5wL3O7o0w
	53FfvT/yl8d+aAwINYTo7jI6Xg+j0PfGSRXEXUhO4vPEEUNSDU1IlI83wQNWS4W2xmm+kgy3ftj
	Qqxim+NKVgAkqVklStcLGIOF246VDcPghYWSt/s/Uhs3rjHGNLAs9s7OmBTOxjHNRmB/vQ8TnEv
	99H8jztY9KSFLT6n2avrUp19XVIi8YHjlTJ4xp/K2hBDXUtKU4AcOw==
X-Received: by 2002:a17:903:1ce:b0:2ca:26:195d with SMTP id
 d9443c01a7336-2ca7e6a9f0cmr31749355ad.11.1782934302133; Wed, 01 Jul 2026
 12:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629152406.52582-1-leon.hwang@linux.dev> <20260629152406.52582-3-leon.hwang@linux.dev>
In-Reply-To: <20260629152406.52582-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:31:27 -0700
X-Gm-Features: AVVi8Cfmg5_RbShl0pNDp3CrFROZR4VUm4he2XAiP8L4ZjJ7QELDhaWywwRNJok
Message-ID: <CAEf4BzbLDna2j_yNniZ8gW6Um4AzWd6xYS4N8hp7hk879phgug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/9] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
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
>  kernel/bpf/fixups.c     | 32 ++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c   | 15 +++++++++++++++
>  4 files changed, 83 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178c..c4e9430941e5 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -259,6 +259,37 @@ static void *percpu_array_map_lookup_elem(struct bpf=
_map *map, void *key)
>         return this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  }
>
> +static int percpu_array_map_direct_value_addr(const struct bpf_map *map,=
 u64 *imm, u32 off)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +
> +       if (map->max_entries !=3D 1)
> +               return -EOPNOTSUPP;
> +       if (off >=3D map->value_size)
> +               return -EINVAL;
> +       if (!bpf_jit_supports_percpu_insn())
> +               return -EOPNOTSUPP;
> +
> +       *imm =3D (u64)(__force unsigned long) array->pptrs[0];
> +       return 0;
> +}
> +
> +static int percpu_array_map_direct_value_meta(const struct bpf_map *map,=
 u64 imm, u32 *off)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       u64 base =3D (u64)(__force unsigned long) array->pptrs[0];
> +
> +       if (map->max_entries !=3D 1)
> +               return -EOPNOTSUPP;
> +       if (imm < base || imm >=3D base + array->elem_size)
> +               return -ENOENT;
> +       if (!bpf_jit_supports_percpu_insn())
> +               return -EOPNOTSUPP;
> +
> +       *off =3D imm - base;
> +       return 0;
> +}
> +
>  /* emit BPF instructions equivalent to C code of percpu_array_map_lookup=
_elem() */
>  static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_i=
nsn *insn_buf)
>  {
> @@ -551,9 +582,10 @@ static int array_map_check_btf(struct bpf_map *map,
>                                const struct btf_type *key_type,
>                                const struct btf_type *value_type)
>  {
> -       /* One exception for keyless BTF: .bss/.data/.rodata map */
> +       /* One exception for keyless BTF: .bss/.data/.rodata/.percpu map =
*/
>         if (btf_type_is_void(key_type)) {
> -               if (map->map_type !=3D BPF_MAP_TYPE_ARRAY ||
> +               if ((map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
> +                    map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY) ||
>                     map->max_entries !=3D 1)
>                         return -EINVAL;
>
> @@ -832,6 +864,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
>         .map_get_next_key =3D bpf_array_get_next_key,
>         .map_lookup_elem =3D percpu_array_map_lookup_elem,
>         .map_gen_lookup =3D percpu_array_map_gen_lookup,
> +       .map_direct_value_addr =3D percpu_array_map_direct_value_addr,
> +       .map_direct_value_meta =3D percpu_array_map_direct_value_meta,
>         .map_update_elem =3D array_map_update_elem,
>         .map_delete_elem =3D array_map_delete_elem,
>         .map_lookup_percpu_elem =3D percpu_array_map_lookup_percpu_elem,
> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index b2a19acadb91..5787246bef30 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -182,7 +182,6 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>                 u64 val =3D 0;
>
>                 if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_valu=
e_addr ||
> -                   map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY ||
>                     off < 0 || off + size > map->value_size ||
>                     bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>                         *dst =3D unknown;
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 3cf2cc6e3ab6..4f84d087ca69 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1819,6 +1819,38 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>                         goto next_insn;
>                 }
>
> +               if (env->prog->jit_requested &&
> +                   bpf_jit_supports_percpu_insn() &&
> +                   insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +                   (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +                    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE)) {
> +                       struct bpf_map *map;
> +
> +                       aux =3D &env->insn_aux_data[i + delta];
> +                       map =3D env->used_maps[aux->map_index];
> +                       if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +                               goto next_insn;
> +
> +                       /*
> +                        * Reuse the original ld_imm64 insn, and add one
> +                        * mov64_percpu_reg insn.
> +                        */
> +
> +                       insn_buf[0] =3D insn[1];
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_re=
g, insn->dst_reg);
> +                       cnt =3D 2;
> +
> +                       i++;

oof, this was a subtle head scratcher for me.. that i++ is easy to
miss. let's update the comment to be more explicit: we are *skipping*
first half of ld_imm64, patching over second half of it with that same
half + percpu mov. All because bpf_patch_insn_data() can only replace
one 8-byte instruction, which doesn't work well for ldimm64.

Anyways, this looks correct, it just took me a bit to figure this out
and while the above comment warned me about this, it didn't really
make it any easier for figure out what's going on.

pw-bot: cr



> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       goto next_insn;
> +               }
> +
>                 if (insn->code !=3D (BPF_JMP | BPF_CALL))
>                         goto next_insn;
>                 if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 49a331c27b43..dbf76fa9d43d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5594,6 +5594,8 @@ int bpf_map_direct_read(struct bpf_map *map, int of=
f, int size, u64 *val,
>         u64 addr;
>         int err;
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY || map->map_type=
 =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;
>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>         if (err)
>                 return err;
> @@ -6149,6 +6151,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>                         if (tnum_is_const(reg->var_off) &&
>                             bpf_map_is_rdonly(map) &&
>                             map->ops->map_direct_value_addr &&
> +                           map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY =
&&
>                             map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {
>                                 int map_off =3D off + reg->var_off.value;
>                                 u64 val =3D 0;
> @@ -8117,6 +8120,12 @@ static int check_arg_const_str(struct bpf_verifier=
_env *env,
>                 return -EACCES;
>         }
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> +               verbose(env, "%s points to percpu_array map which cannot =
be used as const string\n",
> +                       reg_arg_name(env, argno));
> +               return -EACCES;
> +       }
> +
>         if (!bpf_map_is_rdonly(map)) {
>                 verbose(env, "%s does not point to a readonly map'\n", re=
g_arg_name(env, argno));
>                 return -EACCES;
> @@ -18203,6 +18212,12 @@ static int check_and_resolve_insns(struct bpf_ve=
rifier_env *env)
>                                         return -EINVAL;
>                                 }
>
> +                               if (map->map_type =3D=3D BPF_MAP_TYPE_PER=
CPU_ARRAY &&
> +                                   !env->prog->jit_requested) {
> +                                       verbose(env, "JIT is required to =
use global percpu data\n");
> +                                       return -EOPNOTSUPP;
> +                               }
> +
>                                 err =3D map->ops->map_direct_value_addr(m=
ap, &addr, off);
>                                 if (err) {
>                                         verbose(env, "invalid access to m=
ap value pointer, value_size=3D%u off=3D%u\n",
> --
> 2.54.0
>
