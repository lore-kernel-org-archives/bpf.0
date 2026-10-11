Received: from mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E72FFF8D
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692926; cv=none; b=KTqjMv2jEFAio8ZD2OsN06mUC7aj5gjjlSL+Zv3ml5pzpDXgtxNOsO4g8H7O6pGnbw3bWNxjYCRl3ilyVFVxBryS/BbZnPAuA3NdyGRAUVEsboPdGaAkQLnOweG2OvgAV5tsdWPeFbvGM9WTctMd+pyz51xPiczXCsirYPFdOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692926; c=relaxed/simple;
	bh=oWfUT88ZOBjq8dRh0lwJrPuh9l3/thyYC3pPZq9Dy68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMkPBOxhRZQzhS/wyeJmG1CihZKm2IYX4KhuKVfAl4lp4FHdTFQUHk1mql6Xn1y0AxULw39bX6wKUWoytBDqzJnrQehm1RJrRbBtOzlg9+Hu5gpBjq9jZVzbGsL6Q08zu+cIOrDFj9xgIf79sJoH8KISFUeX2CWiaRONj1IAcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=knPtv1fe; arc=none smtp.client-ip=91.218.175.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="knPtv1fe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oWfUT88ZOBjq8dRh0lwJrPuh9l3/thyYC3pPZq9Dy68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791692922; v=1; x=1792297722;
 b=knPtv1fePRY9gnamK2oRYnxoeynwkFmDUtGEV6kZYxW1RdcuQHuszkfmSk00gRGYIjZSowRF
 db7pw+WgzH22V228pLW3qtsM6Wy+/DIAKzlZH15VRdlXNmd6lIQEksc9iA4hxNvjkkcc54pq0Sk
 DhIOTmhvU2A6EeYCkum0nOJY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de44eda3b754d562;
	Sun, 11 Oct 2026 04:28:41 +0000
X-Mizu-Trace-ID: de44eda3b754d562
X-Migadu-Flow: FLOW_OUT
Message-ID: <44b54799-6cab-4bcd-bce9-d8d55517a7a2@linux.dev>
Date: Sun, 11 Oct 2026 09:58:37 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing: fgraph: fix the quadratic shadow stack walk
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20261001102909.1152572-1-vineet.gupta@linux.dev>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261001102909.1152572-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 15:59, Vineet Gupta wrote:
> alloc_retstack_tasklist() assigns a shadow stack to every thread when
> fgraph is enabled. It did so FTRACE_RETSTACK_ALLOC_SIZE (32) tasks at a
> time, and since for_each_process_thread() has no cursor, every sweep
> restarted from init_task and re-walked the tasks already served, making
> the ftrace_graph_active 0 -> 1 transition quadratic in the thread count.
> On a 60-core Sapphire Rapids machine with 400000 idle threads it took
> 227 s, inside a single bpf() syscall for the kprobe_multi case.
>
> Allocating inline with GFP_NOWAIT removes the batching: a single sweep
> serves every task, 227 s -> 0.092 s.
>
> v1: https://lore.kernel.org/all/20260922225526.1554758-1-vineet.gupta@linux.dev/
> v2: https://lore.kernel.org/all/20260929005411.4105448-1-vineet.gupta@linux.dev/
>
> Changes since v2:
>   - update the stale alloc_retstack_tasklist() comment, which still
>     described the old batch-of-32 behaviour (bot+bpf-ci)
>
> Sashiko flagged the mix of goto-based cleanup and scoped_guard() in
> this function. Peter and Andrii both considered it fine as is, so it
> is unchanged:
> https://lore.kernel.org/all/20260929080346.GR4120091@noisy.programming.kicks-ass.net/
>
> Changes since v1:
>   - replace both v1 patches with Peter's inline GFP_NOWAIT approach,
>     which removes the quadratic behaviour rather than dividing it by a
>     constant. With a single sweep there is no retry loop left, so the
>     v1 cond_resched() patch has nothing to attach to and is dropped.
>   - comment why returning from inside scoped_guard() skips the free
>     loop safely
>
> Vineet Gupta (1):
>    tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
>
>   kernel/trace/fgraph.c | 44 ++++++++++++++++++++++++++++---------------
>   1 file changed, 29 insertions(+), 15 deletions(-)

Gentle ping !

I appreciate folks might still be on the way home and the mayhem of 
merge window.

Thx,
-Vineet
