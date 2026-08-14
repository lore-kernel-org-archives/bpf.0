Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A835C6A7
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736964; cv=pass; b=I9NCtI+7/SIRSGSoueehZxF9VUX1Rm3sN9ci6tUEEILsshn/gV2u6ob/mvG+puk45X6IXc2ruQFOgh6/uc0futfDpy8nFQcYaGuVURM5S4mWSbmRpIun4/7Yt2O33poDHUN8RpeDVDmHuxNI895tPLLEzYMKFlgStFQcvwar/4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736964; c=relaxed/simple;
	bh=qGOVOiwHRNQNT68Orvjie8HDe6oW1vyTxCt5iXKLSew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsz1psHQ8gUInAOch41Qt1VqEpkPTHk0znNClqor7p0bbfj6aOFQgxhWiys9sOB0mKfCfAUpD41GUUz8BIorDiRoXD/DzLKCvJxBKB22XQaLF12XNFugFavjA0tV/ljRqNgwnFvZ8AyVrsvUkukEeau5BD28qup90CVN8Hsr/PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYROp8N9; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYROp8N9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso21791165ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 12:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786736962; cv=none;
        d=google.com; s=arc-20260327;
        b=HL0sGPfbhN4Him6FXX2ovCv6/fFDSrYUFyQOjlWU9HJRlMEMWazQRo5mMxAwTdjicp
         6+4Hhbi1gxqHDSEeZJ8meyc0kacCNuzdk6ym0LFEQOlZ6ca0GvW0meqCRKDhT5wSD7ZQ
         YDnMzj6ys0PWZiP2W31DSNXm5doGQ5zWVRMHXpWyJuPwcOnDZuhPHVOOT9wvSOeirWML
         hcbslS8oHUv7FKc4GPUgu4ehPC3CzWFVu6izi/ACwn4YGdGJZVQvn/HirqC3WgnKpohF
         J8NLUqaFaXFW1mVtE077XxenabFB9Bn7F2g8vPf+05apu3eDp49AT5GQRW3xXuEzzYpk
         zpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J5kP1ALyjd1085hsxnV4piVOMuLWzW9JRl/gUNLpSDo=;
        fh=dT+WiqYFvElQz/VO0uSING9E07WWYoks4mWgdOfMY7s=;
        b=sTVTRJZy9amxurwULhu0ihSapcE9NtideYi7zmsBVwiClrWkbL80FUnVB+sYhDgj+4
         JZofbhQcC/EqvfNWu1043whCzXow8Wrh45YC9OrClRFw8DmL4zPpAqwfZqusct/vD9dU
         Dkgcz+08iBeUBS9yKo5RVdsJF8JijK8bNOChQLj1G4bE+PXXTjl80zXJQxD4VbhqzeYI
         itDeZwB7BKUfX7yjMdtZ4mIX3Ew7brNr19QO7igc61H05w6OVOHGBnV91RhFnR6V4XsO
         C+DdZuc9VVvgKDDu1tsVZttrHrQPtP+yrIRebSgEzkXw5PeA5SfrYOHvTMJKDYeFLJaW
         hs2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786736962; x=1787341762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5kP1ALyjd1085hsxnV4piVOMuLWzW9JRl/gUNLpSDo=;
        b=CYROp8N9pJwHhC+qh3qKfxgW7tGbCZITOgX/+jZvvO3+tNINHoG2u4EXBf0J3pwxMq
         IMp4diHB40ob4Yo+VqFQazMelMjtX8HSC8iaJYUwRgpky15yy1xR+81MeOr6hIuVd5o+
         ceBnpV7E7/PKa3kB8BhN2b6SJBRzFdtUM7UyA9LjgdZsf3qaIdcaJ80GkMxfJjzIXIXG
         p5dT79ewumbHw9mzrdKJ8kqMwvu+rWGwaQcrSo+NXTi8bt4eUpyW5AfvPPqIy31Xy+gk
         a+kpu/TOc1vPXp3K2ZLyA4qQzYMv1eZU3lOblgWBEsJeHo3zbNNnXKFQzACk4X8G9pig
         Jz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736962; x=1787341762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5kP1ALyjd1085hsxnV4piVOMuLWzW9JRl/gUNLpSDo=;
        b=OjPRUpU2Uxy6ERy7Iz0tub1Uqtlav0xYfMZx5psSpi8FtGwTbHzOqcJSrR8ba8xSbQ
         nJK/v0hi/uDk+tbvA4AWM0J70pRD8fjjXgCDCohshliFwdUHqV+esDNhsP35jAGYAJt4
         8ANFCu0NN3ROfk2XL4ZXanGRgSs4MaEoJWBtdrMJrGdu7tyUcSkHxFpsAsZui3Vg46NC
         mijwaRHuJAeeX4flMINvY6XgrS6z5ERxv4C7ck9fRqXnmygijltqCXz2lKxXE89AFiOj
         pcAvu+nrGPR4tr1/NlL3uhWj4PcBXQBMyL4zp1eMItogGmFqcD/HrFh89KqhoDeV0DcZ
         jheQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqf7PajlBJa6oJadESjs/40QVe5asEOrMDLDlexoQns+5qWw8JK9fiEBGEVr2CpxFyqr+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXW2cHOW6TQNpqiATwqDO111+E0cJBg6t5Rd2aDCGM+kVme6RR
	+5Vc1vR1vbBRw5ASpI81KD4V6CRLaYKiLr0Mbgl1naJtX3jEWF0bNsCPUbhmTdj+UnbD/Zz4XbW
	hlOh4pojI1MCk+/AcCnrMpqVEccavYRTk0g==
X-Gm-Gg: AR+sD10LPG6YXEe0JsiFcumytzkOlPwdQloTB5J5Y/N6Zhggu4PZN144SK5M/r5DL95
	6EptIDG1ifa5xS8xT95p4m3IvKaqK4qYR486oW9Ef9NiC+0vZERBQmGEPWBsmSxiFGvwkXxY3/j
	uIgcBlW1sWOke6K+jL/4FG+eyIZu24Qfn0AVoM9BnluS/g06aE88y0l37pwUDazmeFP592cjPMQ
	2WkaYUhy139yoBuxVUuAGOpY2AL72OEAdftHvu3Ldp5IE+6/IWbqViwt57y++uMzMSbingUcuY+
	Jw7QZdvhOfnxM4Y/N2kl0b4kBcDCgkDFGFxCopbzGUDmY0aHD7cN2Kf7ESmVbxtMfYu1aP4L1nj
	SClQ0NHXPFZHzH3nbkdmUNsVDhA==
X-Received: by 2002:a05:6a20:3d1c:b0:3c6:3c5b:f2e3 with SMTP id
 adf61e73a8af0-3cc72086fafmr9453450637.33.1786736962191; Fri, 14 Aug 2026
 12:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-8-3b3675da1f6e@meta.com> <20260813235957.0AC751F000E9@smtp.kernel.org>
In-Reply-To: <20260813235957.0AC751F000E9@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 12:49:09 -0700
X-Gm-Features: AUfX_mzlCnOebkHVgsGP6fMU7MY72U9zRRTzcb8FrV8GCPduodG9VRaLQShauOw
Message-ID: <CAEf4BzYLLOoiujaFO5GSra37i-DR-T4CGgU_zL-HGp2HEK2N2g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for
 resizable hashtab
To: sashiko-reviews@lists.linux.dev, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is it really a good use of tokens for sashiko to review old patches
that have either landed or were significantly changed since (and
probably got a bunch of new revisions sent), or just plain forgotten
by now?

Did something regress recently? I'm not sure this has happened before
until recently...

-- Andrii

On Thu, Aug 13, 2026 at 4:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Uninitialized memory read in `last_key` when `seq_show` overflow=
s.
> - [High] `rhashtable_walk_enter_from` resets iterator on deleted cursor k=
ey, causing O(N^2) complexity and infinite loops.
> - [Medium] Missing __GFP_NOWARN flag in user-controlled kmalloc for map->=
key_size can lead to OOM splats.
> --
>
> --- Patch [8]: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs=
 for resizable hashtab ---
> commit 226ce1988038cf4876ff0a72b5ae8e5ebc263151
> Author: Mykyta Yatsenko <yatsenko@meta.com>
>
> bpf: Implement iterator APIs for resizable hashtab
>
> Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
> bpf_iter and bpftool map dump work with resizable hash maps.
>
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 4611671bf8e74..5ca4d26e70178 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
>
> [ ... ]
>
> > @@ -3205,36 +3218,113 @@ struct bpf_iter_seq_rhash_map_info {
> >       struct bpf_map *map;
> >       struct bpf_rhtab *rhtab;
> >       struct rhashtable_iter iter;
> > -     u32 skip_elems;
> > +     void *last_key;
> >       bool iter_active;
> >  };
> >
> >  static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos=
)
> >  {
> > -     return NULL;
> > +     struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> > +     struct rhtab_elem *elem;
> > +     void *key =3D *pos > 0 ? info->last_key : NULL;
> > +
> > +     scoped_guard(rcu) {
> > +             rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
> > +                                        key, info->rhtab->params);
>
> [Severity: High]
> Will this silently restart iteration from bucket 0 if the cursor key is d=
eleted?
>
> rhashtable_walk_enter_from() looks up the provided cursor key to resume
> iteration. If the key is missing, it returns early and leaves the iterato=
r at
> bucket 0 (iter->slot =3D 0).
>
> In __rhtab_map_lookup_and_delete_batch(), the batch operation deletes ele=
ments
> and returns the last deleted key to userspace. On the next batch syscall,=
 the
> user passes this deleted key back as the cursor. Since the key no longer
> exists, rhashtable_walk_enter_from() resets the iterator to 0.
>
> The inner loop then executes while (total < max_count) holding rcu_read_l=
ock(),
> rescanning all previously emptied buckets from the beginning of the table=
.
>
> For lookup_batch and seq_file iterators, does this yield massive duplicat=
e
> outputs to userspace and enormous RCU stall times?
>
> > +             rhashtable_walk_start(&info->iter);
> > +     }
> > +     info->iter_active =3D true;
> > +
> > +     elem =3D rhtab_iter_next(&info->iter);
> > +     if (!elem)
> > +             return NULL;
> > +     /*
> > +      * if *pos is not 0, previously iteration failed on this elem,
> > +      * so we are restarting it. That's why no need to increment *pos.
> > +      */
> > +     if (*pos =3D=3D 0)
> > +             ++*pos;
>
> [Severity: High]
> Does this pass uninitialized memory as a hash key if seq_show() output
> overflows?
>
> When reading a BPF iterator, seq_read_iter() calls bpf_rhash_map_seq_star=
t(),
> which increments *pos from 0 to 1 and returns the first element.
>
> If the output of seq_show() for this element exceeds the initial seq_file
> buffer, the buffer overflows. The sequence machinery reallocates a larger
> buffer and calls seq_start() again.
>
> Since *pos is now 1, the code executes key =3D info->last_key. However, l=
ast_key
> is only populated in seq_next(), which hasn't been called yet. Thus, last=
_key
> remains uninitialized from its kmalloc(..., GFP_USER) allocation.
>
> > +     return elem;
> >  }
>
> [ ... ]
>
> >  static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_au=
x_info *aux)
> >  {
> > +     struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
> > +     struct bpf_map *map =3D aux->map;
> > +
> > +     info->last_key =3D kmalloc(map->key_size, GFP_USER);
>
> [Severity: Medium]
> Does this need __GFP_NOWARN?
>
> Since BPF hash map key sizes can be extremely large, requesting large
> contiguous memory blocks without __GFP_NOWARN can fail loudly under memor=
y
> fragmentation and trigger high-order page allocation warnings.
>
> > +     if (!info->last_key)
> > +             return -ENOMEM;
> > +
> > +     bpf_map_inc_with_uref(map);
> > +     info->map =3D map;
> > +     info->rhtab =3D container_of(map, struct bpf_rhtab, map);
> > +     info->iter_active =3D false;
> >       return 0;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-rhash-v2=
-0-3b3675da1f6e@meta.com?part=3D8
>
