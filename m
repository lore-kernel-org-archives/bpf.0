Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3122C11FA;
	Fri,  5 Jun 2026 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701389; cv=none; b=sWku8KR7lrBPb+YnHLyh7Xujoi4fnGrQqy6Z6boG8XlIN6HNKb6GYtsHJbLFqzfl7wTYFT5qFwhkkQC9DOBYc+DE+8dZaNLRf9n4voqvrhmv27cCAzy9WJ9YhGtL77RzBw34D5gic7vfFvsk7Cr/XApSgdE5lAgiUrJAqcPsp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701389; c=relaxed/simple;
	bh=gQGySES0/R9bwLqBmWPp5WtmF2QZNfMif19YoTUhDK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0JROpUd5N9vAs80L/8mbJDHF2FzEh9sbkWDIiYcHmbF4hIRGnLU9hpyfqxqqhL42fWh4KaSUSYg2JRUduFnaXmPGsk9mfAZFiRps2YRP+fYIekYxGCBXxCN9ooZF9+LlYdX0K48eoKy1ne9ld/ovaJKTCRk4eIwnJDjheztxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=U+1FsSiu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="U+1FsSiu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=diHokLLXxZ0eJl/6IHV4bvHqGhVfhG1QOvKnVgiH0ns=; b=U+1FsSiu0oirvdztQUQfSvw1tS
	n1mZbV7OMIVJuMfwaUCsPI2PN5HKMFOefgg94OTemyq4WMvupClDz/phjzyM3VlRvNUEPs6SaaNMS
	xF2f1vY9KHt4YGUzeqaTNUA6UioHJCi9pcM/1M7TlIBobtj+lzLvfdn3pubtnSkAOV6uo3VWp1gnq
	3b1cVFrbI2laQ8WUyo4kGPMVYa/zR1idKQ5SsC4E4CBA3PESBTSoEZynU13cmbnuv83/zQr2yAx3O
	ChRpXO584sDawASmNxmbSxIJY9qtli7qLwiD8ksSeo01Ujb/XpxlL+5egvKqk6q/ebF1UwNf3JpnX
	tOXvGTtw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wVdly-000FbV-17;
	Sat, 06 Jun 2026 01:16:18 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wVdlx-000NHy-2K;
	Sat, 06 Jun 2026 01:16:17 +0200
Message-ID: <86dac3e9-3af2-4bc6-93e5-d62aa70fb362@iogearbox.net>
Date: Sat, 6 Jun 2026 01:16:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] bpf: Tighten cgroup storage cookie checks for prog
 arrays
To: Yonghong Song <yonghong.song@linux.dev>, Lin Ma <malin89@huawei.com>,
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
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <a8342b94-9732-4878-b794-086106c93585@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28022/Fri Jun  5 08:25:05 2026)

On 6/4/26 6:56 PM, Yonghong Song wrote:
> On 6/4/26 12:03 AM, Lin Ma wrote:
>> The recent KCTF-reported cgroup local storage issue assigned
>> CVE-2025-38502 was fixed by commit abad3d0bad72 ("bpf: Fix oob access
>> in cgroup local storage").
>>
>> However, the previous fixes are still incomplete. The current prog-array
>> compatibility check treats a program with no cgroup storage as
>> compatible with any stored storage cookie. This allows a storage-less
>> program to bridge a tail-call chain between an entry program and a
>> storage-using callee even though runtime cgroup local storage still
>> follows the caller context.
>>
>> Require exact per-type storage_cookie equality when checking prog-array
>> compatibility. This blocks zero-storage bridge programs from joining a
>> prog-array owned by a storage-using program and closes the residual
>> A -> B(no storage) -> C(storage) path.
>>
>> This also aligns with Amery Hung's earlier NULL-storage tail-call fix by
>> requiring storage use to match consistently across prog-array users.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")
>> Tested-by: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Lin Ma <malin89@huawei.com>
>> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
>> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Sorry for jumping in late, but I would have an alternative suggestion below:

>> v1: https://lore.kernel.org/bpf/20260601095158.1186318-1-malin89@huawei.com/
>> v1 -> v2:
>>   - refine the commit message and mention the relation to Amery Hung's
>>     NULL-storage tail-call fix
>>   - add patch 2/2 selftests for tail-call cgroup storage prog-array
>>     checks
>> v2: https://lore.kernel.org/bpf/31927f33-9db0-4a39-b38a-72b33487979e@linux.dev/T/#t
>> v2 -> v3:
>>   - use abad3d0bad72 as the Fixes tag
>> v3: https://lore.kernel.org/bpf/7b3e1adae5c92153e991ac406b2d334609c36d866b5bf81e4465cf63bde0a79c@mail.kernel.org/T/#t
>> v3 -> v4:
>>   - no changes
>> ---
>>   kernel/bpf/core.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 6aa2a8b24030..f0b61b10f30e 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2470,8 +2470,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>>                   break;
>>               cookie = aux->cgroup_storage[i] ?
>>                    aux->cgroup_storage[i]->cookie : 0;
>> -            ret = map->owner->storage_cookie[i] == cookie ||
>> -                  !cookie;
>> +            /*
>> +             * Tail calls keep using the caller cgroup storage
>> +             * context, so prog-array members must use the same
>> +             * storage cookie.
>> +             */
>> +            ret = map->owner->storage_cookie[i] == cookie;


This would basically break if the leaf program does not use cgroup storage.. can
you please try out the below diff ... rationale: this would allow A -> B(no storage)
but reject the A -> B(no storage) -> C(storage) case:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a656a8572bdb..649cce41e13f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2481,7 +2481,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
                         cookie = aux->cgroup_storage[i] ?
                                  aux->cgroup_storage[i]->cookie : 0;
                         ret = map->owner->storage_cookie[i] == cookie ||
-                             !cookie;
+                             (!cookie && !aux->tail_call_reachable);
                 }
                 if (ret &&
                     map->owner->attach_func_proto != aux->attach_func_proto) {

