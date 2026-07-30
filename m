Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB01435510
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417878; cv=none; b=Af7sbjh10/DVUCZO21GXxAaLvx54TQc6EnfBsFwmvdULeRwpmSIaXVs/dUxNdoR2BaEkFztr1/Wj4t7LEeLugmmcCwIaS3HoBvA13OeGCvGvTx3/76Hdl3ncw1n7dm29RThbfXAjF6LBmPX0eixega7+Ef8n4PUsuse8LJAp1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417878; c=relaxed/simple;
	bh=1bmQ3RAxzKe2E3N+fs3vbfkvhQw0L5IsZeWyc9BpdRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki6geFaO9xPXhoVq0wqys5m3kzH1CbC5wKu5K9fP82f7PcILPG/gQTmjLYj5AUvA/YaeIxX2CwXqmneSfxuqfc5ASsyzo1z5mAGbX5+WemiiV15lltvnNOmtNRfs5q7jzSOzlTtkL5ZAtipkthMYn8/MmXPHPO6Zk9q6BKr5s5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=blTFJ+Kw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="blTFJ+Kw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4957eefd361so14667475e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785417872; x=1786022672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wTNiZqsPvsvAsqdJI3NYqaSJTMEuvNjWMEi2TBFAAqs=;
        b=blTFJ+KwnlkNkWzRNAxS6s0Y97LiwFlTGmcXqZhN5tnW7ZSNHgSaCmBTeBpo+UzieD
         x0w3k+O1zEB/Nd36E/sGWVyNoHZqyj7EhLx4+x4+GFZL0ZXG/QBGjHCg1roGOWK20s0f
         dkrE1T7JpcILsj2NN6cu/71VdbE4irtTTIyQtI80K2BbWTC2uKh4PdoAIznjp1ws4Ntx
         QFhg16TBZWjpPbFcNTUDnYcYsJ0UzhqX5A68E3C+9e8+RumP0+Xen3oWx2oRkWvS8THf
         hyY8NHfhO6/zzQuYNzuVYuzjo8NPiVAiysD3dGUouSSpd8P2CNPO3KlOjEZicfXnWesx
         rKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417872; x=1786022672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTNiZqsPvsvAsqdJI3NYqaSJTMEuvNjWMEi2TBFAAqs=;
        b=fJP8OHv+egYA7hMqU0ZhEHYbVLWwHnSUqtCkvwNK1gFPqrI1lHt+RzzEddJYyFiHRh
         u7gKrdQS7z5Mi8fFhl+ICffutYYeDdPwWAoyxE/RuHCW9x8SaGMObcztmSQZ9Qh41DO9
         yE0Kmmur9RPHvKqb4KftKIINxa3j8Q9ETyB1s/2dyra8iBVuvr6GAjzCJ8doniQ2Ao0I
         WfIDAnVoBuJcDYWYRUO9c7ESZHwNv+YCkdoimA5YNlDY2mjBy+035Z+smyHjstkZKToc
         O2GMrRSLbVYw1qabGXg535OMPSfcuwF4+NpmC7Zlf2iPDWkk+dN006SEHWbQqruzNkGb
         6tbA==
X-Forwarded-Encrypted: i=1; AHgh+RqJtJ8xjDmBK66pN6Lo/PL/eLCJbWloP8d88L/heYYxJYelPi+CeTZIuwsB4L/RdYhvzqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYqwr3Q5f2q+jrXNIjF28peinBDPeDlKiKIeuMufij4Y5wbT+
	ENiYPnmluRkB52XdKNZENnM/ioSEhpeGW3lIyQ5IibsBOhRruV9e4wi8KWvGS1NAxFU=
X-Gm-Gg: AR+sD11Zk20mYZxeTn1b+H8JL1YyhyOjv6frBYhtATs0MgtMkHuyRTpXwO17PIKZNne
	ikcJA8uQHf9szky1ZyBEFS/Suk4lneZ2z5F1QX61mvy5ka0BqUr6XPfQ8krRz1/ziCAJOlCPyI+
	JiiAwt75LGGsudlY8wzITBuLMRVkQsDRxfmVMwUMSz8Tg7Sd6Ca5Y+TF3BmNNWg7Oxmhh/V8V9J
	PtmCOrpbqT3F/h5oWcm1QAKPKD3VbhaumcK/ktn4I34rbBLJPKn5W4122wwX0C1z7YddKb/LN6v
	ZeF7KnCNAhCSEpVGO1ywuasYd6Hj7xsBJpzVy61MC1YrhzCOXvzS7EnZDDiZsjXSB9IACgR0iY/
	wY50ZG+6ZrYf3eNLZSALWi7yVTdv8DQ2OPYii38H/CTIKfExdxTiWp+sLP5gClnBDNE7fQpTnrb
	DKNnPluCNfmHX1oQWoceWMMhvHUewtwVt4Hrv+7OO/5CfL/mGaZPSo/guyZlyCE5uzpS8tcQXAR
	r2TyUI5q1kXcZCczlplpDBor/AxGKW+WSvaRuNl8IwIRcLctqvIW0YI/dNr86V4jyBB9uvfcPA1
	JfNMr3Y9buz9W3+WQE6HlnkjH/FzMG2NNpgSYbGFHRUOQw==
X-Received: by 2002:a05:600c:8b66:b0:496:c1f3:e8f9 with SMTP id 5b1f17b1804b1-49800ea1378mr34361415e9.20.1785417871594;
        Thu, 30 Jul 2026 06:24:31 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49801c073a3sm8655585e9.4.2026.07.30.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:24:30 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:24:28 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Message-ID: <amtQjCV6Oi7UI97t@aspen.lan>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
 <akzLgrzsw4xYmnLH@aspen.lan>
 <9f949b97-da81-4bdc-8be5-68f7883d768c@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f949b97-da81-4bdc-8be5-68f7883d768c@lunn.ch>

On Tue, Jul 07, 2026 at 02:30:44PM +0200, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 10:48:50AM +0100, Daniel Thompson wrote:
> > On Mon, Jul 06, 2026 at 05:17:58PM +0100, Daniel Thompson wrote:
> > > Currently stmmac will run a full cycle of IRQ tear down and setup when
> > > setting up a new XDP program. This makes tuning TSN systems difficult
> > > because whenever a new XDP program is installed then the irq threads will
> > > be stopped and restarted which will undo any thread tuning.
> > >
> > > The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
> > > from stmmac_xdp_release()/stmmac_xdp_open().
> > >
> > > stmmac_free_irq() implicitly synchronizes interrupts and, with that
> > > removed, I was unable to prove that later actions in
> > > stmmac_xdp_release() are safe when there are concurrent interrupts. To
> > > avoid problems let's also move the code to disable DMA interrupts earlier
> > > in the sequence and explicitly sync the interrupts handler(s).
> > >
> > > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > > <snip>
> > > @@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
> > >  	stmmac_reset_queues_param(priv);
> > >
> > >  	/* DMA CSR Channel configuration */
> > > -	for (chan = 0; chan < dma_csr_ch; chan++) {
> > > +	for (chan = 0; chan < dma_csr_ch; chan++)
> > >  		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> > > -		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> > > -	}
> >
> > Sashiko picked up that stmmac_init_chan() has the effect of enabling DMA
> > irqs, making this code unsafe.
> >
> > Given stmmac_xdp_open() can only be called on a running interface (and that
> > stmmac_xdp_open() explicitly sets sph) then re-initializing with stmmac_init_chan()
> > should have no effect and we can drop that as well.
>
> Something i like to see is symmetry. In theory, stmmac_xdp_open() and
> stmmac_xdp_release() should be mirrors of each other. But i don't see
> anything like the opposite of stmmac_init_chan() in
> stmmac_xdp_release(). So i can well understand that something is
> wrong.
>
> Maybe rather than just fixing this IRQ issue, you can look at both
> functions and see about making them symmetric? I've no idea what that
> actually entails, it could be a can of worms, which is not so uncommon
> with stmmmac.

After review I found that moving the disable to stmmac_xdp_release()
does and removing the call the stmmac_init_chan() gets things most of
the way there. After these changes every action in stmmac_xdp_release()
can now be traced by to corresponding restore code in stmmac_xdp_open().

It's not fully symmetric because activity in open does not appear in
reverse order compared to release. However it definitely moves things
in the right direction because the new stmmac_disable_all_dma_irq()
function pairs nicely with stmmac_enable_all_dma_irq().


Daniel.
