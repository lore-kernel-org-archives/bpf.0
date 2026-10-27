Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109011;
	b=jeEFIEKoJbNsGhaW3XCsewN1/7YXHdWI3QHXRurQtpwk2B+e9q/RcvjuO5YQ/xGsWeLm
	 g4kOMlZTD2dFa6eJHCAPyg5zjbqIIAS46Aw9Uu/J2FeUOqmz1p6l5uldvwgw7LJ/eCHH6
	 hthf94UvtJecUUf0+WW7tPS3kFObPRAYJ+T6pJqD6Pxl9dN77Ct0smft5qGXHxpr0qmFq
	 NtX1iPJdjpmvafaWctvoHxQJoTVKfPFOvLTdETP7+pGqTnskFaMkPoqtdJGvYwf9schR7
	 NqiYJrxhxsK4caCln1VcwZOLHnwaaOn8l1u0gzHdpti5E8KVVuZAFlHyCTpvEm+5wuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=oxD4cWbiqTTDrasYJYPkkDb8UFvTfqa8u/DLvZA+jxEZwrVQz9JaCtRLqCHcG3yJX88a
	 qucNyKT+2SCwolYHv6x7Y6jqwFEEpNOgEfMIv4qd8gsjiC52YORsGj+bsAvga8L4Fcf4W
	 iarB+AuxhNxN4M2ndaZ6HL8VBz5ucgEUSHI5GUPAEnHUu7vjwOTC3m4ToFDO3m7GRFHkk
	 njr/oYgEczON0UFLZBcp+DHfLCr5GXH3b7jFqYzU6oeJPammZhCk9M+vuwJYRkQszNx6B
	 TeD1kjT3Aqj6jLRIrX7/AHG1ghmMn4Ca8+CmYIrTCf2bZvz5kNFeP7dZWotT7gBYqog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT8AASMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5C606A31A;
	Tue, 27 Oct 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT8AASMT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E951F031E0;
	Tue, 27 Oct 2026 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109010;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AT8AASMTHVvyF7n3nLcnxQzd2W/GHQfAQrL8o3MnITCMMoOdJwlLDVwUJsUAE6A3K
	 tf9DH54i2JCNi2rta+FUqc0rgTE+E2AsHasuY9evG0YF1VOPIp1OKtw6hw9czf+mIb
	 +ojN98QfyhKDzqePzuPj9Lh2+Ar+1LeT2NAncpll0TR9CDkVZxkJF5aQHCS6zLHSDw
	 Qwh+ab9L5IEA5Wkhu+Me60lEO1hwOq7Kz8HhnHk4bUp+7S+4PSv5sr/MqZ6HRTW/Dn
	 PXLDNt6GlZFMXpR8/t1M8xzzrdaAhfhxXWABy5tjAQUPOH+h/Du9YrT11CtZnDwhYF
	 DbBVoAFoMXEOg==
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
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 James Hilliard <james.hilliard1@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 0/6] net: stmmac: XDP path fixes
Date: Tue, 27 Oct 2026 13:50:08 +0000
Message-ID: <179310900894.3327.16366770051104266138@kernel.org>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
