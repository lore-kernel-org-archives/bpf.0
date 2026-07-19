Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F343F08E
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475098; cv=pass; b=UZu/nf/6WLNdNIkVwd4h9SmEHuPg64f0l3GcsY353G0MMSHj3LQfCl5AUl9eoPM/PCiAfULhG1vdt45nhwIlf1O967gjrgsRm78bfTZhXPPD+sfzprZumON7WQx5Au07lPo4Ljow+Oiz57ncasrdAcgvXiiJOw/xX1F3g/pdb5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475098; c=relaxed/simple;
	bh=43poreOw033hnQ5+uBEMcK4AtuoREkX3CQB7gK1NShU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgF+YrtpxR6aq1qBvoEBRfgl8zY/ydFCKZ02olWw0JI9nkKajT4x+tizWua3C3mr7YFolnG/pAWJawD+nPyTGbthFKkMOcSL30p4AvtLKmxlx4lTV/Ylw/kDaIX72Mqfcgf2PrRQhaDp6ezUXFajIx77fwhcCYaNQELie9bTlTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiC9DWpj; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiC9DWpj"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b28ce91111so3873684e87.3
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784475094; cv=none;
        d=google.com; s=arc-20260327;
        b=hgXrpMvbWMFvL74sINWpvuC8KQPQ8tPQOMSI+QVNyAnxWzmhwB09qvI2HTUhDxjuVQ
         2cVHLx39ioGEAqCF7Py45vHex7T0vbbqdhIDub7Wq74BFhROp9V1+p7lOTfQdxRewaJN
         f/ySQ6JlSf9Gbyq32K5beNaO8K5twg6NcAg5sEK6U+W434lwA8brj5afm2OAtZkWT/g9
         FhtUfeNnslwiiAZQB7sqCCPt5sYyHEJ+jalLZgt7/67xw5qPoq5AqLKFQGrvxGWMckdF
         yHiD4MZdHb+fEQEX5Gy7tDndutfMLXS2LjK3GaswajHouS0+QRdnHbfS92893hXSShXM
         hvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9A1thlKcAWyHS9QLWa3MXa1tgojmosi4XgEnrnGE0EU=;
        fh=s3jvsZaLPvD+MK1QKwTj+fSM7UzOwrmTIxEVjxuUhfw=;
        b=TNgEDftHqIAlS6qxEe1De7ISChzXvL1bMhJ7GoHomUBiLU5rTBUlZn56BASLXf6ZM1
         lsSg4CW7E6cNsowI2E68EEq6LHoEV7J9M528LyxRjnLazHkEefSi7GrolZb11qwkrITe
         YKklnidm33Scy0AD5xY04ZPE+3A1CpjmTHGr5ucru5fHojizUWHBo1WsJ5bkF8ygw+qP
         FvKhP0lSr0kGcogQ7VwHv7D/SCM/agR2xvh4j9Lf/GK6KJC2GzXiomnbni1TMNFl1/xW
         q1UyFoIv32CfJgoCAXsVS5UMgRB6f66nYTamJh5bvjghZC5VFMrtlAsXiwtsRpKnrPI0
         MEKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475094; x=1785079894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9A1thlKcAWyHS9QLWa3MXa1tgojmosi4XgEnrnGE0EU=;
        b=PiC9DWpjcegCQ5tPoA8SI/A8Dk2FIB7iJ1KeD5qUIZ2wMBLaFERDeq8whsP6kMUMDt
         APrL6TSKz9JYfOY4gCGaDJys72ivErwKXL23KbJkT5MmyEX9CvhJyhDb7Kk0gOooRAgw
         Zq3VFCaIM7LSy9kT9mPNq5/eF+aq8WjzuH90Jjls4CxNPcYwELagHQdrBee/Xw4Q0S6P
         18WQztwygifofz4BLdfJrnYXGHnxKby0CrZgFzTWUS+U8RpOD60roYw0cPpp7AbuWp54
         /TnHo4Th6tYX9FD1Q6KLJlKXquRmas7ntvkL1ZEE8VllLk2FM2lNrGBMenLx4I/xjebE
         1WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475094; x=1785079894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9A1thlKcAWyHS9QLWa3MXa1tgojmosi4XgEnrnGE0EU=;
        b=B3rJ3mDJf2qoy5dGzldZp2fbYZFHawENcdGUHmH+PVGlyXzQiqJwLVXHkTrKXPqasq
         sPw/IIJHe2Vqc+9TLBU0O2jOaQithCX/G9NS5fHFvg06o/gr9xc4AKtB8j97c553VeFe
         G5MYqhkNBhb7gx4jUk3/XHrM+V0SW585uTeCV+khF7MdbNQLZHODfgwwNYpuUfPJo0jw
         gsGEHZtOHTALX9u1uT7PfQcbO9AL+HL1On4AoqDNDxF0UOfyCm6xc4d3eCyVPmcL7i38
         9pqWGU+0TezXwQ4X7DEN7UNfpNu/Bix+Pu7fUifN0xjdFoxGDCfi958NEtgZ8e6ecXOz
         FN6g==
X-Forwarded-Encrypted: i=1; AHgh+Rp/KFLUutgz11X0CptABzmRcoRCNRQB0mPvNFdFSmyklP+jaxh/67NqTl2F60TKgq3oW4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44OqOjv7hAvgpG5Bx4bpkUiJW/jLDEfz1r87B3hSWPOPQLRW0
	lizi0hJKpJcd57gP8dRRJjG8WU65+SqZrOTWU0W9zpa4yTT97f9M0cyhl9Ku9flsE5MmVWoeOs5
	Rfued2u2K0xyOJ+ku9mhVKtjXnibH5nQ=
X-Gm-Gg: AfdE7cnxTQoLxGTiAm4Bxc74Wp4KJNIK/gjXubEgx3YpsYpSKzA5OHLVlrvPJk/i7aC
	zMwueSjeA4eAC4csVuy7GP13Lc+5nvSy1qgHr5VZdR7iA5uTNF+uADdgKCO3pNcJJKF7GvwUe5P
	ds5nlF3VXIVLBnfR1vPQYx5DG4VEdDaHaje61AYr7i2mlRrgETUuBYykwX1Zv/CFEibImDg7mrE
	yOg7OM30oIa674LbD+KEpSxMYs0yXsC7lx7eyvRRFigYOY2jonWtFErK14hfdFCN55X8uguXJHf
	lkdfD8I2gMXcDw44DJHWE/hOqT/h85fZaW3/6iCUH0Y2F5evlvW6PHLcz3lctPk/Ougrh2frxPw
	=
X-Received: by 2002:a05:6512:608:10b0:5ae:b861:ac20 with SMTP id
 2adb3069b0e04-5b28f87250bmr1574389e87.14.1784475093636; Sun, 19 Jul 2026
 08:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-5-maciej.fijalkowski@intel.com> <CAL+tcoDyygM5XiVhHrmYrZTnZN6QSD0dN9mMPZmZYPtikssYxw@mail.gmail.com>
 <alzPbtHWgy97oeBv@boxer>
In-Reply-To: <alzPbtHWgy97oeBv@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Jul 2026 17:30:55 +0200
X-Gm-Features: AUfX_myCq7o1hmsWxXTlKVtRoSi_4rs4sOR1DszhOwrxH5Qp5l_F5viNSTsjL3o
Message-ID: <CAL+tcoDGOqoFbApK95FNh7rEGuNKdi68+qrjeXpNfPOP3DwojA@mail.gmail.com>
Subject: Re: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx descs in
 ZC path
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 9:22=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 11:58:24PM +0200, Jason Xing wrote:
> > On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > The zero-copy Tx batch parser stops when it encounters an invalid
> > > descriptor. If this happens after one or more continuation descriptor=
s,
> > > the Tx consumer can be advanced past fragments that are neither submi=
tted
> > > to the driver nor returned to userspace through the completion ring.
> > >
> > > A similar problem occurs when a packet exceeds xdp_zc_max_segs. The
> > > descriptors consumed up to the limit are released without completion,=
 and
> > > the remaining continuation descriptors can subsequently be interprete=
d
> > > as the beginning of another packet.
> > >
> > > Parse Tx batches in packet units and distinguish descriptors belongin=
g to
> > > complete valid packets from descriptors consumed while draining an
> > > invalid or oversized packet. Return the former to the driver and appe=
nd
> > > the latter to the CQ address area so userspace can reclaim their UMEM
> > > frames.
> > >
> > > Once draining starts, continue until the packet's end-of-packet
> > > descriptor is consumed. Preserve the drain state on the socket when E=
OP
> > > has not yet been supplied, so draining can continue during a later ca=
ll.
> > > Leave incomplete but otherwise valid packets on the Tx ring. Keep the
> > > existing handling of standalone invalid descriptors unchanged.
> > >
> > > Shared-UMEM pools using multi-buffer Tx also need packet-framed parsi=
ng.
> > > Walk their Tx sockets one packet at a time, preserving the existing
> > > per-socket fairness scheme, instead of using the legacy one-descripto=
r
> > > fallback. Keep that fallback for shared pools that do not use
> > > multi-buffer Tx. Since the drain state is maintained per socket and b=
oth
> > > the singular and shared paths can resume an interrupted drain, changi=
ng
> > > the socket list from singular to shared requires no special bind-time
> > > transition.
> > >
> > > CQ entries are positional, and drivers may complete only part of the =
Tx
> > > work returned by xsk_tx_peek_release_desc_batch(). Therefore, reclaim=
-only
> > > entries cannot be published immediately when earlier driver-visible
> > > descriptors are still outstanding.
> > >
> > > Track the number of driver-visible CQ entries preceding the reclaim
> > > entries. Let xsk_tx_completed() publish partial real Tx completions, =
and
> > > publish the reclaim entries only after every earlier Tx descriptor ha=
s
> > > completed. Complete a reclaim-only batch immediately when there is no
> > > driver-visible work in front of it, and prevent another Tx batch from
> > > being appended while reclaim entries remain pending.
> > >
> > > Also cap batch processing by the size of the pool's temporary descrip=
tor
> > > array, as Tx rings belonging to sockets sharing a UMEM may have diffe=
rent
> > > sizes.
> > >
> > > This ensures that every descriptor consumed as part of an invalid
> > > multi-buffer packet is eventually returned to userspace without expos=
ing
> > > the dropped packet to the driver or violating CQ completion ordering.
> > >
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx =
path")
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >
> > Thanks for working on this big patch! It's not easy to fix it in a
> > simpler way, I think. And I didn't observe any obvious performance
> > impact by xdpsock.
> >
> > Overall, it looks good to me except for a few minor points:
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > > ---
> > >  include/net/xsk_buff_pool.h |   3 +
> > >  net/xdp/xsk.c               | 192 ++++++++++++++++++++++++++++++++--=
--
> > >  net/xdp/xsk_buff_pool.c     |   1 +
> > >  net/xdp/xsk_queue.h         |  76 ++++++++++----
> > >  4 files changed, 232 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.=
h
> > > index f5e737a83055..2bb1d122b1bc 100644
> > > --- a/include/net/xsk_buff_pool.h
> > > +++ b/include/net/xsk_buff_pool.h
> > > @@ -78,6 +78,9 @@ struct xsk_buff_pool {
> > >         u32 chunk_size;
> > >         u32 chunk_shift;
> > >         u32 frame_len;
> > > +       u32 tx_descs_nentries;
> > > +       u32 reclaim_descs;
> > > +       u32 tx_zc_pending_descs;
> > >         u32 xdp_zc_max_segs;
> > >         u8 tx_metadata_len; /* inherited from umem */
> > >         u8 cached_need_wakeup;
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 385a3f4a1b32..2909a0ec6837 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -499,6 +499,23 @@ void __xsk_map_flush(struct list_head *flush_lis=
t)
> > >
> > >  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
> > >  {
> > > +       u32 reclaim_descs =3D READ_ONCE(pool->reclaim_descs);
> > > +
> > > +       if (unlikely(reclaim_descs)) {
> >
> > Just a side note: it might impact the performance because new descs
> > need to wait for the existing descs to be completed if there are
> > reclaim descs.
>
> That is a tradeoff for dealing with this corner case i'd say.
>
> >
> > > +               u32 pending_descs =3D READ_ONCE(pool->tx_zc_pending_d=
escs);
> > > +
> > > +               if (nb_entries < pending_descs) {
> > > +                       WRITE_ONCE(pool->tx_zc_pending_descs,
> > > +                                  pending_descs - nb_entries);
> > > +                       xskq_prod_submit_n(pool->cq, nb_entries);
> > > +                       return;
> > > +               }
> > > +
> > > +               WRITE_ONCE(pool->tx_zc_pending_descs, 0);
> > > +               nb_entries +=3D reclaim_descs;
> > > +               WRITE_ONCE(pool->reclaim_descs, 0);
> > > +       }
> > > +
> > >         xskq_prod_submit_n(pool->cq, nb_entries);
> > >  }
> > >  EXPORT_SYMBOL(xsk_tx_completed);
> > > @@ -574,24 +591,162 @@ static u32 xsk_tx_peek_release_fallback(struct=
 xsk_buff_pool *pool, u32 max_entr
> > >         return nb_pkts;
> > >  }
> > >
> > > +static void xsk_tx_commit_batch(struct xsk_buff_pool *pool,
> > > +                               struct xsk_tx_batch *batch)
> > > +{
> > > +       u32 nb_descs =3D xsk_tx_batch_cq_descs(batch);
> > > +       u32 cq_cached_prod;
> > > +
> > > +       if (!nb_descs)
> > > +               return;
> > > +
> > > +       cq_cached_prod =3D pool->cq->cached_prod;
> > > +       xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs=
);
> > > +
> > > +       if (unlikely(batch->reclaim_descs)) {
> > > +               u32 cq_pending_descs;
> > > +
> > > +               /* CQ is positional. Descriptors already written but =
not
> > > +                * submitted must complete before any reclaim-only de=
scriptors
> > > +                * appended below.
> > > +                */
> > > +               cq_pending_descs =3D cq_cached_prod - xskq_get_prod(p=
ool->cq);
> > > +
> > > +               WRITE_ONCE(pool->tx_zc_pending_descs,
> > > +                          batch->tx_descs + cq_pending_descs);
> > > +               WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs)=
;
> > > +               if (unlikely(!pool->tx_zc_pending_descs))
> > > +                       xsk_tx_completed(pool, 0);
> > > +       }
> > > +}
> > > +
> > > +static struct xsk_tx_batch
> > > +__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct =
xdp_sock *xs,
> > > +                                struct xdp_desc *descs, u32 max_desc=
s)
> > > +{
> > > +       struct xsk_tx_batch batch =3D {};
> > > +       u32 entries;
> > > +
> > > +       entries =3D xskq_cons_nb_entries(xs->tx, max_descs);
> > > +       if (!entries)
> > > +               return batch;
> > > +
> > > +       batch =3D xskq_cons_read_desc_batch(xs, pool, descs, max_desc=
s);
> > > +       if (!xsk_tx_batch_cq_descs(&batch)) {
> > > +               xs->tx->queue_empty_descs++;
> > > +               if (batch.consumed_descs) {
> > > +                       __xskq_cons_release(xs->tx);
> > > +                       xs->sk.sk_write_space(&xs->sk);
> > > +               }
> > > +               return batch;
> > > +       }
> > > +
> > > +       __xskq_cons_release(xs->tx);
> > > +       xs->sk.sk_write_space(&xs->sk);
> > > +       return batch;
> > > +}
> > > +
> > > +static struct xsk_tx_batch
> > > +xsk_tx_peek_release_shared_desc_batch(struct xsk_buff_pool *pool, u3=
2 max_descs)
> > > +{
> > > +       u32 cq_descs_before, cq_descs_after;
> > > +       struct xsk_tx_batch sum_batch =3D {};
> > > +       bool budget_exhausted;
> > > +       u32 per_socket_budget;
> > > +       struct xdp_sock *xs;
> > > +
> > > +       /* The fairness quota must allow one maximum-sized valid pack=
et. */
> > > +       per_socket_budget =3D max_t(u32, MAX_PER_SOCKET_BUDGET,
> > > +                                 pool->xdp_zc_max_segs);
> > > +
> > > +again:
> > > +       budget_exhausted =3D false;
> > > +       cq_descs_before =3D xsk_tx_batch_cq_descs(&sum_batch);
> > > +       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > +               u32 budget, budget_left, offset, remaining;
> > > +               struct xsk_tx_batch curr_batch;
> > > +
> > > +               /* Once reclaim-only descriptors have been appended t=
o the CQ
> > > +                * address area, do not append driver-visible Tx desc=
riptors
> > > +                * from another socket after them. xsk_tx_completed()=
 relies on
> > > +                * all driver-visible descriptors preceding all recla=
im-only
> > > +                * descriptors in CQ order.
> > > +                */
> > > +               if (sum_batch.reclaim_descs)
> > > +                       break;
> > > +
> > > +               /* be gentle when playing with pool->tx_descs */
> >
> > Minor nit: seems unneeded comment?
>
> this has been my helper/reminder that we need to respect already consumed
> space at tx_descs array; i can remove it
>
> >
> > > +               offset =3D xsk_tx_batch_cq_descs(&sum_batch);
> > > +               if (offset >=3D max_descs)
> > > +                       break;
> > > +
> > > +               if (xs->tx_budget_spent >=3D per_socket_budget) {
> > > +                       if (xskq_cons_nb_entries(xs->tx, 1))
> > > +                               budget_exhausted =3D true;
> > > +                       continue;
> > > +               }
> > > +
> > > +               budget_left =3D per_socket_budget - xs->tx_budget_spe=
nt;
> > > +               remaining =3D max_descs - offset;
> > > +               budget =3D min(remaining, budget_left);
> > > +
> > > +               curr_batch =3D __xsk_tx_peek_release_desc_batch(pool,=
 xs,
> > > +                                                             pool->t=
x_descs + offset,
> > > +                                                             budget)=
;
> > > +               if (!xsk_tx_batch_cq_descs(&curr_batch)) {
> > > +                       if (curr_batch.budget_limited && budget_left =
< remaining)
> > > +                               budget_exhausted =3D true;
> > > +                       xs->tx_budget_spent +=3D curr_batch.consumed_=
descs;
> > > +                       continue;
> > > +               }
> > > +
> > > +               xs->tx_budget_spent +=3D curr_batch.consumed_descs;
> > > +               sum_batch.tx_descs +=3D curr_batch.tx_descs;
> >
> > No need to use '+' here because of the previous reclaim_descs check.
>
> hmm correct!
>
> >
> > > +               sum_batch.reclaim_descs +=3D curr_batch.reclaim_descs=
;
> > > +       }
> > > +
> > > +       cq_descs_after =3D xsk_tx_batch_cq_descs(&sum_batch);
> > > +
> > > +       if (sum_batch.reclaim_descs || cq_descs_after >=3D max_descs)
> > > +               return sum_batch;
> > > +
> > > +       /* Continue filling the batch while this pass made progress *=
/
> > > +       if (cq_descs_before !=3D cq_descs_after)
> > > +               goto again;
> > > +
> > > +       if (!budget_exhausted)
> > > +               return sum_batch;
> > > +
> > > +       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
> > > +               xs->tx_budget_spent =3D 0;
> > > +       goto again;
> > > +}
> > > +
> > >  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 n=
b_pkts)
> > >  {
> > > +       struct xsk_tx_batch batch =3D {};
> > >         struct xdp_sock *xs;
> > > +       bool umem_shared;
> > >
> > >         rcu_read_lock();
> > > -       if (!list_is_singular(&pool->xsk_tx_list)) {
> > > -               /* Fallback to the non-batched version */
> > > -               rcu_read_unlock();
> > > -               return xsk_tx_peek_release_fallback(pool, nb_pkts);
> > > -       }
> > > +       if (unlikely(READ_ONCE(pool->reclaim_descs)))
> > > +               goto out;
> > >
> > > -       xs =3D list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_=
sock, tx_list);
> > > -       if (!xs) {
> > > -               nb_pkts =3D 0;
> > > +       xs =3D list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_=
sock,
> > > +                                   tx_list);
> > > +       if (!xs)
> > >                 goto out;
> > > -       }
> > >
> > > -       nb_pkts =3D xskq_cons_nb_entries(xs->tx, nb_pkts);
> > > +       nb_pkts =3D min(nb_pkts, pool->tx_descs_nentries);
> > > +       if (!nb_pkts)
> > > +               goto out;
> > > +
> > > +       umem_shared =3D !list_is_singular(&pool->xsk_tx_list);
> > > +
> > > +       if (umem_shared && !(pool->umem->flags & XDP_UMEM_SG_FLAG)) {
> > > +               rcu_read_unlock();
> > > +               return xsk_tx_peek_release_fallback(pool, nb_pkts);
> > > +       }
> > >
> > >         /* This is the backpressure mechanism for the Tx path. Try to
> > >          * reserve space in the completion queue for all packets, but
> > > @@ -603,19 +758,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_b=
uff_pool *pool, u32 nb_pkts)
> > >         if (!nb_pkts)
> > >                 goto out;
> > >
> > > -       nb_pkts =3D xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> > > -       if (!nb_pkts) {
> > > -               xs->tx->queue_empty_descs++;
> > > -               goto out;
> > > -       }
> > > -
> > > -       __xskq_cons_release(xs->tx);
> > > -       xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts)=
;
> > > -       xs->sk.sk_write_space(&xs->sk);
> > > +       batch =3D umem_shared ?
> > > +               xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) =
:
> > > +               __xsk_tx_peek_release_desc_batch(pool, xs,
> > > +                                                pool->tx_descs,
> > > +                                                nb_pkts);
> > > +       xsk_tx_commit_batch(pool, &batch);
> > >
> > >  out:
> > >         rcu_read_unlock();
> > > -       return nb_pkts;
> > > +       return batch.tx_descs;
> > >  }
> > >  EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
> > >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 12c9fb29af05..a4089480b22b 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -51,6 +51,7 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, s=
truct xdp_sock *xs,
> > >         if (!pool->tx_descs)
> > >                 return -ENOMEM;
> > >
> > > +       pool->tx_descs_nentries =3D nentries;
> > >         return 0;
> > >  }
> > >
> > > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > > index 3e3fbb73d23e..a15ff1929db6 100644
> > > --- a/net/xdp/xsk_queue.h
> > > +++ b/net/xdp/xsk_queue.h
> > > @@ -58,6 +58,18 @@ struct parsed_desc {
> > >         u32 valid;
> > >  };
> > >
> > > +struct xsk_tx_batch {
> > > +       u32 tx_descs;
> > > +       u32 reclaim_descs;
> > > +       u32 consumed_descs;
> > > +       bool budget_limited;
> > > +};
> > > +
> > > +static inline u32 xsk_tx_batch_cq_descs(const struct xsk_tx_batch *b=
atch)
> > > +{
> > > +       return batch->tx_descs + batch->reclaim_descs;
> > > +}
> > > +
> > >  /* The structure of the shared state of the rings are a simple
> > >   * circular buffer, as outlined in
> > >   * Documentation/core-api/circular-buffers.rst. For the Rx and
> > > @@ -263,17 +275,18 @@ static inline void parse_desc(struct xsk_queue =
*q, struct xsk_buff_pool *pool,
> > >         parsed->mb =3D xp_mb_desc(desc);
> > >  }
> > >
> > > -static inline
> > > -u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_p=
ool *pool,
> > > -                             u32 max)
> > > +static inline struct xsk_tx_batch
> > > +xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool =
*pool,
> > > +                         struct xdp_desc *descs, u32 max)
> > >  {
> > > -       u32 cached_cons =3D q->cached_cons, nb_entries =3D 0;
> > > -       struct xdp_desc *descs =3D pool->tx_descs;
> > > -       u32 total_descs =3D 0, nr_frags =3D 0;
> > > +       bool drain =3D READ_ONCE(xs->drain_cont);
> > > +       u32 cached_cons, nb_entries =3D 0, released;
> > > +       struct xsk_tx_batch batch =3D {};
> > > +       struct xsk_queue *q =3D xs->tx;
> > > +       u32 nr_frags =3D 0;
> > > +
> > > +       cached_cons =3D q->cached_cons;
> > >
> > > -       /* track first entry, if stumble upon *any* invalid descripto=
r, rewind
> > > -        * current packet that consists of frags and stop the process=
ing
> > > -        */
> > >         while (cached_cons !=3D q->cached_prod && nb_entries < max) {
> > >                 struct xdp_rxtx_ring *ring =3D (struct xdp_rxtx_ring =
*)q->ring;
> > >                 u32 idx =3D cached_cons & q->ring_mask;
> > > @@ -282,26 +295,49 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue =
*q, struct xsk_buff_pool *pool,
> > >                 descs[nb_entries] =3D ring->desc[idx];
> > >                 cached_cons++;
> > >                 parse_desc(q, pool, &descs[nb_entries], &parsed);
> > > -               if (unlikely(!parsed.valid))
> > > -                       break;
> > > +               if (unlikely(!parsed.valid)) {
> > > +                       if (!drain && !nr_frags && !parsed.mb)
> >
> > I understand you're fixing the mb problem here. But I'm wondering if
> > it still has a problem in the non mb case because the single invalid
> > packet (mb =3D=3D0, nr_frags =3D=3D 0, drain =3D=3D 0) that isn't publi=
shed in CQ
> > cannot be tracked by application?
> >
> > My thinking is to just remove the above line in this patch. Or I can
> > cook a follow-up patch to fix this specific problem?
>
> Good catch - seems I got too focused at mb case and now we have a bit of
> misbehave as invalid mb descs are cq produced and standalone not.
>
> I'm gonna address this and align standalone descs (in generic xmit as
> well) that are invalid so they are also cq published, not silently wiped
> out from tx ring only.
>
> Thanks! sending v4.

Great! Thanks!
