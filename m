Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B72396565
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439258; cv=none; b=bUTdXKKjGH8FR7NXDaibd462NB4d4ITaIzsoVlFolj+c3+ZM6l6Ox2MW5eNhN6L4KThCPg0hrPE5XJWaTABNlfOXy4rqAJhL0tKQiYqFE1CDShq9kWmoEBoAH67ACB9o8dXa3OH/YfZobCpMcSVwClJhUk7PKLSeO4j3Q3cyqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439258; c=relaxed/simple;
	bh=9CFMJ7nJx4O/vdalSPbDs5CClk+n9+N6OmL1AZpCMEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRrgU8+rnuxrUj6Nb8qXxV6xHRvznEAqjD+XARUQmaE1ZcjMke75bcrIxenUJVH6iXYzIx+joe6Wp632FfzXmA4vYOaxqBn4Ml4w/uP9YAGbGcRyAow2+mXo9hN/Yco75KgSm+Qkm6bWuKD+IE5eR7btTgMe5Ax+ZXbHhVVmm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UsTx0SWj; arc=none smtp.client-ip=91.218.175.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UsTx0SWj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9CFMJ7nJx4O/vdalSPbDs5CClk+n9+N6OmL1AZpCMEY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789439254; v=1; x=1790044054;
 b=UsTx0SWj1KBtKZqGTtMtEjpmv8lexkzYPrwhXDLu+IgGYgYk6gz2HKmungsJZwB/19Qrz+IW
 YSNxh9DUm0r04x8vI0kLfV0FG6vIx2+RcB9ImOtARnB4zgxkr0gRT+OZMfOC5y3C4RB/I6NGSEZ
 gDzEfyQewfc9EpYll41rWaaw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50ddf060bd552abd;
	Tue, 15 Sep 2026 02:27:34 +0000
X-Mizu-Trace-ID: 50ddf060bd552abd
X-Migadu-Flow: FLOW_OUT
Message-ID: <2c54e00b-a01c-4400-acbd-f614c457cf92@linux.dev>
Date: Tue, 15 Sep 2026 10:27:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Compute map size of light skeletons
 at runtime
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260914153326.72498-1-leon.hwang@linux.dev>
 <c4f9dcfb3827ef826df36d4ed7d12d78694989fd6a6843967c094b8e879b2574@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c4f9dcfb3827ef826df36d4ed7d12d78694989fd6a6843967c094b8e879b2574@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/9/26 00:39, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
>> index 1f3f332dffbe..6f23ea9410eb 100644
>> --- a/tools/lib/bpf/skel_internal.h
>> +++ b/tools/lib/bpf/skel_internal.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/bpf.h>
>>  #else
>>  #include <unistd.h>
>> +#include <sys/param.h>
>>  #include <sys/syscall.h>
>>  #include <sys/mman.h>
>>  #include <linux/keyctl.h>
> 
> [ ... ]
> 
>> @@ -193,25 +197,34 @@ static inline void skel_free(void *p)
>>  	free(p);
>>  }
>>
>> -static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
>> +static inline size_t skel_map_mmap_sz(size_t val_sz, __u32 max_entries)
>>  {
>> -	munmap(p, sz);
>> +	return roundup(roundup(val_sz, 8) * max_entries, sysconf(_SC_PAGE_SIZE));
>>  }
> 
> This isn't a bug, but would it read closer to array_map_mmap_sz() to hoist
> the page size into a local here? sysconf(_SC_PAGE_SIZE) is passed straight
> into roundup()'s second argument, and roundup() is a macro that expands its
> second argument several times in the non-constant case. The three nearby
> equivalents all hoist it: the bpf_map_mmap_sz() this patch deletes from
> gen.c used 'long page_sz = sysconf(_SC_PAGE_SIZE);', and libbpf's
> array_map_mmap_sz() and bpf_map_mmap_sz() both open with 'const long page_sz
> = sysconf(_SC_PAGE_SIZE);'. Hoisting it here would also make the helper
> independent of which roundup() definition wins, and might let the new
> <sys/param.h> include be dropped.

Good catch.

'sysconf(_SC_PAGE_SIZE)' will be calculated several times in
'roundup(roundup(val_sz, 8) * max_entries, sysconf(_SC_PAGE_SIZE))'.

printf '%s\n' \
  '#include <sys/param.h>' \
  'roundup(roundup(val_sz, 8) * max_entries, sysconf(_SC_PAGE_SIZE))' |
gcc -E -P -x c - |
tail -n 1

(__builtin_constant_p (sysconf(_SC_PAGESIZE)) &&
((((sysconf(_SC_PAGESIZE)) - 1) & (sysconf(_SC_PAGESIZE))) == 0) ?
((((__builtin_constant_p (8) && ((((8) - 1) & (8)) == 0) ? (((val_sz) +
(8) - 1) & ~((8) - 1)) : ((((val_sz) + ((8) - 1)) / (8)) * (8))) *
max_entries) + (sysconf(_SC_PAGESIZE)) - 1) & ~((sysconf(_SC_PAGESIZE))
- 1)) : (((((__builtin_constant_p (8) && ((((8) - 1) & (8)) == 0) ?
(((val_sz) + (8) - 1) & ~((8) - 1)) : ((((val_sz) + ((8) - 1)) / (8)) *
(8))) * max_entries) + ((sysconf(_SC_PAGESIZE)) - 1)) /
(sysconf(_SC_PAGESIZE))) * (sysconf(_SC_PAGESIZE))))

Will hoist 'sysconf(_SC_PAGE_SIZE);' and 'roundup(val_sz, 8) * max_entries'.

However, the new <sys/param.h> is needed for roundup().

Thanks,
Leon

> [...]

