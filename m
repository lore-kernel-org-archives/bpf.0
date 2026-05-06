Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB903101C0;
	Wed,  6 May 2026 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103880; cv=none; b=FFPezFVil7m81416qf9E/sM9FWcf7wZy1LC6oaLporoqt8knxKZWlzll/t7D17PowPA7qjTR88x2sDS8Vz/AqWxYA+Y6WjVyt8PdZ84BVOXqTN8X/EP7kLOyf7kK6LciCjvaeCgUz9k6yEg7q5PmgM0K8II2BXxGlDYeW6CzZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103880; c=relaxed/simple;
	bh=0AzRbZDfTEETX0mURLiMJOAo/Cw3XAkHZPAXujK/W+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvo8eUTjUXd4bO6Asumjpkk5pcBh/eejq5Gb6WZk0diQ6oUJcqOF9YkS+WTspTIK9iPIQ2F4odE8DY2b44hvZliEk6xgYktYNpBOYyLZdUyA4Lcl1R0CVLqKHgtaDVxmiC1dajMnN+OEkLxIFlYyMECcXCsY2Jb4ldt7c9AQYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Lbcp1pa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Lbcp1pa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/ZNWf4ch/DDdXxetEbDLgq9TJj4asvdiGEKsrUNbO5U=; b=4Lbcp1pa3/N6zwvEs16t+auhDu
	jOV9EVBxcRy2SdMdQ3LfFdF6q1rWwe9Pec1f1JL0kjstJ3VBBiNU55jHCq3FxW+66HwlthS7muuPH
	GovLk1v9MCIaOg/ndV8+6dEW4lDcmpGrYKGbPW/IMn9HCou4cI8bcsnx7r14QpXKK7Xo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKk27-001hvI-1n; Wed, 06 May 2026 23:43:55 +0200
Date: Wed, 6 May 2026 23:43:55 +0200
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
Message-ID: <ec5765aa-b830-468b-8965-a95fbe020065@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-10-elder@riscstar.com>
 <736fb3b7-c88a-4ec4-96ad-d1b79cc48d30@lunn.ch>
 <30cec7dd-ac3c-47ab-896a-c29992bd5ba5@riscstar.com>
 <3666e3e6-e6f3-4cbf-b9fe-caa394fbab7c@lunn.ch>
 <0751a051-9894-45be-92d6-0d46f2c39293@riscstar.com>
 <7d7b6b89-3ef4-4891-a794-c8b11f39db34@lunn.ch>
 <79684efa-4ba9-4144-a99b-dab935007a2f@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79684efa-4ba9-4144-a99b-dab935007a2f@riscstar.com>

> To be clear, the reason you're asking is that you're suggesting
> we might want to model the GPIO controller differently, correct?

Correct.

> I.e., model it as *not* associated with the embedded PCIe
> functions.  Then we need to think about what its parent device
> would be (the power control device, which I think somehow
> duplicates the switch device?).

Logically, the GPIO controller cannot be part of a downstream
function, if you need to use the GPIO controller to turn the
downstream function on.

Logically, the GPIO controller needs to be above the switch downstream
end points. Where above, i don't know. Which is why i was asking about
where it appears in the address spaces.

But i also don't know too much about PCI, i'm used to SoCs with simple
linear MMIO.

From the little i know, it is more than what address space does the
GPIO appear in. Its also, what enumerable entity does it appear in
within the PCI bus. Because its the enumeration which is going to
trigger a driver load, which can then drive the GPIO controller.

Or, something more radical, you make the PCIe power controller an MFD,
instantiating both the power controller and a GPIO controller over the
I2C bus. GPIO access will not be as fast, but is there anything here
which needs to be fast?

      Andrew
