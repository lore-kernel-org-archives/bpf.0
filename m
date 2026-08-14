Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91EF3624CC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738758; cv=pass; b=Ns1g9R4dKYLia5Cowd1yF6sJtj2O6gto0KMHrxbro8OQPmT9RotQ34QT5NtcCSSZ27ZEQpYUreyCeCNN/IhxTj6zg/gQaGEK543TEb7ySIkJcxo7M5Ot4b2kjkiB8N+TWGm/UvuwlrIQSmzyiUX+AbR3FSe5+vAZJN8/Q9s2Ock=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738758; c=relaxed/simple;
	bh=0dMiVqMBH9dEZUG3I9jNmEE8AZbF3vAb1Pp4XsBAQV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdvKbki4hPJ0Nx9oNiv6b/ttBuQBPvhMPEex1tWP1O2+4jyeDbxGAW9ayfXdGc97lrx8kyYIXYegLGs+08jlcukvA5osy/QLUtQoiO9ToAiBg8ETfLBpk+EefJjQi+85w9XoyEEiohcZYC3JUP1BG6jgBWJuhyblQvH7TGxjYYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGfUydXC; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGfUydXC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1353526a12.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786738756; cv=none;
        d=google.com; s=arc-20260327;
        b=Wdwb0tCtzwuzC7LEnVmA260t1uMLxqCR7PyHt4CcixctPaG6fWWRAlfduT52p0y0PM
         hlhrbX3+1TdbgvBlIdtKhc6FR5IKLaJOYS9Q5wdFnieOdE9aPjwe0tGFDhDEkTFEc9Z0
         +2aWOGhTXTqXltn7hY35xyjk0Rui+rTSVhoAFkmOyYxf+PuzDgrOLDK6Y6OmmAKOHdN9
         6GuK4aZ/zxcs1OOl4JG9bXniFey9SmXTUsCOq+xf3d2ZuKJLX9i6c8m9pMpiisOtWRjR
         psEjvd/+ZjW94pqAqOqd87aYINg2Mdsv0UQepGb/Mbkv5rsK0myUdUMnyt+7UkRPr9L0
         /I1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bY6e4usJRGRBKgsr/624EHMsuewUZ3dHBCS8LMnl/8s=;
        fh=LlCVAFXVOtLoIece4SkOw39WG+XWz5O3AdpsuwRGTP0=;
        b=sii1v79Wq+xDF/bnDHiW7pGKJ56XpIfp13ScOuccLi+D4YLWrNWPdx7T76hiZ9U4LT
         XqRzUsHUin2gMeloR7a5tg2DqaOo3ILV+zwIZ2byTrYNzAJaRYnbVAX9Ix4e1BsjSyju
         nji8Tj0apitU/WTfBtYfM/PZW05ZhJDmr9sy2v83aXrkGEcvcPQVgEBRl931MdwxW2Zc
         vOzgSYLPsyWgKFncQQFcA+tWmJTNyzWAzSINadaNcJXJ+ZP+i7/62Btb1qJTuS/7kxKo
         VLbv/d8GypKYbddCOjKscUV3L13UT4KHQQTud1TYSa3J2WEA6lm+VZ5ymmAjQeMECh3T
         xvbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786738756; x=1787343556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bY6e4usJRGRBKgsr/624EHMsuewUZ3dHBCS8LMnl/8s=;
        b=bGfUydXCEEQ6RX0epLDEfzVnT4RRpy0BDKN6582rmbjF7fp2o2K+PKdFDbCKsVipEr
         rZRArigJylMj+2ndytgfc3nt2oso9KofVYMnjagYfLng6T6KFiqrhJQn8c8Muvgm7VMo
         wH8PAyqiq1gPQP7cr6D0DQ7wuMX6a7HujpuJzv67332jHx8/2UX5QYs27hppdLJnw6KZ
         q033PHMuwJjKbcUCfP9tnd8TKPWeSUUFaMhhY3KDvCDACrF9V0qWN7m/ZsVVfwmYEQor
         Jjq1j+fPEwvfOBcn3QT2hhpmsukZuaOvaaIB5BQofbv7oJia4y//ij2AOLbpd+5k4gD1
         HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786738756; x=1787343556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bY6e4usJRGRBKgsr/624EHMsuewUZ3dHBCS8LMnl/8s=;
        b=k2CNs15jPZYrbBxYhp1CxAR8C6P+dt5FE4pYxE540+56chit1e6L05mLoU+UH4pwaW
         DXUse+DkC9v7ji2Fw6HYYcKnjrV0MjsfMvJkWnvW/qz/muVmbebedj87QpeisUKqB3H/
         cDFKR9zSmn9xf3eDao/wp4CUb4/C237yz4zx1iZ8S5sLSaxbqIdcBT4BsprbyZFZfd4U
         6ZhCKUZ3GfZdmoIkmL/ICBAKXqSdNGi9UQkzAJ3Im475LWFaplUZQvJC2AxxFSWoC57W
         oxnV8z7xuOvu/QFv+M9IuZ50J+AipmSQXqHg0DxuR2de0Vak/avl9JUGHFc0jo4nx7+I
         zbTg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/hhD0mh962fiywqT3pwXCqndKR+26++MUAL27UGd53KXTs3CoF20R3P7nfTbMSkeffvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuAx+a9EXIhuXTdP+4pxSn6TKdYJ93gzAGEg9ibLDQdJck7xX
	LOx1Twg1hsudORPeeLkVGtT9eGQf4uadzmcTCO1BAWSIon7OSG8z0BHiwB0RNE9jbipX5Bk5DAs
	XLj7muoA4BDCpdV3NuFAYE3lBYo+dZKvaVQ==
X-Gm-Gg: AR+sD10ZEoSZQoeU5UMNAoXLaZ55hfW2j0ePR+bQ4UHNJFIV8uO38IGl3GGSqDpX5pY
	4FvbRZaQPiUTz9//4AaV34tLzMZ3Q9JnpQwd+MBZ/+1XS/I/JpkO7N9J0xu82tPh8DGgx+H9mcj
	quWldVhT0DpRVORTQ6o5diIf7bzLeAq9TNmhx7fbG7D7PGiPAE1TDgli8HxbG9L4wTZBEtgT/1a
	kXbvblra3fFGSnWMSjY+ZzvgF6vRSBM9k9Z1XBtu8+TNGtvdLLHQQuPk0GhI0GpfoAe1mS/D75H
	H8jcmsWGGsXHnzAULSaT7k+NmTuycBbNHrABNyqTDfnoThhDCudH6o86QQzo4GBysGQPp4j4Rxc
	7Ag6UKq1qchxznw+0n+/YUbzaEg==
X-Received: by 2002:a05:6a20:4388:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3cc71abd254mr10466568637.10.1786738756004; Fri, 14 Aug 2026
 13:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYLLOoiujaFO5GSra37i-DR-T4CGgU_zL-HGp2HEK2N2g@mail.gmail.com>
 <DFF6A1C5-51F5-4CAD-9627-3A59CA5853B3@linux.dev>
In-Reply-To: <DFF6A1C5-51F5-4CAD-9627-3A59CA5853B3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:19:00 -0700
X-Gm-Features: AUfX_mx-139Uy0JjkTHtqvJ0yxnr5-bLk41ZsCe1V_AWqrCMzAr5CK4rqE35u-s
Message-ID: <CAEf4Bzb-BifnOHQKeFNf2TX2WaF+-6yajVsWCNnn4Zgn545EOw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for
 resizable hashtab
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 1:15=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
>
> > On Aug 14, 2026, at 9:49=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:
> >
> > =EF=BB=BFIs it really a good use of tokens for sashiko to review old pa=
tches
> > that have either landed or were significantly changed since (and
> > probably got a bunch of new revisions sent), or just plain forgotten
> > by now?
> >
> > Did something regress recently? I'm not sure this has happened before
> > until recently...
>
> Ooops, it=E2=80=99s probably a recent regression I had which blocked sash=
iko reviews for few hours,
> so I had to restart some patch(set) semi-manually. Likely this one accide=
ntally got into this group.
> Should be a one time off though.

It's not just this patch, we've had quite a bunch of sashiko reviews
for months-old patches in the last few days. Just wanted to raise
awareness as this doesn't seem to be intentional.

But ok, let's hope this is a one-time glitch :)

>
> Thanks for reporting!
>
>
> >
> > -- Andrii
> >
> >> On Thu, Aug 13, 2026 at 4:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote=
:
> >>
> >> Thank you for your contribution! Sashiko AI review found 3 potential i=
ssue(s) to consider:
> >> - [High] Uninitialized memory read in `last_key` when `seq_show` overf=
lows.
> >> - [High] `rhashtable_walk_enter_from` resets iterator on deleted curso=
r key, causing O(N^2) complexity and infinite loops.
> >> - [Medium] Missing __GFP_NOWARN flag in user-controlled kmalloc for ma=
p->key_size can lead to OOM splats.
> >> --
> >>
> >> --- Patch [8]: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator A=
PIs for resizable hashtab ---
> >> commit 226ce1988038cf4876ff0a72b5ae8e5ebc263151
> >> Author: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> bpf: Implement iterator APIs for resizable hashtab
> >>
> >> Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
> >> bpf_iter and bpftool map dump work with resizable hash maps.
> >>
> >>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >>> index 4611671bf8e74..5ca4d26e70178 100644
> >>> --- a/kernel/bpf/hashtab.c
> >>> +++ b/kernel/bpf/hashtab.c
> >>
> >> [ ... ]
> >>
> >>> @@ -3205,36 +3218,113 @@ struct bpf_iter_seq_rhash_map_info {
> >>>      struct bpf_map *map;
> >>>      struct bpf_rhtab *rhtab;
> >>>      struct rhashtable_iter iter;
> >>> -     u32 skip_elems;
> >>> +     void *last_key;
> >>>      bool iter_active;
> >>> };
> >>>
> >>> static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *po=
s)
> >>> {
> >>> -     return NULL;
> >>> +     struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> >>> +     struct rhtab_elem *elem;
> >>> +     void *key =3D *pos > 0 ? info->last_key : NULL;
> >>> +
> >>> +     scoped_guard(rcu) {
> >>> +             rhashtable_walk_enter_from(&info->rhtab->ht, &info->ite=
r,
> >>> +                                        key, info->rhtab->params);
> >>
> >> [Severity: High]
> >> Will this silently restart iteration from bucket 0 if the cursor key i=
s deleted?
> >>
> >> rhashtable_walk_enter_from() looks up the provided cursor key to resum=
e
> >> iteration. If the key is missing, it returns early and leaves the iter=
ator at
> >> bucket 0 (iter->slot =3D 0).
> >>
> >> In __rhtab_map_lookup_and_delete_batch(), the batch operation deletes =
elements
> >> and returns the last deleted key to userspace. On the next batch sysca=
ll, the
> >> user passes this deleted key back as the cursor. Since the key no long=
er
> >> exists, rhashtable_walk_enter_from() resets the iterator to 0.
> >>
> >> The inner loop then executes while (total < max_count) holding rcu_rea=
d_lock(),
> >> rescanning all previously emptied buckets from the beginning of the ta=
ble.
> >>
> >> For lookup_batch and seq_file iterators, does this yield massive dupli=
cate
> >> outputs to userspace and enormous RCU stall times?
> >>
> >>> +             rhashtable_walk_start(&info->iter);
> >>> +     }
> >>> +     info->iter_active =3D true;
> >>> +
> >>> +     elem =3D rhtab_iter_next(&info->iter);
> >>> +     if (!elem)
> >>> +             return NULL;
> >>> +     /*
> >>> +      * if *pos is not 0, previously iteration failed on this elem,
> >>> +      * so we are restarting it. That's why no need to increment *po=
s.
> >>> +      */
> >>> +     if (*pos =3D=3D 0)
> >>> +             ++*pos;
> >>
> >> [Severity: High]
> >> Does this pass uninitialized memory as a hash key if seq_show() output
> >> overflows?
> >>
> >> When reading a BPF iterator, seq_read_iter() calls bpf_rhash_map_seq_s=
tart(),
> >> which increments *pos from 0 to 1 and returns the first element.
> >>
> >> If the output of seq_show() for this element exceeds the initial seq_f=
ile
> >> buffer, the buffer overflows. The sequence machinery reallocates a lar=
ger
> >> buffer and calls seq_start() again.
> >>
> >> Since *pos is now 1, the code executes key =3D info->last_key. However=
, last_key
> >> is only populated in seq_next(), which hasn't been called yet. Thus, l=
ast_key
> >> remains uninitialized from its kmalloc(..., GFP_USER) allocation.
> >>
> >>> +     return elem;
> >>> }
> >>
> >> [ ... ]
> >>
> >>> static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_a=
ux_info *aux)
> >>> {
> >>> +     struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
> >>> +     struct bpf_map *map =3D aux->map;
> >>> +
> >>> +     info->last_key =3D kmalloc(map->key_size, GFP_USER);
> >>
> >> [Severity: Medium]
> >> Does this need __GFP_NOWARN?
> >>
> >> Since BPF hash map key sizes can be extremely large, requesting large
> >> contiguous memory blocks without __GFP_NOWARN can fail loudly under me=
mory
> >> fragmentation and trigger high-order page allocation warnings.
> >>
> >>> +     if (!info->last_key)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     bpf_map_inc_with_uref(map);
> >>> +     info->map =3D map;
> >>> +     info->rhtab =3D container_of(map, struct bpf_rhtab, map);
> >>> +     info->iter_active =3D false;
> >>>      return 0;
> >>> }
> >>
> >> --
> >> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-rhash=
-v2-0-3b3675da1f6e@meta.com?part=3D8
> >>
