Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377931ED93;
	Thu,  4 Jun 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587909; cv=none; b=q/HBC9ye3B2JUzSHkPyvBMSBaLP3XO78FI8a1QFFglVYKK8wgYoPBoo6gcVkRcYiTGJdDuJDeWUrlTDbCbfgILBjlnkBPIZqfCAWH0Kl0TZKb7wP6diq7kQbSDYvv3CMjFETpfbAiO34pMnVJGivrPxbfICpIvPhHMd4eHQPeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587909; c=relaxed/simple;
	bh=7Vjgou5oMsAUP+bV9bMz64D3Q2RmTauvoo9g8niLyIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFVoFxTX3E4PDRpZXo2OsP4Xacam1mkKA5LFzvcT8Xo/gtTncgIG7T+KrRTJKMC1WzC0zX71vy4cnVDTZG6XbhJdFuZwapF4YSDv9IfIipracbjgCG2lVrtoR4D/V6y652caYEQqLBxwGMTlMtCma8PQpLQcEPJG04ISUtXoSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqp+2JVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqp+2JVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BC1F00898;
	Thu,  4 Jun 2026 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587907;
	bh=J6/Zc8Kntqruk++j6OsWXgT7GAK8IYpfolpCQp+mdPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uqp+2JVfNkgM4DYirxsvI8dPAPY20KbRBU2RAzPe4pXaeY5l1Ui68DWZUIfPO3hfx
	 H2BfK9fBaLnouKZ85RXL4bSDV1nqG/yiZTXVZTYSz3PiJrGnLb6StT2pTf5PVNnAQY
	 UebUeKlG5F+Ztj6vVrscC2VEtv/jzch/UFZow0rvntiNS+4+GVXrCG2LhQ+pZn6Nh7
	 eIbyNd++z5R9TlaCOCG1RFnBc1tYm4IPX8MdXCasbq1kjaYuujIL7tZzMDsbj5wg5x
	 GxwLb2oUz2tTaMh4gipcMKzDiCzayZD3OpuSuJIulbb6FbA1P4WmiSJUgPj7nk5e1c
	 2gzVemjcOi/Yw==
Date: Thu, 4 Jun 2026 08:45:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Matteo Croce <mcroce@redhat.com>, Sven Auhagen
 <sven.auhagen@voleatech.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: mvpp2: do not return retired RX buffers
 to BM
Message-ID: <20260604084506.274d0ead@kernel.org>
In-Reply-To: <20260602164635.62517-4-mail@tk154.de>
References: <20260602164635.62517-1-mail@tk154.de>
	<20260602164635.62517-4-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 18:46:34 +0200 Til Kaiser wrote:
> The RX refill failure path jumps to err_drop_frame, which returns the
> descriptor buffer to the hardware BM pool. That is only valid while the
> driver still owns the buffer.
> 
> After a non-PASS XDP verdict, mvpp2_run_xdp() may already have recycled,
> redirected, or queued the page for XDP_TX. After build_skb(), freeing the
> skb on refill failure also retires the data buffer. Returning either of
> those buffers to BM lets hardware DMA into memory that is no longer owned
> by the RX ring.
> 
> Split the error handling so buffers are returned to BM only while still
> owned by the driver. Once XDP or an skb owns the buffer, only account the
> RX error. Mark page-pool skbs for recycle before they can be freed on the
> refill failure path, and unmap non-page-pool buffers before freeing them.

As Gemini points out the driver seems to be following the "if I can't
allocate a new buffer I'll drop the packet and give the current buffer
back to the HW" flow. So after your change on allocation error we're
permanently leaking a slot on in the buffer pool. Leaking as in it will
never be filled, if it happens enough times the pool will be empty,
and no Rx can happen.
-- 
pw-bot: cr
