Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DE4B1D16;
	Mon, 12 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838769; cv=none; b=c/hGqLKLeACbCscLV95k8wYqofFhkKZMIaGg+il3m/2IEHjq0wKUuHTVEJTvEL1D2Gm5fsinz0oiKsy7TZxGoSvEs/Q8qzOy53OpyOe4lH57rEH6BT2HReHgJRxFBIJ35i/P79KlaARQ0ADwJIC0kyiRZJsw6BpECOu7LPRDCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838769; c=relaxed/simple;
	bh=iy2Gu1Xh+pBZEGa+Rz72deaxo4wVLFRz04uxXRYJirE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BxyE1e/C9wBEYwQJFc833qjkJp1oAJ3ITVpUoDfztawotBMRk43guXP/wM1Wijv1Cdqv8rPHJ98hVbbqSJwMxn/Wd7nDX2pyFf/sV+v08ekPHvDR3zft4qNME5C3l2P1rHUuMelNg10mGTpd2PaUhRUpNMea8M/eZ5fGMKjwiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=wN+s3QTH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="wN+s3QTH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79E20A1552;
	Mon, 12 Oct 2026 22:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791838763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vaoUskc8feZSg15SFM0v3Zd5QJMwrh9CubC02jWIJuE=;
	b=wN+s3QTHwrwRNofUuZHoJjX0YjT021I+RyJYFpDy9DMMECvd07aLIJ/bGIIWjMxceryAPJ
	vcnPBC8QJ+HIYkptQ/8jJ37C+aLbzsoq/J7q9ru5kStE9Azi0JzgR/3XCrSKFEw5IjSjpk
	krEbMTM0VaCTEWLkWQyMjrkQorkhkwVnbiAApyZyvLnhxZUHVuXmoGEKaHLi9IZVEzP7aG
	Eumk5FPOFKaSHP3slCSTJYMuSEJKrop2HuA+kCGD4m1B3L2uMk6vGW6/nkbYITo3qhiYGz
	IY8xUxKWgzgnCWWsaAK7s+TMwftpk3fO3nrTJuHcYIkygAmEZU7apOK4BapIDw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 22:59:23 +0200
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
Subject: Re: [PATCH net-next v6 2/4] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
In-Reply-To: <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
Message-ID: <c5b6cd354d32c5b84c146943ce00b3d6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
> XSK pool buffer and drops any frame that spans more than one RX
> descriptor:
> 
>         /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
>         if (likely(status & rx_not_ls)) {
>                 xsk_buff_free(buf->xdp);
>                 buf->xdp = NULL;
>                 rx_dropped++;
>                 error = 1;
>                 dirty++;
>                 goto read_again;
>         }
> 
> The non-last descriptors are freed and dropped, but the frame is not
> marked as errored. When the poll reaches the last descriptor of the
> same frame, error is still 0, so the fragment is handled as a complete
> frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
> or converted for XDP_TX. The tail starts in the middle of the original
> payload at a predictable offset and, parsed as a fresh frame (len == 
> 0),
> stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
> though the DMA engine only wrote the tail remainder into that buffer, 
> so
> the reads extend past the received bytes and can reach beyond the end 
> of
> the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
> in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
> when the interface MTU is left at 1500.
> 
> Set error when the 1:1 mapping check drops a descriptor, so the
> remaining descriptors of the frame - including the last one - are
> drained and released with xsk_buff_free() instead of being processed as
> a new frame. Account every freed buffer with dirty and count the
> dropped frame once in the poll budget / rx_pkt_n, and once in
> rx_dropped.
> 
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
