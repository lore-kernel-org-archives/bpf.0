Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE83FBB4E
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491407; cv=none; b=ANEbjSt1dV2B9uA7Z0yf0Atzor6k5uon8xA9wdoNkccyVoowC3zhGKz3J48TeylGdJ3PG0OA5rdOa3KvFiL91Vxd0bpYDaER2A2tZJG2qh3QOZHdK7Ces0+cEU2PfLxeBskf0qlx/AWD3MNpLHXPiekxZBBncyM+5CnTprpBB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491407; c=relaxed/simple;
	bh=toTWUZ9iNC7nG1ZtP7WDlr371fsTq7jI9H6/zCZ0eUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO6MwzvHlk49sK5rglHCSfpdViM9L6Ctz209svm9VQGb9VhRXhR/XYQiV6FdmHSW+t+aP7+yU18EiRgUqt28VLdubhQkMYY6rxpLgX+xVlR8NELtAKwLj/QTwEHQVbpX6tE9N2q74ScP0tqx48/DTNB3wRJzm5NMS1Mu3yT0xwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMY4Uklj; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMY4Uklj"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8453f568e84so1067281b3a.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782491405; x=1783096205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuV0G7qVvdLlZJucQHB+lRJcWvMriN5mYBInGvXRWR8=;
        b=LMY4Ukljruo8ft04XERnzLRzH+2vgzkgnXkT4/r6DiBAS08zIlLEgGBLjWFA/dB0An
         M1LHzNNugChIttUnoA2H9C2U6H1RbIk/2EGDi4Gp6mklIMHmxHzTKlgiKfRea4i6u0eS
         nxJSBwV1W3e3+fGGnj4ZXVylKwpw1ow2E3RYixbJYWx16zR5VS9WYzpNrjCkpRITINUm
         So3PT6N2nii5uZXDSBsMAOnSsv3EanFeoOIe515BTPTKOwy5gMsEb1GYjJbSfQ58W4E0
         RQAaN3mwSeFwp4mTnqGD0vP29HTX0UVMm4g/LCGL4seQ+bDXsZhGAArIrE5opCSQOiwO
         MJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491405; x=1783096205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuV0G7qVvdLlZJucQHB+lRJcWvMriN5mYBInGvXRWR8=;
        b=d+9jXKVFAs1jE/ozTQCVLCM6N3duH1TdP7z22q1/XJwKjsc6AYzemED34A/w2ICnjf
         +UQ0nYulSIiSCXoVqdclHeOTpK8AUWcbQ2tltTWNvWkaRStIKK4XsjWF4FasXOPQa3zg
         8ZR2MWaE+zgUYwLeatkJelucxlnwmkVzRV8GVrPl0705EaGbi/Q/jamyBB4WVAp0gtmb
         O2Sal3Gd0YX9v0G8ncNw3tQ6EiqgUuTNp659BhK0fmMyxmwD3dIC1XZYfcrXYZVU5Gi8
         ERIbktn/2gIkSanUJP8NbiPWDUfVKs8VN6FEMdIitezYsefd4cuvsefw3m4TT+Gwhmaw
         h3IA==
X-Forwarded-Encrypted: i=1; AHgh+RpSUGzmcx+nQrlTfFr/J0elcFrk2J3U8L0xIc7FJiy3ev+GGdXsBX5qVSDE+m7dXTS8CPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35hM6O5rkQUxtMyTsfwWo7KMtYWUzWZPwKGVlp6FosNXdR1JT
	eSxfToiud4xmgdjI6tCe5femmLoypetEbCI0XpY0uEIWeQQ8ANbmV2wG
X-Gm-Gg: AfdE7cnwQL4RC8vG09ayIaIonGBDkIuCKhTaZj3+pqEMOuCAHMkknKelv5ocw0epn4B
	yyRgLuZRYbTXO+DZ58RoebojksB8dWPrNk6hEK+Zl+YDspbEvkQViN9lwYu2Go7ij1R+w1aqEpb
	1sB9/QtNASQGOl3gLJ0MIGMhQfheZCFyTTjcjS6QnbcM729IdCovLhibmdqaCE4uDBYGuJZwrVn
	AIR+E/pgAx2j6gKFQJYMvw3QWrUIOC8xm9OXI8c/8203uJwCMBwUqnIPrF2bFzYB3O2DCVsAdBc
	ZEGSGG5oLXs9M+tfI683UJlFQKyF7tXGJvAkxYpM+hSeweuaOjS/kd1Iow/zFdy36Jtbm87RBnL
	4fLS0+LSIhuDeyUC655EfAStP0Yy/yk+nxIaJjSUbYPO6rRcfAxwA0lr4+T5/sVgauut0zPjcmJ
	gMN/zZrQ==
X-Received: by 2002:a05:6a00:22d3:b0:845:d274:bfa4 with SMTP id d2e1a72fcca58-845d274e643mr885786b3a.59.1782491405061;
        Fri, 26 Jun 2026 09:30:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fedaefsm7785461b3a.23.2026.06.26.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:30:04 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:25:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <aj6mr-cIcF2Tg73r@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
 <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
 <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
 <CAL+tcoDOFtTKavz8TWpU6BPrHCcL6TjY8xrmFA5y3P9Wn0T4ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDOFtTKavz8TWpU6BPrHCcL6TjY8xrmFA5y3P9Wn0T4ZA@mail.gmail.com>

On 06/26, Jason Xing wrote:
> On Fri, Jun 26, 2026 at 12:05 AM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
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
> I see your point, but rewriting is something that cannot be easily
> applied to the stable branches? Until now, we fix issues one by one
> which have an explicit target branch (because of the fixes tag). Cross
> fingers :(
> 
> Sashiko has the magic to find out the hidden bugs more than ever and
> AF_XDP is not the only place where a pile of reports are coming in.

net vs net-next is fixes vs feature work. If we can't fix the current
code, I think we can justify a rewrite using a better approach and
route it via net. This series is 7 patches anyway, it's not like
it is a quick short fix :-) But I'm ok with pushing it as it, I'm just
trying to see if someone on your side is fed up with that part as well
and wants to fix it "properly" :-p

> My take is that batch xmit has been appending too long and at least so
> far less and less bugs are found by sashiko. I believe if the mode is
> changed to batch xmit, there are likely to be new and challenging
> problems to discuss. I prefer to solve questions of the batch xmit
> series.

We can redo this part separately, without batching. Move from "read
one chunk at a time" to "pre-read all chunks". Batching vs current issue
are separate.

> BTW, would you both come to Netdev 0x1a next month? I believe we could
> sit around the table and discuss some future plans there (in xdp
> workshop?).
> https://netdevconf.info/0x1A/sessions/workshop/xdp-workshop.html

Yes, I plan to be there in person.
