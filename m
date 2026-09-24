Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC842466A;
	Thu, 24 Sep 2026 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232894; cv=none; b=kXJvAXZ39ucAII+EUbC2mx0vC8S4VtkkU26ErMCcaYDnKUeJ2JLuW7dgcRh1Z2gwIb9TgmZovgDjgb2yiLSl4sRVEKAmQE6gKNnTZFuCMUjz/Y168bLGg1Ku2++ZV/zgh0ks/rbg6+kzTiWb+DFx0QAyiGjNaRFDA/WbM4JlIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232894; c=relaxed/simple;
	bh=jfvGirLUks0RGTEU1h/kj3ztA62f3Oc2pC3h3n5dYR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2+H8M2hyTZH5Fk7gxjfX25kOPw3pD3A5YIh7OMAVre3tAPqM20gNmnBCTCXSl3e9wk/8gO3aj4Ri3RqarvW1IK3vGTWBA9aG9l6bgK6VIi4jOo+bH+tmD2q5GJKzZ6Fs6BYJSfksC08C/rVWE1DfMH7/4lHuSXs9XQGhN7sPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtQngvU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtQngvU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436DC1F000FF;
	Thu, 24 Sep 2026 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232875;
	bh=+B5t/jhPSXcDtCr4sgosp99GBOYZU3VlvXjJL2sNCxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YtQngvU78cQ7bRp6A9FZCK+zxlT8nuBis2fITPldmcYR+ih+kredadetUJpdILfqU
	 axd9JXEKVJsS0qs346dBnIZzKzsMABFP2KwLW6FrtJIu4lPSquUN8rNTMSQwFf04bQ
	 OYpSY2nNfDRf2N1KddOQ8+XjxQCeCB1TeBlCE6UlkXdjcOMr76uyKj3OVeJcyvjpx+
	 xzZBMPhCqhHlYHxJEZm7aJbRm9efWZxE6zt3Bh12lyb4AgODsjxU4CtNIp4OMFO3dr
	 biP/ImfiMWiNkN4tqXFMqykzojH4LxIWYNmU9rtaKSW0TmQhevpRQEvvwCjoz6ZpNe
	 sUA5Ka/OU4pyA==
Date: Thu, 24 Sep 2026 07:54:29 +0100
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
Subject: Re: [PATCH net-next v7 14/14] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Message-ID: <20260924065429.GB13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-14-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-14-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:34:06PM +0200, Daniel Machon wrote:
> Add the fdma interrupt (OIC interrupt 14) to the lan966x PCI device
> tree overlay, enabling FDMA-based frame injection/extraction when
> the switch is connected over PCIe.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

