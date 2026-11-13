Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=81.19.149.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603576;
	b=a6FqfZsXSB/SJecTeZsS8xSMvKVtg/RRQDKi6sFCNbyLN+GL8ZzSZQ6D0pa6NxLrvW6m
	 zk0/xROmvoqbIzWfdz7T2BrCSvniLbCOfCAbLaUcKeW0DW3+pjkL9A1W0zaUnoVuqZEDi
	 3M2EDTbn9SKtz3bINxXtORu0FabGj0ghIJmpyKO6f3gYi7n6RycCn6vV6CgrvF6KpsWS4
	 IHXYNj1ge1ClgeRwTcHxsuhq/bEUstXPX7huyxPd3cQS5ttE5oiGuyG81YFNlQ1UUj8fY
	 ZQScPud1KsE87JY653yfald/1cPlG7Ko+WIweVgYb8yrO5Apqe2Ik6d9ASeSFw8XV0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603576;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-AV-Do-Run;
	bh=EJBj5wqDDAB9+pHKPL6VCCp1UXeWowXlq/LPUcUSsu4=;
	b=smLrE9PUrEHD79L9jBsRFTewXHmA8L5A7G6St1wMvAZTCPmVPayW/1POlsuN67Cq7eUe
	 xnjmDvoB0BF7PUc4zUGh0oI+OrLDdaQlpUWylPxRzrTpqheAon8a5s1rI8zZRnp0NCljS
	 HEaMLPSx/aTEy2TxboYlACBmPvbayXDlCuNPY+XRNw4H+P1Ntql5hSlw1ItYOy3oA1Tk6
	 wBK80eiiBeiwOiyLLZT9oyj4CesW6O+zBN5npCoxtEWeXbzWV2WAoQNzYVhTeu8T2KSco
	 Z6B0VKdOdq8j8RIImgSpugfwTtys2DLVMgnNmhbmk/SHhS13jwekSfeRkgiHLHi8sJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=engleder-embedded.com;
	spf=pass smtp.mailfrom=engleder-embedded.com;
	dkim=pass header.d=engleder-embedded.com header.i=@engleder-embedded.com header.a=rsa-sha256 header.s=dkim11 header.b=dHn8cJbq;
	arc=none smtp.remote-ip=81.19.149.119
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1C606A323;
	Fri, 13 Nov 2026 20:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75D1C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.a=rsa-sha256 header.s=dkim11 header.b=dHn8cJbq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EJBj5wqDDAB9+pHKPL6VCCp1UXeWowXlq/LPUcUSsu4=; b=dHn8cJbqKQ+Jj9d6vLb1sY/nWc
	B6e+o0CtxAqo/uiUQxLgcOvzG5rwHmG6mUVvysHwv/8Q4vyIoeHlj6zWXFc8wyQnOiyUlJhJ1aT+r
	GPFq/WKMzMFmbnaScuB7+7mfZJlPcKE59hOuMdOXFHcO2apJFdVvRKSwbj/yAd1dGhWY=;
Received: from [80.121.72.134] (helo=[10.0.0.160])
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1xRyMi-000000004vO-2IYe;
	Fri, 13 Nov 2026 21:59:20 +0100
Message-ID: <1ab53072-b9ee-464b-b5b3-cbb578059b49@engleder-embedded.com>
Date: Fri, 13 Nov 2026 21:59:17 +0100
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
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
To: Paul Moses <p@1g4.org>, Ding Meng <meng.ding@siemens.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
 <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
 <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.11.26 09:29, Paul Moses wrote:
> 
>>
>> Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
>> specify a busy poll dependency if they want to obtain the original net
>> device upon consuming the skb. However, this dependency is far from
>> obvious, and annotating it for future features of this kind will be very
>> hard to discover.
> 
> The "deferred timestamp conversion" was incomplete is what I'm saying.
> 
> This started with 97dc7cd92ac6, 0abb62b68252 and 069b142f5819 were built upon
> it, so maybe Gerhard should decide the path forward?

The deferred timestamp conversion is a niche feature for TSN to solve
the working clock / global time problem in TSN networks. IMO there is
no need to make it working as soon as igc or tsnep drivers are enabled.
It would be ok to fall back to normal vclock behavior like all other
drivers if CONFIG_NET_RX_BUSY_POLL=n. For me it is ok that NETCONSOLE
is not possible for PREEMPT_RT in combination with this feature.

There are already so many things to consider to get TSN working. To
not enable NETCONSOLE on PREEMPT_RT for deferred timestamp conversion
would be just one of many.

@Ding Meng: Do you actually need the NETCONSOLE in this combination?
On productive systems likely not these days due to CRA.

Gerhard
