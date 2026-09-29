Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83252120C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699835; cv=pass; b=gVVz4BIV500mHzDpeF/6ncZ38Jmhn/YFa91MKvXl06vihqnrRAwwDFY9CH4alDzTok/1gd38p/oh7n8qH0Sf3CXZb+hjoa2V+yGEwQf9hynyrLM4YjTN3uURUTCs1Y4OiCXtBvm+ebQsKMTQgarNWHa5kU7XeEQuvSWT1gYELOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699835; c=relaxed/simple;
	bh=gpWvrYH4Wp1rA5cCsHTR8gtqaJv0xEqoXZZCd8jv1EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhBPYZ/MMvl0N40vIWO0rjNu5cQaiMGIxg1dBcJVGXgiDvRQPMM74E6ZsMPJL4jNXhahHVizQd00ZB1kKAhttyCfUUGCZm52VpUTcx+nOiJxaAA5+yKwajYHlX/LVp3k6kqfH1w2W6kauPSnNmQsdFxX0k0QYSJLOzbPaQ25ECU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GV2BFO0b; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GV2BFO0b"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a0061bf0d3so55985e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699832; cv=none;
        d=google.com; s=arc-20260327;
        b=JpZmKpfdvzpEOWbWOw6xoeYPhEZ5y6CIYd5KTX9rMLPwp7WOgFDz/oGz18trL4Ya0f
         ACEIfMARiYPSY5IsbutI3OL7Q8k4pgGYsVgvxd5Yw19T4HTG2MQnANEZb73yx3E3MXWS
         B6GH7H/FcMhV1NMjFNUVk6kaetf/hkAF9xXcx3jy00F6HQAhqJMCBJNe9CCFNNjNNvAa
         k7RJIa4ybvLwUlyhcqQU9Q4l07aLAdjJtp2fhlIpyYvXKUgg/aJkLm9QQOMVpswWeOQy
         GGmlbia06AcrbgfoxjZ+zmVoVM39evWcFdvwTiQ/6ECRFbcotoSg72Hovwm++KczbBqf
         4Rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=le2DxLCPEDrr2PRm44y3xvUUCI3+IOhlaSJ1r852sqE=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=T2EF37YcIxzZO5Ux07+kldyG4v3RTscMKQ/dfiy94/8r4PzgIDtF7zbPtBUKPvQhTt
         nX+NQOHGqiKj9rvPM/im+n0hVEzoofiM5vd+DSlcZVKaecq7PALETkK3q4xPWPp9lSH8
         ayrgWFIaYFGOLLvP2O1cEb2XnSzhtMUuaVpDmHTr3DDB85gT/LlCua8lwH0gwUzs8Ym5
         S7fF1+L4njRHbkz07EaoVoI3u5B6mvjE8TSZ2bb67wPF8OJZfxkOxGFA6DTM9cm+qZ88
         a4TWf2swySvPHyncbDrys1yfgEDttTYpzbIdAKoAvhuO+PO4ASN9jARu5OAJM3Ny+OPJ
         x5oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790699832; x=1791304632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=le2DxLCPEDrr2PRm44y3xvUUCI3+IOhlaSJ1r852sqE=;
        b=GV2BFO0bIlTa9DZx84Gxi8vu27vHvmGG87na9h9rmkqEuX3Df4m4dkvQ6jpfXS8bmV
         rqxiPAP5mLYMHqukcDqxkl167LiEIeLWTDkV/CSQ+Hf8LpFK4+QPAwVm0LmEmZZIeiX6
         UOpoz+c0KDerDkeutmKWFBvo2NZ3YMOhkAVZi1oGRyvVhcIyHPPBtYI4JF/Ip1PCOUss
         EP0gLPwUTSUk7izU3pusuC2/bUdwP31qCdki0QgF0PhK6XaqdaIsgxP3K5Epy4nN+sov
         7SISRVjQJMOpAk+cOAYLn3FfH9JOZglgyfeeo0bCFfunQlhRQcuQO7zLzTuB6+fmPi3z
         hgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699832; x=1791304632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=le2DxLCPEDrr2PRm44y3xvUUCI3+IOhlaSJ1r852sqE=;
        b=qx88ZuYczSyU5oD3O+6UkYKOu3TeGDYuAW66WCTtY7+IDjQeMbEkZOHPOmyLd4aqky
         bMvoBgjGfRvt5r4MWT9tFJrs1H3hKS8/f6CiiPk0jAcXBx1xQB2jiq+4emCo0iSlDAYP
         0Xe6tO5O8Z8R40wntO2GjJemNvxY8CE9lrFQy2NtyijL99+GvzCdhBKxrF0iNx5w05iX
         Etz5bKLfJiI7VAjnaG3+ufJNZI9uMBDKgnRy6Oj7ykkg62i+lkdvSy7Kp/MEOgENapxl
         bqq5ocSQo9QvFBcjCHgxSB/1En644BEflhM3D9MX+216kue2FFZCdepeKK1mIFZCAnPB
         y1aQ==
X-Gm-Message-State: AFuF++lo0aBn2E2INS6v12O6JcO/NIfw5cU+JS3sUiUb2Rm2AJp/xVL7
	ABhRdkj5Ynzt/HiehDD6TWWnP/gWRxPjayxSptqj3r77tzuGPLNf7tyZoWo2zeIVFFdFcAV+pvT
	Je8wQO1IKoLcB9YZn9n03Lsy8ZxxgBIZK21sfWSxU0rjU9IesiuNBJm/oQCE=
X-Gm-Gg: AYBFou3h8e4UuO4kvO0j2sQfTVec87WpVXF3IVDEgmnCFDI1GyhKNYbEB65/85tSJsL
	sRmUpHtbwE+mTQs7ZT1n/D+cDqI7j50fWpxi8KEYrnVt/xAp9HO3/5Zb0//fIJCYI+zF55Uywe6
	Ia/CaVibZqjSQhf3U/bdeVg6jvQzM9/oZ48tQwLRF8foYnixuXGKge2s42A0TM8FMemh/JGt3PU
	2iRvCbzqQBBRDFv3zYAsc74xaNU7AZF24jWqrQjbwKI6okhLQVYaZxhvQlglv/0FXEt/wW9I98u
	1Ai0xcA6ya8yzhF4meSyMp6xPs3SJt71JYRxgMiGiQQ+aOaqLyD1bxa2C2u67S+XSE335XB4rzb
	L85+kIFaEfCxzjQAH/nTEMnusqF6yKprcbNmDqXTbXT5e5w==
X-Received: by 2002:a05:600c:a117:b0:4a0:1034:7fe5 with SMTP id
 5b1f17b1804b1-4a01034809dmr833175e9.14.1790699831262; Tue, 29 Sep 2026
 09:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928150121.1712559-1-tjmercier@google.com>
 <20260928150121.1712559-3-tjmercier@google.com> <20260928151833.31C8F1F000FF@smtp.kernel.org>
In-Reply-To: <20260928151833.31C8F1F000FF@smtp.kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 29 Sep 2026 18:36:58 +0200
X-Gm-Features: AclHuK9PvrsgxSgm9vpblUUY7Rb3eicL2q1Rd7eVI6sOT19pqPxF17s79AFhmlM
Message-ID: <CABdmKX2ZonMzkiXKQNvNSNo8bNrWjb_JwR9YsDpwF_bs_C1Njg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:18=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: RCU readers can match recycled elements causing UAF/corrupt=
ion
> --
>
> commit 1b9a82a1c5a80781d8a76b226efc1db28e064ff2
> Author: T.J. Mercier <tjmercier@google.com>
>
> bpf: htab: Reduce elem_size by 8 bytes for small key sizes
>
> This commit reduces element size for standard and non-LRU per-CPU hash
> maps with small keys by omitting the 32-bit hash value. For these small
> keys, it relies on a single atomic instruction for key comparison and mov=
es
> the new key assignment to the end of element allocation to avoid exposing
> uninitialized values.
>
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 5db11a21ce980..7a8049cc99828 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
>
> [ ... ]
>
> > @@ -734,35 +784,60 @@ static inline struct hlist_nulls_head *select_buc=
ket(struct bpf_htab *htab, u32
> >       return &__select_bucket(htab, hash)->head;
> >  }
> >
> > -/* this lookup function can only be called with bucket lock taken */
> > -static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head=
, u32 hash,
> > -                                      void *key, u32 key_size)
> > +static __always_inline struct htab_elem *
> > +__lookup_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head=
,
> > +               u32 hash, void *key, u32 key_size,
> > +               struct hlist_nulls_node **out_n)
> >  {
> >       struct hlist_nulls_node *n;
> >       struct htab_elem *l;
> >
> > -     hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > -             if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size=
))
> > -                     return l;
> > +     if (htab_has_hash(htab)) {
> > +             hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > +                     if (htab_elem_hash(l) =3D=3D hash &&
> > +                         !memcmp(&l->key, key, key_size))
> > +                             return l;
> > +     } else {
> > +             /*
> > +              * When hash is omitted, key comparisons must be atomic. =
Zero extend
> > +              * the caller's key to the word size to support an atomic=
 compare.
> > +              */
> > +             unsigned long k =3D 0;
> > +
> > +             memcpy(&k, key, key_size);
> > +             hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > +                     if (READ_ONCE(*(unsigned long *)l->key) =3D=3D k)
> > +                             return l;
> > +     }
>
> [Severity: High]
> Can an RCU reader searching for a deleted key incorrectly match a recycle=
d
> element here?
>
> Without a hash field to act as an epoch check, it seems a lockless reader
> might accept an element that is currently being reallocated if the stale
> key hasn't been overwritten yet.
>
> [ ... ]
>
> > @@ -1225,7 +1302,18 @@ static struct htab_elem *alloc_htab_elem(struct =
bpf_htab *htab, void *key,
> >               copy_map_value(&htab->map, htab_elem_value(l_new, key_siz=
e), value);
> >       }
>
> [Severity: High]
> If a lockless reader successfully matched the old key in __lookup_elem_ra=
w(),
> could it observe the element in an inconsistent state here?
>
> While the value is being copied (or a new per-CPU pointer is being initia=
lized
> earlier in this function), the reader might read corrupted data. In the c=
ase
> of a non-preallocated per-CPU map, could it dereference the old, freed pp=
tr
> leading to a use-after-free?
>
> > -     l_new->hash =3D hash;
> > +     if (htab_has_hash(htab)) {
> > +             htab_elem_set_hash(l_new, hash);
> > +     } else {
> > +             /*
> > +              * Zero-extend key into k for an atomic write to support
> > +              * lockless RCU readers.
> > +              */
> > +             unsigned long k =3D 0;
> > +
> > +             memcpy(&k, key, key_size);
> > +             WRITE_ONCE(*(unsigned long *)l_new->key, k);
> > +     }
> >       return l_new;
>
> [Severity: High]
> Does delaying the key update to the end of alloc_htab_elem() inadvertentl=
y
> leave the old key intact while the new value is initialized?
>
> While this prevents premature matches on the new key, it seems to expose
> the element to readers searching for the old key, breaking the RCU safety
> of recycled elements.

Discussed this topic here where we decided not to increase costs for
all callers for this case:
https://lore.kernel.org/all/CABdmKX1vF-FD4mFmmobNJeKjQLdZ9wztqGTcR4P9tSv_nE=
FsYw@mail.gmail.com/


> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928150121.17=
12559-1-tjmercier@google.com?part=3D2
