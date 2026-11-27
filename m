Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772554;
	b=A65jB8ijAyvaA4RIHX0ZJS36M6I9bKzAO0q2gvypL1L1zNvtRpLhQwD/Xcj3JzLD/qNp
	 1Mp/nTsPFS6GiI2bOTNlhkf08hsu7DMEvRm2oR2R9PKDdYNybyiccHVJS+PtcI0ETn3dw
	 9l7Co3oZVeb/YQvY0HVJ9WTi6c9OP+SH6vIS/1za0idF9r9dPOPIjOC1dh3RUmC1XlqGe
	 +PDzALghEaWEQfYTYtZzUVR+Ig1nNItDE79KpxbFRih8L/dD0LLwWAsIPSLbFAUcZmFqN
	 XUwjtlPwHOFgvQjkaxS//zppyIcDv0FSCwCO7xdBe1CPdlVRXzvkGrACzg49SCnbIxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772554;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xwPQDlQlJN42Ig5O+tbCP066ideoNucQAnKxdmUCo7Y=;
	b=WPdkF0c2POVH6E/zZGLP/blOXP/vxiFsBRSALEVgyRplDHUXSOPkGtOP4FZ2EwiEDALe
	 qlNmWIyU6D6al2Ju8u9W0FqcjLtOrmQ0D3M6PFd0nnY1AWaVc9XdIsvJqHNh/eqxoU0cq
	 9G+9iDRdUDRSL7oJKmz6Nn4Zbn2INhccVqqojhR6cQLwEhDvooGVsFtuZs0iXNEDepLyb
	 2FRaxuk8ajX0BusBu1k1uVYaNtrLkJO+uHSAZHxUadl81YFabOgSjNJG3Ldj/WmJArIgO
	 7AkWuSyqcuIOT0M9qOtY0kJP+jNZFWG0oE7OeuXeWohOpP9EGsYKwSDsloKcRng954Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=M75RDy7U;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF6606A31C;
	Fri, 27 Nov 2026 09:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84DF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=M75RDy7U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1795772553; x=1827308553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2w8vmJ70JZqInfPNxoBGVHO0Eg2269CQk35NBSdnMvY=;
  b=M75RDy7UxN+zpuxlG8dhtQ4S4riWsxK4X7fwd1h30pHWydEM6GTlrMET
   8vTj9i62n/IkSHpspfRe5NY/AE9HwVjueTbw6MKN2KUyxQGbPjlkUd8LC
   w3ohaPI/RSp3oZx6C2+vN3T7wLBAasZ7OEIHStMIq9JqKJzj98YOcO2aI
   kS9o9Ip8wC3Z1I+R0eO3n2q0dnNIToriL4nBXzn16w9HslZ/c9I9SJqfd
   pzlAT7nF7+mkkjHye/5FNmVU5acg1FtJcNIr7Ok2uAmFo9g68CM8zD+NX
   SUcgG9PgGVjRT42glFoWM3UVLAQLkgEJYh7wadhJa5f5mGtumhqQ/SVul
   Q==;
X-CSE-ConnectionGUID: lOB1Vim1RbSKJaS/OCc0VQ==
X-CSE-MsgGUID: EiLX8zZpQ66YKyWERBh+1g==
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="67349671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2026 02:42:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 27 Nov 2026 02:42:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Nov 2026 02:42:29 -0700
Date: Fri, 27 Nov 2026 10:42:29 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: return an error for XDP frames that
 are not queued
Message-ID: <20261127094229.hk6x776cekm4p6hh@DEN-DL-M70577.microsemi.net>
References: <20261123-lan966x-xdp-xmit-errors-v1-1-f25b6661167d@microchip.com>
 <d7c589fd-0faa-4f48-817e-66efee73185c@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d7c589fd-0faa-4f48-817e-66efee73185c@redhat.com>

> On 11/23/26 15:54, Daniel Machon wrote:
> > lan966x_xdp_xmit() counts a frame as transmitted when
> > lan966x_fdma_xmit_xdpf() returns 0, and its caller only returns the
> > frames that were not counted.
> > 
> > Before this patch, lan966x_fdma_xmit_xdpf() returns NETDEV_TX_OK, which
> > is 0, when an xdp_frame has less headroom than the IFH or when its DMA
> > mapping fails, without queueing the frame. The frame is then counted as
> > transmitted and never freed. An xdp_frame can have less headroom than
> > the IFH when an XDP program grows the head of a frame with
> > bpf_xdp_adjust_head() before redirecting it to a lan966x port.
> > 
> > Return -EINVAL and -ENOMEM in these cases, so that lan966x_xdp_xmit()
> > stops and the frames that were not queued are returned to the caller.
> > 
> > Found by an AI code review agent. Reproduced on a lan9668 board with an
> > XDP program that grows the head of each frame and redirects it to
> > another lan966x port. With the fix the frames are returned to the
> > caller.
> > 
> > Fixes: a825b611c7c1 ("net: lan966x: Add support for XDP_REDIRECT")
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> It's not clear to me if the issue addressed here is stats miscount
> (should target net-next) or deterministic memory leak per packet.
> 
> Could you please clarify?

The commit message could have explain that better, sorry. It's the latter - per
frame memory leak.

> 
> Thanks!
> 
> Paolo
> 

/Daniel
