Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5CE422558;
	Thu, 16 Jul 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208812; cv=none; b=XFE+YVaEYwXi/jcZ4yWjJDyxPtrG+3yEwJPw6iBCCzjHStFxfwWn1rEzXKoyT3vvTMIbK8dH5YrxbxaKBfYBUXTRX2i7mxqn03OqDfoJKikzftRjZd3ZDkRuNRhy3HKBIKZkmWp1nfqrIBi6F6T37Tq3cGlVPErMB7DJe7hTQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208812; c=relaxed/simple;
	bh=sutnjoYKI2uVHpmK3k6RbhRFaXqmJzyJrir0HTQz3EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbpmu2s9DtYXapfqQ7n/8AbXSevfDj9zPyY4jFd96VnqXECk2ZNoHVJ7rYLiqrIk+q0QWCm5gZmp10qb8K8cOMPl/U2lgcVJnvdlxJW/G1TTH9amLS/+obVsEEVkWDGVrfMJcc8mRcT8j6ULJi+rFeqaP2OPGpohNPe5dbuYI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GE9EZj0M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GE9EZj0M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b/4bHkOK4at96eLi17OSQbFBAa6T8Ge0kCnTS4mV0XM=; b=GE9EZj0MYInITLNkWghARYJn9c
	3I3MIKvsUMHLvEISRgyhU87kM7KhC3tTkIMOBOvi1IDNYce8Q9tG3pPMTqO4RFp2nQkqS5UcJLe+l
	Lrbyn5kGOaUaTMR/bz9K/CLA/GqGklz4Zc1TRe9Cc7ECajMePYKXp1ZB9hXYEHA/rw2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkMCl-00CXL5-Lt; Thu, 16 Jul 2026 15:32:47 +0200
Date: Thu, 16 Jul 2026 15:32:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
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
Subject: Re: [PATCH net-next v2 12/14] gpio: tc956x: add TC956x/QPS615 support
Message-ID: <a955ec54-c9bf-42a9-8477-7a4620b155a7@lunn.ch>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-13-elder@riscstar.com>
 <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>

> So we need to make sure that the GPIO controller driver is available before
> enumerating the switch device. One way to achieve is by creating the GPIO Aux
> device in the pci/pwrctrl/pci-pwrctrl-tc9563.c driver and let the GPIO
> controller driver use I2C communication for setting up the GPIOs. Thankfully,
> the switch allows both I2C and BAR MMIO configurations for internal GPIOs.

There was a comment from Rob that the GPIO controller should be
associated with the upstream port of the switch. And there was a way
to do that.

What we need to ensure is that the GPIO controller has an independent
lifetime to the downstream ports. That would allow the downstream
ports to return EPROBE_AGAIN, if the GPIO controller associated to the
upstream port is still initialising.

	 Andrew
