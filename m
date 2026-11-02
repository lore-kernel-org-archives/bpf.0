Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619017;
	b=lV8x2t6mYzzPcEk8zlrOhZniuKdhJJuG/2byqkDpawAjIb7aZSA7rq8ejDVlyQsgJBCt
	 Wdt06hUN6V/egH18tOCfdKy9G7yPQcnuv2uMYwHjG3dYgVSbn3I7oqIrwA6KQx8QtIgtA
	 D2ovdrxYpboQ4hQwmJA9ZwMa/RiSt6eW9mftDmZeiK8Ofgz2Q8TE3u7ikUbJnXqv46n1o
	 XbXgoDDbQhtbfbxcFrA39s9gCUdLr6qVw2tksBgXkChWdqoPsvx/u2QgwSICm5YblQXXe
	 tulRBZrATHAkdNBu6eGI7G1e7Dld0eFGjfq4FRbk+BuTDtiBJiZ54i51y+9aAs76ZRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619017;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NZY9BQPDvkxgWE2rv8QDqhUgKPnpRpopG3JlsimKDq0=;
	b=z7F4CUpgm5cLA5q1RP87MZJOOTYLNcIWm386BT8YgOy3u3fgqGgEIEQ4N6TdAhCNkXoJ
	 BczgbSgBQeBGE4OfW7SlQ8Su4csmEILfUM9fAiNvEusQ8vj5mykztSbXEJfyMrNhaRrwW
	 G3nUS80Aoik4x9EDFY+4VQLIeqpXl6JDWKU8d4sN/d8mWLSIrDBPr2TvXv7u+uhAfoq8h
	 RUVpfR30pdK3xdg+0Xi8k5BtjFA3YOvHNvvrRYxcBmGuJlqL8Zf0lSD/w8Y7H3fAqkP3E
	 +C7vxR2uiaBQiGAWBsHavcu/jfawKWg0fMps2aNtjWHEUlM646atBoF248YExcgCJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=WzMuPcPK;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52948606A333;
	Mon,  2 Nov 2026 11:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52948606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=WzMuPcPK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793619017; x=1825155017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gdT4nn9wsvJ97/KVddnJOkN3H8mBQrTvIbZBwIumB2M=;
  b=WzMuPcPK/032P9L1V9430t/lfJY31DvEQr9sV6+tZILwQDTJu0BKNPWs
   oy1wNMCSGgUsSfsS0/LLVSqtXLFTFGapZ1SJqmPvLfxM5gYScqjALZjFo
   MRT/0MHN+bPi8dNthbF/ltLHxH441YzCprNjfQ79fEf1beujNRYrn2F6y
   s9M0PKzey4JecOoFvVySyVeLE3c1ozgX5pDRnuqUD52Jeq9w9klnSRuDK
   32wIAfoIwXHRjYl3EqwA5fsJ+d2ebs60I44OK3Rn21Klc725PM6gM9n10
   xOFiiSelwJ8Y2AC57/713lby5sIQnYi86HhrPMVNlBUp+ywu9pXc/FCHg
   A==;
X-CSE-ConnectionGUID: xqIXgdQUSxCWNgzIxk5xNg==
X-CSE-MsgGUID: a63FDLByToyww5QJi8dOKA==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="65878815"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2026 04:30:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 2 Nov 2026 04:30:15 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 2 Nov 2026 04:30:12 -0700
Date: Mon, 2 Nov 2026 12:30:11 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Suman Ghosh <sumang@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
Message-ID: <20261102113011.h4gv6z6y3ktab2cq@DEN-DL-M70577>
References: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>

Hi Nicolai,

> On interface down, the TX completion cleanup also runs on the XDP
> queues, but treats the pending xdp_frames as skbs. Freeing them with
> dev_kfree_skb_any() corrupts page pool memory.
> 
> This happens when XDP_TX or redirected packets are still in flight on
> ifdown, or when the XDP program is replaced.
> 
> Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp buffers")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Pre-existing bug, flagged by the clashiko review of my ipsec transmit
> fixes for this driver [1], which seems reasonable (and fixable) to me.
> 
> The other pre-existing findings there (e.g. the SA lifetime in
> cn10k_ipsec_del_state()) may be worth fixing too, but I'll leave those
> to the maintainers.
> 
> Compile-tested only, I have no octeontx2 hardware.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36%40tipi-net.de
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa0..e3b07e5335fb8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1332,6 +1332,7 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
>  	struct nix_cqe_tx_s *cqe;
>  	struct netdev_queue *txq;
>  	int processed_cqe = 0;
> +	int xsk_frames = 0;
>  	struct sg_list *sg;
>  	int qidx;
>  
> @@ -1348,6 +1349,10 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
>  
>  		if (!cqe)
>  			continue;
> +		if (cq->cq_type == CQ_XDP) {
> +			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe, &xsk_frames);

Any reason xsk_frames is never handed to xsk_tx_completed()?

> +			continue;
> +		}
>  		sg = &sq->sg[cqe->comp.sqe_id];
>  		skb = (struct sk_buff *)sg->skb;
>  		if (skb) {
> 
> ---
> base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
> change-id: 20261028-nb-otx2-xdp-cqe-cleanup-net-5810d40e1d30
> 
> Best regards,
> --  
> Nicolai Buchwitz <nb@tipi-net.de>
> 

/Daniel
