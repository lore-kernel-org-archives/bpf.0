Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390BC30ACF0;
	Wed, 13 May 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682980; cv=none; b=bv7M8fxERohj2MTjEdT9sdw4yL3pCM9x0NZwkMt/zNCEAg5b9Pcjw1EQj2EkUdwtyGNFsOp9GsZ70i9V1NRZXrasb9JZV6kIcAOYm+eMnWcTBdLQ23KWSECPk0KofzYdu4tLr4ARxAuWswiswyLMVe17aeNP+Op/xoUpXLkyE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682980; c=relaxed/simple;
	bh=zwUR1eHShPPZ9lB5bypUNce39ZAQ4/I1sdJgnm8K8wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTNCtoT9suARdq8Mkoybq4zEwhzUN1ZR+6HIcSFwANypc8HffxSSX+dvoI9ob//ToHA2W8LPgWjPn+VspJeY2KDJQ7I3PqoGYDD5M5nHoAgXQMmNPptfx4+zd6+IrjYpPzb5SoaWGGVcLV4o65RhcTx2tynb4Q2PkKuywFTV9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2HNv8zGb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2HNv8zGb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vAC6Dx1bYdYmm99hm7L/Rk1otq4N70/MGZs/jd52WJ4=; b=2HNv8zGbrGCjRBDW2PdfPDHxrr
	cEwf7yz0O/f+vjkN3cRdfH+LzkGUrRCIc7S5p7/5dmTHvyo/d+76GyVjIoXWVcIRMzOhxVT+odN6n
	9NpT8yd+fTh8sQAyvO7ZoSYk7yAfSQOd6vLezWAgwqzbWEptx3uNiuP/tWcHBEhY0CkI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNAg5-002kXv-TE; Wed, 13 May 2026 16:35:13 +0200
Date: Wed, 13 May 2026 16:35:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
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
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
Message-ID: <3c6e7ec5-f600-44ee-a97a-211a99102744@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
 <01d6ea18-e022-41c7-a642-ac0321957923@oss.qualcomm.com>
 <agRzai1UoHEIotZe@aspen.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agRzai1UoHEIotZe@aspen.lan>

> However the real reason we jammed this on is because I couldn't find a
> way to get the phy/mdio code to turn one on. However it is possible to
> add regulator support to MDIO devices by extending their existing logic
> to manage resets so it can also manage a regulator. It comes out fairly
> clean so we can add that to the patch set and remove the
> regulator-always-on.

We, I have rejected this before. It might look clean and easy, but it
is not. How do you determine the order of enabling reset, regulators
clocks? How do you specify the need sleeps in between these different
operations?

There is nothing in particular MDIO specific here, and there is
generic power sequencing code in the kernel. And a while back,
somebody said they would look at what is needed to make MDIO busses
and Ethernet PHYs make use of that generic power sequencing code. That
is the better way to do this.

	Andrew
