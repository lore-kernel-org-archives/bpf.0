Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07202D97B5
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079701; cv=none; b=j78AnWuKmqp8Vclv0gehJPJQ2gf1lNkjcaJf4LeUpNJI2fiFD/DVhjm+CIIjd/Ere0qOUYlVnBtIZUbMAyYt+rRf4c87gDIqoKdWwVubbR19J27hNDv02CrAa4HUbnKujjpqpGUAAjF2vKwtpePBz6PNNYy2hw0MYeuCZQ4JX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079701; c=relaxed/simple;
	bh=97D+2KHVfIQtZnF/BiA1aQSJIGdLjAtMFhlOAFZiK14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gobDFP46ST7idTmay4v844zDnXFpwgOtTyjp+10KEjrRAAa/VBqWDCVw5LhR2GERK1eL+0BBFEptXD2bVrHGwX/90WBaup2Pm9OppZSetTU+cAfIiNndUGb7rDyBYybQSzCvRRV0wlZrENtaGZwGRDQlR1iG8UrKonM/qq87UhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0i5uxDd; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0i5uxDd"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b81586dff3so49424826d6.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079699; x=1778684499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLAHKjPfNYNOn213evw/K14liXEUXmu1VrX7uQeQpoc=;
        b=m0i5uxDda8l70L5jkrqPDwCOOZK+zwoAQ0rP3P8kKvLsKB0bYlS6pfo9Ot7jLpCT/p
         MDuZzx/tvKy1KT/OuL0pOTT/ZX6mcsdiU78vvq53I0fjMtJrPGYI/aEXlg7AL8N1+nEU
         lWMRKmH4i4tafalq6HMjMaoRFyawHOuRgW1ntEDlTwIdcMS2QXg49IA9cQfvrtH1MGXP
         K/35nGtdB19D+eMeKi/Zxk2ZDkJE03J2dP0PStSNJDBl01cRDNnUBSTk7PnezQcs+m+x
         8PRT7EbiqfOnP6mMfQ7Za29/XR7CITbyY1GfSsnkzpp8bRSdAGa6rjXj346+qLPwf86C
         jL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079699; x=1778684499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLAHKjPfNYNOn213evw/K14liXEUXmu1VrX7uQeQpoc=;
        b=eL7GEuhIPrlE1iZyNHmXNcEnp+xP5X+v/lHJHH+WRI0I7I8BpYq86m8wQVM1j/3E0z
         tdqrf3BWSERP5R2pxMIgTNU8i+YozzXwM9RgQDhNC0PK1nigexu19ODdGVYBtlCmNgcu
         IR9ni7YKPoW+FDds7w0nl4Unoy8m/tm+zwYOMKu7MxKBffebK/lsDCC90mXzIqYey1v9
         8SVeQzYKl1EX7O6kMm1RMG/+oBFuQR/42q7afDtFzu0yH7ra/4Jn/BWcAeX97IuybqKQ
         TxdoWiekiD+Ht3YfFjCyu1IgEJLtx7rpyNXdCJmldZfZ3iVJ3aeWgeYpwq2vtFtrbBVU
         QyCw==
X-Gm-Message-State: AOJu0Yy1SWlBCkykVWPFyoEwMyKh2N3qBP09jU0rMkVSa5wDXEaVvQ7x
	zq0Ds6/gJdzQA5aKbfI+oRsogRtLSH9OJ1evkBQ6nAC4XKs69enPyS4dhNBmpQ==
X-Gm-Gg: AeBDieuDPprdNTyuyWL0riEHLTxfe+/Z4S16eY7EzKmJC9D+TnUNrRjeFADPYZfX2Wb
	zCee/1EXb70ybm44tnv/HGFZe3UoXgrk+q/LMH9rNJrN3GM7BW+xWkemY50wu2fNI5BjdC/M9VM
	eTteeKGkSnswEoP8a03mSkpbb2kdezMhvtJ7rB3yB7rsVotFzb32FpVVlvSF19c1uU3anR67l7N
	RKoy0L6jmJSSmlYLpApG6QYwolPqgEYmdzjPnhU2iof/gTvw94QyC5BcwszVeEPsCQl0l7WMDKv
	IoLF10LW0JvewXVTU7ZzF8J1qmd3CDSoigzbB9VquZaKzpfXqWE/IBpEaTC7Z6T5HVJk8De8bTI
	V8BecK7GAiYg3aj1D26QHy1U3EmwqtNbdXsBAXSMkhfNqsHYn8RSoJyCdK4N7RJaN53s5u9+bwi
	9tZgm+d9HKtNZotNnhhhvnXMqx/KTlcZOfiIODx14tb/h7mY7ExQhw83pJrw==
X-Received: by 2002:a05:620a:458f:b0:8cf:d9a8:561b with SMTP id af79cd13be357-904d1081bacmr573794385a.0.1778079657410;
        Wed, 06 May 2026 08:00:57 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:11::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c34a0d4sm1635460285a.25.2026.05.06.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:00:56 -0700 (PDT)
Date: Wed, 6 May 2026 08:00:53 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <aftXpXLupAnYh27M@devvm29614.prn0.facebook.com>
References: <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
 <20260506002905.DF681C2BCB4@smtp.kernel.org>
 <afqXAKj4fJbTd4tL@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afqXAKj4fJbTd4tL@devvm29614.prn0.facebook.com>

On Tue, May 05, 2026 at 06:18:56PM -0700, Bobby Eshleman wrote:
> On Wed, May 06, 2026 at 12:29:05AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [High] Double lock lockdep splat and potential deadlock in netdev_nl_bind_tx_doit()
> > - [High] Use-After-Free of dma_dev pointer in netdev_nl_bind_tx_doit()
> > - [High] ABA vulnerability and pointer aliasing due to untracked vdev lifecycle
> > --
> > 
> > commit fea3266a76d31b8278bf86dac679860b442a5bea
> > Author: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > net: devmem: support TX over NETMEM_TX_NO_DMA devices
> > 
> > This patch enables devmem TX bindings on netkit virtual devices by routing
> > the binding to the underlying DMA-capable physical device. It extends the
> > skb validation and binding lookup to support the netkit architecture.
> > 

[...]
> 
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index b8f6076d8007..0e296c3bb677 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > [ ... ]
> > > @@ -1164,16 +1197,30 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
> > [ ... ]
> > > +	bind_dev = netdev_find_netmem_tx_dev(netdev);
> > > +	if (!bind_dev) {
> > > +		err = -EOPNOTSUPP;
> > > +		NL_SET_ERR_MSG(info->extack,
> > > +			       "No DMA-capable device found for netmem TX");
> > > +		goto err_unlock_netdev;
> > > +	}
> > > +
> > > +	if (bind_dev != netdev)
> > > +		netdev_lock(bind_dev);
> > 
> > Will acquiring netdev_lock() on bind_dev while already holding it on netdev
> > trigger a lockdep warning? Since both are struct net_device instances, their
> > locks belong to the exact same lockdep class. Without a mutex_lock_nested()
> > annotation, acquiring them sequentially might trigger a possible circular
> > locking dependency splat, and introduce a potential deadlock if locked in
> > reverse order elsewhere.
> 
> The tests passed with CONFIG_LOCKDEP=y and CONFIG_PROVE_LOCKING=y. Since
> they take the bind_dev != netdev path, I'm not not sure if this is
> needed. Though I admit I don't fully understand mutex subclasses...

Thinking about this more... I think the cleanest approach will be to
just release netdev after looking up bind_dev and then
netdev_lock(bind_dev) immediately after and hold until returning, which
covers both cases bind_dev == netdev and bind_dev != netdev.
