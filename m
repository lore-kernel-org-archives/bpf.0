Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE3390990
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496022; cv=none; b=uMl7xQyWLom7OZTkx3Jg1EXcgjxE7UpNVJfkWsZN7YW0T5G4wcHmIM+zOoV1gt+W6JRBOfUj9ZqsWDnI8int9/EZClUJFjDYMF57VUTJcqB+oJs9eGHKtmhxBDgvydVbnb9ME2aXO+ITejjS8262ZARKehCiWdwJfS0BOHk2eNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496022; c=relaxed/simple;
	bh=qzaH8m1FQQvseH1i2VcsREALPFcUfdY3t26JGB+mNQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CluOokxwQYjRWa5yWtshluL3tTzKWleURPp4HM3Kl4z1IOh+MI0pDytCU0mFq+t7KYofwUrdHE1MF225/OQVkWooOEUdig7/qMZMZJnpOzpzHg2CjmKFI/voh2IevMKXNSTaYXvEFJtbBuE9YkN6RlPTxhhNoqZpEw9lXPGZfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mg0ch4EQ; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mg0ch4EQ"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64eaf8aa893so3466401d50.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496020; x=1776100820;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ak/8YrDC0eJbLQIfMmaoVpPiz4Stv8t/FxXd5vdbs8M=;
        b=UlSx+F3TzyDs7B/Vd/SAuqlriEF+DY/1NmF13QfT83SmrnfpYyjQw5kArVJbJGXaFs
         F5L0SKJ4PxBmuq6AWzSlYZ3ltZDw7CbrhT39V31YzfLJvskbudzFnFYrKS/XRzLXYQQw
         F5p+DBbog8wwp3Z0+bj8M6/hL70/RCl7hc3L9fWWDibWC2DCXFRjvf8ncScU39hyCqZ5
         DD+8KVFGeGYY4RYWzI/HGUJF86S6SNBjwjQa+nVTKC8V3rfih1GlldDG++P7eU9X0aT1
         ymzLlOZEgSEMVXQM8BPUB2dXvMm9uPvyLisF2zezdjLOd/d2plP/svvDPTtkuiMugIwQ
         RIwA==
X-Forwarded-Encrypted: i=1; AJvYcCXNJQ3jxUol98stE/BNbBkxWW8t/0Vp35Za65AxoUnaiO1XM+58eIKZDW8Osbc7IhMQwq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDZSqKG+3sGMCWLM0YaLYdQ2l1SzUYGY4cgpVvqVJv0e1Xgvv
	0vA23iZPzi9/DGjAbgBLGhZCb8TvqbuKbWGDF6N+MocW/AFeUcZB4yV9rFskY4BtpL3D93JF2WL
	2/vrLVYAUtGpDcYHI2q56VLkPVyD7tR+8hMVsaQ3YECB6buRSoPVWJsgGAZjNLC/495gcH9+22m
	nnquG4aputAnrhMzrM4ZtvOD2KSizahZ1gCBugj5XiHRSFr6wYOvDpCwIosrGSus5LeRduuIvyr
	9QE/6/1z8Pp
X-Gm-Gg: AeBDieujsmSe/Gmj5Z2tCe4HP9PZV2qPkVIEn5qB0z39eZIEjL6zr/TtARfKUMSTOr3
	RodaosKM5La5O6ZucRhGyttZWJAbgYb9HXJ/J1ZVaC5Gi0Oa4V+cP9agWXt8DdDsR6aqQ/JCOyy
	RfAXVpnT2eFMMAdZX02uWs+6NkPLeQ+izQRV+0Gkxvv3DBU8bfFeRxhLl5arbxCjRryWz/TYq8A
	VsksrwtsLq6Y/FcykEQiF7kQpT7AEGvhXMD+XnA/ZY6iczV4tODrDhaTLOj2kYqj0PmSHPQTfRF
	BfpjSIhEgOr8DVhKRFAciyyOJICQY+Jne+ccFVGNB8+JERSGqIlm1Q+GV0lwXJsOusdf/xA5u9e
	59A2jcG7zPwE4o9J0q8kzp7peXdHHVtif+qN1E5VOn7TULzS49ftgL6ePCxfRdzNxoWrowbXuu+
	0OMR7g/g6Eer3Kmpzd0WuRmEJUB7a8aSRV3b28dKgzXBGFBKoAHjnn9iWhwnAFgA==
X-Received: by 2002:a05:690e:43c1:b0:64e:ef47:83f1 with SMTP id 956f58d0204a3-650488fa4f7mr9458103d50.69.1775496020340;
        Mon, 06 Apr 2026 10:20:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6503a834a70sm814881d50.11.2026.04.06.10.20.19
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:20:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1275c6fc58aso6337777c88.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775496019; x=1776100819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ak/8YrDC0eJbLQIfMmaoVpPiz4Stv8t/FxXd5vdbs8M=;
        b=Mg0ch4EQkcziAVMWB0Z5nM4tRAyHFRFxAmuDD+9sCySyBPgrQpwPMSNkCftaXXDPQ0
         Z2lvQxrDyzRo6riYO45kmp0lj0+kA92sSh/J3Gl5ZMeNcCg4KFswQ73+5W93Qgq7u93W
         Ux4kwsrdtcC0FT0ZIvlYlaxTRsWdjdcyuWmKw=
X-Forwarded-Encrypted: i=1; AJvYcCWOqCi7cjO1UePaMONMQUjiOMfsK/ybT1vaHdUfNN82DCp9cGZ/GLqyIFRrUSWa/JRbB0A=@vger.kernel.org
X-Received: by 2002:a05:7022:45a6:b0:12a:91fe:f5c0 with SMTP id a92af1059eb24-12bfb765de2mr5785166c88.32.1775496019084;
        Mon, 06 Apr 2026 10:20:19 -0700 (PDT)
X-Received: by 2002:a05:7022:45a6:b0:12a:91fe:f5c0 with SMTP id a92af1059eb24-12bfb765de2mr5785144c88.32.1775496018426;
        Mon, 06 Apr 2026 10:20:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c14a371b1sm892890c88.13.2026.04.06.10.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:20:17 -0700 (PDT)
Message-ID: <cfdadc60-367b-4bdb-9d00-40c24a4c92bc@broadcom.com>
Date: Mon, 6 Apr 2026 10:20:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/7] net: bcmgenet: add XDP statistics
 counters
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
 <20260406083536.839517-7-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-7-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Expose per-action XDP counters via ethtool -S: xdp_pass, xdp_drop,
> xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err.
> 
> These use the existing soft MIB infrastructure and are incremented in
> bcmgenet_run_xdp() alongside the existing driver statistics.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
