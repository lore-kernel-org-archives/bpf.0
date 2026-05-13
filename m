Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCB4C6F0D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676593; cv=none; b=GVk2yAaXBtBRtl+GaUcx3mk9hX36NlS/VOBwktQoUj6N/9SEvAKwAUCUYGNOLZJ1aYGmD0s3dZkEbNu+Xu1LFckIw0dfdZ4zkqAVhiFXJtHUoPPRNz17Ptcsq92AYmZtMVoQJhAQ+NH6mPRQa4FvKYIK8BRPqbnZRYGpru2rCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676593; c=relaxed/simple;
	bh=nI7YOzNufegrzrQMgLxNrwAqGVHXqCpVokhfGj2uJHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhwQ7OE4DPmROOY8x60eLe2iK5FFyGlUZKnhPNfiPjXe2qQH3LVsb/PGOO5IlfPPcho59fFvivIOXgdl98WVtuka2szt3wZqSvTeP+rlgJBZJJ2iPGHsu8197jFJoEX2sYZsWQe9SL5PS8vMq2Do1u34WFcDSdf+LjPxefBvdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=anv6YcyT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="anv6YcyT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so42788245e9.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778676590; x=1779281390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3zF8kES347TPoEbvDwkqQbzfa05yrB1P5lQaxsmy/k=;
        b=anv6YcyT1kkN39tGg5nc5kZAg7zQpsefqN7H9k6nFlR+iDHfySQCgjAqbF1Vit5gd6
         HGvL00FO0ndFtwsAGqbZi7Lq+ftGXgmMie1BQilW144IsLtBbTz8EenRf2GoJtXZXHct
         8L45vMDjh070y3wWVV3Db08kBBIq0CLPhLkZKaHQuey9Hyn9kLtUPM6d/ueYS1lLmDYi
         DWzO+AFK5ewpdDMcSm2BQfdphnr1Dy5xQINNfDbQhJegZhXsUoscwrcjBPJAQ5hersSM
         Dk6KDwz/c9bXB9CgGMtY4vaFx65TH67HQJC9zt82spg6F/gWQGD3VkvQOfMJy9D4lOVf
         BfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676590; x=1779281390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3zF8kES347TPoEbvDwkqQbzfa05yrB1P5lQaxsmy/k=;
        b=f+xyn6cYwqLh/fHRkPlFwVc27U4cPzD8wrq6PiumXKO+wjj31VoJe8o5ePUmP/xFzJ
         4InZ8cbJxi3TI1k5mKNB5stmTdcNTGca17zM59mTsJp0wnLhOQcw770FII5O2Go8fuNc
         iGMuZdmFcT/bY+fsospNCer/JTOeCxDLpSM4hKnSFfedxC7G2eV7qkbG7Jdw/jNTQTNt
         s/SDTBSY+5xK1P3YqBAdGxwgyeUvA8Bo6/hb46Mj7O67G79PS7weu4zWBSfNzdwzBmKg
         s1N8ZC6xpWhif9JV8ptcu6tWIRou7HU1OYNdLPOSyi/PyQyyLL5KbzfmKdUueIfz7llQ
         Q7rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+n4hJQF5xx5lLiiQNvtnnvGrL7b38kPgERO0EaB9QcOWBkRAvmvsx74CKqJRACSa4+XYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oHAXRb1wV8Wbe4/pAiBPdciAqYoCjOqNgJu49hEw8dW2brZf
	b7vqtVD6pE8yfqGa6b0tDvFuZjsmEM1VaaW8Y+ifx/ekM62sB5lcU2SvvzoZzp8UuFo=
X-Gm-Gg: Acq92OF9VvT+WxO3oPEbqTQWLpvpNDIK/3UeMjeZJcs+J5yGHkZL16lTmWLvVL+E5eD
	u8upGsUQRUPvIPz7kw3QvVicrql9HbjIA3ESpiJNYokxytJGIA14JW9oCAfRIVCFG1WK+NdWQ5K
	4g1ftKy/dcQo/39ZN4OU2SR6NW0jixoYZPKS6lq5tSRXzVAmfDzqq3cuOipMDQjCnhoiKdFFBGt
	+I3J7Q63wMwk/i5gedg+0i+e7Wx65mw/m6cBUHcOri+macUNXvf9rtB0e4DK10wK73aCtrBYp5l
	G1wZy9wzQ8uMta44AB8tnCJid0oesi0LEy4ILuA8abiOEECIvnt5fLXm4/H3qLW3rKy8CGFr0HR
	Ld/Em4Viapiv1lFP4oSuyUcFhaIeqUoc4ubgNCiZyVTgGx86TJlVHPT4t/2m6Ci3+5glHem2x+X
	ifmWTvKgC3R6MqpAz3VVDd5GbZF7fdAINg88Y19qhcsDDIaVIVRhKr3k0njYgVZhtRKDV3xu2IW
	JbTmnylo8Kraa1FNFeCmS9NNATCDa3OPARS7LRpC2rhSlsmKSHZe9s9BhH6k/ldtQPskHHxZHwl
	jdsJEKsg
X-Received: by 2002:a05:600c:6305:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48fc9a32aeamr49565525e9.16.1778676590239;
        Wed, 13 May 2026 05:49:50 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8cd49fesm78578015e9.0.2026.05.13.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:49:49 -0700 (PDT)
Date: Wed, 13 May 2026 13:49:46 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Message-ID: <agRzai1UoHEIotZe@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
 <01d6ea18-e022-41c7-a642-ac0321957923@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d6ea18-e022-41c7-a642-ac0321957923@oss.qualcomm.com>

On Fri, May 08, 2026 at 04:03:36PM +0200, Konrad Dybcio wrote:
> On 5/1/26 5:54 PM, Alex Elder wrote:
> > From: Daniel Thompson <daniel@riscstar.com>
> >
> > The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
> > TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.
> >
> > There are multiple builds of RB3Gen2 with components included/excluded.
> > That means whether or not there is a phy attached to eMAC0 depends on
> > the exact board. However all versions include a TC9564 combined with a
> > single QCS8081 attached to eMAC1.
> >
> > Add properties to the existing PCI nodes to describe how the TC9564 and
> > QCS8081 are connected to each other (and to the host SoC).
> >
> > (Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
> > binding, but checkpatch.pl doesn't recognize that.)
>
> This should probably go under the --- line

I'll leave that with Alex...


> > +	qep_1p8: regulator-qep-1p8 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "qep_1p8";
> > +		gpio = <&pm7325_gpios 8 GPIO_ACTIVE_HIGH>;
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
>
> If I'm reading the schematics right, this is only required for the PHY
> - is it collapsible, or does it really need to be a-on?

It could be turned off if the socket isn't in use but it would prevent
hotplug detection from working. In practice that means it can only
collapse during suspend/resume.

However the real reason we jammed this on is because I couldn't find a
way to get the phy/mdio code to turn one on. However it is possible to
add regulator support to MDIO devices by extending their existing logic
to manage resets so it can also manage a regulator. It comes out fairly
clean so we can add that to the patch set and remove the
regulator-always-on.


> > +	qep_irq_pin: qep-irq-state {
> > +		pins = "gpio101";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-disable;
>
> There's no pull-up onboard, should we use the on-chip one?

It is configured the same as lt9611_irq_pin (which I couldn't see a
pull-up for).

I switched the interrupt trigger to active-low based on other feedback
on the patchset and the counts in /proc/interrupts remain unchanged
(with a single figure value). It certainly doesn't look like the irq
line floats when the PHY interrupt is deasserted.


Daniel.
