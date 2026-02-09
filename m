Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36372AD0C
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672198; cv=pass; b=C7csR8eBbpLs7SVJyCiAXQwhr9VQT7ljKAODX/dtMMZLjzfbQ2JzF43Kr5P+k3PKgj95ydC+vh9OSB2sFlYAbUYBjndPTxr6gdDL2NbUhmHWjaNpGPFJsDyaq72OZQv0qsBphTJEaiFk02it+WF26aU6s+v9UELwF6/1tuTeluE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672198; c=relaxed/simple;
	bh=XQVI16sht2XT5PEzrX2Qln4gv/sKtzVtyywstW4Ue2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP5Iu5yerOmkM/rT5mYl19qGfGYyvMVYwszx16Smt2RaxljXN8mIafih+tRmC2lHnGJ+KuksAvaeoplEDizqm23vCSBsnls5nkwLQrJwlQaSSVRbVanP2NH8XjiPrPmyYH2FZmd54dJ7YEMJiWAQ1G9aEvhMJUt6CK+CO/yGttQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtXVlwaI; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtXVlwaI"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824484dba4dso122966b3a.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 13:23:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770672196; cv=none;
        d=google.com; s=arc-20240605;
        b=MS5bJUihKkaUToGx/yYv36wtVjLPSgLq4M8iYZNVCzxvyJqdjO14JIXdRXYSfkEMRb
         1UfSrpfFyF55p1mUtmm/3N35GTuJ37114NPFRHjefd9kn3Ie7ABwd3vmDT+zbEVivUBW
         Mm10Cc/S8gq/zYxufpVR7xshdJvA5C/eZiXWTGUX7s9vwabIAmG/UPFQKAbXbAI0orkg
         coD6G8dpADq4LOCigqPybMjMTAq57bfQR1g9/XJqY3zihRzLUg/28LakvnVxvP59LD+o
         Lbd3GFoeeRMe1/fsUgux0Bv+8SsmKxsq6QASzsfBEOfWiQmfyqSaHtQMvqSgoikBJDIU
         8+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDKniAi1SPY8sVft/wPcVxnV0NxgSkUl0iBwmdPtWyQ=;
        fh=TCTIBws018cdvbzFnR9DP/oHdDTIeWJgn/HK86y3L8c=;
        b=CT5siwk8OdRYj0ZTliC9R3O9u7w7O1V6c5Npo5zUqgsDYNCLM+K0991EVDKoSLcUOW
         gY6pdM0FdTxphZuUV4ssxwkNAlcOPAuFu66APGNqFA24dHslnkeEywoBMNko5rtBgdow
         ybRHjnLTCL5TvIX3avOJsYJJU5DZ3RAqxK1jwGTwexwsz7bMLdUkui9mWBNZ6lkNfmXQ
         J33mVfn9rTwPUlPFQm6wkfAYjPQSL+HDR0pOu0FvraQ0m2hhVDLfL2XVwr/a6HJg4EkP
         7QZxo5SeR0Fqyzw+SIKffQybkykyV+Xb9UeZUhaF2lYn3JmABnXyGjmHF7EyCuEPAkXC
         eRyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770672196; x=1771276996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDKniAi1SPY8sVft/wPcVxnV0NxgSkUl0iBwmdPtWyQ=;
        b=GtXVlwaIoxhXOszNAwDRL4+b+Z4s21Y39qLgFxOBlY60U11SZzqBFxqw5CmacK9aon
         /zezPNsyuPwt1o8pLGyKveEtH/FzuY1Bx0NwyNW+qAiK/7NUqceNKnLCSHlY55tkNRl+
         vh8unIe9V/OUhXuAx/QfZ2S1Trh8FBdNLZDzpqvpIYlSKt+DNH7gJ1MAIu13alnUd0b5
         PZtcR3s2wMFvgCe5WgSpFfJ2/dYekoHVoRB/7bWeGNfB6YWYRV3+tCvQVwP6/gGZ2GY+
         apx9Bt0HKg5waN+xkcxTz5ZoGV/8Sk+lDv0DlowCoGlsPakvjphlxZDxSr1UWeYOrAYs
         GLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672196; x=1771276996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDKniAi1SPY8sVft/wPcVxnV0NxgSkUl0iBwmdPtWyQ=;
        b=SpmrKY7Vfv86bqyJHVjGNTeIdcFFxad+FlFgBGcu76SFg4SfPdB9O55lcdtJu1vHcj
         VqIw571qoby37busmiwIuVczrih2Q3quQtY1L5qGL8PMvWngkHApXoMAk3Oz74dmkedn
         MV17Hiy/kH1vdKrDY8E0RuM4ZU+LBjqfU/kenQf4q1IFevc4fhcbenotB5tJm1taOx7R
         /0Z9XgtLL3RP6SK4EjpjWZXzi9ZwLdGUMTHP7+L83j+1tf+7xfkyD8pgqNeYhvjl5jXM
         j8F7mGBPXGoAEBThVenIkZ+N/lff1TuO2ODJnWXT0ShkI29eWpeQDWt1+63XLD4TXmGt
         Y6iA==
X-Gm-Message-State: AOJu0Yya6eaxQgsAdzVk1Q35tmE1ILdxUsbXMjwPK77CxK4TYyHT+UcB
	0paHevA4gw+Mm8LJIC2d6V3NCvM6udXsuRqqixnS4FQQII0oFmjb14XEjBinjdmjfKF75UEbWV/
	QXxV95FzC+0JiEFO3Ic5VBtqNaOCiYdk=
X-Gm-Gg: AZuq6aIFRgcQO+oD8YxR8QquCrw8UJlxxGBP92kh9CR1dLuYJvJHCejhhP5N5Obt2FD
	mOY8BkOKyWgxJRun2c/uiSEosBZ9HoOCyIkxYvikrOSPuHojrmdh8XTEmtPKXtHA/24dKr9FU3B
	XX34Oa2v23yoVYGRE2Qu2qP68+i88bgnjbXnpT3mrF8ZQN4UHV9CMlXoUM9A2a6kIDn8EnDWFxE
	D+Oxp6qsd2xBy/8tKDtUeeSAHUcdRy82dX2tDDMEEP0LrXw6sXtsk3JX3dxPkBoVty0FxP8+3jr
	Vetyp/Fzeg4=
X-Received: by 2002:a05:6a20:43a3:b0:35d:5d40:6d7b with SMTP id
 adf61e73a8af0-393ad369c51mr9936575637.37.1770672196209; Mon, 09 Feb 2026
 13:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209210240.2051209-1-emil@etsalapatis.com>
In-Reply-To: <20260209210240.2051209-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Feb 2026 13:23:03 -0800
X-Gm-Features: AZwV_Qjj3zuCPBbrpY5UEi0iY0HC5xkAmNcWUT-sWwgSpODIXaeCw_smRdO_MyE
Message-ID: <CAEf4BzYz3KBUyqR+OJCMns2Edsd+Dhyij=f8cqSEyY9OG0KCdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add gating for arena globals relocation feature
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:02=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add feature gating for the arena globals relocation introduced in
> commit c1f61171d44b. The commit depends on a previous commit in the same
> patchset that is absent from older kernels, causing arena programs using
> arenas >=3D 512MiB to fail to load and breaking libbpf's backwards
> compatibility. Introduce a libbpf feature to check whether the running
> kernel includes the required patch and only relocate arena globals
> if it does.
>
> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena"=
)
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/include/linux/filter.h    |  10 ++
>  tools/lib/bpf/features.c        | 178 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          |   7 +-
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  4 files changed, 195 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> index bcc6df79301a..70d4b5c08a7e 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -366,4 +366,14 @@
>                 .off   =3D 0,                                     \
>                 .imm   =3D 0 })
>
> +/* Program address space cast from 1 -> 0 */
> +
> +#define BPF_ADDR_SPACE_CAST_TO_ARENA(REG)                      \
> +       ((struct bpf_insn) {                                    \
> +               .code  =3D BPF_ALU64 | BPF_MOV | BPF_X,           \
> +               .dst_reg =3D REG,                                 \
> +               .src_reg =3D REG,                                 \
> +               .off   =3D BPF_ADDR_SPACE_CAST,                   \
> +               .imm   =3D 1U })
> +

Note that this won't be available on Github mirror side, we'd need to
add this there as well (but I hope we might now need it after all)

>  #endif /* __TOOLS_LINUX_FILTER_H */
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c

[...]

> +       opts.prog_btf_fd =3D btf_fd;
> +       opts.func_info =3D &func_infos;
> +       opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
> +       opts.func_info_rec_size =3D sizeof(func_infos[0]);
> +
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", ins=
ns, insn_cnt, &opts);
> +       munmap(mapping, arena_size);
> +       close(btf_fd);
> +       close(map);
> +
> +       return probe_fd(prog_fd);
> +}
> +

ok, wow, that's quite a feature detector :)

but if we take a step back, we really are just trying to detect the change =
in

12a1fe6e12db ("bpf/verifier: Do not limit maximum direct offset into arena =
map")

(btw, do mention this commit somewhere in the comment in the feature
detection function in the next revision)


which just did this:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21132,11 +21132,6 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)
                        } else {
                                u32 off =3D insn[1].imm;

-                               if (off >=3D BPF_MAX_VAR_OFF) {
-                                       verbose(env, "direct value
offset of %u is not allowed\n", off);
-                                       return -EINVAL;
-                               }
-
                                if (!map->ops->map_direct_value_addr) {
                                        verbose(env, "no direct value
access support for this map type\n");
                                        return -EINVAL;


Now, setting up ARENA map is quite bothersome (as evidenced by your
code above), but ARRAY with BPF_F_MMAPABLE flag also allows direct
value access, so let's use that to do the detection.

Basically, create a small ARRAY map (no BTF required, I think), and
try to verify a simple program that only does some map access with
fixed large offset (e.g., at 4GB - 8 offset). With old kernels you'd
expect this to fail with "direct value offset of %u is not allowed"
message in the verifier log (you'll need to provide a small log buffer
in the feature detection function, of course). But on newer ones we'll
fail on "invalid access to map value pointer, value_size=3D%u off=3D%u".

This relies on verifier log messages, which isn't great, but we can
adjust one of selftests to validate that libbpf does indeed put offset
at non-zero offset, as that should always be true for newer kernels.

Does it make sense?

pw-bot: cr


>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +756,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_ARENA_GLOBAL_RELOC] =3D {
> +               "Relocatable arena globals support", probe_kern_arena_glo=
bal_reloc,

we don't detect "relocatable arena globals support", we detect if
ldimm64 allows full range offsets, so call the detector as such (i.e.,
what you detect, not what for you are doing that).

> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..0aeb740a5f47 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *=
obj, struct bpf_map *map,
>         memcpy(obj->arena_data, data, data_sz);
>         obj->arena_data_sz =3D data_sz;
>
> -       /* place globals at the end of the arena */
> -       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +       /* place globals at the end of the arena (if supported) */
> +       if (kernel_supports(obj, FEAT_ARENA_GLOBAL_RELOC))
> +               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +       else
> +               obj->arena_data_off =3D 0;
>
>         /* make bpf_map__init_value() work for ARENA maps */
>         map->mmaped =3D obj->arena_data;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..e0223a6e4c95 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports relocating arena globals to end of the arena *=
/
> +       FEAT_ARENA_GLOBAL_RELOC,
>         __FEAT_CNT,
>  };
>
> --
> 2.49.0
>
>
