Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA4433BDB
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928795; cv=none; b=dzK8I3YOAJnq+CG2KVz0D5UDL4LtcqSnrfwA1kQk/V6AW2cTTBRkJyNDjvYpWtLVqqq2BHv8EiE8ZDUpbkr1EwnbucfRNTjIj+gnOA7cf/aUikSE7JrQ7e3UUkI1Q4mR9xO9mG/lWuF2GiqirCLF/b2uCymSYzYSb6VRwACKSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928795; c=relaxed/simple;
	bh=aLTzvfomwByXyEU8smjayJliRRdS33okKX+aa3Hd++Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS4Tqc3M/gr5wWHUxwmxgWq4d53zMWZQn5w1cD8NhiWcNCTStokQIRaQ8QPawYjz7BixJhYU3BwhLCVEZyl8IFwDLjLgoW8ynlHr6ODT//h8/1DSJ2C5R/ZZJ5ZQLwo/34V3BRFg84n7oAqjcRn7JDiStkCGl/P+nlG5wXcaXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F0jK8QMM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F0jK8QMM"
Message-ID: <74fddad1-fedf-4fc6-a2de-ba83a7190caa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785928780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZG92dOdfDg3hxjpfzh/S6L/2k1BlAviAVSI0u0P4pDM=;
	b=F0jK8QMMtgQrIfRSo3y1UqqEnTJ7HjROa0n/quKUD9+orIyVsEYBmarL+idgMM+gZ9nLNS
	IHFi2PMfscOm2II2fi0PK0n1Ndx3u8MdcmsBy7lrxdDX77ErUsGQrp1x03PWlIPCYnGSst
	vbaw0nHEB1oezIc1HI+MrvyqqYGHINg=
Date: Wed, 5 Aug 2026 19:18:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add a test for arena
 fault-in under memory.max
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805091720.139924-1-jiayuan.chen@linux.dev>
 <20260805091720.139924-5-jiayuan.chen@linux.dev>
 <20260805092944.5B0351F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260805092944.5B0351F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/5/26 5:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test passes on unexpected crashes because it only asserts that the termination signal is not SIGSEGV, rather than strictly expecting SIGKILL from the memcg OOM killer.
> --
>
> --- Patch [4]: [PATCH bpf-next v2 4/4] selftests/bpf: Add a test for arena fault-in under memory.max ---
> commit d5e6a0b924679b20cf7f391518ec1a560ae725e3
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> selftests/bpf: Add a test for arena fault-in under memory.max
>
> This commit adds a BPF selftest for arena fault-in under a constrained memory
> cgroup. It creates a child process to fault in an arena and verifies it is
> killed by the memcg OOM killer rather than incorrectly dying from SIGSEGV.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
>> new file mode 100644
>> index 0000000000000..ca039ebd3d674
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> [ ... ]
>> +void serial_test_arena_memcg(void)
>> +{
> [ ... ]
>> +	/*
>> +	 * Faulting a valid arena address until memory.max is hit must not look
>> +	 * like an invalid access. Without the fix the fault path allocated with
>> +	 * the non-blocking allocator, turned its -ENOMEM into VM_FAULT_SIGSEGV,
>> +	 * and the child died with SIGSEGV on a valid address; now it is handled
>> +	 * by the memcg OOM path and the child is killed by SIGKILL instead.
>> +	 */
>> +	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
>> +		goto out;
>> +	if (!ASSERT_NEQ(WTERMSIG(status), SIGSEGV, "not killed by SIGSEGV"))
>> +		dump_memcg(read_cgroup_file);
> [Severity: Medium]
> Could this mask other failures by accepting any signal other than SIGSEGV?
>
> If the child process crashes due to an unrelated issue like a libbpf internal
> assertion (SIGABRT) or an invalid memory access (SIGBUS), this assertion would
> evaluate to true and the test would silently pass.
>
> Should this explicitly expect SIGKILL from the memcg OOM killer using
> ASSERT_EQ(WTERMSIG(status), SIGKILL)?


I think checking "oom_kill" in memory.events would be more accurate.


That said, I'm not sure patches 3 and 4 are necessary, they only 
exercise the memcg behavior,

so we could drop them when merging (if the series is accepted).


Both ok for me.

