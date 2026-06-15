Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B12FFFB5;
	Mon, 15 Jun 2026 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565721; cv=none; b=sD/OIEPHc/soEIQvcUD1BtqU0JA64CUQztpQhSx+boCHEB+Mh3TMBRHSKEuib46YtIO1rVL3D8KFGJSBbGqy81mJ5T1teIB+N2Kr0fSNoYoWKhxdnNELpejRwNEtVS2eGHL25TKbMMHAJfG5p72ivYh0G4Dfn/o/nzGBrySbKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565721; c=relaxed/simple;
	bh=anIGmxFrM6IOXYEJWhizU+cURCoxzWoYfP6Nf1Aav+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEsf5NsB0es5SvBFgR8uN4y5/cP3SU0/NPApbDF5gYtah3RjOu0wB1TlR4VmdETlt69h9kFhz33ezmrOpi5dvgxecAm7KpoYdhf1XoYZkJ2oShRMarjk/0maRr6WShGBJDcFEbRaVFjZS0K1znOk45xSite+eiFkLU+FvAeytTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5u3AMZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5u3AMZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99DB1F000E9;
	Mon, 15 Jun 2026 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781565719;
	bh=12xCYe4ieqhwExskYGWu30pRBE8o996AZrPppTl9ixc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M5u3AMZs/zrNeptcKR/L1LwbH8tGYHQ7LuESwqK2Zr+LXrbIfZvIJUwqYeFNiebGX
	 iFfbLnHb1CUU+oOQIcC08SZRM3Y9YxTPje6vwwuFrMJJNkKBiIyiLJxjVbg3IS2Wl6
	 Y2hBNkowlbIneF8BmmkzejNkJFiKFRNkm0lKT9Mjihmk404AWG6/vrrowxXUwhmI94
	 ERma0k0Hlt8qKKgxQ6hrBQJ8UxAR7pJQ+BlqTaa269l1+oKyzsMRD3IKen+Gr8k4Tu
	 tX43ewxQ533ID9F63RyPZJCJ/nykt11otHxSU1mOFk2tQgga7r/3O9JAA1nYxeQpZ+
	 XU7M8epez5D/A==
Date: Mon, 15 Jun 2026 16:21:57 -0700
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
Message-ID: <20260615162157.3748bcda@kernel.org>
In-Reply-To: <20260611185744.2498070-5-m-malladi@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
	<20260611185744.2498070-5-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 00:27:44 +0530 Meghana Malladi wrote:
> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
>  
>  		num_tx++;
>  	}
> -
> -	xsk_tx_release(tx_chn->xsk_pool);
> -	return num_tx;

Why are you deleting this?

>  }
>  
>  void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  		num_tx++;
>  	}
>  
> -	if (!num_tx)
> -		return 0;

Does something prevent us from running all this code if budget is 0?
If budget is 0 we can complete normal Tx with skbs but we must
not touch any AF-XDP related state.

>  	netif_txq = netdev_get_tx_queue(ndev, chn);
>  	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
>  
> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  
>  		netif_txq = netdev_get_tx_queue(ndev, chn);
>  		txq_trans_cond_update(netif_txq);

This looks misplaced, now we will hit it even if we didn't complete 
or submit any Tx.

> +		__netif_tx_lock(netif_txq, smp_processor_id());
>  		emac_xsk_xmit_zc(emac, chn);
> +		__netif_tx_unlock(netif_txq);
>  	}
