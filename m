Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DA315D53
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275764; cv=none; b=dsiFzRmcWTF5fn9AQWqXIZKFu50s7bWuHOMaJGvI/f2vCnqvTsFQ4cnxsAi1CS21hQgzhITWrMbYohSkJamsyMOAWaO1k+jwYnEbUzK3XJf2DWH3wKg8QJzMxywpybomEDnLQ/5/WOO0PJUzmBzxJDal42WIAiJeUa66tfZTQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275764; c=relaxed/simple;
	bh=gqWMHjglpbHY/2tqJjSk/6W2N13etU+sr8bVJuTM4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcOQfOpWLgEs7IzouTgfSRHdoEMbnPjZMD3ZDoNg3D/eA9BBNqkCMjGHS+7arW6afRXBNz/Cg6BvDvSkC71evKVGPFd8g3BiHigiMAnStd/p+qS12xtpheqBT5TVR/j83mgeyG2hxuiZ4vvoN6KsBzvei91VgWzUSPQ0zpJfAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBE9ytoq; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBE9ytoq"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc150711112so73355a12.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275762; x=1787880562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
        b=KBE9ytoqGNRk0tgsofHNaXiCHOv08zLHV/Tn5QNqEU6FbejhbPTrmHgiSqd9X/lPhA
         ftwsSblQvDRaoeBW7p4WSTkipw5AvSJo+hqSQ8z8EliowpercQxBHDEikzcLz2Jw+jqH
         1KjueGhPQSH5C9YUHHziDB+0+ChuUzDr0UDHUQqD0Ix7M22vFwKqC51lV70ZXuUj27Bg
         F6Ul/NxR1NK60cC2O6pEGr9nd2YMcym/hXGdpIADJpJIKHRzFG/0rQnK52RmLCY5q/Se
         bszGnLCoc7fHLzHo0qTFAMWd27RHLEODylghyZYDHllFAbTFxi3wSHVQfLcnw76hiUCS
         HrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275762; x=1787880562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
        b=OWHAmEbwvmPVC0cnjeCgcS79EXbkkrcOaYXxHjGfjamRkW0zvaKjlQgCeg7Sqkxq8w
         3zl6SPHS68dkKXlZF04OL+dxtpMjSpxzFw96oDgbB0laVceHvIqcYUw7pDxRFUlyYGiB
         EcsyBWMZzyNDIOQbfN++zbgmL2yQCHHg22tMhaGIQEuPB+rmnmzOr6lrhICwWIYtxNCG
         5dCNT1WDQi+etMypJ7zK9UjHXX2/h6h+CpqQy7qetsfZlvhkcZ7hUe/RO+QH33dhkqC1
         jYB9/bdZ3RNBuKGvBqO5VW7X4j3+DV6SkXs/3LkdffHHiCisf40zghzuERuLjnwFhfTc
         WYUg==
X-Forwarded-Encrypted: i=1; AHgh+RpF0nm7CF3bCzD11ru7Yq1AvmA1tEiuqq5PUc3mJco/Kf0zqlSBlPynnEnbQUB5sYpxYig=@vger.kernel.org
X-Gm-Message-State: AFuF++kfyspce4chpg6gUldvA1AyeaN04a7+cdLlEYh3gYwFoj41Bg00
	S9mjJpLe7F43f2NnA5m0vo7ACxOxjmT92QGvsmhi52Rnic+Oubna9RPB
X-Gm-Gg: AR+sD12SfTpqHpX3fTnyZNWzEQ0D2ZllqokNeUjjmaK9x1/KaFpzP78p+0DtBUk8WF/
	4XjEDOjS22UjMxIQ7o3sRiSVkpLeTTmvvUBSKw458va5lzG6+426zvdmGqVVqCrt2b3Cz50e6PY
	myMwcvh7CNNZG3kqwaUOced2epxMAVgZqxKXZT/euXdZIfDXSLXO9dQ4pM1NW0HY/17yu2uOUmR
	exp8qCTc3T8ki3K3TwHMrBgD9GWr58Ydf4epSBdSmos5g/DD5R97RZjCTxbPG4WLfNmYOwL6E3p
	/1lxZHjLs6O6tk+98fv88kp9c2I4M6qu2QN5B150KeANL0PUL8ttfo+5XIj+MOdfa9NSA4WK4MM
	F7HjQflk/Ce9+hOhx/DM080Vuhe97IilMz7jNVYVFfe4jtjECVy6xxAC7h40NwvSRZ5LaPZIP6U
	DEvSNzBgNjQFBYsROXWPgTeTzJgVKkFD0WWvERYwFTuPVqkPbr7lS7grIKdj5E/lkg
X-Received: by 2002:a05:6a00:170c:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-851f9f0db82mr3439334b3a.8.1787275761986;
        Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640dd4sm2169685b3a.41.2026.08.20.18.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:29:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com, horms@kernel.org, 
	magnus.karlsson@intel.com, sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, guoren@kernel.org, dtatulea@nvidia.com, 
	witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me>
 <aoceSoSFMx69Z9up@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoceSoSFMx69Z9up@boxer>

On 08/20, Maciej Fijalkowski wrote:
> On Wed, Aug 19, 2026 at 09:05:35AM -0700, Stanislav Fomichev wrote:
> > stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
> > after xsk_tx_peek_desc() has reserved their completion entries.
> > 
> > Completing a rejected descriptor is unsafe because AF_XDP completions are
> > ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
> > descriptor, which may still be owned by hardware. Instead, leave the
> > completion pending so the ring eventually wedges and increment the drop
> > counter to expose the application error without risking hardware
> > misbehavior.
> > 
> > Document this intentional ring imbalance at the check.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 62de03e65a90..6a532747c039 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> >  		if (priv->est && priv->est->enable &&
> >  		    priv->est->max_sdu[queue] &&
> >  		    xdp_desc.len > priv->est->max_sdu[queue]) {
> > +			/* Completions are ordered, so this descriptor cannot
> > +			 * be completed safely. Wedge the ring to expose the
> > +			 * application error instead.
> > +			 */
> >  			priv->xstats.max_sdu_txq_drop[queue]++;
> >  			continue;
> 
> Hmm. I read the discussion on v2. Maybe we could cancel cq entry here in
> this branch? Also it feels like something achievable at bind time when
> taprio is configured and vice versa?
> 
> Otherwise we over-commit cq entries.

What do you want to achieve with the cancel here? IIUC it will make it look
as if some (if the user has posted many) tx descriptor has not been consumed
by the kernel?

I do agree that a better idea is to probably do these checks during control
paths, but it's a bit more involved (and not sure if it's possible? if we
have a bunch of xsk sockets and we change that max_sdu, do we go over all
sockets on the system somehow?). My main motivation with this patch was
to make our LLM reviewers less chatty about preexisting issues.
