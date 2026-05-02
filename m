Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439A1E633C;
	Sat,  2 May 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740436; cv=none; b=M3KBxGmFqdA5NpwjHUnpkflCSrO9IO4Dnnj8NNNhQLU8CXmvT/pTcwzx7hKH4owvg9dO6fMz6Je7eHUC51CPLkEA91UdXneXP0wulEPPtWrazd1Qf2t6T9H2vK5vhjqltRufgbMk9umdFJnXyL8X3r7ZI5FHqW+i2rxF+SH+O94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740436; c=relaxed/simple;
	bh=zymvXjOjeTSggFeuoM050BBTeP4ivuV+K0ZODz63sG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQp/EtTLnNkk6qAMz66zeq5u8bLcgc7gi8wrAoFshW7+AHXdhc+kDwSNZEWFTNXhW7JLLozTeXWJtTpGMRkOBRRbDdhvOW4GXBErqetZDvhMhUn7orn+AcF/05DwP/1X+KVdJ7TaruX8ym+xExD/CznlrcIjYO+HX/QORvE+8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2a0Vi3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2a0Vi3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4943CC19425;
	Sat,  2 May 2026 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740435;
	bh=zymvXjOjeTSggFeuoM050BBTeP4ivuV+K0ZODz63sG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C2a0Vi3QX0WD3xutTIXFvjrVMuUqle24NF4BAQHxyUpWgq77agsQiQDARZ48oGEr8
	 zWeFVrQ+2yNo3XsQXXseVTkoumlvbwMcqRQ9Yrv9/oCfoJJfiKSyfy/R/1KWeM8Ejx
	 j3kgXK8lc2stL15qKUXCkaF9uBbZyYkkj9ca4JUpNJEbRoD1qD1piUoN2e5hAWLFZo
	 hmI8PjcAL1L79x9BIkN1E2eRROzi9GCkLp+6y/VFSfpgKhQs2XFoSYrQPXb4whpnxD
	 2Fh+iykG/8DvSFLTzfAlLeLNrYwBZESP4BuukCRYY4PUWPAJsNa9OBiyeLZcaDz2BO
	 p7nB8soAtHKMg==
Date: Sat, 2 May 2026 09:47:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, daniel@riscstar.com,
 mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] net: enable TC956x support
Message-ID: <20260502094712.69b29dc8@kernel.org>
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 10:54:08 -0500 Alex Elder wrote:
>  create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>  create mode 100644 drivers/gpio/gpio-tc956x.c
>  create mode 100644 drivers/misc/tc956x_pci.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>  create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
>  create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h
>  create mode 100644 include/soc/toshiba/tc956x-dwmac.h

Please add an entry to MAITNAINERS for tx956x stuff?
