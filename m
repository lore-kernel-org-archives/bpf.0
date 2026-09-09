Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136F37756C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975496; cv=pass; b=gbahh95WC3GhrmzdcXcq/iqeVBEgoaj5iM5EQlsF0v4tHntPgrH9jLFJ5IbKas8C+we96HU75NEdH1pwA/YN/FXK70if37GnxZFyhJyaMqy8FxbJnX8U/7GEl0FxAUIGnUWJw5saWwIhvPXNZeIsIN4JCwY/NOZ+9q2fXH3t0Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975496; c=relaxed/simple;
	bh=lTZUZ5Ca+Z7Rm2xkWM/Tsv1LuHBU0i4EDnEaAxlqH24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICoRvi1n/cOCXXRLaenN0MU4Ho9knCEhEVqKYr0XWGiE3NSObddsEQ97wA2Ujcuu0b9fZb3I2HPK+PvGvwGfgMRtQ2yFD+dX1vwVSturF/zm+J+Bft/QkZykuxHsWUD8RQhnoVSC8pp0/oMB5Z8FyButTGXWojMrt2jm48oeiGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leZ5+d6N; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leZ5+d6N"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1334a3b16so4330911eaf.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 10:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788975493; cv=none;
        d=google.com; s=arc-20260327;
        b=gx0/eQRCsVGY9cy+I2Mua9B7geTIDo9BeKSYRwAQuNR15cFZgnrDb3lN6aVZuHBFnT
         nP8S9WIMXejn24IAwF1WvEqeuZrrYtehl1nwdNLZqfvVFm+3ZASXWI/mpPp9bEy++ufm
         87ZdpYk0f6NQWMM2i5mrMMvMT9s0wAI/lsGDoe9M1zioB6ntHoUgZu2ecwYThImWNc9E
         0yTmyRyqoQQJMaYqSw2cglcluetcIyq0gx/U3LfcLmEXhR29r4FMrs0PS8MBef8nGE7y
         Zf1SNTgXgmiUhmNnqBsS5nuJjEHTbjw0eE+6xWpKoDW1F1X07fWxOXZVjlCOFPsqhhHI
         CCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7EyIA8EreeLF2YPOJ56vdmUeNKSfquRh5NhaoX66P1I=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=PzBRwianL265O7H4+Xh1EynB8Uz19N89uiqKUGo2nG9DaVB+4mFHJDvvE3HUocKP3H
         1HdFGIvmZmGreBLvOOEtSb5stz7XiloK9lo/iGQ8tTLbS9hooBHfefOWZU3/kRbe8ys8
         AY+qNFTta10d6v0agcvXaQEKDiX10C2dii4P3pC3VldCqtOTQZIOyzPpv82I1ifItaUA
         CCGv8ahHgu+jw0QWkKvofHOlgcYp0Jdz+9uzw5cTugNwRaA5BZ8UkNSBFWtZpzm4BkJs
         o76lcsT5nFMYA7onIlV8N8QbyJDh8EzYYeKelumhXXBiOoJWYVHvx2RtgWVtSdtnr+P5
         UVUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788975493; x=1789580293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7EyIA8EreeLF2YPOJ56vdmUeNKSfquRh5NhaoX66P1I=;
        b=leZ5+d6NUdcJgqFlIUK9KA54aPruqVjva4QRKzWlMIZyibWEIC7AUjHn1t83n7pe/6
         yO8jwyqZ4aIcNBCS/etxJiSgZtfDsFM9022DA8e+rVguv3xge/XkiX9XkQh86k4CkdoS
         1S1G7Hs6u/ywtfF9xUwemF66k35frmvF9nZ2GcLQihtW7Cc769R8nhjs0e5NNNYkgXkG
         /veySqNrYIcf9+m+n0oYDfxD5NBB/e3kX+RqNbQ+rw7hbSZ5GOi9xRFS+m3rfYgig0OC
         ilyr6Bsm2dgIzMtSiZCsQaFq5aqZ7xF8bBL7xW7SMjOCUzE5XhRHKn3Ek4VLZKqP/Q1e
         1PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975493; x=1789580293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EyIA8EreeLF2YPOJ56vdmUeNKSfquRh5NhaoX66P1I=;
        b=jJnhl4fm4glrrOnC8AKKUH056tVkM2y3ybxqRXsZ8v7hLXOph/9S3sJ/x/PxwmQaPs
         R/rh2lvkOC4VVpRnjAfpda4FWsFUhccpMuA9TLj3+XrqI9eKDafi4+NtuVvp6jJGZEsB
         inCrWHZqp6/9T3akbHIy9rYFJ3QCPRPs46wVLB0lcxg11UzsPHCNozvkBN/VecH0G7ok
         A4o7q9yT08drrVmw9i0vhgapIwm6wHP7srLimo4MAamI3DHZhWZ+hhXK5TyD1FEA7vtw
         FlzhzowTaghNb493xQkfQe0T9UqFD97MFIlIFJhBr7Vhb7FHX+roK9id9IZtfDXs/Rty
         +Ksw==
X-Gm-Message-State: AFuF++n1ZBCtrvYM3m+40oQRKBplwLlI31etQrCtqg6i/6czwaq4P4Bo
	M9wDmlT4ZeuedVCcPfjmE/LsyvNM2rgb831xbxAOm89Wlrks0nWG2J9f3axtk8PqDbb2+K8uQAu
	o/5YU0wjRkib0GKzBPsavLlHx0T/6NHc=
X-Gm-Gg: AYBFou0MlilfNNDcad8GRKp2choI3mcPek0OwRdreWnyjG5irlealUotavP5YAxXIyI
	C7+1Ims+NkeUqJlt43VNouDPT9VUu+gXuPfWqjWCBXd4f/iFWWBPx1NeyDIvBXz4Zn5futAH4YT
	Nigmh4M1dievDmVHJxGkle1BlmBLnstFZR3jweP7Y+Ytac6550Fp+msXgxczlQ4SQw4BHA0M7Fm
	NzgZTSlkAvH/9R6Ix3Txy+Ui9QjyGNMln9Ez4XdPAoph5oyBdRZxluvWh9gA3US7VCHjf5xNnx9
	sDmQTtz5n0iqfpZ4Sbozg3Tn/Y2774H/iG+EoWqNFAA/BmtIiJc7daTBvik64q6jbOvQ0Q==
X-Received: by 2002:a05:6820:1625:b0:6b4:3303:d1ba with SMTP id
 006d021491bc7-6b6fb3df307mr19691151eaf.8.1788975493452; Wed, 09 Sep 2026
 10:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-3-ameryhung@gmail.com> <2bc0fc604c11468717d136f444f0a46f4ba716d1a2b5b9371358a8aa5be649d3@mail.kernel.org>
In-Reply-To: <2bc0fc604c11468717d136f444f0a46f4ba716d1a2b5b9371358a8aa5be649d3@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 10:37:59 -0700
X-Gm-Features: AcwNN1Vpy_X_a7VqXHQkAcLTMEB4f0YiyPVgGRq1z5TkUhj7yj3ITGBawxFBECE
Message-ID: <CAMB2axP_afbrc3p7g1x5vVNgV+=6R=izHQ+7tO862ym=KGLWUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 02/22] bpf: Address check_func_arg() arguments
 by argno
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:44=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > check_func_arg() derives every argument from BPF_REG_1 + arg. That work=
s
> > for helpers, which have at most five arguments, but kfunc arguments
> > beyond the fifth are passed on the stack.
> >
> > Switch to the argno_t addressing used by check_kfunc_args(): obtain
> > argument state with get_func_arg_reg(), use argno for diagnostics, and
> > call check_reg_arg() only when the argument is held in a register. This
> > prepares check_func_arg() to be shared with kfunc verification.
> >
> > There is no functional change for helpers. reg_arg_name() renders their
> > register arguments as R%d, so the updated diagnostics remain unchanged.
>
> The changelog lists three edits this patch makes, but only two of them
> appear in the diff. The first two changes are present: "obtain argument
> state with get_func_arg_reg()" and "use argno for diagnostics" are both
> implemented. However, the third change, "call check_reg_arg() only when
> the argument is held in a register", is not in this commit.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f49c90beefc5..30e1f7a7553e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8769,10 +8769,12 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >                         int insn_idx)
> >  {
> >       const struct bpf_func_proto *fn =3D meta->fn;
> > -     u32 regno =3D BPF_REG_1 + arg;
> > -     struct bpf_reg_state *reg =3D reg_state(env, regno);
> > +     struct bpf_func_state *caller =3D cur_func(env);
> > +     struct bpf_reg_state *regs =3D cur_regs(env);
> > +     argno_t argno =3D argno_from_arg(arg + 1);
> > +     struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, arg)=
;
> >       enum bpf_arg_type arg_type =3D fn->arg_type[arg];
> > -     argno_t argno =3D argno_from_reg(regno);
> > +     int regno =3D reg_from_argno(argno);
> >       enum bpf_reg_type type =3D reg->type;
>
> [ ... ]
>
> > @@ -8786,9 +8788,9 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >               return err;
> >
> >       if (arg_type =3D=3D ARG_ANYTHING) {
>
> check_func_arg() still calls check_reg_arg() unconditionally:
>
> check_func_arg() {
>     argno_t argno =3D argno_from_arg(arg + 1);
>     struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, arg);
>     enum bpf_arg_type arg_type =3D fn->arg_type[arg];
>     int regno =3D reg_from_argno(argno);
>     ...
>     err =3D check_reg_arg(env, regno, SRC_OP);  /* no guard checking regn=
o >=3D 0 */
>     if (err)
>         return err;
>
> The guard that would implement the third changelog item appears 20 commit=
s
> later in the same series. Commit a490f49b0c4e ("bpf: Check helper and kfu=
nc
> arguments in one path") adds the conditional guard:
>
> -   err =3D check_reg_arg(env, regno, SRC_OP);
> +   if (regno >=3D 0) {
> +       err =3D check_reg_arg(env, regno, SRC_OP);
>
> with its own changelog explaining it will "skip check_reg_arg() for
> stack-passed arguments that check_outgoing_stack_args() already validated=
."
>
> This matters for the stated goal of preparing check_func_arg() to be shar=
ed
> with kfunc verification, because the new regno can now be negative.
> reg_from_argno() returns -1 for an argno below -MAX_BPF_FUNC_REG_ARGS (fo=
r
> a stack-passed kfunc argument), and __check_reg_arg() takes a u32 regno a=
nd
> indexes regs[regno] with no bounds check, so a -1 would become an
> out-of-bounds index.
>
> There is no runtime regression at this commit: check_func_arg()'s only
> caller is check_helper_call(), whose loop is "for (i =3D 0; i <
> MAX_BPF_FUNC_REG_ARGS; i++)", so arg is always in [0,4] and regno is
> always 1..5.
>
> Would it be more accurate to drop the "call check_reg_arg() only when the
> argument is held in a register" clause from this commit message, or move =
it
> to the patch that actually implements it?

I will move the change early to this commit to reduce churn.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
