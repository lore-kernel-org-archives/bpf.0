Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765568;
	b=JL4YLokKx7RafAXfKZGPYQdjIIFsq76Is4qsfDultSgZPY9HeA2jDUA1XZYC5Ory8Re9
	 mqEurRjOnS+al92z32ZHoTV/mgXBW4E3KNWomIS4FEBte0J4dPc7Hn36DPS+IymsdtYzn
	 VnxXNwXoEPH2voSX6Q6jmV3a5WMu49Yx5htSmq1AURnIgg6Zsoy+bZ4gbDL/2hvujweOY
	 ALIlv5UJBiyrEi88eT5QTnfr5fvMovafF4Sc+Yj57WINyTnw8rs782NARxtYXXjuIZaF6
	 nLYEJnAImG7hC99NdXZq/z9eFLlnTmJA/ZYE2uPgBdjNCs82Vdk3Ld9s8bnDy9kj2Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765568;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=rNQVTx4lhPT7gUYO3AytUq5JqSDXfzRQRvUF5K9FXCY=;
	b=2/B/804rs/uXBWRzDvKcYygwyBnbHPFKRNNxIvw90DtlHW+52ofaCQebU4REWx2qepEg
	 YW5uXnddr1DB1LP5W+BRwZmTH6oWEaP6LZcvVrK2han064E1yPNPw1riw3AkjP9l2MZPT
	 WS/AW9apsK/FT/GGhPxAUHJtdgcjJncuFwTMOVUPzLfEexa2m2FKWJ2kpp4+Xzle/6XCe
	 O4Tt/gZUDciTeO7xVPe/vhkIjbFSJcQcqLREHjVUHnnfs/56gYrlyIK+wMrkULUcAnUTr
	 7J0jCpW230hP2n2YaTBRsI6g+Swmy5S0lSTTkzZrF8VF+JEtEUYhikOECjJ1lzMxWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=j2KqxSqa;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A6606A31B;
	Wed,  4 Nov 2026 04:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B6A6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=j2KqxSqa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rNQVTx4lhPT7gUYO3AytUq5JqSDXfzRQRvUF5K9FXCY=; b=j2KqxSqahhxPxqBn2O3ZEJgme5
	ImruPr9ETsXPi8d5ePjsYJb2m6RBUStdiGJSdtSFxd7HFkI+VOcc+oUZkVWFpl3AwHtWJAln4RcJ6
	GeDbFfQRtejBBRlQKwEIpeph9JpAzdmKAJne4RpTmXYZCzm2yihURS8yhqAn7HP27Pg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOSMP-00EEjx-JJ; Wed, 04 Nov 2026 05:12:29 +0100
Date: Wed, 4 Nov 2026 05:12:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: stmmac: unwind the XSK pool when the initial wakeup
 fails
Message-ID: <972f6505-f5ff-470a-bc2e-d82f7ecd0577@lunn.ch>
References: <20261104025342.1527441-1-vulab@iscas.ac.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104025342.1527441-1-vulab@iscas.ac.cn>

> +static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue);

Never add forward declarations in the kernel, move the code needed
before it is called.

    Andrew

---
pw-bot: cr
