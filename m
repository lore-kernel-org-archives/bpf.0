Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA826D4F9;
	Mon, 23 Mar 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277537; cv=none; b=P23LPxEIHwr8vXtd2+RyoGmwqIR8u3Tq2XuV80IrUPJA3PTIbt0TMh/UZW+ivR5lZNFGXy3Ga2M+3bHJLmm8oiVXAet7Et5SEN7Rox7FARKnYWi3G72dnFtROoyNdK2mjGiSocGzSED/MY+JAA/G9lZ9CZBQyHFiKvgYA2piaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277537; c=relaxed/simple;
	bh=gEFZHcS+3f1UqHF/dEbEQNy5RrjhSuBDbPxycZkiY/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scdzrhWdiW1uyk6cou5Y3WphQlJKDuf8UK3Pb+Z3FFEIiEMHuCkSjjZbUfTm0Ip6GuBBa/jN85iMpvXtjjx6Nhk6V6+SN4ZlT/QR1K6g7PRChHfgR/F1ky62RDvWYh1c3cO9y1LTDeRMbpN2iMhs6Dsj1R4M+ub6GvDkicSx/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yG4RJGH1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yG4RJGH1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1264AC58080;
	Mon, 23 Mar 2026 14:52:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2CBF75FEF6;
	Mon, 23 Mar 2026 14:52:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E294610450F0F;
	Mon, 23 Mar 2026 15:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774277532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DLV+ANNlVjbThs16of3ozI8lyO1UcM7+YoV0gax8uv8=;
	b=yG4RJGH1jGCr5yIL/Iwc2IhbDiXPLapiDF42K57oGuQpanTOeCL9cWri01MT47AeaNS1kL
	jzCjTiD2U+xB8Cq/sL7WW0hNqvbTdi/rBc9iGTi40h4b0uUL/lvU33FleXNZ+rS9W4iEot
	qwUREqzZd4arajGvdGEu0y1vbMZ0JhvUPcKi7mDUGrWMYhcIAwLJF/xLPXKBsg7FiqJEpg
	2fFpVRhIUYWmZJZs/bfqZz29F8p/T7yBtdi/3rbh1RubbvvRtn0ZZf8KLJEDEMxWSGVFzy
	Ptrq/Ott4JJJua4bKROhr8BP5MStAj8zoFb2pLN/yFWoJZCXhTxG26QUA5pb6g==
Date: Mon, 23 Mar 2026 15:52:04 +0100
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
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260323155204.0321db13@bootlin.com>
In-Reply-To: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On Fri, 20 Mar 2026 16:00:56 +0100
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
> the network stack. With this, throughput increases from ~33 Mbps to ~620
> Mbps for default MTU.
> 
> Patches 1-2 prepare the shared FDMA library: patch 1 renames the
> contiguous dataptr helpers for clarity, and patch 2 adds PCIe ATU region
> management and coherent DMA allocation with ATU mapping.
> 
> Patches 3-5 refactor the lan966x FDMA code to support both platform and
> PCIe paths: extracting the LLP register write into a helper, exporting
> shared functions, and introducing an ops dispatch table selected at
> probe time.
> 
> Patch 6 adds the core PCIe FDMA implementation with RX/TX using
> contiguous ATU-mapped buffers. Patches 7 and 8 extend it with MTU
> change and XDP support respectively.
> 
> Patches 9-10 update the lan966x PCI device tree overlay to extend the
> cpu register mapping to cover the ATU register space and add the FDMA
> interrupt.
> 

Thanks a lot for the series taking care of DMA and ATU in PCIe variants.

I have tested the whole series on both my ARM and x86 systems.

Doing a simple wget on my x86 system, I moved from 3.8MB/s to 11.2MB/s and
so the improvement is obvious.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

