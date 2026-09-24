Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2C3DC4C2;
	Thu, 24 Sep 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267090; cv=none; b=hgLNXDHjlIPr5lPgbBOpH51o4yoAoPcmqfV0dddd15dqb1JWORQaBqJLaAsxrfshHvQm3Sk/PtUh0gYH2kVhR0vsv8wXGFuhGOZ/mK3q4xHvo00jYclXhWUHr+nfj3g7NvIiU+JQFZw3sQVeWEzQB3HhjA3TgchulskY+R2lEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267090; c=relaxed/simple;
	bh=057w4K6AIH+2cjgtX4h1v5myM/zTrovsfRnreCXZXgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5kbaa4IO5PFm5SdDJ8ZWAOWGu0Krzdu5Q3Xtnh5VSNkxRKRLSTYH5UzgHFASVl+se4G/xRiYsIG0NVNfC5fAuLGJpiZGv+Te0uO05ba0gIKEBbqqP6hpoKw7d+OgAowQ/6X24jB4o4Z3+Gf23oT6/fchRXokF4W0WKt5noLGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U6IAhE70; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U6IAhE70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790267089; x=1821803089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=057w4K6AIH+2cjgtX4h1v5myM/zTrovsfRnreCXZXgk=;
  b=U6IAhE70dtOHVXdjZPBet44xD02bMw6SmAXMstzga1+c6VtD24xrD0t2
   p+ygqbVHSjR1kulqz3X28bYGX5kC2XY9PemCJ0LjDIeR8ZghTStTAEqEV
   a/wjs+tuv5pW3/M3VO4q1frQFGk5AJimkXyfTr7+TxN3QN4jevKCLxbNY
   GuqUNbHM+E1PwaxFkv3oOAytQNVzG9AXXcr3tP45KypV5XS0/DS0UlrbT
   8w2wKd+JVwOzXOU3loy1CyCvSyrw/YHscKQe2HVXOuHIrLgk1IoXqLTok
   CklEaEthYo1rkJo7UB9Un7YoD+apys4gQMbA5Wstx+vvVi/iq5QgNPWHM
   Q==;
X-CSE-ConnectionGUID: W2R9KMarSxa+DEZ33B5E4A==
X-CSE-MsgGUID: jaEIntY6QkyEU8YyNCAOvA==
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="64409041"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 09:24:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 09:24:47 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 09:24:43 -0700
Date: Thu, 24 Sep 2026 18:24:43 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, <netdev-bot+sashiko@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <herve.codina@bootlin.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <mohsin.bashr@gmail.com>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260924162443.5vmx3dx5c4cx7rrm@DEN-DL-M70577.microsemi.net>
References: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
 <179008205148.2160803.12818321368571406375@kernel.org>
 <20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>
 <20260923180730.GV13925@horms.kernel.org>
 <20260923201155.lbbbtx22adz2ilhg@DEN-DL-M70577.microsemi.net>
 <20260924064617.GY13925@horms.kernel.org>
 <20260924083141.67eecb6e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260924083141.67eecb6e@kernel.org>

> On Thu, 24 Sep 2026 07:46:17 +0100 Simon Horman wrote:
> > > I am a little reluctant, when I cant really test it properly. Sashiko gives
> > > another solution - adding a LE dependency to the Kconfig of the misc PCI driver,
> > > maybe that'll do?
> >
> > I think that should be a last resort. I won't hold out on this,
> > but I would prefer the approach I suggested.
> 
> +1

Ack. Will add the big-endian support in v8. Thanks.

/Daniel
