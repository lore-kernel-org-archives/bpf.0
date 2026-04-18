Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4232E692
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536988; cv=none; b=RMQbvaHAqlcCUsow0H4dJLM1RI6QCcU6VV5QVy20hlm3k2Acxqjum0DRcUsQsBRHG6HYEjDDgd9llgaqK3zL/q81VzK6NFUzLbXFmu0gHDJdfnRJwMKVANnmvLmXdceXcY3A2AeXPgp9WpsO6EVQ+EsIV9krF8Ty+f8jWtnXv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536988; c=relaxed/simple;
	bh=0D5OxM04+HdyBc8nngQlGQWBWjTTqjpyl9VOlNrRCr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhUXEzT2RZgTNtaov0t+vD31+O7PKTvSIJd5wRv8xztr1MKFYlfuaQ3I6CrET6eNVT/y00Pm7rtZFks6A9BZ0oHqVuJ2H/HD/lSXaUEV4qEAQZXg8BNjsydTr8wLxSN2VNGExZpcu6eWZrciM4lgH5DzSCiuhv4iptDZM8gZtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r0GvYIAS; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r0GvYIAS"
Message-ID: <ef645237-85ae-4f44-b06d-1ffb5f503eeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776536974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgka/eIemE/RMzo2CNUm/wUjPX0jdW0ozB7ab5Fy55w=;
	b=r0GvYIASBjXLBNKRJAAvJx0v9ScE4kb7kiJ5W3H5iZp/rkN+UhRteUmt+6fmMrYo1lHbJR
	gRC7DWzI4BgSxv0W9HnbpuF85PZqZGI8h6H0W9DOQW8LEEdh+zCg3wDUJs+g91pVvfUo6z
	8WVWjfYLDvIpYugDN09ul0yxjtLdBik=
Date: Sat, 18 Apr 2026 11:29:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 15/16] selftests/bpf: Add negative test for
 greater-than-8-byte kfunc stack argument
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034833.2636781-1-yonghong.song@linux.dev>
 <20260417042854.4BD1FC19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417042854.4BD1FC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:28 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Medium] The `prog_test_big_arg` struct uses `long`, which fails to test the >8 byte limit on 32-bit architectures and causes BTF size mismatches.
> - [Medium] Using `ASSERT_ERR(stack_arg_fail__load(skel))` masks the actual verifier error reason, allowing the negative test to pass for unrelated reasons.
> --
>
> commit 1ec644adfded3aa88befcb32fc73958c68b7e018
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add negative test for greater-than-8-byte kfunc stack argument
>
> This commit adds a selftest to ensure the verifier rejects kfunc calls where
> a stack argument exceeds the 8-byte register-sized slot limit. It introduces
> a new kfunc taking a struct argument and a BPF program that attempts to pass
> a large struct to it.
>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> index 2c1cb118f8867..2a40f80b074a3 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> @@ -50,6 +50,11 @@ struct prog_test_pass2 {
>>   	} x;
>>   };
>>   
>> +struct prog_test_big_arg {
>> +	long a;
>> +	long b;
>> +};
>> +
> Does this structure achieve the intended >8 byte size on 32-bit architectures?
>
> When the test kernel module is compiled on a 32-bit host, long is 32-bit,
> making the struct exactly 8 bytes. Since the BPF target always treats long
> as a 64-bit integer, this makes the struct 16 bytes in the BPF program.
>
> This size discrepancy between the BPF program's BTF and the host kernel's BTF
> might cause the verifier to reject the load for a BTF size mismatch rather
> than the intended stack argument limit.
>
> Could these fields use explicitly sized types like __u64 to ensure the struct
> is consistently larger than 8 bytes across all architectures?

Good point, using __64 is much better.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
>> @@ -0,0 +1,24 @@
> [ ... ]
>> +	if (!skel->rodata->has_stack_arg) {
>> +		test__skip();
>> +		goto out;
>> +	}
>> +
>> +	ASSERT_ERR(stack_arg_fail__load(skel), "load_should_fail");
> Could this generic error assertion mask the actual verifier rejection reason?
>
> If the program fails to load due to an unrelated issue, such as a missing BTF,
> a syntax error, or the architecture-dependent size mismatch described above,
> the test will incorrectly report success because it only checks that the load
> operation failed.
>
> Would it be better to refactor this test to use the standard test_loader
> infrastructure (via RUN_TESTS) with __failure and __msg annotations
> in the BPF program? That would ensure the rejection is explicitly due to the
> argument size limit.

will do RUN_TESTS style for this test.

>
>> +
>> +out:
>> +	stack_arg_fail__destroy(skel);
>> +}

