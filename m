Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89527453;
	Sun,  7 Jun 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780854807; cv=none; b=PKOFFjLuajzjcKBuazg3dWVeMFRMPjYLB4gR30yZVl8/HJq4TGh+tV7gqUa6c3Mb4CjsbFxuuhyI419HZgkmpP/ByR3LbPzTLCod5U2EppK8b0H0+RXQ3FMVyax8RP5SW8WgZ1xeUuMNoIrYiyGWJzHPIAeXH9CHWtTkG7yx0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780854807; c=relaxed/simple;
	bh=Wp1sWLpC4lb/tpO67nATgDedJ2AC/9CZP7Uafk3jLjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Reeur0gZnGDDQN7EFcCcktu3IN00EZiEfwMmo0L18hM41UMxtbaCprvjtg2LdKc31blJ1gqHUbFStOcJ3HffwkF3IRGq0/QxlvFdws2iPErI0WJQgAI31H9ZM4r3v/gEIxf5ZtPdFlOQSA1/cQxiR7P+wTkYMR746DGPP1cNPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0kEo+1js; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0kEo+1js"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RC4UpJZWJ3dXT7LKa11Eh5lvkgD8MR6nBFl7fzqu7wY=; b=0kEo+1jsZFmFPuILPU9h2Z8lK0
	Tw3q/RsYcediV3XhUhcgz1JZyCPjTJbVqiHFhYhnrYRh5JjHvOVU4aib0LsSn1jxM9cKym+PQh0z+
	bIovlTt9IcCUj1kEWGq/mQ6LuxQ+pbLPW6ZZ/t/TAnOA2bZRwcQwVSX+NwRlbO4jA79g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWHg4-006UW9-B8; Sun, 07 Jun 2026 19:52:52 +0200
Date: Sun, 7 Jun 2026 19:52:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/14] net: pcs: pcs-xpcs: select operating
 mode for 10G-baseR capable PCS
Message-ID: <1225f728-8b54-44fb-bf70-94e3966359eb@lunn.ch>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-6-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605010022.968612-6-elder@riscstar.com>

> Rather than introduce another quirk for TC956x let's attempt so solve
> this generically by setting SR_XS_PCS_CTRL2:PCS_TYPE_SEL to a reserved
> value when we detect the right we detect the right combination of phy
> interface and XPCS feature support.

This sentence is broken.

     Andrew
