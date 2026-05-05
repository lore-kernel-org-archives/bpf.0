Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F148B368
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998336; cv=none; b=n6JQD2aH4D/jSNH2B0RccTIehq1f96BqOU2B+jYTUrAjSk/SUSMHpHnINTmocd4l+zh6MXAOJ8xRTMAAqaeG+MvmOzfrRIciXa/EIj/HXXZSY19Mo5+fUR9gX58k/vnhLVP/ZR4+BVuVu7zeUlhcQFXvlKouopfVst9hB29MIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998336; c=relaxed/simple;
	bh=10ad65O0ps7iM6dei8qNX30QY3FkTiMh2oPpwbtxSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzUjyC6CZhDzya46W2lS55VUJa7gKwwfxYsMoNgZR32BZCM80KgMfHB0Pk0H1HTo/54Pvjg22jriJvcBtwMy8BO6HUJEl33y23vF+6jRNNi3AERjttmVlt8HJ4ljXHSesRKBjLhLZSM2wQmXE94Je9a/RlKUI5bPocWExzjOF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=BOLA12n2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="BOLA12n2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso48558405e9.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777998332; x=1778603132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvgEgjFlnhgVavTSLAwA8kue6OnY1fSQmcbYOk/Oxj8=;
        b=BOLA12n2zlvmTn6BetXu2cIMwXhJbX+fAz/gLq6do6zp3kF4K8bysb/R3kx6QmU/sL
         sy3LWQoP4bi8cfnuP560JUjb7CQJze1XckvA6zXP0cQCyFX4ek6Ex+BhPLyNPHbkcKvi
         mi3Mf1XGJcV9KZdHYB4NPiQe4Be5mJyy0DlMvUJcGYrNtvX/tmmSESSG8uRanKtf6QrH
         +jXCiqbm1qvvfa3oR65MrApVGLhfnE5RhpdCkSitxFVUhnKXbOyeOYf85Na4ivlYhRxp
         29xl5m38ckNZuCyrfLY9/TP0RzuQ/yCbLpPNfD20ghiwdgtgdjyIoXBIwXneCGn1k6w7
         F+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998332; x=1778603132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvgEgjFlnhgVavTSLAwA8kue6OnY1fSQmcbYOk/Oxj8=;
        b=c5qrjG1ADT9+P6Z7Z8KtugXRIhVhwmoJjeZaG1sceYq6a1mqd3DP5SklKN6QB9T3Qy
         RFhlX08KdQbWtNnfJ4SRsDsRITFJuiMsfFIToA4xD10DK/yqOf7BwkY/VjA9q8eeI0Km
         WpNHcHZ8VH0GGMndmEx7YuCVmZD4666C+YgheFZbXtSNgVS2xxjrtJAO2xnZY6UWOOmF
         Je1Y11OWYqPkZMRoKUOuT78HfzlUXhAb7yvBjrv9Rau0rtYOGnIvaTm4F3rmx0IhGYoa
         K5Mhyc0CK9nRzjQT3phDVDrWSmETl9LPdzDSUzgsEPQ/PYHssp8W6hXc2tjEOsIvQMIc
         og4w==
X-Forwarded-Encrypted: i=1; AFNElJ+qgwuhhaJ9YtIe5L7zaTnwKGeoMT7d2RKhRt4Pqn5ODKUjhoc9bKFRpXCyNyjbzYVmt44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6ZrWhmZq80L1jXmR/dbrDvHhmxqU1rK8tXrXOO7nDahwWdHe
	tDpjFzgXNrHLlxZk0rdviUxg7IcyW+O5N/H6WqSaju/fPxOCqT+vu9c+9MDGRc+X9Rw=
X-Gm-Gg: AeBDietq7be4dupHvwv2sFA3O6H06SAfPszDf2tw+ZHa1vA6dYEegEPUPMAx9cWH3hJ
	oSiLoyNz/LELbnSHWMegE7xTlneS3QqDLUb7gFBnT2C4UU9+H/UUSf9DJJOptf6AEvQb08UWkp8
	sqPeLkczb0vb8QXm+8ihkcIGUht7D3cICm5VOZJL6x3mn5SUOehlzI2v394xHVrLWUXwqeqvPSo
	LOhB9LkKVM673pCdssSHBy08dtGp7Tx6VrxKzUzc5ZWUzTbtnNh9uVinvUDYJxRWIh0GAMBdj9/
	m/w2r3gWMsP8O+rkshYr31oHBvlp1Bvfs7+Xev3xQwXL0txC8nWIBA+sEJ+sd4mEsJ3ybwNcZcX
	1fkqvjVEZDpr1AzJ1NL/1o4Ob8tJ6B/WG7ZEY3iSkr6xrb9E/5vPlegO/6bERc7uqi4dbjes6oq
	0PwiBwmcXj5SReelapR9g2A9nOyvzpB/iP0of9JXQ5uW5MCcgOqDjBjAC3VsSLrcfyB77d8z9/m
	ZRlPAbJZVv+T62X/jjvVU2VWsG/63UyNPazSyFq5Cs7j2KMXtWhichx5U9fR3i65nH3nGziavOF
	878k43lLYM4/wkDTVk4=
X-Received: by 2002:a05:600c:3e05:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48a9852fbcfmr256956845e9.1.1777998332149;
        Tue, 05 May 2026 09:25:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm737620655e9.2.2026.05.05.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:25:31 -0700 (PDT)
Date: Tue, 5 May 2026 17:25:28 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
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
Message-ID: <afoZ-LuVRaX6ixs4@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
 <d29621c3-07fc-4720-abff-d8901a0d791c@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29621c3-07fc-4720-abff-d8901a0d791c@lunn.ch>

On Fri, May 01, 2026 at 11:09:42PM +0200, Andrew Lunn wrote:
> > +					tc956x_emac1_phy: ethernet-phy@1c {
> > +						compatible = "ethernet-phy-id004d.d101";
> > +						reg = <0x1c>;
> > +						reset-gpios = <&tc956x_emac0 1 GPIO_ACTIVE_LOW>;
> > +						reset-assert-us = <20>;
> > +						reset-deassert-us = <20>;
> > +
> > +						pinctrl-names = "default";
> > +						pinctrl-0 = <&qep_irq_pin>;
> > +						interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
>
> What is probably wrong. PHY interrupts are level, not edge.

Thanks (and agree). Will fix.


Daniel.
