Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72653339B32
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869402; cv=pass; b=r986TRHMZ+zREpfey67bmmJbFM4dG/vOcCJSEYbEdO0YfJ+QLh64qxfmQ5i1BYql8DpRQlcLmVimEHnPpbwblc4GKvUcTiXmHnsTql3MRBX1Mfb9IWiA4OQYc/sdhI9s1XFqeRNQKRVmy6uFs49in81UabSXBJmgwemFXrWVJ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869402; c=relaxed/simple;
	bh=ENA80e9r6CpQnbmQ6frhmvh5gnbE0k7YAwHUVhp8KCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0HlU/WN/QXcU5cjTL9uQHIX7zsgsQeTUQ9TTslCSAytYI1Svmnp6arHJ8BielbaWZ+u6sjKQB0d7+l92On3Gk2WXgPbO6fXurDzUkMFw6Ijp7mxx8Uj5MuYspe4JXxJh2T9CqmhMJzUflBkuHpVz7mqaM3jhtX4qDFaKN/JinU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuJYFcYp; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuJYFcYp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a79ded11a2so31132125ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:56:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869401; cv=none;
        d=google.com; s=arc-20240605;
        b=XjcNYzqNfYoGlLUFKwAetu8jZQ2xNDy+C5G7kUFPYA7CMN7YgtBV0JgdmC4DtuGGBf
         e2maGmHn7ia+XUlHBvCFJ3CWJ3kVXN5iiX2GiSJZtyc3T+87pDVhHiCaMd+Zpxcw0TyQ
         j6SsZTCcyU80ClVsCBzmQpRvREEMKD6KWYV1YABffaMSdSiRP4aL9oHpBtmY6cf48W7S
         8NxrcMB3tTaaX8bTWS6plZ+Elq2MfgzzXhEhWdmQZCb64vhPK7rM2nD313Thtc9JXNP4
         YiAUWuTgYLfa0ArV5d9uoueYjSrFnGpvRVodpx+E/Qb86jbbAhT5ecpQtG3bCZjwq4tj
         s6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ogFf5HfvvIUhdm3leLHNLvU0UQQ4biePEsEMND3YA8=;
        fh=ruRytyp1U3/Twvapv5y1mA5yA1sI6j9rkfCvopNa1BY=;
        b=e2fqftGM+LURlDoznrDtP9d+S1zQ0MAGazb+R6Ii3TJY/CbSI+aDt0AwFy/9GLxUk2
         3Ap94RjrfYRZXN8hxcxii6BKcOuUEfiuN0zwoXqYekbQx/NOEJSjzxhtyp2vDbFvG7IJ
         J2h749sBfLH5Mmlvz+05spHDIRIaCQjdcDG2vrmW7h5LBFiBnNedll3qj+aepSxv09oh
         DDlnPr0F2sFeUzwVXldLypczYkgIgxSdt7bfgZChVdTh127S2/w+gEfT2X9Z7ig28IYJ
         /LYJX0RbDhW7MVk1VpLRsFqVXGyIkj/xFtmp8GeZ5UFmXShczqAXc6+sowEq2Yutqvbt
         GQiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869401; x=1772474201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ogFf5HfvvIUhdm3leLHNLvU0UQQ4biePEsEMND3YA8=;
        b=FuJYFcYpv6uPyaur4QgtTuMdYW0Kqwm8AlByLHw/FTeYJ4xxBZpEeX76eoJnnVkslD
         riP0FUiFhbyv0n1onmwsvHinczfeX8DecewqBfvqDG8UmHMMV3mHR2/8de2AJsG8DLzr
         SGJj5G3246MO1ddql6H24ZhcIYyKpbI684G/IFnY2UYmy5WgbnYEWcXuFxZpjUsIemL1
         +b7u+hIgTqVJ9cBovuw9iYgKwtKJwkYhvwGat/LERAKpEZM/1lY+PQN1SiUPUDGFbEjX
         rP83wyRDycVzN0p/NmZn8L2y7uW24aL0LSRzHlxtcYzZue3VQ/DFzziuZgBhXZNZxJoI
         6x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869401; x=1772474201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ogFf5HfvvIUhdm3leLHNLvU0UQQ4biePEsEMND3YA8=;
        b=q88FXVs/36aGlyxMCX40tm/xyC0U6TV0FY7KRrn1RuIJNy41vblZWgHwyLLYcjO6/k
         KkWn5m/T4FrsLimcFovtILmzQwqipDzzddmbjD1g6CvSxs+EKW5XkBiATZDCVDHba6A/
         YSgD9/mvuQjSq/BdjZ3fjUuMjnUGUrSfpVyERGO54teOv2zQnOnpsYilN+Go6DTWRI7U
         CaRDyvI4hSNcYUP9CX4pJo5NfXjOBAH3pGQtzOlBkn8M8Tz2lgha7mVQBK36VkfNDn8s
         iu3XAAa+KPAS3JZV6XmumjNW30cuRs3FtAcrhfuToXShU4q0VsgG+oEXSQbLAFHfd1H/
         42fQ==
X-Gm-Message-State: AOJu0Yz81IFDrx7Dz3iF8uiELQtdDttREk61t3TG5O8BQn6CvPQCaBhl
	WZuu6p67X34DrnX1MphxQA9WqUVAcLbd8BWPhJWtHTKfHXbTak1SII+bh0Ror//kdYq7wCw15PZ
	O5Z14+fgdZvJpWIOmQlgEwFVtcjffVlI=
X-Gm-Gg: ATEYQzxKlpUymSCiHS0NWrDLd7XAqlVke8QCaEq0YgNoYqA+/R5Y9X9YT/QxeFv2412
	FmBApM+/veGc+RWloZpNrHwdbsJVgumCR+IHpWgczHa2xDClOdeQgnZEA+8h3lmTK4glrh59fR3
	gtoEW9JmCVVnFUt9qMJJbaLupm6vuknPuEGTcCL8jtfhViQ7hu4N7iiJxxBbkbtxrESDPPee3/I
	t3PODr2z2e1cLKnoU5C7RNv2TS0FYw2w5zjhRPF4rkXnxTnaCT0+UKOwsf9Lqf+5ksjKYb8go+G
	IgqK++zp+4kNprupEd+Y2QQ=
X-Received: by 2002:a17:903:4b30:b0:2aa:e415:589c with SMTP id
 d9443c01a7336-2ad745675admr71834955ad.55.1771869400591; Mon, 23 Feb 2026
 09:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771625484.git.josef@toxicpanda.com> <c0c2c805042fe889daca6dd43b86ba5e18725021.1771625484.git.josef@toxicpanda.com>
 <CAEf4BzYbyyAMnRo0Kb8K7D19+CUSANkOWnByX3BZdEase46ZDw@mail.gmail.com> <CAEf4BzZ7tNJG4ex-2oh3zH2fGy9iVtTEimV_pJxj4ZiEBfv1KA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ7tNJG4ex-2oh3zH2fGy9iVtTEimV_pJxj4ZiEBfv1KA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Feb 2026 09:56:27 -0800
X-Gm-Features: AaiRm51BzZj-jvNK4ni_7TFUjutZxiVAazE2172FA0v1KtC8xr-sQuRjhfIN8m4
Message-ID: <CAEf4BzZonog2HTTCQ58D9JzP0+ecSLRfrQUXbCOQ_OLabhWzxw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] libbpf: support appending split BTF in btf__add_btf()
To: Josef Bacik <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 9:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 23, 2026 at 9:52=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Feb 20, 2026 at 2:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > btf__add_btf() currently rejects split BTF sources with -ENOTSUP.
> > > This prevents merging types from multiple kernel module BTFs that
> > > are all split against the same vmlinux base.
> > >
> > > Extend btf__add_btf() to handle split BTF sources by:
> > >
> > > - Replacing the blanket -ENOTSUP with a validation that src and dst
> > >   share the same base BTF pointer when both are split.
> > >
> > > - Computing src_start_id from the source's base to distinguish base
> > >   type ID references (which must remain unchanged) from split type
> > >   IDs (which must be remapped to new positions in the destination).
> > >
> > > - Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
> > >   count, which is correct for both split and non-split sources.
> > >
> > > - Pre-emptively calling btf_ensure_modifiable() on the destination's
> > >   base BTF to prevent a use-after-free: btf_rewrite_str() resolves
> > >   strings via btf__str_by_offset(src) which may return pointers into
> > >   the shared base's string data; btf__add_str(dst) then calls
> > >   btf__find_str(base) which can trigger btf_ensure_modifiable(base),
> > >   reallocating that string data and invalidating the pointer.
> > >
> > > For non-split sources the behavior is identical: src_start_id is 1,
> > > the type_id < 1 guard is never true (VOID is already skipped), and
> > > the remapping formula reduces to the original.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> > > ---
> > >  tools/lib/bpf/btf.c | 44 ++++++++++++++++++++++++++++++++++++-------=
-
> > >  1 file changed, 36 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 83fe79ffcb8f..654fb9ffa01f 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -2004,24 +2004,47 @@ int btf__add_btf(struct btf *btf, const struc=
t btf *src_btf)
> > >  {
> > >         struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
> > >         int data_sz, sz, cnt, i, err, old_strs_len;
> > > +       __u32 src_start_id;
> > >         __u32 *off;
> > >         void *t;
> > >
> > > -       /* appending split BTF isn't supported yet */
> > > -       if (src_btf->base_btf)
> > > -               return libbpf_err(-ENOTSUP);
> > > +       /* When appending split BTF, the destination must share the s=
ame base
> > > +        * BTF so that base type ID references remain valid.
> > > +        */
> > > +       if (src_btf->base_btf &&
> > > +           src_btf->base_btf !=3D btf->base_btf)
> > > +               return libbpf_err(-EINVAL);
> >
> > let's make it -EOPNOTSUPP (ENOTSUP is not a public error, so let's use
> > the proper one), it can still be meaningfully supported if bases are
> > different, we'd just need to add types from base and split parts, and
> > shift all type IDs (but no use case right now)
> >
> > > +
> > > +       src_start_id =3D src_btf->base_btf ? btf__type_cnt(src_btf->b=
ase_btf) : 1;
> > >
> > >         /* deconstruct BTF, if necessary, and invalidate raw_data */
> > >         if (btf_ensure_modifiable(btf))
> > >                 return libbpf_err(-ENOMEM);
> > >
> > > +       /* If dst has a base BTF, ensure it is modifiable now so that
> > > +        * btf__str_by_offset() on the base returns pointers from the
> > > +        * strset copy rather than from raw_data.
> > > +        *
> > > +        * Without this, the first btf_rewrite_str() call that encoun=
ters
> > > +        * a base string offset resolves it via btf__str_by_offset(sr=
c),
> > > +        * which for split src returns a pointer into base->raw_data.
> > > +        * That pointer is then passed to btf__add_str(dst), which ca=
lls
> > > +        * btf__find_str(base) -> btf_ensure_modifiable(base).  The
> > > +        * first btf_ensure_modifiable() call copies strings into a
> > > +        * strset but then frees raw_data via btf_invalidate_raw_data=
(),
> > > +        * leaving the pointer dangling before strset__find_str() use=
s
> > > +        * it.
> > > +        */
> >
> > This is very surprising behavior, tbh... Base BTF should stay
> > immutable, we never modify it. It seems like we switch to modifiable
> > mode for base (implicitly) just to be able to find string by contents
> > efficiently, which is just a side-effect.
> >
> > Anyways, instead of this, can't we just detect that str_off we are
> > trying to remap is coming from an immutable base BTF, and pass it
> > through? That would be also more efficient, IMO.
> >
> > > +       if (btf->base_btf && btf_ensure_modifiable(btf->base_btf))
> > > +               return libbpf_err(-ENOMEM);
> > > +
> > >         /* remember original strings section size if we have to roll =
back
> > >          * partial strings section changes
> > >          */
> > >         old_strs_len =3D btf->hdr->str_len;
> > >
> > >         data_sz =3D src_btf->hdr->type_len;
> > > -       cnt =3D btf__type_cnt(src_btf) - 1;
> > > +       cnt =3D src_btf->nr_types;
> > >
> > >         /* pre-allocate enough memory for new types */
> > >         t =3D btf_add_type_mem(btf, data_sz);
> > > @@ -2074,11 +2097,16 @@ int btf__add_btf(struct btf *btf, const struc=
t btf *src_btf)
> > >                         if (!*type_id) /* nothing to do for VOID refe=
rences */
> > >                                 continue;
> > >
> > > -                       /* we haven't updated btf's type count yet, s=
o
> > > -                        * btf->start_id + btf->nr_types - 1 is the t=
ype ID offset we should
> > > -                        * add to all newly added BTF types
> > > +                       /* For split BTF sources, type IDs referencin=
g the
> > > +                        * base BTF (< src_start_id) remain unchanged=
 since
> > > +                        * dst shares the same base.  Only remap IDs =
in the
> > > +                        * split portion.  For non-split sources src_=
start_id
> > > +                        * is 1 so all IDs are remapped as before.
> > >                          */
> > > -                       *type_id +=3D btf->start_id + btf->nr_types -=
 1;
> > > +                       if (*type_id < src_start_id)
> > > +                               continue;
> >
> > see, just like here: you know type is from immutable base, and doesn't
> > need remapping, we can do the same with string offsets
> >
> > pw-bot: cr
>
> oh, and let's please have a test for this case of adding split BTF
> with the same base?
>

doh, brain farted, there is a self test in patch #3, ignore me

> >
> > > +
> > > +                       *type_id +=3D btf->start_id + btf->nr_types -=
 src_start_id;
> > >                 }
> > >
> > >                 /* go to next type data and type offset index entry *=
/
> > > --
> > > 2.53.0
> > >
> > >
