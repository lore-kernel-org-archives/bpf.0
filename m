Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6F34404F
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730113; cv=none; b=Y0dgIHpUn+KcIn2XyGyLcBkMmVy6fJEvviiIdZiy8qV14vRKbiQqnB1h88zNH4MljuOWb004JSs2TSal3vl+lTbnqzsCINJBhAyBH5ehWtVclaDj/2peyfbqY4U7p2YqkD9EzQCTTQA7evNQJ1KSjfzw+cRvv+dawn8GH6Txxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730113; c=relaxed/simple;
	bh=7mDT2KegbjhvcGVQ7Ky//j6ZPW6Zd2p+RwPpKzFXQmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW8snUs/WLRD6YZ8HOLiY4OzthNUsDNpQ4BXxJSc9qE4mJBURLoik3FZGNl6RAexQIfs7prnPexZ9r7YNOXSJ+kuu4eJrXcnj0PAWezNOOKj1lAxNf4NrTVjx9yQm+IgJQszxr0JMdzXjh8pSpuOnpvyDlXrnhPdc3biS86cMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl6lM7Ok; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl6lM7Ok"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so7277766c88.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730111; x=1774334911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/uOq+b65vcKRbPJG2b/xfb9wjJT/epco+iRGrxkHWQ=;
        b=Jl6lM7OkYWMjal9cJ2c4wfuIsWki21sMKWMw91Es/DWIEtNnSpm3sgg9i8bcrXbGD3
         2QzOotwbrY0CTKbPoa5t4wiVXbXMXhcTVEOUx6AfPqQNhY0dHG1Y97+Vvv1oT86QwYDa
         HYitxSqwXpsPE9nU/uROOxPtyxTdDbFv+5nTztDsVbx7nT3Cj7ydZLO91xrxsjnz6TGS
         fUILnpgEQPvglN1rA22Lp2aK4M26f6nNuoleWF/7C1Gz/+Xc84SUeWmLMP2Bl7Vtwf87
         3bQh1/juoy/+SebiPlYN4whYButH+zk+0ejhAxQZjFjqzBdbm6ynf2bdLnHf3y1TUukI
         6x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730111; x=1774334911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/uOq+b65vcKRbPJG2b/xfb9wjJT/epco+iRGrxkHWQ=;
        b=M6Ul0+LNRTzxqQHnM0dnpwSmVorG+3yYMV7JfPpSTsXM8X0lPBvwwFxSHLXenHp8u4
         fdVRoghtWOhnFTqhLXAzO9RfKtnxtf+iWE636CNuEHpfHS0efUc8OSoOqK4yPDwMdSq7
         5QKhgFR9xDuB6mZNyRx5okbrnAKqufmH9LDY12Q5aHP+Y/2ZXNVf4jP/ds0YPMJlEy0H
         Iw7Paw6PvVzGROCLvRzwwIsqx0oBPMehDBin4Y3ZW2dZC9oCSkuAmvIJOXTM3yZXMBx3
         sTEx/SYs9ZEVt0iviDECMCt4lmJAYUVNGU/1g3nOq2vlgAtuHnHEiAxL3/IgdIO+PMo+
         Xl1g==
X-Forwarded-Encrypted: i=1; AJvYcCX2OLek+WEglvZLrQAkslftzcO6I+t2f5SmxzwEn70jYASTDoZWHKf0rsw+heomIpQpj5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tOxMdNCjBdFlX9AHhWw/CcPJDsTbA3LamvucuRB3NbLrHWqd
	vqU30vuy11LfDc/quxw7mmsHd6+eiJzek5kRogvl7YPF5abkG8PN/O+M
X-Gm-Gg: ATEYQzy5vr+VGK1cReTu15ISvWCVqVOWpWnvx9N5smOHbS0nHmmcQSY7420hBaRLymr
	t+oj87gAwGuUeAa4m9mpv57kSg+0sJGVteQqwQ22/9YZyfH+yanlcKXVR1tHA0KiwLs6UkYzEds
	hEzULfZTpY/qRR3K3JU+KCMgleD7bNYyzg6riVlc8jFu36WgILttaHxw7gx0CgFWGoSDXoE/7ti
	26rMuvfpiPRgaacphC3qZJD8CGQk4yAB741VVUXGVfeHqFpuYQ+45xEpPBgFL1aQDTSjG4FJvom
	y5ym6jD5+iSsTSsGuvpZSp9EjeH0uvdE8XcvPCjtUE8ww6/U5gRkfZNQKdVfrqk7NGUdULNVpGB
	B0EM0LvUopP0EYzkqfISykNclpUEov+CQ5YIUaj7We3FjdJDVWIHRhbrEYutGsnuqUepaK7Z8uU
	fz2wTNfpvgqDiDr0mO+WrHQXq8JfAEs8dHIq7IWMsV0tDCbd3MWNbMa2iCcXF/S6Qn3aj6Kr3U6
	ewNEOwz3xbCqMlH0RTYHA==
X-Received: by 2002:a05:701a:c96e:b0:123:3500:b688 with SMTP id a92af1059eb24-128f3d45b05mr6349426c88.19.1773730111003;
        Mon, 16 Mar 2026 23:48:31 -0700 (PDT)
Received: from ?IPV6:2601:646:8f01:ac80:1833:81b1:8dd:ec21? ([2601:646:8f01:ac80:1833:81b1:8dd:ec21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526f9asm23132416eec.19.2026.03.16.23.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 23:48:30 -0700 (PDT)
Message-ID: <f790d4e9-7f17-4878-860f-8d21c4c9c307@gmail.com>
Date: Mon, 16 Mar 2026 23:48:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] selftests: net: move common xdp.py
 functions into lib
To: Chris J Arges <carges@cloudflare.com>, Joe Damato <joe@dama.to>,
 Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 David Wei <dw@davidwei.uk>, Daniel Zahka <daniel.zahka@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-6-carges@cloudflare.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260313223029.454755-6-carges@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> -            _set_xdp_map("map_xdp_setup",
> +            bpf_map_set("map_xdp_setup",
>                        TestConfig.ADJST_OFFSET.value,
>                        offset)
> -            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
> -            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
> +            bpf_map_set("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
> +            bpf_map_set("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)

Looks like a duplicate call to adjust the offset?

> +def format_hex_bytes(value):
> +    """
> +    Helper function that converts an integer into a formatted hexadecimal byte string.
> +
> +    Args:
> +        value: An integer representing the number to be converted.
> +
> +    Returns:
> +        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
> +    """
> +    hex_str = value.to_bytes(4, byteorder='little', signed=True)
> +    return ' '.join(f'{byte:02x}' for byte in hex_str)
> +
> +

Since format_hex_bytes is not exported in __init__.py, Should it be 
prefixed with _ to indicate it is private?
