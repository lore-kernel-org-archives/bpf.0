Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F42FE07D;
	Fri,  2 Oct 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950502; cv=none; b=msMZqv0DHYu/nV61rJpGv/LB5coZ819thOQF9LoOton59EwuilTBCygoGd4ux3taawFxSNbJqHtyH2xDS/pSI8cjez2WWNaVKr/1fP/+8doiQRBTwYhyEN/C78zsRQY9b+2zc5Qli4/0gKEhrGJxPNSAM9A2Ex1zwqO3CwPAGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950502; c=relaxed/simple;
	bh=pGs23D4u3ckYtC8BpfKB+xFMQDH4WAEDjJfi4D1e134=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khnvuGUOKnguKYH8ncL9ih8+t2bHnwlEcZs362QNJ6BhCUzmvNjLpoOAVPj1ugjwoxGiBXBz2k/fdTMvXx5la1TSIK+IRFKE4lwqTnVTxyHywVxbrTSiGckg2RAq88gTAa265TcCA48y3oWHSRusCrxvK7j1VPXEbdHW3u+Gv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7QQYL1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7QQYL1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB41F000FF;
	Fri,  2 Oct 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950501;
	bh=6zgilu93Hp4FlU2A2Q+0E24y0uk6qApz0rFUUk+jie8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R7QQYL1Nqt64YeWSigZIxuY27nMZq8IArDoFjTRP1ex7LDXrfdfnoi/DeCe4ewvBv
	 J+aYs2ahtRXbKTYd2IZJEaeMW2GE6vPhnRFAfmgsGc6zVUrUMgx0ncrZ7Wmtg3PNg+
	 Y4agbe7YQKBZWjhgrKoKZbLhzUqp2SWvB1C7MEJ9mNsAoabBcqHjxKixMiUByeWh2o
	 wMUf73wkyqMRhd8HnXu5vbtoW2PGIQJ74y1IZ6fNk4P8/MnNbRsdk6reNa4bypV1ki
	 XsAjmqjn0F0oiaTK77tEJU1tF2e3LTjLw3gzoZtHJySHeil/vd7ExKpoUkw8rr0Ya3
	 OTDTpiIYRBizQ==
Date: Fri, 2 Oct 2026 15:14:55 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v9 11/15] net: lan966x: add PCIe FDMA support
Message-ID: <20261002141455.GI13925@horms.kernel.org>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
 <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>

On Mon, Sep 28, 2026 at 09:32:59PM +0200, Daniel Machon wrote:
> Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
> DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
> transfer instead of per-page DMA mappings.
> 
> With PCIe FDMA, throughput increases from ~33 Mbps (register-based I/O)
> to ~620 Mbps on an Intel x86 host with a lan966x PCIe card.
> 
> The RX path uses its own copy of lan966x_hw_offload() that reports back
> when skb_vlan_untag() frees the skb, so the caller can drop the frame
> instead of touching it.
> 
> XDP is not supported on this path yet, so do not advertise xdp_features
> and reject program attach for PCIe instances.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

