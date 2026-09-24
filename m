Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E8427F9C;
	Thu, 24 Sep 2026 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232883; cv=none; b=QqbhJ8Daj8ckU5qwuKv8o9FDZAMMuM8+lSeo17u47/0c/Wf16JK2NFU96/+t21IepQF21ThIFt86P9kfUPBkgFFkqMzsJCad1qbiPI7ZSqSHkuendzFu88Gvy2MPgZ4UWrrbMf5YcE1KX0/FRXWfnaWCr9Smf995I4vseZKrUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232883; c=relaxed/simple;
	bh=I/rIu+DhNGVdILzdavOaC3roYTBy9wWlIis7JBLS1pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHzB8damP2nAW/beNP4knPJvQaZNz3D8PKhdkFCKjM4J+LuE/HyqFCi8zuc+CIx753lG23oOhWM+56oT7zTGl51d04M1XkUumGKU3Ao/x4ehulFwTtEsMRhSh2Znb3paVwB+IFMhLmeYQ5tTU6PgjbILqL068P/dEp3r0lhipt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU+IVIff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU+IVIff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053301F00898;
	Thu, 24 Sep 2026 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232860;
	bh=xHMlTAryYkKRHoZj/xsR4dPiUEBqRHg26hGB5/0An1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lU+IVIffzxwk0PWWjvKyEh2hofKBLn/vVIfLQFveYat051QDQyIkJw34Ugrp7ZRXk
	 1bHk6nwLRs7pd7vQWP19O2uUYRDNSmPp0H4n8t+rqn55djKlwrUGli3hyUz7zlq+wJ
	 rql4H7YueoNrqG8cYMHpm1thmGcRxU380rc6uqo6VMSp01WGkF+q21uyvdeFMCaaKh
	 QS7OVQey1p7xPwwM1xgXJ9VMdXwmb7gLkEq2QTVKVCESaszMiFY2ezIAxtuTcLKfGK
	 rmMQqpR8VOgrsY6M7qrc/zHKF9qDAIGGalu7rd92CC0xdZCD7KoHK9ftXc3KNoD7wX
	 7VAw+i8u3cRiA==
Date: Thu, 24 Sep 2026 07:54:13 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 13/14] misc: lan966x-pci: dts: extend cpu reg
 to cover PCIE DBI space
Message-ID: <20260924065413.GA13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-13-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-13-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:34:05PM +0200, Daniel Machon wrote:
> The ATU outbound windows used by the FDMA engine are programmed through
> registers at offset 0x400000+, which falls outside the current cpu reg
> mapping. Extend the cpu reg size from 0x100000 (1MB) to 0x800000 (8MB)
> to cover the full PCIE DBI and iATU register space.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

