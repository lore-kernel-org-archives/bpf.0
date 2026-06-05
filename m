Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28E3126B1;
	Fri,  5 Jun 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675575; cv=none; b=YLZf4R1xVPK2r4M8xjfERhTE7Hg+UKLECFpVgDZeygQi8QxBGWCaxXpEiVXasRSvYaqL+8a1aXOjcE8/l/5idzLj1iu816JiFcbmyHvYonG1riNa+30malDbyIyizWPo9is/PYhmsYzNSyzhs3iXVyukR39zv5eojfn+FWT0wtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675575; c=relaxed/simple;
	bh=lbQ0ZHWF0gkTF8f1YGmLlH6N5pd9CUfqcDjT2PzWmrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/vlczdGkKZwvt3w1zRdmPOMaMSQR1t8M49teDjM48l0vRnucrnRMWHMTspx/VcnukmEYXf503TVFV0n5CHOmq3TXzPUqO3DGNjYLEFC9zns74gklc8DwJzvmGEL5Jb/TKqdN5kbcfL6nHBuhnzaUqVUeA+P1DAXksQnDoq2oxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zvphM/Ca; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zvphM/Ca"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F166C58478;
	Fri,  5 Jun 2026 16:06:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FF855FED1;
	Fri,  5 Jun 2026 16:06:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50A83106A2533;
	Fri,  5 Jun 2026 18:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780675569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xk45BjVakQOeHi7wm8QKE6eINYQ/jNZGrkwgZV41tIw=;
	b=zvphM/CawlI8lv+bypTyNGk5QI0aaFSd+ta/nOlof5HxsbAqYwrTcdlBWPnIuvZ2nkCCPu
	hbcuN8XA2utGYiVw3vAMz/EUcccOZ6nAVIPhuIwnmU/ZvEKqcCf+mrXrS7xQPsGjH5VnyL
	jfU+2CYStZaWkh9I/v2V82G2VXEFEMjU8prhXTzet2GaJQCHCWFcuFFJnXiVHMYzele/m8
	M2jI6t+La0RoeTKiZzWM/fX9/gkeeAapQr2r4/psEj0S1ukX9nQtJ224jAudfxQR6QRZIR
	I2AoympPGcN2+ig3zx84LnAejH56/NY9zf9b6R90qA0XuuKGwk4feZJ5SaU+tg==
Message-ID: <c60d1819-18d7-4d4c-a997-586599323d7e@bootlin.com>
Date: Fri, 5 Jun 2026 18:05:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-14-elder@riscstar.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260605010022.968612-14-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex,

On 6/5/26 03:00, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> Toshiba TC956x is an Ethernet AVB/TSN bridge and is essentially a
> small and highly-specialized SoC. TC956x includes an "eMAC" subsystem
> that can be accessed, along with several other peripherals, via two
> PCIe endpoint functions. There is a main driver for the endpoint that
> decomposes things and creates auxiliary bus devices to model the SoC.
> 
> The eMAC consists of a Designware XGMAC, XPCS and PMA. Each eMAC is
> supported by an MSIGEN that bridges TC956x level interrupts to PCIe
> MSIs.
> 
> Add a driver for the eMAC/MSIGEN combination.
> 
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> ---
[...]

> +static int tc956x_lookup_max_speed(phy_interface_t phy_interface)
> +{
> +	switch (phy_interface) {
> +	case PHY_INTERFACE_MODE_SGMII:

The SGMII definition we use in the kernel is the Cisco SGMII de-facto
standard that only supports 10/100/1000M. Some vendors use flavours with
names such as HS-SGMII and such, that's basically SGMII clocked at 2.5G
with aneg disabled. It kinda becomes 2500BaseX then.

So all in all, we don't support 2500M on SGMII.

> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return SPEED_2500;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}

Maxime
