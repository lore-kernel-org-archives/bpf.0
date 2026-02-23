Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF433970F
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869193; cv=pass; b=YgXj9w73fnPf/gDcO6HH7KZdEKJKoNK7OT09JLNa1ghoqYGK7ovcYN7TPrGqMNGyj2Qv+lCoxCUkd+jkUhPFXhTvypAAu7nEiUdCTLUmKWyOLbAWAA0b4H6hvakCJ5V3GG5VX+/dJR+C6m7GWiLvgZulqebBOO75/KWgDn9eCB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869193; c=relaxed/simple;
	bh=7yist8Rv56buWBkPdRvTgtRV54GUvRz5bVuf1xRyTtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpsiOR9uBHB3dSayS45FTbxFywirbZ8+K2b8ypjZjcuTgb/zJ+mvpPOZa2+92Aae02eW47mjYuHP7kkM/qfpEHPFGTtBQjK789BjNg4Q+wqQP1rOBnlucCGG2c5LWJ7uc3uZSa0EJxyNTDtwCGRRxwf/3SQXoCxtUBm91OFZxZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvPj8ngf; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvPj8ngf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a8a7269547so43347625ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:53:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869191; cv=none;
        d=google.com; s=arc-20240605;
        b=D1eVp7OUzipejbZ9f8UVbdIH3GigSaypHMUO4UkZPU/vklZ2FNoXk94UiZUzZ5Mrxl
         bmaQZRoc1avpGMEcDkFZVfFSN1rRVtzEsuGMt3W4uC8F/0g7WCA6I/kgYG3+7wBppQvM
         HQNo8cBftkirMgdNgistLTwogG6ROIEvUQ3/RFod+UuxYXELam6glJEq5ijRed2YLWm2
         n/72rFhKpAVM1ZYLK6YHpaSFpnTiJMAYNUVs+Q+ygxRTdO6oy0QIkbXhv/eFGNrNuuRo
         vUp7sDpwkkHsnamR14LPIZ1QrrkKvtVRk09I3+z3etMPrYqYLZriDOo5py/LTpOjru9/
         A2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NijVRuk9WjWzOt/W5ZpWegB8z9MULVtaPdhQ6+tM0M0=;
        fh=ruRytyp1U3/Twvapv5y1mA5yA1sI6j9rkfCvopNa1BY=;
        b=C7lvYdfd3/XTg0+iUmLz9V1BLFsck0ATKvmJ1RiDrqJbLb76rswamGZnENN/3/abJk
         q4QnkRQu1F1r3DyF1eyTX+++s4Y3YQRoxudvRGZ8WcqiwlI9f4jeKdtkDfH+TOHXY2O5
         7TMo71JiosoiCXC/mSEZL+u6nRa4vYET7RFFhxazlP/GvJcaMrhcdO6cpuRCq6gPQ7nJ
         WPuwdoDiB7U+G3u3kGBVhvFqzfIEYTNrTeMXrObaQ8VAEqvZCO7dVrOizwI+9JaP267S
         U62UkI7y1Xi0q60adiP3KFhbwsLAKQG+v1qo3xFrc2AWKhS3w+JvooE05HHWqUBLbl4v
         6tBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869191; x=1772473991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NijVRuk9WjWzOt/W5ZpWegB8z9MULVtaPdhQ6+tM0M0=;
        b=bvPj8ngfJMzZpw3EftHwJzfKom+JlLIhf3v5+YsrQlThxEdcA7yEZAnvVE+TmA+Rv7
         NsXvsc5gWmneTUWzMmrZItYWMekhRH5vCg69dAvRh3CprGlb9030N4NOWvbmCjKAD15n
         DWNXPHUSI52A3l2Le7S/sWgryG0Ly+6hS5m9gQJiQVJyZQ3EdbIVzO/u6e1H985MlQWh
         ut7hCaEcEJfqVhWpAZ/+fMEOWxPx7QN8Dnyk6OKqFhkQ96RhC91VTR7lA8VrKngGf1S4
         T/KwIPPdvlOE6vZqnB4SeaViFK8jfqee9EGvTZseVMzXj7aXsjioC10rr1+4+spislFo
         qDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869191; x=1772473991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NijVRuk9WjWzOt/W5ZpWegB8z9MULVtaPdhQ6+tM0M0=;
        b=nwp5dfG9GWZaorjwnuSrGdzp29WQkC8eumE0heolKngxRWizza2CdWOBeaYvnwiY3O
         tVZ6KvBtWajKWiT75+62BVeFGEI2S482u+pX6sU4xnxRRihVwMDwGuOsknPjPvZpednC
         LJ73DHwRgVRPlS9MC/ZU8bSRYOYCXo8+3Aooc8vy6LCmhyzk38Wy6xLU2KHMajFjXWMZ
         8uJ2+1Om+ww1SvK2gItPnTu034yKFu7MLDukRCAbk/hNEG4AG4CLCh9jlXSiUECGNyN4
         WwlD/659b+RFmJcb7+NLzsOkPS7kSUosWWJW9DztvFByMY6GhRe50YdJWiBkeU7Na8Ot
         Wfpg==
X-Gm-Message-State: AOJu0YygK9mM8b7t7UJMDT+XYevQb8rLV/p94IWe7L2+i1qbZqcYPu8H
	lN+RefHC/XLMpFfWG1DaiFu24D78uiwWGGHb89081b2X/FKh7TAmnT3B3/dI4HymwIQ1OieYSPJ
	grRO3eJyLeDO5ACTdMkd+TTU9PxKER+c=
X-Gm-Gg: ATEYQzwbHP9oC6UwSz1ip6Ou5OTuJLmlscj18lPxxrciZzDVoK/T22vvGl1/94TAwm6
	d6HNXuqgc6GkE72J7V+dvWWp8srNI3P+Djn1XXV3WX+fPTCOBYwYDZBgfwzkcZkLvAUIhYpKnT5
	az+ecBSx89BJbLDDQ6z/5CCI67WTbfnBtfF2lJcFESiIicszkgt4t/AAYMYwVjfelss1jyCqpR/
	n6YE9zgJEEaLbAlV9+mP0huN3TyIGHfeGx4V+iWGvnuqNSpesde56FmELQYpomhfR/jn2tb/nuu
	dpIAEEyg7/tepiSU75PhWZMPAg1pE4bhFA==
X-Received: by 2002:a17:903:2c04:b0:2a7:95d1:3c0 with SMTP id
 d9443c01a7336-2ad74450ef3mr72579495ad.23.1771869191419; Mon, 23 Feb 2026
 09:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771625484.git.josef@toxicpanda.com> <c0c2c805042fe889daca6dd43b86ba5e18725021.1771625484.git.josef@toxicpanda.com>
In-Reply-To: <c0c2c805042fe889daca6dd43b86ba5e18725021.1771625484.git.josef@toxicpanda.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Feb 2026 09:52:58 -0800
X-Gm-Features: AaiRm53okmZGw6XSVHgJeUwX4E2jZkkyWwoEycd-ZUC-3f646QW2zJ4yOoKe3Ck
Message-ID: <CAEf4BzYbyyAMnRo0Kb8K7D19+CUSANkOWnByX3BZdEase46ZDw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] libbpf: support appending split BTF in btf__add_btf()
To: Josef Bacik <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 2:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> btf__add_btf() currently rejects split BTF sources with -ENOTSUP.
> This prevents merging types from multiple kernel module BTFs that
> are all split against the same vmlinux base.
>
> Extend btf__add_btf() to handle split BTF sources by:
>
> - Replacing the blanket -ENOTSUP with a validation that src and dst
>   share the same base BTF pointer when both are split.
>
> - Computing src_start_id from the source's base to distinguish base
>   type ID references (which must remain unchanged) from split type
>   IDs (which must be remapped to new positions in the destination).
>
> - Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
>   count, which is correct for both split and non-split sources.
>
> - Pre-emptively calling btf_ensure_modifiable() on the destination's
>   base BTF to prevent a use-after-free: btf_rewrite_str() resolves
>   strings via btf__str_by_offset(src) which may return pointers into
>   the shared base's string data; btf__add_str(dst) then calls
>   btf__find_str(base) which can trigger btf_ensure_modifiable(base),
>   reallocating that string data and invalidating the pointer.
>
> For non-split sources the behavior is identical: src_start_id is 1,
> the type_id < 1 guard is never true (VOID is already skipped), and
> the remapping formula reduces to the original.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> ---
>  tools/lib/bpf/btf.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..654fb9ffa01f 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2004,24 +2004,47 @@ int btf__add_btf(struct btf *btf, const struct bt=
f *src_btf)
>  {
>         struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
>         int data_sz, sz, cnt, i, err, old_strs_len;
> +       __u32 src_start_id;
>         __u32 *off;
>         void *t;
>
> -       /* appending split BTF isn't supported yet */
> -       if (src_btf->base_btf)
> -               return libbpf_err(-ENOTSUP);
> +       /* When appending split BTF, the destination must share the same =
base
> +        * BTF so that base type ID references remain valid.
> +        */
> +       if (src_btf->base_btf &&
> +           src_btf->base_btf !=3D btf->base_btf)
> +               return libbpf_err(-EINVAL);

let's make it -EOPNOTSUPP (ENOTSUP is not a public error, so let's use
the proper one), it can still be meaningfully supported if bases are
different, we'd just need to add types from base and split parts, and
shift all type IDs (but no use case right now)

> +
> +       src_start_id =3D src_btf->base_btf ? btf__type_cnt(src_btf->base_=
btf) : 1;
>
>         /* deconstruct BTF, if necessary, and invalidate raw_data */
>         if (btf_ensure_modifiable(btf))
>                 return libbpf_err(-ENOMEM);
>
> +       /* If dst has a base BTF, ensure it is modifiable now so that
> +        * btf__str_by_offset() on the base returns pointers from the
> +        * strset copy rather than from raw_data.
> +        *
> +        * Without this, the first btf_rewrite_str() call that encounters
> +        * a base string offset resolves it via btf__str_by_offset(src),
> +        * which for split src returns a pointer into base->raw_data.
> +        * That pointer is then passed to btf__add_str(dst), which calls
> +        * btf__find_str(base) -> btf_ensure_modifiable(base).  The
> +        * first btf_ensure_modifiable() call copies strings into a
> +        * strset but then frees raw_data via btf_invalidate_raw_data(),
> +        * leaving the pointer dangling before strset__find_str() uses
> +        * it.
> +        */

This is very surprising behavior, tbh... Base BTF should stay
immutable, we never modify it. It seems like we switch to modifiable
mode for base (implicitly) just to be able to find string by contents
efficiently, which is just a side-effect.

Anyways, instead of this, can't we just detect that str_off we are
trying to remap is coming from an immutable base BTF, and pass it
through? That would be also more efficient, IMO.

> +       if (btf->base_btf && btf_ensure_modifiable(btf->base_btf))
> +               return libbpf_err(-ENOMEM);
> +
>         /* remember original strings section size if we have to roll back
>          * partial strings section changes
>          */
>         old_strs_len =3D btf->hdr->str_len;
>
>         data_sz =3D src_btf->hdr->type_len;
> -       cnt =3D btf__type_cnt(src_btf) - 1;
> +       cnt =3D src_btf->nr_types;
>
>         /* pre-allocate enough memory for new types */
>         t =3D btf_add_type_mem(btf, data_sz);
> @@ -2074,11 +2097,16 @@ int btf__add_btf(struct btf *btf, const struct bt=
f *src_btf)
>                         if (!*type_id) /* nothing to do for VOID referenc=
es */
>                                 continue;
>
> -                       /* we haven't updated btf's type count yet, so
> -                        * btf->start_id + btf->nr_types - 1 is the type =
ID offset we should
> -                        * add to all newly added BTF types
> +                       /* For split BTF sources, type IDs referencing th=
e
> +                        * base BTF (< src_start_id) remain unchanged sin=
ce
> +                        * dst shares the same base.  Only remap IDs in t=
he
> +                        * split portion.  For non-split sources src_star=
t_id
> +                        * is 1 so all IDs are remapped as before.
>                          */
> -                       *type_id +=3D btf->start_id + btf->nr_types - 1;
> +                       if (*type_id < src_start_id)
> +                               continue;

see, just like here: you know type is from immutable base, and doesn't
need remapping, we can do the same with string offsets

pw-bot: cr

> +
> +                       *type_id +=3D btf->start_id + btf->nr_types - src=
_start_id;
>                 }
>
>                 /* go to next type data and type offset index entry */
> --
> 2.53.0
>
>
