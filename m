Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790631;
	b=c6dt6DUmHyPUMHLPuP9bwkqHhWj3OB2NantNI2yBHu4sCRwzHUlMy2uE3/kNlSGDbVAA
	 6UahFCG35rDVZcBDEOqqj7tHpYEAftMJvSyAw8RzyZw59q8+8NT/KvnvWu2VALCmPs7rY
	 Ke0qEJTscUUD51wj4fiuBWPfFZnAbSP5kKvmvw+T9Yb7xaYlrCOvh5B+2t1l1/ttl7AVx
	 +bIxgY8bWnT/6EarY0zegASmflKXDZRxj7uQeM5tUmA+YBl00eT+OxBtIP7Ap6Yuo8FT9
	 T2+BtzpAGdhdRI2TsqGFbEWG9iayXW7RhgcOVuOxKtF6vtMcO09NhSv4n7HRBS1bxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790631;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qDjAiGN9DxClUsHbKhzC+df0z9DdE+tvvWVL7zTbqjQ=;
	b=2o8quQw6J0rwTHq/Cw05bKsjDh8bzAJk2XQkfDhz87MbkbYRYEey8wyGu6hlQFhoWdWA
	 pb9on7PGgcdIEfLHiyO1+SmF6yBead2M/EioDVukXB5D86exr4ZO3ZVysFDQlUhuobTyL
	 yA8L6MeqRinpr7X1dv8OSbgl2KTIGL06YawPfQo5vNNtjz4uQSrw3vt7B5qUnTCNEtRju
	 Y30vpUkXmSowsopDGg81ST7Utk44FlY2Cl/cY71XI0QFVwkk5lZR3A4X70UTdZHpUPcon
	 +Gx4+C2jiPVpdVYQQ1/gh6NkaToURv+m+ri2MLbP9GB50Is4QwrC4aksjxEw0tqavxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ve3qM6cb;
	arc=none smtp.remote-ip=95.215.58.242
Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABC606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EABC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ve3qM6cb
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WWXsi2sKIGoGgyhIoSZ+4BEAUs75uz9JX/TPU+B3b4w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794790628; v=1; x=1795395428;
 b=Ve3qM6cbkvgW8CvXaKOowoLephw1dkp9Kp4IuBmN3ctKxIg+iVnVnjOX/4zSgB0bBFl22FFP
 c0CjHQkGAGqWPQg11JmTOkhAL0GIsC1v7g+VUK1tP2RXBPmcxcwKJghSRSbiFOgQW54CedtIWCl
 1QBsJ/ZE0wQ9qoHVZkmc4p8M=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 77561f772e9bc9b0;
	Mon, 16 Nov 2026 00:57:07 +0000
X-Mizu-Trace-ID: 77561f772e9bc9b0
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 08:56:56 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org
Subject: Re: [PATCH net v2] selftests: net: veth: propagate channel-check
 failures to exit status
Message-ID: <avpU2DbRUp0KaSYD@fedora>
References: <20261115214702.50817-1-emmaonana18@gmail.com>
 <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>

On Mon, Nov 16, 2026 at 12:45:48AM +0000, Tianyi Gao wrote:
> On Sun, 15 Nov 2026 22:47:02 +0100 Omokefe Emmanuel Onanaroghene wrote:
> > chk_channels() reports mismatches with a "fail" line but never sets
> > ret, so the script exits 0 even when channel counts are wrong.
> 
> I found three more checks in the same file with the same problem:
> 
>   bad setting: XDP with RX nr less than TX
>   bad setting: reducing RX nr below peer TX with XDP set
>   bad setting: increasing peer TX nr above RX with XDP set
> 
> Maybe it is worth fixing them all at once?

+1

> 
> Tested-by: Tianyi Gao <tianyi@cloudflare.com>
> 

Hangbin
