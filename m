Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82040DFDA;
	Sat, 28 Mar 2026 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774730207; cv=none; b=b6C0JNJ1RhXKwjfVg74v+h0v7nXVkA9u5ISm+roFJ+gYfnjDBM50q+0JkhOclhfT6TrbFFRkezx6REt2qoUqP2PblxEG2v7CSHYnXqdpp+n4G08RD7qrMg6jb/Vkis8Jcas1aP0ecMFdxkzVR5i6xW7/KJWFnweTbr6UXC/FOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774730207; c=relaxed/simple;
	bh=nIL0XDMlVefhqrVUWMCYBuniRXD307UvHlLbMTelUkM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KaSM8f8n9E/rEC5j/905IVn3MlBc9q59vO9gHxbS+Jcx9Gh4VhOuAAR/W5hHy2F9jihngqUeJ4zj6mbIOMP5mynGRqDSo+YmbHJsojKJBD7yVdGjA21S5X8CmohrbuslWlS3O2tZvnjPnmM0n33jlR/B3mJqrUVB/y3j7qfV0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=avU0OdIG; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="avU0OdIG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3038FA5842;
	Sat, 28 Mar 2026 21:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774730182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j5ffpPEEKmpVzD289rkZzzPLyWoX4V35qWw/m0tK9D8=;
	b=avU0OdIGB2HBb557hov0Tu4evt0t6gxr1mT9ezgsErhao5GSH4/B85QCTHHXkEGVZeGCx7
	YvAqIYXdPdo3R0xVC55aWwZ2P0H7Kw5kfAIfltJUNAhSQB6cc9lepg0MwBUZqOkoYxtiK5
	x+xSMlNFyaGLQVA1X3NtcLex8ftx7eM3zg8ZcRdRb73+GhXvtSDLgatbDhoMFqls6pC0hz
	oqSkOsaLihvbqxPovXXeOyL4qVoPjaCjP1ANXkeUz1I8eXHOpVONKMfj/LiR6ksUd12zaY
	BdNJa+rekM19iMOgko1SIduwXsnqQkwxxmb57WqjB+j8M3Df3Xm6M1kAVg+YhQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Mar 2026 21:36:18 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260324210342.61b0b5f8@kernel.org>
References: <20260323120539.136029-1-nb@tipi-net.de>
 <20260323120539.136029-5-nb@tipi-net.de>
 <20260324210342.61b0b5f8@kernel.org>
Message-ID: <b6dc5c465a05fcac74b3979327d12daf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 25.3.2026 05:03, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 13:05:33 +0100 Nicolai Buchwitz wrote:
>> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
>> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
>> 
>> Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
>> piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
>> RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
>> completion within the RX poll path.
>> 
>> The GENET MAC has TBUF_64B_EN set globally, requiring every TX buffer
>> to start with a 64-byte struct status_64 (TSB). For local XDP_TX, the
>> TSB is prepended by backing xdp->data into the RSB area (unused after
>> BPF execution) and zeroing it. For foreign frames redirected from 
>> other
>> devices, the TSB is written into the xdp_frame headroom.
>> 
>> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
>> DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.
> 
> drivers/net/ethernet/broadcom/genet/bcmgenet.c:2420:27: warning: 
> variable 'tx_ring' set but not used [-Wunused-but-set-variable]
>  2420 |         struct bcmgenet_tx_ring *tx_ring;
>       |                                  ^

Missed during the refactoring (should be part of patch 5). I will 
address this in the next version of this series.

Thanks
Nicolai
