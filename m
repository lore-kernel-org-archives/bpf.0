Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738143F54A0
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160223; cv=pass; b=MNPnkTOgInegUaG5dxdh9Iy51lNZur6HIUbTzvzhxbUac9jPYfG6E4DUhrBmoLwKBnL2tlPtvi9FMwpvEtlMY0Gka8YA7O7mkxIBJ9eCBTE2hvECMYWObKb2uh4t4Qhvw+6fzuxoqKOxcJlOy4oS9wC0/EkRwYnE+DD1bb2L+Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160223; c=relaxed/simple;
	bh=9Jgm2FO/o1Ngm5CMWr0tKMwtsRN5483k422YkFCi7/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opGL7GfdjDpFkvA5VXiOcrrq8BdWvlFKGiz3PLFUIxPX/+nCjzMNiL7alkqRmLIzlouFf1sNXHt+Qa0S/IGWbKKUOQFdBQXScnkPG+WE1Z8S3IZOkf98fWv74Ek5OSGfQ4O69erIhmrZ3yAhWgrRZYERF21+XB/3m0vvHSXY2RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlBUgvKt; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlBUgvKt"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7b4ee3a88e1so8140697b3.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 06:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778160218; cv=none;
        d=google.com; s=arc-20240605;
        b=WFIKnJRB5lkR5o/CUJu/7mzIOVMqvNSdNaXRRqSWVj2vLIGV5dHJGSQOrIKIU53nEr
         RJ5+P60Fgpib3pONcChIufRQPbAYhj/5F4BaViX2UEoqpqUw0WNg+fYEKCdhV9XTtjOT
         0L3ulMdI3Dv4yV1tW5LyJ1qlEsJFXjR3WO+DsSx1IYt5aBYJ5glvcOY/R4PUoOKuWk6J
         Dsq2SVoJd7n3ztCG/4i/A8BiEjk0sY2nibfSGiVnNAEF82FODc8/G7VRK310uGRXltNX
         z4jflCXEDKn9adZD58q4a6BQbv7V4wod6VMKyQmD+ALN7b4AiFukBkFNqJQ5l0hZxBzV
         gjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W6smblTfezSJWX6RvWSVUMERv5fpI/QdrqhW+dClZI0=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=HbTWbb7JKk16BvdRf/9/ou2uzvEokMb+IbVfj2jMHeaLIjSByQIoNeLvSBqyztQ3BO
         Bmxzuu6lNNCMJbvS+BF7fL4kEAabhqIpwc3Tov16ZamojG/IPzp7ia1B0QenUvcsVcw8
         95fpNGMOjz2r2ig6iey+DZA/Al2wg6UA35bjUxpK3tFuQ3Q6KuzX5wnzaUzwvoW/P2vw
         0msq6s2yiUxa3iPJMB2TxXDOojplsDXvbUeC2iuVjv4LWxcakLAnafVk0ANx5gfPgO1i
         CFS63p2RZ1XkDA9IZ8ADO1WlLoo9l49LGFalHHE1UaaDxp55UqkaMRbdRHgfHVCxjatQ
         asJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778160218; x=1778765018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6smblTfezSJWX6RvWSVUMERv5fpI/QdrqhW+dClZI0=;
        b=DlBUgvKtrbcMcWnhuR1OmfZM3D8wi0r6SkOOw52Llie9V7W6Qvtr3YbCeRx9xVgsAM
         AwWixn5vTkzdYUtlD6VyeFYO59Y+pY24t+2TNoGOQ+lEBe0HML43/l5a/+ZhIbUjmRJr
         yLVoazUw8oPUDIdoamtPts82eb40iqgbUXUlnRVJ7S5AHkn8q1B4Zie9wsaZ2I2/OhV4
         HzaQo6WHT/7/JLJRsYn8iUt1HCLtThl/AJpG+TZ65NpOKFFUwNLU38WyL02qKav+bWwG
         l3Q3KnkulGxCDljpzwFhAZEEXWcSzU2V4rBWxNRlG1dA1WNrZ7w0Q85oOdr8T6Gesshh
         AU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160218; x=1778765018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6smblTfezSJWX6RvWSVUMERv5fpI/QdrqhW+dClZI0=;
        b=bX1IPfTE0FraghguCrp3ide1aE/86kEcnQuvjeal86vYb2SAxp7M5CDLH0/jiBjXGr
         YvyX/MpMIeAwk4KQ25uS5gNk6d+XOF7LMzCBKhE741U6VpLYtKhkg7oa5ZNhSz/E7ZOz
         2YgCfvz0UW1D32OKVgM/P5+vUDuMPUQxTKYkEwCL/Nws7zIUUu35T6QEnkcoRjVxJiER
         vuar0S/49YJb1yLfdMFKQcFLM1mCN8jZ0b+P5qMN+BVtsh7oYSDq8WvsR6AU6qEEGEJR
         lmma62hRfwe2sJjvEHw7zlX/x+pqNRgE0BnLvMaQKXlwWwZKeJ6bLdKI9sWZ8XKazHHx
         3qIQ==
X-Gm-Message-State: AOJu0YyxE1wAL3/T1va5fRgYNU7pkttakDsBRUqMVsdrFQMN5LKpHmtP
	+1MlOcpSEOMvcTtUZIKB31DwJTIsrng+h34Qy3BVqkewXP3aB7crWFNqPOkYdZtLPHXQn0Wvdaq
	e3Yj2GIBomjhLh/0bjqG2dimDl+G/xa0=
X-Gm-Gg: Acq92OHauvoBDdukgoZTvo/JFuUbtYjo2KERdgI007R4ao9sJzW3/nA6cJOSdTbUGV0
	F+cJTUCEcWNimz6ceo7BcXGz20yiL6/BSHn/XLE3B6KuGtF5FhGc4LByx5Xer8Wu+yKQP+gKvLr
	+wkyWTo1Mcpm9MZirJijl72q8eyRan+Gv430tZA5EACt4Jn44pfxwYyCfXZ1oFeD+BUTFxruX9A
	VaEw3khjEGHyqg4qcndqauAZW635/OaUieHlIBnvUUYhZOEd8PI17GfYNiqiOTd14cwP0WzjPrG
	4jD8A9GY5+ovJvpgXvRVnMBmZbBobw==
X-Received: by 2002:a05:690c:dd4:b0:7bd:7b55:ebdb with SMTP id
 00721157ae682-7bdf5db91b9mr82957967b3.5.1778160217790; Thu, 07 May 2026
 06:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-9-ameryhung@gmail.com> <20260506235915.687C5C2BCB0@smtp.kernel.org>
In-Reply-To: <20260506235915.687C5C2BCB0@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 15:23:26 +0200
X-Gm-Features: AVHnY4IGekU0O8uTCO6uo7TaWUsiNxKEX4SPGMTBCHCQrpoUs3X0nGFPkKlwMTo
Message-ID: <CAMB2axM9DM+6CD02sr7Qx56V-yp4Mr_=yRebC0PktthNTh227g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for helpers
 and kfuncs
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 12:59=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Hardcoding meta->release_regno =3D BPF_REG_1 for KF_RELEASE kfun=
cs creates a Use-After-Free vulnerability for kfuncs releasing non-first ar=
guments.
> - [Medium] Incorrect evaluation of the release_dynptr flag leads to false=
 rejection of valid BPF programs.
> --
>
> commit e0e1bbafcfda45d42ce5635352bc4b69c0d713c6
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Unify release handling for helpers and kfuncs
>
> Introduce release_reg() to consolidate the release logic shared by both
> helpers and kfuncs. The patch determines release_regno from the function
> prototype or metadata before argument checking.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 542912c7983f7..e40f09cefa291 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >       }
> >
> >       if (meta.release_regno) {
> [ ... ]
> > +             struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> > +             bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) =
&& in_rcu_cs(env) &&
> > +                                (reg->type & MEM_ALLOC) && (reg->type =
& MEM_PERCPU);
> > +
> > +             err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.=
ref_obj_id);
> >               if (err)
> >                       return err;
> >       }
>
> Does passing !!meta.dynptr.ref_obj_id as the release_dynptr flag cause va=
lid
> programs to be rejected?
>
> If a kfunc or helper accepts both a normal PTR_TO_BTF_ID to be released a=
nd
> a referenced dynptr as a normal (non-release) argument,
> meta.dynptr.ref_obj_id would be set. This would cause release_reg() to
> mistakenly invoke unmark_stack_slots_dynptr() on the non-dynptr release
> register, returning -EINVAL.
>
> Could the release condition be strictly derived from the argument type of
> the specific release register instead?

No existing helper and kfunc releases a ref_obj that also has another
dynptr argument.

Kfunc already use this check and I choose to make helper align with
kfunc to make it the same without overcomplicating things. In the
future when there is a universal proto for heleprs and kfuncs, we can
check meta->fn->arg_type[release_regno] to make it more robust.

>
> [ ... ]
> > @@ -12083,6 +12107,9 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifie=
r_env *env,
> >
> >       meta->kfunc_flags =3D *kfunc.flags;
> >
> > +     if (is_kfunc_release(meta))
> > +             meta->release_regno =3D BPF_REG_1;
> > +
> >       return 0;
> >  }
>
> By unconditionally hardcoding BPF_REG_1 here, could this create a
> use-after-free if a kernel module defines a release kfunc that frees an
> argument other than the first?
>
> If a BPF program passes a dummy referenced object to R1 and the actual
> target object to R2, the verifier might drop the reference for R1 while
> retaining R2, even though the kfunc frees R2 at runtime.
>
> Should we still rely on dynamically discovering the release register base=
d
> on the argument type to avoid this?

If anyone is developing a new kfunc whose ref_obj to be released is
not BPF_REG_1, the verifier should scream "unreleased reference", so
the bug is unlikely to make it into the kernel.

Some reason for this approach: The longterm goal is to remove the
dependency of bpf_reg_state from kfunc proto generation. In this case,
I want to tag OBJ_RELEASE by looking at the proto. This is currently
impossible since we haved enable decl_tag for kfunc arguments yet. I
think hardcode to BPF_REG_1 is a reasonable workaround for now.

If this sounds okay. I will add this temporary constraint to kfuncs.rst.

>
> [ ... ]
> > @@ -12622,13 +12638,7 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> [ ... ]
> >       if (meta.release_regno) {
> > -             struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> > -
> > -             if (meta.dynptr.ref_obj_id) {
> > -                     err =3D unmark_stack_slots_dynptr(env, reg);
> > -             } else {
> > -                     err =3D release_reference(env, reg->ref_obj_id);
> > -             }
> > +             err =3D release_reg(env, &regs[meta.release_regno], false=
, !!meta.dynptr.ref_obj_id);
> >               if (err)
> >                       return err;
> >       }
>
> Similar to the check_helper_call() case above, does this global dynptr
> metadata check safely handle mixed arguments when releasing registers?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506142709.22=
98255-1-ameryhung@gmail.com?part=3D8
