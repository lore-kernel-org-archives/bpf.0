Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63153A7846
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908374; cv=none; b=I2WyeY8lZbzf0SWXCLu7J5B50jrFv05F5K3XIKZ1QXnc10um2ndRfqbOGYlXkVJ2Qa37h/OypH1kwDcJEHRCFj9Cx8VZn9bU9XPw5vO02SfG04XfB7eH34M/3Lg9Hvl617HLgeRaZq/6M/W1gdbEEnZJeq8z4rgXozlsx9tgTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908374; c=relaxed/simple;
	bh=/nlF0x6bBiFja0NOJnYySQcEMlNQ05KgKCz/9OtXkfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eekz9U3aHlok25L9hjUK8npkm2EG4+389klsUHSCAg+OvJfPH7mvOm36/KsvHYvDBkz6dlB7z2N2zfUCKcFiYD85pl3PDJRpS0x2f/V1ebtP6FqRHyq9S6ls6uUsyw+8VCqwuJA0ADBgyHTmo7LuQ/lmBxJ2ag3pjtpgGcG84XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P4X5DeVZ; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P4X5DeVZ"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-89cc797547fso54272366d6.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908370; x=1775513170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wazMMCQ25eiP79G9aIROHWVXvvxGSf4JuL+1u5LyYKw=;
        b=UnQNkYnmtAaYcLEFKz2EFrc6E/5Q2y0/aiFlpVLHlD8uBKQju5jREm+5yCwASrBn2H
         PhddztU4yjrZQCi1Id5mTwx5StNCzQvHdwAO8h59kYAni/GNJee+QTjVCfh3liurUkpD
         wWuJJf8BCOTvXNb1Meza6tIbdOESpcxNFwo5GtH7RucKj1vbom/NWDnQZxcxmrxcHk3T
         SFPjAWacTz6uOoUgdKe8ZwXKYBTyaJaHzvDcs9Bebb+O4NskMHV5oSYoI3J8oNo2WvEI
         58hqqKxXYVvhEUZ+rhojDMvh5z2E57N7/+aZezpoHdyc40yO8dpYuCTn2lf34k0bfMtH
         l+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXuMLd4Of6U0yd9+cad7QrSQrm/9PE3bdmbGzHfTj41l5Bgq2KdbJXeacQUHec8qSO7Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTq5SytQuJ+73KmnqlI6dbcDA24HsdG1eWhnnDeuSI+rLUgkwW
	ePagnG+81D6QAso03FKJyzPM7DXYvKXD9HsJis7m9obP33pvKyQpV2fKiriVA1ihxzAX6uG4TI+
	nexMZcUv/CRNVRw/jn+VyA8RS+xL/PHL1lNag+JuR8n5LkI6x1qB2XppVBxfYK5BZwuwr/CxV8c
	3jbJKL7KQVceUG4ZCgH1KQI4Qj8v0Wuwuh/R0oYRk3uspT2E8kbSrVN5ZnqEXilqR7u9IbtfGK/
	sOGnjQxWevN
X-Gm-Gg: ATEYQzzPgYySFf82reu3ZaftrL3fAbG8nj/UKiSSEeeKGmK8F4kCY/c4ZQWx0wJX96n
	zaiO+mmwftOBHTUxxuIvpUSBmXi90E07dQgNet4zrIsn8WBLi7VX2FGXLK84Tevb5yt7ekr6O9m
	bw1XQQLb8SlcTb/0aNqGK+NjQg1C1ygKwaNTgoQ6XRlO1bGVejwNjCprrWs3UL8pqpWJb45l6MR
	qquDLd0U1OPhYIO+bl2Qvhde5SEpfMvpY7LzVbPDV2+8JPXc4UHuClU0fyoGC5q5VTMGGcOfq7Z
	ABWe+1aahzH9Tedmuh+ROzPt4SkiWdMtv5Oy/JzUAMLVLBDdaTuCg+Wj0aauA5GaGek/QABxt2k
	zXvekiY9Yi6U61VnBFxvH0Ij/AnzqLsR2CX85PZ7vhUGARGxLar/sqQ9QACnjIs0UePK4f39O73
	J6PMUEPqx2DQPFvex3r5nTFQ1zoqnUOdDYFPFgMH9gs5oCizGFK1HXVlARHTdKtA==
X-Received: by 2002:a05:6214:5c88:b0:89c:c5cc:4bf4 with SMTP id 6a1803df08f44-89ce8d84206mr200350966d6.16.1774908370326;
        Mon, 30 Mar 2026 15:06:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89ece6cdf9asm11273156d6.27.2026.03.30.15.06.10
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:06:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5266380eec.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774908369; x=1775513169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wazMMCQ25eiP79G9aIROHWVXvvxGSf4JuL+1u5LyYKw=;
        b=P4X5DeVZU6t2nP/KyI6c8nBmLY2DXHH8ZYx9YoqLFMp2vaDEWjvWbc40Fqn+gx/qlp
         GfPaB7vmWeGLEaUUEM8I+zeqZjD+XNFg7CCT95nP4YRqEXDbnmZiSCQ5YNXtPqm/qXbT
         dxHaGwl0UDm0n/5KmozkwOyCtQZEs0HzOE7RY=
X-Forwarded-Encrypted: i=1; AJvYcCXnIwtNiyyNKbB9miDvOFftmamjQSixL7oI8hURbMG6lW5pZuL96RiFzxsVkJdEcdBPnj8=@vger.kernel.org
X-Received: by 2002:a05:693c:310c:b0:2c6:cdb3:bd67 with SMTP id 5a478bee46e88-2c6cdc30cd2mr2625854eec.22.1774908368712;
        Mon, 30 Mar 2026 15:06:08 -0700 (PDT)
X-Received: by 2002:a05:693c:310c:b0:2c6:cdb3:bd67 with SMTP id 5a478bee46e88-2c6cdc30cd2mr2625818eec.22.1774908368152;
        Mon, 30 Mar 2026 15:06:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b249fsm8196653eec.19.2026.03.30.15.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:06:07 -0700 (PDT)
Message-ID: <99062602-05a3-418f-9182-f60a83fdbe3b@broadcom.com>
Date: Mon, 30 Mar 2026 15:06:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
To: Nicolai Buchwitz <nb@tipi-net.de>, Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-4-nb@tipi-net.de>
 <1d551008-3c42-4b7b-9507-03072740a54a@gmail.com>
 <56270d59e5e5e79fcd3d104817679d70@tipi-net.de>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <56270d59e5e5e79fcd3d104817679d70@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 3/30/26 15:01, Nicolai Buchwitz wrote:
> On 30.3.2026 20:15, Mohsin Bashir wrote:
>>> +static int bcmgenet_xdp_setup(struct net_device *dev,
>>> +                  struct netdev_bpf *xdp)
>>> +{
>>> +    struct bcmgenet_priv *priv = netdev_priv(dev);
>>> +    struct bpf_prog *old_prog;
>>> +    struct bpf_prog *prog = xdp->prog;
>>> +
>>> +    if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
>>> +        SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
>>> +        NL_SET_ERR_MSG_MOD(xdp->extack,
>>> +                   "MTU too large for single-page XDP buffer");
>>> +        return -EOPNOTSUPP;
>>> +    }
>>
>> The MTU check here is great. But I do not see support 
>> for .ndo_change_mtu. This would allow users to change MTU size AFTER 
>> the program is attached.
> 
> Good point. I had planned to add ndo_change_mtu in a follow-up series, 
> but this leaves a gap where MTU can be changed while XDP is attached.
> 
> Options:
> 1. Add a minimal ndo_change_mtu to this series that only rejects MTU 
> changes incompatible with XDP, default behavior otherwise

Option 1 seems to be the simplest yet getting you a path through merging 
XDP support.

> 2. Reject any MTU change while XDP is attached
> 3. Defer to the ndo_change_mtu follow-up series
> 
> Thoughts?
> 
> Thanks
> Nicolai


-- 
Florian
