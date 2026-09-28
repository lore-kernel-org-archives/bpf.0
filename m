Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DF385D68
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620418; cv=pass; b=XE7ISXV4EDb68ABlgIf3c23sHoTxSPvFzYppU+jekbPRPkIvEe1pYDj7vzGtngtPsbzpTN7dYLPOddZzFWqhF7k7zWjFoXB1NzMXsq9VGwPRBfAWKqKpguPSlkJ+ZH4hDNhRN70QbrUwzACcndIJDZ1OFHrLRpTVFELDfRD83+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620418; c=relaxed/simple;
	bh=t0yDPJvdEtGqTqYBpAtdipUVGNWr+/cPQ70R+VoF7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcHdffSU9TNMTHqnrxA4HVlSAU++jYCpCOG0uo29EoujqbkLqxq2ESchpDEkRZU3o2P8yzsKRSN9NHYlJWd2qs+XwgF3p1erICPCfjxS3N2buA2j/rBtSAffP++IX/NIIs0EIC9oke7sNusuSNb8sCd9+qfHqEG74YGJVCxYUB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfgrthQ5; arc=pass smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfgrthQ5"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4938dd40902so1954518fac.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790620414; cv=none;
        d=google.com; s=arc-20260327;
        b=Ih/oKUmOXSv2GMYdgLXILI+4+XeCcFI996SAwZSdOeedN4F7/dwboRlJjRhBZD6SyR
         30MKOeNLPToZEiLWkozNTzc8ax81ZgupQOB+eM1Jwqfn7CTN/WuRAhYXiB0Pn3HecCda
         hBok3tdej+cFGGoRRuVqfCb8w/2f3bU8a6oBGRT9nc4S7lDaXn7LQIaUlZfMXRU/x7Zw
         NJswKCCvV5ADE341Sev0G5AJ4chtdGVD1+i9PZVVFlroLK9R6Gpx1XcOA2rDistZiaV9
         eY9uJnjUUV+Y6UA+Piy96GwfrDPZHw5891u7EenquEnPQ77OfTejQdZ9tTEZF5UixSWy
         DxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GJv0YrgM9Mo4NiT5Hn/XU5a/l8or40BlSM4zqfmb43I=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=o0CXwqUidiYGkCWFUbNj6e1+zxpdh/W9w80EzCnVj2/GlbMygv8gFOOPgg0GeFsvZN
         zu3xkM8KNnhQOc1rkZio4VOuEO/cYeIAwVf9XsMRfG9bGysYcpmd1fgL7oPJHmOtqfmq
         /C5Ff6LIfGWExMSX0KYqHJ0qFF8EuJLtgCHrZKDk8P4gqcOE3D19WsJD6DZ5ssfgkiog
         Vjh1A31k6pJImIoOYDf6FR91tWyhBH2x2SG9CkCLBSK3s8p3H1L8yE2DL3PEbzZIK8Oa
         zXkUPs7bmzJ8hI+a5v6wZam8jAbDJ4KUGsW66tYkuvx15c7vIjLt+sXK7qHlfboUTw5P
         fXkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790620414; x=1791225214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GJv0YrgM9Mo4NiT5Hn/XU5a/l8or40BlSM4zqfmb43I=;
        b=YfgrthQ5PEvqG20Xz2wMYszmKlx7/zouHyfkO0XXXoU3bYARDaviQAQZJIuvXv1JIp
         ltViwDAvCogv+a6saS6QkfTdTPBEtMqjQbSMYKQjjjwDEXs1i8ODWEPjVEpRPUOMDsYD
         +MMJUVUXVrYrXBW2CjXh/xiB68ixy+U08S/wEGOAHD/LLGFbaCEkpPGb1AnXZ+Tdr62F
         Aq52FGjxswHoCJAYyT4SMpYJ5o3HecdIOnIxNLIbCj3wEp1YSKnw1A+ovxtvtiyXLuzA
         ASJA+74xTMCtVwxGEsSkcJ3dpvYKhy6b4oT5wtnfXBoO6VfQWEwaf/TSVBqZwoyMjCVS
         FnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620414; x=1791225214;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJv0YrgM9Mo4NiT5Hn/XU5a/l8or40BlSM4zqfmb43I=;
        b=QMwhb+gJfI6r0mMbW3vzTR2nXlrG4rxCSHFb7dQIVmPGd+KmAZc0V4F9nIkJF7vQUt
         3ci7t3eCQ0M4rRsu9UOfeqibeJbTYqfILcgLsNXNN/2HfvN9O+N13EwEouOyf50I4oiM
         dH45bmw8avi8XhRW78HYo3tdN83MRjnf1y8HJ9G4yoPj8SweAp2ieATlSFSD3lLdKusu
         dmGCbsoFnUV+Er/eri+dvvYNcsZ+zsOmZWbJc5vUm57SVd++wbOpkbF0S3YhToWsWLkx
         WH/8GCjQCRVeITE+CT2is3Ri2KxW5o1i+vFBdq4ugTPR+Xvd1DMRXiIAxI/7qlvf9ES0
         liOg==
X-Gm-Message-State: AFuF++nI9+zOWxodb2BGYAx4n+AFW+L/xRMkQj+HzyixkxX871bbZVzt
	HkhrZOhsPLzdazIXyo0fIZIDCCK0ZF61ZVqgO5Gnu+DO9zYz3pWRQ9TxZlXchtBNzdlvT6bh3Dz
	cmo8qgLk68tVxg1C9hrF/ERMgHI4hyoM8bQ==
X-Gm-Gg: AYBFou0GmJjVnpegJlY9x+l6NAebXPXvAUDA6NxUklgXMzp4WZt5mpS3MwthzUMI6FL
	FefC4PyS5ipvePDL518PXJOMizq51bwJ6tt/NIAkEraAJDuHYLPCxg2BDM0q2LwisEn/gRnbD4+
	JTalZSS4J0pRtrCyYsMs9rZ/KSiSoz24OVQIrM1rZDIiDamNmdGOJj4ywGr899mPzaglTU59GIu
	vFBbftiplm8jWK290aTdJRugBAoqREXp66LzTKHwlUI8X7RigbVAjKR3yWeZmN9YEwIoKXEbgG9
	PTSF76ThBqfAUEd6f4VNXs+1B3Rd5fe2qSbtSCEnpGWiIsVfNjAKWAE=
X-Received: by 2002:a05:6808:50a9:b0:4d7:22cd:51cc with SMTP id
 5614622812f47-4d72aa5b173mr17373947b6e.35.1790620414186; Mon, 28 Sep 2026
 11:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928181414.644158-1-ameryhung@gmail.com> <20260928181414.644158-9-ameryhung@gmail.com>
 <20260928182823.0EFEF1F000FF@smtp.kernel.org>
In-Reply-To: <20260928182823.0EFEF1F000FF@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 28 Sep 2026 11:33:22 -0700
X-Gm-Features: AclHuK8HINrwTptjbFI71Pm_-wCViCSyK26VqdhJFYXA3tuWxpYFVyBj9WHNrwQ
Message-ID: <CAMB2axOEyuY67huG=POzf4ummgSFcQ-sGYX6-0kOXTdQEYfaLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/11] bpf: Check subprog dynptr arguments in
 the common path
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:28=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] bpf: dead code and unreachable diagnostic in process_dynptr_func(=
)
> --
>
> commit a02951e0de8834e87c650bf3681861699a204241
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Check subprog dynptr arguments in the common path
>
> This commit routes subprog dynptr arguments through check_func_arg() to e=
nsure
> register types, offsets, and dynptr states are validated in a common orde=
r. It
> also updates a related selftest to maintain consistent failure states acr=
oss
> different compilers.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index efb20e50c974a..075002f6a59fe 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10883,7 +10883,7 @@ static int btf_check_func_arg_match(struct bpf_=
verifier_env *env, int subprog,
> >               nslots =3D btf_arg_slots(t);
> >
> >               if (arg_type =3D=3D ARG_SCALAR || arg_type =3D=3D ARG_IGN=
ORE ||
> > -                 arg_type =3D=3D ARG_PTR_TO_CTX ||
> > +                 arg_type =3D=3D ARG_PTR_TO_CTX || arg_type =3D=3D ARG=
_PTR_TO_DYNPTR ||
> >                   base_type(arg_type) =3D=3D ARG_PTR_TO_ARENA) {
>
> [Severity: Low]
> Does routing this through check_func_arg() render the register type valid=
ation
> in process_dynptr_func() redundant and unreachable?

Indeed. I will remove the redundant check in v3.

>
> Since check_func_arg() calls check_reg_type() before process_dynptr_func(=
),
> the requirement for PTR_TO_STACK or CONST_PTR_TO_DYNPTR is already enforc=
ed
> earlier in the flow.
>
> This makes the custom error block in process_dynptr_func() dead code:
>
> kernel/bpf/verifier.c:process_dynptr_func() {
>         ...
>         if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DY=
NPTR) {
>                 verbose(env,
>                         "%s expected pointer to stack or const struct bpf=
_dynptr\n",
>                         reg_arg_name(env, argno));
>                 ...
>                 return -EINVAL;
>         }
>         ...
> }
>
> The selftest updates in this patch seem to confirm this, as the expected
> error message is changed from this custom diagnostic to the generic one
> produced by check_reg_type().
>
> >                       ret =3D check_func_arg(env, arg, slot, 0, &meta, =
env->insn_idx);
> >                       if (ret)
> > @@ -10912,15 +10912,6 @@ static int btf_check_func_arg_match(struct bpf=
_verifier_env *env, int subprog,
> >                                       reg_arg_name(env, argno));
> >                               return -EINVAL;
> >                       }
> > -             } else if (arg_type =3D=3D ARG_PTR_TO_DYNPTR) {
> > -                     ret =3D check_func_arg_reg_off(env, reg, argno, A=
RG_PTR_TO_DYNPTR);
> > -                     if (ret)
> > -                             return ret;
> > -
> > -                     ret =3D process_dynptr_func(env, reg, argno, env-=
>insn_idx,
> > -                                               arg_type, &meta);
> > -                     if (ret)
> > -                             return ret;
> >               } else if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID) =
{
> >                       int err;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928181414.64=
4158-1-ameryhung@gmail.com?part=3D8
