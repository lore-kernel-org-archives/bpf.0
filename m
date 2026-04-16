Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDB395257
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333548; cv=pass; b=imwjwciuSycQ55cPmQPnN29TPUOUIndcNXHfWK6NPN84CQ8KvDRVTj3+ukVkYuRjVu9z0rwdUxfbp7TtDXxcBbzv9Iy0DOPCjWXzkU/TGVKVWIeEsaVzSDZOoW59ed/XVipGgDbAx8MGJ+PfwxRwXwbHmeu3g/gIZp5TazYI6vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333548; c=relaxed/simple;
	bh=B2adID4oHMiKjpDnrLEpOdrg25k/SPPdzX3FVHgeEf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxJQQnSBSfdbJQL5f3s9ZYUn1NYzmWL8cTcthOyR8xw2TfcUxJ/40JxxSAHQjzsRk5DzQn9/ZTU05ErJpLIP/ccTO0fY4xYStAGPE7unub9SyBRyU9+Vdk2fHOlcY17Al6fcbGUa7POf7T8sVmXYpTpNQi5bIc2Unm1xG+SEGeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/41F3I8; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/41F3I8"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a10d130b37so454929e87.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 02:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776333543; cv=none;
        d=google.com; s=arc-20240605;
        b=YL4PjJBGCScglBUkuGpvTlJaMgBSN/voeA/aM02q1UG5E4F+6aVAF4L2OTZRUmd7wJ
         2OVb9gaDYyBasnDHMbz/oaXvwNj/j0eJzXMPPvdTZS4hbvduc3VjvhY6HjUFcLG9Cr0s
         VrufyRy6xBZFImbIyLF/n4i0TQB/M7EbQdH5Wf4kozO7gEyX3WcYgCWV3sxc2K7vsDKW
         rkK0Rg1XLHGIB7XCjqSC02rYR0HUvzz1QuaFY2oeAP8sQFdVHNLYgGj9L7oWTFucvLj3
         anj8mNalGlKRX8pLafs7jmar/xdgsvOrASchLfwZCwjeplscXeeN0oUUrojntKD+NGi/
         /Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUxpOuiz+aOvX6zBmdfxgMUPYRyc3oE2F9IAKlQesWI=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=XrEV5cYoeuqLRi08CLpqDW23uF78RoeXRbdcRQQhsyFJzDFRXfS7s3dFhQrQVmHSaE
         tEVCgJucw0nKNZeqqxD0BHWsnAOR1jotJkjU16Wl9UE58n7RO7ERYC1/JB4HDypJC2Ua
         b7sOtuwwG7Jlk2urQpbjZuyhw6RBPGtnSPPWkh1GlEUbFH2hWO/6NWq2SqCVqlafRl4D
         PDhXBUQrQc6X9ovx6SjkWplDqa0kpI2UqTF03ftjAcY1Kj0wR+38vW4K9/eTxeTrtjZk
         9lj4f2j/EM2eJ8dYwPJgUOz6HZVfB8qiK2LLNtE8fuxzH5IeAnBWryuWLPV0SE8DirVX
         3Ntg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776333543; x=1776938343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUxpOuiz+aOvX6zBmdfxgMUPYRyc3oE2F9IAKlQesWI=;
        b=h/41F3I89SDEAmbB6wMlmD4nHonYHlsCuyDToFBhv2UN7Rgp6yBk2SuW0kLWUpLDrU
         D86Ws/bs5zfNkyOxluc5UpYZcm+NmR/RntSyezrSVTH4CKlJIMDqR6IAVQJ5+phRHq9v
         CpUNIeuE1xyALXQ7kd4qATKNoQN3A2BQNuydyj6d+OrqGsBvKVfIzQlgmZS6wzkdLXju
         UoPBUuN3Thct9Tc4qeQNx2hTGq71yHFnjd7YeJDtSTspq1a6trSFW0T/krWmoDoSuLLl
         HKhgAGF0jrEZZwg5aBKBgHg7zTRLMg7/ByeH6Er5dwwwtG8jStcik6YWNaDHnWPPZJ9O
         qNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776333543; x=1776938343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUxpOuiz+aOvX6zBmdfxgMUPYRyc3oE2F9IAKlQesWI=;
        b=RY86LjRhe5IVMZTr4q5cNXrrbJfJ5IdtuHBD9CAJK6DEWoZhTvS7xmDVQeAgMAhL/l
         voBabHFifii0kDVsHwXMwvv4xK2EKE7q0C7JD+KUSYzkIXBT7KcixlIas5Ug+Nzk+pka
         kiyxJ2sfIxUQQR5WCjQ2hdnJUMtpwPYhQBgAWZKwt/O8+9mWWEcN+QwdqVAgoYsFQfP0
         j8jyGJwb8drK/cXgDVn2FcHFiDXq6gOL3khTxmqWTGQpQK4ObcB3YUEKuKzhYnaHfMCS
         ovPN+GQQTEm/8tY0kydk/PMXSO1wEDjDFAjNBszzNuX1B/4K+nJ/o+DTQd0vsY8p5Q2+
         T3XQ==
X-Gm-Message-State: AOJu0YyIZBfkmNsP1dJ07ZCtjI8CJ7+p6nzTmFG9D6LP6cuypJBLMh8f
	oyYSdEhSZhg5ot+j4+QzGmPtplQXXgBLGYHnnqzt1092OEAU5WQrIevXMJvxr2Sg8VKlgn6kcOW
	tJbOgy6b8SKK9s9AVj3/4ZQ2a1O6TIrWg1RDVGNY=
X-Gm-Gg: AeBDiev/LSOKuxOn8aY8+OAQVIzjkBpp6/E7w/I5KhsC/JtDHdNCSL4Tbi0CpJEuIyQ
	aqEglrEetOkvLOC1L1C77sa53mhKNbnXi2MC13nrrizhPrcEQLp9P99+MsCQpRXz0QAeMrLhlsJ
	+cTozMCoPsKijssKgRfozEsEsIY03wd8KdBaxHM/gr5/KtKA+IJIMduFZDV45TLFNVqweKdF6Ur
	buzixSsgbyj9NDkq8QRGGRZbNU7V3tbgSgFpL2Jkq6V2rPjEX6IN63rrghmtnvkVReNgmUrxf1P
	B4fUJYhSFK08KoIAy7I=
X-Received: by 2002:a05:6512:1302:b0:5a4:f0:c4c1 with SMTP id
 2adb3069b0e04-5a40df63d88mr992181e87.2.1776333542880; Thu, 16 Apr 2026
 02:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-12-kerneljasonxing@gmail.com> <20260415093801.0CECEC19424@smtp.kernel.org>
In-Reply-To: <20260415093801.0CECEC19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 17:58:25 +0800
X-Gm-Features: AQROBzDgK52vu34vOfi2wBv8wO9PH-S6Ynn9N1Jw_mPIutb-OW6GDjEWc8Iof9c
Message-ID: <CAL+tcoDTZQueaNgcG+90wZohcU4c3Btn74McteqU7DSN=HgucQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 11/14] xsk: support batch xmit main logic
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 5 potential issue(s):
> - [Critical] TOCTOU race on socket state pointers leading to NULL pointer=
 dereference and Use-After-Free.
> - [Critical] Integer underflow in `xsk_alloc_batch_skb()` leading to mass=
ive OOB memory allocation and kernel crash.
> - [Critical] Unconditional dropping of partially built packets (`xs->skb`=
) causes buffer leaks and packet stream corruption.
> - [High] Double cancellation of CQ slots and incorrect TX pointer manipul=
ation on SKB build failure.
> - [High] Infinite `-EAGAIN` livelock and stat inflation when packets span=
 batch boundaries.
> --
>
> commit 4041fe3cb310f6f01b04ae2ff1fbd04cf0aa2713
> Author: Jason Xing <kernelxing@tencent.com>
> xsk: support batch xmit main logic
>
> This commit implements the core logic for batched transmission in AF_XDP
> sockets via __xsk_generic_xmit_batch(). It introduces a loop to read
> descriptors, reserve completion queue slots, allocate SKBs, and transmit
> packets in batches.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index b4f3cc7125804..16e47f6fc30ec 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> [ ... ]
> > @@ -914,6 +914,122 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs=
,
> >       return ERR_PTR(err);
> >  }
> >
> > +static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
> > +{
> > +     struct xsk_buff_pool *pool =3D xs->pool;
> > +     struct xsk_batch *batch =3D &xs->batch;
> > +     struct xdp_desc *descs =3D batch->desc_cache;
> > +     struct net_device *dev =3D xs->dev;
> > +     u32 max_batch, max_budget;
> > +     bool sent_frame =3D false;
> > +     struct sk_buff *skb;
> > +     u32 cons_descs;
> > +     int err =3D 0;
> > +     u32 i =3D 0;
> > +
> > +     mutex_lock(&xs->mutex);
>
> Can a TOCTOU race occur here with a concurrent socket bind() or setsockop=
t()?
>
> The pointers for pool, dev, and batch->desc_cache are read before the mut=
ex
> is acquired. If another thread modifies the socket state, could these
> pointers be NULL or freed by the time xsk_is_bound() is checked, leading =
to
> a use-after-free or NULL pointer dereference when accessing dev or descs?

Indeed, I'm going to move those read operations under the mutex lock protec=
tion.

>
> > +
> > +     /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> > +     if (unlikely(!xsk_is_bound(xs))) {
> [ ... ]
> > +     for (i =3D 0; i < max_budget; i +=3D cons_descs) {
> > +             u32 nb_pkts =3D 0;
> > +             u32 nb_descs;
> [ ... ]
> > +             cons_descs =3D xskq_cons_read_desc_batch_copy(xs->tx, poo=
l, descs,
> > +                                                         nb_descs, &nb=
_pkts);
> > +             if (cons_descs < nb_descs) {
> > +                     u32 delta =3D nb_descs - cons_descs;
> > +
> > +                     xsk_cq_cancel_locked(pool, delta);
> > +                     xs->tx->queue_empty_descs +=3D delta;
> > +                     if (!cons_descs) {
> > +                             err =3D -EAGAIN;
> > +                             goto out;
> > +                     }
>
> Could this lead to an infinite -EAGAIN livelock and inflated statistics?
>
> If a multi-fragment packet spans beyond the nb_descs batch limit without =
an
> end-of-packet descriptor, xskq_cons_read_desc_batch_copy() might safely
> rewind the fragments and return 0. The code then treats these valid
> descriptors as empty, adds to queue_empty_descs, and returns -EAGAIN,
> causing the application to loop infinitely hitting the same boundary.

Point taken. It costs me some time to investigate how to support
multi-buffer in this scenario. I finally come to conclusion that
change the behavior of __xskq_cons_read_desc_batch() should be fine:
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index c3b97c6f2910..c8b7079a6728 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -270,6 +270,7 @@ __xskq_cons_read_desc_batch(struct xsk_queue *q,
struct xsk_buff_pool *pool,
 {
        u32 cached_cons =3D q->cached_cons, nb_entries =3D 0;
        u32 total_descs =3D 0, nr_frags =3D 0;
+       bool copy =3D !!nb_pkts;

        /* track first entry, if stumble upon *any* invalid descriptor, rew=
ind
         * current packet that consists of frags and stop the processing
@@ -288,7 +289,7 @@ __xskq_cons_read_desc_batch(struct xsk_queue *q,
struct xsk_buff_pool *pool,
                if (likely(!parsed.mb)) {
                        total_descs +=3D (nr_frags + 1);
                        nr_frags =3D 0;
-                       if (nb_pkts)
+                       if (copy)
                                (*nb_pkts)++;
                } else {
                        nr_frags++;
@@ -300,10 +301,11 @@ __xskq_cons_read_desc_batch(struct xsk_queue *q,
struct xsk_buff_pool *pool,
                nb_entries++;
        }

-       cached_cons -=3D nr_frags;
+       if (!copy)
+               cached_cons -=3D nr_frags;
        /* Release valid plus any invalid entries */
        xskq_cons_release_n(q, cached_cons - q->cached_cons);
-       return total_descs;
+       return copy ? nb_entries : total_descs;
 }

 static inline u32

After this, this function shall return the correct descriptors.

>
> > +                     nb_descs =3D cons_descs;
> > +             }
> > +
> > +             cons_descs =3D xsk_alloc_batch_skb(xs, nb_pkts, nb_descs,=
 &err);
>
> Does this calculation of nb_pkts trigger an integer underflow?
>
> If a batch contains only fragments without an end-of-packet flag, nb_pkts
> will be 0. Inside xsk_alloc_batch_skb(), if there is an existing partiall=
y
> built skb (xs->skb !=3D NULL), the code may decrement nb_pkts. Since nb_p=
kts
> is unsigned, nb_pkts-- would underflow to 0xFFFFFFFF, resulting in a
> massive out-of-bounds memory allocation.

Right, I should avoid that under the condition where the nb_pkts is zero :
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a61477d04c14..e04eda59eb7a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -671,7 +671,7 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32
nb_pkts, u32 nb_descs, int *err
        if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
                base_len +=3D dev->needed_tailroom;

-       if (xs->skb)
+       if (xs->skb && nb_pkts > 0)
                nb_pkts--;

        if (skb_count >=3D nb_pkts)

>
> > +             /* Return 'nb_descs - cons_descs' number of descs to the
> > +              * pool if the batch allocation partially fails
> > +              */
> > +             if (cons_descs < nb_descs) {
> > +                     xskq_cons_cancel_n(xs->tx, nb_descs - cons_descs)=
;
> > +                     xsk_cq_cancel_locked(pool, nb_descs - cons_descs)=
;
> > +             }
>
> Can this cause a double cancellation of completion queue slots?
>
> If xsk_build_skb() fails inside xsk_alloc_batch_skb() due to memory limit=
s,
> it already calls xsk_cq_cancel_locked() internally:
>
> net/xdp/xsk.c:xsk_build_skb() {
>         ...
>         if (err =3D=3D -EOVERFLOW) {
>                 ...
>         } else {
>                 xsk_cq_cancel_locked(xs->pool, 1);
>         }
> }
>
> Calling xsk_cq_cancel_locked() again here for the failed descriptors woul=
d
> underflow the completion queue pointers, potentially corrupting the user
> space ring buffer.
>
> Also, does xsk_build_skb() advancing the TX consumer pointer on -EOVERFLO=
W
> conflict with the rewind happening here?

Right, I mentioned in the previous patch that we can handle this issue
in patch 2 to bypass this part in batch mode to solve the problem.

>
> [ ... ]
> > +             if (err)
> > +                     goto out;
> > +     }
> > +
> > +     /* Maximum budget of descriptors have been consumed */
> > +     if (xskq_has_descs(xs->tx))
> > +             err =3D -EAGAIN;
> > +
> > +out:
> > +     if (xs->skb)
> > +             xsk_drop_skb(xs->skb);
>
> Does unconditionally dropping the partially built xs->skb corrupt the pac=
ket
> stream?
>
> If transmission hits a NETDEV_TX_BUSY (-EAGAIN) or a valid multi-fragment
> packet spans a batch boundary, the code drops the fragments processed so =
far.
> Because the completion queue slots and TX pointers for these early fragme=
nts
> might not be properly rewound or notified, does this permanently leak buf=
fers
> and merge unrelated fragments into corrupted packets on the next sendmsg(=
)
> retry?

Right. It will be fixed by:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 8c115202fe42..c7c81ee81c00 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1020,7 +1020,7 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *=
xs)
                err =3D -EAGAIN;

 out:
-       if (xs->skb)
+       if (xs->skb && err !=3D -EAGAIN)
                xsk_drop_skb(xs->skb);

Thanks,
Jason

>
> > +
> > +     /* If send_queue has more pending skbs, we must to clear
> > +      * the rest of them.
> > +      */
> > +     while ((skb =3D __skb_dequeue(&batch->send_queue)) !=3D NULL) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D11
