Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE341D23C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291927; cv=pass; b=BnT5/r4vdJg1a8ZLZP2BmgivybU1mia6pGd/OxHUhkA0l3YRcYfOspJnUYjqwjimcf1g8x8thaBX5z/g1KCp1BOzan6f8PG1EcPxXzGRKqDTfU2w70ZkJnYWsAcV+D6i937H/eDbXKjb/Vw9CwhuT3rmtDNQ/Q9b5PBc9uXPCzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291927; c=relaxed/simple;
	bh=QmhZDh4ySNDX8Q31EACXtFxHKrNArobCfR4y83+VFR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQkexPEYS4mWJ52uRyqbzBRJB2qAZbZGeUtYBjjMMw02KE7191s2uhG54sxd90a4p+MaGQVC+Z2kGvsGBLDsu+uR8sosSDJYPECIKw+g7P32BzI7KaHcCiS4R1qKVmUWzWumGPRVDUvJzYjOd3K7eqH1dwQRGQnzhTJQvgrOTI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5N9lnl2; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5N9lnl2"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso303714a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790291926; cv=none;
        d=google.com; s=arc-20260327;
        b=MORgptGJmSpTZwUNBIpP65hv0CYD50atgK318ECUNkSvfqImtO+Uy0NYyzRGfy7tD0
         pJl4KtcbZYgqo9WpOg4ykXTRa8z/FbcSfly8hfQihZIln82Nwr96GANjdVuU3j2rg86Q
         pTS82+Bx//Vyer5m9ZLA53NqY/co9+7f421U70f9nxSV5fUMrWTAkgyJCY80dW9sQ2MM
         YX79oHVv5ehQfKjMVNq88gWfcvlShrLGyqK41B4JIrk0A86e1fTrF16Ajgq+Wd83JZ07
         cBa74zAOJ0oAcn6h5odefqg5We5VbgEuFpuQFem0xblXrcFQt8Li3UpzLxxbjjK2m0WR
         XigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uxWc+jeVAMw82z+fQsCIZSxaNCFVi67xsWU3Nh4EvG0=;
        fh=FLd6JgKJC78bvz9uUBQxoN4rjy641h97g+CnETlClq4=;
        b=VVe67L+7YSe/75j+YfEpLHaAtKn84lJ8RzpdjI+3abag9a4fMW5spl/CTtExSk0t3k
         zSI6oKMsSR2oT4vvaK5T2itqdqC7NmNgKx+6kK1LsyyRedTRgDpJZFVHgnhOcW29FVVF
         nYeB44erfRvfjrJ692/sXO6tSWfP6Q5dQ0anxKvpoGaWJ5/AqyYr1LkG4vwXzjSC6qH9
         BGzRd9fzcQ07p5st6cM4XIx/NIjsfAlRJhaR9d/LaAZc/JSqAibROMAjM1mCpBD5J0+Q
         ibiRkVpFclTpJbzlROPFcZzQDnYBNOt0Evk8OpXQY4UKeRNHi7WESb0Z2R7QCMM6KrE+
         qTHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790291926; x=1790896726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uxWc+jeVAMw82z+fQsCIZSxaNCFVi67xsWU3Nh4EvG0=;
        b=h5N9lnl2x6oKnM5E2a7H8B9GyfppeDDgPOxCEg6NWwpSAvsSgEIOXSv7VNLqhYcT0b
         BdH1Dyzd2VzNW15Rt3aXixvQf7oJbdQhlrT3FkaWdkWaKJoNJ9wWVEWAA+bkR4IG2e6o
         87uV9ehiUzd72yyTHgEe2Z64//PzVjlhvdaHYwdq6bo83qWqLS7Y6tL5Y+jIrxO0CY3Z
         YOlJbrmfFREeLdZ24Q180llBlF1LIV5Hn7f8WGdKkeAQne19TYh5TtWOnnGQxc7L0+Qq
         dJdGpUXw7OSfEm1Cem/LWS4Rdra1g/WWWm34XgjoVEHWc+18OU7F6ck34tNo9CPEwpTg
         lcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291926; x=1790896726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxWc+jeVAMw82z+fQsCIZSxaNCFVi67xsWU3Nh4EvG0=;
        b=2QyYz2gtXDNDJoMWJ3g3PwvdKwgp4seby8/PE+JSiDcNn1hrVAPcIDNeco+9RDeO+H
         yxelJQAwt6qcXq4Vy4y+5PA9t/0zB1HiLatNNrx5QhYzsQCTDCKmK+ApHmI/f5DYNCvN
         Vj4d9NnmFHsV7V/lEweuWsdDRVx4L1DylxfY8Sdtf6NazEDNwhSl1FshskbPwQlH8TUl
         uckDQo0HEV9wF0ZDhsC2bAY5kaKnzMUt9yM3t3KMrg7gONpx1ABD/Qudx+AWiq+47R2S
         bbEA+XtCdCldx9V8GxmK1aiK9dhpVmCgdEMsCBUCccCNgHNlKJWFCgG83TPHQ9MAwApf
         qKaA==
X-Gm-Message-State: AFuF++ninVQcc7b98KhD3EQq3AoG1s29SdnY3DWAtg4SAh3nvKUXt++j
	wh7iKpCpH15z22VLM0X6RL+RyceIiIyiFnl9lV/COq42wKD9Bsa06W6aEBJ2wWtqv8PzYmB1p6u
	9EacFCUCNCwEYSDFVQ39jOcj0ND1z10I=
X-Gm-Gg: AYBFou01TnFnmP0xYElSebGBF3mlbQ3GWVdhdib6HID+iknwL4I6/zhJ+c+tew/Mvad
	xAYC62xtzBMzEPglrHbN3kM0feilGc0Um0701HqyzlxfA8+Qdm5DjwVv4+ZDXUtHDtpCd2xhPQE
	bsAFke9WFgJKXPYuWQCjZDZNDQ2B1ZoqmCkI6+ieuxq6/tExnjgmendM+ZUP/U/HFTZVUca3OcQ
	mKaWyq08+LFB1uswzwHR0UmYpgbCmRXOiTWsveF8sJl2gg5zF3AvCg5/c3Cwk1zSV5rSUvt0Nec
	WU2C8bC/LCy0V7ssKFgu/iXHC9698DCyaP4BymZmWPhak5rBsD7aNmQSBVE2CB/vBEpL0KjPG4o
	3aQGAhn6ask4Akr8vMgSSE6GHwnJOCGDsB0L5
X-Received: by 2002:a17:90b:3c0f:b0:39d:eda9:febf with SMTP id
 98e67ed59e1d1-3a098da4171mr4014390a91.18.1790291925614; Thu, 24 Sep 2026
 16:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com> <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Sep 2026 16:18:31 -0700
X-Gm-Features: AclHuK8sH4PXfH1LTBo5eSHOScrjWP0JmKlgbh9FqaT_UkyfqSDr51wTaVhUOUo
Message-ID: <CAEf4BzY2vgk3nrEY_0P4y=t7JzCi8+BdDZM4nFO3bxkXP8Ri5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> BPF programs designated as manually loaded can be loaded and
> attached independently after the initial bpf_object loading and
> attaching.
>
> These programs can also be reloaded and reattached multiple times,
> enabling more flexible management of a resident BPF program set.
>
> A key motivation for this feature is to reduce load times for
> utilities that include hundreds of BPF programs. When the selection
> of a resident BPF program set cannot be determined at the time of
> bpf_object loading and attaching, all BPF programs would otherwise
> need to be marked as autoload, leading to unnecessary overhead.
> This patch addresses that inefficiency.
>
> A manual-strategy program is loaded via bpf_program__load_manually()
> and unloaded via bpf_program__unload_manually(), gated on

forgot to update commit message?

> bpf_object__prepare() having already run (BTF loaded, maps created,
> relocations applied) rather than requiring a full bpf_object__load().
> Manual programs are skipped by the object's own autoload pass.
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 200 +++++++++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h   |  32 ++++++-
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 204 insertions(+), 29 deletions(-)
>

[...]

> -       obj->btf_module_cnt =3D 0;
> -       obj->btf_module_cap =3D 0;
> -       obj->btf_modules_loaded =3D false;
> -       zfree(&obj->btf_modules);
>
> -       /* clean up vmlinux BTF */
> -       btf__free(obj->btf_vmlinux);
> -       obj->btf_vmlinux =3D NULL;
> +       /*
> +        * The btf_vmlinux data is needed for manually loaded programs,
> +        * so defer freeing it in that case to the end of the object life=
time.
> +        */
> +       if (force || !obj->has_manual_progs) {


same condition as if above, why split into two ifs? and really better
to just exit early if !force || obj->has_manual_progs


> +               btf__free(obj->btf_vmlinux);
> +               obj->btf_vmlinux =3D NULL;
> +       }
>  }
>

[...]

> @@ -15375,10 +15431,69 @@ void bpf_object__destroy_skeleton(struct bpf_ob=
ject_skeleton *s)
>
>  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_pr=
og_load_strategy strategy)
>  {
> -       if (prog->obj->state >=3D OBJ_LOADED)
> +       struct bpf_object *obj =3D prog->obj;
> +
> +       /*
> +        * has_manual_progs is snapshotted once in bpf_object_prepare_pro=
gs()
> +        * and never recomputed; once the object is prepared, no transiti=
on
> +        * into or out of MANUAL may change which programs are MANUAL,
> +        * regardless of direction. AUTO<->DISABLED transitions never tou=
ch
> +        * MANUAL and keep the looser, pre-existing OBJ_LOADED gate.
> +        */
> +       if (strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL ||
> +           prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> +               if (obj->state >=3D OBJ_PREPARED)
> +                       return libbpf_err(-EINVAL);
> +       } else if (obj->state >=3D OBJ_LOADED) {
> +               return libbpf_err(-EINVAL);
> +       }
> +
> +       if (strategy =3D=3D prog->load_strategy)
> +               return 0;
> +
> +       switch (strategy) {
> +       case BPF_PROG_LOAD_STRATEGY_DISABLED:
> +       case BPF_PROG_LOAD_STRATEGY_AUTO:
> +               if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MAN=
UAL)
> +                       prog->autoattach =3D prog->saved_autoattach;
> +               prog->load_strategy =3D strategy;

not completely follow the whole saved_autoattach thing, and the commit
message doesn't even mention this aspect... why saving and restoring
autoattach if we can leave it as is and just ignore if load strategy
is manual?

> +               break;
> +       case BPF_PROG_LOAD_STRATEGY_MANUAL:
> +               /*
> +                * Manually-loaded programs are not supported for gen_loa=
der.
> +                * This is because bpf_object_load_prog is not called for
> +                * manually-loaded programs, so such programs are not vis=
ible
> +                * to gen_loader. For this reason, prevent calling
> +                * bpf_program__set_load_strategy(MANUAL) when gen_loader=
 was
> +                * used to generate a BPF object loader.
> +                * A gen_loader implementation is being called for autolo=
aded
> +                * programs and defines its own model for loading BPF pro=
grams.
> +                * To pass a BPF program to gen_loader, set the program's=
 load strategy
> +                * to LD_AUTOLOAD.

you are fixing this comment in the next commit

and the comment doesn't have to be that verbose

pw-bot: cr

> +                */
> +               if (obj->gen_loader)
> +                       return libbpf_err(-EOPNOTSUPP);
> +
> +               /*
> +                * struct_ops programs are incompatible with manual loadi=
ng:
> +                * bpf_map_prepare_vdata() bakes each member's fd into ke=
rn_vdata
> +                * automatically during bpf_object__load(), before a MANU=
AL member
> +                * could ever be loaded, and nothing re-bakes it afterwar=
ds.
> +                */
> +               if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
> +                       return libbpf_err(-EINVAL);
> +
> +               if (prog_is_subprog(obj, prog))
> +                       return libbpf_err(-EINVAL);
> +
> +               prog->saved_autoattach =3D prog->autoattach;
> +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> +               prog->autoattach =3D false;

keep autoattach as is and orthogonal to load strategy? if MANUAL is
set, there is no auto-attach and user will have to manually attach,
no?

> +               break;
> +       default:
>                 return libbpf_err(-EINVAL);
> +       }
>
> -       prog->load_strategy =3D strategy;
>         return 0;
>  }
>

[...]
