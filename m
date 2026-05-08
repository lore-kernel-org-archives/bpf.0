Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172D30DEB2
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255700; cv=none; b=VqlNKQ6NwrvIt9HpAauWnj0IAOWRobBdEL7u057zjrAlWsS4SRQAKaiYgKJRPGRKh+LQBq0lzz9SP2Gfit6IlWENxbBohI3Zv69g3i5Sw8IaGk857B1D1XcmdvMDUojdZWQmyONsSkMlA6oaUMxpfXllfJYFtiTDPDPhetHYFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255700; c=relaxed/simple;
	bh=beGQbSohbqovdwuat6nKIVAFYzmFCR8PUrxcs94i44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGN25t4IyuBt2EZPlspRBfZk3/+FgBmH145ixqwfUC74hoeNEBqcFwrIuNY/ALIURlW4nI3zw1xLRTYg1uDyR/wF/OjDUPe901BLoC9t+oeGDhXvFGxJzmblPorT8HM7MvPnqYPFjipgwW1HR2hkt5yPmCADGBb7Kmzodvm38DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=r+qYdjAF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="r+qYdjAF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-453903ee4adso1605761f8f.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778255698; x=1778860498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=beGQbSohbqovdwuat6nKIVAFYzmFCR8PUrxcs94i44o=;
        b=r+qYdjAFZkJSnq1CvRGaZ/LI0eK8QVoWEZ9b1iPl9bQ4fUagPkJ5pED9ioSpKvlsoO
         DrvL7Bh6e3tvTGaMBZXU0PYwKOPjbw7Sxw8y8vdeE77aWvjecDLGUuyegp7slaeFmOFc
         m8b3MlNirSpcUJr7Z89UYmFHcLpaWwjHk3JoHle6AcfeIevgB9PUjiGrTg/M1Lqj8hxx
         PjZvZhERjKUMRpg7w0l/re/UGKYWkC3uMKgNovGFMng5MGmX24mwGtoGrEHnwpwLAyrb
         /RbxexjnFUp6MOGJNDbI6hH+pNv1l2PtOczm5KPhE+ZYhNqqtd0WXLpNUXVKFjvbIaXe
         H2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255698; x=1778860498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beGQbSohbqovdwuat6nKIVAFYzmFCR8PUrxcs94i44o=;
        b=GnIT4rSA68xcojug3rrSZ9v+dymgsbEmI3jfjv78N3PfBzeTzoB+0BZ1m6VKY3WYtS
         FcEZ8HVeJEzAfGezdvdv1qx1Bz9ijrJuYO6/sOlp7ASgLRunPyPUb8AyoR6ulsj2Ckxl
         ZNjMZHSzHyZu6/36aTJAI6ueIArFV01g4UnDGA3yN1g2L9y6JgFn5TajZseepf1/3A35
         CW0I4hTB0bIHWAhqx27qlFtAVypktdSZ2u9oKGtrNhAQGXat8wkK6lileQ1DRBayHtCp
         b2xpiCNVDHhqj2FUvvI9wbst1jVrtt4OMtgzp1bb3LenXRedfUOpcGFKkxezrtBuLvH5
         fXyg==
X-Forwarded-Encrypted: i=1; AFNElJ/QoNpSEKsaFKxgl3tgw9hEw5j2IZn7xCMWoGQWI2ivbmZ8gnpwg1a9WTpOIHNhKDYjiFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS04IipZNkr6pWeJObtPi40zH51HiwTn+kE8d2WZGAF2hZRXhf
	/FaRG5Bu22qz3+pxrhjYnJSz5uuCAo5NnPHUYy/OXcWvRPVRoVMqkATeaN9//Y6+Uvk=
X-Gm-Gg: Acq92OFnS4Ex3MckohMCVAPTLkjJYTuACyFnOvpIxBXxpRKnt5E6OfBppZyMeS6sYfq
	Un07gyiUfd1qfQDAQEokaDJPN/+f5VF72r5cBgXCdVbAJNRjV7my4QrUHKUwmt2BzWpjck40iMq
	TZXEd+jr9IX7FT7CI0O/q5xumqz4e8tTcG68zLbyVgBUxT0/QBXPVahwDvxyCEhX3FBeeVaFHO9
	uKsTZNHVxX57p63/MsRfrXS5zHyism5nw3cBWz/Nv5MFxmg75MPgaVGT1E5beez1Ja8Ka6T9Q93
	9f89DAcjK55XWVXmyKSr/JfO5SGi2R8wntsampNsBFkUR11WclrUCKsMrLVeYf8Ku2EVCB7RsGQ
	sD+jybqvsICvDwvf2QO2U7NFjcY7d8tOpetig/j7LTGrHED2tkVZqDzjLox8Tv5aXLC/9BSvFc2
	ZJEg2qJQnTIg2BzY0PB3x+EE0ZE8eymMGsE7EK33HLRMWEn3u2qsghK34CHv6JQPEHcBR2bSYCR
	afw3e0N9ByoGRGVMY9EgMJBVHBR2NPeAMOGd2Y3x7NQ9pok3BwCiPbp98wawrkoRTXpgGKl6Q6O
	F+pAeoYf
X-Received: by 2002:a05:6000:22c4:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-4515ce1c6bcmr21753628f8f.22.1778255697345;
        Fri, 08 May 2026 08:54:57 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm5680163f8f.9.2026.05.08.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:54:56 -0700 (PDT)
Date: Fri, 8 May 2026 16:54:54 +0100
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
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <af4HTg5P3j0GsNvt@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <2ce5897d-5bbb-486a-b0f0-0e30e54b451a@lunn.ch>
 <afy34kj2hPxIlArO@aspen.lan>
 <ef6df85f-11ac-404d-958a-8cf69b3b6bb6@lunn.ch>
 <af3IKKkjl0jK8GGB@aspen.lan>
 <f15e2fe2-88c9-409d-b953-cdc94aee4e16@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15e2fe2-88c9-409d-b953-cdc94aee4e16@lunn.ch>

On Fri, May 08, 2026 at 03:34:42PM +0200, Andrew Lunn wrote:
> > BTW if you are bothered by SP_SEL_SGMII_2500M, that name comes directly
> > from the TRM and I'd prefer to keep it if I can. The enumerated value
> > we have to write into the SP_SEL for 2500base-X is "SGMII 2500M".
>
> We try to avoid anything to do with SGMII and 2500 because it is
> technically wrong. Cisco never defined SGMII for 2500, it is something
> silicon vendors have made up, without any foundation in any
> standardisation. We much prefer to refer to it as 2500BaseX with
> broken signalling, which is a much more accurate description.
>
> The TRM is also not a public document. If it was, i could see some
> value in keeping with the naming, but since ~0 developers have the
> document, this is less useful.

This is a pretty obscure register buried on some of the TC956x glue
logic (e.g. it's not part of the DWMAC's register set). I take the view
that if someone is debugging the hardware interactions deeply enough to
care what this is called then the odds of them having access to the TRM
are actually pretty good.

However having a different name would be only a minor irritant to the
poor soul trying to debug the thing! I'll rename to SP_SEL_2500BASEX
in the next rev of the patchset.


Daniel.
