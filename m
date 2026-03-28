Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA9361DA5
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680662; cv=none; b=ewFGoNENTsmD0XCnXjOpEHWJ4Iq/IzvltggjHkcvoxTCyy/3uvaZE7ezAog+FoUrOGmurBh6ZqVanSLz+HGOEFeXNjkYBUEJWCihSvLaDvNoW0i+b5yzaEwiYnibxKosWjzEwxahT2h6jU+HRiQMhKW75jmSpviO7A5/hrjL+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680662; c=relaxed/simple;
	bh=5nUtOQF5bU3GOvnc3XVqEe5GlPyNotb9va2tBz32Fxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSjRI2viImAr0+F4kjoFdXQdDOi27kqUCrO2dNq93RVDirbT3orXtTY/UhRF/jIlLrIkOvPs3MgXTd/GtGFtnVD7v3QyFXTfseCBRej/qBD5sh9ZpOnhZom0bERANdw8/2eg84cRPxmlOGHXdqHxfROTJVsf1KFd5/K+FqEDRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iwAezTs+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iwAezTs+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1848945f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680659; x=1775285459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsZAatCd9ykKoBaN7oQj9bzWiijKhSau8vkhJp8rYUQ=;
        b=iwAezTs+XzKIMDnQWWUYp3rPH5wQmC1aq7eeu8M3IPRX3RUosSbsBKJpJA40wYQp/8
         /YYTZlRBsgruPE/TG1vnzXXLN5x2X3GQTBY5HjMxJ+LSfqD04pkIIJmtExaqeE4MY1LZ
         IcmFRROGFh7mFDuioSqybYxX6axwJiatZnWonD7zFUJMuOTj/VjAucODwq5v9QIC+AxT
         hRV9gXFmFjcdDcTyoB3KMRNk3fSB8HJbmSYsSr9XunHPBnlR8hq8HmEqWsqiAUnxE8hp
         yRfqn/5rBY7sFbvTaijEnB08QXRMuwqp/Oi9zUIiLTR8AJUvByzuO3PYXaGe8FiKjMLd
         X4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680659; x=1775285459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsZAatCd9ykKoBaN7oQj9bzWiijKhSau8vkhJp8rYUQ=;
        b=PiZ4Z6jhQXsAADSxmFentjjDgRHzEMn7hzAiXiuDMZepr2+ege9SqGpr28jgTxw2n/
         dysbCWn9TSrg45W1bS+MqXZV9uowp3V/NNkiHakOSKrrMR4In0XQiMLd2Y5ONHI66Ofm
         pOGfFSkhHLzKQL/4db48ELpIonmCz5TAvcBVE3hoFj4RaU8SlYroodL0H1FEC4y1jHt+
         bdpsufy7vr5GNDl2rOyTx0lxk6UEgj4qO3yJh4HN5xrsYyC9enPPLAWjg1vCypcpSicg
         iOcecQE03UagS7BasUx1SiXRBrIg/HFhVvZmV3oeOghek5YtzZjYnqvdpQIQORE18f2k
         hWpA==
X-Gm-Message-State: AOJu0YxV7/qRVOIxeK3CZLVI/SZOFKhRFN+G2uWqm1zc1tExY8TTkl/l
	X/06O9bik7LOAEroQ0DFxFW9YO5LT5EdstJqMggpVcecledSV42LTpW4xQj6TzZL6rI=
X-Gm-Gg: ATEYQzxAfhCk0PEMuNjV4Gq/mLfY8wWjSUiEHhLQUvMu+uH7MxhXsBJt5Q7aAPV+hpU
	R79GikrlKiovvd2iJ+lPP5TUlXMIAWiTPnNXcSxZKv+8LGS6ImLMy8TJ2fOJgCS7xhlLOYyCKgY
	Fggd3uS46afBgMLKhut+NU4mCRCoykM7XaJBcTMiseQgwkuvPeTqt3Jt258AB0lWFxUF5mmCHkr
	4Prxr8qxNSGIpijcQyLQE+R/HbXUmDdauKXcT3XG7ddsDqoJDp2t7hbIvlKs1oV0OMtCMVHolkX
	5Am7evLN8w6DVW2290vzJu/mfd17fwVccePQoyVFHXCNmQPZqKm9UmHuMAXhtd0zxKIuWs4wcd3
	VC/f7MZAZBafJIDoVi+gPBiOSqzFc3ETPGqFKN/xbXiJ4/HP5YxOmdK16hwKGMjsvmbB8g3ZJ1w
	9eKdtdiStG7J84gScgGWNpm/lfh5hkCs/d41vmMljZRVPRWHp+5HaYpg==
X-Received: by 2002:a05:6000:4023:b0:43b:5765:96a9 with SMTP id ffacd0b85a97d-43b9e9fadecmr8160332f8f.24.1774680659550;
        Fri, 27 Mar 2026 23:50:59 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm2632392f8f.37.2026.03.27.23.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:50:59 -0700 (PDT)
Message-ID: <9e78ceca-78b8-4d54-93d7-2d6658d44290@blackwall.org>
Date: Sat, 28 Mar 2026 08:50:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/14] net: Proxy netif_mp_{open,close}_rxq
 for leased queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-7-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 14:10, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a leased rxq, and call netif_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   net/core/dev.h             |  2 +
>   net/core/netdev_rx_queue.c | 93 +++++++++++++++++++++++++++++++-------
>   2 files changed, 78 insertions(+), 17 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

