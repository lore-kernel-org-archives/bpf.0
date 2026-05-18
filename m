Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648B2BEFFD
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116073; cv=none; b=F+2TMwBOZw1y0X6X7La7voVbpxKGl1Xlv4fegaK0mRupEG0dwTv0ARc/3xXQVQwYENuQEm40400mRuAodyd6Mzzobnr7nrC4FasCJFw5C0FrgrNnxOXRcPOCubIkmJ4qsrzbv2j1EIz/PJxISw6XFmM7LtYGorh3FTD07B8kIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116073; c=relaxed/simple;
	bh=0hNpcKFFPUeeY8mvNc8d+Furck1M+6yn4y5f78ZljG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9BSIa36hfa+dwrxATCjFzxMsGe+RK69RY3V1Ud1msphZqMrnjvjBOsdpOf4/sHIT22YYOk4D3f/V3z57ihh0WH41CbDWvsw1JEQcPadEvGFMBtpx4yqxQ1sdNfwuE2o5PGbaCbVKEr7pj6O8AJvrzPn+/UJqb2L7u2L1vanqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLCFccEt; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLCFccEt"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-651c366f7efso2525347d50.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779116071; x=1779720871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c0dfQ7Wr8JZMajT0PBZM7edBivQd6TDRFDvTIsxG1qg=;
        b=mLCFccEtbfVYAyhGY6YYh7xqeUg1akP7dse6zMWJCu2L7YFFjJAqXYbmv7yDVbjdZ6
         1ARZDVF9kLxQoVcJD9BzNvv38S7ZDRg4J03b439PGLoN77J56D2DG9GDjpQXPw9m7xb8
         baKkW4Bzkrq4qniWEBH/IuA+INSXvCP8XzXWJOR8F8jkEdlCiEYzAI6DWxBrbRoqCDLC
         +cZS+VDQ05dqREcWckwmrnvuWZ0NcUSoSgVnOAbGmZyLodIAebNS6N6DgU4LnFkD9ppI
         uKYPi8ooDCmmtkHe/A9w+AIw1Y+9QPY0fOnKP7WW4xc7QfgaOSBkr2Dymd/cZZBDw8Yh
         DxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116071; x=1779720871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0dfQ7Wr8JZMajT0PBZM7edBivQd6TDRFDvTIsxG1qg=;
        b=VK3ogC7jqKal2Ein/k5Shpu1AO7pFB+2yEtsjvXb29/k46Nn2b+f8JmWBa0UXne7fJ
         HSw3HQrXtx6+dhRZUPrBRBDuo2fue5mbPLrQ28Hy9qIC7yLsLtJYmdhD4gfz+LXsM8i7
         +yf8dsWU5Vj4r9cOCKbMJHqB+mr1Qk/TSWvzca7jYTURF62J3JkOerYmOU/kOP+S49r+
         nlkVPmFCkpr8hzk5BKH4FlBJp9Om6EjHoCDvklrX1CB6MBJMGqkDFgVEc7M5f8YrvTf5
         LilaPMp4I26G3DeATQBPRFHp9Dm+CLaWHOxdcGf7sC3mBB5epEnqERg5k6KPMHP8PDI3
         mgMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yurXIf3kAuqW6AYuz2Vsa/kE4A324Jw3+0N5EG+qtT4fDicmBODh7WDXq0BI5eKxeatw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqv+gCVHnD8Ftj+EODEMORqB4bY1cky3YFma7kuGnyuiMXOhH
	jRHJ7AJHAHvOZIzvo24gtadcrg5dHWMRFdQIaSJ/as/KzXy2a6jumHLr
X-Gm-Gg: Acq92OEvIuFqs6m7J9galpgmRX/Usvvco0o00ArhnHlTt332Xc+FzVRF5moHoB8W+QV
	BDreO/mPKjyKTHooqwSKGwmZvtuPORLz4qw8oUvwYMdYvYRx5ET2UO3ONPrUqk8Lfi/0LsZXFl5
	sY7q2Y35nkCuupq2OS5HChHIAF0p9fUFjEJAfX35Ok79mIY71Zuu3adUfRJuk3PirQFL0G+XQAL
	yt77xh6iUmbZTyIhOdl+Knk58FY1tlrEqWKMyf1DS5abY+uOxc3oHubnoX5LMItbsNApryn4PRf
	8MtisQ6JFmTSWqWkRTuyj7BdXS3h5pNKO68jPq0Vv/FXHGZkIW2AlXsEaI3eZqhEG+5T+Thwxzh
	FjlbGhtEyg9IlY0DAmpVQq8xRjyFWdbjaPLQJFopw8kKBwaVWBqCNw4E9IuguoEOU9uEI7ulh+Q
	hT/HooQUs1GjqnjGbG
X-Received: by 2002:a05:690e:c4c:b0:65e:3df3:1c30 with SMTP id 956f58d0204a3-65e3df3218fmr8960255d50.7.1779116070571;
        Mon, 18 May 2026 07:54:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0aa51sm6466044d50.12.2026.05.18.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:54:30 -0700 (PDT)
Date: Mon, 18 May 2026 07:54:29 -0700
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
Message-ID: <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
 <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
 <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
 <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
 <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>

On 05/16, Jason Xing wrote:
> On Fri, May 15, 2026 at 11:41 PM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/15, Jason Xing wrote:
> > > On Fri, May 15, 2026 at 8:29 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 05/14, Jason Xing wrote:
> > > > > On Thu, May 14, 2026 at 12:27 AM Stanislav Fomichev
> > > > > <sdf.kernel@gmail.com> wrote:
> > > > > >
> > > > > > On 05/10, Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > > > > > only the current descriptor is released from the TX ring. The remaining
> > > > > > > continuation descriptors of the same packet stay in the ring. Since
> > > > > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > > > > leftover frags and misinterprets each one as the beginning of a new
> > > > > > > packet, corrupting the packet stream.
> > > > > > >
> > > > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > > > > > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > > > > > descriptors one at a time: each gets a normal CQ reservation (with
> > > > > > > backpressure), its address is submitted to the completion queue, and
> > > > > > > the descriptor is released from the TX ring. When the last fragment
> > > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > > > > > function returns -EOVERFLOW so the next call starts with a fresh
> > > > > > > budget for normal packets.
> > > > > > >
> > > > > > > This reuses the existing CQ backpressure and budget mechanisms, so if
> > > > > > > the CQ is full the function returns -EAGAIN and userspace drains the
> > > > > > > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> > > > > > >
> > > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  include/net/xdp_sock.h |  1 +
> > > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > > >  2 files changed, 23 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > > index 23e8861e8b25..1958d19d9925 100644
> > > > > > > --- a/include/net/xdp_sock.h
> > > > > > > +++ b/include/net/xdp_sock.h
> > > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > > >        * call of __xsk_generic_xmit().
> > > > > > >        */
> > > > > > >       struct sk_buff *skb;
> > > > > > > +     bool drain_cont;
> > > > > > >
> > > > > > >       struct list_head map_list;
> > > > > > >       /* Protects map_list */
> > > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > > --- a/net/xdp/xsk.c
> > > > > > > +++ b/net/xdp/xsk.c
> > > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > > > > >                       xs->tx->invalid_descs++;
> > > > > > >               }
> > > > > > >               xskq_cons_release(xs->tx);
> > > > > > > +             if (xp_mb_desc(desc))
> > > > > > > +                     xs->drain_cont = true;
> > > > > > >       } else {
> > > > > > >               /* Let application retry */
> > > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > > > > >                       goto out;
> > > > > > >               }
> > > > > > >
> > > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > > +                     unsigned long flags;
> > > > > > > +                     u32 idx;
> > > > > > > +
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > > > > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> > > > > >
> > > > > > Not sure I understand why you want this if you're still marking the desc
> > > > > > invalid.
> > > > >
> > > > > The key point is that as long as we read the desc from txq, the desc
> > > > > should be either put back to txq again or publish it in the cq (for
> > > > > application to keep track of this) at this point. Or else, the
> > > > > application will lose track of this desc, which breaks the whole
> > > > > logic.
> > > >
> > > > Yes, makes sense!
> > > >
> > > > > > > +
> > > > > > > +                     xs->tx->invalid_descs++;
> > > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > > +                             xs->drain_cont = false;
> > > > > > > +                             err = -EOVERFLOW;
> > > > > > > +                             goto out;
> > > > > > > +                     }
> > > > > >
> > > > > > I also don't understand why you want to return -EOVERFLOW again? Why not
> > > > > > (quietly) swallow these invalid xp_mb_desc from the previous packet and move
> > > > > > on?
> > > > >
> > > > > This particular desc is really one of overflow cases, right? We should
> > > > > warn users to handle this with this error code.
> > > >
> > > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > > The part where you set drain_count=true will -EOVERFLOW. Then this
> > > > remainder will also return -EOVERFLOW?
> > >
> > > Right, my intention is to alert users twice under this kind of
> > > circumstance. We silently drain the remaining portion of the skb the
> > > second time, which looks a bit strange, doesn't it?
> > >
> > > >
> > > > But let's maybe step back, what's the expectation on the user
> > > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > > shorter packet (at the current prod index), right? And then your
> > > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> > >
> > > People would be aware of the skb that is too big to handle when
> > > receiving two times of overflow warning. To put it in a simpler way,
> > > the second time in xmit path only handling the remaining is enough, no
> > > more descs that belong to another skb should be taken care of.
> > >
> > > If the user is able to quickly react to this case, I think the whole
> > > skb should be re-put into the txq again instead of adding the
> > > remaining part. I'm not so sure if I interpret the "break" correctly
> > > here.
> >
> > Let's say the user puts a packet with too many descriptors. We find that
> > mid-way and return -EOVERFLOW. What is user supposed to do with that error?
> > In my mind, the user should drain TX ring completely and start posting
> > shorter packets. You seem to be trying to handle the case where the user
> > leaves the remainder of the previously EOVERFLOW'd packet in place, why?
> 
> Good point. I think now I understand what your opinion is here:
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3b604776f09f..72d05a1fb0b5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> 
>                         xs->tx->invalid_descs++;
>                         xskq_cons_release(xs->tx);
> -                       if (!xp_mb_desc(&desc)) {
> +                       if (!xp_mb_desc(&desc))
>                                 xs->drain_cont = false;
> -                               err = -EOVERFLOW;
> -                               goto out;
> -                       }
>                         continue;
>                 }
> 
> Then as long as we have enough budget, we silently handle the whole
> big skb and then continue with the rest of the skbs in txq. Users will
> be alerted by the counter of invalid_descs. I think that is what
> you're asking, right?

Yes, this resolves one part. But the larger question still stands:
why do this tracking at all? Why can't we clarify in the documentation
that the user is responsible for flushing tx queue completely after
EOVERFLOW? What am I missing?
