Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620195;
	b=Z6KKA7woCsReFuclkJ1J9Pm9Qji3mkwXJJhWY8+xWPXvtbBGsOv9OWe4nw+1DoiRf/B6
	 xSF/PSRC5GwExjDe039hhPVU1om6DYX2SvpF0mOQlPV2xsc6fM6ISMzw8U14PGH/sq8+9
	 3hvdAhWn+tF3BAlfGItcrTShjOXwK1HUdvavRRfeYbwxvzY6yCLNJ4bqKNalCYp/Q/Byl
	 fTS5b4gobvkDeBnIoWeMjg5k0dfEfr1kaIrVT2pF0T8Cm6R8LASfNICnscAurSe19Nwsf
	 mxX/kdduufG4L/OrT7v0JavaxOwwQdacGUvNssMZfF1U4fQBqlIuxEOVGINT2OSp1Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=xZ8R/0zL0WnVnApWQF0YiVgUe4Ls1tYHcgi2ZrmQ/kddJeO3wKq4SKGsbFKPAMYc46Uc
	 VTjJJKixAR0JUJlXziR1Uo6H2H3lJcpvoW5WwqSTKvscuvpqKBs6CH8YAlOj4F2gFdLAX
	 S1kZ3oZbp3PXae4578OyxNkUNSGgC1iykzQG2fhOen+TNJjepewBv89ehPqqLq67K8wrH
	 7iS8jJHdc0Cd67N8ZaJFOzaZHiZomjxnMn7tyKu3p7tWzex6+xvYBBGtRqPM3pNnCoMWa
	 EKs4BTRf5EeHIuL8NOiEblrEFfiq7gl2YU7QpNANouAL8ZHcKI+M8T07gB9yAQMalPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVE81PL1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA94606A32C;
	Mon,  2 Nov 2026 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVE81PL1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149C01F00A16;
	Mon,  2 Nov 2026 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620195;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVE81PL1ATw+J0OiuNGT5mE5qhBBIYma1qfdt7eQ9xpWGP2doo74uPoAaqxYY8j5u
	 Lz/nQe/YfRA0awxr8L9eQE2AXVesp/+4BqB3M44OEhTEqCuFuwQdw0B+6+0mz0uytM
	 OeCKjRj1VM6LRiwA39LunC0fQp+cHFiLMw1rC9EWlgy9/j3eZs0nCE8K5Fe5xTb5+h
	 iKfKUqhnrLDHDBfLEboNRlG20SjtwnUPf9Vw8FlyF/Cvud/WLCpmPeVOjYKv7Fj9qb
	 UgnphdUOW5Jwx5efO5oE2yAuH0I14PYCskFHNVZkId8Yx/bXtEFSdUHbyPIvf8yNqL
	 9kJVfgS17cL6Q==
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
 Stanislav Fomichev <sdf@fomichev.me>,
 Song Yoong Siang <yoong.siang.song@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: 
 Re: [PATCH net] net: stmmac: set XDP metadata length on the page_pool RX path
Date: Mon, 02 Nov 2026 11:49:53 +0000
Message-ID: <179362019361.3286.8732260602904932373@kernel.org>
In-Reply-To: 
 <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
References: 
 <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
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
