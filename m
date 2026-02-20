Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259113D503
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549637; cv=pass; b=EGkF3Vx36r5NpRihj7zf0dq5pSdW+sTJx3lsrzkaOnTTXK+XwhkaxyV5R90QiurhnwK0oTCYso6XqYQlikscdNactYHF6bzyxPHXLsWFqev5f+806Y0Hx54KZotV24EEy3QHNlboY0N9mc2+10PEVazB05uJ4SM8Ezlc6C+EelI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549637; c=relaxed/simple;
	bh=4Du0OQoVDfLifz3GYSC+YkUNdNJ2Et5vb/FwjYsvS+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpxVsRP+lLfyriytp7g5uJdC54GIp7CJHZjiPaQWoifzmLDPbQo9dikOZEiS9ZYWssfLVSLgCLKyhT8+ESpO6qNH15pl5ob+gMgq40F5AEF9MuNDKYetwVrvHjwuBDbTNM+H/0uWcYjjqCawqdi49kPrspzDQbQGTcrWFNsa/3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Y1Ryfc; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Y1Ryfc"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso1879057e87.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771549634; cv=none;
        d=google.com; s=arc-20240605;
        b=ckK4mCurf5rDwRNk14OVDN3T0vB3pJYm00luisF3zUwJXNE9j8Y3sKC+3ZMKkJ5CEx
         /7ltwT1/oM/AZ6HgSfrHfH1Of+inYObqlWEPHrIXoFutMN55G3traIKX1SbD1hlG3Zgu
         ecXYRvgGtEtzF9o1/OPxJXBaybMptnwh2EE+nS+FpJre/hpQwVUw8907tvbWZKbvhgE+
         OTA8zEZPkS/JpLGR8Z1ywxN+6S/gD/sR8Jd8q1sqM15B2PiyyC1X7ATqjBhicf9TkirP
         9wWPv1/ZpUSO/fmx8Sib/KpMVDayz+XzVdWGxBvdYXJBZ1TKvUDBmQECpKEt8G2FYFyH
         TUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZmIxyr54D/I58TGB2aA1a9CohmKJ72f48z84M3gqW7U=;
        fh=J4yJzGLNfB6IrTf4kTD1UUuCgV2yNq6dxdgJfdD/hQI=;
        b=UBBNtEcuzStLqQXV7WIdydGAiqWYGcw0jCO11NXLcufBAfEz4hSDiXzKfIjKrGUVFh
         58tpAVyfsQJgyUINID+O++bqYh94rcqrDTg/8roKZxdFT3GGBTwwu5UCcKdJLRahIu9L
         e9AnW3rRdO+INDz9z5kpHItn6FJUH/7rheJMobV3c59QV+Pr/xzZjfJk4M3hd++BhIs0
         H6C9M+QbWm0NIL1KhYdDKXzcIB0r3FFJLXudcpCLnvyx++9vqaX5FWPgVoD25BkAHLJa
         /FzCb6GYy0iCzVdr35OzIFw20e+b2Y6XJiNr3EciX+yM4bBLxFmXvUjTXEs+Y7BQXtw7
         g2bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771549634; x=1772154434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmIxyr54D/I58TGB2aA1a9CohmKJ72f48z84M3gqW7U=;
        b=X7Y1RyfcJ62vtQeELeBpgIsqIwySUL3qfTkhS6exJ8wW/Tx5Bw6aWPvFRVq0FnHJeQ
         oy5zlKhBqqIU/VFinM6b00Z1+3r4bYLRjM2UcyK5wwhY8BsJi+0q2T/m+9rchldlgd3u
         jjyOZHrursfa+h7/GoeiBuFmGY3KSqQTael0bByPDHARXiRKEmEZqLZHSiZT5ylPGxS2
         YAxYsPSlPli03X1L1dbLmjNM87EfSdS5oBhErJRGRtkYvE7dCfsj6jXYX04xIIMAb09d
         /Icrhq2+lOYdO7kKHlcCeCeYj4Y3Rcu5VwhR8Jt4VdmHrk8UsOFzbn3zMTnmmOO/nzS2
         qlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771549634; x=1772154434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmIxyr54D/I58TGB2aA1a9CohmKJ72f48z84M3gqW7U=;
        b=d5f2lJo7ztb09e7EV06aHHQRRQjXAazP5bO8ewVw8u2mmlE9yyC4iBkTWFmkcAqlyE
         4Z7KxNQcIbaWFonyavVjNDe2oFwpyHfg4oZP6MjBhN3S8OUCjsBN3QnSIme0ZVb6/jfM
         WgbAk2MmT5TVsfM4gWvXtC1alDf8adYKhs/oNOmPTqYAWjiOn8ty6K5CyhSk9V5w1Las
         fJrojKYhgwpPuJvl4ZQOrlhfB6ebDUx6TUbRwFJVhBPvqk6wS2Zzs+zIBBlJAbymJsPO
         SzxjaAB8AwSUqyqRiwvDwOqqgatokOB6yr/TA30xOLS93s9dPeKZFRT5NKLbH9j5Agb5
         ArDg==
X-Gm-Message-State: AOJu0YyQvJfNjqw8AxWT2srJ6axjE0bdZfsHXfjIXj2RJVo/uFbK8aIL
	3Lwl8r2r/TjJt5N9OOHhKFHh0j/fFYWJgFHdbC+Y3P4bjnqpj4stfpjs7/8W9H/m65LvhVY7HMv
	9xNim4tFt5FQ2dfQowYJfPcRagbYMEbk=
X-Gm-Gg: AZuq6aImwXoqRHn2DK6OjhYwfXn8SZQuDlkv/kNgEPydPyobc0zhfF+sZ9YP0qniYmM
	mUACWVfCq7acuBudFGOYgICbzrtb5+EN75gwlk0h3jiR+GTDYyq2Wb1mPkrbqv/MERzNZ96Jlza
	ucR++gy5Jl7DJwbdrAZJie6rwmyROhne6UG1EmsktS9hrKaFcSHp3Bw1tD4k5mpzsFqli9/sUXm
	zqfen9UBq5f8Zi83MXmUOzAAPXsKLnB+mBkVd63pgZtxKU0NQF6XuwXZv89xwDh9LcIHjBPZZx1
	J/aO04Q=
X-Received: by 2002:a05:6512:3087:b0:59d:e9df:6dcd with SMTP id
 2adb3069b0e04-59f83b9da63mr2099271e87.15.1771549633590; Thu, 19 Feb 2026
 17:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Feb 2026 09:06:36 +0800
X-Gm-Features: AaiRm52_xb6kFQorOBbTSas6w9BZ_ZFswXRYRYP9SzorGa659iuDtN-NAWW3y58
Message-ID: <CAL+tcoCYMzNtAqgrdOHVNPBO4H5mCtvwhYj5kGdhJ5CCRgRd5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: avoid double checking against rx queue
 being full
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Wed, Feb 18, 2026 at 11:03=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
> rx queue has enough space for producing descriptors:
> 1.
>         if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>                 xs->rx_queue_full++;
>                 return -ENOBUFS;
>         }
> 2.
>         __xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0=
);
>         -> err =3D xskq_prod_reserve_desc(xs->rx, addr, len, flags);
>           -> if (xskq_prod_is_full(q))
>
> Second part is redundant as in 1. we already peeked onto rx queue and
> checked that there is enough space to produce given amount of
> descriptors.
>
> Provide helper functions that will skip it and therefore optimize code.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk.c       | 14 +++++++++++++-
>  net/xdp/xsk_queue.h | 16 +++++++++++-----
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..aaadc13649e1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -160,6 +160,17 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct =
xdp_buff_xsk *xskb, u32 len,
>         return 0;
>  }
>
> +static void __xsk_rcv_zc_safe(struct xdp_sock *xs, struct xdp_buff_xsk *=
xskb,
> +                             u32 len, u32 flags)

This helper is used only here, so I wonder what the need of it is?

Thanks,
Jason


> +{
> +       u64 addr;
> +
> +       addr =3D xp_get_handle(xskb, xskb->pool);
> +       __xskq_prod_reserve_desc(xs->rx, addr, len, flags);
> +
> +       xp_release(xskb);
> +}
> +
>  static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len=
)
>  {
>         struct xdp_buff_xsk *xskb =3D container_of(xdp, struct xdp_buff_x=
sk, xdp);
> @@ -292,7 +303,8 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_=
buff *xdp, u32 len)
>                 rem -=3D copied;
>
>                 xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> -               __xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_C=
ONTD : 0);
> +               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> +                                 rem ? XDP_PKT_CONTD : 0);
>                 meta_len =3D 0;
>         } while (rem);
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1eb8d9f8b104..4f764b5748d2 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -440,20 +440,26 @@ static inline void xskq_prod_write_addr_batch(struc=
t xsk_queue *q, struct xdp_de
>         q->cached_prod =3D cached_prod;
>  }
>
> -static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
> -                                        u64 addr, u32 len, u32 flags)
> +static inline void __xskq_prod_reserve_desc(struct xsk_queue *q,
> +                                           u64 addr, u32 len, u32 flags)
>  {
>         struct xdp_rxtx_ring *ring =3D (struct xdp_rxtx_ring *)q->ring;
>         u32 idx;
>
> -       if (xskq_prod_is_full(q))
> -               return -ENOBUFS;
> -
>         /* A, matches D */
>         idx =3D q->cached_prod++ & q->ring_mask;
>         ring->desc[idx].addr =3D addr;
>         ring->desc[idx].len =3D len;
>         ring->desc[idx].options =3D flags;
> +}
> +
> +static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
> +                                        u64 addr, u32 len, u32 flags)
> +{
> +       if (xskq_prod_is_full(q))
> +               return -ENOBUFS;
> +
> +       __xskq_prod_reserve_desc(q, addr, len, flags);
>
>         return 0;
>  }
> --
> 2.43.0
>
>
