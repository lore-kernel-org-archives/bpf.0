Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216661;
	b=zbL5uRXeCK945vBeEUTVKiqCEM5NWC2rdaK+F8e6N8y7VzEGdPsT0oLSkebMeNUlEHfN
	 Z356oBcQzH2CRF+7llGf32XGt/v0TllDyDsH+nLi7ejtZvzWhCFtq9ZL1om6wgm7VRzqY
	 qQHOb6R7b+DJqAEuwMENr3Qbn2CBYzLr3U/SLk86ilITx5pxpxutribgi3t7BJNbZ3eYS
	 yw5Pk8PHBETcY7Hl/oDcixZETsmB3fZ73z3bR9I0n4pxu9XLnLON6mVGiUS1RdxG4Y9X7
	 gkOZg9jCa4T7Z2YghU9y29R3VfUWe+Voa8V1Kk3B7hVwCACb0zMxTF9s3wgvPFy5uYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
	b=IqpAaci4pEo0evITkW2iaM/YtZuAxN80o5r2af7WuBROjLSUY2V/C9O/BFwWQrL95jWC
	 QcoTkhZX0q0h21l7qzGcx/32rj7sJgoYNU3o8yCMKkNZ6CBHHMdCFbtl0NLYeTtKgKWf7
	 eq11jGjHUrydreKRk4RXDkAlnDqFBm6t121qXE/zBVny8FgjB6kzbevpDf9HpfJ5SPXYo
	 AfAqv0O7R+5Q5hs1oi9vy/iTBQbydKd9ag2acgkjXu2qgYMdvVtGsyiQayamtupwr/9hl
	 FnEW9WA7c/QcJBslH7mYQfAbqnmtlAQeeEEyBWuJZApRqLjanpt3XGyzn9SsyuVWykw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oD80inq1;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD3606A699
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 23:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CD3606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oD80inq1
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so14161475e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795216660; x=1795821460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
        b=oD80inq1OCi7sES2mZDguKm7iyjfIQpmNo57rsodReJicMZiMJ6FTJg1dEvz8vLIze
         Iy7ugQ9nzgZFaYlcarFHnSoY6M1asQ05+hnWEjOVVAWuLGcA72nzo2Om76rkqGpmFxZ8
         7jU8oVXrWNa9gUvrdtwjG9aDYv7MEv1agucz/fVVZnyDF7DyyZeweEg9XEacOHHch7hu
         NYKudRf1jwDyP8HHjL824XRBWRJXj4iTPzSmVcj5WCQElNJXKXzHOvWhzU4wfIjn8xCi
         XwSu9OhPflwp2fqeB/NNKfXrDUD5VheszfxMeFQQYrBPKaAoV0EnZDIZM0LAGfqSL7Oq
         PxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795216660; x=1795821460;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
        b=ul7R7R5bQH8SgJ3L2aAzqyJAwcbHon73L+b3i96WcsgLuan/0TBk4I+3TUOsix7ViT
         Zlep6q1jiPfEKDUZEERmapZRpjIpDTyvPNCzgU6KRMHj1HOLm7uhK4ElyRAi1360nZat
         reqMpBkO8k1S15uv+ARLBPg0OyW1gRgPzSBOUFZptVZlWALCx1c+BbJ/tm0s9BnsA7ZP
         ogLwti+BdPLJ8mSLl86e8ObJ7nNc02ub5CQwgvL6pZMDgIeMVb/+jBYTdBADTqGB/r42
         meB5fyeKx4xxZg3Ccs+iKqkaCw4YxszNRQoIVxBK090Lrq9sSgeYZZUL0ThIMRpgp/LJ
         UQKA==
X-Forwarded-Encrypted: i=1; AL+hErGeT8qwLwh7c3RdRW5RmkhIaTwN6NiYyQHMDHfg0DO+rDquFtXvA3YFQJRvpW0pYAV4qYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wGozq1yzSyCo6KUDhV13+ywmiIbyexjv/k34pLSW+52c66Uco
	s8wVOHZxXVG+Htp/ajiZC5T3sas2Q9fsqfn3ZtJ2OGXOSPhQycl/wT9k
X-Gm-Gg: AYBFou2NnCv4XsA76Rv15hYBSksF2+0EQjzFkUTCS1tt0Z9TuXVbBPYIcE1cKLBORk8
	wXhN3uZP+bnIw85/3FJNFtxB5XwBLq67iYeWYm8x6NgJjhG+NhSAvN4ZBJPklhaBUOaalI4NLRP
	oNOngjBxCXXep8C2ViJAORaGWlyPUZY7txibxzMOYXmt/CdiAe6c28/FWW8a7WxRKVUWFK6VfVc
	TY2XpAgFISlxJzjfx/2hZqvxXq9jOilp2WPI9VZAW3oKfTkEho1Vk6rN4IlOv4d/OLKZOSAl/BB
	EAWTQKDuydcpYRZfbwfh5Y6idMe+UrD8n8JNPDJj5TgzJxg/xiSI0Y1FbuFbyybs0RrhnzigTir
	MiiqTg7H28rwxpwznyzNqfKX/grG32rvfiKGyLNi4mOMc3whz+M0EfaKSnZkVx+grjJwWOTpM3F
	GlMVeHRtKpIYnn9V9eusZtfghHNdQ54ia/sGHeG6zE3ElILW1WlFBHPrgyFsWxJ5vWhiZfXWVNf
	HEkpWRRVLnMYoWl1n0y6RibbFoui88rPJB4yVYgAJcvSeB/hKzwQ1Qtj3VVMheBbIcUygigqLJm
	2OEvNFOsJzjknlPjDdv0ZKxwT3kMhL1yBrnjMiEmxK1cHl09m4efkZBP0hAYAtbBwRY5mmNvevB
	skWgO1EqhNxDygvLUgwTJovk/ixSmHXkU+X8=
X-Received: by 2002:a05:600c:820c:b0:4bb:6f6a:1976 with SMTP id 5b1f17b1804b1-4bb887c2923mr101689825e9.2.1795216659651;
        Fri, 20 Nov 2026 15:17:39 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm151650265e9.15.2026.11.20.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:17:37 -0800 (PST)
Date: Sat, 21 Nov 2026 01:17:35 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
Message-ID: <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
References: <20261120210134.133238-1-antonio@mandelbit.com>
 <20261120210134.133238-2-antonio@mandelbit.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261120210134.133238-2-antonio@mandelbit.com>

On 20 Nov 22:01, Antonio Quartulli wrote:
>xsk_get_pool_from_qid() checks the queue id against the stack's real
>queue counts, which can be higher than the number of rings the device
>has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>before enabling VFs, then passes a NULL Tx ring to
>igb_txrx_ring_disable().
>
>Only disable and re-enable the rings the device has: skip the queue if
>it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>an Rx ring using the pool still stops using it.
>

What happens if a pool is bound to, say, queue 1 and the socket stays 
open across a runtime resume that falls back from MSI-X to MSI 
(queue 1 becomes invalid)?

If the socket is closed after igb_rtnl_resume_task() has reduced both
real queue counts to one, xsk_get_pool_from_qid() will return NULL for
queue 1. As I read it, igb_xsk_pool_disable() then returns -EINVAL
before doing the cleanup and resources get leaked.

I may be mistaken here, if so, please let me know :)

Best regards,
Janis
