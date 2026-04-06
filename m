Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E03914EA
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495971; cv=none; b=mvYHXSJ1VqQ+UANXGWUZzJ93Fwnfjz6Zz8TWxqNNO/2a+xsVzpRPzmGxPJu6GsYoQ/0bDjaHf2lHXBHST16r98WwVxSgwe0e9t97V8jtmtCGu6od6C+FBW5lOj2hZ7yYcVtqaBGqaXYAwTtIgSCCDNikZhqMNekrntEHHjazwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495971; c=relaxed/simple;
	bh=Ss6WTHFJk7o5y0YnMAozv3+vHvaa9XtDF+7OYIRVVEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONNm4AQeCtCXtrADQDdNLhdFfZ78BpopGQXS20ZxNbHaAd+y5kabLohOJmUxpvgSHqm2CxKENZWw8hhNti8uG6m4KeaSJ12UFsxiczYpjvrKbyU/9Ntwfs/Lwx7P+Gam9tAPlGUbFux7z0nXdtoiKJTO7wO7dW45m4dC9+f0yHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TfymV7/O; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TfymV7/O"
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so2804615fac.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495968; x=1776100768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRkVSzhsy3jVbqKy4UiNeOSWCmccE1QBrUWtrVbAuS8=;
        b=OPnYiRmQQjMJQaYYXTHyErb83yH2huAkszcUszcVmq+WVEJerPOaGUrIBpixuO1pRR
         0uY4g9qUZRDa2u9yg6c2D62thmzxkBDNr77RjMFybOSUFJ3R9bHbTss57TmEH+XtTO8V
         wbUrbirnkLT/VAU5bF6SHUJE6ulBOzqhF5zetCMIuokpnPruDKRJHUZwKjinZvDVU9Uw
         c6bci5P0VvaxE4TTxSiBOycH7w162pez1+S0hFBdgv8QNujRcgEh1oDscTfy2LF/9ry8
         b2bDDt3bXQ8eIAck8JeL2pRxHcdGvlIGj530X9HF0eO6lDHOLFCd9sMavzJie2kut6VY
         +xlA==
X-Forwarded-Encrypted: i=1; AJvYcCXBO8nejudMJCvPRN9y+9/4mDQwabfH4gZhBLg0dqPaFFCd7K9pI5RDqbDmdCheNABOddw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3MZaQogHQNpodOceSlvDxFezlauQx0ZGp8kDjgAhG0pySDN6
	1DMlHNWTHd6qudoNdOuGYDtJbdsgpARzTbd9m53ppsffw2FUdT9ckPTZW8ay7moxytz+WyS7vOE
	PLR2cHqasB5pji0sWxQFkyN34lG0C3Vf8ciA5RIuAoWD+8PKSaQ1BkwEpF2ZfKA7BU8aqjhBXN7
	YWMG3i5OlY2Uv79WDXp4FI2i4S9ta+1yRqpBCXg4DxLm7eQfi1/yqTuarZJkApxMz+EoYr/c1cI
	0wJVhwg5Rs2
X-Gm-Gg: AeBDiesltkwDKDCyFvqUNVyvirtnnL2PXJh1YwTR2O2DyaiDG+eecOdStivVbWBiWZX
	dP/wxjL+MQkmk5tZaktWmZcyd1Q/Q7EqY0SDmlMkvS83/pA3RI1nr/RYEM6O7wtCQwQKf7dvEM6
	4pfoVUo6dDaSlRGmKmp5p1q+vQIvFUnY13HHgnmR665i+cZu85Wfw7mb4/O9eDYcRw3pSX7B8MR
	3Wpu1UV13UYkkKzEYtHZDbfxGs8RLV9GSMmUeJZKHmyTe0juDocnct2TIL6DEFKLmxl/GLBb+RG
	icJx5EMtTpJbcaNZaoUuOvwnwzq3NqviEAWlgrwHcYpckwqzbvSO9JGpyw70rgJ0UzNAdUxGn4N
	duRAyx/YtQCEda08hx9k4Ik802hfgxUCkTuGUIfv8lbCe9RCxVA5bF0aPskDAR5eqsXOFpdSJYU
	uT1WphU3l09tQzCpKi0t7xoPhXpA3otxKvIjwIOb5MPR3+VOlhIWK+SqszVReyog==
X-Received: by 2002:a05:6870:1718:b0:40a:4467:d5 with SMTP id 586e51a60fabf-4230fd85329mr7409098fac.14.1775495967948;
        Mon, 06 Apr 2026 10:19:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-422f5bce2a6sm1381960fac.16.2026.04.06.10.19.26
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:19:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5730624eec.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775495966; x=1776100766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FRkVSzhsy3jVbqKy4UiNeOSWCmccE1QBrUWtrVbAuS8=;
        b=TfymV7/O7c5eFmfvkZNxWGl0ZGIArH3eeaKvulbhnrW+UCXAM0umeF7y7htvp7NVXu
         XtAPhNjWe7uaQXg8pf/HN31wG5A/CQDukHGpS1lZALutKx7ETiUwSK2+tyo7vVpvNBzY
         iqzmkmwd80uxFTpC8yPz06v72V1r97kVDA2Dw=
X-Forwarded-Encrypted: i=1; AJvYcCUvARFxLWX2sMhXxt+8mH3cLWszU9cBPYSLt6apq1SGL5u7Ldqcqk1BsBdlfetVf3QovgM=@vger.kernel.org
X-Received: by 2002:a05:7022:6881:b0:11b:b622:cad9 with SMTP id a92af1059eb24-12bfb73e381mr5511727c88.21.1775495965599;
        Mon, 06 Apr 2026 10:19:25 -0700 (PDT)
X-Received: by 2002:a05:7022:6881:b0:11b:b622:cad9 with SMTP id a92af1059eb24-12bfb73e381mr5511704c88.21.1775495965035;
        Mon, 06 Apr 2026 10:19:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede7f542sm12020430c88.14.2026.04.06.10.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:19:24 -0700 (PDT)
Message-ID: <967f597e-589d-41b5-9b03-b91ecd2d3ab0@broadcom.com>
Date: Mon, 6 Apr 2026 10:19:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-8-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-8-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Add a minimal ndo_change_mtu that rejects MTU values too large for
> single-page XDP buffers when an XDP program is attached. Without this,
> users could change the MTU at runtime and break the XDP buffer layout.
> 
> When no XDP program is attached, any MTU change is accepted, matching
> the existing behavior without ndo_change_mtu.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

