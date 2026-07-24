Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BB3B47E0
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910564; cv=pass; b=U+PYo1HDi1sO6RjBPe/uzQQKwMmdM7VGoY1PGDich/S41MJae4FOP2FF3VsOsR8w/HoqphHUKCDbQZCBKceHuF6ryKjQSWPDc0dObvutRkMWi9MqbPnWf8HFe7F3NwYCY1tP+B/N/JbMw71/x8mdKxm+Ytsnp2wropJeZUGG5XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910564; c=relaxed/simple;
	bh=eiLri7nlGvjARufQYKavsqrnbicdoE8hXtUZaLQQeSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrGSSEerQvOMUikZSDZ+KYQVvJxvYgjTeyuwnCnY37E7FmYaTXFV4WE20jpEdN8X+ImWEJrwguqu9R4yCyfm8Z4cTXm3OSY+yhDONSC1E9XFzwdLVRFpUwVG5qaCNKG7O47L3B5lre+/ivEFzlVKzSOaM4hubNQAkuC/3jeCIwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld4zF+a/; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld4zF+a/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81f52945098so7512317b3.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784910562; cv=none;
        d=google.com; s=arc-20260327;
        b=MTTyma1U+V4urVH1ye9M0FMzEVrbohYFnAxfwIy86SPBsMg2OUZBWpJBdaNb6M1KwQ
         Y6OeddASD/F8hidHRMWSJeW65HlHZsQ/abhBsep/iMeJ5hPny/d0I1rgbIA0RVSc2Awk
         tZU77kmxAAvY7wqI61R7Oo8Vf2Gt8IW9WUuH9rbvQBFM4aSeFf1O+gagV7ZPPwN0461U
         +eVf6i5boGmR7FWUwvZ6SKcQqiT918TdP+YVHL01NJsfYVEGbcSG2VtlSLVEuq703LhT
         pk77dC6DkDFZcKc9Zv9Ud0IlaYo9UbjAUxsKv5gxYuo++W0iInNg3OGxhhZ0/cF0hogX
         KETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o0E+HrKhU17MYywCk8O/iPWCgtKjnfsVN5oK8hiTFYg=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=NFt9+EfPmu3Gcvl3UFNE2odISFaG9eRMkiH5dcZuByJ0QO1SfjL/RdJAMlx7Mjy87k
         n+zJrOouHUlfDkOQzmu5ADBIfA7LIObTTBZhLFz5EdgIDqyODIm6qQ8mmj6DOavPQZj3
         Ba4crMsDlF5mm9rSvLMXuxovKMdWeu8IdbglMI00GDTeMz3uhDr4xuEHEhrmS95FpePP
         3OhqUqMpYMMJwVx9L6fjMW+YFmkw57hMQsqTh8ligvJduJekfQu31FnI0ZYD3X08dWGM
         I04z3OlH266WSkY5D3o7FoFpYJxEayxq6djpkjNxTk6rS84OT/vPYGDwyTIF0rKSHHPv
         4emw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784910562; x=1785515362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o0E+HrKhU17MYywCk8O/iPWCgtKjnfsVN5oK8hiTFYg=;
        b=ld4zF+a/9oaiNcLI5+aP7ccETYoyM0o59OrjmaqrcM3dFa8jDNOxHbgn3HDiL6difN
         n8bbd8+DkgdXDTfUp7nhCMhvO9xk3LZ23H+cqn5/6xxFFirSEFqze4tg/uncQtmu9laT
         cOenmNfNK5mRNOS4Z+aS7UswDv3iz+1joDIZCEKW4PihaJHtl4Rf2KOtU0ew+ACiNRtd
         w0UtuXU9mn8hxCZYx2oOThRyij6JMLVViBE2570l2cmhMHlIvK6PMzxzbL99PCqZPuFv
         /xLl/8WktH/50TEwts6AbjU+BnjZl4jnqbldnoE2klSgIBOT/f0iV9898CW5kVTnfWSn
         sX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910562; x=1785515362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0E+HrKhU17MYywCk8O/iPWCgtKjnfsVN5oK8hiTFYg=;
        b=KMkwPF1CsZTpFFLA82Rv73O/nIVB1fbp0J+uJbh+dsAmH46ImnsXUXQ4zwWFj+7Oic
         D1BERKIIFn6b1Ko5K1QsVw3RTngnS55kLqALCgbzFWWvxCUqA+YGqqiDG5gkyFDNQOez
         ypee5IpsxZGy9/dVisTUOk6uSJVcMTYuW/dwwlcUdqzW/uhBJ/ApkLApfrYtIiYXkvS0
         /IG3cAV1jyZAsTWZ0xPHF+fdJbx/lMiGQQEBbP4cKts5o+oWVK+FLFmtEYgRBDbK711H
         dHBSnkEuNgh/q0LrlddpnvUj8SjgRHinwmUYn/TnQy9enM0NDgzX6sWmtrNKwXQJqLEH
         iXaw==
X-Gm-Message-State: AOJu0YxCA33+GHppbl14aHtfKkZn063jVk0V7ONKYkNdrNvJJsRAx1od
	LWl3PR444qkYFda+q8xuNIH//ffRCUMHZcGJoThZU0QVgpP2GIN0v2346m+uB/JqP5ZjfZq32XJ
	SoIeKUHwhbtjkVuSsKfW0IdQIjjPBPOwG4CzV
X-Gm-Gg: AR+sD13FAnDRTkyEFEg7vksYGZ0ZjNHexfYi0NbwwOD7UrgGi21qArU+s0HUuuYuLqx
	0qYi4oJDf4A1I//1BLekPrFSATcXJOWI4MMt8of6orcPtiI1xYCKp0GhXpYmVikrp5MPGjILKbC
	FOASmvV38Fsoe4IM0mDbilTbPF2RgW8ukeNsm5rWug6jL76UC7m60dBf9tmwbCDwqELwfq2PqfG
	/tSe6ag54Z8dbDGUYTNVGokVKegNFkT8zNNHCeJ9rohzDmZtt+1vbWGhEUiyA==
X-Received: by 2002:a05:690c:f07:b0:81e:c38e:4bf3 with SMTP id
 00721157ae682-81f63bcff14mr3477987b3.26.1784910562292; Fri, 24 Jul 2026
 09:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-18-ameryhung@gmail.com>
 <20260723080103.AE5CF1F000E9@smtp.kernel.org>
In-Reply-To: <20260723080103.AE5CF1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 24 Jul 2026 09:29:11 -0700
X-Gm-Features: AUfX_mxON2WAiG3iq5irnRXSgNH4j5x1p07ciXkqimDB5AI19VYzK5IjC1ulqzs
Message-ID: <CAMB2axPrsX+2fbKf--2M7oGBW68oWK1K+Ftt=SQpiYrcT0zvSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 17/18] bpf: Classify scalar kfunc arguments
 from BTF
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 1:01=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] The `KF_ARG_MEM_SIZE` argument type completely bypasses the =
`SCALAR_VALUE` check, allowing eBPF programs to pass massive pointers as bu=
ffer sizes.
> - [Low] Uninitialized variables `ref_t` and `ref_tname` passed by value t=
o `get_kfunc_arg_type()`.
> --
>
> --- Patch [17]: [PATCH bpf-next v1 17/18] bpf: Classify scalar kfunc argu=
ments from BTF ---
> commit ea739f7fbc71c6a534cb3103ddbdf3b31c5f391a
> Author: Amery Hung <ameryhung@gmail.com>
> Subject: bpf: Classify scalar kfunc arguments from BTF
>
> This patch updates how scalar kfunc arguments are handled by moving their
> classification out of the inline register state validation and into BTF-b=
ased
> classification. It adds specific KF_ARG_* kinds for scalars and separates
> BTF classification from register validation in check_kfunc_args.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 24858a38c34cf..ba2608592bd5f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12130,11 +12122,13 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >               if (reg_is_referenced(env, reg))
> >                       update_ref_obj(&meta->ref_obj, reg);
> >
> > -             ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> > -             ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> > +             if (btf_type_is_ptr(t)) {
> > +                     ref_t =3D btf_type_skip_modifiers(btf, t->type, &=
ref_id);
> > +                     ref_tname =3D btf_name_by_offset(btf, ref_t->name=
_off);
> > +             }
> >
> > -             kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_=
t, ref_tname,
> > -                                                  args, i, nargs, argn=
o);
> > +             kf_arg_type =3D get_kfunc_arg_type(env, meta, t, ref_t, r=
ef_tname,
> > +                                              args, i, nargs, argno);
>
> [Severity: Low]
> If a kfunc call has a scalar argument, btf_type_is_ptr(t) evaluates to fa=
lse,
> skipping the initialization of ref_t and ref_tname.
>
> Could this result in passing uninitialized variables from the stack by va=
lue
> into get_kfunc_arg_type() during check_kfunc_args()?

No because these are only used when the arg type is non-scalar. The
next patch also resolve ref_t and ref_tname in get_kfunc_arg_type
instead of passing them. I will make it less confusing by doing it in
this patch instead.

>
> [ ... ]
>
> > @@ -12435,6 +12462,19 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_call_arg_me
> >                               }
> >                       }
> >                       break;
> > +             case KF_ARG_CONST_MEM_SIZE:
> > +                     if (reg->type !=3D SCALAR_VALUE) {
> > +                             verbose(env, "%s is not a scalar\n", reg_=
arg_name(env, argno));
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     ret =3D process_const_arg(env, reg, argno, meta);
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     fallthrough;
> > +             case KF_ARG_MEM_SIZE:
> > +                     break;
>
> [Severity: Critical]
> Does this allow an eBPF program to bypass the scalar check by passing a
> non-scalar register as the size parameter?
>
> Because the KF_ARG_MEM_SIZE case label is placed after the SCALAR_VALUE
> check inside KF_ARG_CONST_MEM_SIZE, an argument that is exactly
> KF_ARG_MEM_SIZE will jump directly to its label and break out, leaving th=
e
> register's type unchecked.
>
> Could this allow programs to pass a pointer as a buffer size, potentially
> leading to out-of-bounds memory accesses?
>

Right, SCALAR_VALUE check needs to happen in KF_ARG_MEM_SIZE. Will fix.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D17
