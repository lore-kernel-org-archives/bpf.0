Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861626;
	b=EbVBx2BgWbzwe5RkO0UPJcEE7jJhV1ee+AlsaValMaxTYM01XNaS7aO+6Bcfaoq7wf3N
	 tmluzjOLzHTlteTv+geQ5tD0rO3Gcwz17+D0RNc3G70nyXFOGiA5Wvqiy1juKRPtsX8km
	 k2Xi8j0Pq2UdbQBzb/WbnKuI31Sc4rpfJc/U4EnSa3RJhZ8L0L0cj+g0pJenMScRwlGU3
	 9L+azJPNlrST8VEF6NA/xshjY7kG5sQj2m0+6pElcMOUwVLE+LFNNrhtQnzbgcNaK8cHo
	 TkOGs/+lV0b0z57Ycrues1I+irFf2QLxULmL4uX2VNXnEq8cEdqoa2sZlcvb2yvPTeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861626;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=ksCPXSLdhTTneD4W2NgdphG6m6xwf/GqUZXi4NHFihM=;
	b=wpD3CIeyGhqiHZ3I9BtKfH7D0HXReViwhDha4dNxL1AmLBAwndjYZixXHiBNeDeSlef3
	 1ul4MIuFIjzWX7OBPoSaa9qpguPUH2+vJor7ZcWHxk+WXqtTSu+pxKBo7qun7HVtMwpvw
	 L9aB6hjQssTFJOkwRWpkX1nhvO5MFGrYA+1BOzEijg+UA5KwOiju1joiOJQ08ot96mV4+
	 eon/Amir2X+Fe8H8aojxc2RTN4RD9lzn0GbmfVM7LYYTgC1vKga0mV+jAGz8obBpRZwPw
	 7HguLmHh6LhefX6Uu56ifkG4bNAHlrOF5ZClL9Ufalzlr0ffOqfjsUiERQoVZDeRCTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=HcOWLbsR;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD0606A31C;
	Mon, 16 Nov 2026 20:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCD0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=HcOWLbsR
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jT09W18PJz3y1m;
	Mon, 16 Nov 2026 21:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794861615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksCPXSLdhTTneD4W2NgdphG6m6xwf/GqUZXi4NHFihM=;
	b=HcOWLbsRC4wdULsQRDXnioLbhKniRsXzYUB6ztgT8lcKOKeBTyPE5eriNnBuMspXKXhktk
	s08oPImuCqeRqR4uvmIY1inshCWX+F5gbdPKaQ+DSHQE+mA00g8dTSKJ/iRv4T0a5nk5PI
	L3SvKOTG0w/0n3PcyMdmdfoEu3efgS4PpI3KcW3PbB9lIvO+hEIO5/Uz8raJz45CNT2ZmQ
	dRBurb3fAQUkdIMkXFURABqRGWoZD23Tyo/3ORwogCZ6RdsUP1JDiveT3EogjoE3qY4lhe
	a9ZYhPx7bNsspG6x5QioPX/NVogh/d7q61hmsJ28583qJiTFBgjVyh9ICABhFA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <8205fa5f-a568-4b86-9276-ccd3ac78c4ad@mandelbit.com>
Date: Mon, 16 Nov 2026 21:40:12 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] tun: don't probe the transport header of
 packets written by userspace
To: netdev-bot+sashiko@kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20261112150612.3866546-2-antonio@mandelbit.com>
 <179484274982.3136.10527408814471189308@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179484274982.3136.10527408814471189308@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jT09W18PJz3y1m

Hi,

On 16/11/2026 16:25, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] After the patch, a TAP packet that is neither GSO nor
>    VIRTIO_NET_HDR_F_NEEDS_CSUM leaves tun_get_user() with…
> - [Medium] On the default tun/tap receive path (no IFF_NAPI, so no GRO;
>    delivery through tun_rx_batched()/netif_rx()), skb->transport_header…

Both medium findings are valid.
I'll respin.

pw-bot: cr



-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

