Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA20224B1E
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831111; cv=pass; b=uTZlyTE3jA8qaGuQ0X4POBFnIdj83pphNWOhzXNSjCXA7QrR6Q/txZmPaPIwd8uu7iiAkcmBuj+zpNocCzv+dZpxcAdU0YR8777KtQMaRGK/oTUXzxt14plqg1d4577uynxMsvGj7e3Qtjs8slxxBMTclAiZmfvRz/A3Z22K5+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831111; c=relaxed/simple;
	bh=x5yeMEmRp8Gkz3QWIxoiqkoCMZopkCi9a/qaHiAVJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JskPuKwlrXEgHPnvrFbvivHbzKzgi06hV1EdMdI8nKhFOHr9ldD7evX1Iwp9061nYXYfL5BJ9UXHm1729ivxxo2kfg2CYOYuec2cxpulDOmcJhw7+2/NTpZSEyvn/Ac7aX0wIGwP0y1Hub1ZC+L10ywJ4Q7+t6OC7P6rTGNDYB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTjzBioQ; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTjzBioQ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a06b9eso8951437b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784831098; cv=none;
        d=google.com; s=arc-20260327;
        b=kYEF1KMti7ajuigAtdpww3x54fcQj6tgki5zmCAotPl7rtKbAs8Ns8rRQ6ORHY8KTq
         2Bo38G7dnDekS/q0pSBYpWqeyvT2qJBHvhzGDkn3IcEDlyAKUqUTSh0FtnELw0ULdMCv
         6xhxpVSHjtCUbvhw1jhqkR5/Y0QiO+/xYe+48yimRtk8wd/ZqFLjo4Qq4wgS7+PsZZrU
         dWeZlRm4oh1WfXrW6LHW09Y/8+vR8ovhund/l2Tar5gqoeravo1VeKhRELGgmdmIsUAa
         6P4DP9+jf/xa+Rb5FFSUPaOsY/b31F+6wkQ/JkWdR9bvE5VOHZD6EShkH0wD7osYLH7p
         Qkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0oJYMqyNkCHkL6Hpz5vc/KbsgIoJjAK4W7sArgGDP2s=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=kLGEJcbp78bvDkYDu5/1A9EyB2OtNStADmM+Nu2B4sS8jFH+XUVq4IP7drqjIg1pZk
         h8cPVjgY5aIQTnfTlBbe4CZUFFfu1XhK0SycHHpjrT+AePZRG47ZF92qtxzevX62ma6b
         SawK6FM5B7/Bl3q8OKFJuHRRTMSU9cXxEqdo+RVr0NEOghKb41TM74haMBaZMMBIsb9i
         8Gew0WnhwLv/v7v0TWSyD2uD7xfWQamHt0AQ3xsZ+sZ/7nmcdU4xNlfvEGh4GgKlQ9n2
         N2hXA3Cj3+LlUQw5r9URX+18FjmX7y2AdzUxTWfEyKdzfIpCTmATiPA4yB75fGcDZkAQ
         3i6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784831098; x=1785435898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0oJYMqyNkCHkL6Hpz5vc/KbsgIoJjAK4W7sArgGDP2s=;
        b=TTjzBioQY7jXNjNQlp6fWTUa7/xSZvjDaJnMEJuaTmnc68mb2io5g6amSJyYNoKP7W
         gwbxF77qX3YJaNOKqTLjNQzmRCGFQuPoxkPu6LqXyzFVI6qLCbq9qcJY309sOdJgYh0J
         TBpcD+A4nkWXoFFeoPVP7dlFIaamaXocdfbRMdPU9MwkG1/wFIj5q0xT9dmkwvNiu+za
         lj1TfGcOHU9LMZDKtiQ+5/SVKdlz+ocu5ndchd7n4skNsX0dpye32I3FJ2R33/6tKtel
         jT4HmVys0Wa6fTQM9xqKoxQvTBojEnAYaNQA+wRSaY6sStFOT/+DuXmgcfv9jxvXHeFS
         woCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831098; x=1785435898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oJYMqyNkCHkL6Hpz5vc/KbsgIoJjAK4W7sArgGDP2s=;
        b=Oo9KUV5ArwCbr/l3Qk4vI4DPKrG1qBSmIGstU578fH+5PmGPOTyNBw43YLtIe5ZFlZ
         bX3b2Nk1JMZY6OB6Qpz983Q1HN3VntddAvUXEO0jR/sh3wvmm2BClYTRKw1qjy+s+DPN
         vXfnpEx7jzYIc7KzTjMNrdWxwx797tmUelx2F3pC4g74d6xhV+5aNyeJWnQXLM15v3TA
         NN+3lx/gU9GUn3d7v+ywFq7WvXqg91vyIyfpWCJhfao+8tE2wH1kxZAn1TxSZ2S6JtPk
         Z0wmfBMwa/qJp19A+nqO+mqgIK6JQS1SpiKBpEYPp1AwFZzJbJ4msIfDMMNL8aoaTqsG
         4DpQ==
X-Gm-Message-State: AOJu0Ywg9Jn6WmS5bAsWLfk1qN/SvKjWyTd0/w/sXSU0GYfIyHce/whB
	IZjhHQ9G+JZ8sfMtyH0WRXnY8ZNfP0MyW7g4Yj01PjjIW1NsKRDscWl4PyUggdwQtX6/0NFkMV6
	ZZZZxqaULqoPRzlaYKmPOTw+bCNkvBPytFfMG
X-Gm-Gg: AR+sD12WsrLspWTnzXqMV1JBD74FnI2MLbS0bUdtTCYFB9i4xM1/mLDZjFQ8Iv+oDVk
	hb0w42mTLx2pnLo1o+FexWKGkTBegjvQjUxq3F5zbtZi74WnoFhaj6hsD2gQnukCGDzZFEbi51u
	BGo62vg4g5iinWBZ8ivKexFTGbI38Jh1lMgCKnnvQLX322MSjiTM6eZRNRLdBdeGK7evUrU4nZr
	puIYXs4dHqksWKHxh5uGWnasmFGsUFftHJfZzvP31CaUeJEccnrIxe3/WC4Cw==
X-Received: by 2002:a05:690c:670f:b0:814:5840:2f92 with SMTP id
 00721157ae682-81f4c2d2b76mr13363727b3.48.1784831097652; Thu, 23 Jul 2026
 11:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-6-ameryhung@gmail.com>
 <20260723055202.984761F000E9@smtp.kernel.org>
In-Reply-To: <20260723055202.984761F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 11:24:46 -0700
X-Gm-Features: AUfX_mwR4iMhFVRnwBs9R_fx3dAX9M0ehCQCWJcc8X_OOBFEauYOdSe_7ov9qTA
Message-ID: <CAMB2axMnAV=Dkt28YwHsGm15myYWdG0L+D7EoaOmjhT3bydWkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Unchecked nullable pointers passed to helpers with `size > 0` ca=
n cause a kernel panic, as the verifier does not enforce a strict correlati=
on between the pointer's runtime NULL state and a zero-size constraint.
> --
>
> --- Patch [5]: [PATCH bpf-next v1 05/18] bpf: Check helper and kfunc mem+=
size arguments identically ---
> commit 209f89ec76658f4c319cb2f0b37557c6e39026aa
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Check helper and kfunc mem+size arguments identically
>
> This patch unifies the memory and size argument checking between helpers
> and kfuncs. By moving the may_be_null handling into check_mem_size_reg(),
> it prevents an issue where an un-narrowed map-of-maps value could be
> passed to a nullable helper memory argument and leak kernel pointers.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 29d45636c28b8..6520742d51b58 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                             bool zero_size_allowed,
> >                             struct bpf_call_arg_meta *meta)
> >  {
> > -     int err;
> > +     bool may_be_null =3D type_may_be_null(mem_reg->type);
> > +     struct bpf_reg_state saved_reg;
> > +     int err =3D 0;
> > +
> > +     if (may_be_null) {
> > +             saved_reg =3D *mem_reg;
> > +             mark_ptr_not_null_reg(mem_reg);
> > +     }
>
> [ ... ]
>
> > -     err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax=
(size_reg),
> > -                                   access_type, zero_size_allowed, met=
a);
> > +
> > +     if (access_type & BPF_READ)
> > +             err =3D check_helper_mem_access(env, mem_reg, mem_argno, =
reg_umax(size_reg),
> > +                                           BPF_READ, zero_size_allowed=
, meta);
> > +     if (!err && access_type & BPF_WRITE)
> > +             err =3D check_helper_mem_access(env, mem_reg, mem_argno, =
reg_umax(size_reg),
> > +                                           BPF_WRITE, zero_size_allowe=
d, meta);
> > +
> >       if (!err) {
> >               int regno =3D reg_from_argno(size_argno);
> >
> > @@ -6920,6 +6933,10 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >               else
> >                       err =3D mark_stack_arg_precision(env, arg_idx_fro=
m_argno(size_argno));
> >       }
> > +
> > +     if (may_be_null)
> > +             *mem_reg =3D saved_reg;
> > +
> >       return err;
> >  }
>
> [Severity: High]
> This is a pre-existing issue, but by clearing the PTR_MAYBE_NULL flag
> temporarily, does this bypass the verifier's check to ensure the size
> evaluates to 0 when the pointer is NULL at runtime?

The mark_ptr_not_null_reg() here doesn't bypass any NULL/size check.

The "size must be 0 when NULL" rule applies to a known-NULL register.
It is enforced in check_helper_mem_access()'s default case via
bpf_register_is_null(). mark_ptr_not_null_reg() runs only when
type_may_be_null(mem_reg->type) and never touches a known-NULL scalar
so that check is intact.

>
> If a BPF program obtains a nullable pointer (for instance, from
> bpf_map_lookup_elem) and passes it to a helper with a size greater than 0
> without a NULL check, the verifier permits this because it verifies the
> bounds as if the pointer is valid.
>
> At runtime, if the pointer is NULL, wouldn't the helper execute and
> dereference the NULL pointer? For example, in net/core/filter.c:bpf_csum_=
diff(),
> if from_size or to_size > 0, the pointer is dereferenced by csum_partial(=
):
>
>     if (from_size && to_size)
>         ret =3D csum_sub(csum_partial(to, to_size, ret),
>                        csum_partial(from, from_size, 0));
>     else if (to_size)
>         ret =3D csum_partial(to, to_size, ret);
>     else if (from_size)
>         ret =3D ~csum_partial(from, from_size, ~ret);
>
> Similarly, in kernel/bpf/helpers.c:bpf_snprintf(), bstr_printf() could be
> called without checking if str is NULL when str_size > 0:
>
>     err =3D bstr_printf(str, str_size, fmt, data.bin_args);

I'm not following. The two helpers in the example are taking nullable mem a=
rg.

>
> Should the verifier emit a runtime check or enforce a constraint to ensur=
e
> the size is 0 if a nullable pointer is passed to prevent a kernel panic?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D5
