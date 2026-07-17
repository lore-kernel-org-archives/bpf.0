Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7063FBED9
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294358; cv=none; b=cbKHRuhalrR+nzizFQQS4N5U0Woj7mkOhKwaZlqtTRyK26/BDETW8Mhcd8u+AnncH4CrQv2nE/2j6rwTWORhSxmImU7vThwTaQBHy3j2+AtCZijYhaDAkvgNczFgJ0AnEmNEGdcJaVglgPTuj04yxx+Soa7+Z5+wblujUB7M/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294358; c=relaxed/simple;
	bh=+Bt6+Goat+FUbSO1uQ+yOgPj04WcdtNgvnfxalQE8HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLfU8aZDrlEy4j+q9PypNsTp9S6yTiZiHLQOLIgaPOs0AgkHIt9wjr776FDf0I5X3F3Pi2LuzH8x+i4fKiZwwoXk88ATwneleXeO3VYAwwfbDviF0XyKSSq7b0ZicZmC5BxO5CX+zT3FAzmtwWWKCaq8Hu3MIyf+bp+Va6zJoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrR5XkKt; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrR5XkKt"
Message-ID: <d365c74d-a8a0-4331-921b-4cb3d546590f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784294345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE2YjpJZ8eOHIiNT+EOnxdh14S4kY6fOB/FwDIqk4TU=;
	b=BrR5XkKtzzku74edaNJNiLI2odtR61mLvqAMqsQThMdX0pOC815KMoSnO/P12kNQ9wWU6x
	U1xQqoY+XMIbiZSUbbi/X9bxGY8AB8JYYwnzx184RMVLNQnksTOVnREEx2qBxvoz9CVeT/
	KBZV+uZjynxEq+jnBDWILPPI7vzeKXs=
Date: Fri, 17 Jul 2026 21:18:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for memory usage
 for arena
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
 <20260717114117.350851-5-jiayuan.chen@linux.dev>
 <20260717115336.A78DC1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260717115336.A78DC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/17/26 7:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect use of ASSERT_OK_PTR to check for a NULL pointer read from BPF userspace memory, breaking intended error handling.
> --
>
> --- Patch [4]: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for memory usage for arena ---
> commit b8bd79585d9f7cbf2a83d5381d0df2c316e65ed7
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> selftests/bpf: Add tests for memory usage for arena
>
> This patch adds a selftest to verify memory usage tracking for BPF arenas.
> It allocates and frees arena pages both from BPF and user-space and checks
> the map's memlock value via fdinfo to ensure it tracks populated pages.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
>> new file mode 100644
>> index 0000000000000..14c2d1a1d673c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
> [ ... ]
>
>> +void serial_test_arena_mem_usage(void)
>> +{
>> +	struct arena_mem_usage *skel;
>> +	const long ps = PAGE_SIZE;
>> +	char *base;
>> +	size_t sz;
>> +	int fd, i;
>> +
>> +	skel = arena_mem_usage__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_load"))
>> +		return;
>> +	fd = bpf_map__fd(skel->maps.arena);
>> +
>> +	/* Fresh arena: no data pages, and the scratch page is not counted. */
>> +	ASSERT_EQ(map_memlock(fd), 0, "initial");
>> +
>> +	/* BPF-side allocation of 17 pages. */
>> +	skel->bss->alloc_cnt = 17;
>> +	if (run(skel->progs.alloc, "alloc"))
>> +		goto out;
>> +	/*
>> +	 * A NULL ptr means bpf_arena_alloc_pages() itself failed (e.g. the host
>> +	 * is under memory pressure), not a miscount -- flag it distinctly so a
>> +	 * red CI run is not mistaken for a counting bug.
>> +	 */
>> +	if (!ASSERT_OK_PTR(skel->bss->ptr, "arena_alloc_pages"))
> [Severity: Medium]
> Will this check actually catch a NULL pointer when bpf_arena_alloc_pages()
> fails?
>
> When skel->bss->ptr is NULL, ASSERT_OK_PTR() evaluates libbpf_get_error(NULL),
> which returns -errno. Since the userspace errno is likely 0 following a
> successful bpf_prog_test_run_opts() ioctl call, ASSERT_OK_PTR silently
> evaluates to true (success).
>
> This would cause the goto out to be skipped, and the test to proceed to
> evaluate ASSERT_EQ(map_memlock(fd), 17 * ps). This subsequent check would
> then fail, emitting the exact counting bug error the comment mentions trying
> to avoid.
>
> Should this use a different macro, like ASSERT_NEQ(skel->bss->ptr, NULL), to
> correctly verify the userspace pointer?


On success ptr is a valid arena address and ASSERT_OK_PTR() passes 
correctly.

On alloc failure ptr is NULL and ASSERT_OK_PTR() may treat it as OK 
(libbpf_get_error(NULL)
returns -errno, which can be 0), but the next ASSERT_EQ(map_memlock(fd), 
17 * ps) still fails.

I can switch it to ASSERT_NEQ(skel->bss->ptr, NULL, ...) in the next 
revision.
