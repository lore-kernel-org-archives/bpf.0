Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695226;
	b=UCSfkzEn/y4idUxYsrA+k0bggMTTr2utBC4GAH69x1Vpd1/WIvWqGj5N25Gtzm+jXFe1
	 wOzB/NpqSjCGt2xtj6RBh/3xSXCVmXLgtD8sv0WkmTNdqjMNOwdnkh663WqvH+6sEcMeJ
	 cvXVAJIrUP2LElgTEYv7N2Tq7F0qJe7zcNLrYdh2JycVVCzrSeLA89z/nN0sdTHrpaEL0
	 IsSx8xcG4wtbdlpEH7FXQpnCE5dqJN9DAn7gXRnyu5iwRpoHuF1w2jm2yeG8u7UN4wwFa
	 JrcCx+Q5UTUMtTVOUGzZcJCzcbL6AR9xYs7/4aaVxd1AGMTamTpNbt01FkNJAn3uQ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695226;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
	b=FCic3zYnXuMqtIlzqr6JWC7/rz6m7MEk3lnFuKV5Yb/Hy2a4fllVhwGRSr2x2pTwCZLs
	 riz/SgaAEz5cT6d7MQjHTbIeY1M8+49ekIyd8u3ge0/vsKcwHqWCTSON7THClLM1nm8xi
	 iQ8RRlefAG0mVH4rdzxlZ5cdsqiOXzF01vsV9L9dIauyCcnGTbIR0qk7yBE+7dJrQwaiv
	 gqo1f8yjUw+5AHebqeu7/9xJMr8L4E6yqLTDATai8ViXgOrHgbTzJTzW896FycAyD3h22
	 4U1RNQCtJWhZ0OQJjDfycGNDxf65gJ8dvnJb3GA74vISq3Fd8UMUa3dF+JeB/17lkOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="E54R/Th5";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q4XUYoz4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34146606A949
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34146606A949
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E54R/Th5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q4XUYoz4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793695225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
	b=E54R/Th5vtszQ4Y571VZqohiGIaIYINsXWVSs2KabEIvdvdyiWjx0+GPNgyNZEmclxobzL
	wSkG3ZMKD2drgJH979FOL0EDQiO+l9otoHTcHtFfRcREm/11RFzLRTpwIMjvKWmtOsVp6e
	gMTr/6Gc9a1DC5qgba73tMDCYiQqsz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-8hMy4RHEMj2vnV7hG0d5-w-1; Tue, 03 Nov 2026 03:40:23 -0500
X-MC-Unique: 8hMy4RHEMj2vnV7hG0d5-w-1
X-Mimecast-MFC-AGG-ID: 8hMy4RHEMj2vnV7hG0d5-w_1793695222
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48afcecb035so104610f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 00:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793695222; x=1794300022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
        b=q4XUYoz4QZ5U/UeO9wjqdjmr7wdclbxnCN3r9/e9izS2cUZIzrHYMEjNGDsRN+JSh7
         S/dhhbIcHUhjVSWCmqD/7bkf3RN3eF1s+4DVBmZjBGqj4usNfcmUUdyePVNKrHfpqQTI
         63p6DVl1BYL1RC5kOThSjFca4xKjP+JMAdI/8ehXEl0a5iJYkrwdfPR7IpK2StVjcsci
         REh9+gRECqGHDM9Wncy0nLmdL4GnHHcKAdnF9StjWzI1B5f6LMP7jzAYyb14YCYWR9xt
         wNCwMAJwxh2mJ/bPa7IgAvwK6GgWyxZ5+4oS1Y17RkLLv51r+I3Ao/6nqtOiImsukkNG
         gh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695222; x=1794300022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
        b=1zCROafJ/A6mUW8hoRUma0hggkr9Gm1qFivKFGl1k8raeqDD7iPxmSMMXgdZfyDT+F
         Pb4LLmad7zyv/dvZ0Rp8yI7amE2GgQODIDfTjkp3g/ih8b6gWQLeoRQ3Vl+ijUB4Mnqb
         4jZjr6fFs4uHiQRcBlmrq2Ic0zqJ3jPkVjPgUuUuyiW4uOQTD3BDSoac0+h3MYOga/Pg
         Gzao6N21qt34ph9rEx2VK3tl/tM4F6ZFQOTrOCiqoztq7NkeTU5Zr/h/RzvRGCB4jI2H
         lBhgcyDKQXiqu+3NZJNLjUtFFEwRv5JfUPaWC1oUUN7rOhxmXlBXO+KEZ81Fio0j4r3z
         4xGw==
X-Forwarded-Encrypted: i=1; AKwUvBxJrT4bEj3Z9w3bm6mvXPKzJU04xgiNPQOZ3qa4gbFS1F24rO/E+C6cG+IHJLrxvAErSrc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2tD0rDJ+JczgXEu4znAQPtxOOwbmmluirMmkhKgIDb0mJQnOc
	v9Bpb1uTrV9xt07A0azkMKpfW+Z0J9wJjG3SNG5q/Qh4QOBpyd8JSQXbNh/O42H7NJtawGAJhAh
	L9pDfGSBTnw9cY4m15pJZ6AnggaeZuw3LBMX+WsGSer32Bsl3DRuxQA==
X-Gm-Gg: AYBFou1dgIKu2bmDf32BbYWiMqTK8dqetGRG7qzpGr+HB0ZYsEWKxx4bFBDxFomDUgK
	1HI6jIsLjWQ6ZppK5s7gofN/cpyBIlEH89OMZHEBET30CyotE8r+kR5jf+vnJ4uT9aGjZ7Hx7Hz
	WZkKTYHxb2i7rdfPh9zdVvGzp/VR2fnEFQLrCtjz/xz3lFljgI9HWFe0kWUVdsdTmXmsW3lOR+0
	V6Ka3w0S76Ac2q0f1tpvDQmOK7BxRmT/3gqypv64E0mFAzp5loSm7y6DxwJXRgG61bU1OGbVCCo
	ZhcxAWdZuJQ8kOKkqVeyh2/N2oIkb4+HMPM5ImLkYRkWX8oUjKP1cWRghLNZOV/OAH5W3Mzqs7Y
	QI0JFmEoEh+vQ1+EUVzRwu9omb4Xlz4PiW7I+8FFUsfUqW7IUL63Prx4i85sOH+jPQTlrQ/tVmH
	dETwGB0Cddjee1ylz8ht7UOwDK3J1gjAasFD758nDEcGI=
X-Received: by 2002:a05:6000:2007:b0:48e:5e63:27fb with SMTP id ffacd0b85a97d-48e6e2dd32fmr30251218f8f.20.1793695222532;
        Tue, 03 Nov 2026 00:40:22 -0800 (PST)
X-Received: by 2002:a05:6000:2007:b0:48e:5e63:27fb with SMTP id ffacd0b85a97d-48e6e2dd32fmr30251181f8f.20.1793695222153;
        Tue, 03 Nov 2026 00:40:22 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm26624201f8f.6.2026.11.03.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:40:21 -0800 (PST)
Message-ID: <c573bbcc-e0d8-4f43-b14b-09c676a6fe38@redhat.com>
Date: Tue, 3 Nov 2026 09:40:20 +0100
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
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and secondary
 hash tables
To: netdev-bot+sashiko@kernel.org, edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, willemb@google.com,
 horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 david.laight.linux@gmail.com, willemdebruijn.kernel@gmail.com
References: <20261030122045.3035709-1-edumazet@kernel.org>
 <179362213820.3131.12108035098960840444@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179362213820.3131.12108035098960840444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 13:22, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The hlist_nulls restart does not work when an IPv6 SO_REUSEPORT
>    socket is tail-inserted back into the bucket it was just removed from.

This look real to me. On the flip side the most straight forward fix - avoid
tail insertion in udp_lib_get_port() would re-introduce the issue addressed
by commit d894ba18d4e449b3a7f6eb491f16c9e02933736e. But rehash already avoids
tail insertion...

/P

