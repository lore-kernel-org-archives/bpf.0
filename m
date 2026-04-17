Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE31F63D9
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438998; cv=none; b=fLgv5q+flJz2H32EMSXW9ZAfAoX9LwNB3karzkSTwGnE2hzZ+OipywVilgiJeoBkeyw/zpyoWx7TE2tgqa6bVeXQhSt+khLQ0kLOTE232kEiibbCs0eeXLcvgBSLEdpoGaRvHk2CcsQSIJdUAXOauaVAaBsx9vaoWYOjUXfVfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438998; c=relaxed/simple;
	bh=tbb5PuK55DR0wxrBFuUfSi3SU3heSYBo3OJ90k8XXaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3wPZC4U0Oex5CBpMGxNZ9yjIqVRu1KnLg+LmPujaWV3HGQVcg212Ts74mK4iLTCzVdn49MPAdA+7OKrRV5UkSLmt4ya2gPBXIis9+TSRo+ES5JnOCLCXVClnjZ+AqfHa3DwJgkUFC4iGYcvIrhe9etKj8dDQaXk95KH3+9tnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMOTNZ+u; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMOTNZ+u"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7650202fso707655f8f.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776438996; x=1777043796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XgLk78wslS6OB4UDwO3AJCpe86+NMN2+MFJiP0eHB4=;
        b=RMOTNZ+uHWFQxInUA6WwymBK7wey81CAg1n23RSO+j0sB01LTxkUm5l6XD7uijxa5V
         5lDKXz+SXIkgk25T0OVA2/p+5Ib3GeIyOFBTQgOrUXSKyQcvmS5PBJ90aptjnvYouSNw
         MgIisz/jHJS1i/oWz47u4N2J8lWr9kCIA7g3uACufOgSZL6LSJXpodEL9m7PqpAEjR54
         E21GH8umFQQ440zhZyHQIDxwy44rmuMbi7IC86fOVs63Gvlo8XMsI0oQg8v7gEmXqrBP
         Mr4/y5TrzaT7WKmJHxzjqIV6+9jyASCtmIeOumXzfREboNHt20pq+hQPvE9jnk2pgxOe
         Xq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438996; x=1777043796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XgLk78wslS6OB4UDwO3AJCpe86+NMN2+MFJiP0eHB4=;
        b=m8k9q+xJNzoivxDzN1V2+ZhJEHT4DwZIfipzXBk8EQAqjL3Pq+85STvoKZ4kruGCq0
         PqWuMu0+vWhRqAXEWsb9W6o/D8yyfL1muXsI8O8b1nTzaNGNvBx8kzyQu2nxcznk1pev
         OYCVADm7YgjAjHcbDSo2NqxHkJTru+5u9DsdLAohmMpn8PjEAzSGcgM2jVDCV1W3dYWc
         7HXCPiTTRXwPMUntSZ4LNdjCnQiPMZCnw51LN8LODG6YexGJjbhM+iFtex3oSrta0NKs
         HJZvjX3F5DWTkyG4e28cUJpjxquxLHPDodDcU+Hudt9ySUJqPXrNjwT79Cfk7T/GYoRj
         Szxw==
X-Forwarded-Encrypted: i=1; AFNElJ/+0YRyhYDZbV8MRaueBri66CZX6ZGvpFin55eUvGvcv+hN69QrLh+8GCNI0AUNO9iB1Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNFOyXeXy92r0THCci6bDyLWAhcARqNUH3Q5RRKqegGowVE80
	zH5s2M8E0rBisrgaC2kZFBSLtPcA56BKpBY2A9zPem9Za3ytmJGawt/ZGohdR2mN
X-Gm-Gg: AeBDietPMnQpJ/5r0Y0L7Izq3Opi1mtiwzOe9G9ywlgVBFSLiHkGTOnXJdUTqVE+P2g
	bpFVo5STU2w+yOEy8fwDnt9t8t1mBB311azTkurY0LuIvODWdkLWbFgEWNlFWt4gafvuOZzpu8x
	UVfQfI/IEE7f5JZs8Bh/FD6K83ip9JX+jIMWIqYDClvVFKukSdLLx7BG1Wy1VCC3qFUIdBCMFzX
	4QiBufSqiOzO0EGCeo8CdcldFAxJh++Zmf0RA5HESB9ssblq3vD/PutKMtOja2IrBusli2EoreT
	7mpp+HQYaWoh2GuC9aI2XkNkxjGI6jOb48BJZDn0rXNvFh1r0XyId/gN1J7xaWh1t9FeUw/DeO7
	luo1b/sF8FV4dpRh+90efvBEd2Fsw4RGfVe2buObjAXdRQldk/pgXwgZR4QlKB+YWrWI7rpix3Z
	vp1ErfIc96k+xte7KIvj4HxwWjb4+uOb7wQzv0m33Y4oEF/H1wYqntILkC+XbEHEFlKKhuDgzTV
	CXUpu4mNjV15h/nBAHL6g==
X-Received: by 2002:adf:f04d:0:b0:43e:b0fd:5a24 with SMTP id ffacd0b85a97d-43fe3dd3c63mr3471642f8f.17.1776438995713;
        Fri, 17 Apr 2026 08:16:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm4797952f8f.32.2026.04.17.08.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:16:35 -0700 (PDT)
Message-ID: <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com>
Date: Fri, 17 Apr 2026 16:16:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
 <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 7:54 AM, Herbert Xu wrote:
> On Thu, Apr 16, 2026 at 04:10:35PM +0100, Mykyta Yatsenko wrote:
>>
>> There is a problem though is the get_next_key interface:
>>
>> int get_next_key(struct bpf_map *map, void *key, void *next_key)
> 
> Any chance of changing the interface?
> 
> If not then perhaps a better solution is to use a linked list
> in conjunction with rhashtable.  It'll cost a little bit of
> extra memory, but really provides you with the ideal solution
> for what you're trying to do.
> 
> Cheers,

Changing interface is practically not possible - this comes from the bpf 
syscall.
Linked list solution: we probably can't afford it performance-wise, it's 
not worth it to pay for the linked list maintenance in insert/delete 
operations, to make traversals work well.
