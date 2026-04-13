Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AED3C278A
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082927; cv=none; b=n1hpYkNy1AsA+qGs3K66QnlxmVDxpegV4lDubqVqzkZB/oCvH7Rx6dl1gkpqywXm53j6UZ3iM0QAd+OVm4yIu8ewf4O3gXHZBEmCWFlsqEplKTncTirrnjhkSnMF61KxTWhvIQTh0XON1CpXVBD4aNS2qHB52ybH2t9v3x6AXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082927; c=relaxed/simple;
	bh=CVU+ab2xQHCiCpC3/2rjCkeKhZ3QXAS4njPJtWwtLSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS9bMR+VanVBScIMUAwG1rsrwj3Lute2UDqJhhuXOCjeoB6mwkRO1ai+AQGAkypYMK9e9UiqupLbkHFTmzODT32HwlBrs1Hehsxg+dKrMJJE1+JCpCOvEylyW9BYsxKGY4lhrDohqOXEqhuHd3FHBRzxtRfM5J6eU1iZVqjLEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cneOdHGN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cneOdHGN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso5737021a12.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776082924; x=1776687724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCdirkkGPZpKjG++76tVGD7rcW9GPf4fsB5j9DM4xaM=;
        b=cneOdHGNS0tgvZe07Rs/KkG4xQuuUpunC+LWw4LUhbxMDOqtyCCY5H6eC7d/3B58FJ
         zhhFudaM4WCn7Z1ffd4Vl/7Rgnhq18wNjgYSJIsNLR8Bvpip1ffVGRTwf2Heq1R6yPdN
         owit17dRNkUDh0rlMrUDvMPIMKKU1Q/cGacrLEJiBO3xR+cUkaqx6phcMV4Qo7k+boMX
         iI9dPKglu9WTYGVrAw7MbDx+Lswf3rXldiiWaRsAxhyDfHwXlkOYVB0RSlD1PPfUZaJ/
         kdtMWssL1pU7V+qYSaCsJETI7fV21QBgtK06pgyxsIpv2dijKceFd+ZFCivssxmC6xoG
         Bgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082924; x=1776687724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCdirkkGPZpKjG++76tVGD7rcW9GPf4fsB5j9DM4xaM=;
        b=RVIYtVrhRG5mFEDeLQzGKVJdgFLbCPZcPDPv2evyd++WaHln+nXGQVvP15sDKG4dZc
         SJE0kelxKqSY+j79S788cbNhaDVWCOnnj6M+cviTJfOtZ+ZtxeedkfWYPztHNrZUz8qU
         +4nigCph0CmvgA8KP4eVSqmNB4uwnZkG8wSKFDb9Iot0jFezUSnVSbJrNL+FZcRCX+GJ
         0fwiBoofXyD+b4QyAd+yjdObkDMgMAj8iixgVdzN9cCWfgRevNqxtQHKKP4X00ikjQpg
         w7FG18HJEwQ+2UrWTCLZWZcjRIIfGa8qiTQpaiqbt0F7Pjz3guz0wvUr62BvmpuKL6wE
         EBfw==
X-Gm-Message-State: AOJu0Yycy57hx0SKdt2oWVJ3DxF2rnJNvlQRF8woYSrDIJVBQYkKrWHn
	mHOwD8fjmqXw/FWiJ21cmiG8WRyWCr0qVkKJ5fz3io/Q/gaSaJRP3aYn
X-Gm-Gg: AeBDietzZHqVSapUKrFODDkvV5AKgJXUnTGcKXueRThxNiMDSY08ZlN9yNjtVJlruh7
	/xGhtLDrDiwNfIdM/uEFXWdSpY9G0iEQeTsiyNQDWRnsZPEMS74LGaVWE3Yz6TY9UZvbybNSwkA
	eL3vCQ9lnJQaekTcK+9rKkOFy/1KNPFRJm3FJielgJeix312gUQJN7eJQTUYkhyHqY9m+6jNBOZ
	1+ClESmucAXFa1X1i8KXJZe79hIamD7xievzCu4r7lZgfZ1MTKeXTJEbr4Kq2r2a5HlugAtrZ/9
	556hIuK4BBkYAY++9vB7dHJmO8yhbLg0jfGpAy0y46H63bHEGwGW2OEslKozXpL3HYcAIqMPzA3
	yz5g1T7nTm4S+fdlo4i3aOkcoxQnEySuMRz0GRQzRV/hqEguvX52pufLaR6fwz+efhUjiwf86gc
	b81DBGX0k17WQMx/enfH2h1BDXQxPAGg6tnUp/k6Kyjp2/tGC9iSdK+lRAAYsKkxOg8rCK5+3Wv
	mHK7xYQDOs=
X-Received: by 2002:a17:907:e106:b0:b96:e3db:9e04 with SMTP id a640c23a62f3a-b9d727ac3d7mr404080966b.53.1776082922425;
        Mon, 13 Apr 2026 05:22:02 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:1086:f5f1:32fc:93b3? ([2a02:8109:a307:d900:1086:f5f1:32fc:93b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de97d96sm311371066b.5.2026.04.13.05.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:22:01 -0700 (PDT)
Message-ID: <c503dc00-f56e-4b03-ba1f-dc5c8b6048e3@gmail.com>
Date: Mon, 13 Apr 2026 13:22:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 04/18] rhashtable: Add
 rhashtable_walk_enter_from()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-4-3b3675da1f6e@meta.com>
 <CAADnVQJuqv+ZkgaajB42r-PNj_zFWzvCakOs-jQvzODz5M=6gg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJuqv+ZkgaajB42r-PNj_zFWzvCakOs-jQvzODz5M=6gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/13/26 12:13 AM, Alexei Starovoitov wrote:
> On Wed, Apr 8, 2026 at 8:10 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> +
>> +       /* Test 2: walk_enter_from with non-existent key starts from bucket */
>> +       {
>> +               struct test_obj_val key = { .id = 99 };
>> +
>> +               scoped_guard(rcu) {
>> +                       rhashtable_walk_enter_from(&ht, &iter, &key,
>> +                                                  test_rht_params);
>> +                       rhashtable_walk_start(&iter);
>> +               }
>> +
>> +               obj = rhashtable_walk_next(&iter);
>> +               while (IS_ERR(obj) && PTR_ERR(obj) == -EAGAIN)
>> +                       obj = rhashtable_walk_next(&iter);
>> +
>> +               /* Should still return some element (iteration from bucket start) */
>> +               rhashtable_walk_stop(&iter);
>> +               rhashtable_walk_exit(&iter);
>> +       }
>> +
>> +       /* Test 3: verify walk_enter_from + walk_next can iterate remaining elements */
>> +       {
>> +               struct test_obj_val key = { .id = 0 };
>> +               int count = 0;
> 
> Please de-claude this.
> I couldn't force claude to avoid using these pointless indents.
> Either figure out how to do it or remove it manually.

Thanks for the reviews, I'll apply your suggestions here and other 
patches for the v3.
