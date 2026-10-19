Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608B368D46;
	Mon, 19 Oct 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408126; cv=none; b=pFhsS+9pZBq3MLuln5Q0PBjIm0iopWfF0Xp3l1mLzrSwA508rBtwYqvV2gqAmCNC5dqydLBhMwuxzwjneg5/JH9yCIC9U/nA6pEDDCw52h4UdwH32pt8R+JSofVO9X5BjKPCuFYcwC7EZbLHDOz3alArfdIJUjuSvPwinhC61AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408126; c=relaxed/simple;
	bh=I1NkXJWU7BObp9TspanxhjZF2DBSFWJ3/CzSDJwAY48=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VuOTizucZpKJH72bKtv+10B3CdGJY+e3TldVElp/G7Gfncn1VPO7Czn1TIMss4Bf7RMKpCEbuLPs+je17rp6V67deFbAfFSGn1rXJXqQMoMh8+PCjcRemJEapy1z2tYu5MncQDlzU4x/ZX0Un3nGBu0DjngRjSaWaMQIp0RyxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=MhI1Q9md; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="MhI1Q9md"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9E08A012B;
	Mon, 19 Oct 2026 13:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792408123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=llR1/M0o2+RZ7BjQt2ccx5czJ+FAocfUi1hrDYTfbnY=;
	b=MhI1Q9md5FRv287FvCaP3fHOmIanX/KO9qN8HAatofw9iqGHq4SmS9eyFq6OT5TYZubKo/
	81Tok1syzLXxgRy18Oi+xm0Jb4dSyqfS/m0T89/4ivJ/EeN5Z9LkDo+FU+kFrZ49XuVBhu
	efbrH0HZsOB4+XsBTgi0QnJk1Iv8Zazihtsma6OMHsvESK2aid09Dh2Fc+zRhEJS5oxGZy
	nueKDGINUQK6ng7ofrmDPjRSkVKlx6kkHGvcmnhZySsb3W1hypA1zdP/orgU7SLqswPOyL
	fE6l+774LYv13uyeN6nRy2W+1WQeZSTIirgrOhqtBQuSTRmJY3BRs5p9786rCw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 13:08:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] net: stmmac: fix VLAN tag stripping on
 non-linear RX frames
In-Reply-To: <20261018-stmmac-rx-mb-v8-4-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
 <20261018-stmmac-rx-mb-v8-4-5f58c0b25849@oss.qualcomm.com>
Message-ID: <276f90f8ab2bc5f022c894b0542d57e3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.10.2026 19:07, Lorenzo Bianconi wrote:
> stmmac_rx_vlan() reads the VLAN header straight from skb->data and
> removes it with skb_pull(), assuming the header is always in the linear
> part of the skb. That is not true once non-linear skbs can reach it: a
> program loaded with BPF_F_XDP_HAS_FRAGS can pass up a fragmented frame
> whose linear head has been shortened to as little as ETH_HLEN by
> bpf_xdp_adjust_head(), and the unguarded skb_pull() then drives 
> skb->len
> below skb->data_len, tripping BUG() in __skb_pull().
> 
> Pull the VLAN header into the linear part with pskb_may_pull() before
> touching it and re-derive the header pointer afterwards, as
> pskb_may_pull() may reallocate the skb head. Also move the XDP metadata
> written with bpf_xdp_adjust_meta() together with the MAC header when 
> the
> tag is popped, so data_meta still points at the metadata after
> eth_type_trans() anchors mac_header, instead of at the first bytes of
> the destination MAC. Return an error so the callers can drop the frame
> when the header cannot be pulled.
> 
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
