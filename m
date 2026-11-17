Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931057;
	b=jneOO47roTz7HgqN0ESq83rZnjJQbIdigp8XBJSiFrWhMqMrZHAwD+kv63reFaGPoixd
	 VXqqP5Tkn9tmYevaED9HA5dRERFuEWPIte9EcT3NZExI1DGXtCsRnMlulgGUtsmycq9+S
	 okOknROoM769gv+uRPBkTnZWIIYfBnt8YF1qGX81CT+iM6C7tf2J0KUKV6TZhvxDGZUCU
	 gEcpz9shcupphVvHp2F658hlQ8OzCYdPEpoz/6PN52K8nDmCjsvWSPKHEhoVgFbbyGpLO
	 YQbGu5yi6dubTpSs6XOjJ4KE34gzPw5+of05L2pMyFElqTAKGZ1eVlRK1mLvgYqtBiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=r06Z0cwHYHKqzmWf1pMBS47Fcml3mNTfSgZRyxrcEnZfdCWsjtheKNE6uw0cxaLerL1n
	 FqOTuT5MaUie9VNjriIgs7H6OvDFO88ly+bHEAAOVm3dN6g23xM0UTaeSSw4hYAT8cnd+
	 6goyXWbzFTkz79hHiTspUMFRC9BrPWqNTTdsmldOXL+WwXFJ/cOqyg19yXqzSUZZrAnb+
	 oxajBky9CJ7iFBw5nEODWr8Y1/nXIjBxvIJLN5K+Suu4PK8T2f/jMzasN2lRdClLmqk1I
	 2YYtqR/MvMZMjI9NNydxYucGZZ9HERQwQQzhdF9n27WniwTD5A1Ilp3OwXpvUfIGkPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqAunJ9S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF789606A331;
	Tue, 17 Nov 2026 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqAunJ9S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419381F000CC;
	Tue, 17 Nov 2026 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794931057;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqAunJ9S14rv0YgjXfzLTU5lWReAsZ50+ynx5TK/jY5QUYHv5To3xOotDm6z+S6E7
	 6TU5zv7Ubom9eSAy9REfh2HQlLh8OHe3A2gxGuG1XsHuiKDpCYyEkQoUSF/bcSYTE+
	 TV4Qqlw2mbXssOi+eLAoB83Nza0kGJrJVdVBbZYgz1eJ2P/oyI4bHgDEzu4JxRFs8v
	 7knlCmooWuzWQw2BNNxpVj8/8cnJUongLyWDcKPRZpYn3n41u5jhftUXQyGVMYlXIa
	 M+6bXA9e8G6PMTCnIFz3tVox5M6xt3dmLk+q9gTuwBbsgJ/2TIaPnyucfn9TxzXW7B
	 /fJwhUT8nkVbA==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Vladimir Oltean <olteanv@gmail.com>,
 Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: 
 Re: [PATCH net] net: stmmac: fix num tx queues in stmmac_xdp_get_tx_queue()
Date: Tue, 17 Nov 2026 15:57:35 +0000
Message-ID: <179493105581.3291.4118659695077688589@kernel.org>
In-Reply-To:
 <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
References:
 <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
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
