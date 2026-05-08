Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C346FDA;
	Fri,  8 May 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247418; cv=none; b=ZO5OgzHj6mJ6tKChLC0oM60P9C+g0ez5NqaHBGLDSTbNtaQoZDyNhSGjpHzQh/JDeY2kpnZ7q0WE6SQ3h3pttT5/UkyBEe3luKK5YxuTbizYUQBoelq0vq1NY7tgUKwFIfgG+IdutvWkSiTSuusvqWaLbemTxkpUVXB3rYr7sBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247418; c=relaxed/simple;
	bh=i50Vfwv1iTfIuXu0DUP6PeS+Eh6A64Cf/1UqNt+EBhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2zz7wQGc4wYsn8o2gP8YMQZgr1eid4n9skq75IynU/6rfZIjL4LaaHrF3SUCVdJdgDKY+TvtDdwckLI5iFdOK40N2bNqTlvuZz8R1scXeN4ujAPbqFgAd/v4+GFjVDB7HyIjwMd3N2Q+bfRFqqlR91r7Ah2dovvkxXSxuf/MTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rgMPQ7xm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rgMPQ7xm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DN4O0h+HP+4t4p879pcCyrpV4QGky4za+OSvHaDHf1Y=; b=rgMPQ7xmzpAXlMC2ZwX9x6BE1T
	Q5rkaSkenFlVdvXYru+zGx29blSGqUdYG7XLMT5KAMgLayL/KEEJ5OcFkN4c7kztke//NT2f/SQL0
	1VFSh8ON60HqX2HWqqFf8QmrKeEZR847R/ysXuX08tu3lZrWT3rydSQX4hcgiadFAexo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLLNL-001yba-Gs; Fri, 08 May 2026 15:36:19 +0200
Date: Fri, 8 May 2026 15:36:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xilin Wu <sophon@radxa.com>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
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
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <fc5d14d5-c65d-445f-90c6-9659e284c0ca@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <224E233C593EF171+8c8a43dd-5061-40f8-9eb7-f360eabf2ecc@radxa.com>
 <ae90a4c9-f027-4373-a378-d0d4b7796ff3@riscstar.com>
 <6744F8FEFD290FFD+4973b8ba-7d3b-45e4-8478-0b3334b81960@radxa.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6744F8FEFD290FFD+4973b8ba-7d3b-45e4-8478-0b3334b81960@radxa.com>

> Hi Alex,
> 
> Maybe I missed something, but I already have WoL working *without* changes
> in the tc956x driver.
> 
> https://lore.kernel.org/all/859776B5671B36B9+577c19e4-3e66-4036-b26f-fe20287a1d43@radxa.com/

Sorry, did i miss the patches for the PHY driver? Or was the code
already there?

	Andrew
