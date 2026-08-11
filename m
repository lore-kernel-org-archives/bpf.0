Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705C3939DA
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483695; cv=pass; b=kDsKSE9T5Gpenh1ivPez6ut/EHGz0ceF4BODSmEHezsR1QWGo2IFtCZnYREjoa3p8uIpoW+K6nh7jpChkK7IYIfORSQo9KTeVmliYfYHTnSs5axO3aqxEz9EspLNJA054RJk0B13l+y/UIy578Ipeb0t8/AXlRke3pgDv+e3id4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483695; c=relaxed/simple;
	bh=Flykugnpaai0D00LDfVR17NA84zTKRTzhRqWTlmrj54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdZqin0FWA6WOHD19YhAM+wS4Ucz3ZjDpYpSa1XokoBoWjtvFYLHfhlkX9Q0L/Z4bBRYY6hBOduSsE3cZ9t544JuNG9wyzt+RfmCzOTeY9HDqXhXreEwCSXkIjTYBs3A5Fke2U2/M2Elf/dDyklcQLeKCGBezUbjapukoENnLic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxkCRrnf; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxkCRrnf"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80c5cb9a888so2296387b3.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786483693; cv=none;
        d=google.com; s=arc-20260327;
        b=fcb9/iEAFfxn42zZsbVEvTBk+EmScFc2CBTsF1o9jv9/hQgsp9DUahh6NlW3ZUcD7r
         IfcXgJa0p+IdXywlOrWpQMyZB69r3D5/abQUhJtX97vDhNGVE4CXxraeJAeyrm3pmXyB
         /ddk6lqYhyeheVHVRnSPK8Rgj2jGLEZu4WOGaRHuzO8bLUl8QeVEaiEIU+y9JjSYG1XH
         +gP/CY4rQmMagiw4buQvnDlh+9orJghoKYSImD7rgbLtIwRRaAnugMf7bhlW2cxvOwt5
         lelZX0heExQVYEfhXVRWrqK+Zs/R5AZchS+ioNhrbRteqMaVK/++D8kfN/2aheP11Wt7
         cvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TJZxiqG9mp1c28pEHfAiKnTXRqUv7NSZbvy6Em86ZyA=;
        fh=KFuCT+lsuCBthncmPgCKNp8gBFIheQk8cxGC6Wnibas=;
        b=GmajTZnz0DSksVRqcg5QvMLSCQoYv+izASZCJl+9MWYaFp76XOgYsvLrLa9hmnslgk
         FvYM0gdxse8sUuuxPeUhLllCpcF4qLQ821+dmVgPJ7M0/HJKJJ4Hoz9CczsUe8o0xEC7
         baT5IlzzGpfG+gfvXPqdyc/dd9QPO2lCBEGzdANr3WMsh5VTS/L/jPMrG2h+V1JDv5AG
         mf3kQmRT3IjdLL+I98W6PbBWojvCW3hvZGaQBIRhGBimlFdHIUsNYZTc1VpuhO7axFLx
         3cViKu5DQPt5fm01ehU74TYOLYMb/P73ZqmipVSBwn4K+hkSp5jXS+0g3lVDtPZgYyUW
         4R9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786483693; x=1787088493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TJZxiqG9mp1c28pEHfAiKnTXRqUv7NSZbvy6Em86ZyA=;
        b=LxkCRrnfadlpgINCaUWuXI6KAXedCOAvRnD3yZiPGepksh1pwXl/6PR9EtTcAuUMQH
         jhcljUVjUdPZdcEUwMH77VhAshicyMfNYEiJberLQakTKlucKIJmUzLJwXnM77hz71ib
         Qke2IojfyvZTa/seSs0oDkMzvLdbieJUBMnNrpyUoizdeS575kxTTxikrb1Hw4zIGP1J
         c9Y1iSgsRvNBkNik4s4HYIhpmMTHmXzzS//TJ5r+c6PQB8cI1CalfbJOn0ANm1NJKy5O
         2fgfRaizWTSS8Oxp3eqzsARqFLcYdQ4kprKCXyVzjs0ioB4iebyNPOjrHX/09ycSdTRi
         6gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483693; x=1787088493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJZxiqG9mp1c28pEHfAiKnTXRqUv7NSZbvy6Em86ZyA=;
        b=QULMYoLoMP52SsyzcaYAbqcu+V+rgHmByGi3H0PwabgjDg23RrHNJnb5FZeaB9KMmc
         PXUu4tRNHm04iSosKHA+779VZUYodECy4zmyPQM4rqD+Az6WvKs8sKeIsCHHGaF3q1Kd
         dLbzwDmy4FPxJaP88OXeqPemacMvekW/mbICEKBC9VyGz5MOXkp1GHePWLRTO2/IAvTU
         soFdE9PDZDG5mPaydHbpaq0mHajQ5E2qE+l3ZjUbfXQ3B4SUdtPuFK9GCIdTwR7gLRjt
         zxgtWjEt+L4jSRogTiVE4r0/oWV7hFQqyYTHqUUkpBAPDYq47/CYKIIqspm2lxNyTxVl
         sZWA==
X-Gm-Message-State: AOJu0YxjJkwy3Hjm1OK0xabmIMUbafa38c4241YtboFqzksDysiXcx90
	b2QmOBTMnIsKaybKy72mZ8Wmhjgnt+oJLMtAFedt0h1zQuhg6wGlr5J8OAWnA+wWrbhUQq3eULc
	lB7ETSiXe/VjuVKOMjt/PyMAUSlNTUyt7/uj8WYo=
X-Gm-Gg: AR+sD13aU1S//Uaxpkh9MrBGpIchg92WQECWiwQnVbPRK5KQ+uE3TgIXUlC4tg2wDO0
	rORoiIRyO9ca0QGl1wAKOFRLlrugk7LyOIt6nRP9NCp9oHe2jERbIlztg6OXAvAU9mJ5xK/2spa
	F5WjqHvY63NP3YxfcRZ6OfyI6dLuWG1Y8RuJzlGt4ad0+nzN150nwIfvM00HgGHMdFmDS4ipS0F
	yD852nw7kc/gb73dCFiPGXt3UlzzQ3LXa3TYnCaS5IfB2HwQ3PQ8moMf3OyqM/ZVE9dWt/VwpSS
	2OtlhRW11OsHkUvdB0cN9RrHOfluwSzyNY8EECh/KtbN
X-Received: by 2002:a53:ac88:0:b0:667:daee:17ee with SMTP id
 956f58d0204a3-66b3435abeemr135648d50.39.1786483692713; Tue, 11 Aug 2026
 14:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-7-ameryhung@gmail.com>
 <DJXS1OUUJXX5.15RH1OEET2EB7@etsalapatis.com>
In-Reply-To: <DJXS1OUUJXX5.15RH1OEET2EB7@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 11 Aug 2026 14:28:01 -0700
X-Gm-Features: AUfX_mzRaUUSRn_6YJ8nKz9ykqvmylgy25gCquj266DPGEzqF69XkMED-VBYFMk
Message-ID: <CAMB2axMUWU6OigggngT6+hsSefdT0yaZ1C8fgH4peQAeybAqZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Add prog_list_init_item(),
 prog_list_replace_item(), and prog_list_id()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:56=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > Add three helpers to abstract operations on a bpf_prog_list entry.
> >
> > Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
> > which returns either pl->prog or pl->link->link.prog. This will not wor=
k
> > when struct_ops is attached to a cgroup because the attachment is backe=
d
> > by a struct_ops map instead of a BPF prog.
> >
> > The same applies to __cgroup_bpf_query(). Instead of always copying a
> > prog id to userspace, struct_ops cgroup attachment will need to copy th=
e
> > struct_ops map id.
> >
> > Refactor bpf_prog_array_item initialization into prog_list_init_item()
> > and prog_list_replace_item(), and refactor id lookup into prog_list_id(=
).
> > These helpers will be extended to support pl->link->map in a later patc=
h.
> >
> > This is a no-op change.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Followup on prog_list_prog() since I hadn't realized it was moved to the
> helpers in this patchset: Maybe we can just make it not return NULL
> since it's impossible instead of adding error handling to minimize
> churn.

Thanks for reviewing this patchset!

You are right that this set avoids calling prog_list_prog() on a
struct_ops entry and so NULL is never reaches the caller.

I'd still rather not drop the NULL return to avoid baking a caller
precondition into this generic helper. Nothing in prog_list_prog()'s
name or signature says "non-struct_ops entries only", so I'd rather
keep it the callers' responsibility to know which entries are backed
by a prog, prog link, struct_ops link, or being detached.

>
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index b100c04cb9c8..b43f0bff184c 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_=
prog_list *pl)
> >       return NULL;
> >  }
> >
> > +static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_p=
rog_array_item *item)
> > +{
> > +     item->prog =3D prog_list_prog(pl);
> > +     bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> > +}
> > +
> > +static void prog_list_replace_item(struct bpf_prog_list *pl, struct bp=
f_prog_array_item *item)
> > +{
> > +     WRITE_ONCE(item->prog, pl->link->link.prog);
> > +}
> > +
> > +static u32 prog_list_id(struct bpf_prog_list *pl)
> > +{
> > +     return prog_list_prog(pl)->aux->id;
> > +}
> > +
> >  /* count number of elements in the list.
> >   * it's slow but the list cannot be long
> >   */
> > @@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *c=
grp,
> >                               item =3D &progs->items[fstart];
> >                               fstart++;
> >                       }
> > -                     item->prog =3D prog_list_prog(pl);
> > -                     bpf_cgroup_storages_assign(item->cgroup_storage,
> > -                                                pl->storage);
> > +                     prog_list_init_item(pl, item);
> >                       cnt++;
> >               }
> >
> > @@ -1015,7 +1029,7 @@ static void replace_effective_prog(struct cgroup =
*cgrp,
> >                               desc->bpf.effective[atype],
> >                               lockdep_is_held(&cgroup_mutex));
> >               item =3D &progs->items[pos];
> > -             WRITE_ONCE(item->prog, pl->link->link.prog);
> > +             prog_list_replace_item(pl, item);
> >       }
> >  }
> >
> > @@ -1318,15 +1332,13 @@ static int __cgroup_bpf_query(struct cgroup *cg=
rp, const union bpf_attr *attr,
> >               } else {
> >                       struct hlist_head *progs;
> >                       struct bpf_prog_list *pl;
> > -                     struct bpf_prog *prog;
> >                       u32 id;
> >
> >                       progs =3D &cgrp->bpf.progs[atype];
> >                       cnt =3D min_t(int, prog_list_length(progs, NULL),=
 total_cnt);
> >                       i =3D 0;
> >                       hlist_for_each_entry(pl, progs, node) {
> > -                             prog =3D prog_list_prog(pl);
> > -                             id =3D prog->aux->id;
> > +                             id =3D prog_list_id(pl);
> >                               if (copy_to_user(prog_ids + i, &id, sizeo=
f(id)))
> >                                       return -EFAULT;
> >                               if (++i =3D=3D cnt)
>
