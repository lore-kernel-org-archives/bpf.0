Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA31239086;
	Wed, 25 Feb 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016751; cv=none; b=JB3XaQLTkFud2qFvCp09EEBYpBd0GTBOQMlk00pMMKvglqyXsnDgoDwZtpoc3tnPpmcA1XrNc/sgFQezM2JHPr7G+IaHuiE20ynb4ujC6nq0+STqI+p85Ls3inSdSBpBAaD+igLIODuA5aKqOtRlmtsN2ogVGh46/XNl2NcSSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016751; c=relaxed/simple;
	bh=yuwwmarVQJbGtgQN4ILOy6JSC3S+6/92DRhYX5b5AXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXWc01WMqKmbw1AjvqTOEgitNcOIlQEvuoFjns8nWc0HGngVwA5sO/fcuYpHP8g4kp46Wa/tIsrhPzrlXZAv1TBRZ3bCZu5kwAx0mPlKV6mCOM2m1aXmAX/zq3HoBhUKrYCJ1JTy+2YMg0naMNQH8bTJCp722SFv62J97oJsMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.249.96] (ip-185-104-138-144.ptr.icomera.net [185.104.138.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DC9DF4C2C37D48;
	Wed, 25 Feb 2026 11:51:26 +0100 (CET)
Message-ID: <5d2c5f84-436f-4681-ad81-9900a8563b61@molgen.mpg.de>
Date: Wed, 25 Feb 2026 11:50:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] igc: fix page fault in XDP TX
 timestamps handling
To: Zdenek Bouska <zdenek.bouska@siemens.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran <richardcochran@gmail.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zdenek,


Thank you for your patch.

Am 25.02.26 um 10:58 schrieb Zdenek Bouska via Intel-wired-lan:
> If an XDP application that requested TX timestamping is shutting down
> while the link of the interface in use is still up the following kernel
> splat is reported:
> 
> [  883.803618] [   T1554] BUG: unable to handle page fault for address: ffffcfb6200fd008
> ...
> [  883.803650] [   T1554] Call Trace:
> [  883.803652] [   T1554]  <TASK>
> [  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
> [  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
> ...
> 
> During shutdown of the TX ring the xsk_meta pointers are left behind, so
> that the IRQ handler is trying to touch them.
> 
> This issue is now being fixed by cleaning up the stale xsk meta data on
> TX shutdown. TX timestamps on other queues remain unaffected.

If you have the commands to reproduce this, that’d be great to have.

> Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
> ---
> Changes in v2:
> - Moved 'adapter' variable declaration into the if block (Vinicius)
> - Link to v1: https://lore.kernel.org/r/20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>   drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++++
>   drivers/net/ethernet/intel/igc/igc_ptp.c  | 33 +++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index a427f05814c1ae7330c6f7034cd0f2b40b74dab6..17236813965d334f14eba928affbd4f91b96ecd4 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -781,6 +781,8 @@ int igc_ptp_hwtstamp_set(struct net_device *netdev,
>   			 struct kernel_hwtstamp_config *config,
>   			 struct netlink_ext_ack *extack);
>   void igc_ptp_tx_hang(struct igc_adapter *adapter);
> +void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter,
> +				       u16 queue_id);
>   void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
>   void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
>   
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 89a321a344d263ace5c66f7ade782b40cc482566..1931fcb659354d5009e0ea02316bf3a47b66b04d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -264,6 +264,13 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
>   	/* reset next_to_use and next_to_clean */
>   	tx_ring->next_to_use = 0;
>   	tx_ring->next_to_clean = 0;
> +
> +	/* Clear any lingering XSK TX timestamp requests */
> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
> +		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
> +
> +		igc_ptp_clear_xsk_tx_tstamp_queue(adapter, tx_ring->queue_index);
> +	}
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 7aae83c108fd7611b00bf075592f93a902b83422..98491346d21b80925ce42ba276d851d4318e66b7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -576,6 +576,39 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
>   	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>   }
>   
> +/**
> + * igc_ptp_clear_xsk_tx_tstamp_queue - Clear pending XSK TX timestamps for a queue
> + * @adapter: Board private structure
> + * @queue_id: TX queue index to clear timestamps for
> + *
> + * Iterates over all TX timestamp registers and releases any pending
> + * timestamp requests associated with the given TX queue. This is
> + * called when an XDP pool is being disabled to ensure no stale
> + * timestamp references remain.
> + */
> +void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter, u16 queue_id)
> +{
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
> +
> +	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> +		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
> +
> +		if (tstamp->buffer_type != IGC_TX_BUFFER_TYPE_XSK)
> +			continue;
> +		if (tstamp->xsk_queue_index != queue_id)
> +			continue;
> +		if (!tstamp->xsk_tx_buffer)
> +			continue;
> +
> +		igc_ptp_free_tx_buffer(adapter, tstamp);
> +	}
> +
> +	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
> +}
> +
>   static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
