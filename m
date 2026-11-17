Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941668;
	b=sAI5+IvlTIvgDXS8tLRYxuXa5Hljh6JKZ/ubShhllHoJjAZbNs9Lt+s5UiQHopTsewB8
	 s9vSAqFzxmwk0NNHKB545Wea9tybHWgWew9TKeri9ZRueLl613NwybdtgfwDWHaACAQr/
	 +gA/u1TjDvq2Kk6Kc0S3N2y2sFFfhauxlF0OeMv4BTV3YnrnTd1D6VGWbsIbDEws6TU89
	 NhkStdKf766WMa2waNp3BNZFRqNunkiEognCsS3dStoNnQzEviU9plo8N6K9QcLeKcyN1
	 ds8v4jjwiH4F4m7AKWkKRRDPSGrdaNGvA8j4X29Ki5SX6467NdjidmYcWKqBGt5dXmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941668;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=oyXfSxY1SC5sSASaK9sor3nEs3De0DC+JXPLMJXd4kw=;
	b=jaalEh77NKg671alAxoJsGwQNQZ+tVni+52+sahwBejBNVjPo2qsvqwkgFd0ciCZSBIW
	 YGW6eplZfkkbKfv/RZRFRNyXDIpttBuJxX3gyqeH6fSUF33M3FCyU+TDtFV5IXZaLWHkv
	 vJCjmG7fQWguijvjck8cGwAb8XKnc57G/4QazK0gLWnvdPFIKZqHUPh1+i7+v2rjOa5JN
	 IftD4UGJfz50oV7Ngdis0JORp8gwkLrCgYoctwn3FGj0oaSlGRsvwqaGUyL5ve+RmLqhD
	 +WVFprF2DKc9hsug7yaEhG9ibvcX0/GQk3AsJb3MxoFz82xxwaXHfmmBk5nrtdZOGHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=pWRCdIsA;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CD606A32A;
	Tue, 17 Nov 2026 18:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA0CD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=pWRCdIsA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1794941635;
	bh=oyXfSxY1SC5sSASaK9sor3nEs3De0DC+JXPLMJXd4kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pWRCdIsA1hx7NU9gQn6CuN4ZRk8OSoF+AMDAtuTp/Oa/E0Pw9cUEbL03OaEDKH0Yn
	 F92g5I4l3UjO+kpOh/GaR5rUN4vt+hyNse4azoY2L1G/sbwAt0KocTlrQeA0q6Tym7
	 H7nGhDzGakSkptxhC1wBCK+Bbs037Gr7y5PHP0qg=
Received: from [192.168.0.202] (ipservice-092-208-185-164.092.208.pools.vodafone-ip.de [92.208.185.164])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6AHIrrEg001015
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 19:53:53 +0100 (CET)
Message-ID: <ab31c0a9-8e3a-4c24-9570-7baf91c22288@tu-dortmund.de>
Date: Tue, 17 Nov 2026 19:53:53 +0100
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
Subject: [PATCH net 1/2] veth: wake a stopped peer txq beyond
 real_num_tx_queues
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, tianyi.gao@linux.dev
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
 <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
 <20261117181607.30219-1-tianyi@cloudflare.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20261117181607.30219-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 19:16, Tianyi Gao wrote:
> Hi Simon,
> 
> On Fri, Nov 13, 2026 at 11:46:47AM +0100, Simon Schippers wrote:
>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> 
> I agree with Sashiko on the Fixes tag.
> 
> I have reproduced the stall with your script (stuck after 2 cycles) and
> confirmed this patch fixes it (all 30 cycles pass).
> It is tested with veth from net at 5e9b2ad9b838, as a module on an arm64
> VM with 8 vCPUs.
> 
> Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
> Tested-by: Tianyi Gao <tianyi@cloudflare.com>
> 
> Cheers,
> Tianyi

Hi, thanks for your testing!

Yes, I should have referenced the other commit, will post a v2
if requested :)

Cheers!
