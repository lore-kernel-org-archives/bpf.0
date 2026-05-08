Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D13D090B
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239959; cv=none; b=rqX+CA0XikxSzwAZqDz4VPaP7Gu/kOVDtzpN4kLYOiThDRG6JqYqna12LU4ZyT6cLVu+X+vmrBezK+LHrUYr0eLeIyHn+1gD1zeeS7fCG8hmVewZksKaAWQqbYdoWwgdSjoFfyVkibnBQne9YXDNphDJIZ9Gm06n67ImYHgEnvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239959; c=relaxed/simple;
	bh=0hrQlW5FpcXozs6wxkIBzDktzohYeRr936w21ThvyGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5bfL54XtqFLIAP/5Ae5g/XJYVQqs/I2zojh+2mbo/1HpXzlR/jnliRH2dwgzZ05MTBCtsuHqH+CJFLJPfkvYfbwgznVIvU3onx61hbJC4l/gPSD4UnGj9bGlb5SB6jT5XTk2u1YzXJOZO6jAPGxbidHmmlyfRm+yEv0MciEgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=GOK0bOic; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GOK0bOic"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso1850719e87.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778239946; x=1778844746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3oCf6JjY2k4f2DdZmgb+d8lKs1DeUt4qK3/lGPB5dQ=;
        b=GOK0bOicP9EfTd1qBgFEldBXfDJ8FiWszClkdoFfP9kf5kk8R9fMDZ73KK/WrrnsXW
         IjLcfQsAkhsM6p02OLTCDkmkbHrMChdUPlPWfk0HPW8Cq9+y78ajjCN/zfuwPWIAsr1q
         nJahLN7dxmOzL6sDUdxYbNU68AT24x58wRCP2ToUSW52UAmh+mM+3eVIpazBivPec4U4
         0NmHZRd9Zr4NQx7JVUbdKACpENzKTMHEeZg56nseAk00kAv3ZRsCrGMmTKbvVkcPwjIq
         z7h7NE2pKfVJaeYJg3e+gDzt3B9vYeYxhHY1XppnrGHmUQxLcRhSbZfi8Yrmm+eJknsm
         IQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239946; x=1778844746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3oCf6JjY2k4f2DdZmgb+d8lKs1DeUt4qK3/lGPB5dQ=;
        b=jMmS6153KiE4fDv9MkDaNtyUweW/a8ubMEL3PZS6d9vOfUVshZ/LDwOtJvhbE84hUT
         16SezGpAqFTBrpCZANGcEKPJYfSyZJO+qqiduLtpzpFjgwUNu0aX2PPl55AiQbw9s5Yj
         qSVyXgyUGRy6oiu7/yP5xfM8RpivOnCTBrE3aoTdsKlLSmGIbIi4wKS4XCJNCtyvuM24
         QQ/Li9GwGK+Ibt/ABdcNgQjsVdF+RDZ4G1ee6YrzD/qb9Hm2crG6SSYDCJpxkdrKW6QO
         bpdXnfkL8y59zQ+5HNd2DpSUU33fGtuQSa0uLgeZ8u9sEbiJWxE7Wrcne55VaKv5tiAg
         j6Fg==
X-Forwarded-Encrypted: i=1; AFNElJ/0S6hSJ8XD2JFum4YBQkVE9T/SzFW2dnwwcmq+tWENuY5/GARrCK0YGRZXyU4kovU1dDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiuf6ZL/HKKzygjeO1xqDTuxIotGdeSfKF5Z2WMxog2MbEPazx
	7FW3tpR9SdN5wj0HbPs8s1K2mPWvHbyajr4iwNHS971U9YbcuqCnQ/DICn+XJe/2YsRgPhO3tKr
	lceKltlE=
X-Gm-Gg: Acq92OFOoODNZghV/j8LYJrdm9F2Q9ib7RP7XyppkoAHYjFNnXCe7ZTfD3XxzM8fLp8
	tRnBtyW+ObLXSNn3FqJ3+TdXLEai75IZDFG21Ws7EoSlgMjIbAH9Yix/mm7PNNsfq0AzCfa4G1+
	w9608h3iMSclZcKdacyyUggsV5Wc1UPBbdf059IikXcqnI+7WVGAvTouuvdp9Jh4i2jmNM15niL
	gluB3eF1ekWYlszDEHsidv/3CdSCLtdM8E8dQFyoRv2NPkRpyXFRLCGShSKahIAiFcfP1RknOo+
	OesvAAt9EmZPq3HvG+3vC+Xi5pTw8nBA4pvlhLF7BXINZfISYu25UvGHurq07IQG/tJdUWC2D2j
	MplON0GLlgQ+VY4HF6UHH0MHWl1S15MArLek9G/2kmhxiVsLGjQLTqlgoY9tkHMlGMupWWz5sgp
	pGPPLTdGedqXVR9k0DllONRzmqOuVjRW6XWTkkEaBPX5VRy00067Fr+ecUXxhrwlG9cIpYGNr0D
	XXxsDiTiv1I43hDuKaX383S08xn1hNQbl2noMsW54quooiP1HFGnA5G0sVLYYz3cm4V+qFAHCW2
	YGNfe4sG
X-Received: by 2002:a05:6000:26c9:b0:43b:3b80:6776 with SMTP id ffacd0b85a97d-4515d3dc30emr18803689f8f.30.1778239532551;
        Fri, 08 May 2026 04:25:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm3814079f8f.26.2026.05.08.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:25:31 -0700 (PDT)
Date: Fri, 8 May 2026 12:25:28 +0100
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
Message-ID: <af3IKKkjl0jK8GGB@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <2ce5897d-5bbb-486a-b0f0-0e30e54b451a@lunn.ch>
 <afy34kj2hPxIlArO@aspen.lan>
 <ef6df85f-11ac-404d-958a-8cf69b3b6bb6@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6df85f-11ac-404d-958a-8cf69b3b6bb6@lunn.ch>

On Thu, May 07, 2026 at 06:29:15PM +0200, Andrew Lunn wrote:
> On Thu, May 07, 2026 at 05:03:46PM +0100, Daniel Thompson wrote:
> > On Fri, May 01, 2026 at 09:04:58PM +0200, Andrew Lunn wrote:
> > > > +static struct tc956x_mac_speed mac_speed[] = {
> > > > +	{ PHY_INTERFACE_MODE_2500BASEX,	SPEED_2500,  SP_SEL_SGMII_2500M, },
> > > > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_2500,  SP_SEL_SGMII_2500M, },
> > > > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_1000,  SP_SEL_SGMII_1000M, },
> > >
> > > That looks odd. Some vendors implemented 2500BaseX using SGMII
> > > overclocked. But that is not strictly 2500BaseX. Having the 2500BASEX
> > > entry suggests you have real 2500BASEX, so why have an SGMII entry
> > > with SPEED_2500?
> >
> > This is a consequence of the code that uses this lookup table being
> > called both during initialization and from the fix_mac_speed() callback.
> >
> > During initialization we only have the value in plat->phy_interface to
> > go on so we run the lookup table using plat->phy_interface (which is
> > typically PHY_INTERFACE_MODE_SGMII) and with the maximum permitted
> > speed.
>
> Something sounds wrong here. SGMII only supports 10/100/1G. You should
> never be asked to do SGMII at 2500. It should ask for 2500BaseX.

We weren't being asked. It was just an internal driver trick to common
up some code paths.

However I did a few tests and the internal driver trick doesn't
actually do much we can't achieve a different way. With that changed I
can (and will) remove the PHY_INTERFACE_MODE_SGMII/SPEED_2500 entry
from the table.


> > I haven't got detailed enough notes to allow me to double check but I
> > think there were problems completing the initial MAC reset if we didn't
> > write something sensible to the hardware during initialization.
>
> > During fix_max_speed() we get told to adopt 2500base-x. Reviewing the
> > code I can see we don't propagate that and just use
> > plat->phy_interface for fix_mac_speed(). I will fix the code to that
> > the requested interface propagates properly to the lookup table but I
> > think we would still rely on the SGMII entry to get sane initial values
> > to write to the hardware.
>
> Getting sane values into the hardware is good, but 2500 SGMII is not
> sane :-(

BTW if you are bothered by SP_SEL_SGMII_2500M, that name comes directly
from the TRM and I'd prefer to keep it if I can. The enumerated value
we have to write into the SP_SEL for 2500base-X is "SGMII 2500M".


Daniel.
