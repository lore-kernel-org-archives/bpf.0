Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE833A00C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869331; cv=pass; b=KVuZtpcVF9oqWDpGv99x4RhNmN6WqdpXNPINxMRoR5bAOLElczLSd13wZ+NkhtAxT6PjCdlwT5T7XDpVpKHTzGPy49ZZ1wgIS63Zc4Bszw7Hf+sO56csO6W3z3oaaDpNinMpFbex5tD0jSnpcYGmTJ5QKWM4zbX1ctFOmeKMwOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869331; c=relaxed/simple;
	bh=gsalqXOcUjKW9MHMiojjZWGJnUBZNa7hXoHDRyXU+7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLe8CDCxpBvtfMmOjbLM0u/ATjZKciiUhUH5cjW6rLIE60pbf+u11Cdm00SItz3Q+oNgoncenbv1MXtStV35eHs2JPJpr/Wy72e6N5+Mx4cPdE+bCNg0nBG9TvmUL5JfC6M9v2Wwovi3HaZ4YyYGxO594U8xq73Go/9Z4HvbWr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKHIkmEb; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKHIkmEb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso2478324b3a.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869329; cv=none;
        d=google.com; s=arc-20240605;
        b=AClCKG0ObOVV+plW3ztHb+8ouDDPc78Xmse1Z/lEgQ+7jNw7Fww8YxQ0HVokTYuXkn
         b8H9kdubDVuWt0XEfE1DoN0q8gL3AuR5E9rKPebp44gbAs0X5Fv+twHOvgCrox/oPZPf
         5tlxtd5kYxik23SzJUp1Itqfz8rAPaPhNnuLnfdpydcr9rGPbjXopKsDyoOfpJEoOCtI
         96u6lw1EIjIyOFB98by9zj3wv42GBHxhhExB6CtDWL4hEtNP3t4C0I1ulEl+Tjngfy0a
         BfaK4uiopvMp5PaTGGXYN36fTR4pET8+XS2kakC/47MaF/Tn6aSfoZFefwpoPilVb0xo
         ztEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFGah+p8F0/itjwrIkClJy45WaW9Yg9hJTjIOyZclOk=;
        fh=ruRytyp1U3/Twvapv5y1mA5yA1sI6j9rkfCvopNa1BY=;
        b=ND7zL994OvX33WA26/7gjFH47KzTKNa+ICOzUqMeAesCoz/rwv9W7bb3lD1hN/8rTg
         c6AnUfwTZAec4K31W5rEtzLheWzN9G5gvbDF7+Oc6yeXXtdjLQ01KwoKkFmlcAF1dt/w
         IgVN9G6J5uaumcqTHWQp9KaPKETS1XG40ls3OZd9s3R3XMMM2obiXougNfOr1dOXBei7
         CJ1OiLJiPdpJTU3GNm5/grOMj1KF3SFdcAnctJ6T7womjDBYTxZmSCx4RiyZs5515P7j
         1uJMWct36wmlRk12qtDeslPoOrdWGOM6QGUPpMLrkOM3mMHciDXIhKxHA262bpabJOCg
         mJyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869329; x=1772474129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFGah+p8F0/itjwrIkClJy45WaW9Yg9hJTjIOyZclOk=;
        b=hKHIkmEb+Ak1xKU5JFpQryD4VGFadIsrzQDimpreXAFmbBFtIK91ffV8A8etLCf+gx
         C9+jct+fVEdU+aySFvBkAcqTzxNqPOhPwWxB06GQHsqPJeXyyeH5aFlWtCfSDspJyZ6V
         r+/q0FD4MWPVuxicHFDwYpTUgRXE2YO/f3IFEDEAPDipafJ3jfdWTemJgRgtvvFUSeoG
         T0FGoK4VqaoW87rE0/68QgkkWqncMK1jH9J/R7bivqnQpNg7I6JtIa/Z9LV909PGwyjW
         sVml0gASyi3yvdEElVEcWFM29XwG7TIP3daeZdswNYqfowzzoODQ3W1VVjmqhtcfDzYw
         ilTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869329; x=1772474129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFGah+p8F0/itjwrIkClJy45WaW9Yg9hJTjIOyZclOk=;
        b=ezJnhokcbNc9vfyzS1nuTiBJZpcSREmU2hvP4NOWSgSzZC/MeWy5aoeExUOriG5CJY
         0DU2iHcFBUBdiRRnlxjWbwL1tR3m/tOuuS4P4FzDLQ15jLWzeKB0F44X65Av1RgwYyHv
         77wHRotnWSFRasTFbkgIFIkKvnHakbnBKPNjwv7c+lVqjGVO83otDwGSBV5xEjCudlBv
         2hRiUD6Ab/MJqy39Mnz7JUZN5j+UTfP1XMm4L3X7hJnYv+QlYtGxSLrd0kqVq9QKkwN0
         Mm5pKw7dR1OY8z3fVktYgYAgRipA2oyAn5bHGR66l8f7QODsQ/iCr5/OL4iU4PMo65sa
         bBFg==
X-Gm-Message-State: AOJu0YybNWKSLKFX6aHZ7AMxA/ToiiZYG1z2VXpiIocZzWtyyS4jMyfx
	RHtN+PocYwHUNmznbC8fXqnFvU5tGdaZoU8HS0654rSkhbcpBy8m61wmyLxb5ww620t+JIAyjZX
	r0VWVEr4aPf0E9idiOg6gz2rfgusYmLU=
X-Gm-Gg: AZuq6aJpN6owSGQwjsKUnPCQlEw7husiAOnqYHSp8pwD14tzPG+gFE28KtLeN+orsyQ
	904PWbaPoE2KnN3k6ib43MqQR/FaGMGJYwC1ifHCPXCaNPOHLNLDoxTfgu3LVtbb3/R9Nyfo/I8
	62vsdVrcyT7S8BcsGToXNgSbpUdoP4F8F7SE34PS2uTvkXANzRqu8XIdk03UkrXPPZ1+4qLsR4p
	Z2WCX5p2Vi5NsvUA7xKLmH2TI/Xfwvse0rlJJGHQtbIPZpqgjBcNVbfCZ+mtCuYAqluWkNtFOtQ
	nfRdqBFYIzxQKukxQzmIZLm63o54hO3Jjg==
X-Received: by 2002:a05:6a21:a4c9:b0:394:5ac7:9001 with SMTP id
 adf61e73a8af0-39545e52274mr6728073637.2.1771869328966; Mon, 23 Feb 2026
 09:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771625484.git.josef@toxicpanda.com> <c0c2c805042fe889daca6dd43b86ba5e18725021.1771625484.git.josef@toxicpanda.com>
 <CAEf4BzYbyyAMnRo0Kb8K7D19+CUSANkOWnByX3BZdEase46ZDw@mail.gmail.com>
In-Reply-To: <CAEf4BzYbyyAMnRo0Kb8K7D19+CUSANkOWnByX3BZdEase46ZDw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Feb 2026 09:55:16 -0800
X-Gm-Features: AaiRm50YHOvEL-txelllfBs27-wA-sUf4cTc-A3EkMMi6YyyPR9EzhjbDPCkrbo
Message-ID: <CAEf4BzZ7tNJG4ex-2oh3zH2fGy9iVtTEimV_pJxj4ZiEBfv1KA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] libbpf: support appending split BTF in btf__add_btf()
To: Josef Bacik <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 9:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 20, 2026 at 2:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > btf__add_btf() currently rejects split BTF sources with -ENOTSUP.
> > This prevents merging types from multiple kernel module BTFs that
> > are all split against the same vmlinux base.
> >
> > Extend btf__add_btf() to handle split BTF sources by:
> >
> > - Replacing the blanket -ENOTSUP with a validation that src and dst
> >   share the same base BTF pointer when both are split.
> >
> > - Computing src_start_id from the source's base to distinguish base
> >   type ID references (which must remain unchanged) from split type
> >   IDs (which must be remapped to new positions in the destination).
> >
> > - Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
> >   count, which is correct for both split and non-split sources.
> >
> > - Pre-emptively calling btf_ensure_modifiable() on the destination's
> >   base BTF to prevent a use-after-free: btf_rewrite_str() resolves
> >   strings via btf__str_by_offset(src) which may return pointers into
> >   the shared base's string data; btf__add_str(dst) then calls
> >   btf__find_str(base) which can trigger btf_ensure_modifiable(base),
> >   reallocating that string data and invalidating the pointer.
> >
> > For non-split sources the behavior is identical: src_start_id is 1,
> > the type_id < 1 guard is never true (VOID is already skipped), and
> > the remapping formula reduces to the original.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> > ---
> >  tools/lib/bpf/btf.c | 44 ++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 36 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 83fe79ffcb8f..654fb9ffa01f 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -2004,24 +2004,47 @@ int btf__add_btf(struct btf *btf, const struct =
btf *src_btf)
> >  {
> >         struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
> >         int data_sz, sz, cnt, i, err, old_strs_len;
> > +       __u32 src_start_id;
> >         __u32 *off;
> >         void *t;
> >
> > -       /* appending split BTF isn't supported yet */
> > -       if (src_btf->base_btf)
> > -               return libbpf_err(-ENOTSUP);
> > +       /* When appending split BTF, the destination must share the sam=
e base
> > +        * BTF so that base type ID references remain valid.
> > +        */
> > +       if (src_btf->base_btf &&
> > +           src_btf->base_btf !=3D btf->base_btf)
> > +               return libbpf_err(-EINVAL);
>
> let's make it -EOPNOTSUPP (ENOTSUP is not a public error, so let's use
> the proper one), it can still be meaningfully supported if bases are
> different, we'd just need to add types from base and split parts, and
> shift all type IDs (but no use case right now)
>
> > +
> > +       src_start_id =3D src_btf->base_btf ? btf__type_cnt(src_btf->bas=
e_btf) : 1;
> >
> >         /* deconstruct BTF, if necessary, and invalidate raw_data */
> >         if (btf_ensure_modifiable(btf))
> >                 return libbpf_err(-ENOMEM);
> >
> > +       /* If dst has a base BTF, ensure it is modifiable now so that
> > +        * btf__str_by_offset() on the base returns pointers from the
> > +        * strset copy rather than from raw_data.
> > +        *
> > +        * Without this, the first btf_rewrite_str() call that encounte=
rs
> > +        * a base string offset resolves it via btf__str_by_offset(src)=
,
> > +        * which for split src returns a pointer into base->raw_data.
> > +        * That pointer is then passed to btf__add_str(dst), which call=
s
> > +        * btf__find_str(base) -> btf_ensure_modifiable(base).  The
> > +        * first btf_ensure_modifiable() call copies strings into a
> > +        * strset but then frees raw_data via btf_invalidate_raw_data()=
,
> > +        * leaving the pointer dangling before strset__find_str() uses
> > +        * it.
> > +        */
>
> This is very surprising behavior, tbh... Base BTF should stay
> immutable, we never modify it. It seems like we switch to modifiable
> mode for base (implicitly) just to be able to find string by contents
> efficiently, which is just a side-effect.
>
> Anyways, instead of this, can't we just detect that str_off we are
> trying to remap is coming from an immutable base BTF, and pass it
> through? That would be also more efficient, IMO.
>
> > +       if (btf->base_btf && btf_ensure_modifiable(btf->base_btf))
> > +               return libbpf_err(-ENOMEM);
> > +
> >         /* remember original strings section size if we have to roll ba=
ck
> >          * partial strings section changes
> >          */
> >         old_strs_len =3D btf->hdr->str_len;
> >
> >         data_sz =3D src_btf->hdr->type_len;
> > -       cnt =3D btf__type_cnt(src_btf) - 1;
> > +       cnt =3D src_btf->nr_types;
> >
> >         /* pre-allocate enough memory for new types */
> >         t =3D btf_add_type_mem(btf, data_sz);
> > @@ -2074,11 +2097,16 @@ int btf__add_btf(struct btf *btf, const struct =
btf *src_btf)
> >                         if (!*type_id) /* nothing to do for VOID refere=
nces */
> >                                 continue;
> >
> > -                       /* we haven't updated btf's type count yet, so
> > -                        * btf->start_id + btf->nr_types - 1 is the typ=
e ID offset we should
> > -                        * add to all newly added BTF types
> > +                       /* For split BTF sources, type IDs referencing =
the
> > +                        * base BTF (< src_start_id) remain unchanged s=
ince
> > +                        * dst shares the same base.  Only remap IDs in=
 the
> > +                        * split portion.  For non-split sources src_st=
art_id
> > +                        * is 1 so all IDs are remapped as before.
> >                          */
> > -                       *type_id +=3D btf->start_id + btf->nr_types - 1=
;
> > +                       if (*type_id < src_start_id)
> > +                               continue;
>
> see, just like here: you know type is from immutable base, and doesn't
> need remapping, we can do the same with string offsets
>
> pw-bot: cr

oh, and let's please have a test for this case of adding split BTF
with the same base?

>
> > +
> > +                       *type_id +=3D btf->start_id + btf->nr_types - s=
rc_start_id;
> >                 }
> >
> >                 /* go to next type data and type offset index entry */
> > --
> > 2.53.0
> >
> >
