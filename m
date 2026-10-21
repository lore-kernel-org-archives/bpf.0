Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558424;
	b=grBcmKL0T0dpUNjb+ij4kdaOcZVgsOEx/MoJBN29Fq5qGXEMWPyYKIDj1a0L9tgt5gRk
	 M5Z0hdPaB2A40se+H8aDiMVrz5f5jrY/8XvNVRUmc31O4rWvRjZF3e/OtIaFf7fcrxpgV
	 B7hKEqUQuJGX5ya2sVFIj16GQJtV3+/T802gBJDFfQCe1y5aWqSMrmGsiXraWDsqgs4Vg
	 bWE6nqH5QIqxDWhs5UpAcwp2Ehu2CqJzqWVG4GIyfFX6hTvXhSXiOi4/GsM1N5USOHIUt
	 ENA+8c8bvCyO6FEyJ0vHoXVJfstFMQabq+5A13UIK7N642Vz0imXjxa1x8XvCxG0lRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558424;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fY7ZTK1khhR9HlmoUz9qcKC7kwN/J1ah6/E5o6LMewQ=;
	b=uxjoY1n1cG6b7MdZVTFF2tB0DMdMHAZ1BxKkqUWtwI6m3A4opk19rBX/DKd46p4mhfMR
	 sulTSIyTpgQg9joQPkvm4vvWdWN4c2HPqW149Jlb9RDuCMZ/T5NRhYm59i27dxHSGubzS
	 o8Sc6Ghdb//C2YGbznbUeOwQQwVRJ0P2H30bRgXSM9W/yJ79WzuaWzRzRxg4lWLCgDDMc
	 LHwulX61bbGEK3mfutWCcZI9LSSdPgTY/WgauhjZgj1oJevWZlv+xC+PKjCXScyBWn45V
	 wUj4O/huH1XVHORolZCJTYLhn12YDcIiShWlreaCexH+f3Nqp/ZfjfIR0ULdOUJzCbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMLszvUQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54F606A319;
	Wed, 21 Oct 2026 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMLszvUQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532D81F000C9;
	Wed, 21 Oct 2026 04:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792558423;
	bh=fY7ZTK1khhR9HlmoUz9qcKC7kwN/J1ah6/E5o6LMewQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eMLszvUQs7ukeFBPwrJfmZWfGvBTWdq70mWd/uZXoS+bgyJHJ9rwlonaRNdYiSOqH
	 iLs+tPhNqfnvqH8R5g5MbzU688cdJjc+FxOhbnx6r+Tib8sd0Eu30SeBpeMOdavbYp
	 JacSgzHAaWwm/j0EjD7R+ZfsbSwit7aYXTYaKLjhenT8/RAOOm195QBGrRfFodO+4D
	 0/0IXJHsogxgYgYYBwo3uWrkWGpF94iz/9a3FALSNOalfZLbG5YkyH4Xny5gQuqQoF
	 LG3os42pqfsozDdhcjpY001PbJS2GJVG3/inCrm7bgev6v2n47VoElwiWWWiLliR+M
	 HDI1MgUE81w8A==
Date: Wed, 21 Oct 2026 12:33:37 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload
 for jumbo frames on bugged cores
Message-ID: <athAoWfW-xesPhFP@xhacker>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>
 <ata8k2EVDCDTmeE6@xhacker>
 <atbbRqSJIJ_glwuf@xhacker>
 <3ca537e7-c9a3-4306-a2f4-9c7d57123bfc@lunn.ch>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ca537e7-c9a3-4306-a2f4-9c7d57123bfc@lunn.ch>

On Tue, Oct 20, 2026 at 02:28:26PM +0200, Andrew Lunn wrote:
> > > Here I want to query a generic rule from netdev maintainers:
> > > can XDP frame enable HW checksum on dwmac IP? Per my understanding, the
> > > dwmac can only do HW checksum for normal particular packets layouts, such as
> > > TCP, UDP. What about if XDP transmits a non-IP frame?
> > 
> > or a generic XDP guide from netdev maintainers:
> > Since XDP can tranmist arbitrary Eth frames, so how does the eth driver cope
> > with HW checksum if the HW checksum is intended for supported IP packet
> > layouts rather than arbitrary layer2 frames?
> > 
> > choices:
> > c1. Simply disabled HW checksum by default. Then XDP prog must provide
> > checksums themselves, lost the HW offload cap for IP packets.
> > 
> > c2. detect the frame in eth driver's xdp code path, then enable/disable
> > HW checksum accordingly. Then how? Any example in exisiting eth drivers
> > is appreciated.
> 
> Why is this specific to XDP? Cannot the network stack transmit
> arbitrary layer2 frames? Isn't this a generic problem?
> 

network stack normal tx supplies the skb->ip_summed metadata, and
dwmac driver specifically can decide to enable/disable HW csum
by checking the protocol which is extraced from skb, example
stmmac_has_ip_ethertype()
But XDP path doesn't have the necessary metadata, and I'm not sure
whether stmmac_has_ip_ethertype xdb version can be implemented or
not. That's the reason I request generic XDP guidence from netdev
maintainers.

correct me if I misunderstood something.

Thanks
