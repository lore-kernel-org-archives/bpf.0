Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89C2D8762
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254735; cv=pass; b=AlwVTA/3/8ySkAapS/wD6yVFid1U3v/gzvTDHOQgGOAgCmYJxeDCAVGIT+mhz00bg7gZlI3f6RYUUaaBHhs0Ko0+0oM9HTXZhVy5zEqJf2JOxjY3/nyXve/+95/pQ+bvR8WN7+QLvy4jY861zUI+VwyaGNmhTXjY314Ec+kN9+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254735; c=relaxed/simple;
	bh=hrZgMFYyT9DEm/vsnt3KYYGCovrOMN5tcXZ3in6a5EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgXVPJZURb0DOeUVs80cJZe4fZVHTbt2xH4xuI/0c5J4vp+0q6/PFNlhTyIIBjzpb7m9NOOGP7FMeGxM5LH6wm5Py3cKGTdk/4Ui16cFPpW2MhJxNLLlW9qo7eRJxJr0FH1w21M4WGIeFit3q32yndaBUQRGww7pA4Qo3n/ViEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMef/w9w; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMef/w9w"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6ec0af575so1868235ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254733; cv=none;
        d=google.com; s=arc-20240605;
        b=b/YB7axe4ZXeVGND5D4MdktzsGFIBXZwfauRrvtRCU5yBsV1vh2xZX8jhOWC2jfX/5
         PkZkwSYqv7UM5uutn3rQ578OXMYSqY3O5fYv9xUdSzNpjbv+wCbtXVlq0S4yu4C5FQBU
         odux2jzJ/rQK+WVUQZoKDH4u6HA7jikpNBeIXCEL0+SFtkDwNpm/Ri7A8sh8qPranmoO
         vktYAhYYD2vnbi0KFVKlWJbrawAyjfJXmUMXUCAJy8KW5T5AW2r/4V17c6m8kLhMvxQR
         jf9gZlF2q5NQgQ9iUNRsOLUwqm1x/AyXhDl+rUYEXeVfSZiwWTFva0SQ4FcoOeYX3frE
         Q/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wXxOG/jfQg0/T7gomCIYREfQOagj5s1RFOGCHTxehnc=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=SQR1GZExyf4FCQCXqlEqIpAwu4y6i5T9ENHeGY+fvnScrPa80Nw4iqXnCJLwn4r/C0
         zQEtKyetut0slhwu6E9hGidYQQxMUUoCwiNhdwqzlPC/hGywVX1YJ4Nwwn3KRrPOO93C
         +f2mqSSR7XW/qW606wN5wtrZDSgnnrsmC4dS0PU5nRgALeOGZm5XwYY4SLdVnf+ws5wb
         67Tf4hQ/N+gQReHUYUFTsW9vxFvQN2y/bynLj3p9bvbjivMA8qkn8L4j3B/wXaWJB0j5
         B78XsqDU1S0qVcfT6Qk+EntMAnz1cTxcJ7ZHbgSaQz8O5ckzGS4QDH1gNJE2ObyBrath
         EgrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782254733; x=1782859533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXxOG/jfQg0/T7gomCIYREfQOagj5s1RFOGCHTxehnc=;
        b=kMef/w9wnqFT/EVtrKq2nYspo7aTrxsyZkI8OySsbOiGassqbZ5HkkMIwV0KWrYZB8
         9WqAH5jWbI3FvkN5015imhXgCBNMGAH5toLB6s024CHNfvZQfa6dusoRm/Ekxf+etPPn
         C9trfwcN5Yg7qLU/AZBSfXyMctLfK7EwUMyzsATxOU4i5l+V36hvLDoNB9DJfjQbEMEe
         Xf2HhD9/a02wyd2aiMEaKcRfHnf9fmeXLi5X0ti3B+mi/nEDBKVov3bYtVuNH1XS/Paq
         N0yEgupsMgLd4zzzzTczfxqraPPkKFN7KNGX3lALUq6Fo2B3fLYwMBoegKlmJOZyNuGw
         Q1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254733; x=1782859533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXxOG/jfQg0/T7gomCIYREfQOagj5s1RFOGCHTxehnc=;
        b=fqtG/EdGDREKCtbBaS+D2K7CQnMA7axSU7HP+8OHgjCe7e1FNcYJWVYbTC55Jl0SZr
         sl8krAcmL0gc5QKle4PlLafPpge1rf2e7NblS+lffvGyxE5Owlxsnpmbkczs/YhD8ChU
         3VByJpULx5hwQ7pzJqbN4k9J12ObgJ2nniai1le1cRKIr3+4eHxVZaVaFIxDRenCqJAa
         7YKHStA3l/buxSEqD7KCFM2cPHbOPdNTWt9ukU60UFOoeHC91oeAEfFZjbccW7jV5fLM
         7eZDQ5bnYQx9Zr3geGwC5ycDCNBhlzM1MMZlkQT5XBWQLIdxNF7HnGYUDPFt8fSme7nF
         Iw+A==
X-Gm-Message-State: AOJu0YxqLmOKaGNAX1CV13MDMbUrMuRpm8+2l93J1kPbfzmsoHuUHfNK
	Df6WGdxAcpBqrZzZ8hrKqHHNBmMnxBx4jAIi5sYmNRQRFsg5EBvXlh1W2IgL03VSm1iKJos4fqb
	ElPfPOjxDuRHbdrBYMsmmE2Y5cLC2X5s=
X-Gm-Gg: AfdE7cmjlnV0n4e3p4gSMibu1U+a8oFqSBm5oMI88fJrlc5h18x9sPv1bnv5bZDKi+J
	6jluPnj0il+mDIhi4uZDBn8nK7jzpJ+4s3Q9gZlimRv6R8uM+xr/95BcRClUFYpX3/aKxvNGPq/
	d6tk6nxvUTP0mAAUcZOwriaPyeFimveaMUi07YAo3rkfqH1BGqeMiN28/NN14gr0hr/oHJ3VAfP
	x4sAxeffyD9JafOOgFY0E439Wl04wp4666RDLsNiAarAGUHAc4HXIT6vwhVvSuTxZPl8zJaQiMC
	49IsllL4Cr8g4CwkTik4H5cMCOh0mVOO5rF1TzK88MkEnkUZip+NsqkW45dw2ojy+9EdCg==
X-Received: by 2002:a17:902:e843:b0:2c6:ef2c:4405 with SMTP id
 d9443c01a7336-2c7e13bdfe2mr7595515ad.5.1782254733479; Tue, 23 Jun 2026
 15:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-5-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 15:45:17 -0700
X-Gm-Features: AVVi8Ceoru0wYWL826ra81zuTyttk0w5Uc3IpjDkIWpGEbDG0bNldeRs_-InEgw
Message-ID: <CAEf4Bza8aqNsiiBHJ64+Sj-2twUFxeSuBZ89tVroig3OWC9_Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 04/11] bpf: Introduce global percpu data
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

On Mon, Jun 22, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
>  kernel/bpf/arraymap.c   | 39 +++++++++++++++++++++++++++++++++++++--
>  kernel/bpf/const_fold.c |  1 -
>  kernel/bpf/fixups.c     | 34 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c   | 15 +++++++++++++++
>  4 files changed, 86 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178c..876aa2604f41 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -259,6 +259,38 @@ static void *percpu_array_map_lookup_elem(struct bpf=
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
> +       u64 range =3D array->elem_size;
> +
> +       if (map->max_entries !=3D 1)
> +               return -EOPNOTSUPP;
> +       if (imm < base || imm >=3D base + range)

nit: not sure what's the value of range local variable, single place
where you use array->elem_size

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
> @@ -551,9 +583,10 @@ static int array_map_check_btf(struct bpf_map *map,
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
> @@ -832,6 +865,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
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

can you please elaborate on why this change is needed?

>                     off < 0 || off + size > map->value_size ||
>                     bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>                         *dst =3D unknown;

[...]
