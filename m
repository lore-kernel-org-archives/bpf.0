Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3B43078B;
	Thu, 30 Jul 2026 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418532; cv=none; b=kWsQZ3JLnFpEjzhxdCoIK5s8gxDIQVfZRd3CGq2l1HcvMe1G7E8EAMRDCkpbjfDB76lWuL9N3etgsUjamg9FIn1wMlG4wFfKABppqgfYMvo57xhPmTJQOdrp7ErcSC7TkybQT6JSuN0AkqEBRyVXzPOtfkNM/LyKwo9lci5RFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418532; c=relaxed/simple;
	bh=Gd4CVRXHjGRZ7SXbAMmBL1rNORTNXLyX+Y4Y3ao/bxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxLVFJrpIctSg9gvZ/Zkq/1lINRr2tFoN/kBYEEHOckPHwh+DHBy6knS3ZGcUsgztgf8nUgy0Q3VZy/3eBL0kzJ65rsdjH0ESm9zLfMBnLF1hd/S3IIV1xS04MTfe4nljLW/7zWhAvBk7DKWyxYSiMyNpnBadLkq1yJ2a1jbb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rg9kiSct; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rg9kiSct"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BlBBYwRTDRAaiDfmDKu0GwfXvFKTY8AE4ZGeeeheVu4=; b=rg9kiSct5RsdD6WKRqypNdkEGp
	KtuI1/9rIQPhGOXgZtqcDiVXyWmAi9A5qqqZl8VRunovPlSSzj9B9K9wZmvRyYqQA/l9fg55o7BVF
	KVCjrYNwP3tXBh0UHymSYZ8gYLTXr3HHXQF+ROdplejQU3NFpa6IXeWxeYp0usCmsX9A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpQuj-00F0oL-Ax; Thu, 30 Jul 2026 15:35:09 +0200
Date: Thu, 30 Jul 2026 15:35:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Message-ID: <ad3249e5-c607-4516-bf2e-63879e168272@lunn.ch>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
 <akzLgrzsw4xYmnLH@aspen.lan>
 <9f949b97-da81-4bdc-8be5-68f7883d768c@lunn.ch>
 <amtQjCV6Oi7UI97t@aspen.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amtQjCV6Oi7UI97t@aspen.lan>

> After review I found that moving the disable to stmmac_xdp_release()
> does and removing the call the stmmac_init_chan() gets things most of
> the way there. After these changes every action in stmmac_xdp_release()
> can now be traced by to corresponding restore code in stmmac_xdp_open().

Great, thanks for finding time to look at this.

> It's not fully symmetric because activity in open does not appear in
> reverse order compared to release. However it definitely moves things
> in the right direction ....

We cannot expect stmmac to be fixed all at once, it has too many
issues. Maybe we can ask developers who need to touch some code to
spend a little bit of time to also do some fixup in that area. So we
slowly chip away at the problems.

Thanks
	Andrew
