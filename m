Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA874B4897
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053700; cv=none; b=RmZAwQTBi5qPj++SVbiZpX888d3Lfy4G7kEvj9JrY2kTu2vwNzS0XKY31jrIO1gngHZehIPT8NMwMVghbGw+aMokzb+n1Ay0o+Ka5JI1WUn83jnYYUHSD8/ermxBuhowmDKGoApYB48N/0SbMgrZqEgVvPf0pY6zc+EfvBMP28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053700; c=relaxed/simple;
	bh=6EAcZ+Us8WapBgHYVsI1qI9jonTLifGiN6hiq2IjM4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvWrRfHQbTtIY5xa7Uu+LS6LxCABMwSkIzouKwRPVlzkFuo0Dkk1kvN5wPkxs4LkFzp+c2yMsmfZzE8bDq7Cj9Agi0oVMMBHOErXVxW6hqnOZglwPK4nyNsyt2fRhMixJQyjU0oJoC4fMcoPFyzzjM4sF3rd/7hCuwPlfsWpQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY3fSkhp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY3fSkhp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so13500125e9.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053689; x=1789658489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EzQRhO0rt2cj9dunvGOTIWGEl+7bOny3zQpjJd2RpU=;
        b=RY3fSkhpGC3VEVYHXeJ1t+oyclkdq5MODWsKoinMQb7US7ZdTnxBnPpqj3JaalGXgr
         E5X3wPqJsTPcqzvOzWT0pFU5c+YiR8XWjLXNEDxkHQNFMAnKy6IafsSK9N4ZVrn/wsI3
         i8y1U80lhED5O+bi/e12ZAYFmaklFbQMedqUFyWBjDRBIUOPBh2GWSQsVKxvZ6iguu0/
         m29gcNpBpEud/RhC03MwgasbhJvFlDkrcjKNC1Vs527aH/xAoDJgd5Wn0w8f0u0WmUDN
         i/pBU1fOdY8vd80aV8QZqumM7v3HC5j9ZUe7175cMme4IC8vhcOz2Tg+h8FD8bN0FvLI
         m+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053689; x=1789658489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6EzQRhO0rt2cj9dunvGOTIWGEl+7bOny3zQpjJd2RpU=;
        b=pyY/qdKb5vLlLwslVcUiySTvglnZRuQldHpQKO+i3DIxT/e3x07PU9LKt4AkdNUV2n
         sbxWwl1X+oZ0CcdFpAWNk48NvTFoC5MFmpVwAGhBvJDpv+yLMJYItfvy+EeMngf+2cyd
         5jlLaruXZ5cSoNdHkAfxFRr8bT/RboN40XBwfD6FL05xtXVE+rwNr1t2n1D52o8tR8G7
         pAxyiQ/wQFwVa38ib6VEmqxbM26VLLqMvIwDdw5TiaC7VcvsCT0IwbKWVu37tgdXyH2q
         eHnL4iBRQCFh5HJLVXT/AqLfkTN7c2PJXZw8aN7NE3ZkutnNLKWlcrmAzxGdotJGdaxW
         uceg==
X-Forwarded-Encrypted: i=1; AKwUvByPTC8EPmxUZF7iZdivuwm1KuzxR5K20rDavXHMthjEqoaWLq8aqkAFXWvc0z4UXyh8rdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mFm8ZHVU3Kc4mNplTtv5wJtq9c8UdtzQKd5eF9ODqfm4ENN5uq
	w0j/C7mTSpEZpJ5rsmjC5BSnZJpadrnNmVw+xasa8Fz9ZxXpg6L+uF3+
X-Gm-Gg: AYBFou36lE2Y6K08IWm8LQoR/DMsfZlpb4d6/x/moS3UFJdao//3sS3I28U9iROvkXj
	MINFaJtu5NdbsuJwoU8hDJHbqJOwLn7Bu03BtQCasjTR5c6873nbA3AwkneuzdOTqq/286bfY9O
	lvQ3Mg0MJET+yolLF3qE6m5a4MlfHin9eyWobWeLg/j9t7k1lkJTarEaJBAs1P48BieKzfKcBEX
	RD/OC/Erm0sgTHJN/8LiAWrZ9T99kKiJ5ZPjccPu0rno03DXTS5QB+TsGtTTP5gq27AMrr9frua
	JHnLOn8clpyydA04au1gJRaJ5Im2k/EApcRvIy+mn7E8bnzqgpALx0ehhRmkI1fZvd3T+4EMv4h
	wv8aOC09vMyMZ5wG3US318U8XU/cfU5lYxyQb/GqkKMtA3Db4wAjozUikEFnXAL6iPDab7piYdN
	0btGTsXKOIZ/L0mbfwVDh8QI0Ce6AAHAng9rP0pn/1hyK14H0/UJRdbT2PcEJeZjlZii+El7Zh5
	kDhZuaJym7mKy+ZJjfBmQm5hjdtlbOC4yRv
X-Received: by 2002:a05:600c:c178:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49d1f362a92mr204968765e9.12.1789053689122;
        Thu, 10 Sep 2026 08:21:29 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4821:971b:60ec:d55c? ([2620:10d:c092:500::7:3747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm2334635e9.4.2026.09.10.08.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:21:28 -0700 (PDT)
Message-ID: <79d579fd-7392-48ab-83da-454599217981@gmail.com>
Date: Thu, 10 Sep 2026 16:21:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/4] bpf: Add KF_PERFMON kfunc flag
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: eddyz87@gmail.com, info@starlabs.sg, bpf@vger.kernel.org
References: <20260910142107.40582-1-daniel@iogearbox.net>
 <ea68b32c-1af2-47ae-b168-4fd6791f607b@gmail.com>
 <DLBQGB3CXTSB.EXQVL3ZIQ3QO@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DLBQGB3CXTSB.EXQVL3ZIQ3QO@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/26 4:14 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu Sep 10, 2026 at 5:03 PM CEST, Mykyta Yatsenko wrote:
>> On 9/10/26 3:21 PM, Daniel Borkmann wrote:
>>> Tracing related BPF helpers e.g. under bpf_base_func_proto() are gated
>>> behind CAP_PERFMON. However, the same is currently not true for kfuncs
>>> and they are accessible via plain CAP_BPF. Add a new KF_PERFMON flag
>>> which can be used such that check_kfunc_call() ensures env->allow_ptr_leaks
>>> is permitted. This follows similar pattern to existing KF_DESTRUCTIVE flag.
>>>
>>
>> This problem has been reported and patch sent some time ago:
>> https://lore.kernel.org/all/20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn/
>>
> 
> We ended up discussing this and decided to go ahead, since it's a bit weird to
> continue to have the discrepancy against helpers that have similar restrictions.
> In practice it won't matter much to actual users, but easier to just fix it and
> put the thing to rest.  This one is also a more comprehensive fix compared to
> Nuoqi's.
> 
Thanks for the context, appreciate it!>> [...]

