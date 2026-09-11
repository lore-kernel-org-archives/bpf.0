Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CA378D89
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160408; cv=pass; b=MP6w4xCmfLZ+tFZEZ2gd+MbvVcipwxBaiKK4CnKffZ1rXeVuNr3k7Q/P+AX3DOVk30FJVhgmQ91r6o37DEJj14rrDlV+MnBxuOjRVC4WmuWmHvYQlMUkyL478MHZ6vDQFS8ZmyUia3KM8+V5PKJp81eINbtA28YvGoCrjeVLOVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160408; c=relaxed/simple;
	bh=xKKFYQhcHRuYG9ir/hwetHkc290PBnHmyac6P8Dgcmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpbk7rt+/jmS9EbRyWUSW1XyDKA2OVWDuxBA8tMxg7nlPt+CSfW0/kycLLQW1Vpu7uyY+X5OZyLapjQUfmC5WmNwevSMyeI9zO2zKDwYMWjLP41MpFJ+pQ0qG2H8qqQzyX1dD7YGZST2uFa2O8SfhVZezNBr6B+HuC/oAsebt5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFQbz+jQ; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFQbz+jQ"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a30eb3bso236513b6e.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789160404; cv=none;
        d=google.com; s=arc-20260327;
        b=oSIJjIiSyn4NPnvlptAGqetGk/TVHhEjFybXf8Rcloxod4KG9nNU+QRqKTGJ7iyrP/
         WelR9ntlrulZg0xcCoQphNQu5bb/zt3noAnQaTeU36Ub6rwSCDTlBw4mM9fQL5HY0yBY
         VbEeYiT1iEPCORQZ9jQFBBlXvqhjs+rsl0mD3FU3chBbnE4461Aoeno4CrYfOHHCloLj
         P738d5FybKKSh0IJyJw9EuMBliBEHmkl5WTVMn/ezia60iUtYAqb1McF/CZpy1ERGrGc
         3lq22m/2wEMew+ZRLxBwe9m1exAaBR7RV/2C3fuUAlA/omg2d+wX7SwSrsmTflzGRPO9
         TEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MH9IX5hIuMzODpkeT8csfNAVdxr4YmQhsEyInmF9M8U=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=gApK6XHVDkDbmZoQFhDhVymJ+FHcmBxYwbjYTNd4QdtT1hwnb3Daj9w2J6pS7IX8Hu
         5UVnFYeIl+SzvnrdX4EwhzYfvuYCK5v0yZ/bALFWCOR6r8cvldifMjijlbCEJwfFrVZO
         8tNiCAMKgoiyceT1gCKJpzFRCL3YOpPOwUxIAlScos1uS6yuOpPolHieTOqAco7FeFBe
         /Px2kMs8Q/gMEX+1bbMZxIuAKaVuTxVI7aG2QQhdgiW1mFmjF3p1r/W/HgE2JSGX/7yX
         dGaz335G7u2HQ96YWcGUaLwFcvEgKnkWayIxWJ0JpEUc4qCEe3HfYZwuz4N4N6tfept5
         VNWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789160404; x=1789765204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MH9IX5hIuMzODpkeT8csfNAVdxr4YmQhsEyInmF9M8U=;
        b=VFQbz+jQsxfDt6Ngd9ryEH/AsQTnXjeAoAvF0EuyOkbdRuiyAsbEzv6S3XSkorkXp/
         1wh8xlG1bEoZHX8KPMTp2tcfmqV3GJ5HStMEVezF+WpT5LL88ZuLyjCIG/GOPZ/ur0kd
         /GaaeYn3pQh9AhhMpIrIC88n8/P9laEWHmlnJ/y23entEkWQkXlzJDN+Ld0scVZH+CSn
         NNgNVPiF16G++u1CyTmD/BRebn+ZqedsJ0MuIpBYMmuRggo7LD02jEyNs9DNSrXV/0+d
         ag4m19GTKhf/kz1/twSym8qcsu2wrc6r3o7lGQoDXmRWEKPo4c/SEqJJAZfdk9sIyifT
         29hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160404; x=1789765204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH9IX5hIuMzODpkeT8csfNAVdxr4YmQhsEyInmF9M8U=;
        b=NYkcIubE2d4xjfkAUZEzof2vTUQHLcKZcHjCKsa7KsoC2J5Qm3CKV8y6iruTKNtmRi
         NLeCrIpNH51iMkH630Hxixh8+54hOQHA58mSoGZotZDTAAJVsWXCS0trtrZORc8XCSCj
         We7N7Pfl5psFVecR/OI70JH64YCB+XI7tPKQPh6y3IYPdJT6Lmg8yuY/Fc5oivp0DMYn
         9LhMLsrXPlZ46X9hl4X1uJPCkWN264ZwibheCspicRXGqat8vfBEvPwvuok2x2nECq8p
         uvOaPFBhK4nkRtArm5hZ61nAylk6ZExGMlncVd7yo4EGzo+pfeUvAKoim1rjKx0Faydr
         01GA==
X-Gm-Message-State: AFuF++nDSFgMtA/2or3d/9vad8OSIutat0jBR2c72xu6L7qlzNF1S3mv
	+HZppaaGStwgHgbmwLVR0W3TWbbEZtZuE5Jgyig73Y/4q5aUuTbF0sIFCltePu+yndYU2OGSi93
	Kuch8lPetIFBKa4jLEM2ucHIhyIoK/qvT6E3G
X-Gm-Gg: AYBFou0yAi1H+W7WlC+fVEcugV93f9tlza1Xg4F1za0+sgKrQDaA69958KWoMYT8/ME
	Gk4i7iN7gMK8SHm+DzjaE9zLE1/33bTRcYWKMXtN9Eh0TBYdlsu4OuGJPL/NiGJIXWV9l6qxeft
	lyFrnnMojq8wUnY1K6HLQkNaw2HZqInQBxakxd0ra2xav68YfN7H61CCO9fwYHa/AF+wy30e9KY
	HQSGcgTi0ELXKJe8P/THlX6UDubzd7i/NRwVlL3lmdQY9MQ90t5Hujvkq7b0ETJ5bko4ie1lE41
	o/T180g6rBMwQ2Ai/SZE7GQBRnj6gjtdeTHOiNdprYo7oGQIY1usw2yR0fLhXXUxLxLNBLU=
X-Received: by 2002:a05:6820:c452:10b0:6aa:cce3:ab61 with SMTP id
 006d021491bc7-6c0ba923c37mr6468380eaf.9.1789160404591; Fri, 11 Sep 2026
 14:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-1-ameryhung@gmail.com> <20260905220117.922028-23-ameryhung@gmail.com>
 <20260905223348.85D551F00A3A@smtp.kernel.org>
In-Reply-To: <20260905223348.85D551F00A3A@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Sep 2026 13:59:51 -0700
X-Gm-Features: AcwNN1XAVZWJkpdmxs5hktIsCs5XyxE_eHvb_ZIjvgNU9BY4E8vMsIjooOO66AU
Message-ID: <CAMB2axNjqLtLeKbVqKwf0yEQ4OvjTq3ifJq19wWTg5YkRDtWcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 22/22] bpf: Check helper and kfunc arguments
 in one path
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Out-of-bounds reads on `meta->fn->arg_type` and `meta->fn->a=
rg_btf_id` for kfuncs with more than 5 arguments, allowing bypass of eBPF v=
erifier safety checks.
> --
>
> commit a1895fafaa5219b7b972d20a932c550f7862cec8
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Check helper and kfunc arguments in one path
>
> This commit unifies the argument checking logic for BPF helpers and kfunc=
s
> by introducing check_func_args(). It moves kfunc-specific argument handli=
ng
> into the shared check_func_arg() path to avoid duplicating the argument
> iteration and switch logic.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6c5d7e544f844..54656fb31bbe7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -8808,6 +8840,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> >                         int insn_idx)
> >  {
> > +     const struct btf_param *btf_arg =3D meta->btf ? &btf_params(meta-=
>func_proto)[arg] : NULL;
> >       const struct bpf_func_proto *fn =3D meta->fn;
> >       struct bpf_func_state *caller =3D cur_func(env);
> >       struct bpf_reg_state *regs =3D cur_regs(env);
> >       argno_t argno =3D argno_from_arg(arg + 1);
> >       struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, arg)=
;
> >       enum bpf_arg_type arg_type =3D fn->arg_type[arg];
>
> [Severity: Critical]
> Can this read out of bounds when processing kfuncs with more than 5
> arguments? The fn->arg_type array is sized for MAX_BPF_FUNC_ARGS (5), but
> kfuncs can have more arguments. For stack arguments (arg >=3D 5), this ap=
pears
> to read past the end of the array.

The review is a false positive. MAX_BPF_FUNC_ARGS is 12 not
MAX_BPF_FUNC_REG_ARGS, which is 5.

>
> [ ... ]
> > @@ -8935,6 +8980,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >       case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
> >       {
> >               const u32 *arg_btf_id =3D fn->arg_btf_id[arg];
>
> [Severity: Critical]
> Does this also read out of bounds for kfuncs with more than 5 arguments?
> Similar to arg_type, the arg_btf_id array in struct bpf_func_proto is lim=
ited
> to MAX_BPF_FUNC_ARGS. If a garbage pointer is dereferenced here, could it
> crash the verifier?

Same false positive as the previous one.

>
> [ ... ]
> > @@ -9056,6 +9389,37 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >       return err;
> >  }
> >
> > +static int check_func_args(struct bpf_verifier_env *env, struct bpf_ca=
ll_arg_meta *meta,
> > +                        int insn_idx)
> > +{
> > +     struct bpf_func_state *caller =3D cur_func(env);
> > +     const struct btf_param *args =3D NULL;
> > +     u32 arg, nargs =3D MAX_BPF_FUNC_REG_ARGS;
> > +     int err;
> > +
> > +     if (meta->btf) {
> > +             args =3D btf_params(meta->func_proto);
> > +             nargs =3D btf_type_vlen(meta->func_proto);
> > +     }
> > +
> > +     if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> > +             err =3D check_outgoing_stack_args(env, caller, nargs, met=
a->func_name,
> > +                                             meta->btf, args);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     for (arg =3D 0; arg < nargs; arg++) {
> > +             if (meta->fn->arg_type[arg] =3D=3D ARG_UNUSED)
> > +                     break;
>
> [Severity: Critical]
> Could this loop early-exit and bypass verifier checks for stack arguments=
?
>
> Since nargs can exceed 5 for kfuncs, the out-of-bounds read on
> meta->fn->arg_type[arg] might evaluate to ARG_UNUSED (0). If this happens=
,
> the loop breaks and skips the safety checks for all remaining stack
> arguments, potentially allowing unverified memory access.

Same false positive here. No out-of-bound read, and there is also no
ARG_UNUSED holes in kfunc arguments.

>
> > +             err =3D check_func_arg(env, arg, meta, insn_idx);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905220117.92=
2028-1-ameryhung@gmail.com?part=3D22
