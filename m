Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067987;
	b=d3ktnKWRfKKh4dyi/J7NX+fWdwiqtYlcGLjTuQ5toJSpGLmMlts334wwfENG8vq+8d/N
	 UgrtiroK35D7JOuRd/uFv6b+YlToj/ZZlrBE0EV/ZIjop0rac3msrs/+mFifCZzdF7us+
	 /ajAuIBSMXvzeB6he+xqSEqJX43FqnPGEEpQbvQ0C+sKEo5CuuEodMC++Hsohnaw/zYMp
	 dzA+kg74CS9DlJQnx2JaPr52KU3jVQTIHvRQcqgy83fcmzP640mjYD3gCc5KnHBe9ovMf
	 Xm2ZZbkGKKlyMqyxvIfVuQgezQetB7EwOWwXpWV8UVug947v1knAl3JUKFlihTKebmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067987;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zJJW9ImHGeQI9HkBzIrCR9incErrDrQZ8U5oqxXIi8w=;
	b=ovUdw2k5j978FhQSBhniwSue1Y2I4xXyNtw/T+ndpdC9ZuTngjUC2GLWNvgO5wuB2DKj
	 Yi8M+qrddpS8Gdt0/vWHPXEP/LnfBdV0OAfZ1BOQqgEpUyOpAIVeq2WDTDVYOpevvEgJE
	 +dvb3xXcK56cESdf2Sam1h+YJHRBahAdvrfzwHJ4NGxw3hMk40sy3AAzBFat3+eQHlawN
	 fC131FMQe3hyUu0Ot7wf4C+EoM0ZaPeASMzlowlktiSQxTdhpXr7F+9NR3LBaJsWSK82M
	 pkMo4acgPL0sSNgG1JNm3vTPLtMIFh3CvoTJrz+4zERh7IoEs1HP1obTFY0YbVmSfrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tpSCjllo;
	arc=none smtp.remote-ip=91.218.175.36
Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F4606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097F4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tpSCjllo
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zJJW9ImHGeQI9HkBzIrCR9incErrDrQZ8U5oqxXIi8w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795067985; v=1; x=1795672785;
 b=tpSCjlloQ6hcZJFh5lmnsxKaU1HKE9z6Vi8cecHmFQOvJvo5kFhedCRr/9oALIMXLHphJc0b
 hJsdumD9/o4vCZrJ4WUNwmM+iu6+2S3wxzQamVOMaTmnGu+dZ/Nn8myjgKeGqzTnd2WvMIwq0RI
 GxjqTCHgIQFzZMpf1OZvvYL8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a21f34f1ed7e6d6b;
	Thu, 19 Nov 2026 05:59:45 +0000
X-Mizu-Trace-ID: a21f34f1ed7e6d6b
X-Migadu-Flow: FLOW_OUT
Message-ID: <01a31252-3194-4b2e-9327-f4eeb7a251ea@linux.dev>
Date: Thu, 19 Nov 2026 13:59:39 +0800
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
Subject: Re: [BUG] bpf, sockmap: data left in ingress_msg is dropped without
 moving copied_seq, and TLS RX then warns
To: Kyuwon Cho <kyuwoncho18@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179505708397.3511192.17406955708229395086@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <179505708397.3511192.17406955708229395086@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/19/26 11:04 AM, Kyuwon Cho wrote:
> Hi John, Jakub, Jakub, Sabrina,
>
> While testing v7.4-rc3 with an LLM-guided test generator that we are
> developing as a research prototype, we found that setting up TLS RX on
> a TCP socket right after it was removed from a sockmap can find the
> socket's receive queue and copied_seq out of step.
> tls_strp_read_sock() sees tcp_inq() > 0, but tcp_recv_skb() finds no
> skb at copied_seq:

 

Thanks for the report.

We have too many copied_seq bugs in sockmap now, I think we need to rework it.


