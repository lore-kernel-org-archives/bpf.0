Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D794D5962
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010629; cv=none; b=B8nra46XHdS8ofBSHBb//73ySbRja7+2asRHdJiuR3gOum239GafT8kR12OwUbDN1Mr0TNcBG0W9113eMM1zecco0ctJtVi0IMKdL0kcwLYNEJuAnimol9JJeA5eISU2aFjlM8fl8h93a2GuTP3V5Q/nhP4H0EbVRwRK6l5f+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010629; c=relaxed/simple;
	bh=vCZxtvF6nYdDpH0AUs6ECDR84tUwhLRwb7lvMSdlwDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0GstQoNhsuwGkwlbeOTLQhq6uWBxPh+PHCqrm7Z5Cam6mwiqdVCe6/HYjDPhcYCbxv85TNohRGFsN1gzj+eOAWQBY/gmFA/nD0WmzF+gw8G2oilx+7T0K7Ijd9NEMAWV7GdtmywRrG1c//O+BVaxnehLoSYC507wd35zGMIrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiOYlzyH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiOYlzyH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so10700305e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010626; x=1790615426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVoGVhwLoAjaiQDtWkEnHuf3WsujE8dJ6Cb6dr4zCy4=;
        b=SiOYlzyHiwDoxuOzfQ6Tkt0Km6FwTV1xmcWQfzK1WBSx3mbXM9t/a0vhV6r8D9BGTo
         7iiaHeTgxuhFTLLHqmYqMoUoHVGMXYnYO//RVA3m7lcrWBlapCwrBvM1ycb2FMiuxJpX
         X5ZK+ar0JcAsF96RHbBOmpkCh2NvocRxI+OgDh20XBi4NQpIwco91Wb6sRSGZzCVTVsj
         izIdI7ztXD5hghmZBgfhMe0KfKCTKR66L+YO+90t19ySd3T3Ugr0eYDBTgVm0AzhbrMY
         W0c9cGxPz1Ot3fuAXqFW9DECjeeRILY9yHNLZKhaOuODZCOqLDEWZFctoYqGUS7AtnRP
         xzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010626; x=1790615426;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVoGVhwLoAjaiQDtWkEnHuf3WsujE8dJ6Cb6dr4zCy4=;
        b=l9PwjrBZ6RsyIJfxnvreaOKZcLBkIW7NR0xsYKb5UXWScorq6+Ssx6UGv3I7XESmc8
         qZngC1LaVQhZNuD2IzZ20APedRIgAdtuyDTCrXIoWa1RTpF/CClpHwsM0b/C60P93z7J
         0KMJxCvNSSAWdTPctZT5RWCDpySHZYSFiBdOSYzoHumGHNcaEkRWutvtzBUgkO9EXz1z
         yZ2MwiXDPolIKAsV5vKlwjEVU8DC70Izl4KSIE1EepZ8EMW5t4cxJzU4T+Wp22F1fhvf
         JJZmI0tOSAfjYGuVajYAlDCtzpbFkT9mJl70PUQRSm6w2FGmfsKqNwETXxoqm07hJ19f
         w9gw==
X-Forwarded-Encrypted: i=1; AKwUvBygr/VqNSN767f5RiDajLitqleXrbpIIaUqYzmLDTaSLqrKDe0otCgtITA60m9bGMv54BE=@vger.kernel.org
X-Gm-Message-State: AFuF++mlA+NKQRsqK2+LLSrbg4VVeulYpDSabs+FufKiNm7I6VrGnsUI
	oEb3IJ72YOCF6s7U8ekIKUgOZzt3BIwmPt1cwU3UW+YHewobUs+JYXK3n+ZRoJL6qdo=
X-Gm-Gg: AYBFou2ApNOe4GF9pXvhu9Px5XOtWPl9IeXlKIFWVUBDDlOd3D5rs0jKsBWJqhHdsgA
	yEDTMYti4RAqUefiy9p7N3evjIlu5yLZ2tu4lmV9elg4KreZEF5SI1BG2UR+WHYa5K44b1LXPCp
	MaZc2CbHkPcYSD6BZPCDMbzZHLuIhdgILwvKexVDhn8FNr3DlqcClFGGFMOLZOEespFcX4zlCTm
	A9frGFIfkrEvgi7x8+aubfTWlZKQSrbtYCkVvGu1BGzH/oKEJvzLzCE4x9/IyK9wdipVPSjzXGI
	FglTnIsvonLc0BmPBuKWNpMI6Nso1eJAZXzrEoeyehnnlTZAdTEl/NB47dgRqq1jHd+yoGpr37M
	A0SUF/Q4M2v3b2sKibMwsTTxLTF5fZ+EFiVKGWGu37k8BpK2Slu6GD0OnAQIL26ur+KK2ARw5wu
	+jDSn2aJrOzwN9a5f3Mk/U8z0lfAYldylp80a8EmWgjZLPbUDJNnFImT12a+m4OqONq5wqll2I2
	713yguWH2Eq0eT5SwCJ09IeQmcqksAa2XEg
X-Received: by 2002:a05:600c:4e53:b0:49f:ce79:7a8d with SMTP id 5b1f17b1804b1-49fd8a731c2mr3797585e9.17.1790010625449;
        Mon, 21 Sep 2026 10:10:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:244c:45bb:f9e2:a281? ([2620:10d:c092:500::7:f504])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ba0748sm5015315e9.6.2026.09.21.10.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:10:25 -0700 (PDT)
Message-ID: <372f09a9-8c1c-4af5-86a6-e286cce8af8b@gmail.com>
Date: Mon, 21 Sep 2026 18:10:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Speed up htab hashing for u32/u64 keys
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com>
 <179000542526.3934731.994864591824564797@gmail.com>
 <DLL5LJUBBBNP.K6GOQ6AV8OU0@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DLL5LJUBBBNP.K6GOQ6AV8OU0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/21/26 6:00 PM, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 3:43 PM UTC, Alexei Starovoitov wrote:
>>>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
>>>  {
>>> -	if (likely(key_len % 4 == 0))
>>> +	const u32 *k = key;
>>> +	u32 b;
>>> +
>>> +	if (key_len == sizeof(u32))
>>> +		b = 0;
>>> +	else if (key_len == sizeof(u64))
>>> +		b = k[1];
>>> +	else if (likely(key_len % 4 == 0))
>>>  		return jhash2(key, key_len / 4, hashrnd);
> 
> Nice improvement, but key_size is known at verification time.
> Let's do a step further and specialize htab_map_gen_lookup
> for small key sizes?
> 
Sure, let me try that.
