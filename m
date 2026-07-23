Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0B388E44
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825586; cv=pass; b=efwKDFMSGtDgn2OpdF4stwRQ5+wa8OOVDiCv033r6RY23uvnjuBgPt4Vc5umNGxmvasSglbv6aso81l+1MN64yuV7fY9wHsuMioQi51ubIY4kTmgc0q6wL/Sb8r1DT1icqlFsNFMWhM3vrNsjpTAMQW60JWeUuHG6bVCBGUEoyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825586; c=relaxed/simple;
	bh=eECP8AmlTL6Y/rafqk+Nw4dJNBD5MFOMRhH1chD/y8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hro436X9sipyqimDigAMqzSVM8uE5l7Amb/VTzTgNohD9a/QsDIfgEjC8zhbxn6RI6wrYTOPTezs6e234holAHROaSmBnMNSjMKh3lPf99fLQNrgr5POhiNGtqkqw8oM+9wqGI1r7tAQQnSYPDC803s2btrYFySZlMeC1AVaEfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmz49B5N; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmz49B5N"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81eff3ddba4so7093897b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 09:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784825584; cv=none;
        d=google.com; s=arc-20260327;
        b=IfsQYTyYjr0smQwL9UunvADtJhpxz44emjo9yWB3LtzQiyZQUVun5upXoPDt8gu13a
         hUvc3usPZdWOB4HETs2rEzLKFwUJA70rR2WTuvnzqLKxuzpIvErxqsovxpgYZ2Cx4l44
         uP58GS1oeEeHNMbDpiIYbfgCpgpEa1GESRNsrOPiUReYy1WeNIA/am/sS0jgAGtwyb9R
         DmDRlrjriUoUjSPVhtnL/B8aAQ+rZO/j18obIeG21krklpmML4cFZwOWYVWUhC7g/RIs
         gGtdVhHbER9Oy+OWSlj/A2w661aBvgvVQz+KThckXiTiHrNtoXknglT1wZDOp+R0Y6Ie
         5Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QFlS/DgVG0mBli/C45AnzwYLezZwdHd2vepLVL+Pp3Q=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=FdPZl+FTjvT3FhoM2oIR7KwfZGdwGEIUtcQxUsaoWwpoWnX8zYJyk3iG7pdGV9InH9
         K/0Kro9vI3BhA4UpDdlrI3djwTjSURLlcI0opBs66RAb8bLCxrwtX1UDt6W0VXXmX9ul
         lYxwuKFd+L1q6azkTvNbeYbTWT23LT/ko4am+w0u52rEovbycz2Rk2AW6h+2Qtf2vZcS
         HCojrkEZUgY+nYnxP0URTHDtRnuXk5dkNGQzdh4oZxO1M7QCPnhmXnNb+spi/+B9Udji
         jhp4mIPl1YcRkRq/fGFPEeHbPy9EFUsCf0mXqeo1gbee/xhlfIFu3xIJHr0IhVb+qVHn
         CXEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825584; x=1785430384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QFlS/DgVG0mBli/C45AnzwYLezZwdHd2vepLVL+Pp3Q=;
        b=Pmz49B5NoqrmemZ7C+xqPF10x7jFEHxw37TF8x233qVGS47rK899fNbKxaV99sqyGM
         Ds32hRTSBXpL7tYcjrmEI02dYTnJaVC6xTCndIryIVL/QWkK+5XMrq6YdL4FgB0kEMPf
         bzuzg49RYP5d0bS/2HfJaL8bthOfwBuazrQrmY+vn7GsJN0WtDm+Thsy5AWQDd86dC2t
         E3qYAxSW/5RJnsmkvO5rPwYO3ylZJAcMVlG00h8/rDZ+m8dCbOQjqImxhr8mbAqMhCNv
         7cfema131TE2Vm83bEUm1VgUvs0ARP6QRcAsUiZer1izKpayxgMz6+mAxHjwu0qcEMgc
         H8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825584; x=1785430384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFlS/DgVG0mBli/C45AnzwYLezZwdHd2vepLVL+Pp3Q=;
        b=geVKaTUjUuJtLaMAqREMhHkrz1p4AQBySyEokuf0ziYx2iibkDZxXn4GS+nV1a3qv1
         g3m+MpVk/MZuQgJfmr4Fu+3UfoiAGAfY+vN4wKDB+7rjg79WreqfJiMB6uKdIKA7XV5k
         kFQ/Wm1Z3MLPckP0imx603Ffxj8UC6aWFe/DaE0K1Sblnkxl7kyp5OhwwR/GE4Et19Vb
         dleJHIN1O6mMbtcJJkCgaMRuPJ7nhlRy0qGGGRInBkysS0IaKhn/WrIrX5X9GqAsvBCz
         1qtOLchAWyItxpW6t3dKl86HRHodhnZcBoHNArrp+NO6WRIncV3X2wN3XpCWmtCzgcC9
         3Y3Q==
X-Gm-Message-State: AOJu0YwoILPBTouZubk39+G2kv7guY4SOTHkJ6SOwLfJxZOM7/v4yO2A
	DXT+JwuRBxMxc9evy50GFfjXJi19xtFd/9SBPzZ/z1KbUn0LpQtL9fuqbpBiTqSQot5bkPXOCvq
	RMVh2RnYqvP/E84yyNhaybnXIdMaAeKM=
X-Gm-Gg: AR+sD13K8MhmdQlabvzm0thSjVxJU/ZUBHaP5y3rTXRifnz4fq9nM8nHAgGs+x0KWKN
	pF9ycF6I5DuRJlnWNgNn5svQehv/7CiNADndCUrns2lDvF7lFRCGYM4/uV0/hOmQYghX94QkZks
	yvOozUtW1+iR9cRAxb66Kgw61HPWFmnMGG9UaNH2ej2pgadj97riRH38ace0rQ+3RDnlhaqUxG4
	OIyxYwrdybzD0JW9Lwz2luu3LCkE3HpyOepDyiwl+ED9ZKsDqD2pTRC82hBQg==
X-Received: by 2002:a05:690c:3388:b0:80b:9114:3b7b with SMTP id
 00721157ae682-81f4c1bf05fmr11795357b3.17.1784825583783; Thu, 23 Jul 2026
 09:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-4-ameryhung@gmail.com>
 <20260723053502.B40831F000E9@smtp.kernel.org>
In-Reply-To: <20260723053502.B40831F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 09:52:53 -0700
X-Gm-Features: AUfX_mwJdOqs4jUEMIYvLOgaaNieUoE9IjpoUFhEvPc09qaAKnvjT9cjXGiDALc
Message-ID: <CAMB2axM-tZ6OCFi3MwE28Je=3HLYbrsjyMSR6Hs-KyUNEe7nKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/18] bpf: Split kfunc map argument into
 __const_map and __map
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The newly introduced `KF_ARG_CONST_MAP_PTR` logic fails to v=
erify that the register's base type is `CONST_PTR_TO_MAP`. Any register wit=
h a non-zero union aliasing `map_ptr` (such as `PTR_TO_MAP_VALUE`) can bypa=
ss validation, leading to severe type confusion at runtime where user-contr=
olled map value memory is treated as a `struct bpf_map *`.
> --
>
> --- Patch [3]: [PATCH bpf-next v1 03/18] bpf: Split kfunc map argument in=
to __const_map and __map ---
> commit 2aa2cd575b3d4be283e92e30e814910f54fbe0cc
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Split kfunc map argument into __const_map and __map
>
> This commit splits the kfunc map argument annotation to avoid type confus=
ion.
> __const_map indicates a verifier-known map, while __map indicates an opaq=
ue
> struct bpf_map resolved at runtime.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bff51aff25579..0ba0de8eb8fe0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -12164,6 +12168,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
> >                               }
> >                       }
> >                       fallthrough;
> > +             case KF_ARG_CONST_MAP_PTR:
> >               case KF_ARG_PTR_TO_ITER:
> >               case KF_ARG_PTR_TO_LIST_HEAD:
> >               case KF_ARG_PTR_TO_LIST_NODE:
>
> [Severity: Critical]
> Does this skip the is_trusted_reg() checks and leave arg_type as ARG_DONT=
CARE?
> Since KF_ARG_CONST_MAP_PTR falls through to the break below, it seems we =
might
> bypass pointer type safety enforcement here.

is_trusted_reg() is not needed for KF_ARG_CONST_MAP_PTR but the check
below needs to be tightened.

>
> [ ... ]
> > @@ -12371,12 +12376,16 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >                       if (ret < 0)
> >                               return ret;
> >                       break;
> > -             case KF_ARG_PTR_TO_MAP:
> > -                     /* If argument has '__map' suffix expect 'struct =
bpf_map *' */
> > -                     ref_id =3D *reg2btf_ids[CONST_PTR_TO_MAP];
> > -                     ref_t =3D btf_type_by_id(btf_vmlinux, ref_id);
> > -                     ref_tname =3D btf_name_by_offset(btf, ref_t->name=
_off);
> > -                     fallthrough;
> > +             case KF_ARG_CONST_MAP_PTR:
> > +                     if (!reg->map_ptr) {
> > +                             verbose(env, "pointer in %s isn't map poi=
nter\n",
> > +                                     reg_arg_name(env, argno));
> > +                             return -EINVAL;
> > +                     }
> > +                     ret =3D process_map_ptr_arg(env, reg, argno, meta=
);
> > +                     if (ret < 0)
> > +                             return ret;
> > +                     break;
>
> [Severity: Critical]
> Is there a missing check for base_type(reg->type) =3D=3D CONST_PTR_TO_MAP=
 here?
>
> Since this breaks instead of falling through to KF_ARG_PTR_TO_BTF_ID like=
 the
> old code did, it looks like any register with a non-zero union aliasing
> map_ptr (such as PTR_TO_MAP_VALUE) can bypass validation.
>

Right. The check needs to be tightened like below.

-        if (!reg->map_ptr) {
+       if (base_type(reg->type) !=3D CONST_PTR_TO_MAP) {

> For example, could a BPF program call bpf_wq_init(wq, map__const_map, fla=
gs)
> and pass a PTR_TO_MAP_VALUE for both the wq and map__const_map arguments?
>
> If wq and map__const_map use the same register, process_map_ptr_arg() wou=
ld
> verify meta->map.ptr =3D=3D reg->map_ptr (which evaluates to true), and t=
hen break
> out without ever verifying the register type. This would cause the kernel=
 to
> treat user-controlled bytes inside a map value as a kernel struct bpf_map
> object, potentially leading to memory corruption.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D3
