Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A442D3A69
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718314; cv=none; b=q39uyehZwga2OJjwxtIo7OYedUmMe5kK3t1QKrf+jeGPQ7OQa5pUIHNB8oCV56O2JIVzeWBIxEDZaLZ8i0i7J9j5950pGS61r+dNXrTv+IKkTejj2u6EVsEhkFngY/686mHbVHUtOyv2Jkrepx5jQwsvAOYRpEau3N9kukyQrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718314; c=relaxed/simple;
	bh=OEoIxi0GIIXzHNo+sitwf64Y7auwxVmC7N9xy7C0zBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfccSPYuebEPUJ282IJTTjxmAs5lA4ugxOj2q13uFjGVmyOxVRuIz4HqPOrCPbNCmgZb11ROfg2vyBAbJap8PLpdUaBKA8bL2N8GWnDIM6muVthvfuq865MSO6u0UvIiQvkVPh840jpOEQlAqRlXJnxRhcP63hAm+yfK7YH8kjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bm3riK5V; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bm3riK5V"
Message-ID: <b7114d6f-989f-49e1-918f-3bdf9d319624@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780718300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Agl+Zv2W56VjUDH6mhAKCavu7dinG363UWIQgopHFiA=;
	b=Bm3riK5VR+DtIGjlGcVYK1e8UrGAKkU6dPmhuwn0oS9yoV8k0ZR71CNe+ut6K5maoWd3Q8
	/Vsbfw1gUSfAwMPcY+6BonavJ+YT+FKxOUwj303fQQIut2z/tcEPZhN2XmjISd0z/Ukvno
	1sdgHoCx+iVUf5Us/YZ0FSzvQENOBwM=
Date: Fri, 5 Jun 2026 20:58:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] bpf: Tighten cgroup storage cookie checks for prog
 arrays
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, Lin Ma <malin89@huawei.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 YiFei Zhu <zhuyifei@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amery Hung <ameryhung@gmail.com>, Rongzhen Cui <cuirongzhen@huawei.com>,
 Jingguo Tan <tanjingguo@huawei.com>, cenxianlong@huawei.com,
 chenzhe@huawei.com
References: <20260604070318.2869813-1-malin89@huawei.com>
 <a8342b94-9732-4878-b794-086106c93585@linux.dev>
 <86dac3e9-3af2-4bc6-93e5-d62aa70fb362@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <86dac3e9-3af2-4bc6-93e5-d62aa70fb362@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/5/26 4:16 PM, Daniel Borkmann wrote:
> On 6/4/26 6:56 PM, Yonghong Song wrote:
>> On 6/4/26 12:03 AM, Lin Ma wrote:
>>> The recent KCTF-reported cgroup local storage issue assigned
>>> CVE-2025-38502 was fixed by commit abad3d0bad72 ("bpf: Fix oob access
>>> in cgroup local storage").
>>>
>>> However, the previous fixes are still incomplete. The current 
>>> prog-array
>>> compatibility check treats a program with no cgroup storage as
>>> compatible with any stored storage cookie. This allows a storage-less
>>> program to bridge a tail-call chain between an entry program and a
>>> storage-using callee even though runtime cgroup local storage still
>>> follows the caller context.
>>>
>>> Require exact per-type storage_cookie equality when checking prog-array
>>> compatibility. This blocks zero-storage bridge programs from joining a
>>> prog-array owned by a storage-using program and closes the residual
>>> A -> B(no storage) -> C(storage) path.
>>>
>>> This also aligns with Amery Hung's earlier NULL-storage tail-call 
>>> fix by
>>> requiring storage use to match consistently across prog-array users.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")
>>> Tested-by: Amery Hung <ameryhung@gmail.com>
>>> Signed-off-by: Lin Ma <malin89@huawei.com>
>>> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
>>> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> Sorry for jumping in late, but I would have an alternative suggestion 
> below:
>
>>> v1: 
>>> https://lore.kernel.org/bpf/20260601095158.1186318-1-malin89@huawei.com/ 
>>>
>>> v1 -> v2:
>>>   - refine the commit message and mention the relation to Amery Hung's
>>>     NULL-storage tail-call fix
>>>   - add patch 2/2 selftests for tail-call cgroup storage prog-array
>>>     checks
>>> v2: 
>>> https://lore.kernel.org/bpf/31927f33-9db0-4a39-b38a-72b33487979e@linux.dev/T/#t
>>> v2 -> v3:
>>>   - use abad3d0bad72 as the Fixes tag
>>> v3: 
>>> https://lore.kernel.org/bpf/7b3e1adae5c92153e991ac406b2d334609c36d866b5bf81e4465cf63bde0a79c@mail.kernel.org/T/#t
>>> v3 -> v4:
>>>   - no changes
>>> ---
>>>   kernel/bpf/core.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 6aa2a8b24030..f0b61b10f30e 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -2470,8 +2470,12 @@ static bool __bpf_prog_map_compatible(struct 
>>> bpf_map *map,
>>>                   break;
>>>               cookie = aux->cgroup_storage[i] ?
>>>                    aux->cgroup_storage[i]->cookie : 0;
>>> -            ret = map->owner->storage_cookie[i] == cookie ||
>>> -                  !cookie;
>>> +            /*
>>> +             * Tail calls keep using the caller cgroup storage
>>> +             * context, so prog-array members must use the same
>>> +             * storage cookie.
>>> +             */
>>> +            ret = map->owner->storage_cookie[i] == cookie;
>
>
> This would basically break if the leaf program does not use cgroup 
> storage.. can
> you please try out the below diff ... rationale: this would allow A -> 
> B(no storage)
> but reject the A -> B(no storage) -> C(storage) case:
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a656a8572bdb..649cce41e13f 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2481,7 +2481,7 @@ static bool __bpf_prog_map_compatible(struct 
> bpf_map *map,
>                         cookie = aux->cgroup_storage[i] ?
> aux->cgroup_storage[i]->cookie : 0;
>                         ret = map->owner->storage_cookie[i] == cookie ||
> -                             !cookie;
> +                             (!cookie && !aux->tail_call_reachable);
>                 }
>                 if (ret &&
>                      map->owner->attach_func_proto != aux->attach_func_proto) {

I just tried. All tests (including patch v4) passed. Your patch indeed
preserves the leaf prog (last one in the chain). Thanks!

