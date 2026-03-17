Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358923E6DE9
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757977; cv=none; b=c88bxbghchSCd8C5hszsT+ztiDU/PSQ1/IQGH6c/NTQn+cDeFNVfEEIQ+4G6dFNxqOYzuoIdXoNg7PpaHoEdjeDyJ7SnHKWYYmC1hO5VAvUcTxOQ6hdXxAGUhE2F6TkaYtra90LTnDWEI0aTi6vMeHy9yYni/NLcgh+QvpQ3CdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757977; c=relaxed/simple;
	bh=UQhy86RBpO6F0poicol7tkVEH4GfMsaYZqbSFAbiD4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V491LMESK62SwiCEBG+KfpfH9WqOAQ1ze3kkkGc1+uTC+s+JC35SSm9GbsHU83xK+HvRa3RCUy8vbYsjiMpq+C6weINyOGBaYWk+RqXnuJB+c/xm4RxNrSMqq9cArXfC1NAbmtEPLZlfq/4uvMNvJowjpdASbHAMoksSfNnb6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2Z7fOOM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwgGlpAO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2Z7fOOM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwgGlpAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773757975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D9W6spqw8VAUPjpA4QQ9ebhqahz4Vs6fKnlo8CL3p4=;
	b=M2Z7fOOM8XnULD51FCiiBNLLIH36XnojRLkaJjksG6PmbFiNxwI+cynxaqbY174AV3HC1w
	sAEHvxTm3dQpscqsYR6kUv0YMw4oqtWdt52JYMBxyRkT+SX+erHkDZI6R14ir4vgZ9EhMa
	sb8Tovmdjg2JQXp8Kr152RRwbptzh+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-mDsSSowJOFKhgP04yuDscw-1; Tue, 17 Mar 2026 10:32:53 -0400
X-MC-Unique: mDsSSowJOFKhgP04yuDscw-1
X-Mimecast-MFC-AGG-ID: mDsSSowJOFKhgP04yuDscw_1773757973
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853efceaddso50447125e9.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773757972; x=1774362772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D9W6spqw8VAUPjpA4QQ9ebhqahz4Vs6fKnlo8CL3p4=;
        b=gwgGlpAO32yPu5rSk0MwfJDZA34ZshIuQOudeogeY9kXajKWXYTaII3pVYL6vZ+Kpy
         Hbp1dSyaQt1FcDGZ2rysEFiQlm+2SaYf860IpEMB2c3zOPAxFoWtYrah7Xy2gQiNBliQ
         hyqudPVnhezP8dwFy+VMoyBG4nx6o9gUq7TsCZn1YTRCvzeTWI9LZE21Y/pDyv9DGZJM
         5Iv1MVxr/fShLY/+mXntBuKyFH+Ie6wFE+18ezlrfV7AOf69mRPISncC8TClHd7KAJX+
         mzLtde8raT9399y+zdJBcOAwgcHphpBx+NmdMUyhdlIJ9ILCqciJY/W8YxeBHXZlT9Gr
         SgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773757972; x=1774362772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8D9W6spqw8VAUPjpA4QQ9ebhqahz4Vs6fKnlo8CL3p4=;
        b=enYPvNAdAWBYzzxTQ4AtZxCvq5NsYntL1u/ueBhnXN2xqfX+bQMyJtvjxxOx+ebjtk
         aPXWIouqXi2V0t0sz/qCt87IKf/cJIE2GKpv/VLzbSiMckWvCjKLFoW4hidQMrhruUig
         BwuoLW7nUxL8ZjZ2wbOG126Cwb6+ZN+qGwJ7jLjs6HQKxGO/GLmKjdrCm+1e7n+9tZXh
         42Cmrhvs2G865z1Z8f09e5zlYpz8VDNzqVjT7bgCHHDMItpcKUCtdEt21dWm4IqYMGy+
         QrfEYt6keb8hxE62N+mUYYecPjx9GjEnTSKLt+1DIRglpwYymOZvhhIhLbXrfjSddIdw
         btug==
X-Forwarded-Encrypted: i=1; AJvYcCX83ThLwYO3j35o/ctbkMbHxsDdGLis+qFP5mQ8V/NMv+PDBKetfq5cv8aAE0wRaVFZn9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRwPq45SNzwSK66SZL1cLwHlxZC7aHRwPMGQBC1PankUc4V9R
	KEkfNCSYuryGxoeWXvnbqoPTmGyDYwYIEr8ac7QDi5GjMbsTt5rHiMlTHsMuiBDmpgbPf4tEea1
	7dYcwNrODti6tfhA1hKjjhKaZ9Q96ej0XOQZfxBV3pEh0tHJjfGm7UA==
X-Gm-Gg: ATEYQzzErWsEhoKbAW8h9zbnpc0rWiXV1jaDzLjrv8hhzBwsVcglCPLZJV4J8vm9Va5
	K9BzD6xpQ7cUjij2tOZigL8Q46ly9fgXdXkxOzZlUWBEmHyaHQr75gjQVoJWzD0jyNGhiYXHdsJ
	shoMPzmfsM5oZM83EfJi43b+nHwagILmGogEt105EH301EzLZIdo4B6KOR9jRGDSH5QkZMOcMMy
	oxe9k52b0yIdJ1KVF7JBGt2iCFV4jQ+J6Ekph7YcCo/AIWtGwJodUZ5C/nIys/HSjVm6woWp3Zd
	4u/pssnixAfv9XQN1x3lvl6szgCp1tI51uhLZcoW9zjmKlRsrOxpw416J2ljbwW334m8nFXeOGx
	VVe2T74qriYRYYVPLBB740zQptYrnFhWeV4XfZaJqKuPLmVXfbIUi+DQ=
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr277855375e9.3.1773757972501;
        Tue, 17 Mar 2026 07:32:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr277854775e9.3.1773757971893;
        Tue, 17 Mar 2026 07:32:51 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855777bd37sm191300515e9.3.2026.03.17.07.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:32:51 -0700 (PDT)
Message-ID: <f5edbbfc-9d42-4911-9dac-e2597db7a2bc@redhat.com>
Date: Tue, 17 Mar 2026 15:32:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] selftests: net: move common xdp.py
 functions into lib
To: Mohsin Bashir <mohsin.bashr@gmail.com>,
 Chris J Arges <carges@cloudflare.com>, Joe Damato <joe@dama.to>,
 Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
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
 <f790d4e9-7f17-4878-860f-8d21c4c9c307@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f790d4e9-7f17-4878-860f-8d21c4c9c307@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 7:48 AM, Mohsin Bashir wrote:
>> +def format_hex_bytes(value):
>> +    """
>> +    Helper function that converts an integer into a formatted hexadecimal byte string.
>> +
>> +    Args:
>> +        value: An integer representing the number to be converted.
>> +
>> +    Returns:
>> +        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
>> +    """
>> +    hex_str = value.to_bytes(4, byteorder='little', signed=True)
>> +    return ' '.join(f'{byte:02x}' for byte in hex_str)
>> +
>> +
> 
> Since format_hex_bytes is not exported in __init__.py, Should it be 
> prefixed with _ to indicate it is private?

I agree such cleanup would make sense.

/{

