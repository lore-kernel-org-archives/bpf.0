Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3A3FBEB0
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491408; cv=none; b=Ty+n4Vm0azorJuwT28x4ZdglPxOJFkXf6VfMQnnH3ZC+zHooYmy+UNbXYyi3gDSyipsEY4/WQfG/f94kllHuQMX2G3o2NbjH7eYoHbSKJKJ5efblH8Hwn85OQZyDde6cIEl8UlkY2xnO5sULDpplZNnVLoJXSTfrIwnGZRv/OIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491408; c=relaxed/simple;
	bh=cHsycw6Dx/PvvgcoSTksoIIit6mKz6/9Xv9YLA3RYEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6S258RLC7x6K/etiQ+HpatKu1g9kRQu1zGrrWYbW74M1jem/BZt1jTuHv8sULq0obtehq3nwwMh7W4Cb6dJzQZvBXR4tlTPAMvYTLXamzWrHma7MChaiRwAZq+ROkAgr2sKoCApboW2ve7iuSIrWQfMddAhdKw5mK3NUvP1+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9U2onHz; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9U2onHz"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-37c6cb02587so100312a91.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782491406; x=1783096206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmvSZXf/ou0b678tcR/y6c76H9T2F/pNhOOOVYqn/aA=;
        b=Q9U2onHzSeDdr6/4Omm0icT039ESYXQe+d/7jidC5cmyeKXFf4XB+X6zvaNDm9/wJJ
         9LiVVLx+5iGUNZEVo0XDynsch9EBo0ktpR/6xhSkDciirQXGw/KYTN5tGuqlbwvhXnQB
         TZNuAxFk6PNVQaGt/XCns3o0SROoGxucAaexuGNjI/XJaFuHJX3YCDPk/KT5opZPasBN
         Q8RqLA4p5RfOGej+3t067xZ/+R2QVI/8aztkFQuNUaQOagzmN1K0QQCHL2tHzpGIccYa
         xCGIj4bFZUYZCalOsdTpY9/pHh+cnZoc4BMzqWMgjc+7Gd5jok9H24TLAtdPgR/vo4M6
         2+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491406; x=1783096206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmvSZXf/ou0b678tcR/y6c76H9T2F/pNhOOOVYqn/aA=;
        b=iCzXpJz7Ousiq6C3Z+uhsPsrRWMhh6EAyQI/BmD3+60TaSR9nSJYcnoNQzw5Q6ledH
         2cdowAAC+/HaJQr+nY7aNeVdIm/eBpgQzspmZHOmvVxKIzco1vweR18GOxC6GnZcP1rn
         Pj0H1RoN8zVgOUbuFHkdTeEf/hfPpjlaOiQ1OOyts8AXwk97OBLHlXb96AA/CLszxtFz
         uh6WkcBp8Ig4tXmwdHwE6Q9YDcx0XuFrIsJQ7fa8O6bIpvpwDEH46Y9joec/2iAxJ5Jz
         LEvCBoOU9wXeMTnXS4Q+41v4wl778yt1FGgXgYXjuvafpgMVr8eFJ/c6AL/OyHGpMzsr
         4LOA==
X-Forwarded-Encrypted: i=1; AHgh+RpnufCmnr2mTl2VIxQzQvP3VSjatUXfvh7xD1sjv1+Nb4LM64XuApcLCzj/0T+/E0wC134=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKb658y0KMmyObeVikEwjkjX/5yvwQSlMwtnVzEeYepHkk0Ou
	incW+lOemPyConuS10bHH2fY/ClXDa017N34TELpKq0sgUbHwdZvWMPA
X-Gm-Gg: AfdE7clYBe9UaPPGRsGnZHvAFMcu6tAJ39Nn3O5wbeOSMZRob57cb9BJ71ccegp3juj
	D5iSA0vy9s4ujFuvRo7gQWDZg7mIICi9jvm0If7acZeCfJjbufTLcvBSkA6Fw4bQI60bZ7aajn0
	RbOx5uDA0264+5Zd1ZlIlkItVppX4+BpnOrqn0KeBZ8vz3KZPVp/vCxQl3X+lqnzt/JLudto1dp
	Ir6aNgwGOVKkJaTW045/Z/G8TgqGZjpxI0Xk/Lq+IKHGletveRmH6gdNOFHlvzrDzXJCQpXW35Q
	hJuwtC7Snp94XUAZkBt3BILPzalCulYYDr5ZQtzVEPRtgpIGUpdSQXtzdTM+mqO8HkguNrt6L0N
	yuqh2xL43pGjuC991Z26lWVf8BaUp7gw0y16mMGs/xDJwkMIFrz91l0aHwzouPoKLbvSGGC0C+p
	I8VNjUmA==
X-Received: by 2002:a17:90b:388a:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-37f7a5578e1mr953048a91.7.1782491406246;
        Fri, 26 Jun 2026 09:30:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e132ac1dbsm1496221a91.5.2026.06.26.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:30:05 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:30:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <aj6n48QAqDP85_-Q@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
 <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
 <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
 <aj4tUMqAXmQskO6r@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj4tUMqAXmQskO6r@boxer>

On 06/26, Maciej Fijalkowski wrote:
> On Thu, Jun 25, 2026 at 09:05:28AM -0700, Stanislav Fomichev wrote:
> > On 06/25, Jason Xing wrote:
> > > On Thu, Jun 25, 2026 at 12:37 AM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > > Hi,
> > > > > >
> > > > > > This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> > > > > > consumed from the Tx ring are not consistently returned to userspace
> > > > > > through the completion ring when the packet is later dropped as invalid.
> > > > > >
> > > > > > The affected cases are invalid or oversized multi-buffer Tx packets in
> > > > > > both the generic and zero-copy paths. In these cases, the kernel can
> > > > > > consume one or more Tx descriptors while building or validating a
> > > > > > multi-buffer packet, then drop the packet before it reaches the device.
> > > > > > Userspace still owns the UMEM buffers only after the corresponding
> > > > > > addresses are returned through the CQ. Missing completions therefore
> > > > > > make userspace lose track of those buffers.
> > > > > >
> > > > > > The generic path fixes cover three related cases:
> > > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > > > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > > > > >   reports overflow;
> > > > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > > > >   packet, including the offending invalid descriptor itself.
> > > > > >
> > > > > > The zero-copy path is handled separately. The batched Tx parser now
> > > > > > distinguishes descriptors that can be passed to the driver from
> > > > > > descriptors that are consumed only because they belong to an invalid
> > > > > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > > > > address area and published in completion order, after any earlier
> > > > > > driver-visible Tx descriptors.
> > > > > >
> > > > > > The ZC batching path can also retain drain state when userspace has not
> > > > > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > > > > state local to the singular batched path, the series prevents a second
> > > > > > Tx socket from joining the same pool while such drain state exists.
> > > > > > During the singular-to-shared transition, Tx batching is gated,
> > > > > > pre-existing readers are waited out, and bind fails with -EAGAIN if the
> > > > > > existing socket still has pending drain state. This avoids adding
> > > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > > >
> > > > > > The last two patches update xskxceiver so the tests account invalid
> > > > > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > > > > still not expecting those invalid packets on the Rx side.
> > > > > >
> > > > > > This is a follow-up to Jason's changes [0] which were addressing generic
> > > > > > xmit only and this set allows me to pass full xskxceiver test suite run
> > > > > > against ice driver.
> > > > >
> > > > > There is a fair amount of feedback from sashiko already :-( So the meta
> > > > > question from me is: is it time to scrap our current approach where
> > > > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > > > half-consumed descriptor queues)
> > > > >
> > > > > Should we:
> > > > >
> > > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
> > > > > and do a full stop here)
> > > > > 2. now that we really know the number of valid descriptors -> reserve
> > > > > the cq space (if not -> EAGAIN)
> > > > > 3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
> > > > > locally, don't ever create semi-initialized skb)
> > > > > 4. construct the skb
> > > > > 5. xmit
> > > >
> > > > Yeah generic xmit became utterly horrible, haven't gone through sashiko
> > > > reviews yet, but bare in mind this set also aligns zc side to what was
> > > > previously being addressed by Jason.
> > > >
> > > > I believe planned logistics were to get these fixes onto net and then
> > > > Jason had an implementation of batching on generic xmit, directed towards
> > > > -next and that's where we could address current flow.
> > > 
> > > Agreed. That's what I'm hoping for. There would be much more
> > > discussion on how to do batch xmit in an elegant way, I believe.
> > 
> > This doesn't have to depend on the batch rewrite, we should be able to rewrite
> > this non-zc in net, this is still technically fixes, not feature work..
> > 
> > There was already a couple of revisions with this drain_cont approach
> > and every time I look at it feels like the cure is worse than the
> > decease :-( Obviously not gonna stop you from going with the current approach,
> > but these fixes feel a bit of a wasted effort to me (since the bugs keep
> > coming and we are piling more complexity).
> 
> Well this is my fault as I took Jason's patches as-is and did not realize
> Sashiko had issues with it. I *think* I got ZC side almost right so I'd
> like to have at least one last round with trying to make the generic side
> right...

You can have my ack on the series since I already did a few revisions
on the original series from Jason, but it is still a very low confidence
ack:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
