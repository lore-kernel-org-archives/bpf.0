Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2E17993
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891989; cv=pass; b=MzdNY0Cvk/uCf9PVfwETUr1POKFJZMF91rHKI+uSBBStbrRZ9lH4NJVnQTJea37wWw4PUUAW3/ybW0dYxnwCNMZ46Fx5lYB/rVpg6FwmaZkDNjLIOBthBgub/9yA2aXzuZFpYl9ZUnTCD9vG1vJhHKF4wuj5vI/yX7LMUj8urqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891989; c=relaxed/simple;
	bh=T+yUj63nr8G0D2RqAT2dp1bp65Xp4QhXHRGbEAsk0Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAKAckyeYJW8OMYm+yTdA1WHGCBIwIFVYLSX2M+RnTMvjiaiBTyKtJBbra1tHv6bNKLKKk7PVzQr1LcMyVev36+FwgP2sB8R4LWgZF2ou27dqiMtsaWL7YTKrmnzlDDKJCXSmry0S/KGH/+xjpcrgsA/W++kZNx2N3i3rG0FuCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBbsjnNL; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBbsjnNL"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so1678882e87.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778891985; cv=none;
        d=google.com; s=arc-20240605;
        b=Fab51bN7ahy++9mCzRDUsg3KFyTg++74zncl1sVOc2RVU890n2ZvDD0qDqqaLO+XKA
         chQdwCT/GhwlTKYNqUipKwNFlejPZ3eotlNab3wE6Kt8hOg4ldThLy0L9stO0XK/VLJA
         EJ0+Ajq6oRVlsH9DMyiQkUqiQHfbtydE/7R6A89NHO4rHINd0umCGpX3hCkw/CgJFICe
         nnb9wZVo1hRBeIGIuQND5pc85Ittfq49YCsOmlFUpA7eBad0cHmHqJm+EacxfLxmt8aO
         LXIcjXY172QGZWl8LzJ5cLEJSpsLmXqqoIMp9mE/8a4Cri0gonsee7xAiHCEB/s/wnJf
         MXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wXQw3ul382R2H1568ILjKfxwOS5UY4B0hdZAwg0074k=;
        fh=8d3c9MRIEo3TovO1Jumo5HHDSq8poyRCGtU+7zDjQVE=;
        b=E42Ht2XJi5Bpt6bAOlZZhQNYQvBnjI3tBpl0N45E/T6r1hzlMObZKIC/8NvCAixy/Z
         7WEN3KLtsXYsWJu7NLqwM+8ZrPHqv3UkdrLFz7IwrS2Kfj2785NNPma35/ePDBBBjRmB
         8dt8oSwzVUKOQRXVZpJG45YoO4rYPl4kjKZYtE+rVwtnFv80G44xbNbCsZzSzv7ZZSOF
         HIn8v9JH2sF4etPoVcJpd4dn1DtFCbB7JJUepB8NmM4BaV0lEcNlMVMbRU3tuVw0d3Ay
         8uIrvf0k29ltNqhPNaQjOTsslhkxOypb4Mue4lusYH2qVOm+60MGPQ/k5IUzyJqlXZFz
         QTTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778891985; x=1779496785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXQw3ul382R2H1568ILjKfxwOS5UY4B0hdZAwg0074k=;
        b=ZBbsjnNL4r5qt0WkjlnXHrWbsKWSulfgyCiuX50kN7HXYrsYyAoVoHnLZOgqVYMVaA
         eRxarTYhf+NEGHUTjvD74SDAx6MyhyfiYNFmPfdaV3yZ4OknTVsA2m2hKRBinZm3tlus
         mXUnqL+zogZnWOE4eH//KJ4sOBdvlpov5c0QQ2PZEj1RSxiq1Er6PFZAwwhY991ZhOXq
         ipjyU8bcsk3tDRjjyrb3Rt4HiZoIOzAuqopdkBhDuMc/GAvSmU+9t5t96xLM9siFBKKA
         Xh/evveE4M0M/ydRvf2cWKY8+jfBaVZ3cWsApqkA+ruRcOKAy7cAHKaGg85voHbfB5At
         UnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778891985; x=1779496785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXQw3ul382R2H1568ILjKfxwOS5UY4B0hdZAwg0074k=;
        b=Cyx+3Rs8z556eJ/UUNOT27lTJ7Eq3Ncmn4wsFXlV/EqEIimLQJdAoYe2YSVATNST0b
         xnBPaszzCeHUZiQ+02NKzenBzlY6aHSQvRZBIcUesbDMzn3BzXKu+z7Z2BH7tk5UIQtV
         UPRHzXFGcezb4l6dz3aVsWjVrvRDULfHTD0Gg9KwM/5L7VQbrUMgyF1qERCPuKkBsn2C
         6gGLMpFB4rbR3gCYz76QUef3nrFqXg+080oiVKY9RyOpdaDZQ4HuizOCmsJs+jBEJBJE
         qZ3mq9X66FLUMAVxDU0EUzX8n4AjtPvekXshYLGihPFo2VLcq0XtgGaeowdM1oGubZOM
         F9vg==
X-Forwarded-Encrypted: i=1; AFNElJ/Pc3n78zfSir4k3Pqu/Fp6UMTroGIryFCrfs12LYHSn0Lv8jLzrXUJMA+vIqSqtZ9FhP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIYaQHIaxfyOXcbzEBZmx8+RwDKY3sA+Gr+q3KVicjs3KPT9p
	+hJe3CoX18ILPrrUV60R1RVWJupJovpFQI7PCff1fDqsUM1L0EdbsqzkLThO8AhZFNO4tq6xg21
	ehPfGq1y46DgV8q6erx3KbSduXwL/1G0=
X-Gm-Gg: Acq92OHuALRXAZ/h/vG0sZXtMmdFKnxreDlnz4x7HA2rAfN7CpHepSoZ1LNQIwmfH3Y
	jd78zbDKzV12c1BqFBeHL3wGfpPS3+NT43CAnQnLRTOQWs7+MMLNM84ftogsv9SXrWGqMtDpy0O
	rkG+Xs9hCs2yg9f1CKYpnHzR2mHDly7LWXSU1nrkgfkYegLyo4YZ+tS96JdNPZylagu0lWiE4SD
	4ZUJNiuzP7Qb+j7Tt+tbDzIaVABBDwh6mOMLxyuUN81fZL1mT1BTNzFnm6/Mh1RPAJpP5hG4x3z
	WQKnDsMWR8lYs/l+7RSGOv2GyD97xhfiVs5/Wp8K5cJftNWBcg==
X-Received: by 2002:a05:6512:33d3:b0:5a7:4699:9fd8 with SMTP id
 2adb3069b0e04-5a8ffc67143mr3197300e87.16.1778891985134; Fri, 15 May 2026
 17:39:45 -0700 (PDT)
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
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
In-Reply-To: <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 16 May 2026 08:39:08 +0800
X-Gm-Features: AVHnY4K3LQI7Ue7pUUyQTA0Ygv5_VAl1KOEhJ-ibFjUCQa_lphV8g5fy1rKEc54
Message-ID: <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
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

On Fri, May 15, 2026 at 11:41=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/15, Jason Xing wrote:
> > On Fri, May 15, 2026 at 8:29=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 05/14, Jason Xing wrote:
> > > > On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
> > > > <sdf.kernel@gmail.com> wrote:
> > > > >
> > > > > On 05/10, Jason Xing wrote:
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
aised.
> > > > > > The main TX loop in __xsk_generic_xmit() then handles continuat=
ion
> > > > > > descriptors one at a time: each gets a normal CQ reservation (w=
ith
> > > > > > backpressure), its address is submitted to the completion queue=
, and
> > > > > > the descriptor is released from the TX ring. When the last frag=
ment
> > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and t=
he
> > > > > > function returns -EOVERFLOW so the next call starts with a fres=
h
> > > > > > budget for normal packets.
> > > > > >
> > > > > > This reuses the existing CQ backpressure and budget mechanisms,=
 so if
> > > > > > the CQ is full the function returns -EAGAIN and userspace drain=
s the
> > > > > > CQ before retrying. Zero buffer leakage, zero packet stream cor=
ruption.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@=
smtp.kernel.org/
> > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer =
on Tx path")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  include/net/xdp_sock.h |  1 +
> > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > index 23e8861e8b25..1958d19d9925 100644
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
> > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct=
 xdp_sock *xs,
> > > > > >                       xs->tx->invalid_descs++;
> > > > > >               }
> > > > > >               xskq_cons_release(xs->tx);
> > > > > > +             if (xp_mb_desc(desc))
> > > > > > +                     xs->drain_cont =3D true;
> > > > > >       } else {
> > > > > >               /* Let application retry */
> > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock =
*sk)
> > > > > >                       goto out;
> > > > > >               }
> > > > > >
> > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > +                     unsigned long flags;
> > > > > > +                     u32 idx;
> > > > > > +
> > > > >
> > > > > [..]
> > > > >
> > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock=
, flags);
> > > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, d=
esc.addr);
> > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod=
_lock, flags);
> > > > >
> > > > > Not sure I understand why you want this if you're still marking t=
he desc
> > > > > invalid.
> > > >
> > > > The key point is that as long as we read the desc from txq, the des=
c
> > > > should be either put back to txq again or publish it in the cq (for
> > > > application to keep track of this) at this point. Or else, the
> > > > application will lose track of this desc, which breaks the whole
> > > > logic.
> > >
> > > Yes, makes sense!
> > >
> > > > > > +
> > > > > > +                     xs->tx->invalid_descs++;
> > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > +                             xs->drain_cont =3D false;
> > > > > > +                             err =3D -EOVERFLOW;
> > > > > > +                             goto out;
> > > > > > +                     }
> > > > >
> > > > > I also don't understand why you want to return -EOVERFLOW again? =
Why not
> > > > > (quietly) swallow these invalid xp_mb_desc from the previous pack=
et and move
> > > > > on?
> > > >
> > > > This particular desc is really one of overflow cases, right? We sho=
uld
> > > > warn users to handle this with this error code.
> > >
> > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > The part where you set drain_count=3Dtrue will -EOVERFLOW. Then this
> > > remainder will also return -EOVERFLOW?
> >
> > Right, my intention is to alert users twice under this kind of
> > circumstance. We silently drain the remaining portion of the skb the
> > second time, which looks a bit strange, doesn't it?
> >
> > >
> > > But let's maybe step back, what's the expectation on the user
> > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > shorter packet (at the current prod index), right? And then your
> > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> >
> > People would be aware of the skb that is too big to handle when
> > receiving two times of overflow warning. To put it in a simpler way,
> > the second time in xmit path only handling the remaining is enough, no
> > more descs that belong to another skb should be taken care of.
> >
> > If the user is able to quickly react to this case, I think the whole
> > skb should be re-put into the txq again instead of adding the
> > remaining part. I'm not so sure if I interpret the "break" correctly
> > here.
>
> Let's say the user puts a packet with too many descriptors. We find that
> mid-way and return -EOVERFLOW. What is user supposed to do with that erro=
r?
> In my mind, the user should drain TX ring completely and start posting
> shorter packets. You seem to be trying to handle the case where the user
> leaves the remainder of the previously EOVERFLOW'd packet in place, why?

Good point. I think now I understand what your opinion is here:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3b604776f09f..72d05a1fb0b5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)

                        xs->tx->invalid_descs++;
                        xskq_cons_release(xs->tx);
-                       if (!xp_mb_desc(&desc)) {
+                       if (!xp_mb_desc(&desc))
                                xs->drain_cont =3D false;
-                               err =3D -EOVERFLOW;
-                               goto out;
-                       }
                        continue;
                }

Then as long as we have enough budget, we silently handle the whole
big skb and then continue with the rest of the skbs in txq. Users will
be alerted by the counter of invalid_descs. I think that is what
you're asking, right?

Thanks,
Jason
