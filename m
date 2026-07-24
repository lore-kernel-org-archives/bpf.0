Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32162283FD4
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933568; cv=pass; b=MDKjURkULnk9N3aC6cIvCK8izU9k1CvtKfKbWhMEdV3vUnT1PJv/lY0gu3ovJSObVlVOOh2DXjIoPKtzcstyEXWim150MhiE1k6eXYYmip/iggUMYnpARshXrfpuIu5thY+iii/u1BRaDb84/RIbi8hvnny4b1oL6oF5MrzE36I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933568; c=relaxed/simple;
	bh=5r+wcWCSnXEVCw26bG0hPi5Ia1f/Hd5c7gS0uuMc8f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNxYMpK7//KrlyHAChnzVpHa+gvs27F0nbqeImSeNqeXlQsa25Bc5L5EJREOwr1yns02BXecbntF5TRCrxdQ4mqHfLioWzjJpQb1K0h7JtoZPEATDowl1KFajVW/HtrdIK3U9qA+kn6DLfpXTUnRtI8ExRJwRCM2B6EUSEmm7qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCxPQOQE; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCxPQOQE"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80dc4a68e4aso8343417b3.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784933557; cv=none;
        d=google.com; s=arc-20260327;
        b=CGKGdtqN2bhISyNAs47P7NMD3nEuoYbkSpvM337jJ82giXwqrTyymgQy76u0dBoc1n
         A+uvOpzIoOcSf1EFuweWquBbaIeBfM9An0bMsWv59pq32GpusI0cODqOEk+y3P4zZdaW
         6EVHWhYaWKqLN3Ee+7nkU/Y89N7wPWjgtQMElK0J/2v0sQhOgw9M/Vbh1YCMQ851rZWX
         Rv32BX0jIQXDzjBng4dwHizWXRVp4kpK0jfyrCwV1e/+32R5AYcC9RrkaNUKMH6/HhTu
         ZmpNuDzBkg78vlZuBTIknnwqLQFL2EHIp8VN6L5xYcPcGyIhFD+K8ihxDKcCuExQCvsg
         ijKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Je9RQL7yzHK1azs4JTGhkDhHGg3bmFqi0w/4Q5JGZZM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=d+TH6qX4K3oZhlIZapB6/bTCKTiXcu9/jMoew427WeuXmlbbYKBx4JmPBFJvFm8w3g
         oQnCywNnzyfzJB5Gb5Tjwc96LpArF1p3eRMZ6bcBWDPMTKsLdC5Bc75WWrGgtOAgIrDm
         6/97tMJYH15jWSTZH3Hyx1h7XQ0XAxkaAW3wAhVfjjz6E8KbkXcs5fNz/lROhgX7WO8b
         e9+Dg81UuyF17R6arlwf6j8xuH5msRaGQNVjHhqe+1iGe0xCgwCXnQsUGXQlNRF+adS/
         0WolDrY42rifyP4pXUxnu8+Dqu6xGOXuyrCrBFHfK9aiEDmmQkkzFuecNVxzqdX2XpF8
         vCNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784933557; x=1785538357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Je9RQL7yzHK1azs4JTGhkDhHGg3bmFqi0w/4Q5JGZZM=;
        b=dCxPQOQEJfJmweHNz0OIE3ilQsnDt5S+heTFkByKknDoMQ9xZkWQadUzXnQsonYmeH
         Odn5iXyf4g4fQHVmRmf/XQ9yVsIbyGCNN19a82k7c37C7i/aNEe7Yb9xcyYAWCts8gm4
         1zjfNhyrGMuDSFYgKvr3p65kt4mM9IbDebyBeL3QKeAOGLBMvfusy0f204lDRFT/HhPi
         EXxTXPU0Fyv8UPu/f3QaGb3PwL6gTRf1+bacplOaBj57qW4hILAcfv/Cw84q7RrWEX7I
         XBGLDr7A/V/fHYKE3Yzl+FzEI5220bGH8bIh2uXYZJ3dF1MA4AJy2hrEM6tJWApt1vYt
         uQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784933557; x=1785538357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Je9RQL7yzHK1azs4JTGhkDhHGg3bmFqi0w/4Q5JGZZM=;
        b=J1TGicXO8yzLpZQ6rDxmhYG4cFe0IC1aZ5obbHyu0sK3v7sYK/zCD42L3lDes9PXTO
         3B4xZzYN/KntdyCTypbl4ibGf3r/uRye4WysjdGjN/8lSwCzgSuDfvf+ECLN+CJRfaBD
         13Odo20200OVvGG51hdGAgqe2GsB3B+8EZvMezI8QCGttONweRbD2yBP/VlD9QMPTJZe
         LqN/UQRg/Xgv231x9OTZopYTgh/HKqltgZdC9K0Q328FHPjYDEYtfYWpKsBuL36puOWu
         2QEDZx/ARgIdgP+0wio7jUqG9joLI8GturlqG/IXHl5DgsVq4Cr2h3eGZ1qrkUEp+Q5p
         v7Pg==
X-Gm-Message-State: AOJu0YxdQn385Cm6/xcz/NjvgfEnuCuX/kYl5kUBEonfHzE0qDkGVIp0
	Y+gCTto0FfAwsF7uexz6F6PGWjvxOHTGS3/s3OchW6yavHlL2W/BJITitg9XrSVHJx5H20UgO7t
	JG1wAUhPV280mh1/kEQjNFRGCwKkNTz3JFWUD
X-Gm-Gg: AR+sD13MxiWu8jz8YQvX+8NaiuOT7YgEj3PAUtyppiuDUF8fOrpzRVi3BXn660HHNbM
	xt+q3liBLTyPSLsT12IXNiNz5hfARQmDGF3H/LSDh+Hz09jI0zJo/jDWee0ESMMgsgrf9sW42rs
	nq8rgY30ZRvbVs1ziehC8KogklGvN2il1jKnWxg/5shkgDEIPYy9vrWdV1V1H4oJU0/s5iPxkEe
	OliRvvjt4gAQBxbV+eL7mIckjfUWSw1gVrstpOi99cvayGYGE9YqNGVCgSyiA==
X-Received: by 2002:a05:690c:9688:b0:81e:45a6:bd52 with SMTP id
 00721157ae682-81f69e3c4b3mr1520747b3.34.1784933557256; Fri, 24 Jul 2026
 15:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-12-ameryhung@gmail.com>
 <20260724193854.57F981F000E9@smtp.kernel.org>
In-Reply-To: <20260724193854.57F981F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 24 Jul 2026 15:52:26 -0700
X-Gm-Features: AUfX_mxAgvUZDDSV_y1FYtX7GTSISkmzcoT504FkjU2DbC63Dg_OFMVyiqiMF2w
Message-ID: <CAMB2axPqGZhVmkGbpijqmdmkY65aojPJemV-ot0ATZ6DEANf2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/18] bpf: Classify kfunc mem_size args from
 BTF without register state
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Removing the `SCALAR_VALUE` check from `is_kfunc_arg_mem_size()`=
 and `is_kfunc_arg_const_mem_size()` allows unvalidated pointer registers t=
o be passed as memory size arguments during kfunc lookahead validation, tri=
ggering a `verifier_bug` kernel warning splat and local DoS.
> --
>
> --- Patch [11]: [PATCH bpf-next v2 11/18] bpf: Classify kfunc mem_size ar=
gs from BTF without register state ---
> commit 55013229ec44003dda12328783652d410aa4f75e
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Classify kfunc mem_size args from BTF without register state
>
> This commit drops the scalar register type check in is_kfunc_arg_mem_size=
()
> and is_kfunc_arg_const_mem_size() to decouple get_kfunc_ptr_arg_type()
> from register state.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f8d403083177..f6b373630ca95 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10795,26 +10795,24 @@ static bool is_kfunc_rcu_protected(struct bpf=
_call_arg_meta *meta)
> >  }
> >
> >  static bool is_kfunc_arg_mem_size(const struct btf *btf,
> > -                               const struct btf_param *arg,
> > -                               const struct bpf_reg_state *reg)
> > +                               const struct btf_param *arg)
> >  {
> >       const struct btf_type *t;
> >
> >       t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> > -     if (!btf_type_is_scalar(t) || reg->type !=3D SCALAR_VALUE)
> > +     if (!btf_type_is_scalar(t))
> >               return false;
> >
> >       return btf_param_match_suffix(btf, arg, "__sz");
> >  }
>
> [Severity: High]
> Could this removal allow a pointer register to be incorrectly classified =
as a
> memory size parameter during kfunc lookahead validation?
>
> If a BPF program passes a pointer register (such as PTR_TO_STACK with a f=
ixed
> offset of 0) instead of a scalar to a size argument suffixed with __sz,
> get_kfunc_ptr_arg_type() will now look ahead and classify it solely based=
 on
> the BTF signature.
>
> Because of this classification, check_kfunc_args() eagerly processes the
> unverified register as a size parameter before the generic scalar validat=
ion
> loop catches it:
>
> check_kfunc_args()
>     ...
>     check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno, ...)
>
> Inside check_mem_size_reg(), the pointer with a fixed offset of 0 yields =
a
> size of 0. Since zero-size is allowed, it passes the bounds check and cal=
ls
> mark_chain_precision() on the pointer register.
>
> Because mark_chain_precision() expects a SCALAR_VALUE, it triggers a
> verifier_bug splat for backtracking misuse when given a pointer. On syste=
ms
> configured with panic_on_warn, this creates a local denial of service
> regression.
>
> Should the register type check be retained here, or is there another way =
to
> prevent pointer registers from bypassing validation during the lookahead?

I will change check_mem_size_reg() to be lookback by calling it in the
KF_ARG_MEM_SIZE case in patch 13 ("bpf: Distinguish fixed- and
variable-size kfunc mem args with MEM_FIXED_SIZE").

It is not bisect safe, but it will be free of this issue after patch
13 in the next respin.


>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.14=
58271-1-ameryhung@gmail.com?part=3D11
