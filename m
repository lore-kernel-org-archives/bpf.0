Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4793115AF
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034263; cv=pass; b=hyperel9IaetUERLiL5dDH2hkJrr8X0DFoGLtxgyM8fV/TFtmZRwDpmp2N67jnR+NTwEMxw9D57sWyx2fwzIhOc3Df9VpCYkUgGPWITpL4QqgCHrY5FTbuPOpZ7J/X/kgoFNOltLr+d1AuM6vHhN6v2FgQZWfj/9d8JEbcdMnPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034263; c=relaxed/simple;
	bh=wdWMLiYPgfptHm+cvwHI/DzZ3cBDYJECWExqOs4SPCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVXiJvZ1b17Mx0vrjXNFPLiPg/SPBPTaGafL9ZIKTqBpuvsixwXlk2B1asYoEvXcHvg3t8CFJdj5qzLxbZs4bVOXO2Bl2ceMpl/24/S5A37mVO48RriBXAj1JI8e6nZe+Y+CZRJaNmX7IfeeNZ5+ofng+XKH6Qm9YnJeed1oOn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMPHLtgr; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMPHLtgr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8114a4542b2so35236947b3.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 09:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786034261; cv=none;
        d=google.com; s=arc-20260327;
        b=o2kZDR6qlPJwvXtEbTDAbUdP3+I+mkvfb5mrdCH8ixK9lglM96CB4l3XZeAPdKyl6+
         7WP1/sbN114iiKDqGddB0d12CYQ9VPFLdACspq0eUpabfEeYsaUncJ62epzQjx7gNTZd
         RbC/33VDKLf/2d+mqOE2Yp571AC20oCgtQKQEh/+yST3srBapqf/IELhe2ou6kqT95vi
         HMeg+OyoEEkUTlruMHrAhkRDNsdXhLNVjBIgzSy3Ylj+sQcBr0TitUmLp03fYDiDyyYF
         k/ETScz3b27uy72ilgYI70xy6RKK4syAcds83ZJ4CklGValzjk7bVutiYsouM1EYKkgB
         PmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gvzVMVnmOSeWHJNvMQp0ohnwPh1G5vxzMj2f2mVKW2M=;
        fh=B5cyw1yRIFuY1K+xO+VoEqAhNWQz2KjO7/ov3WrCuBU=;
        b=rIBG1b+yxsXemTbIUH40mA9bAm/NQEbLJ4fDGHcC+s7AJgE0ySeM0mrFS4PWMC0aP/
         WA2eZawsCOBl+cmkScAAxYzNJa3qCGl2RINEAr5DWaeor45BNDyOCKnZP3BJA8aSQg/m
         JEo+40/CVUULbs31K7AtuAenHMyNYnm4GRMsSBr6GCzS1K9VXssaTxuFLUC/UKPXUuQS
         EIgPC+ZTNl3oWn4xrM0dkPzlR6SYnS5cDR+evUGJJ4j/HUTroukX6CBzoWwF6uO4tNRY
         kk5DjbjAZHGBmCvF/ePqQNLUcnPfilrbrJga3a92kZc/QD2zFE+uKl7b8Kdz8hNS/0DB
         fuYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786034261; x=1786639061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gvzVMVnmOSeWHJNvMQp0ohnwPh1G5vxzMj2f2mVKW2M=;
        b=iMPHLtgruz2LBMc7hlRR4cvZ50/thsB143XrU/hnf3fGARCRMSFI6Snhcqbmxnd7VN
         VHlnXu+XGG3NkdyrzmlFIsI2zOzfY0rv8RblTuuHs0HRhAdH+83jHw8TrohADXVLGRK/
         3VdeOZKYmoTThYwaqHCxh+zMscdZ9g87OXA8/upDgm1bBUTjIbyyqcaClzNrj7bA9hUO
         69iFGiTHDVw/Y1JdiaElFdLgPGnsRsgMKIs6l2U+2H6Gj67JDDOFyncuiP1j7vOSesXY
         XraYXKRoELsQRmNl9w7rgZghdcwyBezgebVT62BvoSbix2JSRhW8NDbHFeMjSZuy2t06
         2Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034261; x=1786639061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvzVMVnmOSeWHJNvMQp0ohnwPh1G5vxzMj2f2mVKW2M=;
        b=qkPL9WlZSLjBra0fj4FKpFgVYi7QPvWbi7n0w986q6lVjITXjQTHG5KGYN7jPM00gB
         sJp0+PWKQrmqR4L41xmzae2pYXCqs8ST1i7CxeIllGDcRyMpryQXQG5I/qCpSnwCVr2G
         Czld77YozkUoXC7hYZcrVFXTp7/bY2q8zy268n7BUoj0EqBtFfMPyPVqzGSU0PuYWj6q
         OE41TxHU3o8cVAlmN1ZgTM38e85XSZdNQ23QZ8i2CfyL+mVxgN5Y1byYU75R66V9KN9E
         JBWTqtCRAdoGllkqATgafQXb/hSHrI+02MzznTMICK4XM6OIZ9RCPw2lSzjLvatqF1pL
         8D/g==
X-Gm-Message-State: AOJu0Yz80SKJXr9Y6Rjby409jxZVxZ3ebA2IprqZWO2ilZZfBiKWxZoI
	8NC/bPNNfS1T9YbnuxzbCxrCNIEBZJTtXeQy+CYZsJWM5KTpGobW2qe34dxJTX93Qvm+UP+LnCf
	J3Ia44z9gdsoib8bn77NOwzNy0YL5JN4=
X-Gm-Gg: AR+sD11KkMh/61DbgDgt47rKx0OuizH5IEpMY47uWCC4gE2dgDBCf613zGgKLxcgDHo
	SB+6dEXfnoD4MVa9knfNhlPmlj62aSbt08CqLIgcyUBi+ETadB8iIRWZ39cB/WFwjiDMJbMNOVe
	Wv8Gw5MHt56oSqcztsCa/M7bfOQRUrW3Kgy7u8idfZWug701bS01SmZk8Ryhbc9uUgX3JxTcjF/
	7OX0zffYqaaJcwnJtmwYvollF4bwBfaUI1la/6HA9s2ZSOJ1q7Q20sr6OC6m4vcoQmLdxKE/Esu
	fioe+IuwTODDYOdLz7XXRS1sYXUKrIaA7SAE+tC2kPDx
X-Received: by 2002:a05:690c:6d86:b0:81f:238a:1709 with SMTP id
 00721157ae682-82024f1a9c1mr99304967b3.34.1786034261417; Thu, 06 Aug 2026
 09:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805210427.3218326-1-memxor@gmail.com> <20260805210427.3218326-4-memxor@gmail.com>
In-Reply-To: <20260805210427.3218326-4-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 6 Aug 2026 09:37:29 -0700
X-Gm-Features: AUfX_mzzT9WnmVJY0eRFPTwfRK-C7b2CzXjfkLMf4W9G1GIS7UouN0oCriyRk8o
Message-ID: <CAMB2axMu8LVx=vFZWQ8tc3sY5FTegu3kqF2BhFnRMiZKfYm_Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/13] bpf: Collect kfuncs after resolving
 program resources
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
> The kfunc descriptors include argument prototypes generated while calls a=
re
> collected. Some argument classifications need program auxiliary state der=
ived
> from referenced maps, such as the arena associated with the program.
>
> This avoids a footgun in get_kfunc_arg_type() checks where we do
> validation on whether program has prog->aux->arena and it hasn't been
> resolved yet.
>
> check_and_resolve_insns() records used maps and populates that state. It =
must
> remain after bpf_check_btf_info(), which applies kernel-side CO-RE reloca=
tions,
> so that instruction validation and the program tag observe the relocated
> instruction stream.
>
> Move only add_kfuncs() after instruction and resource resolution. Subprog=
ram
> discovery and validation remain before the full BTF phase because that ph=
ase
> needs the complete subprogram layout. Add a short comment describing the
> resource resolution phase at the call site.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/verifier.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 24b163c2bd63..b62e77949542 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20344,11 +20344,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>         if (ret < 0)
>                 goto skip_full_check;
>
> -       /* Collect the kfunc descriptors used during verification. */
> -       ret =3D add_kfuncs(env);
> -       if (ret < 0)
> -               goto skip_full_check;
> -
>         ret =3D check_subprogs(env);
>         if (ret < 0)
>                 goto skip_full_check;
> @@ -20358,10 +20353,16 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>         if (ret < 0)
>                 goto skip_full_check;
>
> +       /* Validate instructions and resolve the program's referenced res=
ources. */
>         ret =3D check_and_resolve_insns(env);
>         if (ret < 0)
>                 goto skip_full_check;
>
> +       /* Build kfunc prototypes after resolving program resources. */
> +       ret =3D add_kfuncs(env);
> +       if (ret < 0)
> +               goto skip_full_check;
> +
>         if (bpf_prog_is_offloaded(env->prog->aux)) {
>                 ret =3D bpf_prog_offload_verifier_prep(env->prog);
>                 if (ret)
> --
> 2.53.0
>
>
