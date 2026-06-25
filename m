Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D563E3142
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403549; cv=none; b=mB5k1kEJ3nQLGnjoGvBdza+0DHYzUCCi510mGF63ubnD+nX7zIrLEZA9hClzBm+hgZ4TCGAcYhzqa8rwbS15XawljLrVg73VBoC25kUEf2RTzRmRuz5JoqnT2ECrZngaqYLlPuKjExrXTp0Wozhh1iY89qTSoL392LsWFIaX/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403549; c=relaxed/simple;
	bh=HqA2syi3fWc1e8sLEbaM7wYJoTGSZDfwgwmK26oflkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqUxElIqwQSsgHcoY4NPGviQM2/EgMDiaZDFLwFYp8HOs/NC+7hHcX5N4GWkvR8Dsjd5/aElcQbKV+s1osky/PgwsDDFW1Jl3bYuZ3CY014kZELus46FQgt9S6b8qTbXZUvnhya7XWG7TvXkwiRjQe+YhSYnS33yB30duVe5WrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMvqr0q5; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMvqr0q5"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c7cfa17fedso818245ad.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403546; x=1783008346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXmRvL9EL1hwxlK3wjXlOdCXiCuQDXgSKjUEyrxUuTg=;
        b=LMvqr0q5GLgwhOom972umnLDit2Og7KGeRKAm2Ekh4KUssb3Txstp/3vzv8CZ3PcOA
         0cW/YS9UsQ3Q2Ut/sHKxbObUbyJKnyaoy8UWV/L1MGnNnri5pIkUJ9GH21RDWg1dVX2z
         fCXVRwgsh66KxvpKwi+hnvWdWsNbLUKeVAuroAq3bNO7g+iF78kTCbQm11nWU2bBQAOH
         qRLgWpoTW6N6qrBzTCgEHy26q2/GjDsE+gnHTBycbmB4NIC+ccGRAtfLV00RfCr3YtOH
         ZzZFkKnBVVbcrSngGw12Hvy4M29GPXyAG+a6qG9DGgz6hpbi1Ruxrsix6c4A7lkcXBPn
         2PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403546; x=1783008346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXmRvL9EL1hwxlK3wjXlOdCXiCuQDXgSKjUEyrxUuTg=;
        b=iwFERR+3VmVTwFzz6NJ6TdLCaSHh0y4KehLr+qIBzueD98ImNF00/PpZk5YWYXUS7t
         xOG8dhEn8IIAVxN4I/L1R1WNN4UNy7TiwJezO5rFf4Qb+hqKkazVza4DlwAITbvwJWTH
         XdC0cCpTdak0iqUPnIxZ58y5Dnzz7Ss3DOpzDOV3Krqs3w2J1R34eJGn52wddO/r9fzb
         FiH3F7/UVEmuDhwQn89Wcf2/cLf9PX92fQl6GUbRHrHnHYf+mJ+wfpnrNyrV9eDVGVtl
         xc/t1qr2OSlHBIN/sv5/V39vRv7WVR6J1QiA/Jrqt2cKpEmtyspWmhDuYURkFsFahmeO
         HtUA==
X-Forwarded-Encrypted: i=1; AHgh+RqyEMYhMJfOSubt30gwKorRWBf2dnuPCs9QiW79jzFKKfT2opSrKjzKDUU6tReuxxTZXRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQz9WAWX609XWh+z4Bfwmc3l5yjCgWqEn349Bsqjn/dFIlp2sW
	lrRN+AtsqjG7RMMAZ7dbl4qBYe9B+GNff6jBYSRDBfQMDoZM7+9iHFnL
X-Gm-Gg: AfdE7ckvwyhGMoU3gmhUNFOGlMEqSp9OF60JT/xQsLv2fI8kvUyBXpCkn+ovNWH4ijv
	xmiVGODO0sUmmTRv/t3Qu8e7/HxFAqR5cyzaUrc/1aFfYC2sTi6vQY7D4PuiiiU+ZAfwZk3zx/l
	DYKYYMqdKtYWQL3gEUNM+IZt1H7iL16RSWwMjr2bncTfTqko4cllV8UOFKY76xCHM6xuXLuyVdJ
	JkVaNJvFPaIsD/UoM7+B2nyXpA3khVrY/Bve/0g9SNedI9n1R1/poEgS/EhS8aQXXk4qqhFjhZL
	UolqXOwORpval/IKFXVanfDeWZ29gpAfwCS9Ic6IKlkMGvC/pXrsHvx0NA0P+sNq2fXnSAWiE+2
	O7dc74LgKOq4Ff5mFN5CyWGpXI4Rvl/bKhsCdrUomxKqhECwyIoaAxVizWpANl9Hj8ZMd6MUQPw
	yXE03ACw==
X-Received: by 2002:a17:902:f68c:b0:2c6:bb31:4564 with SMTP id d9443c01a7336-2c7fc88dfdcmr31945275ad.34.1782403545537;
        Thu, 25 Jun 2026 09:05:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f64dcc30sm22787485ad.66.2026.06.25.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:44 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:05:28 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
 <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>

On 06/25, Jason Xing wrote:
> On Thu, Jun 25, 2026 at 12:37 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > On 06/23, Maciej Fijalkowski wrote:
> > > > Hi,
> > > >
> > > > This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> > > > consumed from the Tx ring are not consistently returned to userspace
> > > > through the completion ring when the packet is later dropped as invalid.
> > > >
> > > > The affected cases are invalid or oversized multi-buffer Tx packets in
> > > > both the generic and zero-copy paths. In these cases, the kernel can
> > > > consume one or more Tx descriptors while building or validating a
> > > > multi-buffer packet, then drop the packet before it reaches the device.
> > > > Userspace still owns the UMEM buffers only after the corresponding
> > > > addresses are returned through the CQ. Missing completions therefore
> > > > make userspace lose track of those buffers.
> > > >
> > > > The generic path fixes cover three related cases:
> > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > > >   reports overflow;
> > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > >   packet, including the offending invalid descriptor itself.
> > > >
> > > > The zero-copy path is handled separately. The batched Tx parser now
> > > > distinguishes descriptors that can be passed to the driver from
> > > > descriptors that are consumed only because they belong to an invalid
> > > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > > address area and published in completion order, after any earlier
> > > > driver-visible Tx descriptors.
> > > >
> > > > The ZC batching path can also retain drain state when userspace has not
> > > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > > state local to the singular batched path, the series prevents a second
> > > > Tx socket from joining the same pool while such drain state exists.
> > > > During the singular-to-shared transition, Tx batching is gated,
> > > > pre-existing readers are waited out, and bind fails with -EAGAIN if the
> > > > existing socket still has pending drain state. This avoids adding
> > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > >
> > > > The last two patches update xskxceiver so the tests account invalid
> > > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > > still not expecting those invalid packets on the Rx side.
> > > >
> > > > This is a follow-up to Jason's changes [0] which were addressing generic
> > > > xmit only and this set allows me to pass full xskxceiver test suite run
> > > > against ice driver.
> > >
> > > There is a fair amount of feedback from sashiko already :-( So the meta
> > > question from me is: is it time to scrap our current approach where
> > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > half-consumed descriptor queues)
> > >
> > > Should we:
> > >
> > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
> > > and do a full stop here)
> > > 2. now that we really know the number of valid descriptors -> reserve
> > > the cq space (if not -> EAGAIN)
> > > 3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
> > > locally, don't ever create semi-initialized skb)
> > > 4. construct the skb
> > > 5. xmit
> >
> > Yeah generic xmit became utterly horrible, haven't gone through sashiko
> > reviews yet, but bare in mind this set also aligns zc side to what was
> > previously being addressed by Jason.
> >
> > I believe planned logistics were to get these fixes onto net and then
> > Jason had an implementation of batching on generic xmit, directed towards
> > -next and that's where we could address current flow.
> 
> Agreed. That's what I'm hoping for. There would be much more
> discussion on how to do batch xmit in an elegant way, I believe.

This doesn't have to depend on the batch rewrite, we should be able to rewrite
this non-zc in net, this is still technically fixes, not feature work..

There was already a couple of revisions with this drain_cont approach
and every time I look at it feels like the cure is worse than the
decease :-( Obviously not gonna stop you from going with the current approach,
but these fixes feel a bit of a wasted effort to me (since the bugs keep
coming and we are piling more complexity).
