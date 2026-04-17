Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426932737F8
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392259; cv=none; b=cQrS28JvvLEHzrO9p9t8kOvw7pZJ60OeYCghxf5nHN8Q3wpExWmsQg/X+SzabcHDmJv1KgChjbiY0rf3r66OKVwuBbNOIRS4pUeu8ZsoORZUXncM91U5wpAGTzGBTuwExq/Ff9qFqAww/HcvksoGZyD+dgA2261HmFqXYkG3yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392259; c=relaxed/simple;
	bh=cdoquM5uqhR3ZqPtELP8c3EiPGTFie+pFNZK+7kBMTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYTJvj1VqMvdzh0eRJATy2qo35pUauQnfhMYEbroUiFVHSlkC1+P/78IamI6AfV7tJ1e6hsgCP6cmyoy+9nSCXuxUE+FdcueG5J4G7zflETiHgkoVUzFZLDM0P0E20FOpt6VHi6MASt8qKYp7I/PvB/3X2XwgqWtTxw32On/Tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4hEQHBL; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l4hEQHBL"
Message-ID: <a5ba416e-f70d-4ba3-9443-923ce3b10d33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776392254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdITxPE861+ZwCznNJRIBMh9F1oYXIA+qrDu3sQ7wRI=;
	b=l4hEQHBLThyZMVrGTL9swkarwa6Za6R9tsjU/PdA6ojv6qajEbKJL3OPS4uEqUTIaIddsF
	DeGV3SH1dByeqvNSuNy1POiTPrqdQcNNzI5EpNYKq03Dd5iV/Ev8Bx0IStC2nQov8W2VyA
	UKIKE1AtfTvkmFHjXaPfBmnbrVfslaw=
Date: Fri, 17 Apr 2026 10:17:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: Add a test to verify
 bpf_iter for global percpu data
Content-Language: en-US
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260414132421.63409-9-leon.hwang@linux.dev>
 <20260414220850.D6421C19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260414220850.D6421C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/4/26 06:08, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Medium] The `dump_percpu_data` program is autoloaded by default, breaking existing subtests on older kernels.
> - [Medium] Checking `err == -EOPNOTSUPP` after skeleton load incorrectly handles unsupported kernels.
> - [Medium] Casting the global datasec to an anonymous C struct relies on fragile compiler layout assumptions.
> --
> 
> commit 1e00e3e2b318918e67a2c7d2e251132e1b985484
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Add a test to verify bpf_iter for global percpu data
> 
> Add a test to verify that it is OK to iter the percpu_array map used for
> global percpu data.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 0b0384b6515ed..9ff09ff1981c4 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> 
> [ ... ]
> 
>> @@ -269,6 +269,57 @@ static void test_global_percpu_data_verifier_failure(void)
>> +static void test_global_percpu_data_iter(void)
>> +{
> 
> [ ... ]
> 
>> +	err = test_global_percpu_data__load(skel);
>> +	if (err == -EOPNOTSUPP) {
>> +		test__skip();
>> +		goto out;
>> +	}
> 
> Will this correctly skip on older kernels? When the kernel verifier
> rejects an unsupported program type or feature during bpf_prog_load(),
> it typically returns -EINVAL (or -EACCES), not -EOPNOTSUPP.
> 
> Libbpf passes this error code back to the caller, so this condition
> might evaluate to false, causing the test to fail on the subsequent
> ASSERT_OK(err) check instead of gracefully skipping.
> 

This err check should be dropped, because this test won't run when the
kernel does not support global percpu data.

See previous patch:

+void test_global_percpu_data(void)
+{
+	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
+		test__skip();
+		return;
+	}

> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> index 947721c21f30c..0ddb820509ebf 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> 
> [ ... ]
> 
>> +SEC("iter/bpf_map_elem")
>> +__auxiliary
>> +int dump_percpu_data(struct bpf_iter__bpf_map_elem *ctx)
> 
> Will this break existing subtests on older kernels? The bpf program
> dump_percpu_data is defined with SEC("iter/bpf_map_elem") without the
> ? prefix, meaning libbpf will attempt to autoload it whenever
> test_global_percpu_data__load() is called.
> 
> Since the existing init and lskel subtests also load the full skeleton,
> they might inadvertently attempt to load this new iterator program.
> Should this use SEC("?iter/bpf_map_elem") to prevent autoloading by
> default, and only be explicitly autoloaded in the iter subtest?
> 

Since older kernels do not have global percpu data support, this test
won't run on them. See aforementioned explanation.

>> +{
>> +	struct {
>> +		int data;
>> +		char run;
>> +		struct {
>> +			char set;
>> +			int i;
>> +			int nums[7];
>> +		} struct_data;
>> +		int nums[7];
>> +	} *pptr = ctx->value;
> 
> Is it safe to cast the global datasec to an anonymous C struct like
> this?
> 
> In the BPF source, these are declared as independent global variables.
> The layout of these variables in the .percpu ELF section is determined
> entirely by the compiler. While the current compiler version might emit
> the uninitialized nums array after the initialized variables (matching
> the struct layout), this relies on undocumented compiler behavior.
> 
> If the compiler alters the layout, or if variables are added or
> initialized differently in the future, the field offsets will mismatch.
> This could cause the step calculation to diverge from the map's actual
> value_size, leading to out-of-bounds reads.
> 
> Would it be safer to group these variables into a single explicit struct
> in the BPF code to guarantee their memory layout?
> 
> [ ... ]
> 

Correct, I should not use such an anonymous struct, even if it matches
the generated skeleton's embedded struct.

A better approach is to locate the int by offset, which will match its
offset in the generated skeleton's embedded struct.

Thanks,
Leon

