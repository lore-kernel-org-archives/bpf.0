Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49C17C203;
	Wed, 22 Jul 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737311; cv=none; b=PmAw7g90cfYsMo33keeO0NtZHtz8nvQK83TjvBf3KkfC9k6Fcr2CEtWKnK36tGIYThC0cnNaWFHXVvUaxt+Beg2S9hB503sVGmhI3TK3Qm92el7cne8BO3LeBpgjgahpV5jq6gGBQjJ1irRV7/1P1VgNYSLTbHORfTnX8GvE6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737311; c=relaxed/simple;
	bh=omm2nkvYVT2e7Kvy4LbP2okWMNimmvmsrgFo6mxCWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwyMxGPQoDDQB8IAk/ZVBJrVkNOuaH2Gsr96fT10RgIkw9urDKBGPVX/gLBV9g3HCSq18xKQzlQRuqxlzttom21lRnk7jwc6dcBgKD09wS+1Gfnrl2/b1T/J6JtR0vXpOKbjwBzRF9vIXHWG1hvBI7GMVuh6zjNKdC/fIqiKjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1Yl/ye9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1Yl/ye9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F581F000E9;
	Wed, 22 Jul 2026 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784737310;
	bh=X4nlqSDTQfKgXnssLdmt4BpD3msEFfZZnZiCI8vkwJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1Yl/ye9GP5zGKTMMfFEQjKOVnbf06k9O6M9LFLkIXuL3qh8TZ4CE1JuxW+NQxlt7
	 j6DdGu1sHJhsqKlIh/tvLdfemqB+/FJU+2jHRsbhCfmd2/RxFGIBRi7FQ21FqrJlLZ
	 TWrVkMVfbhn5cv6lGEuM4mp0802PWhXMSIKzx6NU393U8iT7usXc41YoxRmbQNqRAK
	 ZWau1UuybNFE2JOfF6ithDRuCR1LdESOauAZDApQWntLyTj6Hto12+L6kuGbX34yaM
	 3ibRtv/kBrl9v1RCfklHGv5Ljsq+8D27BKJkzmOoW/LSloBTphcwdM8rrVADvm4V21
	 giYYr9J77kX5Q==
Date: Wed, 22 Jul 2026 18:21:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, daniel@riscstar.com, 
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com, alexandre.torgue@foss.st.com, 
	ast@kernel.org, boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, 
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com, 
	inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com, 
	livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com, rohan.g.thomas@altera.com, 
	sdf@fomichev.me, siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com, 
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/14] gpio: tc956x: add TC956x/QPS615 support
Message-ID: <p5sfrfa5prxsuznqdjnuusgkj4vyl3aom7gorpdxb2iroxjpgp@7wyx4rceybac>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-13-elder@riscstar.com>
 <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>
 <df217d83-272a-4d4c-8aba-a87e4b8869fc@riscstar.com>
 <z6fllvxd5r7bln6t6o5cacf2k35c47mnavvkmda6l4gnjaanin@52o34je2alxw>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <z6fllvxd5r7bln6t6o5cacf2k35c47mnavvkmda6l4gnjaanin@52o34je2alxw>

On Tue, Jul 21, 2026 at 04:43:21PM +0200, Manivannan Sadhasivam wrote:

[...]

> > - Does the TC9563 chip have only *one* function on its embedded
> >   endpoint, supporting just one Ethernet?
> >     - If so, this driver will have to be modified to support
> >       the second embedded function and Ethernet controller.
> > 
> 
> The driver assumes only one endpoint, but the binding lists 2. So the driver is
> not complying with its own binding now :/
> 
> So technically, the driver supports 2 integrated endpoints.
> 

I was wrong here. Driver supports only one endpoint and that's due to TC9563's
hw limitation. I confused two functions defined in the binding with endpoints.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
