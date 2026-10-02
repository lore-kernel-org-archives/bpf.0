Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFF489FA6;
	Fri,  2 Oct 2026 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947556; cv=none; b=dzYJyXgpM/6q7dulzOY2mX3O7HEHkAXtmCV4ftY4AGfRzTtrHERgX7zyNLSIo9L4Bcto/lzBJbJIhX7xzFq/2rDkgzP0HomqZZUtcmRhJGqJoQFzqoJiQjYV+zLEfG1nLbM2RDGaF75mBmBeTDhbGS3hCsDe7EysITWr8CxR/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947556; c=relaxed/simple;
	bh=la4Slf1QHZA1G1NveHjiQUPOcv5H2yRVoCeezxnImrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEqHbD5XzF8UgCPzwm8+BmI88d1V4Ran9bfbE30ORyb1qodqBHiVYNayzJDGYCkbWOfuULgSEks9aC8CV4wS8PjjoLriHv/7g1jU8jwlbczt64iYyMq6rV6hRmFm7d6Yp8qwOCZ22k+RA1O9SFWir+lgVcHdSoEBEkgfrjR23Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmHxuDya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmHxuDya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85371F000FF;
	Fri,  2 Oct 2026 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790947554;
	bh=PbYSzylms7o12wuCPlSjyl59qP4qkoDF5kmaNChmMWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JmHxuDyafXnH6yN6mdvkdJmGGHhTaFZoYT4ccKchi2fE4Z+4PokAD8XIcNBYlMYvV
	 RSIZAUNlwRIPbZYcANRZUpqIKFhchZAkAusigMIXZutGLqGpXEmHfj7C9XXIesU0z3
	 Sh1/onvDtHA06k2nWqnerjLTR/tu4og1uik5eKrqpCsSe74TLF9kIX87Id3e7WiOrK
	 JZLWej9ZmCt10qyfJRfGIT5YPa4wysnkcucxRzDtgw5WzUwy8/+7Oq9GfQxWFv8edI
	 8Zxnl8k5KWF6GDUOPX6UgoXS8MHY7XJjbDhUVETVhU2qLcR2pgVxDYmAjIeh02OvBY
	 dYHjGwkxACS4Q==
Date: Fri, 2 Oct 2026 14:25:48 +0100
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
Subject: Re: [PATCH net-next v9 04/15] net: microchip: fdma: use
 little-endian types for descriptor fields
Message-ID: <20261002132548.GH13925@horms.kernel.org>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
 <20260928-lan966x-pci-fdma-v9-4-a17caf60f89a@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-lan966x-pci-fdma-v9-4-a17caf60f89a@microchip.com>

On Mon, Sep 28, 2026 at 09:32:52PM +0200, Daniel Machon wrote:
> The FDMA engine reads and writes the DCB and DB descriptors in
> little-endian byte order. So far the descriptors have only been produced
> by the little-endian SoC itself, so plain u64 fields were fine. With the
> PCIe FDMA path, the descriptors live in host memory and are written by
> the host CPU, which may be big-endian.
> 
> Change the descriptor fields to __le64 and convert at the library
> boundary: in __fdma_db_add() and __fdma_dcb_add() on write, and in the
> fdma_db_*() accessors on read. The dataptr and nextptr callbacks keep
> their u64 signatures, so their implementations are unchanged. Add
> fdma_db_dataptr_get(), and convert the lan966x sites that read the
> descriptor fields directly to use the accessors.
> 
> No functional change on little-endian hosts.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

