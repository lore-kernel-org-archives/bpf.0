Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771613F9F58
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057371; cv=none; b=Nu61nFOO57Eitk4mJEaJOeLVyA6wh+Iaa4a6c3cNLxWJWopIhgAGaGUMNNUiY5o+cy09V+5UU88tz6LJbM/Z0qbNNobdwl/5X193pSEwN0JKsdgU9XsRN/b8eHlGCkgZX90SC+xzi4qaOTMg26iitMB4onYmvi0o4bhjBnJuAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057371; c=relaxed/simple;
	bh=gb45/oqhAOA3WMHez4z8ZFzbFW8uPRkRLGqn5ya+m1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uvlo7bx1nyuu+yF1JNUxuYyN/CiX69kiLmh4xtPNF5za1YD4TWDDflpA8Xr9KpC7cggFCceAY0mLeVV7lLQTyU5z2ciUYhX+nhuFJLox6jAn0u2DxWxSOHz5Ajbk1aKo+UcrKxvYcElneU55lPRrk3VD3xfazRw4n7U8INnLxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBOmyvSp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBOmyvSp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso65171675e9.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057366; x=1777662166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1TWGPl8GQ6EGftPy9BnY4YxVrgEeuJpqvfXBBU0i7s=;
        b=JBOmyvSpXcnzFjBljjAnMoDJHBK402+VoMqf9MEXfGX3Vi7YePdRJwiM0HXhLVBATO
         w4tm5iUzVseO5yFHBa8GvIzD2TjT2iGtCaNePcOUIE5zSLDwEj8IZ+hMKrZhl27yOQWR
         ha7Q00zvkqzACD31Xkd6XjmGJr0cPrdljvpuUYMMAcvnG4GZuS17cbyfhIjZuEh4fjnb
         yAnmjxiNt008jhOVVG3zU+rcmJI0DsCOfGVzBSxKW8wQ58bX0lYhYfQ23OEXaEv+vXoG
         M4ZaXuTpm2On5s1Cb1dpHGqDoCwRqMnsnX0Psi2cf6oumjQNssUet3Yn1LZGdzDWOodE
         A1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057366; x=1777662166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1TWGPl8GQ6EGftPy9BnY4YxVrgEeuJpqvfXBBU0i7s=;
        b=H1xzAK/E8Jw5DtHBjX5YNrFRGwV89BqnCzu0hTSt+aUgGyBSKqPj9lWASZLhVVNkjs
         m2jbMKQUqWapWJEgqpjdW6p79cqW7vQyY5olG/bnqSZ43VzjvC1r7JxZ61f5Cq9GFiMu
         YeMtSvhdfdjCqNgieDb6Mwkabtb568q9Dp4Fx5HrVmQNFLAQQWfGuSmHW5BGiO1I/8+q
         WahkDjS2TYFVDHcNZb5M6tWKL2dw0dogDRZl4R9lPG0PPJEBWCLGhl+TjgjAkGGRgCFP
         pppIaI/ZM0z/VHwf5iJ4bys66nrMPncd3mqGR26dsbIlTEINevpHcMC0nr33QDSifZni
         XP1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1QN+rXA3xpHzMjLAgG9Q3euL+R5tsWgsm2YDcT3T5spgX5m8nB4Rqh/cGlYBMuL1RkNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8YjEbr+hfAqstzJxCVCkrWv6k1dZDlgsFLl5kx0jwewujjZa
	4S0oeOFLXXiikdEvXhSODFgaEQ72nt3lVrjWpvKHO6/EagfbjRjJODz7
X-Gm-Gg: AeBDievWcHmyzTqeiwxm56z4Bj7tvi4041/cIljfDX2XgBMR7l/jyx5VoJelzVFLx58
	VbLWdChit1vNOoMSv3g61+0gJAnjKn8EnJElgDibvSOp/IiCTx0uYlKspeKG4J90/mnzm9CaMVR
	wNfrsZzTTanrxLB8CrMTFXxFSXlMZUZhPhRnKkLPUWAcNLm+aZBzp88F+yQ5KaiYQdFtfhbly8E
	B2C010bzR+YzIlFMzi8F9JMIwkKTm4QfCq0JA2aeE3TOH5T8DHUDQVl6hRXxQn3oJK2+dUOO4jQ
	lh/F2dztfY/tnf2HJg7nHE9+gszkaEAMT77RL65J1/9i394dJUNsavUJDLaZQgHjwg2nWELel/z
	IyUmXgjGiFHbLcQSLY0L7ucsDZisL5qbS3XUXehg/rxhffRBW1qLKF9cWLYO/C2UejY0H7SnFYc
	JRM5ADCMbM3ldN3szKqsQy9RqrhRKfud8McmA1DBtfVW7HfkTHXX2Cto2Hfgt3ozQz8OwmKQ37o
	2b9lheMqzIdLeY9GEtrlQ==
X-Received: by 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id 5b1f17b1804b1-4890c57760emr224728995e9.31.1777057366253;
        Fri, 24 Apr 2026 12:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52d232afsm106937625e9.31.2026.04.24.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 12:02:45 -0700 (PDT)
Message-ID: <68e42b44-d77c-4bbf-b808-9927de9dad48@gmail.com>
Date: Fri, 24 Apr 2026 20:02:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20260423222356.155387-1-ameryhung@gmail.com>
 <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
 <2026424184430.ui0Q.martin.lau@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <2026424184430.ui0Q.martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/26 7:49 PM, Martin KaFai Lau wrote:
> On Fri, Apr 24, 2026 at 12:50:34AM +0100, Mykyta Yatsenko wrote:
>>> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
>>> index 14eb7812bda4..b50d26a542ed 100644
>>> --- a/net/core/bpf_sk_storage.c
>>> +++ b/net/core/bpf_sk_storage.c
>>> @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
>>>    				      sdata->data, true);
>>>    	else
>>>    		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
>>> +	check_and_init_map_value(&smap->map, nla_data(nla_value));
>>
>> I think check_and_init_map_value() should be moved before the
>> copy_map_value(), because copy_map_value_locked() already uses
>> spin lock special field, which if uninitialized can deadlock?
> 
> The src (sdata->data) lock is used instead of
> the dst (nla_data(nla_value)) lock, so it should be fine.

Right, the lock is protecting from torn read, my bad, thanks!
