Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681113B3C17
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926211; cv=pass; b=ecXVliYUX/EEChZU6FLsk/6XXcYzYoxTl0gErIxuQGV0pw+juckQycQwSx27WTbhJuP4EF6lZu4Im2rJ2sYktwdqz32WVi4GtPJdP593lsthNtePW8rDdGyDhnl/AsP8a8dUHq2sjluCRB2SzxZVWs/WpTJJxB+5DfBTfBPv1B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926211; c=relaxed/simple;
	bh=DeKeHMN1EaZyILyPa3N3SlwUjqx+e3RWpW7JK3gJa1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guSmPQKyw0wuy0gPW3WkkF9V1LhHsZQNOhr1Pt9KLB9exIDLKSj3JAugXrmw1Ue4WNvYlfoOw4T/9DAC1X3IOb/ls65E8Jzy714mJrfrRNBmzeduKDqGh4M1nDC13x4jEkADqvWQ6yI6pbgaUAf3VJ05h7N8ysADo8sOCCJe3+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sw10kloW; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw10kloW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8111c0c7561so6431397b3.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784926209; cv=none;
        d=google.com; s=arc-20260327;
        b=Zs2QKAE/nax2jPYK6dy1q3Rd9ksNRtveneWnWlHQod/Q75Uq2qUoRMgm0E2woPdT0O
         qC7n3vzRbi7vyxlMrk3vVkohFnLeOMWUeefgGW6Kcpskb/LENz7CcLIPYUDNxz/Zwa00
         UOO7a78476spqvfYq0JAGRwcvUUhHSh+xf1h0ucDbc/qp5FVFeRdHPL9+Dv77GI3TYac
         7lojOD1eq0x9/NHIs3nEN+KMX9OgXEzCXwFaX1xTWqFdtV8y+frMTn9kPgasiK7dFJOA
         rpgsOH22ym67G4DwhJ7UZy6LZEiZXtFKlkfKBGco0tveF3RKsvJ92HXzUnI9ldkwBvqG
         QV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ruj+BsjsuAbvvaqwyPqVkAoHz0sZM0BQFx5c/y5tKvI=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=oBmr3Rjj4D1PygMUmt+MvuyJ5pk1QvUBPRBkS8bBowInDX1tP/3n2+QoNKGPuhpCH9
         MR0C1pMh4wBjg8GqZCLgBaF1hAkOITkPmsWiB8c8ys+5auNbduCXUD2MLARRjelGyqpZ
         TdgUkEBrtOdW7Mvrxov3PGCfij3GQTDpwctGdqV1CmjE8QXtyvdjyI8uUCvRzzW/fuTV
         Hk4pVhfeIX6JypgNsfaXj+DLo6RsZZcIMph4p4Vg1VvXPZFmgGXEzqVJ12zNVMDMpzXf
         AwI5MU3R0RbYygbvieT3pb+Ba0I2Fj8XCtkrqstQT5h696yskvxnj7a9Vf21oUr5MG6O
         vo4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784926209; x=1785531009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ruj+BsjsuAbvvaqwyPqVkAoHz0sZM0BQFx5c/y5tKvI=;
        b=sw10kloW+mnsSzf3meemBRq4Ft7zQWJ1H/J5+6hFnCl8khvZgmoMsnYRzLaPsqDsQG
         3/KEacr2Pd+Ua5MFiDuDA2d9/nkhLVSXKXIl24aPUJGMX4wHTaAe+v5MJuhGBZgpVv7q
         o0hkj7xtbX5qL41VTsD0SkqWiaCfIq0LwOtLzts30XTUTcH8tXmCIopgrcuA1pZ34Pr7
         C9+3VY9M7L6g1R6xrTE9VLJlynRMb+wA6RLOz8VVzF15QIjhT3eIis+BTg8MCR+KCnCd
         9RoDbv3D2w9HHjuXZ/24E4lOPkVjcJpcolM1R6bJ9ImIExQtI0y5Flc8cnq9uQR6nJWg
         Fxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926209; x=1785531009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ruj+BsjsuAbvvaqwyPqVkAoHz0sZM0BQFx5c/y5tKvI=;
        b=LNYHoq3MF7zU09X0A64k3hxsFseGmQHbIzTeVhcjYI87RtWA7jK0aAXOet3K6S/Jbu
         mzR8BcwV3laI3sDUIjzciMlVaVi/qO4llEIgfefxByp+D8GuICjyvf3gdc6wZM5t5zVW
         fqw61zXOEJ8pXcXyGuPI0bSRfZNbxnoNd6ig/pHrx47NP79ZsmjqdmCS8CNE01jXQyeL
         AqqxA6+91EkwIVzLdauSCDDHmNzLUvyryDgna4Mmn2hrRAy2GpSgipIuUmEFkSCsYwEr
         yf2FPt5ec0RGuUPv2yj5mHEYLNEPavTxbsyYb8R5++RCoEbEyOgfx6g6yasiEfDrFkO0
         Pw4g==
X-Gm-Message-State: AOJu0YwHdjY1kugIxNWSTjAd5lR2M/ll/dkNwK7kkavRx8jgM0r+cvLA
	dqHpIZUNXdHFg8psB6xsqB54a7rLBvChWXe7wP1e1shDlEKhRfzDFoNqpUQGVSEcM7SNTpFAwY4
	1uEC5ztFM1v0n8dapfbz5a7rpPzV5TL9Wv/29
X-Gm-Gg: AR+sD12Hsq2jNRVqW1RDHPDypnd3zXKGdB8erc6Ftw00f+RsKTIM/s3U3L50BiwjSo4
	bniK05ZErAF7LuYhAYjV/4+/UDoeXzTq3WeQ6VQDSx/aPqz9D2Qxh11iWDS+Uw9mzIFqzfazmhv
	FYoaMdbegER8GRxYGLKFZIFzK9X277AzF/0c24q+bjFThs4LzMyHnTSjSD8+9tM/3S3XM5BIsBC
	BqAIjfcLqITbi2I/j12itZb61XkWcuAu7BsFYVwWjEhH96eJaTRZLVZlj9pMA==
X-Received: by 2002:a05:690c:2610:b0:81f:47b5:d930 with SMTP id
 00721157ae682-81f69d49002mr163077b3.31.1784926209275; Fri, 24 Jul 2026
 13:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-3-ameryhung@gmail.com>
 <20260724192840.1BB2D1F000E9@smtp.kernel.org>
In-Reply-To: <20260724192840.1BB2D1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 24 Jul 2026 13:49:58 -0700
X-Gm-Features: AUfX_mz8jzGwCxLHOf1PMdUD_tm0LrUzqkkbW-3SbwaVJMTFOsrBQMivdalnSg8
Message-ID: <CAMB2axPaPthdQ-pVG0PV21Wzw=dgWnFdPqi5FuJ1EeAEde-P1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [Low] Multi-line comment does not follow the required BPF subsystem com=
ment style.
>
> Pre-existing issues:
> - [Critical] Pre-existing verifier panic when an array map is passed to k=
funcs like `bpf_wq_init`.
> - [High] Pre-existing logic bug allows mismatching maps to bypass safety =
checks in kfuncs.
> --
>
> --- Patch [2]: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argumen=
t checking for helpers and kfuncs ---
> commit 08bfe87a36be7126ec3db2d3ab4783e72b62e453
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Unify const map ptr argument checking for helpers and kfuncs
>
> Both the helper ARG_CONST_MAP_PTR and the kfunc KF_ARG_PTR_TO_MAP
> recorded the map pointer in meta->map and, when a map was already
> bound by a preceding timer/workqueue/task_work argument, rejected a
> mismatching map. This logic is factored into a single process_map_ptr_arg=
()
> used by both paths.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e8c76abbf76a2..a3429610b426e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8274,6 +8274,44 @@ static int get_constant_map_key(struct bpf_verif=
ier_env *env,
> >
> >  static bool can_elide_value_nullness(const struct bpf_map *map);
> >
> > +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg,
> > +                            argno_t argno, struct bpf_call_arg_meta *m=
eta)
> > +{
> > +     /* Use map_uid (which is unique id of inner map) to reject:
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the preferred B=
PF
> subsystem formatting?
>
> According to the subsystem guidelines, multi-line comments should have th=
e
> opening /* on its own line:
>
> /*
>  * Use map_uid (which is unique id of inner map) to reject:
>  * ...
>  */
>
> [ ... ]
>
> > @@ -12122,36 +12140,9 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_call_arg_me
> >                                       reg_arg_name(env, argno));
> >                               return -EINVAL;
> >                       }
> > -                     if (meta->map.ptr && (reg->map_ptr->record->wq_of=
f >=3D 0 ||
> > -                                           reg->map_ptr->record->task_=
work_off >=3D 0)) {
>
> [Severity: Critical]
> This is a pre-existing issue that was not introduced by this patch (in fa=
ct,
> the patch appears to fix it!), but could the old code crash the verifier =
here
> if a BPF program called bpf_wq_init(wq, map, 0) and passed an array map
> without BTF for the map argument?
>
> Since an array map without BTF has a NULL record, evaluating
> reg->map_ptr->record->wq_off would result in an unconditional NULL pointe=
r
> dereference, leading to a panic. This could be triggered by any user with
> privileges to load BPF programs.

[...]

>
> [Severity: High]
> This is also a pre-existing issue that was not introduced by this patch, =
but
> did this original condition allow mismatching maps to bypass safety check=
s?
>
> If a BPF program called bpf_wq_init(wq, map, 0) with a valid workqueue bu=
t
> passed a mismatched map (like a map containing only a bpf_timer), the
> mismatched map would lack both wq_off and task_work_off. This would make =
the
> condition evaluate to false, bypassing the mismatch rejection and potenti=
ally
> leading to type confusion or memory corruption during runtime callbacks.
>
> > -                             /* Use map_uid (which is unique id of inn=
er map) to reject:
> > -                              * inner_map1 =3D bpf_map_lookup_elem(out=
er_map, key1)

Yes and that is why this patch use meta->map.ptr->record that is
already verified. I can also separate it into a standalone fix
targeting bpf if needed.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.14=
58271-1-ameryhung@gmail.com?part=3D2
