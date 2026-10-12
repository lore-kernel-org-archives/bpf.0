Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55E4C33EF;
	Mon, 12 Oct 2026 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838746; cv=none; b=XrOWBw2KynsuS8gz2kNhklpfhtKLXc1sJqzJYCFuNRVvWal+S4ha9VCgxpJbocek2pbk17QEF8SlqzoQOgiK1SrKtKkCr8a1WWEZbNuty0QoI7DdhJsz4xwwAR9GMMBIL7VKt/sO/j3Hqt3Jm6TS4utAgGZLxpWOMib5FY87yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838746; c=relaxed/simple;
	bh=EG+lZEtItu31luwtTBP0PeVXPPhs6XnTgs671t8mWg0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZaDcJ2eh++9eFDogCuWo4Amm9ITSG83fYTV7Bdy8Qpx5DKsYzQT0nBvndc1B3pkwsyhBMec618udZGTJgtNf1Bqc9ebbAdjgA/KNtIZJ1Z78PA8Uk1rdB71Xo8VVCblsrmejckuah/oZ4AGTOZqs1kQYyt7l20YaEHdsLjyI6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=EzSm5dvL; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="EzSm5dvL"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D914A1583;
	Mon, 12 Oct 2026 22:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791838738; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b7gHMV3umSUeDW/ePA4faUCYbBu5Azy4eUsgtI9tPzs=;
	b=EzSm5dvL7ATlJxnSTNJmDAp/fW9wg6fTo12WUZXP8S953bpQ8tsUVSOxYBYo6wrXw4QwnY
	Ma6OZwWUqp7wFVH3q0koTg/H94K86mjCmZAhiDirvqCQY0FQwF76mF8jQzoDP7HHWVdaq1
	1XP0HZvB3BUsnYZ/DSuhXruffJ4fUyILiGoxLzTB+rciulAVysagewVFZB8QUhvPXL0UoD
	6mFq7gpQNduexAR0s2n2omYqH+3rC13IJwgoGp7nVgaKBnZ6T83YPLQlW/uVvDj5j9OhWb
	w/z6PY9EzcqiX4/fPGRBKTi/l3sLPRH9an+n+8Un3nAWEbBOjO2jLP9hrFY52A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 22:58:52 +0200
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
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, James Hilliard
 <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v6 1/4] net: stmmac: take ownership of saved RX
 state at poll entry
In-Reply-To: <20261012-stmmac-rx-mb-v6-1-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-1-2225050915c1@oss.qualcomm.com>
Message-ID: <829fd355a6673517df0eeaa382f078c4@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> When a saved partial packet completes with a poll budget of one, the
> old loop can leave state_saved and state.skb pointing at an skb that
> has already been delivered or freed. The next poll then reuses that
> pointer, causing a use-after-free or double free.
> 
> Take the saved state at poll entry and clear the stored ownership
> immediately. Save it again only if the packet remains incomplete,
> including when the next descriptor is still DMA-owned.
> 
> Track the frame-in-progress flag independently of the status read from
> the next descriptor. The old code keyed the save on the status of the
> last descriptor looked at, so a loop stopped at a DMA-owned descriptor
> (rx status not yet valid) could drop the saved error/length bookkeeping
> in stmmac_rx_zc().
> 
> Drop the saved state both when the queue parameters are reset and when
> the ring is destroyed. stmmac_reset_rx_queue() is reached from
> __stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
> stmmac_enable_rx_queue(); without draining it there, a partial frame
> saved before suspend (or before a queue is disabled and re-enabled)
> survives while cur_rx and dirty_rx are re-armed, and the first poll
> resumes that stale skb with descriptors from the freshly initialized
> ring. __free_dma_rx_desc_resources() releases it on teardown.
> 
> Apply the same state handling to stmmac_rx_zc(), which also leaves
> state_saved set when a saved frame finishes at the budget boundary.
> That path saves only error and length bookkeeping, not an skb pointer.
> 
> Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header 
> support")
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
