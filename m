Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319319F12D
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030342; cv=none; b=cqk9w72EiEA0k/4QiUUzYUNFDikylR+Kbl9sXLsFI5ib0jqa7+xGJjx1JtAzjA66OdOT30R9YkKZ1/KG0lKB91VP981+qO2pLhJB2smqppAgSVIu1ezPAInE2WOtEQSHlJkIf+cJjAz+F5oFPaUntQy8AxcKrpK0+iD47qsgYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030342; c=relaxed/simple;
	bh=LR7LAldVcgI9obIy+/bO4y0ruSnBiqbukoMOuSekzAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsykoHJXQPaHfFdEP6rfKP/o7CgvaTjnHmOHWjA3z2gtUaiX/GreGlbwrDGH+UCLvAdV6govLFaylLLs84GFYZPR1uCVUhSR0qt05mfUKVD9M+6Fh+kF1f41bbfD9EO+iL5OTccFqHOLUgJif7iIMMeBvGznE+qafRUgjzLMtgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Y4ZHY8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Y4ZHY8"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899d6b7b073so61173636d6.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778030340; x=1778635140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xefO3CdiqRR6SyOJAzo15ugz1YtLwmd7HdJ9NdZnMzE=;
        b=Y4Y4ZHY8PPueFBZKDPWXnnqfv8cs0PyPjc16gSrV0otZf49UYYk1cc8zl1JFHwQW6e
         p64n5l0rwA88PcU3r68rZFiRQrdzauWhf+b7C+0CgrIfkQzh1Pdk0CpHjYYJcHPzphkd
         qDUmnhynED+hcaTKBi0rco+Vm054G9mP1spV5Patr8DmieKr/MKb3GtrDM/rli5t13+h
         qAYjb9oyepwlXIhgmrWM8My/JkupNlE2XjAvGOhfyF5vuEBZC+0QFnOEiuet3KKmzk7V
         k6v7a5w5y1Nkgdaf6I/GbmrjSdC2CC/6/2EABZGrq7aDdBHxrIeQioKNyQxeHsownUj/
         WsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778030340; x=1778635140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xefO3CdiqRR6SyOJAzo15ugz1YtLwmd7HdJ9NdZnMzE=;
        b=M+h2/ogkiaGisd5xMYu+K9nhhy3WYsIVs+xPZIidoDZSaLrPPs5/PtOv+uOebq7r2X
         75qhLQU3L3VAKGu+KTMLPwKeSuAAIr482Kn+x3l0e/1Dfxkqn2vJuENSYTYUG/TJtsCq
         2QpAz66Wri2RBZCuPMT4Bxq3XUvRWxvqTMIIMt3t85l7tK17S9fngV3Z7n5e20xs2y9G
         kY6PUeKUdFqN3Fbd7vUX2Qhj6VTdcECxzsz4BrdlE/lmkuiJB0S9N5/ZW8kwao4fMEx2
         odUiwtee4bFA1+4zNf37msrSoAEb8HjZigwUD/vKvVwsFC+eucy/PSr9KoArsL8Ck1Xo
         NCEw==
X-Gm-Message-State: AOJu0YxaiFXNjCwQH+bIkWbHd6feqFQXz/+7icrCD6LC+W8nhnVcTr3R
	k5PQzj843gPKAfnCzGZ+XbCrPLmlEXZbMxll7DDE5/qRvm07c1+699v+
X-Gm-Gg: AeBDieuxPWf1prbCDAPh9FWvSqA3oqg5UavDfSn/61net3Dxg7p3asItWRQsyoEKuJg
	peyt8X2MRaROW/jvsp0MfVCzNPGA5fjHD9jifxF6kbZduJR+9oloQKLcmPRAxfFwt//7LG1tHIb
	Xax+hgLxok4hEsqRHqATMdYdx317Uf3c17yStrZKtU1uR66wmTmfvQ+FeX1eNp+X4zDF8y/K4d3
	GsKHIofaHz8s1rsWSKzWPy7PvLRioNNHyLfHp95sJwulUa+ln4eeURk4rgQ5xEFIKKm48rzSZwQ
	HGJHgH5ayrsWvq64jPgxjKCpjau/yAQ09T88DTS/GKlU89uA6ep/09/Y5ZcalQOmtM95oJ20HFH
	M5i8YblRKtZnwH33ovFBWewB0A7J/JHRXKX/aF8XykPnC61YHA2CM0fHuZSPauNscNYODX2d1di
	/yJRZ4oKYdDANezevYVMFVtArOQhSL9xsHLnyEBTdwz2cOcYKp3c5hK/tMJw==
X-Received: by 2002:a05:6214:f66:b0:89a:622e:d32c with SMTP id 6a1803df08f44-8bc44f852fcmr21784616d6.36.1778030340115;
        Tue, 05 May 2026 18:19:00 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:2e::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm186780256d6.3.2026.05.05.18.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 18:18:59 -0700 (PDT)
Date: Tue, 5 May 2026 18:18:56 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <afqXAKj4fJbTd4tL@devvm29614.prn0.facebook.com>
References: <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
 <20260506002905.DF681C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506002905.DF681C2BCB4@smtp.kernel.org>

On Wed, May 06, 2026 at 12:29:05AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Double lock lockdep splat and potential deadlock in netdev_nl_bind_tx_doit()
> - [High] Use-After-Free of dma_dev pointer in netdev_nl_bind_tx_doit()
> - [High] ABA vulnerability and pointer aliasing due to untracked vdev lifecycle
> --
> 
> commit fea3266a76d31b8278bf86dac679860b442a5bea
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> net: devmem: support TX over NETMEM_TX_NO_DMA devices
> 
> This patch enables devmem TX bindings on netkit virtual devices by routing
> the binding to the underlying DMA-capable physical device. It extends the
> skb validation and binding lookup to support the netkit architecture.
> 
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index cde4c89bc146..644c286b778f 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> [ ... ]
> > @@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >  	}
> >  
> >  	binding->dev = dev;
> > +	binding->vdev = vdev;
> >  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> 
> Is it possible for this virtual device to be unregistered and freed while
> the binding is still active? Since there is no reference count acquired on
> vdev, and no NETDEV_UNREGISTER notifier seems to clean up the binding for
> the virtual device, vdev could become a dangling pointer.
> 
> [ ... ]
> > @@ -397,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
> >  	 */
> >  	dst_dev = dst_dev_rcu(dst);
> >  	if (unlikely(!dst_dev) ||
> > -	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
> > +	    unlikely(dst_dev != READ_ONCE(binding->dev) &&
> > +		     dst_dev != READ_ONCE(binding->vdev))) {
> 
> If vdev was freed as mentioned above, and a new, unrelated network device
> is allocated at the exact same memory address, could this pointer comparison
> incorrectly pass due to the ABA problem?

For reviewers, we could add a dev_hold() on the netkit to avoid the ABA
problem, but then a guest ns user can use bind-tx to prevent the the ns
manager user from being able to delete the netkit. This ->dev and ->vdev
check only exists to inform the sendmsg() caller early about the
mismatch, so I leaned towards this not being a great trade-off.
Especially since validate_xmit_unreadable_skb() does the validation
correctly. I'm open to adding this if that seems like a better approach,
though.

> 
> [ ... ]
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index b8f6076d8007..0e296c3bb677 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> [ ... ]
> > @@ -1164,16 +1197,30 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
> [ ... ]
> > +	bind_dev = netdev_find_netmem_tx_dev(netdev);
> > +	if (!bind_dev) {
> > +		err = -EOPNOTSUPP;
> > +		NL_SET_ERR_MSG(info->extack,
> > +			       "No DMA-capable device found for netmem TX");
> > +		goto err_unlock_netdev;
> > +	}
> > +
> > +	if (bind_dev != netdev)
> > +		netdev_lock(bind_dev);
> 
> Will acquiring netdev_lock() on bind_dev while already holding it on netdev
> trigger a lockdep warning? Since both are struct net_device instances, their
> locks belong to the exact same lockdep class. Without a mutex_lock_nested()
> annotation, acquiring them sequentially might trigger a possible circular
> locking dependency splat, and introduce a potential deadlock if locked in
> reverse order elsewhere.

The tests passed with CONFIG_LOCKDEP=y and CONFIG_PROVE_LOCKING=y. Since
they take the bind_dev != netdev path, I'm not not sure if this is
needed. Though I admit I don't fully understand mutex subclasses...

> 
> > +	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
> > +	if (bind_dev != netdev)
> > +		netdev_unlock(bind_dev);
> > +	binding = net_devmem_bind_dmabuf(bind_dev,
> > +					 bind_dev != netdev ? netdev : NULL,
> > +					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> > +					 priv, info->extack);
> 
> Is it safe to use dma_dev after dropping the bind_dev lock? Since
> netdev_queue_get_dma_dev() returns a raw device pointer without acquiring a
> reference via get_device(), what prevents a concurrent hardware hot-unplug
> or driver unbind from freeing the dma_dev between netdev_unlock() and the
> subsequent use in net_devmem_bind_dmabuf()?

Valid, will fix.

Best,
Bobby
