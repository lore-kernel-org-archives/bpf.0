Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7A480325;
	Wed,  6 May 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083044; cv=none; b=hNFRkU9n+0qZ7pH7rqEXxGRYnVpzrQRBpvHjjHIvIxLSzcps7rsNgkoTj5mhw5zp/I+iavOI/i43CGdZOHnEWI95ajIUzNJ2T3jNhSulgToHh+0UlD8A3hEdV5kVcTVvalVQNeOup850x9n3K1pdIJLo3jaaEzTUCXQIsIoQi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083044; c=relaxed/simple;
	bh=dX3bGLfWiKE2ITDJscni4W8mvCQnjDfEwCyr6lUxYS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI0gNw7r8RzpCJXGB/WWxa4t0LJqVaytqqGQHiEMW2rH11G3KPmdXvsOgLW79ASvpit/35MItZ7t2lws0/O8AuCSMCGp/ssd/YXiE1LQqOhpVSISNLI5tbIXjdnDsfQJRIzsLJ9/XRwIA5uBzaSidWg1INb+S02GRxyfQuf543Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yT600PMk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yT600PMk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1+Wztvuy0mJzlF3FNcQ0AyichYU2Z09zwwj4BuQcjo4=; b=yT600PMky5Bc7rOdWUY/HYanZ2
	ht/+YIA92DXNE0eB1ig/4bui/cnoKbZJueQ4b9IG7molm8Cd9hRHD/24YruLk35oGfHKzmIxyxWT9
	tBf22d4UDXY7UfvUy7CR61aBYu71nhGduWaB2U7PYJ3RY3Dab5MVDHE0iysqtitRtwcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKebu-001fZx-3z; Wed, 06 May 2026 17:56:30 +0200
Date: Wed, 6 May 2026 17:56:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xilin Wu <sophon@radxa.com>
Cc: Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <a8b5d96b-3c8f-4ec5-b205-bbacafbf47aa@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <224E233C593EF171+8c8a43dd-5061-40f8-9eb7-f360eabf2ecc@radxa.com>
 <4015f47a-af62-441d-b1b8-a8598f963970@lunn.ch>
 <4C0D95BC59F1A4ED+53f3be85-2cdd-4058-8950-57970027d481@radxa.com>
 <aftgorkah-Hjrvq2@aspen.lan>
 <549BE66F62F1470F+a489d4fd-10ab-484c-9b55-6aecfd05d383@radxa.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549BE66F62F1470F+a489d4fd-10ab-484c-9b55-6aecfd05d383@radxa.com>

> > Does that mean you don't get phy interrupts reported in /proc/interrupts
> > before any suspend happens?
> > 
> 
> No. The phy works in polling mode AFAIK.

You should be able to tell from dmesg:

Generic FE-GE Realtek PHY r8169-0-600:00: attached PHY driver (mii_bus:phy_addr=r8169-0-600:00, irq=MAC)

irq= can be MAC, POLL, or the interrupt number if interrupts are used.

If PHY WoL is used, i would expect interrupts to be used, otherwise
how is the PHY waking the system?

     Andrew
