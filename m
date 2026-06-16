Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86444105C;
	Tue, 16 Jun 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623198; cv=none; b=jUsn77YwIcHVWJTfgXyszttSJk4QkM6+Y0755hEMonU4FBH8wnqRjYlyw+n3HXlQP1KWR8a6VOGKYavT2c2numjtncnIIzYITyp8SrmwbBTiLDHdJdgT4dUOdqVnh1QklCxLoVgMcQbicrpW5Odj/A5vrIoUoEu+/Q/261CHm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623198; c=relaxed/simple;
	bh=JlUmJ5DBcsfUYQX4vTIw4k1KT8v4/azxh62j2Yp9PoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBN/mh++M4M1CL0c7DgKNF+LA5o1yNVf527lC0EnjUYcfh/cTvQObni5qDOLk8BYc/hLWOeAe4tgEBajzbHeivxlGPpXC5mzNR8EB4sMQdNsbSnOcERdmo16miKA1I7TWfvSAM09ROG233/YYeD7kNWnPZvtA10ew3RPJahSDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHNEtl8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHNEtl8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B128D1F000E9;
	Tue, 16 Jun 2026 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623196;
	bh=VfbnHY+aIdC82PGEHGtuLsQPBx8FLWY1rXe+qSv98R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mHNEtl8RbNvTGPTjX3pTBwPHUIhqntugKsjms91Ls7d61c5mmVyuH+GHfghcDdZSf
	 /nj7LafsGUp8ljfbv63H7uY34K5fpgjQh4rjja9+ps6pad72/qnzQs1BiHxiRIk2fo
	 B5Crbz5sDRCq5okwRknKNZImddxeI6GJ2BRpPygnNMrUx4tBM7acfOgOMz9w5YH7kf
	 JlMP/6iVUSX5Qfu17S7v6LuM2+H4nfUo0klMVovuNkWlpkxVm59Rlk8RnS82YjkNMp
	 hBg6JVIezzCk91zmmovFSBIwW1/DbYzebsj0R8QTgJYcYTYqes/yI0/LETGFkutney
	 moeafmV/dqjGw==
Date: Tue, 16 Jun 2026 08:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
 <vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
 <jacob.e.keller@intel.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
 <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net 4/4] net: ti: icssg: Fix XSK zero copy TX during
 application wakeup
Message-ID: <20260616081954.0d12aa13@kernel.org>
In-Reply-To: <ed0bc332-0196-4613-8066-9b94f8ed0013@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
	<20260611185744.2498070-5-m-malladi@ti.com>
	<20260615162157.3748bcda@kernel.org>
	<ed0bc332-0196-4613-8066-9b94f8ed0013@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 16:41:00 +0530 Meghana Malladi wrote:
> On 6/16/26 04:51, Jakub Kicinski wrote:
> > On Fri, 12 Jun 2026 00:27:44 +0530 Meghana Malladi wrote:  
> >> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
> >>   
> >>   		num_tx++;
> >>   	}
> >> -
> >> -	xsk_tx_release(tx_chn->xsk_pool);
> >> -	return num_tx;  
> > 
> > Why are you deleting this?
> >   
> 
> xsk_sendmsg() also calls this without an rcu-lock when transmitting the 
> packets if the xmit was successful, so I was assuming it is not required 
> and I removed this.

I think you still need it. Besides, seems like a separate cleanup.

> >>   void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
> >> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
> >>   		num_tx++;
> >>   	}
> >>   
> >> -	if (!num_tx)
> >> -		return 0;  
> > 
> > Does something prevent us from running all this code if budget is 0?
> > If budget is 0 we can complete normal Tx with skbs but we must
> > not touch any AF-XDP related state.
> 
> Can you elaborate more, I couldn't interpret your comment here

netpoll may call napi from any context, including from IRQ.
It uses budget of 0 to indicate that it's trying to only reap tx
completions, without doing any Rx or XDP work. XDPs can't be called
from IRQ context.

> >>   	netif_txq = netdev_get_tx_queue(ndev, chn);
> >>   	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
> >>   
> >> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
> >>   
> >>   		netif_txq = netdev_get_tx_queue(ndev, chn);
> >>   		txq_trans_cond_update(netif_txq);  
> > 
> > This looks misplaced, now we will hit it even if we didn't complete
> > or submit any Tx.
> 
> This code needs to be hit for packet transmission in zero copy mode.
> emac_xsk_xmit_zc() submits the packets to the DMA in NAPI context,
> when application wakes up the driver and triggers NAPI. Once DMA 
> transfer is done, irq gets triggered NAPI gets called which will handle 
> the tx packet completion + submit next Tx batch packets to the DMA.
> 
> if (tx_chn->xsk_pool) -> check ensure this hits and runs for zero copy 
> only. Also above check (!num_tx) returns early during the application 
> wakeup (where budget is zero), hence it is removed.

I'm commenting on txq_trans_cond_update(), you're calling it
effectively on every NAPI call when XSK is bound, whether
Tx is making progress or not.
