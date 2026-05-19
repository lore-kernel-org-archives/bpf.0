Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435931AA9B
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225448; cv=none; b=sCT0j8EGNZC8u4D8lnDdaogSLU1rAn8Q6BFippHJqm3BFNger9AykoMYk5/YXAO9q7YTiMkuAPoV68v49NuHvIMBo6awcv+Vcxt4EGDj6eitHPO06DNC1Sdqd0SMl/nXCxygQ9N8MEAW24ZWoRfqXgunj4TfI2yCTGk3ZTmTwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225448; c=relaxed/simple;
	bh=2REmvrAXKMB6S9EvuO/GNs1DZlt6MkdC/XcjUjCs5x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOwaP1xYSn6gG21IMUxoI1e3c6ordDRAj13/myUyysYVqdF7jZI/xRb8+09Aohvtd9iJMwFNQtGb9hUaFlasUGvTElSwwCrGwkrVVSQp8q9FT/eYkUJzGHTglLhfS+MDWtUqrCVghJrwtjFLK+bwB8Nma4cRiN6xIjBAhw28w1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knN7IPPs; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knN7IPPs"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so2564692a91.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225446; x=1779830246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x78gjIbpZ2kUjlXijmMSEm0FunC0b0itFqesbdBFIKI=;
        b=knN7IPPsVJ4Rp+DJrQPWnP+oMurK6i+Rayip7wYH4eMfEnh7XhnLUTwaVd1OcExEAC
         2yWjuUvywRJsvjDhXluZL/LgHqsG1XH0W2fzzwQeOw0Pxt4+PchyCjXV1xn9VvLCwtiu
         OEDKQ/TUqP25qEXOachgCgN9h4hfUlyDYniGWb4SELVpFsvscxlqg/dWjBsEbyid237X
         L5I6EwCIMSyjuTmtKcGPeDhFRQk3oXKCRA/2+yNGWH9EGXBITP93d03/499PDdvyshl3
         rEp/fDjfvYRr0HkiRDfFiGwpGUITk0HwDQj/qFha+HWq5cpJz5UuG/I7M545b1cWX64e
         ZGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225446; x=1779830246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x78gjIbpZ2kUjlXijmMSEm0FunC0b0itFqesbdBFIKI=;
        b=oz9E+Ng2pszKcmFaYSLfxEYL3lWPWrnRM5JH1UUbo2PXSkIwR3QikpG3jG0eo3wlyF
         pjSP+8oFELIkX87Ds7d+JAQsnlCfY4gGYTGcfm8oT+gVTWD0/a/PPW30Xt+/1ojgrxX7
         f+izwvO5ZQUIKg0sCDFvXGidW1Fo4qUaMbFjl8zGIuOdeZJoWSmLZFEY791JtHmFgueC
         2hpHuMHiiRWx4NIt+evrO/jJlMsBcsY2UrLgAxWqugTO7y9EWn+AjV8WWTdUwj/7s6sW
         b88BuZoP10ZZ19FleN2FImLyO4vLXimX+lx4ahEwZ1JBqyFDTfwxtEQSE+MIN92deAvj
         oKvg==
X-Forwarded-Encrypted: i=1; AFNElJ/fX6I4BLtJRlcMRx6w/rmGIx6p1CGj2xTIdgdJC7MLnGNVqoQ1WJwB8S9S2X2x1eFwlbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKEyiCdr/iRgo6SsdJ7klQ3885hCFAW/f+whd09iYHTGGpUGI
	ERxHySWAMGWxK6N7LtL9gzFsuiPZ++ZukOrbR1mPFLr9lbIdVGhSyNoELrdIvcbM
X-Gm-Gg: Acq92OEHQgwQittTUpJCBjfKcuoIHguTZJ7EFOokqela6plY2CDWPnavFNafuky3wEF
	hb/hek4LcZ2gmJVBUOKFVTD+qY/3/TMjcMzs/46BITBOTNrivoGnORGYa2e7ky53G9hRxwAgqQb
	sYkaSJTQEq/t41BmeBMOrTdfEkaa1bBOPXKbo98TsYc3EH+cKeH8RNsGTg64gEoEsmJIaEK8FDy
	jsa5YT5xi8AzurHOeZ0FjyaWmTVIBFDdjjEuD2+jMsSrDC3Nmb7Je/RXtPzA9t9vEPIEv6BPeuY
	fa6UTBZn7l5oYEylteuEumVLWquY2JaPD1W7D8O6aD3Qzn5iEjU2jfbqf+qIOUm8eQ0wGNh7Jx4
	jeHtfGBgwcgaMSqJKX9hC/Vfm/9UOEh8QBHO5NyBPKMu74FVdSlcSs/YXhccqigpSPmaG534SfL
	JBNaIU/kg2R2VBAGk9/54oYNDYBWrd8qIxobi/UA==
X-Received: by 2002:a17:90b:5688:b0:369:a9e8:dbf5 with SMTP id 98e67ed59e1d1-369a9e8dc51mr11555705a91.3.1779225446231;
        Tue, 19 May 2026 14:17:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148d53asm15076395a91.15.2026.05.19.14.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:17:25 -0700 (PDT)
Date: Tue, 19 May 2026 14:17:25 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Message-ID: <agzTUUCHT_4PG5uA@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
 <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
 <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
 <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
 <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
 <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
 <CAL+tcoD8dtua=ErG63Rn1xNhhWGx=RY-FLa2_rcH78k_Fy7=qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoD8dtua=ErG63Rn1xNhhWGx=RY-FLa2_rcH78k_Fy7=qg@mail.gmail.com>

On 05/19, Jason Xing wrote:
> On Mon, May 18, 2026 at 10:54 PM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/16, Jason Xing wrote:
> > > On Fri, May 15, 2026 at 11:41 PM Stanislav Fomichev
> > > <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 05/15, Jason Xing wrote:
> > > > > On Fri, May 15, 2026 at 8:29 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > > > >
> > > > > > On 05/14, Jason Xing wrote:
> > > > > > > On Thu, May 14, 2026 at 12:27 AM Stanislav Fomichev
> > > > > > > <sdf.kernel@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On 05/10, Jason Xing wrote:
> > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > >
> > > > > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > > > > > > > only the current descriptor is released from the TX ring. The remaining
> > > > > > > > > continuation descriptors of the same packet stay in the ring. Since
> > > > > > > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > > > > > > leftover frags and misinterprets each one as the beginning of a new
> > > > > > > > > packet, corrupting the packet stream.
> > > > > > > > >
> > > > > > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > > > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > > > > > > > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > > > > > > > descriptors one at a time: each gets a normal CQ reservation (with
> > > > > > > > > backpressure), its address is submitted to the completion queue, and
> > > > > > > > > the descriptor is released from the TX ring. When the last fragment
> > > > > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > > > > > > > function returns -EOVERFLOW so the next call starts with a fresh
> > > > > > > > > budget for normal packets.
> > > > > > > > >
> > > > > > > > > This reuses the existing CQ backpressure and budget mechanisms, so if
> > > > > > > > > the CQ is full the function returns -EAGAIN and userspace drains the
> > > > > > > > > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> > > > > > > > >
> > > > > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > > > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > ---
> > > > > > > > >  include/net/xdp_sock.h |  1 +
> > > > > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > > > > >  2 files changed, 23 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > > > > index 23e8861e8b25..1958d19d9925 100644
> > > > > > > > > --- a/include/net/xdp_sock.h
> > > > > > > > > +++ b/include/net/xdp_sock.h
> > > > > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > > > > >        * call of __xsk_generic_xmit().
> > > > > > > > >        */
> > > > > > > > >       struct sk_buff *skb;
> > > > > > > > > +     bool drain_cont;
> > > > > > > > >
> > > > > > > > >       struct list_head map_list;
> > > > > > > > >       /* Protects map_list */
> > > > > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > > > > --- a/net/xdp/xsk.c
> > > > > > > > > +++ b/net/xdp/xsk.c
> > > > > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > > > > > > >                       xs->tx->invalid_descs++;
> > > > > > > > >               }
> > > > > > > > >               xskq_cons_release(xs->tx);
> > > > > > > > > +             if (xp_mb_desc(desc))
> > > > > > > > > +                     xs->drain_cont = true;
> > > > > > > > >       } else {
> > > > > > > > >               /* Let application retry */
> > > > > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > > > > > > >                       goto out;
> > > > > > > > >               }
> > > > > > > > >
> > > > > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > > > > +                     unsigned long flags;
> > > > > > > > > +                     u32 idx;
> > > > > > > > > +
> > > > > > > >
> > > > > > > > [..]
> > > > > > > >
> > > > > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > > > > > > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > > > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > > > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> > > > > > > >
> > > > > > > > Not sure I understand why you want this if you're still marking the desc
> > > > > > > > invalid.
> > > > > > >
> > > > > > > The key point is that as long as we read the desc from txq, the desc
> > > > > > > should be either put back to txq again or publish it in the cq (for
> > > > > > > application to keep track of this) at this point. Or else, the
> > > > > > > application will lose track of this desc, which breaks the whole
> > > > > > > logic.
> > > > > >
> > > > > > Yes, makes sense!
> > > > > >
> > > > > > > > > +
> > > > > > > > > +                     xs->tx->invalid_descs++;
> > > > > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > > > > +                             xs->drain_cont = false;
> > > > > > > > > +                             err = -EOVERFLOW;
> > > > > > > > > +                             goto out;
> > > > > > > > > +                     }
> > > > > > > >
> > > > > > > > I also don't understand why you want to return -EOVERFLOW again? Why not
> > > > > > > > (quietly) swallow these invalid xp_mb_desc from the previous packet and move
> > > > > > > > on?
> > > > > > >
> > > > > > > This particular desc is really one of overflow cases, right? We should
> > > > > > > warn users to handle this with this error code.
> > > > > >
> > > > > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > > > > The part where you set drain_count=true will -EOVERFLOW. Then this
> > > > > > remainder will also return -EOVERFLOW?
> > > > >
> > > > > Right, my intention is to alert users twice under this kind of
> > > > > circumstance. We silently drain the remaining portion of the skb the
> > > > > second time, which looks a bit strange, doesn't it?
> > > > >
> > > > > >
> > > > > > But let's maybe step back, what's the expectation on the user
> > > > > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > > > > shorter packet (at the current prod index), right? And then your
> > > > > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> > > > >
> > > > > People would be aware of the skb that is too big to handle when
> > > > > receiving two times of overflow warning. To put it in a simpler way,
> > > > > the second time in xmit path only handling the remaining is enough, no
> > > > > more descs that belong to another skb should be taken care of.
> > > > >
> > > > > If the user is able to quickly react to this case, I think the whole
> > > > > skb should be re-put into the txq again instead of adding the
> > > > > remaining part. I'm not so sure if I interpret the "break" correctly
> > > > > here.
> > > >
> > > > Let's say the user puts a packet with too many descriptors. We find that
> > > > mid-way and return -EOVERFLOW. What is user supposed to do with that error?
> > > > In my mind, the user should drain TX ring completely and start posting
> > > > shorter packets. You seem to be trying to handle the case where the user
> > > > leaves the remainder of the previously EOVERFLOW'd packet in place, why?
> > >
> > > Good point. I think now I understand what your opinion is here:
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 3b604776f09f..72d05a1fb0b5 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >
> > >                         xs->tx->invalid_descs++;
> > >                         xskq_cons_release(xs->tx);
> > > -                       if (!xp_mb_desc(&desc)) {
> > > +                       if (!xp_mb_desc(&desc))
> > >                                 xs->drain_cont = false;
> > > -                               err = -EOVERFLOW;
> > > -                               goto out;
> > > -                       }
> > >                         continue;
> > >                 }
> > >
> > > Then as long as we have enough budget, we silently handle the whole
> > > big skb and then continue with the rest of the skbs in txq. Users will
> > > be alerted by the counter of invalid_descs. I think that is what
> > > you're asking, right?
> >
> > Yes, this resolves one part. But the larger question still stands:
> > why do this tracking at all? Why can't we clarify in the documentation
> > that the user is responsible for flushing tx queue completely after
> > EOVERFLOW? What am I missing?
> 
> Previous and current (v3 as you may notice) impl always silently
> handle the overflow packet which means kernel never returns -EOVERFLOW
> back to the userspace and users have no way to receive this signal and
> stop sending more overflow packet.
> 
> Another point is kernel should be capable of tackling this overflow
> issue separately without considering how users would do after
> realizing the problem.
> 
> The v3 patch doesn't change any pre-set behavior of xmit path but only
> publish the desc into the cq.

SG, will take a look at that, thanks!
