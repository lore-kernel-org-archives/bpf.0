Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884A32E696;
	Tue, 21 Jul 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638953; cv=none; b=bfRBj+1443JtXDHaxs4SQOTa9+t5hOODkJm5LRAhL6pOfM8FviZJ07WiZjbNbMA205fLxt/EpfVlwrM2oDpywRZawjzTpzvoldTfv4uLeqpuUKre0sKE5IjdT4BZh4Ofkn/yI4XHlJy6RNP92szBQQyoIDxsWO9RCTP+Cf6xAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638953; c=relaxed/simple;
	bh=lNEXsYMkFJvbHSrQy1OqZsdWjhrhUmNHroA4qO6wGUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id4+xLtKQczQLlW8rYpvHVn/QloegkunbniaEGIi5+QDNJz6rjeqD30+J9u3Lo4XKNibYf+C0JRD1SNVdOWZQuOyUFNd+JDr0tIYY2sKjzMmbOqNxirQ8Wvx81Qv4qOcLUZnfPSa6UvBpfrJyElT6FxR+w1/7rv8S+VcrRhGTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OblXjxnb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OblXjxnb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ReUY5SnZ2BjjLkxKuYNlNPHmboIuP/nG8g01ouMFokM=; b=OblXjxnbN69ShCQ5O7J6rgqNye
	rNKIcYTitieJ6QyYlfGWL86gIJwAi5HDo5bPgrc88nFCnTY1e/yxEbN7p6MbuAWxW0oQrXIXfzd7r
	O3R9PRzUWdDKFrDJ752KVvoVteU44+ZLHXjV0ozgZGlj4vNAcDJywh5OniNckVHYxbYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmA6n-00DRAN-6o; Tue, 21 Jul 2026 15:02:05 +0200
Date: Tue, 21 Jul 2026 15:02:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>, Auke Kok <auke-jan.h.kok@intel.com>,
	Breno Leitao <leitao@debian.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH net v2] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Message-ID: <9238e3a3-4168-4716-b2f3-8e8879e65963@lunn.ch>
References: <20260720133049.1289167-1-pulehui@huaweicloud.com>
 <d86c6b6a-fa9a-4429-b004-8c54b2232797@lunn.ch>
 <933d745d-712a-4d49-982f-414ccfd69e47@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933d745d-712a-4d49-982f-414ccfd69e47@huaweicloud.com>

On Tue, Jul 21, 2026 at 10:06:10AM +0800, Pu Lehui wrote:
> 
> On 2026/7/20 22:52, Andrew Lunn wrote:
> > > --- a/drivers/net/ethernet/intel/e1000e/regs.h
> > > +++ b/drivers/net/ethernet/intel/e1000e/regs.h
> > > @@ -242,4 +242,7 @@
> > >   /* PHY registers */
> > >   #define I82579_DFT_CTRL	PHY_REG(769, 20)
> > > +/* Smallest BAR0 that covers every register the driver accesses */
> > > +#define E1000_MMIO_LEN_MIN	0x10000
> > 
> > I commented on the previous version. Is I82579_DFT_CTRL the highest
> > register? Can E1000_MMIO_LEN_MIN defines based on that?
> > 
> > 	  Andrew
> 
> Hi Andrew,
> 
> Thanks for reviewing this! And yeah, I caught your comment on the previous
> version.
> 
> I did the math on I82579_DFT_CTRL, and it comes out to 0x6034, so it's
> actually not the highest one. And the registers in regs.h aren't really
> sorted by address anyway.
> 
> The highest static address is E1000_SYSSTMPH(0x0B64C)
> The highest dynamic address is E1000_TXDCTL(_n), as it define bellow:
> 
> #define E1000_TXDCTL(_n) ((_n) < 4 ? (0x03828 + ((_n) * 0x100)) : \
>                          (0x0E028 + ((_n) * 0x40)))
> 
> But since the maximum _n we use in the e1000e driver is just 1, that address
> maxes out at only 0x3928.
> 
> So, since E1000_SYSSTMPH is the highest register offset the driver actually
> accesses, how about we just define E1000_MMIO_LEN_MIN based on that?
> Something like:
> 
> /* Smallest BAR0 that covers every register the driver accesses */
> #define E1000_MMIO_LEN_MIN	E1000_SYSSTMPH

What is the size of this register? U32? Maybe you actually need:

#define E1000_MMIO_LEN_MIN	E1000_SYSSTMPH + sizeof(u32)

	Andrew
