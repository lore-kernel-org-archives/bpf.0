Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015A1E633C;
	Fri,  1 May 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660616; cv=none; b=K8Uv+vHeYkJHYBjOORPAYIohWiTQIjmR11oW60nTEvRF3JPvNRWLz2ojeXF7w+UwSiCWfjrdDT/arCNTYMUt6lMLGffNxZ3BlRlvPoHdLz5IqEDe3kUxVuZbBbZdNHDtavEDBD+AU7WAcLpjWspV3GnubAWj6CH9oSvjdJNdmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660616; c=relaxed/simple;
	bh=SsTIJvA1/Pjq/mpqisHV0VFtuk11C+ZGfXQJ+O2QUbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ra3Xq1A+AGLwK4eIbY0+/LiDWq8qf38UebGMfaNugXfwUu9mVdEp0lfMm5C/cOQOYe/X8UHSZ7QngX4lp7n65CfULnnimA6MdpFexxr0hASDY2egVc2s2Te3bGqqGi87VvQbDyk63zE1VVFwbZB/sDbofZDTN6unc+NvLNH4YGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hzVyVIJz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hzVyVIJz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vZ9dw2mmSr8oO8ubiqu0GGlDjqOspeWOnHecTqU4Gd8=; b=hzVyVIJzIvvnJ54VdeHNnhi8AK
	zIylf+U+zVcjdHUutgFEFHRNzDG2YixlAqAdlyVtEXWaV2UvZzwy61r3/8b3JbZNCVvdci7WZ3Jvn
	eViWLhZtZXjzloI1SeBIJZCETP/b5a1/VhdT+EnqR0vo8tWQ0+SFqyUCaKkooPQgMl4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIsie-000rP3-Fv; Fri, 01 May 2026 20:36:08 +0200
Date: Fri, 1 May 2026 20:36:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
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
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] gpio: tc956x: add TC956x/QPS615 support
Message-ID: <736fb3b7-c88a-4ec4-96ad-d1b79cc48d30@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-10-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-10-elder@riscstar.com>

> + * There is a TC956X PCI power controller driver that accesses the
> + * direction and output value registers for GPIOs 2 and 3.  These
> + * GPIOs control the reset signal for the two downstream PCIe ports.
> + * Their values will never change during operation of this driver, and
> + * this driver reserves these two GPIOS.

Why doesn't this power controller driver actually use this driver to
control the GPIOs? Chicken/egg?

Maybe add a comment why gpio-regmap.c cannot be used. You probably
need to instantiate it twice, but i still think you will end up with
less code.

	Andrew
