Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769939151C
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333729; cv=none; b=Uhj0n4wZavSTKaJ6H66C66dsoJrUH4eLSg4tVmzAJR2xkihAMq4W82l1FPTokirF+0z1PSkknPzUSRa8cNb+SKZX+VJnUA8mETikcHkEtlp62UIZkmVRuinK3NrQs3lTyFcvd/III0Az7WT534kdBWy7z7rPnRmJO2Caw/88GrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333729; c=relaxed/simple;
	bh=NJN8jFyfFZRC4ONzmgQwAof8r3RuQMpcMDwnyfuk9yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNh3fLdRBUYVB6GOwM4yIgNvTqEZhWM8+w5T8fcnAO+At0wp5nH6n2grW30MaRPuo5N+Jzut1e5b+cjAo75gAyHbMM/eAXU/LY0IxYiTPGao792KfARNzWnQZq6FI3Hb6ClrbiHSL8ox5THqiaX0KQhGHlA5cWV4A93QHDUJ+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYYXRq/8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYYXRq/8"
Message-ID: <a9e91c79-70f6-4f7e-a98a-12f2ef834c3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773333725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClwUXfzhLS0ZOthJ9JpXJPMGQtLbqwwgYKlMbv57QC8=;
	b=eYYXRq/8D8yFxU7Az0wFb7bdcbs3F2Onw42Nxx0d7R1rtu/EpKdgWsz3l7IKBv9vBk0Pe2
	vyj5tLCsHF6KJyFmze3zcWLMuCuKPSQK0Br4xq0y3BJ0BW2ZeshSSPyc7ywEfoC4GKqjje
	KmrfKAzHPQOye9xtU/bUUC0DAcYfw5k=
Date: Thu, 12 Mar 2026 09:41:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
To: Paul Chaignon <paul.chaignon@gmail.com>, xulang <xulang@uniontech.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, kaiyanm@hust.edu.cn,
 huyinhao@hust.edu.cn, dzm91@hust.edu.cn, kernel@uniontech.com,
 linux-kernel@vger.kernel.org
References: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
 <abKo0HZ3R_oY1BUa@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <abKo0HZ3R_oY1BUa@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/12/26 4:51 AM, Paul Chaignon wrote:
> On Thu, Mar 12, 2026 at 01:25:25PM +0800, xulang wrote:
>> From: Lang Xu <xulang@uniontech.com>
>>
>> An out-of-bounds read occurs when copying element from a
>> BPF_MAP_TYPE_CGROUP_STORAGE map to another map type with the same
>> value_size that is not 8-byte aligned.
>>
>> The issue happens when:
>> 1. A CGROUP_STORAGE map is created with value_size not aligned to
>>     8 bytes (e.g., 4 bytes)
>> 2. A HASH map is created with the same value_size (e.g., 4 bytes)
>> 3. Update element in 2 with data in 1
>>
>> In the kernel, map elements are typically aligned to 8 bytes. However,
>> bpf_cgroup_storage_calculate_size() allocates storage based on the exact
>> value_size without alignment. When copy_map_value_long() is called, it
>> assumes all map values are 8-byte aligned and rounds up the copy size,
>> leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
>>
>> This patch fixes the issue by ensuring cgroup storage allocates 8-byte
>> aligned buffers, matching the assumptions in copy_map_value_long().
> I don't think this bug is specific to the CGROUP_STORAGE maps. Wouldn't
> it affect any copy from a non-percpu map into a percpu hashmap? The
> reproducer in [1] copies from a BPF_MAP_TYPE_CGROUP_STORAGE map to a
> BPF_MAP_TYPE_LRU_PERCPU_HASH map, but I suspect you'd hit the same bug
> if copying from BPF_MAP_TYPE_HASH into BPF_MAP_TYPE_PERCPU_HASH because
> for BPF_MAP_TYPE_HASH the value size is also not rounded up to a
> multiple of 8.

The BPF_MAP_TYPE_HASH table have value size rounds up to 8. See:

         if (percpu)
                 htab->elem_size += sizeof(void *);
         else
                 htab->elem_size += round_up(htab->map.value_size, 8);

The same for array size.

>
> 1 - https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
>
>> Fixes: b741f1630346 ("bpf: introduce per-cpu cgroup local storage")
>> Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
>> Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
>> Signed-off-by: Lang Xu <xulang@uniontech.com>
>> ---
>>   kernel/bpf/local_storage.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
>> index 8fca0c64f7b1..54b32ba19194 100644
>> --- a/kernel/bpf/local_storage.c
>> +++ b/kernel/bpf/local_storage.c
>> @@ -487,14 +487,13 @@ static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
>>   {
>>   	size_t size;
>>   
>> +	size = round_up(map->value_size, 8);
>>   	if (cgroup_storage_type(map) == BPF_CGROUP_STORAGE_SHARED) {
>> -		size = sizeof(struct bpf_storage_buffer) + map->value_size;
>> +		size += sizeof(struct bpf_storage_buffer);
>>   		*pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
>>   				  PAGE_SIZE) >> PAGE_SHIFT;
>>   	} else {
>> -		size = map->value_size;
>> -		*pages = round_up(round_up(size, 8) * num_possible_cpus(),
>> -				  PAGE_SIZE) >> PAGE_SHIFT;
>> +		*pages = round_up(size * num_possible_cpus(), PAGE_SIZE) >> PAGE_SHIFT;
>>   	}
>>   
>>   	return size;
>> -- 
>> 2.51.0
>>
>>

