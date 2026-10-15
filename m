Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AE4A49A5
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097580; cv=pass; b=epESkPNMW5EFheHL6zvM/f2/alUB2e1qcd2zqi6mALiKA+ZAHV7+65utBH1VL9kiDMVxZHs8uC6y4ISBP+z2Qd8GBsEWmTCgE7shbc5EUY9AxmUOTRIh2CeJZ1rcRfAAugr+g4XlGU22NUX9WoL99a2E3WTRlBhqipAtnOCU1u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097580; c=relaxed/simple;
	bh=hxk1QMVCnerU7l4ILDOHxLnF1/4FmNo059jIytcT46c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Sc4DsBcmGe5qS3RPhSn1Y3eskp8rbWgtXVo17Yjzgh/dySBg1qsCeRxzVaFmT+Pu6CTD302GXH0MM/4Jg9y9W18gdbi029NkjYRScei8stqqWVNu5hWtR7rd8m25g4F7eDlpQ8ZKoy3Ek3ZcWKzTuiFgAcU4aFH8vsdaehTSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=zDwmN2aI; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="zDwmN2aI"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd623dfe420so1964670a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 13:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097577; cv=none;
        d=google.com; s=arc-20260327;
        b=cPbBH3nPgOoiWdHcvUCaW/9T4nmFUo/h+jqjSo3XXyXmqqN+Frkc6aV9tZc/KUlg7N
         W197FBM7oGaDgy4toTM2GetYS68nj3c8ZLOTqn2VBA3OotsuCAiCh7Y64dgU0foaurCl
         2cI3DkwE1oJEbZ/VjI38wR79OdWCD+AtkpbIjfXc6pdh2vD6NyY971c14eY3jU0qztxN
         hIR8cOGmqZxJCnnJhf0cDOGceIcbKg0bOTLfTkwLMEKGn1/PVYtxcZJ9jx/791GrMeYo
         Akkaqb7XHsCt0ucLYWnvb8jPhS2qGFie/QJ9XKk5J78+1UhsEEkyxG08BbCeldANUci5
         X4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        fh=RkccLRY4/bIJ+D4Kts1PYwgbGRPhpTBwCMi1h3aBfrM=;
        b=Jo31IY/LE6/v6sXEio2B5yXy0xMhq5WQb1F4Vbv12PSADa9YyeduXJsHR6sEbO/Rcp
         61hsPuvmvkkb76mK9MtZgINN82CoGts/lKPKJ4Wcf5/XbCIwfnei5i+cdcnLxW4sn3b7
         HbpfPUV/B9TlQUHbKZEyD8bSQHAivNLmLmCxbGBuElaYk6F9rArVhuCuMk+CZebWoQjS
         OQurqafoYOIA9lEVZiIVjBzB2jmShbM4behxZg9k+v8JiftB7D10+kZ1XLpb/CMzG4fz
         blpjXIpYWtGL/aI7ADW35EHgNgXOMIru49tctDL//mpmyzsmRB1d2Yp5IcldpNCS0rhV
         EPRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792097577; x=1792702377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        b=zDwmN2aI33byk49i0k+0Tbs+be4tyoIiwisrHCykGmnNzN5Vlz+L1o+lsOUXwHBgtz
         fMPl8Nt9yew6NbZVwBQocwHDfkcliGfGf8HVxWLx4snSRU5Rf7C5KZa9fXF87dApVkPj
         IwK9Clflold6Bjf8bhg8y1ic6aEDGqcN/Fodw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097577; x=1792702377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        b=pDceD0+4qwb/7wgxJ2QNVJ2MjKK/A1OuYZoiT0nIS5le9ug0js5QInX8o73S+syy5K
         RSOibH2mH/89PO1Hkv171j63zgkOnVd0cObl03VrY9RMuFROhurOA9/cEZvaTxsY3UEo
         VbsYxSDz/2he1S/x5O7Uucl0/hoFTo/YECG8owm0i/b21rJGsOVXKD2vcvgJkgbp2sX1
         YeGoAlmjrKcRtK+W2LTPYZAgsIzPKrRQJX3HNmUfedMU0QoG1T5ZGUNzHLMzAlRZsbj9
         O5T8TEQtgRHoVhqtGbdHsFsoh2VWWqb0YB8jInTf3lOQ9t2DKmj9x+0G6nZtu+z8vn0b
         HYRw==
X-Forwarded-Encrypted: i=1; AKwUvBwa6GE/8JznvqvitlarZN/xNRjSiNvC5/qbI9N6mOeDcWrnvE69pTgv6PHPP+jdYLmuaeQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8QIBTf5Rg7WnUetu4SFHPVO/vKKaVBd6v96I2IIdrGAuAMlHo
	Sm+2UX6211KI8ORbCh+y+E88RtI6Q4Nsa5Vk7irwVEC8oncmvm8W9TRqvuxYiBYRZeErgJr2+nQ
	7POeG2ulXSIqOu7SAjUFtoy1zCGwruvkcDlYt6ozm
X-Gm-Gg: AYBFou2wOgOoR0HsFig0gtk+sukkqSdkVBuVuNZeSwVh8Z6k05vAam9qQ2nIdqR1m8X
	6rCOtvaIXa8qgkXILUc9J3gBMOnG8UFRzfB6IivqdN/TKl22NI9vzdT1QLiR/cVgWmZi3BsG40R
	xYZuBNcPQsK0sP2eJNejcR0VYI1leeHbNEr6M0X33JmQSHJLbrduq1pDUWQsXiUFXqkUNXMhlw+
	wHD6hM3wxgcTem6EPlVXB+sW6z+H6Z0SZq08XDRzQxNgqlX8btXLdYldTTfBJd7F16rs37vdwu7
	+/Ip9Lz2UH+/4y+43cw5T0TvrTe8g/kqpXtXUQNfnHhSJ2OElo0YN2wYjdH2rDZMCuheDU9fprS
	+WOVENrTWU1Y+i3qCkJdyJXaYex8njuVlfHbXhuKUSmqo
X-Received: by 2002:a05:6a20:6f89:b0:3e1:c08e:38f1 with SMTP id
 adf61e73a8af0-3e1c08e7cedmr10140367637.14.1792097576957; Thu, 15 Oct 2026
 13:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-MD1X.v2.20261009135842@mojatatu.com> <20261015125822.GH83879@horms.kernel.org>
In-Reply-To: <20261015125822.GH83879@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Oct 2026 16:52:44 -0400
X-Gm-Features: AclHuK-3WqmxRH2VJ4NQkGPyh93QYe2dksXJg7Bq6GKxJGeNOPh9iFVtk_DYmvc
Message-ID: <CAM0EoMnhmww2koBL+V0fgKg4qp=3E2Bf23iUSyxtoBPYbYi0Wg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Sashiko <sashiko-bot@kernel.org>, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:58=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 09, 2026 at 02:09:03PM -0400, Jamal Hadi Salim wrote:
> > This issue was caught by Sashiko (nipa). A producer-side path cap is
> > already merged (ea4d4b5dddb5); this patch adds the matching consumer-si=
de
> > cap.
> >
> > The issue:
> > The tx queue is picked and capped in netdev_core_pick_tx(), before the
> > __dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside
> > egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
> > that store is never re-checked. bpf_convert_ctx_access() bounds it only
> > by NO_QUEUE_MAPPING, not by the device's queue count.
> >
> > On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
> > indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it wit=
h
> > just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bo=
unds
> > txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
> > allocation on non-lltx devices such as ifb. Drivers that index their ri=
ngs
> > from skb_get_queue_mapping() (ex: ifb) go out of range the same way.
> >
> > The Fix:
> > Cap the mapping at the consumer and write the capped value back, so bot=
h
> > the qdisc's _tx[] lookup and any later driver read stay in range. The c=
ap
> > folds into the dequeue path instead of a separate walk over the returne=
d
> > list: dequeue_skb() caps the head, and each bulk helper caps the elemen=
t it
> > appends. netdev_cap_txqueue() already logs a ratelimited notice and sel=
ects
> > queue 0. The single-packet case pays one extra compare against
> > real_num_tx_queues.
> >
> > A bulk-dequeued list is transmitted under the single tx queue lock of t=
he
> > head skb, so every element must belong to that same queue. The fast bul=
k
> > helper (TCQ_F_ONETXQUEUE, taken on BQL devices by the per-queue childre=
n
> > of mq, mqprio, taprio and htb, and by any qdisc on a single-queue devic=
e
> > such as the prio root in the reproducer) must therefore compare each
> > capped follower against the head and requeue a mismatch, exactly as the
> > slow helper already does; appending a follower that caps to a different
> > queue would send it under the wrong _xmit_lock.
> >
> > Conditions to recreate the bug:
> > Load a SCHED_CLS or SCHED_ACT program that stores __sk_buff->queue_mapp=
ing
> > (a tc BPF action is enough), attach it to a transmit qdisc (for example=
 a
> > matchall filter on a prio root), and send a packet. With a 1-queue devi=
ce a
> > store of 1 indexes one past dev->_tx[]. Under KASAN with panic_on_warn=
=3D1
> > the unfixed kernel faults with "BUG: KASAN: slab-out-of-bounds in
> > sch_direct_xmit". Loading the program needs CAP_BPF/CAP_SYS_ADMIN, so t=
he
> > trigger is root.
> >
> > Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc =
clsact")
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/179033713973.2160803.49145706939=
94398206@kernel.org/
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2=
.20260924072708%40mojatatu.com
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1=
.20261005193231%40mojatatu.com
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2:
> > - try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) cappe=
d
> >   each follower but appended it without comparing it against the head, =
so
> >   a mismatched follower was still sent under the head's txq lock. Compa=
re
> >   the capped follower with the head and requeue a mismatch to skb_bad_t=
xq,
> >   matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
> > ---
> >  net/sched/sch_generic.c | 53 +++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 48 insertions(+), 5 deletions(-)
>
> Hi Jamal,
>
> Weirdly, this patch is mangled and does not apply.
>

Weird indeed. I dont hand edit patches for shipping, so not sure what
happened here.
Brokenness checks out with my local version. I will fix and send v3.

cheers,
jamal
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..b65bec7e2643 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q=
,
>
> This hunk results in 31 lines, not 33.
>
> >
> >  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
> >
> > +/* A tc BPF program on a transmit qdisc can change __sk_buff->queue_ma=
pping
> > + * after the tx queue was picked. Re-cap it against the device and wri=
te it
> > + * back, so a driver that re-reads skb_get_queue_mapping() stays in ra=
nge.
> > + */
> > +static u16 qdisc_cap_skb_tx_queue(struct net_device *dev, struct sk_bu=
ff *skb)
> > +{
> > +     u16 queue =3D skb_get_queue_mapping(skb);
> > +     u16 capped;
> > +
> > +     capped =3D netdev_cap_txqueue(dev, queue);
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return capped;
> > +}
> > +
> > +static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
> > +                                          struct sk_buff *skb)
> > +{
> > +     return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb))=
;
> > +}
> > +
> >  static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
> >  {
> > -     const struct netdev_queue *txq =3D q->dev_queue;
> > +     const struct netdev_queue *txq;
> >       spinlock_t *lock =3D NULL;
> >       struct sk_buff *skb;
> >
>
> ...
>
> > @@ -216,6 +242,17 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>
> And this hunk results in 15 lines, not 17.
>
> >               if (!nskb)
> >                       break;
> >
> > +             /* Re-cap a mapping changed after pick; requeue a
> > +              * follower that no longer matches the head, which owns
> > +              * the _xmit_lock for the whole list.
> > +              */
> > +             if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=3D
> > +                          skb_get_queue_mapping(skb))) {
> > +                     qdisc_enqueue_skb_bad_txq(q, nskb);
> > +                     break;
> > +             }
> >               bytelimit -=3D nskb->len; /* covers GSO len */
> >               skb->next =3D nskb;
> >               skb =3D nskb;
>
> ...
>
> pw-bot: changes-requested
