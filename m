Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4934313E03;
	Wed, 23 Sep 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124471; cv=none; b=EehUeVdXeI5EXkrsEjyvp2VATZjXU87hHASiZRWFnCxTRthvA1nQX2pkeVfo2Qrnsi2YGdtQ0GWjE1K9SdoxWfgAlwxGF99o7+1BvwaedjlxVhanQnTPJXkenUWJwAwsESQNpjAJOlzpx1RHwLhgCF+Bjm8WproCH+ALnZ6M6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124471; c=relaxed/simple;
	bh=B4ra+2ZVhen2q9WjThUNe5NN3AdNdGl8yD8gwXgVeuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS4k5llQCGWMWf5fmiZjSmoeCkcaf+X6XuI50SpasIo7qW1y0VkfLcSkQVbC2ZF0k3y5/dAtjSbNljZVa83eveqUAOVRlPVJfGMgF6tUEn/WG706isnXJS3KNtc/lrCq6XPo6e0LsMwzaQjmzj3qTKe/GUhgH+JdXh4G9m/CVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TX8yDkcx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TX8yDkcx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xGq9rwKs6zOSERDHcPXz2t5IH8ioYzNY8P7u5lh0XZk=; b=TX8yDkcxbI/5urihg4q3EwAXyu
	7tesNQWje7Dx8qwWKaA4+9rkx5m3d6PPAGfxaZ3CU73YxZdyjB8zW9Jd1RnKT0vyM1dN+97nlFysf
	NYySCAx5hUqRhq4DUd8DAafOH5xurHEhwNraT7mLGHXJaJahlNEctea/yIiVYpa8d54E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9B8v-006hSd-KD; Wed, 23 Sep 2026 02:47:25 +0200
Date: Wed, 23 Sep 2026 02:47:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Alastair D'Silva <alastair@d-silva.org>,
	Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: keep datapath state coherent
 after reinitialization failure
Message-ID: <af3d89fc-0fb5-41a9-98ab-5a7df4c10173@lunn.ch>
References: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
 <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>

On Tue, Sep 22, 2026 at 05:27:41PM -0600, James Hilliard wrote:
> An MTU change releases the running datapath before reopening it.

This is the real problem. Changing the MTU should not release the
datapath. 

> If the reopen fails

Why is reopen failing?

You want the driver to allocate all the resources it needs before
releasing its old resources. That way you can always undo part way
through and still have a working interface.

	Andrew
