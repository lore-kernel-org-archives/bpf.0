Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E369423E93;
	Wed, 23 Sep 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153865; cv=none; b=OYzsHfPHHVKCTnog3wspGy06V+hkAbOEEIom/+QGoA2MNc0V1yPpRfZ6Q9M1Gfv/BL+hCpS5NpVzfd8CP0Hf4kyX0TNARJ1232SUEnmhEqMRB+yrVSbxz9dSCol96/x4zByP3M6neX48XExyKOOE3pxjvVU8YdpJr2AAV30z30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153865; c=relaxed/simple;
	bh=5FJdFplcAurkiVrrdJQZzIq+BPrtSjzSqWntotIwEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGK5mdU4V6zf2FOQ9/I3NRDVSGPAgukts0PU3u58tsMxVovGFZUlRMoa/+K8cDLaXSs/DRuursmbl3mfavnfh9tENK4Vnz40j+g52Em4BFiKLPrRGSv8UaO0zssygIRkcV7hphpQ6ifAMqMQfqofbYuCS6q241+ZFBRR3UThoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KozDhSeW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KozDhSeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E95D1F00893;
	Wed, 23 Sep 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153864;
	bh=QKJrBHLETBJyIa6CWPgESXEOaNq+UTvSooBi5VGZCG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KozDhSeWWZQTg8qR1LTSNd/9vzq5RZIlWfhikFLT+D8L2I5Jz4RW/J/nf5mHhyMWx
	 wgXS1Q6HNz7cfa6/GeElIlb09p8dtUNS1+8zqVqOXIL43y5t/P8Lh20gnxcFl9NmVL
	 9/NSXMsohhFnPB1Cl+3hz7zgSVc7+ozoLDY2L90xLb52BcIsKkVBdbTPRHxQtreTay
	 TeNvdTFh8AXErqEoxXB/6Yado2ZKrr99gMmQdb4CtRLxcnPGxLVfn3rK6asisudprn
	 uTvoSyxmTOtHABCA2ICfTBZw9BG39E9UroKWqES3cl9xK/4Ms6H+te7w8FDX3Jyuo3
	 sDg+z4Sh35R8A==
Date: Wed, 23 Sep 2026 09:57:38 +0100
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
Subject: Re: [PATCH net-next v7 05/14] net: lan966x: export FDMA helpers for
 reuse
Message-ID: <20260923085538.GN13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-5-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-5-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:57PM +0200, Daniel Machon wrote:
> Make shared FDMA helpers non-static, so they can be reused by the PCIe
> FDMA implementation.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

