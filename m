Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A036921B
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122518; cv=none; b=KHUi8PziB4Y37aspRvFg4BqaOOQUjH+PmyXiY7+leCrepb8G74yo2myFXsZx7mY96noZoS9r5FMmME9ysIYiGM3sIBvm8amwrENJ/wRYHAravZ5M9Lx7FRkhA2fJnkkdZE4adVI+DFWDJALheAV/eT12PKSoVx+iPtVYc/lR8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122518; c=relaxed/simple;
	bh=ygVkWVaIbfDe+LFX4fZNNFV3fAbM0XYWvBt8yVvI7U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJXcxtDVXVuMyh+5lZAACQjl4+05xZSrOQNl7cK0ibx4bBl0iOouj3O6xXTZurt8HZQixcyN2egmetverOERgdfuWGD1WStTHjhpjo33R9tobD1CISIP+SExRbADfYTlQYfhNiSos35jcLG557PHO/gsWg/Thw1IFwd90AQ8+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=txM8W5vR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="txM8W5vR"
Message-ID: <23d0b8c8-71bd-4c60-846c-d4abc70b9858@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781122514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUj5KgvgLFLM3JVyp6ksE4uNGu7jZoSY3Moqj4gt7ZE=;
	b=txM8W5vRgOS0CI7Q8QuJrE3UZJ5YTAmdNCeTg10jFZmHqD2FHHLz42AaFGqTmyLi2J72gq
	U65GvmlX6wWf6d1RoQwVWC1/i36evMXqDTf0w7dgZFSkYVjwsBFRFsQ0Uu7t5+zgLCC3gT
	/N8EDWtiFWQG01U+pZ1aUWegjZRPGQY=
Date: Wed, 10 Jun 2026 13:15:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover tail-call cgroup
 storage prog-array checks
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: malin89@huawei.com, ast@kernel.org, Rongzhen Cui
 <cuirongzhen@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>
References: <20260610105539.705887-1-daniel@iogearbox.net>
 <20260610105539.705887-2-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260610105539.705887-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/10/26 3:55 AM, Daniel Borkmann wrote:
> From: Lin Ma <malin89@huawei.com>
>
> Add tail-call selftests for prog-array ownership when cgroup storage
> is in use. Verify that loading succeeds when callers and callees reuse
> the owner's cgroup storage map, and that loading fails for a different
> storage map and for the A(storage) -> B(no storage) -> C(storage)
> bridge case addressed in the previous commit.
>
> Also verify that a storage-less leaf program which cannot perform tail
> calls itself is still allowed to join a storage-owned prog array, while
> a storage-less tail-caller is rejected also at map update time.
>
>    # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t tailcalls
>    [...]
>    #475/25  tailcalls/tailcall_freplace:OK
>    #475/26  tailcalls/tailcall_bpf2bpf_freplace:OK
>    #475/27  tailcalls/tailcall_failure:OK
>    #475/28  tailcalls/reject_tail_call_spin_lock:OK
>    #475/29  tailcalls/reject_tail_call_rcu_lock:OK
>    #475/30  tailcalls/reject_tail_call_preempt_lock:OK
>    #475/31  tailcalls/reject_tail_call_ref:OK
>    #475/32  tailcalls/tailcall_sleepable:OK
>    #475/33  tailcalls/tailcall_cgrp_storage:OK
>    #475/34  tailcalls/tailcall_cgrp_storage_diff_storage:OK
>    #475/35  tailcalls/tailcall_cgrp_storage_no_storage:OK
>    #475/36  tailcalls/tailcall_cgrp_storage_no_storage_leaf:OK
>    #475/37  tailcalls/tailcall_cgrp_storage_no_storage_bridge:OK
>    #475     tailcalls:OK
>    Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

