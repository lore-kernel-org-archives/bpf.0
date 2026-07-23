Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326240E8F5
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849374; cv=pass; b=NNIJuFimAqDPL4+44XOTwTE+satFRGhlF63sUqq82fLf2/7IWpkJhnvpKZxoQiE8WaBB23Nj4RWDtCqgGrVD0CkbtbEwiabzISWZqPJ06QiOysnkqYXcrau1BcPQ8AwIYFOSC+6M16Jk6JvtGbkAV4/TyHaBBiYUaDUSXcqVqiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849374; c=relaxed/simple;
	bh=BVSk6mLrzSyTeGXwlJIPYNa+8Axk+ULGfvm3aiXsPQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSy71+5xHyd7ZNicf261aTYpoP5TrUoTeDsDeShvOJpT8I+C1XTrqxs023Rs6Y4md64khtSc6EjIrPjnBlRF8S62XzahS5Gh5eEnQK65kDB7THtbo0ps73YJKgh9ADl7Fkdkh6KpjLV+T04QIl/eON5k9yN+CeQwCE9Td+7i3J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN4g1kfc; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN4g1kfc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81dfdbd86d1so11128577b3.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 16:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784849371; cv=none;
        d=google.com; s=arc-20260327;
        b=P6bqIxuQzq9hD/K0zpvU5CvVYcG6vg1TLPh1s/Tm2ygXWQGXOBgbCOzd35f+EmtGMy
         gbpQDS/ys2Rp5eZYkYjkT96A6mAxFZJTkU887lxmsqBlifZ9mkjjlEXmav9G/1A7cSOu
         pB89kW/SWubLMyiLazJIZp+VbpdLcy2KGvlhNaQ1+PhFoffqocH0DzCv9R+KewpOmI+i
         /9tbJe7O//rZIxD9DSFYkHkE6DyBzoKhRDGsVWW0GCkCAzTH/xCKAJOQNP6/8/UPU22c
         3bTeUsrBD2ixost7o+uuO9Dfn1z7+sIoIRXDu7KNkgQSqrVSObGj3uGE7z9Tcliw9Xl3
         2dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RbV4veNtMxNuhfUCXGwbw+OXLaKwqSBL6ZNXEnhYxDY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=mHT7bRnRLcKIIagmjCXaeFqRUorkrlDq/QuzBANkRFfB7FKgr5sdHQXoEgTzDiXzSh
         Wljv30rGnLVmWwbi8UmZVbMqxk5P9USJ7thoujndBoQEUKhkkzk7SuXBNM+je08GBTPr
         G2WkHp10TwrIv0y1fvkCk2Fc/IEmQwVJz9ztqseaMU+ZRah+iPJkyRAgYLLLhI5fuzsd
         OVzYhNDD9KZhqXWYOXbU9i5AXvBykJJ4dUNsnRjNuRiLIp8/Fq0Zy9nf88dNeYhFS0Cj
         JOCTF9I6lJmxaPkfmAbjxLxRhQjL3YjKgc2fG6ILXmB+VmoebTI5pa9aGDcDwAdrCUlS
         7u7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784849371; x=1785454171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RbV4veNtMxNuhfUCXGwbw+OXLaKwqSBL6ZNXEnhYxDY=;
        b=jN4g1kfc6aK7YYYQkOFPSSou3VOUJO61zr9mNJj1Je0hZtVvpYJRmvrwRRLJHooCdE
         KBsyY5h5Ki6RC26uJcoa1YSlPYhb3MrqcLYEksBxs5QASEJsQyhCasXwratFigH1CFb7
         gvGfnLdOuVMnnbyr4xGep2dCMBTiPY48xB3NJMIlGpyqpvTWn59tKoH5FKWo4a2et8zN
         wmRVnsEZs61kWz0XNVvvlp5pRMMovuRSAK3bdfrsNh9ft+FoQnZU+pZhZWXXDCGJq6aZ
         ckCsoA3J/9pSVPk3CP7Th4L/leRpgVnXKIbeY191JC12c7yD4yb/Z8DVCIxUysuMXCLp
         44Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784849371; x=1785454171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbV4veNtMxNuhfUCXGwbw+OXLaKwqSBL6ZNXEnhYxDY=;
        b=MXFBHNuJGkeyphxi/TD6Px6DpXSXekCZr9SwTgF1zt3WRiZSD35vGWEkAcYeq3UgfZ
         m+mBgww76YzxjilBL5wy7rkTMaEf/SlmiRGQj3fTq6tgGuyl8NqAJZnjKkQyX8m8zdUh
         tRSAzHTjQXccRhXb7ZzK91HPbDgKBvXliNPAiWz4LY8CF3devMfMqAqhrkrUnSXc351B
         iDLKv1UHbpknhzT08ff0HDpAg202dATHNNtO319Gm97MAunU7AAv2d8Pkzrz7rI1n2fZ
         0r6VP9vriPkO5t9aGEk4O/8mFuzd4/OsJTJLnsYDy5UdWqZAptrmcIVJPL0PkQfkqygR
         yrVA==
X-Gm-Message-State: AOJu0YwVP5AJjSawhc/jUyl8bAj614mQWpC/IMxPNkYsdIKGwhJONdAH
	/lAAuckSd28Zsw8Qb/yCZCJbLWwhxOK8uADswN7ezCu8K+/o8LISGESk3pyfqp9p/oa9Q8yFoqd
	kcHrVoRU/L+icXc4MKBk4owcYe2tCJK3oY2JB
X-Gm-Gg: AR+sD12x4rzXlkk0adzRWO+/vbTiNPjVGUcBRzIUg8u/SYelvb3lBLvz/g2mp8hd+4q
	/I/OryUbbE6GFzN6d/87x9B1fvpeVosPKXvCjA6V151/g1pfl60xUNG/nnN9oD6+Na6uaMrRNcT
	pYxFYKWs9Y6CnSCLca4oC5+8oEixEU0PmtKiIrLfGrKeHOw5pPVQsiU6OEImmVL0foILA3IwWsN
	sSW/VzVOZV/FzIRxoqkMKKa6PnxnP2N2svlY+XV/euSW5X+NJAPQQ1XU1NAWA==
X-Received: by 2002:a05:690c:4803:b0:81d:7a2:f044 with SMTP id
 00721157ae682-81f4c1b9df2mr17185937b3.28.1784849371475; Thu, 23 Jul 2026
 16:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-16-ameryhung@gmail.com>
 <20260723072716.A1D231F000E9@smtp.kernel.org>
In-Reply-To: <20260723072716.A1D231F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 16:29:19 -0700
X-Gm-Features: AUfX_my_bvt3BtXJD1H4wyX3z15ITjeIuNTl1WeQ96Hz0gSr6fjyFnOS0wancEs
Message-ID: <CAMB2axN_qfmW79jfp65qd0FaNyfmMRMByUfytVKZ5s36EkNHdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 12:27=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The removal of the `bpf_type_has_unsafe_modifiers()` check a=
llows referenced pointers with unsafe modifiers (specifically `MEM_PERCPU`)=
 to be passed as normal pointers to regular kfuncs.
> --
>
> --- Patch [15]: [PATCH bpf-next v1 15/18] bpf: Classify kfunc pointer arg=
uments from BTF, resolve type against the register ---
> commit 23915f0b14432c05d0cd9201ab12d531e9b8df8a
> Author: Amery Hung <ameryhung@gmail.com>
> Subject: bpf: Classify kfunc pointer arguments from BTF, resolve type aga=
inst the register
>
> This commit refactors kfunc pointer argument classification to rely on BT=
F
> rather than the caller's register state. It also moves the referenced-or-=
trusted
> checks for BTF ID arguments into the BTF ID resolution path.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12383,20 +12376,46 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >                       break;
> >               case KF_ARG_PTR_TO_BTF_ID:
> >                       /* Only base_type is checked, further checks are =
done here */
> > -                     if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
> > -                          (bpf_type_has_unsafe_modifiers(reg->type) &&=
 !is_rcu_reg(reg))) &&
> > -                         !reg2btf_ids[base_type(reg->type)]) {
> > -                             verbose(env, "%s is %s ", reg_arg_name(en=
v, argno),
> > -                                     reg_type_str(env, reg->type));
> > -                             verbose(env, "expected %s or socket\n",
> > -                                     reg_type_str(env, base_type(reg->=
type) |
> > -                                                       (type_flag(reg-=
>type) & BPF_REG_TRUSTED_MODIFIERS)));
> > +                     if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID ||
> > +                         reg2btf_ids[base_type(reg->type)]) {
> > +
> > +                             if (!is_trusted_reg(env, reg)) {
> > +                                     if (!is_kfunc_rcu(meta)) {
> > +                                             verbose(env, "%s must be =
referenced or trusted\n",
> > +                                                     reg_arg_name(env,=
 argno));
> > +                                             return -EINVAL;
> > +                                     }
> > +                                     if (!is_rcu_reg(reg)) {
> > +                                             verbose(env, "%s must be =
a rcu pointer\n",
> > +                                                     reg_arg_name(env,=
 argno));
> > +                                             return -EINVAL;
> > +                                     }
> > +                             }
> > +
> > +                             ret =3D process_kf_arg_ptr_to_btf_id(env,=
 reg, ref_t, ref_tname, ref_id, meta, i, argno);
>
> [Severity: Critical]
> Does this new structure allow referenced pointers with unsafe modifiers (=
like
> MEM_PERCPU) to bypass validation and be passed to regular kfuncs?
>
> The original code explicitly checked for unsafe modifiers:
> bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg)
>
> However, is_trusted_reg() unconditionally returns true for all referenced
> pointers. If a BPF program allocates a per-CPU object using
> bpf_percpu_obj_new(), it receives a referenced pointer with the
> PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU type.

Yes. This is a regression.

I will replace:
if (!is_trusted_reg(env, reg)) {

with:
if (!is_trusted_reg(env, reg) ||
    bpf_type_has_unsafe_modifiers(reg->type)) {

This also fixes a latent issue where referenced reg with MEM_RCU would
be allowed to be passed to non KF_RCU kfunc. This is not triggerable
since there is no KF_ACQUIRE | KF_RCU_PROTECTED kfunc.
ref_convert_alloc_rcu_protected() also clears id when adding MEM_RCU
tag.

>
> Since is_trusted_reg() will trust this referenced pointer, the unsafe
> modifier check appears to be bypassed. If this pointer is then passed to =
a
> generic kfunc expecting a standard kernel pointer, could dereferencing th=
e
> raw per-CPU pointer (which acts as an offset rather than a virtual addres=
s)
> trigger a page fault and crash the kernel?
>
> > +                             if (ret < 0)
> > +                                     return ret;
> > +                             break;
> > +                     }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D15
