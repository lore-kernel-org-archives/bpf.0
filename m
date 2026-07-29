Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157B29A32D
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299759; cv=pass; b=TvIzOX9BrE28MhDbkoiKbTNIDMPLr1uz4m+hXSnh31F1JH5hV8GTuOmv184szx0RN/GdY8jx3DLLlj6GlT9gU2aWCbZuLxSCoO1z9c1PHMUr3cAr0HZpDvnEt0gO96GPFbKDL6MKZWhYkFUmwB6uSlzalEUfrkqYBAVpyPebVNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299759; c=relaxed/simple;
	bh=eXxuZZCRR4m1SNx9TqLOQOAWhfwaZChlZDGtoBJUfDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMW7gXCHacpnTxII3fJ4/QxkfhaV5rIiMoH+DH0iiMBP7EfS1Qwsz6Y8BYMsinyhVO46EvhUWYMhx+/5O1uTm3smK82X+hhjbLq24INPZWy1W7HgxAUVRVrJKIGMLaaFNsXf9bJus1nmwxORpw54Y2WTDtJ+z8UdawCqON94zlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6A+vyeC; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6A+vyeC"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80dc4a68e4aso8074827b3.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 21:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785299757; cv=none;
        d=google.com; s=arc-20260327;
        b=gcfPLBTymz/V2IfohIFveOgdTitRTSg/+rJTEuDCy73IQ/uWQ/xMxTYY+mvzoMQR9Y
         bAK9izzO15e1QMjToJoXr7tZvDzUPpLARwQ6YujFe5+rU4ClhkbhUX5dzWS1Rowpg14v
         MVUH5QlcK7Uu2sIH7kHCEVnL690DN4MspMoitWgkZdZsqEJOQhBy86XHOMmFltgE229p
         pPlE4veDtPRsL/y9C2KzTHdul3uVp1f2Ve1AVLIpv+t+6UwOMv9KvdokhdTJoIW38P1W
         xrBOi4wnYs+eSApp3/miBPLqDzucXP3vl1QK9L8cr9LiS8PLcoeiZJlfIc6vfEmbb9zt
         QiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        fh=Pd45Y/OzAWW3l1XIeU2wJUFmjqp7t2Y5W8bcaRU3T/o=;
        b=V7N75gRLJlyUlwo/uXnf8SB/Vpqtk+EeoJb/gYFQUYsCP1c+GBX7BvAQYBUqmrgcR8
         5T9P1IWMV3pdbn/Ysz1p4GnPY3SCbQYWAEzXuJI0NjtrPKUUuHjTlrwWKL5Chcl7jAfF
         wG4pqi5koXRF6GLGgubk+sBEAV+h5WMc503XhzJRnKnJ8wwQ6y3OndQaOVuT2qHxpfOo
         jCjDroVGwq6PuaM0QidxAL8hdYOqAzAfvB/wt96hqs0CYwG5OCXHbPCx2RKud3qfKgdp
         vnKtUJ+ZBijlDZ4xYTQt3IU6tufnp5xzrf/3XWyFLj4lPM/oLvd0WjR4m5cgcMlYiy/2
         BnPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785299757; x=1785904557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        b=l6A+vyeCtZ5Vc77/EbmgNFgvlPrXl5+NoSac+IUW7nQV32Mrwgz0JzrO4BkFOQXYck
         EWHTwv76SqUcwVa3wgBQgFakN7DsD6l7pKqL3Yd/j2usjmHAKrPR7FGmrllYMd5dGi8a
         OyjSjAtKdwhHjQwiNVx56na6BJ5VlivPjvguFQSvcYQAVjNkmjBtO57kg/tXNrlb05PO
         GxDuINWPFEzyeniiv3Vsn/voZNYYgBKhWAKmQ+AolOYyGIlCaIR0ufxvIY2JRl2An6l9
         a14D6DXl6RZwtjkTdsJ/0Knpc8rQ0NFhRQ2Cjg6qPTyZyi9/wAejWC8FEnx87yPSro7+
         QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785299757; x=1785904557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        b=guvIO4dgYNHLB8rlwYrhaUVsu0H9ayOVYCE3ULKwHFtcGf+HFG6k8MidVghgrLtuqC
         DrPIRWkLsfR3qP9b+DtVfsNPfn7dr2T7QVA+98g5LXOHhUTWwsbFDRM0tKX2ylCalgAW
         ihC6qY5tOQ2ngUT+yIqt/b1gEosSVlij85e6cdJnVsqzF0jdXlXiFkGPFG7idBjriMJe
         yG4RRhJecE28enLUIHS6vj6Qgggrr22ybN2rZIk6BrGOd16K/sXf2WyTcuR9bDSbiX2e
         LTlFsQxP3xjR2XVkzu4saJU65Hn6I3JfCvcAcdDDd/e6h4YGtzb8c4X3pd7lUR/Zk0pr
         91XQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6ILzwJ5+83CiFbcB6/LNoJKKf6hoUlT52lvjsNxLPxwVCuZtExYTdea9Jdm5kU97Toss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jIp2cs2NjFoJokZrYfosd00MGBh8lnNXlIZlhbVJorVGaafu
	BBuUHWH/gAee8Kdd1jbM0pTtsCCM8z9HMQ0CqSjfILw9FgX18tB5DgnTh5j7eSLAz3i4oslf1Gq
	xhwpvwCdT14lxhYRl2JuTy7SJDfRcu1A=
X-Gm-Gg: AR+sD12fVv6tl05wsv+fOwJiZQ5j0plhOjTc/rUvoh6D8/7JVP5Iwymf9Vcl2UA6+mH
	GWZfNA/A/HEQ8RnSng8bag2JAinv2M7k1jORyFO2JVIjh3aJ/PfIYUugBSMNn4LlWIPusxc3ra0
	8BEbgu/VcFkMo/R1Tl9wOpRw7AMBvpt1cqlRhQGQaN7p5O+eaY2aXAQuaBVJkI7zofOuP9WorMC
	X22Hw1rJtUoZCCPbs2BxyA5u5XuDRqxVsrx/yjKq+zAbg4sSiP+IW11p2rhr196AeXxjqXorDfM
	mvtZlKMWsHcqUnkt8SxxQcYjwnir+3pdohe/GRPX0Y08YvAUlJg4VoOmEQhy2ay9VZsWoMsY+AK
	3ZLsVw1JkVo4r67IQj3g=
X-Received: by 2002:a05:690c:4d41:b0:81d:5155:213b with SMTP id
 00721157ae682-81f990adcdbmr25491617b3.14.1785299757024; Tue, 28 Jul 2026
 21:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-2-sun.jian.kdev@gmail.com> <amesUgTjM+4WvTkJ@boxer>
In-Reply-To: <amesUgTjM+4WvTkJ@boxer>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 29 Jul 2026 12:35:46 +0800
X-Gm-Features: AUfX_myQ6iay0D6KuhMY71cOqlREpxPTZjbUcUBLGVWUwA3h0jnwU10zyOyJWrY
Message-ID: <CABFUUZFfE86j8QVZoR6HSs1PsgLjxOB0=_hqBRwBaFbXKJKxXg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: fix skb length accounting after generic XDP
 frag adjustment
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	lorenzo@kernel.org, toke@redhat.com, matt@readmodwrite.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:07=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jul 26, 2026 at 08:25:34PM -0700, Sun Jian wrote:
> > Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> > XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copie=
s
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in ge=
neric mode")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel=
.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/core/dev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 5933c5dab09e..94204702cb02 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5517,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *sk=
b, struct xdp_buff *xdp,
> >       }
> >
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> >        */
> > +     skb->len -=3D skb->data_len;
> >       if (xdp_buff_has_frags(xdp))
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >       else
> >               skb->data_len =3D 0;
> > +     skb->len +=3D skb->data_len;
>
> hm that reads a bit weird to me. maybe we could follow the existing
> semantics and reuse @off ? that would be a nicer way to update ::len only
> by a delta.
>
> if we would stick with existing approach i would appreciate comment being
> more elaborative, where we could explain that it is simpler to wipe out
> data_len altogether from len and then just add it back.
>
> >
> >       /* check if XDP changed eth hdr such SKB needs update */
> >       eth =3D (struct ethhdr *)xdp->data;
> > --
> > 2.43.0
> >

Hi Maciej,

Thanks. I am reworking the length update around the delta and checking
whether the existing off can be reused. I am also validating the ordering
against the head/frag adjustment paths before sending v2.

Thanks,
Sun Jian
