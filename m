Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528634;
	b=ZuxNHLj9m1QCY5lqQy7A+0G1UZ209I5NGVjRqoQk0S9ebyT5X2xPBAtiHOVNOF/sJPhi
	 Wk/K2EDrHi6Wfav65jc+/+JIOQQIKnPjlD7D803NmFtJIRvCqm2OUQg3jz5CGr/mjOtkI
	 MCZZATYfI/aS0h4z7PH5+NbRvi1Jxb1LHG+z5gE+rv9OFvKjxL+NIGDnwsF7/YM/S+3Xd
	 7GNUTXOwDSwa/gPqb2ULTG2NxQl9ESjyLUzoHVoi2ARhxkjnuT6Fduruo73JG3on3SBoh
	 FDo09aKq4cupzjQUHhmT3v+JSvBAX6aXLiOBEG0XiEHzat3hnBbIiUa73F/2jkIapuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528634;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ngFPIv1lHkBdK5moaQ+BiuEEGR7VyeOEnL3dMr9mwY=;
	b=KkYEnlPmHj6U3P7suWJigp/5P/TRjeiJO2iniIYKRYmMQOdlhPSIiLXYNQTXIQMJ9rqM
	 LTt0Qn5m0/mSJcOyi295MBXFo7qza6sUIth4N1Vgl7PY9ELxSjRN6D823wv9GAL9MHBRJ
	 +VCEpfkpCkFVQ+ku1aq47xkPzXJ8A+LKCVfxaWS9AaTJbR9DRLec/DXRvF3PcFy0VHpol
	 kKYj9uaEJNyC/LMBsksuGf9ZSnj/WtY1mT25mNlGJVnV4sezpi2ZjFPTztamTlAsqWDSl
	 Jo44Ifsd1+H5ExD7TRbfNlhsY051WPjaDvEu/YtwwQ8UkpXwa2akbXUG9HE4dd+EAeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LntxX1jQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747C606A31A;
	Tue, 20 Oct 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LntxX1jQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A541F000C9;
	Tue, 20 Oct 2026 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528633;
	bh=+ngFPIv1lHkBdK5moaQ+BiuEEGR7VyeOEnL3dMr9mwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LntxX1jQI0CNc5YpeMgrEssI3ysIYCejB4z6EKT4BCudK1wbJI5aftY2slAYz28p+
	 cLDb9+Nk23JXjTAPcYshBPmkVRgVRVJsDv4Bz9g7Y29Hsj9kQxmNkx3oBTvYTqLD0K
	 U0xi0zNlBtWAaZbgrxwNjVP7zhQuMTt/mb26rwC/BR6J9A7jY5mW13bn9LqCmOcfCd
	 fM9UzlEAiusUw22P28iz/mP6VxKOPpnzmzZQXbB/ySrYdwWFBmSrHZuEZ1w05Q9lMv
	 hcWJdXs9Ezv0PC19jSW6QGPdRYaPQYAnTl4eQY89WHLuoreekkJB1V+6SnjFSbvbZv
	 KZHEHQtmqRodA==
Date: Tue, 20 Oct 2026 13:37:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
 <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 0/2] octeontx2: mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20261020133712.7078b6cb@kernel.org>
In-Reply-To: <20261014023431.1775238-1-rkannoth@marvell.com>
References: <20261014023431.1775238-1-rkannoth@marvell.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 08:04:29 +0530 Ratheesh Kannoth wrote:
> This series adds hardware offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2/cn10k PF and VF RVU
> netdevices. Each non-QoS transmit queue is shaped by programming MDQ CIR/PIR
> on the NIX TX scheduler. When bandwidth offload is active, the driver
> allocates one SMQ per queue, parents every MDQ under TL4[0], and maps each
> traffic class min/max rate to the queue(s) in that class.

The merge window has started, we have limited time.
Too many AI complaints here to consider the series this late.
-- 
pw-bot: defer
