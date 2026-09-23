Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADC471CF7;
	Wed, 23 Sep 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153721; cv=none; b=MkiMSqUW+/CuJ6RyfeFsR/YxHqe1YGAePZsxdlh4XPIvtEP8061OlLKBe57yRfJxgnU9nY5l0w8O64ZrIcbIRk/u9vJlzRu0F4sxDy3UVrBCmZTYxtUz+t3SriJp9DEqX2dD6UWA9UR4bNoV76npGV2B6oh7GmVnVpaj3j/MiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153721; c=relaxed/simple;
	bh=xE2IWCqMbPk5DBRIkHHAxIcJ03Qg45uYvB8gQsrMlsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snbBjI2neiY2ih3979dRlsfgY4Xaw3r3YjqGrwg0I91mC1chdeG5xYgSlOdC4IyMNpEGjPoDzcb6FoI0QvypRwDwkMZa0bGwOZ9I32obpJ8n8WkJ7jL7ZjzAN0AfyCendhSsgnZDjm+hjSMEJf/C/pp1IXKo75tGM9RAZ9qMiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iACzQIDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iACzQIDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC871F00898;
	Wed, 23 Sep 2026 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153719;
	bh=80DZGmjDiR4Bg9Mnkz01B8NPJILVq5/IaueQvHOQ1e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iACzQIDDqwQYRnvhG9KkuG0heW/4q3SDDtbBW6U3CqrXRI3/mCeelAApaskR6VBPB
	 NUoief6+g5RW67Z/DNil33B6jzZeazIQLQFCp+7B7DOJ3iebE61O7rUWemyLYeQxNZ
	 L1xtANiGEvJBwnBtbPAXK9mlB8UasThAaT/3P9NtAob05M+vAZ86tlj2GAwlYP0kQt
	 T38Z8l3XATqB4k3TCFixC+Tm8BR5wxbk+dqu6KHoHr8fxF+Anu2dcLeHsEaJGEwT/t
	 l3M3eOkCqwCqeHsib1ylNFEfeKru04l+VfM39z1IERrQa3lpYZsUYBzoMHMDun6JBP
	 qHVAV2WRfkpTQ==
Date: Wed, 23 Sep 2026 09:54:42 +0100
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
Subject: Re: [PATCH net-next v7 04/14] net: lan966x: add FDMA LLP register
 write helper
Message-ID: <20260923085211.GM13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-4-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-4-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:56PM +0200, Daniel Machon wrote:
> The FDMA Link List Pointer (LLP) register points to the first DCB in the
> chain and must be written before the channel is activated. This tells
> the FDMA engine where to begin DMA transfers.
> 
> Move the LLP register writes from the channel start/activate functions
> into the allocation functions and introduce a shared
> lan966x_fdma_llp_configure() helper. This is needed because the upcoming
> PCIe FDMA path writes ATU-translated addresses to the LLP registers
> instead of DMA addresses. Keeping the writes in the shared
> start/activate path would overwrite these translated addresses.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

