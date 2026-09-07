Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F530EF8F
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751086; cv=none; b=lc6TC/q5TbI/0RxnuRSjVPB/iHKDF3ztOcWTfG4cp6XMA8dbj06ICDOTFEtf+wLigU6ymqBHszd+6dHCqu3K3ju7x7JLPPeUW48q5PeJDUw6cYaSnvM3HY9F3wbGRgKeGh0rgyDpOCymhpYQNrE8+pT1PytsA3p+hCJkBiy7O04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751086; c=relaxed/simple;
	bh=4NwIip7/KPKLo7TJlw7Cq9K17+JHbn+jGgJ7eRNJyU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h63oiVTS4HvkVoODy58VtOEt3nOSZsuK+VUl+9Wi3ATgQLaLVSsA9t4QcsmNzxIHXV/TQcA9gtYcFGTk/5X7kypCChH78g9mcOyZSP1ZLaD5q8f+a3h0wJ5UPtrL/TpJnaj9D4EfTqP4vEJdcQLy6Nn3VrtbtrNefq5RELQU1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XoH3rQxV; arc=none smtp.client-ip=95.215.58.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XoH3rQxV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4NwIip7/KPKLo7TJlw7Cq9K17+JHbn+jGgJ7eRNJyU0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788751080; v=1; x=1789355880;
 b=XoH3rQxVvtuIH7YZpNDAHgio5/F4WQsDsrj8RjgmAC10i7CcIlUmwP8bUuqy+LE3zPIcbj04
 IYLPnM5exsQpB6aWrbShgAicYDAcFxlT0NrwXT9CkxeMUCHSBGE+86fLTrj/ZsT+fVqzdHni+bQ
 1eKKrZXMfRktIHDLCqB1UHQs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 557dbd025e9566f7;
	Mon, 07 Sep 2026 03:17:50 +0000
X-Mizu-Trace-ID: 557dbd025e9566f7
X-Migadu-Flow: FLOW_OUT
Message-ID: <4525fdf8-def6-4f24-abe8-1948eab54d6e@linux.dev>
Date: Mon, 7 Sep 2026 11:17:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH bpf-next v7 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn
 <inwardvessel@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1788516769.git.zhuhui@kylinos.cn>
 <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
 <20260904110308.4473cde499e91aab14dbd5fc@linux-foundation.org>
 <DL7CEX9EX781.23V26M3600JEI@gmail.com> <apxB5tyglnSbqmEu@linux.dev>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <apxB5tyglnSbqmEu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> On Sat, Sep 05, 2026 at 01:23:39PM +0200, Kumar Kartikeya Dwivedi wrote:
>> On Fri Sep 4, 2026 at 8:03 PM CEST, Andrew Morton wrote:
>>> On Fri,  4 Sep 2026 18:20:19 +0800 "Hui Zhu" <hui.zhu@linux.dev> wrote:
>>>
>>>> @@ -159,6 +160,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>>>>   	mem_cgroup_flush_stats(memcg);
>>>>   }
>>>>
>>>> +/*
>>>> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
>>>> + * current->reclaim_state, so a nested call would corrupt the outer
>>>> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
>>>> + * reclaim_state is also checked because it is installed slightly
>>>> + * before PF_MEMALLOC.
>>>> + */
>>>> +static bool bpf_in_reclaim_context(void)
>>>> +{
>>>> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
>>>> +}
>>>> +
>>> Would life improve if try_to_free_mem_cgroup_pages() didn't do that?
>>> If try_to_free_mem_cgroup_pages() (or some variant of it) were to
>>> permit nesting?
>>>
>>> 	rs = new_thing(current, &sc.reclaim_state);
>>> 	...
>>> 	set_task_reclaim_state(current, rs);
>>>
>> My understanding is that given the current restrictions on where this kfunc can
>> be called, this is mostly a defensive and shouldn't be firing (?). Given that,
>> we can probably revisit this when such reentrancy is necessary, even though I
>> doubt it would be the case in the future. It will at most be invoked from a wq
>> callback or a kthread, so should be fine.
>>
> If with the current restrictions, this recursion can not happen then let's not
> add this check here. We never want recursion/reentrancy here.

Will remove it in the next version.

Best,
Hui

