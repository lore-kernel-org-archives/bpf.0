Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2D2741DF
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548410; cv=none; b=uhAN7cfnrLvSgKhgRmq84ChQD/t63m0YJXLXdC9Q/Nn9eIZPAMzm5TROhUJ5lojDLbHAzTAQC5fI0OCd7meGKF4DdgiHW/Wk45AbvOSuKBrzxYa69lCa6Edw8u8/3uJmBv1HpA7CO2+cC2w/KjUbnx3QiG5Wt9tmtBqOEib2bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548410; c=relaxed/simple;
	bh=L7UWgZbR6WUNTCYM2+ktcecTRozSno4HeD6UtUbuOz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EGoHJhzlj+MIQZ/uKpFKtYOQAbnmaRwLs2e4l4I++fIPsDXwEBeEzwOBA97ZVsz2dBqPMX+SgaVcrdMZsGVhcmcmhTWEeHwMSdEhlaxlLwP8XtZIhSTDs0HY8gliV7RIIa+dlfWDkePufPUt9ysYOCSYJFXgMHLVJoHr4ZrcBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KLjUKGIV; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KLjUKGIV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769548396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiGEnGoweVmTyxsL2DKf2fIPpWt5tDh3VmH3bD1i63I=;
	b=KLjUKGIVKKiUgOpaKmO7R7vTimJ1GcMzFpF3pehqjITQ+8twLC/k5bWDZEGLq7bfHfUSMB
	alS/VUZiKgofs9CTbd8JrOjjSZFQfz+mKt3Dt30icS0Jjf/QkaNvUoB7eMwQDUhD0Yh+hz
	4T/rjG7S8/jIYR73JOT2XbFQcYx0Gd8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Matt
 Bobrowski <mattbobrowski@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
In-Reply-To: <aXiHok-3SKqLncCf@tiehlicka> (Michal Hocko's message of "Tue, 27
	Jan 2026 10:38:42 +0100")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-8-roman.gushchin@linux.dev>
	<aXiHok-3SKqLncCf@tiehlicka>
Date: Tue, 27 Jan 2026 21:12:56 +0000
Message-ID: <7ia4tsw6hi93.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
>> Introduce a bpf struct ops for implementing custom OOM handling
>> policies.
>> 
>> It's possible to load one bpf_oom_ops for the system and one
>> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
>> cgroup tree is traversed from the OOM'ing memcg up to the root and
>> corresponding BPF OOM handlers are executed until some memory is
>> freed. If no memory is freed, the kernel OOM killer is invoked.
>> 
>> The struct ops provides the bpf_handle_out_of_memory() callback,
>> which expected to return 1 if it was able to free some memory and 0
>> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
>> field of the oom_control structure, which is expected to be set by
>> kfuncs suitable for releasing memory (which will be introduced later
>> in the patch series). If both are set, OOM is considered handled,
>> otherwise the next OOM handler in the chain is executed: e.g. BPF OOM
>> attached to the parent cgroup or the kernel OOM killer.
>
> I still find this dual reporting a bit confusing. I can see your
> intention in having a pre-defined "releasers" of the memory to trust BPF
> handlers more but they do have access to oc->bpf_memory_freed so they
> can manipulate it. Therefore an additional level of protection is rather
> weak.

No, they can't. They have only a read-only access.

> It is also not really clear to me how this works while there is OOM
> victim on the way out. (i.e. tsk_is_oom_victim() -> abort case). This
> will result in no killing therefore no bpf_memory_freed, right? Handler
> itself should consider its work done. How exactly is this handled.

It's a good question, I see your point...
Basically we want to give a handler an option to exit with "I promise,
some memory will be freed soon" without doing anything destructive.
But keeping it save at the same time.

I don't have a perfect answer out of my head, maybe some sort of a
rate-limiter/counter might work? E.g. a handler can promise this N times
before the kernel kicks in? Any ideas?

> Also is there any way to handle the oom by increasing the memcg limit?
> I do not see a callback for that.

There is no kfunc yet, but it's a good idea (which we accidentally
discussed few days ago). I'll implement it.

Thank you!
