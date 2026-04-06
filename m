Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3E21D3F4
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496131; cv=none; b=Ds+Uuj3+KR5Y7IGBhITki0HDgRkLDGxgq9lnmhnh5XcAtKp87Vo+KEmEF/j9/7/YeRNhMW3Bp+++JxWKSaLfYR4VvS5kWLs88LsJ0CkW8A/r6nHYOTp6BVm9k+NPZeuqTqAB0tmY0LygJSSdg8JWtmryqJSqRHvoJ5twkOXF2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496131; c=relaxed/simple;
	bh=WfuMCEoItKRep1b96WzqTVNcTzp1Eg4IFNJG3F1hgIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5aquWJIwnCxqh/5fErkNsQiHyQ8gPy1yXy2t8SDdzDolZHS4GjyzFL+jAongOn1XEJbT/k4AMbU3GBtlywV+uHOg/c+2UiAIeVysNaxkWyEiJsUJAUEoxl/r78C2pqMqEB0SGY7enARMD9vFUVEwxLvq9Sg6EGifyPIJEX8kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IP+Tp+fc; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IP+Tp+fc"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-50d6144877aso40207461cf.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496129; x=1776100929;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZPyrAH1/pZMd1gNEecdyNA5qMgHpZZXyuSSEngXuII=;
        b=e8s97lFyjjIAU0bfmTHwHGrzLnvYIaqi4QTTIPyGJ35hNyhOYn+A8SGyNojM9eIE7C
         7ck0yCof2k+rsSByXAFd8ffcUcKSLWwPW4g0AC83qQx6Ik8rcWj8EjG8Bn9718TiLFHs
         JaaIXekzKO+SKCWSGj20BJ2+fY3AIG6qocyFmuQFL4cxHV6PW4MMFDWnxKzARIOyMAwZ
         K2UUQaCWvu0MKsSJvTSOCM/xvOZ/NEY73okvlFidulUJLFZZ7WXIQLfO9OxGNWU6yF0b
         vD4bUAMGnfEDDnsCZuA/vkblyF/5LzuncA5KlFzmxIFzO+LNp7jByLK9vVH4zA7DQRCR
         l4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSYDtnUyFGzCJuMY19+umOP/AMaa24Yb1jKu1ucpmjSbQM/bm6x9MaRsclSVVBCHBAzL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrpNgbGxZS5QgmYQL+63oyMFzCFr+11Do51Ouxf6ae1oL0bb6
	SutKU23sBhFwKS5bXECiY0gaO/SopO3BgCMJObWfKapCxXIi2FBdkXUn1shxlu3Nw5W6ER3v/3F
	+JzYW0sEgAz9Hsgx7eJ+G4tER+0RvRTPoHWK50JJ0z1Ssy64/mFtWlIYgglrYbDsHrjtV4EatNb
	bLIZ2t9GQmHl1r3hlNm+eYLutOSOqJH/6krCaUjk4Wt3X+MIJ0y6r8ZiRgbFpnwplFuvH8rzpN2
	kCfNyKJc/xQ
X-Gm-Gg: AeBDiesFJzj6AbgLxnBR1KpMLRHaPCDx5kaEpPm5ZwQtEmwLoGDZJTNp6XIx+/J1thO
	w+LwEyyE63CzGH4T5D8tAlxoc8ttqR7Sl/h4eRdbTDybgqiEN3aziQQchNcV7mz0EV3v0xi45kw
	bXMosM/mnggLDvgMYwcCoW0pScrigoIX/nYp5G1Y6KRh9ZfBgBulCrRY9jYDmqJHOnJ85MLSUgD
	MmVmBrR7X6ypNeEaI7RA0ZKZuJmCH2xhRxIPU9B6DamuJyuVTNyH6LeGIss4gcDVOEQpbkMjz0t
	nCOG2oB/ofyBVIF8exCb0c/8KTSVAI8J8FCczf+siEY5kc2sD4VyxY4o9jTBKDQaBXM39ma0/0L
	oLmZiwvwOjUz30qUIWK8eV3KH3OdQZsQriUTafHi7NzlIR3GlvdzYYraLz3cRoqEvCbX/ZP/IP+
	fzZL4nH1R4UUuIU/0yF0GVdYbeky4SGz4WqNFXq4rIgalD2Rx4UPCzbiRbhZZZLw==
X-Received: by 2002:ac8:5d4c:0:b0:50d:9204:4652 with SMTP id d75a77b69052e-50d92044dd3mr62715031cf.41.1775496129252;
        Mon, 06 Apr 2026 10:22:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50d753ef1f2sm5431541cf.25.2026.04.06.10.22.08
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:22:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso22973777eec.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775496127; x=1776100927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KZPyrAH1/pZMd1gNEecdyNA5qMgHpZZXyuSSEngXuII=;
        b=IP+Tp+fc9a8wVg4ge/xEuA1LaEWhE/eAZ0tfZfR+RBU9+9wMgg8dEfkXM3/CKsca3J
         rIxVU/9vg57NIMJxkdIIR+3bmtqB3L59ZJTpSF4iNgb3r7Bgqlm7yjNsZeVQeemtC2mY
         rey0Bfp2nDhd04bUblPJY8RSCORI2/CFT4ebU=
X-Forwarded-Encrypted: i=1; AJvYcCVG59MDoEmywCgGM99y+T23L5umiaq/juID5it+rI4QYB5FReL6qmvvVbwqEW1dj2qOLPE=@vger.kernel.org
X-Received: by 2002:a05:7300:e78d:b0:2c0:da6f:55e0 with SMTP id 5a478bee46e88-2cbfc362ac8mr6057406eec.27.1775496127438;
        Mon, 06 Apr 2026 10:22:07 -0700 (PDT)
X-Received: by 2002:a05:7300:e78d:b0:2c0:da6f:55e0 with SMTP id 5a478bee46e88-2cbfc362ac8mr6057379eec.27.1775496126727;
        Mon, 06 Apr 2026 10:22:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ce39d13decsm6017020eec.8.2026.04.06.10.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:22:05 -0700 (PDT)
Message-ID: <eb33745f-da92-4182-a1f7-5167a2917732@broadcom.com>
Date: Mon, 6 Apr 2026 10:22:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: bcmgenet: register xdp_rxq_info for
 each RX ring
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
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
 <20260406083536.839517-3-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Register an xdp_rxq_info per RX ring and associate it with the ring's
> page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
> XDP program execution: the XDP framework needs to know the memory model
> backing each RX queue for correct page lifecycle management.
> 
> No functional change - XDP programs are not yet attached or executed.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
