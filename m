Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAA400E15;
	Thu, 24 Sep 2026 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232847; cv=none; b=QIOrpMWLZBSrTP8siL7szUdI3b2BbDXzP4KsAL6Nh3pTKip2u1q0zZ8q/6TMJDJJoiD+zQ91UDHjAWXjvq6raB+EGk1tUfsHKjppbIP0HkTFQZJioSLDBwDEmCxGOooZekf2j1BxutA/sIKganELNurftAJAHFeD9DVz4vWU6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232847; c=relaxed/simple;
	bh=8Lo6LFpCiDWxS3SRqRrTc5Mcu/Fc0KRLV+Eg2oj+g50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLNEVLb8r4iCoDTFcaW8R7LLmEfBHP9unMS+8iGgDS1vP2ZRtkzjvec/14FxF9X3Yf0ydcgZtYChrkFxCfTrvD4nZdKIQwNrDuRlLmA9eL24zWpq0v3EtJsnPZKfknDYeWbXhQHAg0EM/J824BVhGmfMszd+vFJnhkZYkBdlVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cViPT28A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cViPT28A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9C1F00893;
	Thu, 24 Sep 2026 06:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232825;
	bh=v9U5Yx5v7I8BH9ZzG3vCb+fn78dwC+hyl9uOCicOfhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cViPT28AaCFTT7VyliU/cbiIZWP32lGsiq4ouP9bw7l1vf0LJbcApD5tXxvqt3HqK
	 FwYE4th7mb4fmjboLaC0D4vDUB0lGLJXO6/I8snfIDYq79y5UPqrLwRg6pxVO8teMK
	 iMH6AsmbfYO87Z8D0Z7TXREZXXUojvnhb5akylZGkCWpqa9fIXJxRg3YpiBZDAWFU5
	 cw/vmdxO1bA+LRdRVHgh85TqszLzjexFPvZjrYoQXGGYyrB2as2hbWEKgY+jJPGWVP
	 a2kFxmPFDCBIsqlz7xbH8pH3rgwSgyK1J6/fasTZtiuTtT59mcZkl+8YlrV2lOJzzR
	 eGZn5xnZ3/XFQ==
Date: Thu, 24 Sep 2026 07:53:39 +0100
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
Subject: Re: [PATCH net-next v7 12/14] net: lan966x: add PCIe FDMA XDP support
Message-ID: <20260924065339.GZ13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-12-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-12-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:34:04PM +0200, Daniel Machon wrote:
> Add XDP support for the PCIe FDMA path. The implementation operates on
> contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike the
> platform path which uses page_pool.
> 
> XDP sees the frame with IFH and FCS stripped. These are removed in
> lan966x_fdma_pci_rx_check_frame() before the BPF program runs, because
> after the program returns the driver cannot tell whether the tail
> region was modified. The skb_pull/skb_trim previously done in
> lan966x_fdma_pci_rx_get_frame() are removed for the same reason; the
> frame pointer and length are pre-computed by rx_check_frame() and
> passed through rx_get_frame() and lan966x_xdp_pci_run() to the caller.
> 
> lan966x_fdma_pci_xmit_xdpf() handles XDP_TX: it rebuilds a fresh IFH
> in the TX slot, copies the post-XDP frame after it, and lets HW insert
> a new FCS.
> 
> lan966x_xdp_setup() is extended so the PCIe path skips the page_pool
> reload that the platform path needs.
> 
> Only XDP_ACT_BASIC is supported.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

