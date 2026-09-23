Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB934718DE;
	Wed, 23 Sep 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153991; cv=none; b=gcM1Pe/aPfo91ehTgAGs+CUzWWChusvwAf0yLMXo8RvlW4of6sDSKHGxbYctViFfYNvSpcWv+ZVptmnzTNa0rKuLuLUexiKHM/KzKmIVnAobmBfoFbWe8qIThIKtK0gNtUvxNJomavnYiCuIWLHC+aTC3xUm439h2VLabfvpy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153991; c=relaxed/simple;
	bh=LauzTU5BfdHLdmOz27r/Tc9Ii6E9HVCJLondgVl496c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apVzVFPxV/nRszsDJOqkGToQSf23pkvQkQGcXpNTckzfgmJCyGxYsGW0IkgzzIeLx62wakX59gzJWGn3ebD/dK4JnrrqdbGIKyYJjWySOVl84cQDlUzeQ4L6Gi/TQ37yp/n7nDM0RN9Z1/4CSAEGER9umAWEl36uGqeeXg9N+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjFIRYRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjFIRYRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D081F000FF;
	Wed, 23 Sep 2026 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153989;
	bh=w1m1NFZV8Q6RkXAfcNO6sJC9PIZku3p2KtNeqepoHJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OjFIRYRKDDlKIr3AK+V41zIsPpmYTNPmtHkLw/tBWf1NXG0cvID6+8RkgQU+X+NHR
	 Kk3LXoX6iD9VLpTczeOhh42F/BWpwOjYR6pRPahxLp5tGut+zmIZKTbqS6x/Riy3N5
	 4w+D/FQorat3zPOgh75Fzt34GXaCbsuweLUyo3gbtp3gbvcV5YbAH1dQO1hngPCqXD
	 /rCSfwuuAs6uvnzVFaGgFjsfom0RuFnSBAYbTQ7AIs0jDaFfZxkNSTl45Rxth/WnuY
	 LsZxKGzTESvKffs2s12VssCMN/IuNvlMjOQD2s7j50MbW2R9oEPDeuVv/XTBq874Ay
	 mk72nb2qFGnmg==
Date: Wed, 23 Sep 2026 09:59:43 +0100
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
Subject: Re: [PATCH net-next v7 06/14] net: lan966x: use a dedicated device
 for DMA operations
Message-ID: <20260923085807.GO13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-6-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-6-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:58PM +0200, Daniel Machon wrote:
> In preparation for the PCIe FDMA implementation, add lan966x->dma_dev,
> resolved once at probe time, and use it for every DMA operation the
> FDMA path performs: coherent allocations, streaming mappings and the RX
> page pool. Natively, dma_dev is lan966x->dev, so there is no functional
> change.
> 
> Since dma_dev differs from dev only on the PCIe path, add
> lan966x_is_pci() on top of it, for the later PCIe patches to key off.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

