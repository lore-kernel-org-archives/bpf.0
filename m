Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736269;
	b=EIZPn0MD63lAaYWgcxP4F7kfv5iTZf2UpRzF/pRGs5gTom51LTCIDK56KHPAToPjRMVl
	 /brzeZSsdIFlKWpyNFsQFXSgkHRxQj5ebuji1Q7R15b5Bycrt9o8eFbwQrNdF3ng1oaIZ
	 GtpBs8GF1ExNHBStp8Vx5RfbLkKa90z4AlQJJa0FZ4jOdSP6NRjYNCXpi5oukceUkGJXo
	 mdnI/sOlgSQHHR/Uc3n9C30yMSSUFwPYQh/cyij0CJSEaRGOc87OP33bQrJ/sYWssiH0g
	 hc7iUovuRO/klf3E4ejF5d5P0/JP7UbQxxoAlzVASYlF7FEpAn7wNm2xRcA1oL/Zigw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=SWhEfYUPJYTrxmTb8Gouq3K91YhE2Ifu3AI1WReJddLJCDuX0YCr6w6aGAskwclrSP1e
	 91dhsAOiEK5N8XSFoIawyCJ7mzl5b11HorLI47Tqv/XYjJFULWCcAtIR0PyFCPnim8B5O
	 QVvUDuHRR9d4X5mI561GpWXhljQWLgkRpalXyBdln+dHkllyg0SxYV2E4lgEbUPKRwAZE
	 kbh355wC73jreyVj7uOspcRFltbsbiOvBL3p0Y6cYiycI7mD3AsKtmSt0ZiOyEC5CW0xT
	 ZBFvaT4z230ysAYMhuCkQinpHb54nl+gHJ/Qqns8HS/qLSt3LamcRwR3csiGL7r3v4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhISSf8y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9E606A326;
	Tue,  3 Nov 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhISSf8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389961F00919;
	Tue,  3 Nov 2026 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793736269;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhISSf8yjGc/gbPmrANq0R2bWG2afWk3mfBNO2On1lpqdsCgAVbH6cfnxIdTXRU0B
	 FzdvfRtTvOD+HZw//oMoYDqFtpUnkS8/wxxONz2v8utV7kpBLOdx4A+WQJR2EtUu9X
	 14Icrnwy7vQB0iiyc3xieUp1COAVELca3y8AbYpSv8y6m/4Vo6m0UoRv6WeR8CkzTo
	 17Qs/pG4va399eYd4uAORhuM3wYcmvFTahVjzKXt0JJDFdH8xJOeaEejsq+N4if9y+
	 EoOIM/5cDJvlhd5T+p7jTfJ7ZAbuxyaaw7N1RGxqyC72sET1kTbbrUoES5l3RObDTY
	 JfYEc7qcIc1lw==
From: netdev-bot+sinfo@kernel.org
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net 0/2] net: fix mac_len of skbs copied by generic XDP
Date: Tue, 03 Nov 2026 20:04:27 +0000
Message-ID: <179373626776.488859.10701424242617832815@kernel.org>
In-Reply-To: <20261103200036.65764-2-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
