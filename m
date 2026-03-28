Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7892882CD
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680135; cv=none; b=V9p2v2Ju0/K1qXLKBmLlJrkN0otQFi/RaBYrPX1pyp2zuKXiYwC9NJ5ndRYDXIBF5lckNoQ4VJuNwI+OpZg5ghjUk7naBM5LsuYTCSib4mjbOmPoKPC7sOk2+fNdIA3k8FhzY/p2VMqlVvY/uBWSFplhQ6t1PY+UGZ/0y/7NJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680135; c=relaxed/simple;
	bh=izjvOThxFBEttXfkR3OTXp8Qh8HrtNzcIZFDoILbPwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+S6ynHnQPhxh/NlHRU/AEv5vI385x/nG4HS8CMm6sYc/k/LGoyrNeJW6Myub1Cmca/DG5fSxnV/O8VRJJF6B4kmXzNVkOFO8UVViyajVzaEktmQY6LpeYRrwv7KoH4N6Cgq195XJjUon0/AMNDLwpaH1V1xht7w2FejONcPHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OoEJ8pZ5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OoEJ8pZ5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso26319435e9.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680132; x=1775284932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZMboRssjkv4HFLquIG1BzMqG8ARhYN9v0cHdpQlAPA=;
        b=OoEJ8pZ5aOMtZD/ZG2IlV4fTaUf57TpexwOGW5MYvPiIek/RSwcQouWgSunUx4uRfN
         rYF+mEPcskIvTddPXyg3HZjdepIYquHgyCwKPIInpmCMa4exn5EUyJ8vEr45ZwpSteGU
         D7FFqVcyn8XLQtXsYLFI9mR39wByifna6W2H2BVCo4pm7HjdLInyIzBhx5TJoZVfk15m
         AyQJs5WeUMFi48aHmo8mrdgJAU3kzN9rupxpLJA3T193Niu8Lz4ZH9vx4AWH4Tjbsy9p
         /XdJYBEnB/OmVgkPDiO2iE86UbkaIYDkBuul2McunX6BTDL899sgoqL/lWArzdgNZRvb
         y4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680132; x=1775284932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZMboRssjkv4HFLquIG1BzMqG8ARhYN9v0cHdpQlAPA=;
        b=NSjTSPZQqT2IW5DEgTLxoymOzKU1K47DQnvwR/a2Y1ttm6AnFDuim9jV8/auEJcj7r
         lDgHdiYNRlzTNvf/8B6waDMaiX8/psGGCO2rUxIoAR39DVYv9izOqdUPKTv89x2j2cYe
         TcEoPxaA9j+mnTVKU7UbYbJhnHLSxQq1Is0+6mskcSjlqkHEK1qvmJ+OetCLe8AdXgG5
         j0VxQRxXmGWao3eT9uUi7hX8Ss0MsFtuXnkZqMs6QMC31S1XKGx36dZkKSzKhS3D2te6
         3hYytkSOrMqW2pa7WfpM0weMGG70rHXx9NnPiwEf2hnrb/c7uPaR8wPiAZaVTaaGdpLb
         JjgA==
X-Gm-Message-State: AOJu0YzvkzkYmehP6D1zBznSSVdjAR7uHqJFrlIHk3VdRgNYKSLieJ9a
	gID0zAVEh/WpD+7wgXpgiunoDsCXPTDy6LmoR98CvW4VJxfDRWCPia5cWzZcRV5y/Ck=
X-Gm-Gg: ATEYQzzEiMDJ0XOCTPaxDy67dnquSF/7stxfsg6j0GPY9fgWBaM9qngHN9xA2lC7SFt
	kacLP6A4txmqWb+fMbAcIrODBwlVoTfBFwzDe1z+P3zTqIkFUMApbzOca+zzZzrHkAVW0ejFwF+
	1egx8HoG4n2lsgA7KERo/TKRIsnhb/nzM6jl4+Sm+9AbK0Z8bvX2fZ+TePJoUkc2jU5CaWqdLmY
	YG0Y5HSq2NvIvnGOh01q9iflohPIkF2rkbdApe08uIMbOmBF15fSlwd2D/KyRE2f0HHjZ7kba7b
	EsR/1FNTjS6L06bZW4KBv/yjWX7ucuHH9DvJwtjdOWDOxN1WG+dOqTCw8V64vDWiCUPD+DnzruU
	MtCc3zzWGiJjhp0ZTSOal3q2oMm48nyKIvK/ACTCf8MEv/zKcxQYq3f729TsVvBB+sTN2OVyvun
	2cYD/GKQNcurcibHhLISWyLrSEpXFaNwTDpOvY+zJwH5raIw8FAPSLK84jDIEVgAV+
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48727eda549mr85154515e9.17.1774680131791;
        Fri, 27 Mar 2026 23:42:11 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270f1943sm38204245e9.7.2026.03.27.23.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:42:11 -0700 (PDT)
Message-ID: <7ace5b20-6982-45ea-a137-c0dee5d47c8b@blackwall.org>
Date: Sat, 28 Mar 2026 08:42:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: Implement
 netdev_nl_queue_create_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 14:10, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>    # ynl --family netdev --output-json --do queue-create \
>          --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>    {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   Documentation/networking/netdevices.rst |   6 +
>   include/linux/netdevice.h               |   9 +-
>   include/net/netdev_queues.h             |  19 ++-
>   include/net/netdev_rx_queue.h           |  15 ++-
>   include/net/xdp_sock_drv.h              |   2 +-
>   net/core/dev.c                          |   8 ++
>   net/core/dev.h                          |   5 +
>   net/core/netdev-genl.c                  | 164 +++++++++++++++++++++++-
>   net/core/netdev_queues.c                |  62 +++++++++
>   net/core/netdev_rx_queue.c              |  46 ++++++-
>   net/xdp/xsk.c                           |   2 +-
>   11 files changed, 325 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

