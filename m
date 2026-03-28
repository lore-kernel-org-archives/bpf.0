Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5933A9F3
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680268; cv=none; b=gYJck6Nc78P0vpqr0JBHIJQsIGxcBxiio4dPr6WF2kIpjI1Q20oCRMj83NIHvOt1lo52nkOXd2Tq7Ehe1ztFSwcT7X3rFv0fDbVS1ZD3+w3H0oxjHaI4q7cZetNyjMFKNJW7s01cakaXrYe8DYERasmmvItn2TR6ROielyRSq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680268; c=relaxed/simple;
	bh=xU8llrJ8E/MPvLKzAix5sB2ylAwFcQsWJxamnGRvgmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaKttpWAQXo5DkA5e/U45iL7MyDVrrryAnA2vFm4SL8iBHHvaTJas+AnA0XJPSkq13zY1YiTuU/EY38bBi9+hC8SZsZurTI2FArPw+4Iy7pWIJrTGrwW9KtvK5C8zE6HL90y9ZjgVZmCk/ek6+VCAIvnKX+6yr9P2CZshLrjlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Ye+aru+9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Ye+aru+9"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so26016665e9.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680262; x=1775285062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zb9btrbms911nU8pycyHqMf15VHIDrQVqlKU3C8/x1c=;
        b=Ye+aru+9ztHiPJpVvbgdvNeBr42ckGjT6nQh6HYmXuigJ8Rsb7uqyRg/Avm+wnKnI2
         9yACR8iZWh7slpLjp/nYq4XueX1RlksiyWuIpwJF2tWPq95YVPWgjvT8QiYqSgEikGU3
         fYUfGJtLTzCgTR4XNRkrxJV6snPjE1oQ+F9m/Ly/6+Wy4eo4kn2ULXbMgXScd0ZyucSe
         fHrOksMI4XnBmlMR4YEvRDdtO722VS0op3xX5/stx0AiE3LT3C1dEN7ul08OX43+4i98
         XFlSFrA08xvhuTucfp8+FKHzZKzuw20Dn0TM5+qF7tRKPmXcBSHwjK8tEmz9/sX/g1DM
         moqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680262; x=1775285062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb9btrbms911nU8pycyHqMf15VHIDrQVqlKU3C8/x1c=;
        b=rnqhZsLDJc78y3OsAb6gaDcgtnfNLdUIa9uhphAM6rUnYtDi8zI9RCXtHBMpHKNfSy
         B9KieKPSq45ke47iIXLWAg/SrYLCseRmw6tr06dL7A5tGJvXHskEw1xuEtGjFaeF9FsH
         wYrgwGgMVq8tM22CApJYFShOs2RSpGGRcbEmfMo25tLyyqa3DEV9iNI7MNh9mxOQFy5j
         akbX90YmS3ekbesQKWzn7Rk69c1d4bw2LUilK+IbefV+6cfnVBWh0AnGX3YAncrK9c2y
         j863y/FIhOmO7rAW98QZrbQVprA11qbwKy+mG/RjLKlPpVeO3sdUF29myipy1X1YNGoH
         CSdg==
X-Gm-Message-State: AOJu0YySm8gwfreizHIop16edN5uhDBtrsTp84+ySaW6pv24vhWv7AN1
	q3HxKFUySmYUNEmoL5le+JRSYRLegqiEN72pHjQpHu8PI7X1viniQKSy+Q4TzTLKvtg=
X-Gm-Gg: ATEYQzywbRWWd7U0vKrRJ+5ZGazzdso+S12o9wdKPX5sVrl4VKEbywtvxezg7KsKklN
	G1PhaCArKPMJ+2JfHPV8wWbg0S47uCXFy5nB5yoS34XQ0Tu0TO+P3iM+sENk/wgs9d86fgkRHEe
	8aYzcPP3qb26bKpZSg5yi9uLaic0bIfuMP5Z4iRUXlbcpY/8zM3G7EJAvqoBydLY2LU7yBhyLDM
	vu2YPRmY2uUlUe8ZbSN9F98fpFLTELUgSbVYGm4e0tY5RGokVkbVTHe2CkIIcnq6t2+BPzKCpSt
	klFZVh/n64dzY+9aruOuEnBZ1inskdIzop6Sk3ZIjBJkNGvE0Zjl0o66YFFtT1jJv2/FxOXHUVI
	lc0YXJd+DFcl2kjWjVyEhWZtgHLuT0kswxJiYJQbvMTL06Gt3XBTwLc8qWjpBn40y7ey4Z0uv5G
	V90GSDP/wEwiIzgarCyUAdT/dyFn7R4wVL8mOWhKppOcTzWpyQ9ivHCA==
X-Received: by 2002:a05:600c:19d2:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-48727d594bemr85729705e9.5.1774680261792;
        Fri, 27 Mar 2026 23:44:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270af027sm48648925e9.3.2026.03.27.23.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:44:21 -0700 (PDT)
Message-ID: <388be65e-4f80-45c7-b1c2-d3684cd1c256@blackwall.org>
Date: Sat, 28 Mar 2026 08:44:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 03/14] net: Add lease info to queue-get
 response
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 14:10, Daniel Borkmann wrote:
> Populate nested lease info to the queue-get response that returns the
> ifindex, queue id with type and optionally netns id if the device
> resides in a different netns.
> 
> Example with ynl client when using AF_XDP via queue leasing:
> 
>    # ip a
>    [...]
>    4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
>      link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
>      inet 10.0.0.2/24 scope global enp10s0f0np0
>         valid_lft forever preferred_lft forever
>      inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>    [...]
> 
>    # ethtool -i enp10s0f0np0
>    driver: mlx5_core
>    [...]
> 
>    # ynl --family netdev --output-json --do queue-get \
>          --json '{"ifindex": 4, "id": 15, "type": "rx"}'
>    {'id': 15,
>     'ifindex': 4,
>     'lease': {'ifindex': 8, 'netns-id': 0, 'queue': {'id': 1, 'type': 'rx'}},
>     'napi-id': 8227,
>     'type': 'rx',
>     'xsk': {}}
> 
>    # ip netns list
>    foo (id: 0)
> 
>    # ip netns exec foo ip a
>    [...]
>    8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>        link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>        inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
>           valid_lft forever preferred_lft forever
>    [...]
> 
>    # ip netns exec foo ethtool -i nk
>    driver: netkit
>    [...]
> 
>    # ip netns exec foo ls /sys/class/net/nk/queues/
>    rx-0  rx-1  tx-0
> 
>    # ip netns exec foo ynl --family netdev --output-json --do queue-get \
>          --json '{"ifindex": 8, "id": 1, "type": "rx"}'
>    {"id": 1, "type": "rx", "ifindex": 8, "xsk": {}}
> 
> Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
> lock. For the queue-get we do not lock both devices. When queues get
> {un,}leased, both devices are locked, thus if __netif_get_rx_queue_lease()
> returns a lease pointer, it points to a valid device. The netns-id is
> fetched via peernet2id_alloc() similarly as done in OVS.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   include/net/netdev_rx_queue.h | 14 ++++++++
>   net/core/netdev-genl.c        | 66 ++++++++++++++++++++++++++++++++---
>   net/core/netdev_rx_queue.c    | 54 ++++++++++++++++++++++++++++
>   3 files changed, 130 insertions(+), 4 deletions(-)
> 


Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

