Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142F44470B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291948; cv=pass; b=h4jugi0QZoX4rx+hK37RXnsOPHE96v1gRJ/FYgoUfa0AurC5U4N6f6OHNDNnvnkeuPg40qUw79lKw/QwYAd0XcqGjRW6/bCoy35YyvgF9mJVavvR3PRR3VPFeC2Slgpdm/14ekGjSsjvR7ooCyE0p359NZYN1s6h+Y7UX2ho5Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291948; c=relaxed/simple;
	bh=Dl76kS3TxqzW8es8CRr6DTM22Vk8nLETkh+kBL0H3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgN3wwMpqN3j139kJfAPcFG8bnCqihoZ7XRHgWqj3HpGxa1XDcwdeFT+FDJZbTU9xNdZFxok992nofpiQJfwRkdE16qzliS4g0foqIEknpvoDgqYLENtcsSdsZ4ISIe57HPqmF24/mLfAueQmOW8sbr5R6rKb/p1wNCQNZ6sShY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtCgoUtg; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtCgoUtg"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df8818fe1eso826475ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790291946; cv=none;
        d=google.com; s=arc-20260327;
        b=UgNwmFnCMAiaUXpYjUtFSHeq/l+WtED23zdpcJXmjcl/34LHk2JvE5XPWOOzPQ8xQ7
         krl+yfZvJmAYTz3rpeuTRJxd3RpqmRAuEUYb+QHQoYM/NCzPFuGVoh9aqkcvd4xpjGl/
         MQiX//1TYr5N5WmGauj5mZqcKP4VuSyS90OaFOoO+v88Kq4bY2RyzGByhDNCi1IVT7Gz
         88GlgFE7DkQOIWhEx+cqBWFyBoAWM6CfzD2QzqVHU20wu29VXjr02cOkE2vohnRHw2DO
         Yh4c6iYpVbpjN5G6lvyFYAzVmpbs0B8ukPt6XCBEYNiRMUfyAnUZ9/45ec/PBIbucSxd
         lU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGKg1ypaTIxIm+h/NqbIGNtGUyd1i/dvq2OYFzGt/2g=;
        fh=FLd6JgKJC78bvz9uUBQxoN4rjy641h97g+CnETlClq4=;
        b=gVKUeRz+8dTJf+qnn+W4xwc/RoPipyL7JreJcPhPDogiv3gvCW3q4sP++llnAfn6Tr
         4SZtl6ouhL4wpcJgexwTSBqVYB3amNgZ/Pkpf3VnIVBXf/PU6EWg6zqcNdQ8blOGXzQj
         Nek0PfDRMb7mD8hUjZApfpJ7cOwbi1S2qteDWIIpUrON97b+9jEPTTCwz6VojEMHe2Lo
         krYF4BlrmkoEdiErNM2uixCCurKtV/XzYfHUue9/r66x2U8sObQiRcB01EbeiktQ+DSq
         XXTuN2Mv+a8tpIc/YcCywmncXJ5446L34fYUq6gOdZ03RkHvPI61OspNcsdUBDIuxHTG
         lItQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790291946; x=1790896746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uGKg1ypaTIxIm+h/NqbIGNtGUyd1i/dvq2OYFzGt/2g=;
        b=KtCgoUtgEPTzQmy4No/4pG0f/yXs6ubywkwyIqe5iHCpRbtOjN1smtgTu+UyKN1a8n
         m6lhy1N7GHgXGbPFcCsV1L2jckYbFRbBpL8jvYTcwn0pgOd/w1jpCQghbcqQ0fkWh7f5
         QfgJaRmK5k2cUrMvmFCT9KwPcrZQq/KBfnXRFvSEFTv7T4OClfs0H03x70IgOos52l29
         kLYAA0U+Xfgn10nufQKYH/XjG3fbmgLhc6N2Qe9GwyBqN3hUaDJk3WQQXCuaVSUrQiD8
         J3VvNU+b7+kt2a5tbGGJwtxlGUh/JARUIy/tTFS6+l7bV2QtYH2j5gWf/XFDMvIxHje1
         0R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291946; x=1790896746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGKg1ypaTIxIm+h/NqbIGNtGUyd1i/dvq2OYFzGt/2g=;
        b=k3/Z204gLW7oxjoxYCvwv5REB5P6RK+FUPzFkT04/oXeslIwEzyYSyBIwd/JB8Im9o
         hqjjmTDhkz1D/yB91/LW8yZHXOP8GC0U+La/ToOuYRopgvwdRiHWBN9uQlb4hWjPh2Yc
         UvVXumfOIpTBwHKcEqboq4momMvQ2364Kv7O2FR6EOddWeXJ84Ru2N5BuLzhVFIEf2y2
         QolGgwAKkJYz3qEBvW8TyGpWEhvDWGt4fyPX4tCufKKPs1QkfpnsgqzIztr2yQBrF07j
         fBXqa0SnLo8eA75aMyUV9vJNNiSAUoUsuJMI+RYke0t+/JTwUF4i5IijtdykF1itrOfg
         3VhA==
X-Gm-Message-State: AFuF++lIRTv/y8dGgsnz5mi/xkDlDgI3A5Mq6El/nBq9aovhMZRw85me
	NVlRtBVTC7yfCvR9ihTWYiUpBa56J4W49NzYRa6PsKqPypnEVPAWIFENgxnXClzywRnlViZou+W
	zMCloBBaGGIhh2bCZwjHageqxhgQ53Iw=
X-Gm-Gg: AYBFou1tikkidMO0+9gU7WYDNPBwPS04CoRru7/U0g17njTRVgbwBD0M+Gm0rVIJQpM
	Qf1bmlTyh8iKUswxKSN957G514F922kb/DD4m2x1P8XTIC5THsi+YvmhB1v/3d2rx6gpL9rKp35
	6bi04vlSKBVeIUEsWkfq18K5OLOrnfnW59CvZYPbN4Hze7N8v5elRp5mlTvip/abmy8Jt4IYUOF
	FbEKRRrlL+j6m0kpijqfK9JHw5/d537LhYhmWn52VATB5yU1Drm2UoL4oM7rAuZhQ5VzsrSX3z5
	dcB4YO8AEZul6s+VophPIvyKYuJgV5lqcnE7YfQgm5uMafT2+m1SG3YxFYyomO0OLREgSRsK5Kz
	Xo+6VXpv6pQqm9Tc3e/Cu5Zh2YYoqyWzb/RIM
X-Received: by 2002:a17:90a:f94f:b0:3a0:2614:2077 with SMTP id
 98e67ed59e1d1-3a098b93d4bmr2758481a91.41.1790291946307; Thu, 24 Sep 2026
 16:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com> <20260923232939.1886328-5-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260923232939.1886328-5-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Sep 2026 16:18:52 -0700
X-Gm-Features: AclHuK8Ayw-tkg1IMleCkQkxnhbqxuwzgu2Ngy3Mg8MVfv6LD28TGgOoDczg8_U
Message-ID: <CAEf4BzYJe6FXO5Fj+RQtd9R1SYR0Lo-1Cm9G77kgvZ2uSe3K4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Reject gen_loader for objects
 with already-manual programs
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> bpf_program__set_load_strategy()'s MANUAL case rejects setting MANUAL
> strategy while a gen_loader is already attached, but a program marked
> MANUAL declaratively (SEC("!...")) gets that strategy during
> bpf_object__open(), before bpf_object__gen_loader() can ever be
> called, so the existing guard can never observe it.
>
> Left unchecked, bpf_object_load_progs() skips such programs, so
> gen->nr_progs undercounts relative to the object's real program
> count. bpf_gen__finish() only rejects the opposite mismatch direction
> (nr_progs < gen->nr_progs), so this passes silently, and every
> generated skeleton program slot after the manual one ends up wired to
> the wrong prog_fd.
>
> Catch it at the one point guaranteed to run after any MANUAL marking
> has already happened: reject in bpf_object__gen_loader() itself if any
> program already has load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL.
>
> Assisted-by: Claude:claude-sonnet-5
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d815e53e8295..85e1d9c775ab 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9859,11 +9859,31 @@ int bpf_object__set_kversion(struct bpf_object *o=
bj, __u32 kern_version)
>  int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opt=
s *opts)
>  {
>         struct bpf_gen *gen;
> +       size_t i;
>
>         if (!opts)
>                 return libbpf_err(-EFAULT);
>         if (!OPTS_VALID(opts, gen_loader_opts))
>                 return libbpf_err(-EINVAL);

gen_loader shouldn't be set after prepare step, we should just reject
that operation, it's a misuse of the API

> +
> +       /*
> +        * Manually-loaded programs are not visible to gen_loader (see
> +        * bpf_program__set_load_strategy()'s MANUAL case), and marking a
> +        * program MANUAL happens during bpf_object__open(), before this
> +        * function can ever run, so that guard can never catch it here.
> +        * Reject any pre-existing MANUAL program now, since this is the
> +        * earliest point where both are known.
> +        */
> +       for (i =3D 0; i < obj->nr_programs; i++) {
> +               struct bpf_program *prog =3D &obj->programs[i];
> +
> +               if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MAN=
UAL) {
> +                       pr_warn("prog '%s': gen_loader does not support m=
anually-loaded programs\n",
> +                               prog->name);
> +                       return libbpf_err(-EOPNOTSUPP);
> +               }
> +       }
> +

and there is no need to check this on setting gen_loader, during
bpf_object_prepare all this stuff (gen_loader, MANUAL settings) should
be finalized and never changed again. that's when we check all these
conditions


>         gen =3D calloc(1, sizeof(*gen));
>         if (!gen)
>                 return libbpf_err(-ENOMEM);
> @@ -15470,16 +15490,10 @@ int bpf_program__set_load_strategy(struct bpf_p=
rogram *prog, enum bpf_prog_load_
>                 break;
>         case BPF_PROG_LOAD_STRATEGY_MANUAL:
>                 /*
> -                * Manually-loaded programs are not supported for gen_loa=
der.
> -                * This is because bpf_object_load_prog is not called for
> -                * manually-loaded programs, so such programs are not vis=
ible
> -                * to gen_loader. For this reason, prevent calling
> -                * bpf_program__set_load_strategy(MANUAL) when gen_loader=
 was
> -                * used to generate a BPF object loader.
> -                * A gen_loader implementation is being called for autolo=
aded
> -                * programs and defines its own model for loading BPF pro=
grams.
> -                * To pass a BPF program to gen_loader, set the program's=
 load strategy
> -                * to BPF_PROG_LOAD_STRATEGY_AUTO.
> +                * Manually-loaded programs are not visible to gen_loader=
,
> +                * since bpf_object__load_progs() skips them during the b=
ulk
> +                * load pass; see bpf_object__gen_loader()'s own guard fo=
r
> +                * the full explanation.
>                  */

yeah, wow, nice way to score human reviewer's points, more sloppy slop plea=
se


>                 if (obj->gen_loader)
>                         return libbpf_err(-EOPNOTSUPP);
> --
> 2.34.1
>
