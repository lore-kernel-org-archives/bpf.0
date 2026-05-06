Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9488343D63
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072799; cv=pass; b=levCC/3gnaBIK/NamSe+zZgak8EFp+SKDQJ4tppYd5R1/+a45oBv8uJPP2B+RMl0m+1w1itQhe7R/MMVBHidxV+0Ba9N6Y2Hr3AEZOAqeV5QIHzyCcVu41hJDVXLUf48b613hl3hLDFS7t66gxREjVQlFpmO7oDk+ZiA1iUrQMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072799; c=relaxed/simple;
	bh=kFWKUB4ksxj1GEL/enYPKm5dzhHF2x6c4ER6bjPSdHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5TRlOjSRNHIDhwSn+Pa8ZLHeRC8DvjtJXliQrewJDNgOtTmou8e7S5Wysxvlgj9KK3J6oKJMCZYOJu8kiySCGqfqMo/uPaqTvHgKPvbn0GMkk78fKtK1C5XscBDcBkBy+gKMmEHxUDCoHcUhTIzu6o9F0ixoxvazd2yDsd4pq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ/lBJ5s; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ/lBJ5s"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393d07e8938so2569341fa.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778072795; cv=none;
        d=google.com; s=arc-20240605;
        b=JKCVxNAJaqNs1QOfuH/wUf7d56MXEhcWTScPoeDr5DwnbtjdqY424CBT2dOZJaCr3V
         zjyQKBegCjKoKmiCa9IeUQGF3/Yfa5ojlQPmAdLNvPkLIYwFbhE5/PKhjf8GTZaDUD15
         7Fph0Swm7ik9+r42lMHmfS7BBL+zc7TJFRZpB3JuOOo/hcjUN/xqgBsSyELA9pUF7ZuQ
         zHVdhCQHZdCTohaOkDly+7w2RjK8OG71o3kaVm1Iv95pkmYwrJBa5wUUOJC28NNK8pWw
         P2Z7FG26fUThvb9tArntNs0yhWZfZLB1vZdH0mGRcEThTjJB2yBfJsV3fwsz7Ta/BGHn
         NSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qIha8O8IglA0EGFTspNtQXsJyVziplf6EjUrxckyjaw=;
        fh=i4pFcCHJNKN3toCWGALGsPhsFXcRtRoy1L/qpTRNr0A=;
        b=Fx/GndyowIjqMCPRe8hNnfOqytH9AgGIvLtrR/pyZIHvWv8NJpEgu3tRSM0+cqW7e3
         oc4eElH93pP+x9M3JdUtRCKQchz+HPgjx5B5gSYAfm/UaAKM1pQIGIpWD8V/4TOJqeMQ
         7QoXlk3eugop4hssttzS4f5wDyiKOv+XBOTjoKQMZDLhf9z5q4X4HYckmMx8c6/ADAxB
         L6PPerEi+UR7dlQtmjnA4M5Txrx6fztOEGldqYpgUfERQW+q8yvY1CsnLmXPFcIFOw9G
         RguGKWEQFrM6A9eiG5Yv1iwbHZZ57BdethvnCK/xwDPp4jNqMQptsQNcmELlKgFMFIR2
         I5oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778072795; x=1778677595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIha8O8IglA0EGFTspNtQXsJyVziplf6EjUrxckyjaw=;
        b=CZ/lBJ5sby0XKOuAcpGET+awnDb6h1ttJcAP6DgIAKGJisrETE1AHsb9o+1wvg7Jzn
         6w0muSDZc4k79upV4EzgeIVBGlcEDmIiigvJD2IJzaDUbYyBHizBv7EJLfGXtgdDuGIn
         q49qlUYyUwcdPIRlPZ0M76GqvwAEncEsIB00hL7ThPnlDj8Adi/sczoKF3rkruY+nbMu
         UBHqceUJedYkbbjeB61sSBHerpdoIHzi02sjZ9pY2pysXVBAtZYzbVBePJhY5HfxDy80
         vHqis6z1gjWkW0ViJy/gW7NAdLAh0qKNXgzzKtHgLo3VVz+2OePwG4efGBP9brx8ZFet
         RcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778072795; x=1778677595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qIha8O8IglA0EGFTspNtQXsJyVziplf6EjUrxckyjaw=;
        b=o/OUHIM8uyCelSjRAHk9uJPaQWHRfHTA3yLO3plpf4dRg7H3lER+4TawxfS37+XeDL
         vlvtmO5miUvF5GU8ym4OfXkfSuW8amk2neZ+YptGvEgD03NhX+JZxHviUMOoA+kJhOEz
         YufHfqHSeRlqHXFZPgZzXHS80/orVe1zH1EnAMOAqr/QReH+NjhB9yhWGgCYo3AEnr+M
         /Y40hUNYqb2XZrHP1nL8yeJsl6lzD7Cm+9a4mAwWA2VKD3czW4GVYNc61MDfaWSLlQPn
         rgu50e0i1qNxqDDNFXgkKEhWe74p9tuoGi//h03VDKn49dDgZ5wy7Hw13lPoQ0WiYnKp
         QeIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8w77kl6A/tMxsrYA8t+W0laK68Ht8TrWLAUKMsIyv0RUBjoBLcXuh2l3F0UUeMROE7rLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0mr7wMOaDI2M+P7pMDZIfp+YR02/kAFG5L+UC5c6EReSpNM0
	3AQLkaCyhXdncDPV6BKBkQVT0SFu1CZEoL9U2osucqBMSH/Pod/B9WcNb3x+WDVQRSkWCwMyfLD
	wyY030+XWndF7i2czZRakvVI74RQVpu4=
X-Gm-Gg: AeBDievwS/zPWjxbus//CBqzIXh4TjOllAuS81QJKFoy4vlHsqW4GdEBfe8Pi8OQRBy
	WTXYrpU6YP2qU8a/h6qORZuF0wrzzOb+ik2UvMUjCWwW3gRCD8+Qd7avse7D+seN3Lm2TcocBfs
	FQc3N4/GWOA+3FB5V+hgelAucZ2Ysj2xkF7V1FCXY6EgfH42o0t7+qv/PoHmtzmOg3TN45kM9PY
	h35c+C+m4jHFaQD9JRgPgPLgGI04W9ac2HCjldNIAf3JHgS5fhvCSENsgI16IZai4ZKwHy9utC7
	nL/ADK8sD/E6a49o/NmQhz7wWCc=
X-Received: by 2002:a2e:be85:0:b0:38c:c36b:8221 with SMTP id
 38308e7fff4ca-393c3f0d59fmr14338631fa.0.1778072794477; Wed, 06 May 2026
 06:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-4-vernon2gm@gmail.com> <a74b6b1d137439121917216ef386bbab9107afcc89819d1fd94e389b8c54b4f1@mail.kernel.org>
In-Reply-To: <a74b6b1d137439121917216ef386bbab9107afcc89819d1fd94e389b8c54b4f1@mail.kernel.org>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Wed, 6 May 2026 21:06:23 +0800
X-Gm-Features: AVHnY4JugtOdbG81NqtvS8OnnXg2CeaCnqaekvuLdZtxK-4PsvAJWtwh-SV06ig
Message-ID: <CACZaFFM-o+oFKbnpnHKL9tk01-i=h7Uc2uh_KH1BO9x5NapQUw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: introduce bpf_mthp_ops struct ops
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	yanglincheng@kylinos.cn, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 1:35=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf_huge_memory.h b/include/linux/bpf_huge_m=
emory.h
> > new file mode 100644
> > index 000000000000..1c8a6f7ad8f1
> > --- /dev/null
> > +++ b/include/linux/bpf_huge_memory.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef __BPF_HUGE_MEMORY_H
> > +#define __BPF_HUGE_MEMORY_H
> > +
> > +/**
> > + * struct bpf_mthp_ops - BPF callbacks for mTHP operations
> > + * @mthp_choose: Choose the custom mTHP orders
> > + *
> > + * This structure defines the interface for BPF programs to customize
> > + * mTHP behavior through struct_ops programs.
> > + */
> > +struct bpf_mthp_ops {
> > +     unsigned long (*mthp_choose)(struct cgroup *cgrp, unsigned long o=
rders);
> > +};
> > +
> > +#if defined(CONFIG_BPF_TRANSPARENT_HUGEPAGE) && defined(CONFIG_BPF_SYS=
CALL)
> > +/**
> > + * bpf_mthp_choose: Choose the custom mTHP orders using bpf
>                       ^
> The kernel-doc format for functions uses parentheses followed by a dash, =
not
> a colon. When scripts/kernel-doc processes this file, will it skip this
> function documentation?

I will fix that in the next version. Thanks!

> > + * @mm: task mm_struct
> > + * @orders: original orders
> > + *
> > + * Return suited mTHP orders.
> > + */
>
> [ ... ]
>
> > diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> > new file mode 100644
> > index 000000000000..e34e0a35edac
> > --- /dev/null
> > +++ b/mm/bpf_huge_memory.c
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Huge memory related BPF code
> > + *
> > + * Author: Vernon Yang <yanglincheng@kylinos.cn>
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/srcu.h>
> > +
> > +/* Protects cgrp->mthp_ops pointer for read and write. */
> > +DEFINE_SRCU(mthp_bpf_srcu);
> > +
> > +unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orde=
rs)
> > +{
> > +     struct cgroup *cgrp;
> > +     struct mem_cgroup *memcg;
> > +     struct bpf_mthp_ops *ops;
> > +     int idx;
> > +
> > +     memcg =3D get_mem_cgroup_from_mm(mm);
> > +     if (!memcg)
> > +             return orders;
> > +
> > +     cgrp =3D memcg->css.cgroup;
> > +     ops =3D READ_ONCE(cgrp->mthp_ops);
>                 ^^^^^
> > +     if (unlikely(ops)) {
> > +             idx =3D srcu_read_lock(&mthp_bpf_srcu);
>                       ^^^^^^^^^^^^^^^^^
> Could there be a use-after-free here? The pointer is read BEFORE entering
> the SRCU read-side critical section. If bpf_mthp_ops_unreg runs on anothe=
r
> CPU between these two lines, synchronize_srcu returns immediately because
> no reader holds the lock yet.
>
> Race sequence:
> (1) Thread A loads ops (non-NULL) above
> (2) Thread A is preempted
> (3) Thread B calls bpf_mthp_ops_unreg, clears the pointer, calls
>     synchronize_srcu which returns immediately
> (4) Thread B frees the backing memory
> (5) Thread A resumes, enters SRCU section, then dereferences ops->mthp_ch=
oose
>
> For SRCU to protect the pointer across its use, the reader must hold
> srcu_read_lock before reading the pointer. Would moving the srcu_read_loc=
k
> before the READ_ONCE prevent this race?

Good catch, I will fix that in the next version. Thanks!

> > +             if (ops->mthp_choose)
> > +                     orders =3D ops->mthp_choose(cgrp, orders);
> > +             srcu_read_unlock(&mthp_bpf_srcu, idx);
> > +     }
> > +
> > +     mem_cgroup_put(memcg);
> > +
> > +     return orders;
> > +}
>
> [ ... ]
>
> > +static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_li=
nk *)link;
> > +     struct bpf_mthp_ops *ops =3D kdata;
> > +     struct cgroup *cgrp =3D st_link->cgroup;
>                                 ^^^^^^^^^^^^
> Can this dereference NULL? When bpf_struct_ops_map_update_elem calls the
> reg callback at kernel/bpf/bpf_struct_ops.c:873, it passes link =3D NULL =
for
> maps without BPF_F_LINK. When link is NULL, st_link->cgroup dereferences
> NULL before the check at the next line runs.

Yeah, I will fix that in the next version. Thanks!

> > +     struct cgroup_subsys_state *pos;
> > +
> > +     /* The link is not yet fully initialized, but cgroup should be se=
t */
> > +     if (!link)
> > +             return -EOPNOTSUPP;
>
> Does this comment match reality? Looking at bpf_struct_ops_link_create in
> kernel/bpf/bpf_struct_ops.c:1397, the link was fully initialized by
> bpf_link_init and bpf_link_prime before calling reg. Also, struct
> bpf_struct_ops_link does not have a cgroup field in its definition at
> kernel/bpf/bpf_struct_ops.c:58.
>
> Also, does struct bpf_struct_ops_link actually have a cgroup field? Its
> definition shows only { struct bpf_link link; struct bpf_map __rcu *map;
> wait_queue_head_t wait_hup; }. The patch does not add this field to the
> struct. Would this cause a compilation error?

This series is based on linux v7.1-rc1 (26fd6bff2c05) + "mm: BPF OOM"[3]
first four patches.

All of the above definitions are in  "mm: BPF OOM" PATCH#2.

https://lore.kernel.org/linux-mm/20260127024421.494929-3-roman.gushchin@lin=
ux.dev/

> > +
> > +     cgroup_lock();
> > +     css_for_each_descendant_pre(pos, &cgrp->self) {
> > +             struct cgroup *child =3D pos->cgroup;
> > +
> > +             if (READ_ONCE(child->mthp_ops)) {
> > +                     /* TODO
>                     ^^^^^
> This isn't a bug, but per BPF comment style (subsystem/bpf.md), multi-lin=
e
> comments should have the opening /* on its own line in BPF-related files.
>
> > +                      * Do not destroy the cgroup hierarchy property.
> > +                      * If an eBPF program already exists in the sub-c=
group,
> > +                      * trigger an error and clear the already set
> > +                      * bpf_mthp_ops data.
> > +                      */
> > +                     continue;
> > +             }
> > +             WRITE_ONCE(child->mthp_ops, ops);
> > +     }
> > +     cgroup_unlock();
> > +
> > +     return 0;
> > +}
> > +
> > +static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_li=
nk *)link;
> > +     struct bpf_mthp_ops *ops =3D kdata;
> > +     struct cgroup *cgrp =3D st_link->cgroup;
>                                 ^^^^^^^^^^^^
> Can this dereference NULL? Looking at bpf_struct_ops_map_delete_elem in
> kernel/bpf/bpf_struct_ops.c:936, it calls unreg with link =3D NULL. When
> link is NULL, st_link->cgroup dereferences NULL.

Yeah, I will fix that in the next version. Thanks!

> > +     struct cgroup_subsys_state *pos;
> > +
> > +     cgroup_lock();
> > +     css_for_each_descendant_pre(pos, &cgrp->self) {
> > +             struct cgroup *child =3D pos->cgroup;
> > +
> > +             if (READ_ONCE(child->mthp_ops) =3D=3D ops)
> > +                     WRITE_ONCE(child->mthp_ops, NULL);
> > +     }
> > +     cgroup_unlock();
> > +
> > +     synchronize_srcu(&mthp_bpf_srcu);
> > +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/252852=
79315
