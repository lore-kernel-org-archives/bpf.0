Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838328;
	b=UVoa1L1Enb9oWPTVlgnQ5/kdGjz39OhjwtV4dg6q+dZAD6OniQNA/GE4T6Bl1YGamqoN
	 NFjtBtdU7LpWfZ/8VvLGcqVN37FXB6zQLshdTYnV0hS3KI+enkfOqfTZhkjvpYw/u97g0
	 eu6Ky1KNTt1BOj4OHNTvM2bwGpx8bT0VXnxs95p5vFSvXOe94G8yZf0yV8qR0PsMyXMMD
	 rh+fMwnyII2ALF5Qoek6Wfm991LtC19l43FUSAa3gt56LV4lrW18hDnw1QVK7v6+BRHJ9
	 arfsPaGXS8jVNk90S3qI7skPZj706QlQULM5KzAP1U9uf+lxoYwzJw7yJ3q2usLILXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838328;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=blkIELXaqeSrPlQhMw5wlX9/fGfIzWiX+AQp2/VCAu9X1bQP+0gJdtWVFGeWg5GROAVD
	 DRAE5pwpRVqMtR+d5YX/j8vvsxDL1yluYZzbcrmXQksleNk9z8g+dRpgn5jX7Qh/ORYbj
	 pY63VOAvgYtQmPYoa0309zcYaA4poOxGZz1I6FXfc48LoMdtzsND1IVxSVC9jxMtn52et
	 /Fgc4b3pBTygOFb1PY6dHT21yhxjIWGl2Zn0kFD2PlO6K9kgfc2h3RqaYN7HV8616YfJU
	 Dtq4zrRp5UTN093+Jy5wLvXWoIwMRcegqXnZMr8g0oBoYihVcfww0lRATXgh/SRebkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXeoLJ9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D79606A31C;
	Mon, 16 Nov 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXeoLJ9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7951F000C5;
	Mon, 16 Nov 2026 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838327;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXeoLJ9pMmP5InmZPg7ILmufllZYde193dt8DdHd5b+tYaq9jS7NBjVekzyDgL0+d
	 AhTMQwMNHuR694k+pijvgMQsgkCXY9VEWq8Avkbi0wouFYoBUncLM3O+6mQPXBixIJ
	 qh+4eAjnD4D+90K+CUcTf1ekFqu786fHl6Zcg0r26QNSzgnP484E3/g7Po6YT6QKZM
	 4NuuHwedEwqrOViJAMw9uFLB5c3F/iQ72P9Zg+gv4tw7HmDAdBce6OPsbP7E+ifDzM
	 1pCQhUlYYTOyuNQVZpd7ajdGA6G6JlbjASxjBAygZ9kcgIWeiZQb0SxHjXn+7UJS6S
	 EwBXI0255THdw==
From: netdev-bot+sinfo@kernel.org
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: 
 Re: [PATCH v2] net: stmmac: Disable checksum insertion for XDP frame TX
Date: Mon, 16 Nov 2026 14:12:06 +0000
Message-ID: <179483832607.3291.9756192515421548834@kernel.org>
In-Reply-To: <20261116134848.4793-1-jszhang@kernel.org>
References: <20261116134848.4793-1-jszhang@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
