Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219761;
	b=zj+LiqL6dbQyFYUZJIXU/Em7riGkXjWE/Rt0u25/+uHb+8XEtV+GYhG6X9bJ5g6jgWvA
	 L4GojnHa8FSGqq5e73Xhl9YJsUSJ35Hpzj/mTjrjjeVZTi8r8E7jTjLOD+QBYpqmAp9mZ
	 wwpAZyWKJsYr93zJnssMwYMpmYRkBRuDufHyAfyGPWwgmgM0bDD5iUxGwItGTtm8/E6UO
	 CJw4O8r7wbMnWU6c7bkmjAjHEexWg7339ISVN1UvVb+IL2YGMlQ3NgKnbHQiblLrLSdP+
	 sRsOSl/JZgfBEGiWjAYrDsnm47lFR7fCA8mhy4pWXuj4YSdg83BH9CZRLALI/8AWQTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219761;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=T7TAPE/7YhD5ngclGTREyMx61AzehRbnlDAFX5Ebjf4=;
	b=iUDpQ1R1D3f4iau/jqPb405RhYY/vk3T0Dpsemb8pU5YcA46D4beF1MpGdWrgHlHg2ET
	 4FEpVjpkrJo2bvASkeCxb3rUx7MHmzJxr2MWyIl313QTdvl6Hla/OLVpJJXWS7P+zWEwe
	 ImI53GKUM0NyGH6UANDC+/RxvbuECaBn0bbXYJiIIcUieUDH3GTO1nboQHhACbkhhRfRW
	 wZJ19jzZTCpYVJkTWIknQ5NRVkVt/kqEEVAl012Lkje4B7hOToZMj4TAZsj4TACGkbXZz
	 aV5cwydQxTI+SNNWZIbMNChzVoIb9oS11XYiybPSikktrYb4B8ORuCfD3WWfnccwnxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Rnq7w67q;
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AC606A325;
	Mon,  9 Nov 2026 10:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D0AC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Rnq7w67q
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jNQnw5dx8zNlct;
	Mon, 09 Nov 2026 11:22:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794219748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7TAPE/7YhD5ngclGTREyMx61AzehRbnlDAFX5Ebjf4=;
	b=Rnq7w67qr3fdW8K0dRjJ2X5SQEXHYt+9dK6WfcRgEEH9wqqXahCq4z5TfX6F9sw3GOaGwy
	SEJbn0MEekLBrYoRMtUPQHCOPd5TWRksWGbTtJ0+WN9kfo2Fy1VaVBWjUTS4/76B9TzWtb
	bQfnhf2mgTI4r1DRQjews0iTccI7u0vht8j17p52PfqfY4A/O8/QB+wNIQN4bWBsmtLyt3
	SXT1TJNvmxVHpds8f6IPmWWhCoHU/sxlGmNsKbYBQn+W9/INgwj8WXYqU7EZ0RJ1zP91Jb
	XghtWp+xinEG90AxN+ScwFyZSmiwq3x9CjEl2gtRkLXy8mfNI6hrMxyOx4p+LQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <b1d44592-ddf8-4103-ae3c-dd1c67641f01@mandelbit.com>
Date: Mon, 9 Nov 2026 11:22:24 +0100
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
Subject: Re: [PATCH net v4 1/2] tun: bound the NAPI receive queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, jasowangio@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maheshb@google.com, peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261103142232.1869185-1-antonio@mandelbit.com>
 <20261103142232.1869185-2-antonio@mandelbit.com>
 <willemdebruijn.kernel.20268598d87e6@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <willemdebruijn.kernel.20268598d87e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jNQnw5dx8zNlct

Hi,

On 06/11/2026 22:04, Willem de Bruijn wrote:
> This is quite a complex solution.

Yeah, I agree. Trying to address all concerns (including Sashiko's) got 
me a bit out of track.

> 
> Can we perhaps simplify it a bit? For instance:
> 
> On tx only keep the lockless check. Number of packets that can bypass
> that is bounded, by the number of competing threads.
> 
> On rx avoid the new queue, by not temporary presenting an empty queue:
> 
>          spin_lock(&queue->lock);
>          if (skb_queue_len(queue) <= budget) {
>              skb_queue_splice_tail_init(queue, &process_queue);
>          } else {
>              while (skb_queue_len(&process_queue) < budget &&
>                     (skb = __skb_dequeue(queue)))
>                  __skb_queue_tail(&process_queue, skb);
>          }
>          spin_unlock(&queue->lock);
> 

Ok, I get your point.
Let me spin another simplified version.

Cheers,

pw-bot: cr


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

