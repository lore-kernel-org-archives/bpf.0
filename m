Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA01946C8;
	Thu, 29 Jan 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692744; cv=none; b=BhNdZ4T3Bb0jnff8JBbmpKL8UcWltLKdMbnWHs3A0ChiG0P2zaeNgOm6xzjURd1OdR22Tio1WqeJ0RNpvzCSxFPKK1tqKMHN8KvlDbT62EWS6Kl4nYjs6vSv9VPPW+tm+LiY4gpuXQW8IbBQaJcdqhYF//WiI3Q8chMGJXJkoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692744; c=relaxed/simple;
	bh=BHpv39mFINsX0KbaHZhCLr0SNAvBeNLzSbm1eXXTpvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPTROUwR3FyY3wDSMJ/zn4BQEEdUY+/Za4yBainpxyNUu7ToP91CNqgqLtf6gPKOxYFuO/Uisfd4mPyoMq78Drvv+SAxMTnsXb8Nz38ZLnIV1yDR0MvoVJSPMWxotneLApO9UlEw27QV3qCXJaguv5IWyWypT02Lrg/OtDd1vPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fatg20IU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fatg20IU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wYRI7quE870vDDzkPJ2HhpVjS23jDJ+DDwWwJTT3RUs=; b=Fatg20IUGQW/b4mTpHp3jcfpVy
	jeReeYW6WVOv1mSX9DpAZmgjmYGZ22zm065xdcPLz+6zNxbNx9rgR27pSMyQmSahq/8PPN9RziOKD
	y7tJfQZBEBVDOQ4SH9btyPfbolC16EVgyUA68XgylutOyi50nIDNAzxlowHBCRVzCGVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlRv2-005Mt9-5q; Thu, 29 Jan 2026 14:18:44 +0100
Date: Thu, 29 Jan 2026 14:18:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Illusion Wang <illusion.wang@nebula-matrix.com>
Cc: y <y@lunn.ch>, Dimon <dimon.zhao@nebula-matrix.com>,
	Alvin <alvin.wang@nebula-matrix.com>,
	Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
	kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
	lorenzo <lorenzo@kernel.org>, pabeni <pabeni@redhat.com>,
	horms <horms@kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>, hawk <hawk@kernel.org>,
	ast <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	sdf <sdf@fomichev.me>, daniel <daniel@iogearbox.net>,
	"john.fastabend" <john.fastabend@gmail.com>,
	edumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIIHYzIG5l?= =?utf-8?Q?t-nex?=
 =?utf-8?Q?t?= 01/15] net/nebula-matrix: add minimum nbl build framework
Message-ID: <c1536b51-f441-45ca-8bfb-d5f7d8230713@lunn.ch>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
 <88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch>
 <ad0a6f0f-3ce3-4f38-b27d-2f121511d6e3.illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0a6f0f-3ce3-4f38-b27d-2f121511d6e3.illusion.wang@nebula-matrix.com>

On Mon, Jan 26, 2026 at 10:18:52AM +0800, Illusion Wang wrote:
> 
> >_CORE is a bit unusual for a driver. CORE is generally a library which
> >is shared by a number of drivers. It does not have a tristate string,
> >it is just selected by the drivers which need it.
> 
> Thank you for your feedback on the NBL_CORE configuration option. We appreciate
> your guidance on adhering to Linux kernel naming conventions.
> 
> Why NBL_CORE?
> The driver is designed to support two distinct functionalities for the
> Nebula-matrix m18100 Ethernet controller:
> 
> 1.Standard Ethernet/NIC functionality (via the main driver module).
> 2.Auxiliary device (auxiliary driver) for RDMA (exposed through
> auxiliary_device).
> 4.MDEV-based SR-IOV/VF emulation (for native device splitting).
> Since shared logic (e.g., PCIe resource management, MMIO access, interrupt
> handling, and common hardware abstractions) is required across both the main
> driver and auxiliary/RDMA driver, we opted for a _CORE suffix to indicate:

You can split this two ways:

A true core, which does not provide any devices, just core functions
to access the hardware. Then layered on top if this you have kernel
modules with provide Ethernet, RDMA, MDEV etc. Such kernel modules
would then depend on the core, using Kconfig primitives. And the core
itself would not have a tri-state string, since on its own it is
useless.

Or

If the core always provides Ethernet, call it an Ethernet driver, not
core. The other kernel modules would then depends on having the
Ethernet driver, using Kconfig primitives.

This all about naming, not architecture. Splitting it up into multiple
kernel modules is good, but your naming and descriptions of what these
modules do matters.

	Andrew

