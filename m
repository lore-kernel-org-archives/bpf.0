Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF63C198A
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441769; cv=pass; b=H4s6YEt9KuJBkDFV/FQyVfxgqEGjriLLfrBvqczxUpxmDMGnAwtpTlC3RCMI82Xg1gifM0V20LCIbWX82ftnNtWdUEdqXAkzok+6aL4FU9CW1kZ8vCMr4WHcuXgnzAx1hHYBTGBFfIQU6nIjZjR0SU26RfbHAkupUkNF9TBUgwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441769; c=relaxed/simple;
	bh=9HTYdj36OP19ar/Z2o1Nflr6TtOAK0uthrZE/uqdMNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXcOhxPxxKmVfDaprP6dWx85VcSj0+oq8iitWKBYoFRSZhLem9jXf3/muNDhvJGXXb3sw4dSxNT0vsbQocavD3xvf1IzUj6uSm5fz6yYzE2NSudRT69p6eimTMjhvM5yujzUtSNSIgW2KqpFIv8O1z3WjtB8D2Zn1BIzY+XeG70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/tVPBOW; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/tVPBOW"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a87782588cso9164713e87.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 02:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779441766; cv=none;
        d=google.com; s=arc-20240605;
        b=clj+N/sqsksfouvN8TuhVEzp4f0TX7L2qt9LS2ie2sKhpcHVZF9vtMYFM85uVOf4bU
         BEYz1bV9kz3LEk3bLxvqvVDWpUaZmSwhU9Xjgtf1Ltqx8ehCxkR2ismxpOo/tMCOHrhD
         q35uiIT1kPZi4dERycHj47s11/nx7MuyE2iKlFYHGmwoPAb5/k9AoT+WW9mT6fiaU9BP
         2DNKaO7/MgxIKwUPaXJLCLmaGNI4pEM8WdsiEBmkJ5bSYdbgPAhl3f3liQoF1w1D/LmS
         O+35jeFeDNfAU63tTC7XyOwDbz60tS/kPbVwbvEtCswagrGogFSUk3BODW2b4/4Gom/N
         9A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLKzwkXsCEt56sWNeFNYAOv+OWTqrZnI1zQs1+4PXdM=;
        fh=qvMw07faPAMC81UVv3REMYAZjq6z8HaWF9MAB2uBSic=;
        b=WNdLPXYkWMK6X6I8k7Lp1nAgv4DCQgwtDKu88qqgKfHU/qzBAV/8KDX8MgpjA/5wqs
         I7Tq2f5EhhKC8qUtoVzY3acWMYNG+Tnm9eOMBf8MGGJ5dIFkqkJERXaLTXC7JEJMfZ+/
         uyCrCY5vXsZ7BDh/3nuePPLA+eS+1AauLcZeNRzaVdMK0muj0I/M2dVMoe3Fk9Hnf/t0
         /eh1rEndgucY2ROo4zjxeSLRS2oBuMkiv4gkj2qvM5Pcef1hKImyILDMEn8xN88/PQ8g
         SxiUuxcDO0sdUbTsRwtOZ4AadaDwA9g8Tfd/xofMdnxxFzGS2ZEt9gRdSNIhmaWijFui
         NTSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779441766; x=1780046566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLKzwkXsCEt56sWNeFNYAOv+OWTqrZnI1zQs1+4PXdM=;
        b=i/tVPBOWKwQKTMJHexmn9jgbS8/fi5U3qcvSgUrpdlhE5PVkJKTN20++If+w7MmD5z
         i4Cr4cifRYNkprGvVWx2vvoP685y5DwJt7fBQyPavTcq3Bwhl+NJ1C2YnFd87GL3wYhw
         pMv5MJkZtyIKdrlr9UWs1XIXG8QDg1gSUzLLqSApOZNEPI2l0ibyW6ChqM9oaz/FXLej
         rGXBowq5WNOkjBNMapNTUs11/bvX69kAEPgt29/TrLor1NNNk3132hLo8JHhrtnCyguX
         WlmjZw/IkTsShtdZ9anYsxIEZldFI9ykOt+3DpQcdrUGZS4Dyn6ruYluBioIHCmM6uLN
         C6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441766; x=1780046566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLKzwkXsCEt56sWNeFNYAOv+OWTqrZnI1zQs1+4PXdM=;
        b=Pwu9QaM/kxdW4mUynoWjyfG0LtyUYcEBZpOKJ89ClvhRngkWqT1kwAyeXov80w8ukN
         rnPZuK/iDamOJYb8Dnh/TYLpDjESWqTmYgbX8RQCF7Uz2Poq1zZETHqnJfcYeEff/+5f
         CD6D9Uw/wn715FqiN5xlBeWDSS4P738OXyWrJ0ZlI9r1AhEF1TAObhNM86oxOndtFJFH
         UH9eYaSBd2huwK3ZlPwO2wQn9STQ8/VLKatoB/wE8A2bhG95xV5t7SvJWdoesyAcKeQz
         nsQ/5W417dMvLcNQbCVfABz3WCJr95/3tAk/H6FjntZve6aV/WUjalhCscP6PhK4uAqF
         CwHA==
X-Forwarded-Encrypted: i=1; AFNElJ+NfpNLLpahH55XSn1rilgeYRqxgY+BBD7AhbAvQTJJhUNq0j5E5wNHMjt9RrqpRn/MrAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFTdQsX6xABb2ZCMUlKcU2Pv6qlKyf5QuuuTJZsoPSLVc5YPr
	SLkfEtzqxTmHcRuMGwiysEXsY8z+SAHRK0NYiYSqtuAsdQCWS3vloKYtisozzeiQUO6x/QnvfDl
	EYVkBxcFoPMKVpta6YwvkvQkK0b4E8PS778/fAUEgrsRS
X-Gm-Gg: Acq92OFYlxnxtuTYC2GoS0v/lRt2lpbKytw0joilSDKbXKeie4GZqkVqhIjBob5uEYy
	2bfJKfqUmPyjodSTMvfhcZDtMK51QMOUEzmwYvncISW2L6mV2ppTiBa/x/XFIa22qfBCmBSjd5d
	t2+aP1BMZRTgcNXJn+QelGygBQ97sNlF+hQqCbo5s7H4D9is4gNF/t9R9bBev4LBxCsnNSmDNbW
	jA3pqfIF0WOX/soQjXLDBB3ue4BtCnGO1/jNr2Ksaoojd/37wVHdcOqUBFD1Um5eRfpjwoo4hv8
	UxbD1WhqR4655+iIvtbZo3WvOAKX7t9PpO+3qVlZ
X-Received: by 2002:a05:6512:40cf:20b0:5aa:b6b:93c1 with SMTP id
 2adb3069b0e04-5aa323a9376mr569353e87.43.1779441765358; Fri, 22 May 2026
 02:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com> <ag3c9/EF4h7DLQu3@boxer>
 <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com>
 <ag70RrU4nGy0Nlna@boxer> <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
 <CAJ8uoz0bKHSiHjRvNmvVs_z3cWg58U=6wGKKs9_n65yCCcYbEw@mail.gmail.com>
In-Reply-To: <CAJ8uoz0bKHSiHjRvNmvVs_z3cWg58U=6wGKKs9_n65yCCcYbEw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 22 May 2026 17:22:08 +0800
X-Gm-Features: AVHnY4KPJR2T7YSjs_8Ul5sH3l2nA99WuQMZIMYetyUuNvVQFeSa6E2jFKaCndM
Message-ID: <CAL+tcoCaOY=YEDM2N0tuWjyQpOrTZMkHSYT4KQsy_fn2757V6g@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 5:06=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Thu, 21 May 2026 at 15:42, Jason Xing <kerneljasonxing@gmail.com> wrot=
e:
> >
> > On Thu, May 21, 2026 at 8:02=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> > > > On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -=
EOVERFLOW,
> > > > > > only the current descriptor is released from the TX ring. The r=
emaining
> > > > > > continuation descriptors of the same packet stay in the ring. S=
ince
> > > > > > xs->skb is set to NULL after the drop, the TX loop picks up the=
se
> > > > > > leftover frags and misinterprets each one as the beginning of a=
 new
> > > > > > packet, corrupting the packet stream.
> > > > > >
> > > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow=
 occurs
> > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is r=
aised,
> > > > > > so we have a chance to examine and handle the potential remaini=
ng descs
> > > > > > of this big overflow'ed skb.
> > > > > >
> > > > > > When the last fragment (without XDP_PKT_CONTD) is processed, th=
e flag
> > > > > > is cleared and the loop continues to process subsequent descrip=
tors
> > > > > > with the remaining budget. This behavior follows how previous x=
mit path
> > > > > > treats overflow packets.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@=
smtp.kernel.org/
> > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer =
on Tx path")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  include/net/xdp_sock.h |  1 +
> > > > > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > > > > >  2 files changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > index ebac60a3d8a1..8b51876efbed 100644
> > > > > > --- a/include/net/xdp_sock.h
> > > > > > +++ b/include/net/xdp_sock.h
> > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > >        * call of __xsk_generic_xmit().
> > > > > >        */
> > > > > >       struct sk_buff *skb;
> > > > > > +     bool drain_cont;
> > > > > >
> > > > > >       struct list_head map_list;
> > > > > >       /* Protects map_list */
> > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > index 0a6203c42576..f4add7be8c93 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct so=
ck *sk)
> > > > > >                       goto out;
> > > > > >               }
> > > > > >
> > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > could we get away from introducing dedicated boolean to xdp_sock =
for
> > > > > handling this rare case?
> > > >
> > > > I've tried several ways, but they didn't work. Please see the short
> > > > conversation with Stan:
> > > > https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1Lveq=
H=3Duxd2McuR-w@mail.gmail.com/
> > > >
> > > > That means we always rely on a flag (that is either static or like
> > > > this patch) to recognize how we treat this abnormal descs.
> > > >
> > > > >
> > > > > > +                     unsigned long flags;
> > > > > > +                     u32 idx;
> > > > > > +
> > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock=
, flags);
> > > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, d=
esc.addr);
> > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod=
_lock, flags);
> > > > >
> > > > > It feels a bit off to do this cleanup one-by-one.
> > > >
> > > > Actually no, it adheres to the basic send logic in copy mode.
> > >
> > > Not really. Here you are producer to cq which we have batched variant=
s for
> > > usage.
> > >
> > > But after second thoughts I don't think it would be worth to put any
> > > further effort onto optimizations here. Anyways, even though generic =
xmit
> > > is a whole bunch of mess, maybe you could pull this out onto a helper
> > > function?
> >
> > Sure thing. My takeaway is that it will be refactored once as the
> > batch xmit feature lands in the tree.
>
> I agree that the code has become really messy since I get a headache
> when looking at it ;-). Do you want me to take a stab at simplifying
> it?

Thanks for your help. But not now probably. I think we can focus on
the batch xmit feature[1] where the main xmit path will be rewritten.
I admit it's still complex to understand :S Could you shed some light
on the series that I'm going to post?

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gma=
il.com/

Thanks,
Jason

> >
> > >
> > > >
> > > > >
> > > > > I wonder if it could be covered by xsk_drop_skb() where you would=
 walk the
> > > > > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_a=
ddr_locked() ?
> > > > >
> > > > > OTOH, in theory the amount of frags after we hit the overflow cas=
e could
> > > > > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to=
 cover
> > > > > them.
> > > >
> > > > Right, this is why we now put the logic into the xmit path just lik=
e
> > > > other kinds of descriptors. We need to check and send it under a
> > > > series of protections like the check of cq pressure and budget. I
> > > > don't think it's an exception to escape the check logic. The whole
> > > > process should be fast as there is no need to build skb and send it=
 to
> > > > the driver as long as this case is recognized.
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > > +
> > > > > > +                     xs->tx->invalid_descs++;
> > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > +                     if (!xp_mb_desc(&desc))
> > > > > > +                             xs->drain_cont =3D false;
> > > > > > +                     continue;
> > > > > > +             }
> > > > > > +
> > > > > >               skb =3D xsk_build_skb(xs, &desc);
> > > > > >               if (IS_ERR(skb)) {
> > > > > >                       err =3D PTR_ERR(skb);
> > > > > >                       if (err !=3D -EOVERFLOW)
> > > > > >                               goto out;
> > > > > > +                     if (xp_mb_desc(&desc))
> > > > > > +                             xs->drain_cont =3D true;
> > > > > >                       err =3D 0;
> > > > > >                       continue;
> > > > > >               }
> > > > > > --
> > > > > > 2.43.7
> > > > > >
> >
