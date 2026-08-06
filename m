Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B17420471
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033786; cv=pass; b=pkDoiVP2eNfr9HIZWvSYO25Yp+byDShlEmTsxSq5hG7i1+UH42NN42dw3EeEx705xoDFMAXU2dUBOoJ5VktWh5g+tz910Uv+31e1ZhJuKx/rLP/y/8VaeKf2RJz5blKRQSwq2pQUQwBRax+tEfAflKrNFopIkAIvDdi4QFCIktA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033786; c=relaxed/simple;
	bh=6jY3hCj4bPWi4E+giMIaeH9vXY0P7eDn/bZymZFzSHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkVITgzNcWlGQVIeTZOdIHUVuZq0ygyp8DwGwflZBd2Bz6obONzzwj8AtX7Fs+2ZpcijR6EOho5HeFKvWrKC2Q9bSCHtgY9jFa/PmL1hO0B8witrnbPYzO5ejajpqpboCfODZv014Dp0y+PZBePInfQ27atH65FmfEJQAJKUqAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1sLDMYH; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1sLDMYH"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8114a4542b2so35083337b3.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 09:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786033783; cv=none;
        d=google.com; s=arc-20260327;
        b=JwMwzD5uKnT5VbqJvzMCakY3V4NLeLwyOURsMuV9cn36266jV7bkUSPOtztJCE05u/
         t5vh86GV47RHroVZyd4sYrAwbZJzLXD2RR+n5YuCeodvRPj5HgZIhKHfUr63NqWZTy8L
         A+L2VOi5itig/SoDyjaTBlPOs4pl+ZHi8AACC9FXNdCPTn09nDVVP1ujlUd8pHd+x3f0
         w1b9P5oU5duxHBOgt79fyCIPSZiLCcPheMqAwU4SQlaO1YpuBtTNNd6OEBHekzeHzgNe
         9T7gRo/X1OVS7lbC1l1j9OnqOTunWKIP3W8iM0BrZWqFQNvTMHh9DPFIVuZe63K1tmq+
         qTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ka0tDf/U90sg/zv0u5TmF/tXCBFGIBLufU4BZIvqO1U=;
        fh=B5cyw1yRIFuY1K+xO+VoEqAhNWQz2KjO7/ov3WrCuBU=;
        b=n5yBsC59HoaH1I4TVcKZge54JARJ9PvQAC6pduanstUMZYJtYEcVN8CdouegbpGvUN
         PECVjgj/oz9uFKbz4l4TO7GEu1cvI03f1cYmWLtx24RyhaTgP+54CUxajfmo7gl3D7EK
         VhX4ujdiu1VC3iuhyMRP16eJgYQSA9G6LoBtfjmFHX4bupAKoVxSGfI9O0+CdV3FFMww
         g0P9Amy+YkcD4zir1Qqvq5LslMXHQ0iADFUJeHsdA1ZG+NtODI3H6ZbZEUMp1Mr/y4vt
         BOSk2TA7l9LOhZq31k0nA+mZlQ/bWdNAKfpqSSLv37pSsUOW+VUZOoTcW8Xvz266sAD+
         +/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786033783; x=1786638583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ka0tDf/U90sg/zv0u5TmF/tXCBFGIBLufU4BZIvqO1U=;
        b=c1sLDMYHZ3M9XNMNFYohAAhzyBKLa71Lry4U5F37TGidqeOhc+1HWsEzLnmFev+vdg
         ISnvNFqoS5x0J8BJXfWIO/B4MY+c7e2cIX0SX2cSE7z46J6zUdICo6rb7X+bSqRjwrWc
         itya2EO6vIBpo2sx6nY1jVQAbLiHsgNKIt4f5ZgWFhCS/lv1yaAgbCZRhwQTm1OnveHA
         dSlCUHx1dms5/to2NJlH94RXWIn+AeuhpF//y7tzXrYM+bImM5u+ll1zfHZnKAVGEUFJ
         1gUibN6RHYu2AnjwIlcSiLlSRSLAPcNSl0/HYzAk1U7LXevt4BIDe8XdRuP4Kej3WH51
         Cp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033783; x=1786638583;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ka0tDf/U90sg/zv0u5TmF/tXCBFGIBLufU4BZIvqO1U=;
        b=crERA472M77CDET/8NeINCEfD7qfh/lG7juQvXU6fzx7P5WKr4GJrY/bB9yhCEs5ZR
         09UK1+20XthJToeYE0JCJFz3x+Obh1gG/IjiyByAmp8CeO3Wcc0oRtv3GCrmiwUGLnAT
         7te0PGkVkP3qZra+uhqqocMxfd/dQLlOxM3lx73MNimr7MN/Me4Zj+vus6Eax5tG4MyR
         +kDs9enCA30Qu+/DmuZg1DSuRNJqZmpKvgaSh8VSqZmO7AO/7jtDhZXdqSk1CXI20E4m
         kehCAo6KJUUf+/FS0kmC/mXHSMzfu4OL+GBGfuZuAlCtDQ4teUVQU90IL0ZLRC6KK4wI
         2uZw==
X-Gm-Message-State: AOJu0YyFX3mGhSt5ijN2jvzhqk24GTsDDK53oGvygrhswriaZH3P5iLv
	kLYWBiFVezzVU3DHoVrz+6/ABXKa38A3Fe14D2wuHnNKUEureljamaHxNfwZMXpEEIBBkkuJGMk
	UdvtUl2nEg2OtKbv+alUXqu8IBS4iPHjQLQ==
X-Gm-Gg: AR+sD12oDKusl22vMn0VJMEPyMz2TY3e1Ek1qnIux+FbStnL5VM1+pmc3mTvvM1OexS
	376EZnqI9S26o17dnksws6Tk07HC5xoFRvQ/ETGqjOsPJWj9+q76I0z3m93aYpLpub8vxqbmb61
	7wcGicKkFDAUyVeUPcNsHumeBmHWCy7g2i3Dv7A3gDiDLXwEQhTCXPi8YCMUAwcXTUm3mtPkEG+
	63Ce2KvQFxHiCkv5Hj5gtTiRQgi2YfXCpbUQRV3i/6GUlP2uBKnNkmsJI5LDn9WPcwMIbwGPdoM
	zeBjR/Vn6xJSdROoy/qYniv22VKJuhvsmfiFOXPe1KJrDWSdurP1JpeV
X-Received: by 2002:a05:690c:6887:b0:7fd:ddb0:2622 with SMTP id
 00721157ae682-8201f0c1868mr96734427b3.6.1786033783509; Thu, 06 Aug 2026
 09:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805210427.3218326-1-memxor@gmail.com> <20260805210427.3218326-2-memxor@gmail.com>
In-Reply-To: <20260805210427.3218326-2-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 6 Aug 2026 09:29:32 -0700
X-Gm-Features: AUfX_mwNZO5K-iuyTmCxxfyp_HBH4zylM0wLlAMzaJEXv9NnsfqFHNZyJ3TizIE
Message-ID: <CAMB2axPZQrAPSGsgbOyhC1-E4CjO_Qs5Mm6WUeMKoK01tP_bZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/13] bpf: Rename 'early' BTF checking as a
 preparation phase
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
> BTF processing is split around subprogram discovery. The first phase gets
> program BTF and imports func_info because a BTF-tagged exception callback
> may not be referenced by any instruction. Subprogram discovery needs this
> metadata to find it.
>
> The later phase validates func_info and line_info against the complete
> subprogram table and applies CO-RE relocations. This split breaks a real
> dependency cycle rather than merely running the same checks early.
>
> Rename bpf_check_btf_info_early() and check_btf_func_early() to preparati=
on
> names that reflect this role. Add short call-site comments to make the tw=
o
> phases and their responsibilities clear.
>
> No functional change is intended.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  include/linux/bpf_verifier.h |  4 ++--
>  kernel/bpf/check_btf.c       | 14 +++++++-------
>  kernel/bpf/verifier.c        |  4 +++-
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index a2a40caca0a0..a9555d17fd8e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1177,8 +1177,8 @@ static inline void bpf_trampoline_unpack_key(u64 ke=
y, u32 *obj_id, u32 *btf_id)
>                 *btf_id =3D key & 0x7FFFFFFF;
>  }
>
> -int bpf_check_btf_info_early(struct bpf_verifier_env *env,
> -                            const union bpf_attr *attr, bpfptr_t uattr);
> +int bpf_prepare_btf_info(struct bpf_verifier_env *env,
> +                        const union bpf_attr *attr, bpfptr_t uattr);
>  int bpf_check_btf_info(struct bpf_verifier_env *env,
>                        const union bpf_attr *attr, bpfptr_t uattr);
>
> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
> index 93bebe6fe12e..0e8b3ccc7a5b 100644
> --- a/kernel/bpf/check_btf.c
> +++ b/kernel/bpf/check_btf.c
> @@ -28,9 +28,9 @@ static int check_abnormal_return(struct bpf_verifier_en=
v *env)
>  #define MIN_BPF_FUNCINFO_SIZE  8
>  #define MAX_FUNCINFO_REC_SIZE  252
>
> -static int check_btf_func_early(struct bpf_verifier_env *env,
> -                               const union bpf_attr *attr,
> -                               bpfptr_t uattr)
> +static int prepare_btf_func(struct bpf_verifier_env *env,
> +                           const union bpf_attr *attr,
> +                           bpfptr_t uattr)
>  {
>         u32 krec_size =3D sizeof(struct bpf_func_info);
>         const struct btf_type *type, *func_proto;
> @@ -407,9 +407,9 @@ static int check_core_relo(struct bpf_verifier_env *e=
nv,
>         return err;
>  }
>
> -int bpf_check_btf_info_early(struct bpf_verifier_env *env,
> -                            const union bpf_attr *attr,
> -                            bpfptr_t uattr)
> +int bpf_prepare_btf_info(struct bpf_verifier_env *env,
> +                        const union bpf_attr *attr,
> +                        bpfptr_t uattr)
>  {
>         struct btf *btf;
>         int err;
> @@ -429,7 +429,7 @@ int bpf_check_btf_info_early(struct bpf_verifier_env =
*env,
>         }
>         env->prog->aux->btf =3D btf;
>
> -       err =3D check_btf_func_early(env, attr, uattr);
> +       err =3D prepare_btf_func(env, attr, uattr);
>         if (err)
>                 return err;
>         return 0;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d925197c2e5f..129e50888b90 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20317,7 +20317,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>                 INIT_LIST_HEAD(&env->explored_states[i]);
>         INIT_LIST_HEAD(&env->free_list);
>
> -       ret =3D bpf_check_btf_info_early(env, attr, uattr);
> +       /* Prepare BTF and func_info needed to discover all subprograms. =
*/
> +       ret =3D bpf_prepare_btf_info(env, attr, uattr);
>         if (ret < 0)
>                 goto skip_full_check;
>
> @@ -20329,6 +20330,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>         if (ret < 0)
>                 goto skip_full_check;
>
> +       /* Validate BTF against the complete subprogram layout and apply =
CO-RE. */
>         ret =3D bpf_check_btf_info(env, attr, uattr);
>         if (ret < 0)
>                 goto skip_full_check;
> --
> 2.53.0
>
>
