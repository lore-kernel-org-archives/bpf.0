Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC53624C2
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033898; cv=pass; b=qg3n6A/T0mEill4pVXWY5I0gv7pqf0d9uAYRGAf576stX1oKpW/iJRo1jHmIFpDXCuC5SEtTHkEKhHKf9PXl6AZG9u5OV7KYtxLSHD5JaCU1DKP5XPbaJIpu0MFNOilcrOne/J00j+rt07VaZLUTW3pf/9psT6mDQmXzrEt8BDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033898; c=relaxed/simple;
	bh=EsD8aClgWTTqBpahpreUgIqblCQ7oBBVFLwMEE32rZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1frSu65nm/zQGgN0wN1o0q+M4sMvrBsD0PzQAu6C50hNErmMfOW8cIKPWGeecOhRgtTNpbTP3+K8Y5PdqfmhOGqfqtvM8USDsZOYgchi5zewUuPT4nHV5N4YyubdNwgihho2n1zMUEGyKRekljmMvceFxema/bzukGgzFFpN/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp7TvKdk; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp7TvKdk"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80e24970f1dso19450477b3.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 09:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786033895; cv=none;
        d=google.com; s=arc-20260327;
        b=QBxoQnHa6GvdJpu/us2gf0v/nxi7CcT4eWEcSCP6GyHewj8bz1hyhMAM6JJUhFr9q4
         NouRRAEPXwMOq6pUrEkL467132ZRiDZE0PKqWl5L/tZXmF2xjf9/W+felwT1mwiyvLcg
         s6hq5mYFE0GdfgmGdZJgBsWltwB7/RpY7WAyz75+glMqmcFdtHHn3ZKiYk9pp5EJCJcV
         loMD/kKP+uexnJ4ueG1jSaemoWSIpdzB77e4+1J6P9CyxKKNjW50eP0X9Lq/M0vTKXgA
         DcRIVW9fcLg6QHZlspv4B/Ip1ABwwBmoscxgZ6NZxo4aeh7GJjPLyFpZQuyTOTzqSFJe
         7UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ur1jFnRkSh5G5ufKD4mnRV4SmgNE+5BFSSKodtvclhY=;
        fh=B5cyw1yRIFuY1K+xO+VoEqAhNWQz2KjO7/ov3WrCuBU=;
        b=BH6IROezeCx00i0Y+7sZGFwXc8uvNE2gzE84N1qXMm8i/dUr7JbDUwfMT6JoTpX3Gb
         fYg9/f8lRRU8Yr5t/NZIr4b+EXi25ptOu+b1OPrMogvpjRmRu7pc7uVnzCFhymtfiYyW
         Ufw0zUMjvFfCfaUAGCOa4atrHPRL0e5pO4jE0VMHVTZ0KmCjd1EpqvTuxFDonLXWEoUo
         0Lh1iXR5QBl4gKkSg/R7DdvkBMpBQd3q5gDn5nyN/JD6XxAPuzhksUvgzY4RcPJoVJN2
         xKS8iDcssJ0ErTncbTJ59AovW9jluuzVj7XrkCh2ZjO1n20spC3NPNxzy3IOFYV7gEAR
         klPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786033895; x=1786638695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ur1jFnRkSh5G5ufKD4mnRV4SmgNE+5BFSSKodtvclhY=;
        b=Fp7TvKdkkMilZ7uT2al0QvEX00X08T8/swU4AbL8KayWA6hk+XorKCbVn01VfR7cRz
         m9UiYOuE0dVdCQKynVvp6KhTFWe5N+afFF9tIP7YyfJ/gZAPzCmdbCCv41FOWAMss+Fm
         C13qk3fvXgpFDjTuNhzLPe9pDT3SRJBthTP5QHYolPBw3Gn7JFIe0l09jOWux14xDFME
         nSiAdZXSTFd383JCskSQ7D9xEzP/xCebH1uQKznksghv7OJOr4af026hbjTPWJlF7nDk
         BaykWAyfbz7gbv78Wok2ofl3Dtb50KP1imWXnu75f/keHb494k/2fSycPkxDbohP+SqJ
         uMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033895; x=1786638695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ur1jFnRkSh5G5ufKD4mnRV4SmgNE+5BFSSKodtvclhY=;
        b=WVkEjnKYlUp89PBSCgqKQ76KzmRs6Rha0jOGTf33kk4a/HQbyHmnaDvaorxqv992PQ
         MUL0ggXL233f9C2rARHimdB9CMUp9dIK+AvJsVTMKjd5cL5Hs7QJIZODHQlC7yHogbmI
         XH3I/RHf2bjmJNCGa+LWwQnjm9/mDTwWp91PpSy9nV2sbuRoUkIYHse72FcWDNl9LOqN
         SLMjAC61ar17DufQ5FGfXakduYpB+4CazCrrhsFBSUl2TjYXDkLkl+sIj1VTK5DylQop
         tmzbNFrU5KqNrT6bNqSkxftYys+jJDipJTMU4gL7l5x0Hc2McjZWZK/UhHZGWuWSlZp4
         yj+w==
X-Gm-Message-State: AOJu0YxmxNOzaHiZs8L4uVCBPT84OMOdUALwHtLbRYN3nYMSj+pW25Xq
	+nq8GDvnu8Ju1rxGemnl08J8clxnZ7SR0H1+z05bh6ttM1+uc+IZakfGOzra/mirtBQcWtKrqWn
	edGLAIVyYo6DjHRqNt0GLC2dYZhQeVw0=
X-Gm-Gg: AR+sD126xr0es7ogWwql2HK+kEHlfLkkWf0ghLfTTKn1bbzQgGIpWcXk2p+6zzp1PCJ
	15+CzpvEMmyvYlEHoG4QoWZrdBk9d6vucski4OHpmg+uwvjlsP5PoTkDOWjGrXgl54pU0QNLQD4
	tF7DD3xcYvd0UKQZES1mC+O2CFNLATGR/I8KrtgzqG7XDu5sqI/E0bACpV8LoQ/aCB9DqXqRPgC
	vM0WyCMB5uRh0qU4b0qqiL4EqWMUF+TXeHhr/MWzaOC5epHx9QhP9neuGAl/bZfvphlIWcYJ6nM
	mMo6+fXWQ2x4Yi/UB19jfRdqhpkRV99g0LNN5hA0zX30
X-Received: by 2002:a05:690c:b94:b0:81e:ae6d:caed with SMTP id
 00721157ae682-8225e3fc70fmr17120567b3.34.1786033895572; Thu, 06 Aug 2026
 09:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805210427.3218326-1-memxor@gmail.com> <20260805210427.3218326-3-memxor@gmail.com>
In-Reply-To: <20260805210427.3218326-3-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 6 Aug 2026 09:31:24 -0700
X-Gm-Features: AUfX_mzA2__24sFSDSlSNquwfrQqkuB0lK0jWNHry-iyHMUks_oZNIEqMbNJ5sw
Message-ID: <CAMB2axNOeikzAjc+X6KTT+=YdGNBBa2-_EAXc3Bk_kXZmpLGdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Split subprogram and kfunc collection
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:05=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> add_subprog_and_kfunc() combines two operations with different ordering
> requirements. Subprogram discovery must precede validation of func_info a=
nd
> line_info, while kfunc descriptors are only needed by the verifier after =
its
> initial program setup is complete.
>
> Split the helper into add_subprogs() and add_kfuncs() so each operation c=
an be
> placed according to its actual dependencies. Keep both calls adjacent and=
 in
> their existing phase for now, and add short comments describing their rol=
es.
>
> No functional change is intended for valid programs.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/verifier.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 129e50888b90..24b163c2bd63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2842,7 +2842,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env=
, u32 func_id, u16 offset)
>         return 0;
>  }
>
> -static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
> +static int add_subprogs(struct bpf_verifier_env *env)
>  {
>         struct bpf_subprog_info *subprog =3D env->subprog_info;
>         int i, ret, insn_cnt =3D env->prog->len, ex_cb_insn;
> @@ -2854,8 +2854,7 @@ static int add_subprog_and_kfunc(struct bpf_verifie=
r_env *env)
>                 return ret;
>
>         for (i =3D 0; i < insn_cnt; i++, insn++) {
> -               if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn) &&
> -                   !bpf_pseudo_kfunc_call(insn))
> +               if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
>                         continue;
>
>                 if (!env->bpf_capable) {
> @@ -2863,11 +2862,7 @@ static int add_subprog_and_kfunc(struct bpf_verifi=
er_env *env)
>                         return -EPERM;
>                 }
>
> -               if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
> -                       ret =3D add_subprog(env, i + insn->imm + 1);
> -               else
> -                       ret =3D bpf_add_kfunc_call(env, insn->imm, insn->=
off);
> -
> +               ret =3D add_subprog(env, i + insn->imm + 1);
>                 if (ret < 0)
>                         return ret;
>         }
> @@ -2905,6 +2900,28 @@ static int add_subprog_and_kfunc(struct bpf_verifi=
er_env *env)
>         return 0;
>  }
>
> +static int add_kfuncs(struct bpf_verifier_env *env)
> +{
> +       struct bpf_insn *insn =3D env->prog->insnsi;
> +       int i, ret, insn_cnt =3D env->prog->len;
> +
> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
> +               if (!bpf_pseudo_kfunc_call(insn))
> +                       continue;
> +
> +               if (!env->bpf_capable) {
> +                       verbose(env, "loading/calling other bpf or kernel=
 functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");

nit: Should this and the error message in add_subprogs() be updated to
be more specific?

> +                       return -EPERM;
> +               }
> +
> +               ret =3D bpf_add_kfunc_call(env, insn->imm, insn->off);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int check_subprogs(struct bpf_verifier_env *env)
>  {
>         int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
> @@ -20322,7 +20339,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>         if (ret < 0)
>                 goto skip_full_check;
>
> -       ret =3D add_subprog_and_kfunc(env);
> +       /* Discover all subprograms before validating their layout and BT=
F. */
> +       ret =3D add_subprogs(env);
> +       if (ret < 0)
> +               goto skip_full_check;
> +
> +       /* Collect the kfunc descriptors used during verification. */
> +       ret =3D add_kfuncs(env);
>         if (ret < 0)
>                 goto skip_full_check;
>
> --
> 2.53.0
>
>
