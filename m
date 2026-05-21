Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D53ED3C7;
	Thu, 21 May 2026 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372779; cv=none; b=qaYz8V0bR/RB32CSWo0rKS+xgPGjsRLR5sB9zpWKABGOKJXDasntEGxn46srilNjGE3o00s9FzFqYWCXDv8LdBGfjKoKQpRSqy/6CbllS5xj/au9Phy4+YzCndWSJk/dXmrDTxNQTajcRrHcebfqKX81xnIWG4G1aj0jghl6Tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372779; c=relaxed/simple;
	bh=3uHkCr3Czag36uOPZx+WfiLBDM/EZRglKu7YFz6fG0k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoXaLlGNsd7X8z7JYgggIIWXeCIhZJPANZe/UCETtJM9/TIJah21dPlwZnsO8GQDhh8nEpSkaQl7RhcnuBWXfnDv4/vO+700N2rMoRz/I7g13/5Mr5MBV7uOcDjS5xa1TLWFNsAzUx9spZCdHzYNM0np+AzF6v4n2x1gYDGDoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=u6iz365J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u6iz365J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779372778; x=1810908778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3uHkCr3Czag36uOPZx+WfiLBDM/EZRglKu7YFz6fG0k=;
  b=u6iz365JCaRj8ylvrIcs++kvxocuMFQc/C2viGrC2f4KkxO15tkacVfv
   up0iWaDPakWoKzRtskXjnANmFINJUwJMbN09fDMzGkNu83HzDscev3ZBI
   u1L/y5EjFs7hDFYbZDPHfjCW7jTUNcvT8rdnV48oZEAdNpD4R3Py4f3y6
   sVmYljOd2+NEcbjEtBYYJg4GZg8pzOTVliF/LjUo9Zbk38QGowy+NBsee
   uKuTPiIaVdJ3ObfEDN80oOpOwttyiqIXPFJnfnVHwItNgRVu3EoVSHeM0
   QK8/u2TWAd+E6HmNfXBKvuobnij8MZvXfAZs5t6L4nm7V9OGTmB0yIDTJ
   g==;
X-CSE-ConnectionGUID: 3cMiK0fJTeCaxLknjkz8Lw==
X-CSE-MsgGUID: fp/hYsMdTyu9+GLOBX8BnA==
X-IronPort-AV: E=Sophos;i="6.23,246,1770620400"; 
   d="scan'208";a="289245092"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2026 07:12:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 21 May 2026 07:12:50 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 21 May 2026 07:12:47 -0700
Date: Thu, 21 May 2026 16:12:47 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 00/13] net: lan966x: add support for PCIe FDMA
Message-ID: <20260521141247.h2ekfhhzblopjm6s@DEN-DL-M70577.microsemi.net>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>

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

I went through the sashiko review for v5 (gemini and nipa). AFAICT no new
series-level issues were raised — the only Critical (XDP features exposed before
the xdp_setup() PCIe short-circuit lands) is a per-patch bisectability concern
that sashiko itself flags as "likely fixed by the subsequent patch", and indeed
patch [11/13] adds the guard. The NAPI bailout issue Paolo raised on v4 is
fixed in this version and not reflagged.
