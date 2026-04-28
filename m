Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49531D75E
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392487; cv=none; b=lsWoRCzgbUv2NAbtBVRyKeUzRWvDmuAqVsuNi12TBJ9vylBcdX3xkkxowDdwjmKkjswSukDoWP/aCmeG+c7/ySqrDKym6AT3QGlgsWvKDEcCdH8rmU/if8O6myszPTqHluunU8xdhVq/R0WGxANrmjslKiu54ZgH9FMbBc9ByWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392487; c=relaxed/simple;
	bh=DOvjwCqRSTMuph9VfUSOH3Bnxl1XAy9dSaasLTePhRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzgWWL+IECsi0QMTw+cRg2mRG+G9MYBH3ure0kgV5S93yJW9MU9VLaxRXzf90ZXuYNspZXGZcrC58Zfg7kCehv6klnLgfUcNJngmHI90NHjQvru1CsK9X5ZyncbKraunZnC/V91KADFLbZOYRlNEp5El13jiH4a7Hbjjp9f+IBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qPSztoZg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qPSztoZg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1012BC5EF13;
	Tue, 28 Apr 2026 16:08:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CA35601D0;
	Tue, 28 Apr 2026 16:08:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9ED3E10728E5D;
	Tue, 28 Apr 2026 18:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777392481; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R7YnNrHkXr0z6CcnblvtQUE03jaxaAjhHUqCoIZWK3k=;
	b=qPSztoZgXx+kxLNzJum1hgHv4NAJeJDfINkViE9otpRTWo1Tif78POYWdHN2F/Bdfhfrzm
	1ntwbF2ByJFgJmMVOSpK+czfI/tBWKMWfLQQzsy1OOYWSOAeBim5wKn1itEZ6A6pZSlMAw
	0qGzC47poRHNgQr/8zCUGsyO2UiuEHgt3ZANU8gru1lBWXvi3Y7BFJ0ZRYX5Sao8QnnJSC
	nYqi7zKWGJK87MVruHV/yncpE/W5C6dQzAv9wHnT8irsBW6UpZwbvvkvmd8zM8tekHjfxZ
	OPmd39vhByGsk27HRvI3iFrkfgj/BHqOi0x/hkagWLqlx8QRqr/IKDV4o8O49g==
Date: Tue, 28 Apr 2026 18:07:52 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 00/13] net: lan966x: add support for PCIe
 FDMA
Message-ID: <20260428180752.4e68fea8@bootlin.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel, all,

On Tue, 28 Apr 2026 15:06:49 +0200
Daniel Machon <daniel.machon@microchip.com> wrote:

> When lan966x operates as a PCIe endpoint, the driver currently uses
> register-based I/O for frame injection and extraction. This approach is
> functional but slow, topping out at around 33 Mbps on an Intel x86 host
> with a lan966x PCIe card.
> 
> This series adds FDMA (Frame DMA) support for the PCIe path. When
> operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
> directly access host memory, so DMA buffers are allocated as contiguous
> coherent memory and mapped through the PCIe Address Translation Unit
> (ATU). The ATU provides outbound windows that translate internal FDMA
> addresses to PCIe bus addresses, allowing the FDMA engine to read and
> write host memory. Because the ATU requires contiguous address regions,
> page_pool and normal per-page DMA mappings cannot be used. Instead,
> frames are transferred using memcpy between the ATU-mapped buffers and
> the network stack. With this, throughput increases from ~33 Mbps to
> ~620 Mbps for default MTU.
> 

I have applied the whole series and performed some tests.

Issues observed in v1 are no more present.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
