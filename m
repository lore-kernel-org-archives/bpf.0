Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05326ED37
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804997; cv=none; b=dIRgG3e1qpzzrR2MkJlkDiBD4s7nj/6oN+6p+akaFejaWVCbV83TguCjJ9JppYKCx+d5Tg4X8N1VCobJ6UQZ1Dbc9ZwE6lHX/z0Guvyrhp8je5LkYvXhuEGjDXQZO4bJHWDuLPZJa0+KvholZbBlFqWx6SGMTx0SYlusVgSiUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804997; c=relaxed/simple;
	bh=kZm9COSlCKdfslmMh5PXM3Wbkw9ISu9run4sglfSr4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcBqSt6psAzzKWEO3G5xxu7dpFhYwgb5J5rf8hTozq3zS6wq+CYqtS+NAkWEE8fWEL2CzenbHjqxIspbzu3m266y4eW+qwu31Wq/9LgnCri3oGddd9iDphL/JPuKH+qsW+zqv5O3/aTd7NglHO4DksfVqgFSEbQkATapTmnSUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWrxrQVC; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWrxrQVC"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b9ea536877so2349995ad.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778804995; x=1779409795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Luj1/Ld5Y7QK3m1ZU7RiCeSFxxPOLPoPPrLfowkBg+M=;
        b=FWrxrQVCZCrEmKSafIp4awLFGnPYBEWaawzw30biweUlvea9lO3iRcKbLGgbJUHt1j
         vn03bDmyN59e5tJk0oK5HO7gurYv15IWqwtoea0SjF8B4XLUO+ZIZdZD6ynRYfi7u6ix
         oEy6IRGiFdycV4spgARaRKCfmtg/l8n2tojG1UgWrEdxBX3mimfCWGENYhyUO0SI+yTZ
         +TJbYejlAoiAjkD7LxmUaWSo6wu/2/dD9x4P+/Dc1avTkCThLMRQvyWHRZn8K1sG3Ubt
         VyQ2JsxEWe2eUcvCypAt9f17DaumGT5ev1DLDxlWGr7Mb2dr2EvFbpRvKMTUkGy0//gY
         IPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804995; x=1779409795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Luj1/Ld5Y7QK3m1ZU7RiCeSFxxPOLPoPPrLfowkBg+M=;
        b=JSJK7ci/onFrXuMes3bSqS2eCVkytqHfM8dUVmZtXTSxoJzwba9S0IGb6S4pJiocAX
         TjU63lIc+4Iizb220GtMcSF0BqFxmfp/0RaDQt2Zwa9GejKI/JfsWAcMMDwjMFev2lqO
         QANmsV/6mdPQxk3jZGsVyHzbhL7s1uivBvHBNHbiuSUS5keZbJ/5ZVg5CjOTLpTszqA+
         vCAq2y4GC4z8pS1pqsku1rItoyxHOWqLoV2W/0NWGtTlebYzCnumUtTrct66QJUXGaTb
         LLh/2FjGHeTHyCjC1LmP5QgDZkqpPkWKvtukh4q8qJru7KQ9LZWyHGrNSO3nmFIrr4Xg
         d6PA==
X-Forwarded-Encrypted: i=1; AFNElJ8k0sv5WaSO35QfXbyAXnFo+jTv80UEk/f/xyCJdK3uRmQmExufiRm2uFfpTiQzpO4vOKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9QSc9S2bgsqlHJtmgk8tMvYdCpj5xcbJiQ8KdobUiFiipUFO
	1Jklzvf5dqoQR0orrEf8dmBWBmxlQHgUzCVUVqZh3+PrfsIosTsJ6wqg
X-Gm-Gg: Acq92OFaiIL/NPQ3Joo1pFCwOwZWlvIB9hrkbxxSCxe2ZuoSO881uHICnNtiqdl2auJ
	vZjk0dG491dmGcymU6CI/Cxpnq75wApIz2Is01DNHBNepzbmZcKepE86WQb+skOMxqyOKUG9lDA
	18prpNWzEpXyuUjFystYwHA73uglusa+r3HglWILF7wihbqJ8znuo1epg9fbbQ5s8lCtzWc9cmj
	OWfh/QlMP6pdnz3RZl5iL1giD1fI+GE/HRUu2hXAbtzOfETpwXJdBmAmNL3wMjoF2ike04Qa1s6
	0B0ejNwCwSN7eOivfWPPctDQlOm/u3aGbQP4J92Msej5P+7V+0+S4hxqUrS3a6k/hk0donbHPqV
	ReDjZoW4WNcl7U2B9wjz2o3wLekB8Jl8QoYoz8+NTxRNyDTgN1POXidvTIf4DKQy+98xsFhR2oW
	TmqjBqMdc+nf7uinvZ
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id d9443c01a7336-2bd7e7f4367mr13756565ad.4.1778804995147;
        Thu, 14 May 2026 17:29:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0605ddsm36698195ad.32.2026.05.14.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:29:54 -0700 (PDT)
Date: Thu, 14 May 2026 17:29:54 -0700
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
Message-ID: <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
 <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>

On 05/14, Jason Xing wrote:
> On Thu, May 14, 2026 at 12:27 AM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/10, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > only the current descriptor is released from the TX ring. The remaining
> > > continuation descriptors of the same packet stay in the ring. Since
> > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > leftover frags and misinterprets each one as the beginning of a new
> > > packet, corrupting the packet stream.
> > >
> > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > descriptors one at a time: each gets a normal CQ reservation (with
> > > backpressure), its address is submitted to the completion queue, and
> > > the descriptor is released from the TX ring. When the last fragment
> > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > function returns -EOVERFLOW so the next call starts with a fresh
> > > budget for normal packets.
> > >
> > > This reuses the existing CQ backpressure and budget mechanisms, so if
> > > the CQ is full the function returns -EAGAIN and userspace drains the
> > > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> > >
> > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/net/xdp_sock.h |  1 +
> > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index 23e8861e8b25..1958d19d9925 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > >        * call of __xsk_generic_xmit().
> > >        */
> > >       struct sk_buff *skb;
> > > +     bool drain_cont;
> > >
> > >       struct list_head map_list;
> > >       /* Protects map_list */
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 3f1e590c855d..232dd7126905 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >                       xs->tx->invalid_descs++;
> > >               }
> > >               xskq_cons_release(xs->tx);
> > > +             if (xp_mb_desc(desc))
> > > +                     xs->drain_cont = true;
> > >       } else {
> > >               /* Let application retry */
> > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >                       goto out;
> > >               }
> > >
> > > +             if (unlikely(xs->drain_cont)) {
> > > +                     unsigned long flags;
> > > +                     u32 idx;
> > > +
> >
> > [..]
> >
> > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> >
> > Not sure I understand why you want this if you're still marking the desc
> > invalid.
> 
> The key point is that as long as we read the desc from txq, the desc
> should be either put back to txq again or publish it in the cq (for
> application to keep track of this) at this point. Or else, the
> application will lose track of this desc, which breaks the whole
> logic.

Yes, makes sense!
 
> > > +
> > > +                     xs->tx->invalid_descs++;
> > > +                     xskq_cons_release(xs->tx);
> > > +                     if (!xp_mb_desc(&desc)) {
> > > +                             xs->drain_cont = false;
> > > +                             err = -EOVERFLOW;
> > > +                             goto out;
> > > +                     }
> >
> > I also don't understand why you want to return -EOVERFLOW again? Why not
> > (quietly) swallow these invalid xp_mb_desc from the previous packet and move
> > on?
> 
> This particular desc is really one of overflow cases, right? We should
> warn users to handle this with this error code.

Right, but didn't we already return -EOVERFLOW to the user once?
The part where you set drain_count=true will -EOVERFLOW. Then this
remainder will also return -EOVERFLOW?

But let's maybe step back, what's the expectation on the user
when we return -EOVERFLOW? In theory, the user can re-submit new
shorter packet (at the current prod index), right? And then your
!xp_mb_desc logic will break/swallow/-EOVERFLOW it?

> >
> > Also, have you considered doing this drain in xsk_build_skb error path?
> > Is it more messy? Carrying this drain_cont across the calls seems a bit
> > too complicated (but idk, maybe the alternative drain in xsk_build_skb
> > is even messier).
> 
> Sure, it was my first version actually. One of the primary reasons is
> how to handle it gracefully when CQ is full? Then those descriptors
> can not be processed in this loop at this time and will be delayed
> until CQ has available slots. Another important reason is that I want
> to put the whole read process under the previous clear logic in
> __xsk_generic_xmit(). Some protections like budget/batch still take
> effect in this case. In this way, there is no strange/exceptional read
> process in copy mode :)

Agreed, given the fact that we need to handle prod backpressure, your
approach is good (but see above comment, we should probably clarify
what's the expectation on the user side).
