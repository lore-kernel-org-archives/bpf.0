Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A23A9D9F
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073589; cv=none; b=Dl0ooQFKPNFY/RsqwLtgNYXqtA5LoGQUdayAj/lSCp8V/p4ghC4VFLDA+rrbngvusmiFLxdRn1QlZbrdQ1p9VEI9pfoVtn2/AseZy638pX+uNGhofEVgbo0z7qYFrIciucXBKQn1z3xzuuMWsqtHss8PQUL3xNfIso2a6fHaklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073589; c=relaxed/simple;
	bh=sspcNoQ4slwPQOE12+2gA17gg16W0Ejp0+11LhUUDyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYT836i67lSySmavSu98D3agz+x7dktr+72/wmS3WLoxDKDyYI355jhdYEO9GJcLd14v5MXT2kD5/O1JpmN6L/oeR8DcSnjMkPlUhA+YHePylAXsBifGqG+LZx75FDtUX4zbCaUwYuM5f5gnF0Ke6SoM8fVjN/AkQlesdGd8m2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXZVGJDD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXZVGJDD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ee1a56328so2304223f8f.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073582; x=1780678382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9P6U8xei01KOGYPg5RnY31Pkhxfrb/1e+oUXDe3FXk=;
        b=MXZVGJDDF1T2WGWSjsr671XBKOSH4J5UVsgs1lVbde1E2OE9HGJt/o+B4a+qUWV3pA
         33zltPcLWEulclmsrhyscKDXlZ7mTsDi0PZhBgOs39yiF0Z9B1SrfUXdDWBaMiDtbSzz
         aHQBPHlxlvF1Ekoa6OM8R6DlhW4kEHabAhj3NVbdz4BGvosbp9PBccB0azQs5fwRMlET
         R2OyLgPS2aTDnHONCpAz5whjiiKfowYdZwe8WfyTPeiJQwcBQDv/8yqGK6PkjGMdszyX
         88Lez5UJeqV2dusyN4TZQj/60ZlbBk8ApFpXj1uDpI/udV4i1qREkVD0xmMIk/L9wan3
         0dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073582; x=1780678382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9P6U8xei01KOGYPg5RnY31Pkhxfrb/1e+oUXDe3FXk=;
        b=bIhLGQnxsQIanwrVsVEENX06Vad1A13/m+GgVgBunmcnCX+n2qBW7UJ0D2+B46AaOm
         KLwednTuWhl58PLV70nFXXQC4jwZAsIhwyjhX6n+ItSuEwlvAIWybUTh80e+/fUI/FQz
         rhLlTDAgYl2FfVdrPaNufGDpyiUFqwURzVEFwMoKrA1VxiISDfyt5hofGTBhWGrH1SH7
         xswsubCGxaIFaG0OhAanawpxZ4QufIf7OH1Hk7WHG/Sc8BITRH2cUmAnbCLgh5PTmTI3
         d+7Zwq/rfMby4mST3JNbwJlmCPw2dh9/v5NcbeOghVGg4NDnTJYV0eiH1RZlhoT1oEb7
         bUHw==
X-Gm-Message-State: AOJu0YysOuJTsFm/BexrnEfQL671czYM8wrRfxOAeMIPLkdqUB2GcZvI
	m2Tp2foLh2Htllc/yhpexM/+5gwY2eWwTajz/IvYAjwbBME8tr0dRhEV
X-Gm-Gg: Acq92OFuf3L7ZKcEJLzJtfhZydcjgG72Wpny+E/eyfLSpjsBrLYfSaahZxXrdowRoJU
	RK/eHjdwsN3sIIdHb5LefBrf3JKXOVcY8nYRVEPa5MdM8/jn8LmSXdOKwN8yywJrZ3vPDwWaQyf
	YpDbIdtH23mBOmMK2sCcn8Gw4lDtJvL7pSOr09ibfe1adzf8OxKAQplMf5QpL0Cw67fgitJPCQO
	q+AGdrq+PgOYgybD8CuCVFzx8+iieJGicQ9hFADymVTcMTTEFrKnRRkRHXLlAQokB9saApCfy2N
	fQYxV63zjZaGJBHfW8ZW0gsPaoIZlCHPPb8GXXbEzrIEG2csQy8IIJoaZjd7qEtDpdgErO0Fkl5
	LZlB/I648mdS/AZQKBzZKpWJjmnidEssGXVleNzecFOe3potxNZbqGsgWQ0zm1CZSNJM16lh7UK
	1j0H/Aq9o5oppSU50tMDYQwu0UxYWvpHdlSlOT+HZOivk4rHe3ds2Sz4qeh+kuDq5wXmepnb+Td
	KJktyJ3vBz5vKmQzxDb9Q==
X-Received: by 2002:a7b:cd92:0:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-490a293dec6mr4323945e9.19.1780073581897;
        Fri, 29 May 2026 09:53:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6eb470sm44531285e9.10.2026.05.29.09.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 09:53:01 -0700 (PDT)
Message-ID: <2d558b5a-aef1-4207-9f58-49aab3e891db@gmail.com>
Date: Fri, 29 May 2026 17:53:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 02/11] rhashtable: Add selftest for
 rhashtable_next_key()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260528-rhash-v5-2-7205191b6c57@meta.com>
 <20260528182616.65DED1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260528182616.65DED1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 7:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The selftest strictly enforces that exactly 'n' elements are visited, which violates the rhashtable_next_key() API contract and leads to spurious test failures if concurrent rehashing occurs.
> --
> 
> commit 764349a8abc231043942a78a0c94a8a3422ff178
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> rhashtable: Add selftest for rhashtable_next_key()
> 
> This commit adds a selftest for rhashtable_next_key() to verify that walking
> with a NULL prev_key visits all elements, and that providing a non-existing
> prev_key returns ERR_PTR(-ENOENT).
> 
>> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
>> index 0b33559a910b0..c7a0817b0be59 100644
>> --- a/lib/test_rhashtable.c
>> +++ b/lib/test_rhashtable.c
> [ ... ]
>> @@ -679,6 +679,76 @@ static int threadfunc(void *data)
>>  	return err;
>>  }
>>  
>> +static int __init test_rhashtable_next_key(void)
>> +{
>> +	struct rhashtable_params params = test_rht_params;
>> +	struct test_obj_val key_missing = { .id = 99999, .tid = 0 };
>> +	struct test_obj_val *prev_key = NULL;
>> +	struct rhashtable ht;
>> +	struct test_obj *objs, *cur;
>> +	int i, count = 0, err;
>> +	int visited_keys[8] = { 0 };
>> +	const int n = ARRAY_SIZE(visited_keys);
>> +
>> +	err = rhashtable_init(&ht, &params);
>> +	if (err)
>> +		return err;
>> +
>> +	objs = kcalloc(n, sizeof(*objs), GFP_KERNEL);
>> +	if (!objs) {
>> +		rhashtable_destroy(&ht);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < n; i++) {
>> +		objs[i].value.id = i;
>> +		err = rhashtable_insert_fast(&ht, &objs[i].node, params);
>> +		if (err)
>> +			goto out;
>> +	}
>> +
>> +	rcu_read_lock();
>> +
>> +	/* NULL prev_key: walk from the beginning, expect all n elements. */
>> +	while ((cur = rhashtable_next_key(&ht, prev_key, params))) {
>> +		if (IS_ERR(cur)) {
>> +			err = -EINVAL;
>> +			goto unlock;
>> +		}
>> +		count++;
>> +		prev_key = &cur->value;
>> +		visited_keys[cur->value.id] = 1;
>> +		if (count > n)
>> +			break;
>> +	}
>> +
>> +	if (count != n) {
>> +		err = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	for (i = 0; i < n; i++) {
>> +		if (!visited_keys[i]) {
>> +			err = -EINVAL;
>> +			goto unlock;
>> +		}
>> +	}
> 
> [Severity: Medium]
> Will this strict check cause spurious test failures during concurrent rehashing?
> 
> The rhashtable_next_key() API documentation explicitly warns that its walk is
> highly unstable during concurrent rehashing, stating that callers must
> tolerate skipped and duplicated elements.
> 
> This test uses test_rht_params, which inherits its nelem_hint from the
> user-provided size module parameter. If the test is executed with a small
> initial size (e.g., size=4), inserting 8 elements will cross the 75%
> threshold and trigger a background rehash by scheduling ht->run_work.
> 
> Because the test iterates over the keys immediately without waiting for this
> background work to finish (e.g., via flush_work(&ht.run_work) or by locally
> overriding nelem_hint to avoid resizing), the traversal can run concurrently
> with the rehash. This could cause rhashtable_next_key() to legitimately
> return duplicates or skip elements, causing the test to spuriously fail.
> 

the simplest solution should be to provide nelem_hint for the rhashtable.
Also the number of the elements is small, so rehash is not really expected.

> [ ... ]
> 

