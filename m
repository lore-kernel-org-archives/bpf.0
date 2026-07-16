Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E63C3F77
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239146; cv=pass; b=prl0b0cCR9XriNER4FLa+UpL7oJPW90Z5pzENCZsqRiUTsgLiu9UzR38myelsztMrf2o0FszY4RvkMasOE9TathRj8ZsJYdPcDkU0nELrJ0i5l2F8DI/3vHYW/Af8IKUYPi2m7/FMVitNMVaaNEJ/YPxcWR4oXuu+OPA+sCEmBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239146; c=relaxed/simple;
	bh=gW6WpYWzjcPfsc0bSwHS3G797oW9PCY91xfm4tsJvvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvXJSL47cVGu5js41dRSfi4c5yA+DVKL16EX8DjlLwP90iCecmNcJtsEwKPUYRZ8N+SYjLBsnJipHkNWZ99wQOBbEjy/OWeU/UEyOUv1W+lXVwpZ7mUvRflk+8uM6tMvMM91udEZ72/B3lSFL1vPO45bCir/y1iF/EbIyDdywr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE/KzwOR; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE/KzwOR"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b018fe8318so3249174e87.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784239142; cv=none;
        d=google.com; s=arc-20260327;
        b=VtVvmqRQynS2qHbd3QyLT2zfcF78ta+tTApNocSqVckmiLk7eXtRQAnbnER06beaxS
         k9BundFNXOoMseJXpT/aBdopimH3mlDrkZ02DZd5HIX4Vy2TEiY+7HorbgQzwHnFBk+8
         XsxRwS8c2QLLhg+NdPeYak3VoTONd41KovWYlz3lXf3XrSYDWovvT6ZwmFFfCkYXKHEO
         t1zZeTx0B3eDIUgxjAT9Mu7mxDumqw8kGjQIS4DHNrKOW/f36nkXrkAs0M8a7kVOYGbY
         jq4SIziSs6YDlkiCPE1vAS38ru7V8Ft2o8Gos9RjVXtFhfSr7Ikwcc0eNU/06c56A3Rn
         DkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1SeijiA2WxkII3iZ6SO8cJEWIZ9g36I5ZaIAJ1sALII=;
        fh=JsdFL4cMBUTAXa+aFwRgdvKFb1K9lAMSqven4iTyxBY=;
        b=ngc2Un7eScrYhiDWvvTQM/fSt64ngQ8FZf9vz0nYLPVlTlw3FvB5ZS8+paTohkIeA4
         9IKE5mHRv6r71iFOPgJlH/V671MMZN8My/gurdOuJr/JxQYJPdDNs6VhOmjSFpfaaQjB
         I8ngDScsPnRkBDoiRCWhXa52c/AcHwt5ksW7gWUiPB/X4N1rAqsQSukFTWYWQe5he/6k
         TaJKKgQlqOG0I7WipCRGkGw0EkiZsAdutpsrcSZc/C+mXelW55+fCDL1CEO1fszpU+JH
         3r9JPZ883ntusvQ8qyV36ePBqZZCrfMEv38bwnep3n4Aegr2EqCaMwSmHD70fYxawfue
         k+Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784239142; x=1784843942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1SeijiA2WxkII3iZ6SO8cJEWIZ9g36I5ZaIAJ1sALII=;
        b=IE/KzwORJDNQEzaypTnveWxAk3dMAUNomC5O5DW9I8jfiN6y9+uy9VoCKAl+1Kk1qI
         PnaO46Td4JUQTG9cEMp6YFxFwSW2UGfEM2G2CEeZ6II8guY4UqzXUHRLgrjoVf7UFJQG
         LP4XpzkvMj6di7vhrdjlLwYudi0KlGbI2cBD//PYlS7Sho1D8Z2mksPDZIXbEPyCjAfv
         CNXW2gm8xtajnFTgXdv3CNBB8nPy8AVS9d2M6dzjm5BhGpsQcxZMznEaXGE7j9HRnUYP
         BiYv/s3bmfE+nvqzCLGHWy9mn9yy6qh1JFnSfWqE1kmAeCj0GQmMxRBUCF2ixgbbo6mb
         wxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784239142; x=1784843942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1SeijiA2WxkII3iZ6SO8cJEWIZ9g36I5ZaIAJ1sALII=;
        b=W+BLEA0IkvxasrF+yphrPlu4THJ7NdPZKoRFTkYNpawgeNDl4mw4S46IDjlrmfsqaA
         vbxL66UWePHR4rZkglVhiOcE5Op+V9yjW9ocjbGOuzwhOlPdBkGwWPC6SvADbFxN1yJu
         OsCGwXm45r2mSReKwRPqKuefPF6CSpm9SvHVZnyrkHJDouq1agXPaBz3LtNXC4WL9Opi
         qeUGv845XJvcS2+3ZVjBTUfJBYk34cmUk+PeWYW4aLsIk/iaI3APH/ObxVY/wUpkDlPz
         HiWxyVU35IGDF0zgXa372DCaPEiQcsyNBk07QoNOhhGj/MfUSfpRww76SmOyi9QT2H7g
         ta3g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6XzAKi2P9NYJAvKIJoNXA/aA8xTJs8O0RLbCQGqBxPVHgvAKbeqwvhHcRe89m1e5XUUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYv9Uvvqsl6VlTUxnPlaqI6eJ8dADtRPqd7aBTVkDcLPJcVQsi
	3C3ehxYFqy7jf+EdyvEmy/8oxd6Qo2YzeengJKQj8d3kOZfjbM67NQNlHSR/7q6BCqpycSGDOkR
	7wCcF/JyLkJnKy9xg0GyjjH/i/lrQi2w=
X-Gm-Gg: AfdE7ckYC4ZhOTbN1pHMClSfLWrY5kQBbbb8QLKKpQn6zAbk6Owxp4Wd3Xj+wuRgl1V
	fmZtuQOxVgV7k76Aa4LN+ZrYH+kXcgE0At4iuTzSU1VhVjvAhPQ9D+cFJSW+C+8mOXzXfnhRy1J
	ioZCmjWwv+DsloGbPwvwiUiCkW1ikqVte/6Lj/YB3GHWmKAAo3/fVE6VNg2gestZKv2KFqiCWXA
	RlwlfqfUezTrWqaL8jOrCU8q4/g1J2yvf+fGMYl6fVrFN2x+vnKrKUAFBzcWGZRoRei+CBjCNMf
	uH2Jg1i5LhqPOVgAUv9MHhLmdSGMPqiZ8xDdWFuqJ82u2ksUQ9wqOVfz5EpUZ+lp1pyDfA/iBq7
	I
X-Received: by 2002:a05:6512:8393:b0:5ae:a9ed:162e with SMTP id
 2adb3069b0e04-5b28dd9baddmr88477e87.65.1784239141928; Thu, 16 Jul 2026
 14:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-5-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 23:58:24 +0200
X-Gm-Features: AUfX_mxO9kFG9HNrt8MeDwHgh7BGBFAU8QENnOwKKWJgypMFdtIt2hSIc5Ja6a4
Message-ID: <CAL+tcoDyygM5XiVhHrmYrZTnZN6QSD0dN9mMPZmZYPtikssYxw@mail.gmail.com>
Subject: Re: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx descs in
 ZC path
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The zero-copy Tx batch parser stops when it encounters an invalid
> descriptor. If this happens after one or more continuation descriptors,
> the Tx consumer can be advanced past fragments that are neither submitted
> to the driver nor returned to userspace through the completion ring.
>
> A similar problem occurs when a packet exceeds xdp_zc_max_segs. The
> descriptors consumed up to the limit are released without completion, and
> the remaining continuation descriptors can subsequently be interpreted
> as the beginning of another packet.
>
> Parse Tx batches in packet units and distinguish descriptors belonging to
> complete valid packets from descriptors consumed while draining an
> invalid or oversized packet. Return the former to the driver and append
> the latter to the CQ address area so userspace can reclaim their UMEM
> frames.
>
> Once draining starts, continue until the packet's end-of-packet
> descriptor is consumed. Preserve the drain state on the socket when EOP
> has not yet been supplied, so draining can continue during a later call.
> Leave incomplete but otherwise valid packets on the Tx ring. Keep the
> existing handling of standalone invalid descriptors unchanged.
>
> Shared-UMEM pools using multi-buffer Tx also need packet-framed parsing.
> Walk their Tx sockets one packet at a time, preserving the existing
> per-socket fairness scheme, instead of using the legacy one-descriptor
> fallback. Keep that fallback for shared pools that do not use
> multi-buffer Tx. Since the drain state is maintained per socket and both
> the singular and shared paths can resume an interrupted drain, changing
> the socket list from singular to shared requires no special bind-time
> transition.
>
> CQ entries are positional, and drivers may complete only part of the Tx
> work returned by xsk_tx_peek_release_desc_batch(). Therefore, reclaim-onl=
y
> entries cannot be published immediately when earlier driver-visible
> descriptors are still outstanding.
>
> Track the number of driver-visible CQ entries preceding the reclaim
> entries. Let xsk_tx_completed() publish partial real Tx completions, and
> publish the reclaim entries only after every earlier Tx descriptor has
> completed. Complete a reclaim-only batch immediately when there is no
> driver-visible work in front of it, and prevent another Tx batch from
> being appended while reclaim entries remain pending.
>
> Also cap batch processing by the size of the pool's temporary descriptor
> array, as Tx rings belonging to sockets sharing a UMEM may have different
> sizes.
>
> This ensures that every descriptor consumed as part of an invalid
> multi-buffer packet is eventually returned to userspace without exposing
> the dropped packet to the driver or violating CQ completion ordering.
>
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path=
")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks for working on this big patch! It's not easy to fix it in a
simpler way, I think. And I didn't observe any obvious performance
impact by xdpsock.

Overall, it looks good to me except for a few minor points:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  include/net/xsk_buff_pool.h |   3 +
>  net/xdp/xsk.c               | 192 ++++++++++++++++++++++++++++++++----
>  net/xdp/xsk_buff_pool.c     |   1 +
>  net/xdp/xsk_queue.h         |  76 ++++++++++----
>  4 files changed, 232 insertions(+), 40 deletions(-)
>
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index f5e737a83055..2bb1d122b1bc 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -78,6 +78,9 @@ struct xsk_buff_pool {
>         u32 chunk_size;
>         u32 chunk_shift;
>         u32 frame_len;
> +       u32 tx_descs_nentries;
> +       u32 reclaim_descs;
> +       u32 tx_zc_pending_descs;
>         u32 xdp_zc_max_segs;
>         u8 tx_metadata_len; /* inherited from umem */
>         u8 cached_need_wakeup;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 385a3f4a1b32..2909a0ec6837 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -499,6 +499,23 @@ void __xsk_map_flush(struct list_head *flush_list)
>
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
>  {
> +       u32 reclaim_descs =3D READ_ONCE(pool->reclaim_descs);
> +
> +       if (unlikely(reclaim_descs)) {

Just a side note: it might impact the performance because new descs
need to wait for the existing descs to be completed if there are
reclaim descs.

> +               u32 pending_descs =3D READ_ONCE(pool->tx_zc_pending_descs=
);
> +
> +               if (nb_entries < pending_descs) {
> +                       WRITE_ONCE(pool->tx_zc_pending_descs,
> +                                  pending_descs - nb_entries);
> +                       xskq_prod_submit_n(pool->cq, nb_entries);
> +                       return;
> +               }
> +
> +               WRITE_ONCE(pool->tx_zc_pending_descs, 0);
> +               nb_entries +=3D reclaim_descs;
> +               WRITE_ONCE(pool->reclaim_descs, 0);
> +       }
> +
>         xskq_prod_submit_n(pool->cq, nb_entries);
>  }
>  EXPORT_SYMBOL(xsk_tx_completed);
> @@ -574,24 +591,162 @@ static u32 xsk_tx_peek_release_fallback(struct xsk=
_buff_pool *pool, u32 max_entr
>         return nb_pkts;
>  }
>
> +static void xsk_tx_commit_batch(struct xsk_buff_pool *pool,
> +                               struct xsk_tx_batch *batch)
> +{
> +       u32 nb_descs =3D xsk_tx_batch_cq_descs(batch);
> +       u32 cq_cached_prod;
> +
> +       if (!nb_descs)
> +               return;
> +
> +       cq_cached_prod =3D pool->cq->cached_prod;
> +       xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
> +
> +       if (unlikely(batch->reclaim_descs)) {
> +               u32 cq_pending_descs;
> +
> +               /* CQ is positional. Descriptors already written but not
> +                * submitted must complete before any reclaim-only descri=
ptors
> +                * appended below.
> +                */
> +               cq_pending_descs =3D cq_cached_prod - xskq_get_prod(pool-=
>cq);
> +
> +               WRITE_ONCE(pool->tx_zc_pending_descs,
> +                          batch->tx_descs + cq_pending_descs);
> +               WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);
> +               if (unlikely(!pool->tx_zc_pending_descs))
> +                       xsk_tx_completed(pool, 0);
> +       }
> +}
> +
> +static struct xsk_tx_batch
> +__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_=
sock *xs,
> +                                struct xdp_desc *descs, u32 max_descs)
> +{
> +       struct xsk_tx_batch batch =3D {};
> +       u32 entries;
> +
> +       entries =3D xskq_cons_nb_entries(xs->tx, max_descs);
> +       if (!entries)
> +               return batch;
> +
> +       batch =3D xskq_cons_read_desc_batch(xs, pool, descs, max_descs);
> +       if (!xsk_tx_batch_cq_descs(&batch)) {
> +               xs->tx->queue_empty_descs++;
> +               if (batch.consumed_descs) {
> +                       __xskq_cons_release(xs->tx);
> +                       xs->sk.sk_write_space(&xs->sk);
> +               }
> +               return batch;
> +       }
> +
> +       __xskq_cons_release(xs->tx);
> +       xs->sk.sk_write_space(&xs->sk);
> +       return batch;
> +}
> +
> +static struct xsk_tx_batch
> +xsk_tx_peek_release_shared_desc_batch(struct xsk_buff_pool *pool, u32 ma=
x_descs)
> +{
> +       u32 cq_descs_before, cq_descs_after;
> +       struct xsk_tx_batch sum_batch =3D {};
> +       bool budget_exhausted;
> +       u32 per_socket_budget;
> +       struct xdp_sock *xs;
> +
> +       /* The fairness quota must allow one maximum-sized valid packet. =
*/
> +       per_socket_budget =3D max_t(u32, MAX_PER_SOCKET_BUDGET,
> +                                 pool->xdp_zc_max_segs);
> +
> +again:
> +       budget_exhausted =3D false;
> +       cq_descs_before =3D xsk_tx_batch_cq_descs(&sum_batch);
> +       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +               u32 budget, budget_left, offset, remaining;
> +               struct xsk_tx_batch curr_batch;
> +
> +               /* Once reclaim-only descriptors have been appended to th=
e CQ
> +                * address area, do not append driver-visible Tx descript=
ors
> +                * from another socket after them. xsk_tx_completed() rel=
ies on
> +                * all driver-visible descriptors preceding all reclaim-o=
nly
> +                * descriptors in CQ order.
> +                */
> +               if (sum_batch.reclaim_descs)
> +                       break;
> +
> +               /* be gentle when playing with pool->tx_descs */

Minor nit: seems unneeded comment?

> +               offset =3D xsk_tx_batch_cq_descs(&sum_batch);
> +               if (offset >=3D max_descs)
> +                       break;
> +
> +               if (xs->tx_budget_spent >=3D per_socket_budget) {
> +                       if (xskq_cons_nb_entries(xs->tx, 1))
> +                               budget_exhausted =3D true;
> +                       continue;
> +               }
> +
> +               budget_left =3D per_socket_budget - xs->tx_budget_spent;
> +               remaining =3D max_descs - offset;
> +               budget =3D min(remaining, budget_left);
> +
> +               curr_batch =3D __xsk_tx_peek_release_desc_batch(pool, xs,
> +                                                             pool->tx_de=
scs + offset,
> +                                                             budget);
> +               if (!xsk_tx_batch_cq_descs(&curr_batch)) {
> +                       if (curr_batch.budget_limited && budget_left < re=
maining)
> +                               budget_exhausted =3D true;
> +                       xs->tx_budget_spent +=3D curr_batch.consumed_desc=
s;
> +                       continue;
> +               }
> +
> +               xs->tx_budget_spent +=3D curr_batch.consumed_descs;
> +               sum_batch.tx_descs +=3D curr_batch.tx_descs;

No need to use '+' here because of the previous reclaim_descs check.

> +               sum_batch.reclaim_descs +=3D curr_batch.reclaim_descs;
> +       }
> +
> +       cq_descs_after =3D xsk_tx_batch_cq_descs(&sum_batch);
> +
> +       if (sum_batch.reclaim_descs || cq_descs_after >=3D max_descs)
> +               return sum_batch;
> +
> +       /* Continue filling the batch while this pass made progress */
> +       if (cq_descs_before !=3D cq_descs_after)
> +               goto again;
> +
> +       if (!budget_exhausted)
> +               return sum_batch;
> +
> +       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
> +               xs->tx_budget_spent =3D 0;
> +       goto again;
> +}
> +
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pk=
ts)
>  {
> +       struct xsk_tx_batch batch =3D {};
>         struct xdp_sock *xs;
> +       bool umem_shared;
>
>         rcu_read_lock();
> -       if (!list_is_singular(&pool->xsk_tx_list)) {
> -               /* Fallback to the non-batched version */
> -               rcu_read_unlock();
> -               return xsk_tx_peek_release_fallback(pool, nb_pkts);
> -       }
> +       if (unlikely(READ_ONCE(pool->reclaim_descs)))
> +               goto out;
>
> -       xs =3D list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock=
, tx_list);
> -       if (!xs) {
> -               nb_pkts =3D 0;
> +       xs =3D list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock=
,
> +                                   tx_list);
> +       if (!xs)
>                 goto out;
> -       }
>
> -       nb_pkts =3D xskq_cons_nb_entries(xs->tx, nb_pkts);
> +       nb_pkts =3D min(nb_pkts, pool->tx_descs_nentries);
> +       if (!nb_pkts)
> +               goto out;
> +
> +       umem_shared =3D !list_is_singular(&pool->xsk_tx_list);
> +
> +       if (umem_shared && !(pool->umem->flags & XDP_UMEM_SG_FLAG)) {
> +               rcu_read_unlock();
> +               return xsk_tx_peek_release_fallback(pool, nb_pkts);
> +       }
>
>         /* This is the backpressure mechanism for the Tx path. Try to
>          * reserve space in the completion queue for all packets, but
> @@ -603,19 +758,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_=
pool *pool, u32 nb_pkts)
>         if (!nb_pkts)
>                 goto out;
>
> -       nb_pkts =3D xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> -       if (!nb_pkts) {
> -               xs->tx->queue_empty_descs++;
> -               goto out;
> -       }
> -
> -       __xskq_cons_release(xs->tx);
> -       xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
> -       xs->sk.sk_write_space(&xs->sk);
> +       batch =3D umem_shared ?
> +               xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) :
> +               __xsk_tx_peek_release_desc_batch(pool, xs,
> +                                                pool->tx_descs,
> +                                                nb_pkts);
> +       xsk_tx_commit_batch(pool, &batch);
>
>  out:
>         rcu_read_unlock();
> -       return nb_pkts;
> +       return batch.tx_descs;
>  }
>  EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
>
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 12c9fb29af05..a4089480b22b 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -51,6 +51,7 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struc=
t xdp_sock *xs,
>         if (!pool->tx_descs)
>                 return -ENOMEM;
>
> +       pool->tx_descs_nentries =3D nentries;
>         return 0;
>  }
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 3e3fbb73d23e..a15ff1929db6 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -58,6 +58,18 @@ struct parsed_desc {
>         u32 valid;
>  };
>
> +struct xsk_tx_batch {
> +       u32 tx_descs;
> +       u32 reclaim_descs;
> +       u32 consumed_descs;
> +       bool budget_limited;
> +};
> +
> +static inline u32 xsk_tx_batch_cq_descs(const struct xsk_tx_batch *batch=
)
> +{
> +       return batch->tx_descs + batch->reclaim_descs;
> +}
> +
>  /* The structure of the shared state of the rings are a simple
>   * circular buffer, as outlined in
>   * Documentation/core-api/circular-buffers.rst. For the Rx and
> @@ -263,17 +275,18 @@ static inline void parse_desc(struct xsk_queue *q, =
struct xsk_buff_pool *pool,
>         parsed->mb =3D xp_mb_desc(desc);
>  }
>
> -static inline
> -u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool =
*pool,
> -                             u32 max)
> +static inline struct xsk_tx_batch
> +xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *poo=
l,
> +                         struct xdp_desc *descs, u32 max)
>  {
> -       u32 cached_cons =3D q->cached_cons, nb_entries =3D 0;
> -       struct xdp_desc *descs =3D pool->tx_descs;
> -       u32 total_descs =3D 0, nr_frags =3D 0;
> +       bool drain =3D READ_ONCE(xs->drain_cont);
> +       u32 cached_cons, nb_entries =3D 0, released;
> +       struct xsk_tx_batch batch =3D {};
> +       struct xsk_queue *q =3D xs->tx;
> +       u32 nr_frags =3D 0;
> +
> +       cached_cons =3D q->cached_cons;
>
> -       /* track first entry, if stumble upon *any* invalid descriptor, r=
ewind
> -        * current packet that consists of frags and stop the processing
> -        */
>         while (cached_cons !=3D q->cached_prod && nb_entries < max) {
>                 struct xdp_rxtx_ring *ring =3D (struct xdp_rxtx_ring *)q-=
>ring;
>                 u32 idx =3D cached_cons & q->ring_mask;
> @@ -282,26 +295,49 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, =
struct xsk_buff_pool *pool,
>                 descs[nb_entries] =3D ring->desc[idx];
>                 cached_cons++;
>                 parse_desc(q, pool, &descs[nb_entries], &parsed);
> -               if (unlikely(!parsed.valid))
> -                       break;
> +               if (unlikely(!parsed.valid)) {
> +                       if (!drain && !nr_frags && !parsed.mb)

I understand you're fixing the mb problem here. But I'm wondering if
it still has a problem in the non mb case because the single invalid
packet (mb =3D=3D0, nr_frags =3D=3D 0, drain =3D=3D 0) that isn't published=
 in CQ
cannot be tracked by application?

My thinking is to just remove the above line in this patch. Or I can
cook a follow-up patch to fix this specific problem?

Thanks,
Jason

> +                               break;
> +
> +                       drain =3D true;
> +               }
> +
> +               nr_frags++;
> +               nb_entries++;
>
>                 if (likely(!parsed.mb)) {
> -                       total_descs +=3D (nr_frags + 1);
> -                       nr_frags =3D 0;
> -               } else {
> -                       nr_frags++;
> -                       if (nr_frags =3D=3D pool->xdp_zc_max_segs) {
> +                       if (unlikely(drain)) {
> +                               batch.reclaim_descs =3D nr_frags;
> +                               WRITE_ONCE(xs->drain_cont, false);
>                                 nr_frags =3D 0;
>                                 break;
>                         }
> +
> +                       batch.tx_descs +=3D nr_frags;
> +                       nr_frags =3D 0;
> +                       continue;
> +               }
> +
> +               if (nr_frags =3D=3D pool->xdp_zc_max_segs)
> +                       drain =3D true;
> +       }
> +
> +       if (nr_frags) {
> +               if (drain) {
> +                       batch.reclaim_descs =3D nr_frags;
> +                       WRITE_ONCE(xs->drain_cont, true);
> +               } else {
> +                       if (nb_entries =3D=3D max)
> +                               batch.budget_limited =3D true;
> +                       cached_cons -=3D nr_frags;
>                 }
> -               nb_entries++;
>         }
>
> -       cached_cons -=3D nr_frags;
> +       released =3D cached_cons - q->cached_cons;
>         /* Release valid plus any invalid entries */
> -       xskq_cons_release_n(q, cached_cons - q->cached_cons);
> -       return total_descs;
> +       xskq_cons_release_n(q, released);
> +       batch.consumed_descs =3D released;
> +       return batch;
>  }
>
>  /* Functions for consumers */
> --
> 2.43.0
>
