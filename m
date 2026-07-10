Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46595329C60
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661549; cv=none; b=BsCguVXfvhKBNvKbOCPyQfxjcxEaUwBmhOXYZlkpzVc9M/+5Spy1njes+9nqbksxdmKFNjjvLYMbG+DrPaGHjB+UTjJLs+hcsM7Y+NJ1hWT1nsy+JF6OFfYrl4nceQ5bllYLjHwQwpB2+RT7V4c+zMJBAGjxBmK7+tuS+CePXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661549; c=relaxed/simple;
	bh=7nHUhMO5EUhdBnn8a53dn7QJDtAZMCRcog6ocnEFT1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF9pgp8YG9SAvUQdNvjbW5ouR5rO7KOfIL6zg4qjOAGD1tbDaG2sroNurvqUeGjwY2xD9+XyHNLkOuoNHd4EryhJhB7PS9ajOcIxbj/PC5iGiXeNoZysIGlSb9+9RbdIaL3RjmQ2twYdrUf+n4FdJ7NEBmfxfiv0t0PvqVREZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oY6lg0qZ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oY6lg0qZ"
Message-ID: <5cd21588-2e58-43b9-b9d1-25e9239311db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783661544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0eqyfKxK6Io4jf4C0LwUiJ9UfhcH3uMBCGpZXcck+Y=;
	b=oY6lg0qZmqXZaRcOPsxDSJIHF4rGg+tvjkGJcjwJfIo2iFAU7EpJcZQ64sKpn5TEJq3c9x
	fTpl4VGGr2uzXna8gv68EMxv69NS19kbWJrEeKVE9WPs7iX4xikurgJQGcGd0yoZ8Cj5Xy
	ggwhK5oJjjuaojg9DDCb8dD0xSy1pPM=
Date: Thu, 9 Jul 2026 22:32:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201025.2160583-1-yonghong.song@linux.dev>
 <cd58c8e1e7265ab59dff6882a2e429da97077fd6.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cd58c8e1e7265ab59dff6882a2e429da97077fd6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 6:19 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
>> Add selftests that exercise a 16-byte return value passed in the R0:R2
>> register pair, expressed in C so they rely on the compiler lowering the
>> register-pair return. Tests include an __int128 return (from a subprogram
>> and a kfunc), a 16-byte struct return (from static and global subprograms
>> and a kfunc) and a 16-byte union return.
>>
>> The R0:R2 return convention is only emitted by LLVM 23 and newer, so the
>> programs are gated on __clang_major__ >= 23; with an older compiler they
>> return a sentinel and the "int128_c", "struct_c", "global_struct_c",
>> "kfunc_struct_c" and "union_c" subtests are skipped.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> [...]
>
>> +static void run_prog(struct bpf_program *prog, bool may_skip)
>> +{
>> +	char buf[64] = {};
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		.data_in = buf,
>> +		.data_size_in = sizeof(buf),
>> +		.repeat = 1,
>> +	);
>> +	int err;
>> +
>> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
>> +	if (!ASSERT_OK(err, "test_run"))
>> +		return;
>> +
>> +	if (may_skip && (int)topts.retval == -1) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	ASSERT_EQ(topts.retval, 0, "aggregate_ret_result");
>> +}
>> +
>> +void test_aggregate_ret(void)
>> +{
> The test_aggregate_ret()/run_prog() duplicate functionality provided
> by the __retval tag from test_loader.c. To achieve the same skipping
> mechanics I suggest to:
> - extend test_loader.c / bpf_misc.h with a new tag: __skip("reason")
> - use this tag as:
>
>    #ifdef __clang_major__ >= 23
>
>    SEC("tc")
>    int aggregate_ret_test(struct __sk_buff *skb) { ... }
>
>    #else
>
>    SEC("tc") __skip("... need clang23 ...")
>    int aggregate_ret_test(struct __sk_buff *skb) { ... }
>
>    #endif

Ack. We have quite some cases like this (guarded by compiler or feature flag,
with __skip makes things simpler.

>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c ...
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c ...
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c ...
> Nit: all three files can be merged into one.

Yes, I can merge them.

>
> [...]

