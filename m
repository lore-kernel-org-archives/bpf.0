Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95031214A9B
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067838; cv=none; b=GHd6Khepj9rCb2ZMZ0Lsl0DebUB0+4ruodnJuM9Y5ddxB7JyE74LGDRri2nsm9M4wZjGmUjNRF0fxB1cGeURNywj9Cye5ETxyZ75SBulOuNAA2f94YU92q1wdarTGUR+ATdll0qdYyW6IFFpkiPLNbHChMI5QSw/elFsvnLWG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067838; c=relaxed/simple;
	bh=blN4bEAPNe1K0Ioz3u5M44VuB6ehn+I0XkVx1Bjc2ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXIiNQHXFfrJ4t6NNCQ7eutDn5s4W8Gjk/nFyHBiqBdM0QVCnbeAf5q13MvFgQKA6PeZ0W6vvYnxxAqBXBRlMRvUlcTpsdLZ7KnYeOBg6Qw3bjInA+lLz66Fz1I9EIxKkcK9/ORcpzcGH2gm2T0FvnIQVErDK1ZazbQUT7Dvkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGZlPqZA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGZlPqZA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so65785075e9.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067835; x=1776672635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU8P2JETl6nf7rFzjnnYyncnk6MgTuYU7HjNQEaAMc4=;
        b=VGZlPqZAIsJ4lqUmDhkShvlmLNL+mItsgo8s2Rsff4CNqW0TV1vKurYweQ3riNcGyu
         bq9qDdEFDqbILn+IDRXHIpKJxIKOGUVbRqk1bcsqqlxG8mE3rRYhLn5rw0JAkxzTOs0Y
         6HC1v10CsP6OJKNzhhrgcM23LZNTaxaTauPf+MMDBtv85rwYFBMYz8f5AMnrIiXv2h2B
         bRs9l3huGgZE0uxaWihpo+aWsqg3I/dMVHr+qGSJ8Bj0Itl5zVX1F+YOvNb/1xqbacRr
         2kRAvL3hPHAApTQ1w9y6fU834EjvydpF9klisX9l9KTKbAMBKXo9A4FqtR4bwXiwIG8f
         LDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067835; x=1776672635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU8P2JETl6nf7rFzjnnYyncnk6MgTuYU7HjNQEaAMc4=;
        b=L1Vhelce8RDu+Wb5uNYsslmFs0RqdkYL/4IJZcu3ykCykPSZdCoT/dmlkUAzwY79G6
         7Z+1jVLPO64dpcJuH+rv0XW8Plx0vKxAqt8udWmw5pWeZ5I2e6Gtsrjd4ycD4XcF4iep
         niItwSuuNVaBbjHF2fZbQAVEqnwWWryPjEW/wz8jetSkzLrgV3ygH9H3AQyc5GmMoQAD
         VFSIt823c/W4Z0SArcxNNudFcXugCU1HBki7iRdoX+tEBhM1Yf8NW3lQMI+vxnZJkZnF
         UCKdhZUf1aEmKeMTMN87hpW9wM1DQyvwTI98Vki6F5JzAoeXj0In1tUuBU4WH59EYq9R
         YG4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/QYWNMMWlz0YBGVjw+4IE4ofWAY2kYRCASeMX7QxDj4RSeICWD75XRc4IeNl3Z0TKVtu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6HOGpx8vGdfcbZmXu4bFm9Xr2b+hmKV9b0G9YI7oMZDISUcYU
	wjlIw+HG5v/31U2Ne819K4ZH31VsREtyceYzysvvGpfpK2zOjmOhYJO3v286KHAP
X-Gm-Gg: AeBDievASc7JYf8XPark6ul7srcCXZp2Ly9RsNWiC01o54gkVNFdZ57hJhxyX8Zezht
	5oZHT5r8+9D2aOrd1gX5ULP3g6o+Y14wEyY0HoHzaQT2o0/TE9dt/Mazrampk+Q+s9r7tBffaXL
	WH0/efD5tmAmidtJ0HemiiYhUm0GkmI2qYifjBkYbfqGv7QPmAiyOlxWcqbpYvkUgpfFDl3YzKB
	PLC9pIF3+PdQGMxs1SOrH5emNWMAiMTkUd2ahC1jx2YWqi6WfKgz/8ZSM1u61ppvbAgWIk/uFyf
	O7ZwYOIw9KcZXTD+j+WZjKAjKMsiiPzNQ3x9gaJ7TZ8IEVSbqi7P3G+BoMHt/m1jUnYcxFVmpq/
	j8nNF3usayuPlrVVv8QCsP4dQS6OcRuO/YHuz4GEBstDrlcrfL9Z+2152NfZ522gIKE0U6sJX6W
	CtQOkU2yue3ZZ9UI1Br34POl5X9QZLzfnp41Ma2sGYZrGOrz9ILUsQP2336zn1E5dzPyMa4AWaB
	1cEh/WxlyZLrO8tZV+jOA==
X-Received: by 2002:a05:600c:3149:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-488d68431f6mr170271085e9.17.1776067834827;
        Mon, 13 Apr 2026 01:10:34 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:1086:f5f1:32fc:93b3? ([2a02:8109:a307:d900:1086:f5f1:32fc:93b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d53808b2sm339849805e9.11.2026.04.13.01.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 01:10:34 -0700 (PDT)
Message-ID: <0f4b66fd-4e50-43af-a952-4a0f615e6377@gmail.com>
Date: Mon, 13 Apr 2026 09:10:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 01/18] bpf: Register rhash map
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-1-3b3675da1f6e@meta.com>
 <DHPTXQZL4ERG.3QCBWTRWKFNN@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHPTXQZL4ERG.3QCBWTRWKFNN@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/26 11:31 PM, Emil Tsalapatis wrote:
> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add resizable hash map into enums where it is needed.
>>
> 
> These changes in isolation are difficult to reason about,
> can we roll this into subsequent patches? Right now this
> adds a the BPF_MAP_TYPE_RHASH without there being a way
> to create one.
> 

Thanks for taking a look, makes sense, I can squash it into the latter 
commits.

>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/uapi/linux/bpf.h       | 1 +
>>   kernel/bpf/map_iter.c          | 3 ++-
>>   kernel/bpf/syscall.c           | 3 +++
>>   kernel/bpf/verifier.c          | 1 +
>>   tools/include/uapi/linux/bpf.h | 1 +
>>   5 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 552bc5d9afbd..822582c04f22 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1046,6 +1046,7 @@ enum bpf_map_type {
>>   	BPF_MAP_TYPE_CGRP_STORAGE,
>>   	BPF_MAP_TYPE_ARENA,
>>   	BPF_MAP_TYPE_INSN_ARRAY,
>> +	BPF_MAP_TYPE_RHASH,
>>   	__MAX_BPF_MAP_TYPE
>>   };
>>   
>> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
>> index 261a03ea73d3..4a2aafbe28b4 100644
>> --- a/kernel/bpf/map_iter.c
>> +++ b/kernel/bpf/map_iter.c
>> @@ -119,7 +119,8 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>>   		is_percpu = true;
>>   	else if (map->map_type != BPF_MAP_TYPE_HASH &&
>>   		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
>> -		 map->map_type != BPF_MAP_TYPE_ARRAY)
>> +		 map->map_type != BPF_MAP_TYPE_ARRAY &&
>> +		 map->map_type != BPF_MAP_TYPE_RHASH)
>>   		goto put_map;
>>   
>>   	key_acc_size = prog->aux->max_rdonly_access;
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 51ade3cde8bb..0a5ec417638d 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1287,6 +1287,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>   			case BPF_SPIN_LOCK:
>>   			case BPF_RES_SPIN_LOCK:
>>   				if (map->map_type != BPF_MAP_TYPE_HASH &&
>> +				    map->map_type != BPF_MAP_TYPE_RHASH &&
>>   				    map->map_type != BPF_MAP_TYPE_ARRAY &&
>>   				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
>>   				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
>> @@ -1464,6 +1465,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
>>   	case BPF_MAP_TYPE_CGROUP_ARRAY:
>>   	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>>   	case BPF_MAP_TYPE_HASH:
>> +	case BPF_MAP_TYPE_RHASH:
>>   	case BPF_MAP_TYPE_PERCPU_HASH:
>>   	case BPF_MAP_TYPE_HASH_OF_MAPS:
>>   	case BPF_MAP_TYPE_RINGBUF:
>> @@ -2199,6 +2201,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>   		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>>   		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
>>   		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>> +		   map->map_type == BPF_MAP_TYPE_RHASH ||
>>   		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
>>   		if (!bpf_map_is_offloaded(map)) {
>>   			bpf_disable_instrumentation();
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8c1cf2eb6cbb..53523ab953c2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -21816,6 +21816,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>>   	if (prog->sleepable)
>>   		switch (map->map_type) {
>>   		case BPF_MAP_TYPE_HASH:
>> +		case BPF_MAP_TYPE_RHASH:
>>   		case BPF_MAP_TYPE_LRU_HASH:
>>   		case BPF_MAP_TYPE_ARRAY:
>>   		case BPF_MAP_TYPE_PERCPU_HASH:
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 677be9a47347..9d7df174770a 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1046,6 +1046,7 @@ enum bpf_map_type {
>>   	BPF_MAP_TYPE_CGRP_STORAGE,
>>   	BPF_MAP_TYPE_ARENA,
>>   	BPF_MAP_TYPE_INSN_ARRAY,
>> +	BPF_MAP_TYPE_RHASH,
>>   	__MAX_BPF_MAP_TYPE
>>   };
>>   
> 

