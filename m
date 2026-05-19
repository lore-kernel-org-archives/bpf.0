Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A082DF68
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149275; cv=pass; b=JgeUYEHNk4DvEA+IeqJNmOXyv4CIMPteNqNvd1PQAnvotRKN7lB7nOnJ1aZhj9XIQCurS2z9/zNgfr3vEK8wmj8ls9rhHHPMb6yopU4Q1laIOvOspRh0B6LDdsSXz8AwR/r+7GJZ789JFTFAVjBtGRPamlRqNcmPuwkGuA0eePw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149275; c=relaxed/simple;
	bh=9hILS1zDb+jPchgacVcoJ3YWwARXDYScIVCTRw1ScOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6KaE1CdQOvDto+o4oXhTnVIlRZBRX/bKGmMtfR0k/3ZN7pOeeOLHnxndJ0s6HkPvcNrwLYynj7z4svsax+wEqGetdJYS7kiaJd38qtYvLBHwBYyM+UjjmfZMWFRNyjG7NJhBwhuL3nwEc/gwzP6Gcq77KZV+l4oSrbpxzx3h/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9OT+2K0; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9OT+2K0"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39556b00a85so27058551fa.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779149272; cv=none;
        d=google.com; s=arc-20240605;
        b=XyIPzJ+NsfqJ3K3jwNfkvGKXABAoh0amC4QnbLxPvSON6aznyV62vlCbUg2Kwovuwj
         AY28e+ZxLzzZnJqH3/d/ZwvQfn9t3toIc4G4WU0z1TkrqJhr9wN8pFKzkyvZau23zdDA
         EQZ5fCWbNZB8DWFPvfUfpHA1DOSceI+BPUe4xv1spkaKkzo3ojeXdamX2E/xXUaAWJ9p
         sl4eMFmhN9Wx30edTFNtQoB93t0BIqqCpMz0r0k7h1Gv2WNWFKVXDIm2+NgI/8wv6WL3
         U2/Z6BAHSCnyP4IOigbR/dUpLpfD1b6XErRpFhumiwmNE7o7tUwlc0BSEZPEUo16N0X4
         Jhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qovj3NDVZxKBs2Er+LgveuzgeEyaYQonhNZuNeoGmdU=;
        fh=zKXVB5gvx8NPTkXp9Ivngart622xrBkrbNllbKWUo4c=;
        b=WY+8cYbnvEvIRN//fplYsoW6U4zew+sSpb8Z/fi2JHq7l071CaYDNqlJmXVv6lK1wZ
         bsPzwylmWMNyFSkr8iDLJvhQti9cprDkK/GGEbK5MrQBn+o3bEs/l/P0U9myp5zT05uN
         Ixu1T2fnzjeTRGrRRP4k3AwYdyGBQfBn5phmErar7Nj9dG8wDpi9SzXjZuGhwLAL3ZwM
         /LGBOZmlFXUTXE76XtQs6Xw6HNdfq9svLp8K6CJCYvX7vaLtebccJQAPJP8UfjdWhrtJ
         0q8qzFpZ4Z4Exi2WgbRIIWAFmYfL8eHhVMbpp/caVcGT42SoCuVllBqPcKXLWs+jwTxL
         7C+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149272; x=1779754072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qovj3NDVZxKBs2Er+LgveuzgeEyaYQonhNZuNeoGmdU=;
        b=U9OT+2K0z4Rw7PVmLFaNP0yVaD2ezc5pM2BCOrtC6tUaPsRfQGa2iDixdaWxyF7Q6b
         FCH3n/baI4jZKkmpouR5NA2bt/K1DBJAJhXOxq2PJhi7mv00JdsPevJdyj3oB/dSBVOG
         IhOI9QU4TZ8G13FKkipsrLIInILtcmp8CX4ZAEdonQIdkiLKpfdsa4E7IhbPeoHen9QX
         R+PrhYT9XOKFe7YkyLtY4RqNvLeky9xfasErvyF2uyW/A4M3fN+XZroz7Ee7ofsfY4HG
         Pp9x7jJcJyl4mXuR8Z3DqMp5psHMPcXYDpa/u1+kVjLgFHAWKpMil6n8i8lD0WbDedHY
         5HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149272; x=1779754072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qovj3NDVZxKBs2Er+LgveuzgeEyaYQonhNZuNeoGmdU=;
        b=nItABdaMUO2Mvdr/NLoRbrFgC2J2TcnEnPzEoP+SqFYH7XvW3tfEpcuLZ2qfPdjuv9
         4Jt8XqTT+kkBIPUwcx1gf/+4sFsVMz1QSA4P//enTwmMgz5K1H4vI96bNqOmqQ3MCCRx
         hWJ0Rz9Y1iw9A3WPKdy8wcAR/MZCLbaw5jSQJuZhf6Sx/uiNJDqo/rASq0Q/n1TwHrMz
         8ioFz2rCMtVwzsek6pFtobHV7KZs1P3/dE36uUxIZlMfaLKKPI8W4ZSJve6TyW47nJH9
         26PXOtzvZKY/px9sanNNiwckaQ497gDI2OWhwE3RlNNSvC3RDLxEejb+icY6xQtEJVb0
         d02g==
X-Forwarded-Encrypted: i=1; AFNElJ81hQuflX5GbjgK6GSdyB5Cka6aPQY4/0x8trYwWO0x35FSw2/dDjMt9EQWJ26Z0UFpO/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VnS0Jvn7Xguu/y2FtiLxQZorjwFbhfdlzwpABEOTTw1WlHjO
	dmSD4TcjeMecbmcuXRihyO0Fo5S9pVzPlF5Iv45NvcOtpHNgWcGI1i3ZDMprTcBCtN90Y0zQOc5
	avegoBROv7ZX28SsYbQv5mjWjqDdZiac=
X-Gm-Gg: Acq92OGH+sOQq0ui599Ud66CUTkq1iSidF9AqcdNmL4v3mlWwF13U8gUqs6RcNEBOui
	UPKZOAd7awxfillm65ANRYECo190mI2KW00FfqxSYMq9fYjE8Uq69bsR6y9NOBYZLEi/2GC3zU2
	Hq66qP58Zkyo98N4v9+qfYGQRJFKvy8IkmWJswZVSs1sDhGjILtQUGUhzSV87w7GdX750zhm43Y
	uaBFvpobDzrwwmCn0CbfVPI/V32hqZfVq0lNtG/2ys8apHOkAag9Tpvwgqy3SXG1SgFiJ2/N7uN
	HH/VL+hLSS6+GeOwkEJNmh74AJlPURpb83SDBRY=
X-Received: by 2002:a05:6512:1590:b0:5aa:b6b:93c3 with SMTP id
 2adb3069b0e04-5aa0e74512dmr5337393e87.45.1779149271779; Mon, 18 May 2026
 17:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com> <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
 <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com> <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com> <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
 <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
In-Reply-To: <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 08:07:14 +0800
X-Gm-Features: AVHnY4Jli4ZYZ34dgWSRjvY5BP-C0qxPE8w64703gMJMVUWklQLMw3sQs8VkTQk
Message-ID: <CAL+tcoD8dtua=ErG63Rn1xNhhWGx=RY-FLa2_rcH78k_Fy7=qg@mail.gmail.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in xsk_build_skb()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 10:54=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/16, Jason Xing wrote:
> > On Fri, May 15, 2026 at 11:41=E2=80=AFPM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 05/15, Jason Xing wrote:
> > > > On Fri, May 15, 2026 at 8:29=E2=80=AFAM Stanislav Fomichev <sdf.ker=
nel@gmail.com> wrote:
> > > > >
> > > > > On 05/14, Jason Xing wrote:
> > > > > > On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
> > > > > > <sdf.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > On 05/10, Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and trigge=
rs -EOVERFLOW,
> > > > > > > > only the current descriptor is released from the TX ring. T=
he remaining
> > > > > > > > continuation descriptors of the same packet stay in the rin=
g. Since
> > > > > > > > xs->skb is set to NULL after the drop, the TX loop picks up=
 these
> > > > > > > > leftover frags and misinterprets each one as the beginning =
of a new
> > > > > > > > packet, corrupting the packet stream.
> > > > > > > >
> > > > > > > > Fix this by adding a drain_cont flag to xdp_sock. When over=
flow occurs
> > > > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag =
is raised.
> > > > > > > > The main TX loop in __xsk_generic_xmit() then handles conti=
nuation
> > > > > > > > descriptors one at a time: each gets a normal CQ reservatio=
n (with
> > > > > > > > backpressure), its address is submitted to the completion q=
ueue, and
> > > > > > > > the descriptor is released from the TX ring. When the last =
fragment
> > > > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared a=
nd the
> > > > > > > > function returns -EOVERFLOW so the next call starts with a =
fresh
> > > > > > > > budget for normal packets.
> > > > > > > >
> > > > > > > > This reuses the existing CQ backpressure and budget mechani=
sms, so if
> > > > > > > > the CQ is full the function returns -EAGAIN and userspace d=
rains the
> > > > > > > > CQ before retrying. Zero buffer leakage, zero packet stream=
 corruption.
> > > > > > > >
> > > > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2B=
CB2@smtp.kernel.org/
> > > > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buf=
fer on Tx path")
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > >  include/net/xdp_sock.h |  1 +
> > > > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > > > >  2 files changed, 23 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.=
h
> > > > > > > > index 23e8861e8b25..1958d19d9925 100644
> > > > > > > > --- a/include/net/xdp_sock.h
> > > > > > > > +++ b/include/net/xdp_sock.h
> > > > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > > > >        * call of __xsk_generic_xmit().
> > > > > > > >        */
> > > > > > > >       struct sk_buff *skb;
> > > > > > > > +     bool drain_cont;
> > > > > > > >
> > > > > > > >       struct list_head map_list;
> > > > > > > >       /* Protects map_list */
> > > > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > > > --- a/net/xdp/xsk.c
> > > > > > > > +++ b/net/xdp/xsk.c
> > > > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(st=
ruct xdp_sock *xs,
> > > > > > > >                       xs->tx->invalid_descs++;
> > > > > > > >               }
> > > > > > > >               xskq_cons_release(xs->tx);
> > > > > > > > +             if (xp_mb_desc(desc))
> > > > > > > > +                     xs->drain_cont =3D true;
> > > > > > > >       } else {
> > > > > > > >               /* Let application retry */
> > > > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct s=
ock *sk)
> > > > > > > >                       goto out;
> > > > > > > >               }
> > > > > > > >
> > > > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > > > +                     unsigned long flags;
> > > > > > > > +                     u32 idx;
> > > > > > > > +
> > > > > > >
> > > > > > > [..]
> > > > > > >
> > > > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_=
lock, flags);
> > > > > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > > > > +                     xskq_prod_write_addr(xs->pool->cq, id=
x, desc.addr);
> > > > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_=
prod_lock, flags);
> > > > > > >
> > > > > > > Not sure I understand why you want this if you're still marki=
ng the desc
> > > > > > > invalid.
> > > > > >
> > > > > > The key point is that as long as we read the desc from txq, the=
 desc
> > > > > > should be either put back to txq again or publish it in the cq =
(for
> > > > > > application to keep track of this) at this point. Or else, the
> > > > > > application will lose track of this desc, which breaks the whol=
e
> > > > > > logic.
> > > > >
> > > > > Yes, makes sense!
> > > > >
> > > > > > > > +
> > > > > > > > +                     xs->tx->invalid_descs++;
> > > > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > > > +                             xs->drain_cont =3D false;
> > > > > > > > +                             err =3D -EOVERFLOW;
> > > > > > > > +                             goto out;
> > > > > > > > +                     }
> > > > > > >
> > > > > > > I also don't understand why you want to return -EOVERFLOW aga=
in? Why not
> > > > > > > (quietly) swallow these invalid xp_mb_desc from the previous =
packet and move
> > > > > > > on?
> > > > > >
> > > > > > This particular desc is really one of overflow cases, right? We=
 should
> > > > > > warn users to handle this with this error code.
> > > > >
> > > > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > > > The part where you set drain_count=3Dtrue will -EOVERFLOW. Then t=
his
> > > > > remainder will also return -EOVERFLOW?
> > > >
> > > > Right, my intention is to alert users twice under this kind of
> > > > circumstance. We silently drain the remaining portion of the skb th=
e
> > > > second time, which looks a bit strange, doesn't it?
> > > >
> > > > >
> > > > > But let's maybe step back, what's the expectation on the user
> > > > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > > > shorter packet (at the current prod index), right? And then your
> > > > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> > > >
> > > > People would be aware of the skb that is too big to handle when
> > > > receiving two times of overflow warning. To put it in a simpler way=
,
> > > > the second time in xmit path only handling the remaining is enough,=
 no
> > > > more descs that belong to another skb should be taken care of.
> > > >
> > > > If the user is able to quickly react to this case, I think the whol=
e
> > > > skb should be re-put into the txq again instead of adding the
> > > > remaining part. I'm not so sure if I interpret the "break" correctl=
y
> > > > here.
> > >
> > > Let's say the user puts a packet with too many descriptors. We find t=
hat
> > > mid-way and return -EOVERFLOW. What is user supposed to do with that =
error?
> > > In my mind, the user should drain TX ring completely and start postin=
g
> > > shorter packets. You seem to be trying to handle the case where the u=
ser
> > > leaves the remainder of the previously EOVERFLOW'd packet in place, w=
hy?
> >
> > Good point. I think now I understand what your opinion is here:
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 3b604776f09f..72d05a1fb0b5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> >
> >                         xs->tx->invalid_descs++;
> >                         xskq_cons_release(xs->tx);
> > -                       if (!xp_mb_desc(&desc)) {
> > +                       if (!xp_mb_desc(&desc))
> >                                 xs->drain_cont =3D false;
> > -                               err =3D -EOVERFLOW;
> > -                               goto out;
> > -                       }
> >                         continue;
> >                 }
> >
> > Then as long as we have enough budget, we silently handle the whole
> > big skb and then continue with the rest of the skbs in txq. Users will
> > be alerted by the counter of invalid_descs. I think that is what
> > you're asking, right?
>
> Yes, this resolves one part. But the larger question still stands:
> why do this tracking at all? Why can't we clarify in the documentation
> that the user is responsible for flushing tx queue completely after
> EOVERFLOW? What am I missing?

Previous and current (v3 as you may notice) impl always silently
handle the overflow packet which means kernel never returns -EOVERFLOW
back to the userspace and users have no way to receive this signal and
stop sending more overflow packet.

Another point is kernel should be capable of tackling this overflow
issue separately without considering how users would do after
realizing the problem.

The v3 patch doesn't change any pre-set behavior of xmit path but only
publish the desc into the cq.

Thanks,
Jason
