Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1D38B123
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326774; cv=none; b=sD8M3af20Ssb1mmbKkv1DuhhNzIEdZY6cE2fV2mcdIqYU0f+25TgWeokr8HygucYDu0mT1UariGy7F3BYD0mlR5MyWHW6fgeYaJF+S+YYVVAcFWjdnkskUXanlYRnA+m14TefNyUhRvBmP8rWJWgKynBNFW6QgFB5YWzJHvY0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326774; c=relaxed/simple;
	bh=Ru2dAGDmXt2BWDG4LBRI+9WbLDGbJdMohF9oYmlNENI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn8lEJcE+SPxY3rIZZTdF1a4LKlmWVTbQbWK4hRSd/F4HTtNR0ur9jUqe+2ngc9p645wZ5lRWdO2LPE4U9KuTRfNab0KLvX2u3Fvvg6TMsz+XWjvcU6lDngatAibkgNgxXpTTOMLDWbWwPd0rVMs1Ub1/WTxcD9aUrBFcWG74WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQsbz+Ec; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8B6iMCl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQsbz+Ec";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8B6iMCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776326772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJyyJYZcE0qwxf80pcu1qJxxfSACe3cGGgbV2D39A3A=;
	b=UQsbz+EcEgR2rbPv3GbKf2fbrZOABO8gkBytREmZ/sBoxg/tnnzj1zr3Uql2U3zBjxxdTp
	NQ+5qhDXY3h+lxeegWb9phDW3E6rElr0hbbdeSNzYuNi3SmxrGdCZ1JaDCkHm8LIUQTS3i
	05Y5wNzPEi0uV6f09TJIvfajZPnEjOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-A2YRIfezOJmhG-3IOzd3Ng-1; Thu, 16 Apr 2026 04:06:09 -0400
X-MC-Unique: A2YRIfezOJmhG-3IOzd3Ng-1
X-Mimecast-MFC-AGG-ID: A2YRIfezOJmhG-3IOzd3Ng_1776326768
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d03065782so4658635f8f.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776326768; x=1776931568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJyyJYZcE0qwxf80pcu1qJxxfSACe3cGGgbV2D39A3A=;
        b=G8B6iMCl/xN7TnIVwNj+aX1dyLzNM4Z+/nUVjtBnNBk26k75hjkIinHjPWczobgxIC
         4PWiyZ5l/ojEovkqyXhuH+9TY5WS7iluuPltxj2zEu86JCIigBqxioX7O9wZB5jUSkUr
         w4S0k8ot0Y7fV5LSO0OBKQ+O6jjuNzimjB1cpuAS08tHaCtwzSa6Rq4wI7oqBk+0Bu5g
         obm0vgFhDjg2h7pz8fLs15diEs/L8D1980IPvAsCa4dlKCva4g5y/uASt7twCKP27LyP
         OrJMKVgjLRV1I8bglb6epVkwooJqARY9Y3+GAN/RBs0o3mAlDJrw/DtsWwYWu0xVkAlm
         CP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776326768; x=1776931568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJyyJYZcE0qwxf80pcu1qJxxfSACe3cGGgbV2D39A3A=;
        b=L5ELvcyzKWSpFmltOQn34oRm61BqozYqY9BNx2VTB54fcUtqEj6Vp83h1KCJOo8FTe
         DNhEo0wh1bKhjUeHXTcuHL4hw+4trpQGuy07ZdwkoxIBBiByEph8QqusMlBd+4yKLLEN
         Qu35oNd9S+xGYsKkULZcLEwiiff5qUDf8aLhjrZfaS5mfICQPzp9PcXmNIzVtq5kqkQH
         b878af5avS8CN8rstyYXXqVPSSf3SvTcSIH5cs85IxDGBVo3Uxm2QfoZZhPl8yea7PO5
         BNdLgeKSnd6VINmCD3qtof5+zD9D0Cnyw0y9jeaWzMGyMN6dfCLrXVHRaJUwFKJSrEsL
         JYwA==
X-Forwarded-Encrypted: i=1; AFNElJ+j5KgrivXPn265I9pg1xSdU+8poCpXqaxdPsKlxhB5L/PJ8fXF67i3/J61zXuu9XKLV7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhggibP1lvq25ugAzhBUYDQrUMuZ7iy3MrvVqNpHi4FDh+Ai8
	6KwO+CcodhhsktLlOnpyfYcfjOMUd/CW+dazcUBFvGE50rxmYRsQ4zWnavyyPa3sLrV8sG6khp6
	Wa3BVUMbzECwWLuqfZtgdQAD6TiJKuUkdXTNqNmCKQTgo9r55c0CYlQ==
X-Gm-Gg: AeBDiesKXeo0EmHY1b8/Xu2x7/R4bXVxOYolaCZuNfcQ4fVk+uIhK2R60szvAmMIpTu
	AV1JBkzpCzAoxA43EZpqD1vhv5aSfhEslpK3H9pNAwSh8jzzs9TuI8d/c0+iM/336oXEgXJm96l
	oe5R6G4lyvRi3GqEWUs4rENypsXxAhounNuqFS8ugdS6AZdybP6f40T/YMZezFoOswfOabz+UV4
	pxr7XSu14EaDRms02tSLqKcgc8lFWQJF4g4Iby1UhB+yILks2x9jTgLMCZYl2RtMEY3xEsJGYaD
	a9oCrRZWs9JoGOGZzTy7B+RHOAy4a/xptBstKx1cwFYFWwnsxD6FGKfH6bLbnvzWJYt/3rdP9l4
	/c4QBNU5gxpvPUugYrOupv5wGTa06jJyy4r4Ug3fXA8KH1jPL2BDtECExU2JWXmaAYec=
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr291004235e9.21.1776326767706;
        Thu, 16 Apr 2026 01:06:07 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr291003615e9.21.1776326767184;
        Thu, 16 Apr 2026 01:06:07 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0a6da96sm41903285e9.13.2026.04.16.01.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:06:06 -0700 (PDT)
Message-ID: <2d4193fe-354f-4318-ac65-30c375a90f6b@redhat.com>
Date: Thu, 16 Apr 2026 10:06:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/7] net: bcmgenet: add XDP support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260416054743.1289191-1-nb@tipi-net.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416054743.1289191-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 7:47 AM, Nicolai Buchwitz wrote:
> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
> 
> The first patch converts the RX path from the existing kmalloc-based
> allocation to page_pool, which is a prerequisite for XDP. The remaining
> patches incrementally add XDP functionality and per-action statistics.
> 
> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
> - XDP_PASS latency: 0.164ms avg, 0% packet loss
> - XDP_DROP: all inbound traffic blocked as expected
> - XDP_TX: TX counter increments (packet reflection working)
> - Link flap with XDP attached: no errors
> - Program swap under iperf3 load: no errors
> - Upstream XDP selftests (xdp.py): pass_sb, drop_sb, tx_sb passing
> - XDP-based EtherCAT master (~37 kHz cycle rate, all packet processing
>   in BPF/XDP), stable over multiple days

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for
v7.1, and therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

