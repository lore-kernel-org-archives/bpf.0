Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0E3921ED
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507583; cv=none; b=WxTIQbgra8qRsAz4taBmXm+XuUAxiuyOVHUm5vXqk+MGIvdL3rZrlIn/+IcdWlOG90v+kaxZMlqA2eUmuz49///uJTltzkQ7eHWM12ghWhFqLEvEHQFVVBMGra4mpMrYWpIx/ptlm3s2FnhtSnrqUSCDriYUo/4JQzi7T29FqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507583; c=relaxed/simple;
	bh=2zfyDfp9lDoLpzcdeCHTTCZljwO67Im02LbNzMDZ43g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2BG4BM2yJyEcTkIBCtskT7TeTaC2rgTC6yawziPZq/qE5oEsKyGHEbv6gcpMylWrjIL898hyozsJhqruQhP6Jsle3Zl0mqEkatiUeQIR12t14JRYi+NaEvnkUvoC1hrtQPokxAJqnV7wpwwjlNf3ysDzGYXyvvvLj0ldlqx+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uU3IDwwa; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uU3IDwwa"
Message-ID: <a40b43fc-66aa-4b1f-86e6-602a5f465a14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfH6dHmVvaHe3hKH+bxvI/kGunaJ9EZu/zp2AZ6k9qY=;
	b=uU3IDwwaZ0x66JbIVu3zTxEcSZgkjGobchZw+dMKTimKQzBD6IeNv5ln5VjhEy9w9r+iK/
	svnOsTR0S7nK9poZeSGiUo2tsd7gPipLrJZDOjn/wm7qGODI6eOjkKAU3wd67pa2jZHI+A
	9ddiHizFT/r8vTmdBQl+FAHUQBMv8RA=
Date: Wed, 12 Aug 2026 12:06:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 09/13] selftests/bpf: Add tracing_multi bpf prog
 attach failure tests
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-10-leon.hwang@linux.dev>
 <20260809151715.790681F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260809151715.790681F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/8/26 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Build failure due to undefined symbol `libbpf_find_prog_btf_id`.
> --
> 
> --- Patch [9]: [PATCH bpf-next 09/13] selftests/bpf: Add tracing_multi bpf prog attach failure tests ---
> commit c3b104cf9a90f8ddf11f23d2944ad76004fb3150
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Add tracing_multi bpf prog attach failure tests
> 
> This patch adds tests for tracing_multi BPF program attach failures,
> covering both libbpf and kernel failure modes.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>> index 5ecb751af9be7..5cf11707eaf89 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> [ ... ]
>> +	/* fail#4 (kernel) duplicate target through different fds */
>> +	token_fd = bpf_object__token_fd(skel->obj);
>> +	token_fd = token_fd < 0 ? 0 : token_fd;
>> +	target_id = libbpf_find_prog_btf_id("target_1", fds[0], token_fd);
> 
> [Severity: Low]
> Does this code compile successfully? libbpf_find_prog_btf_id is an
> internal static function in libbpf, so calling it directly from selftests
> seems like it would cause an implicit function declaration and undefined
> reference linker error during the build.
> 

Good catch.

libbpf_find_prog_btf_id() is exposed in the patch #11.

Will move the expose in this patch.

Thanks,
Leon

>> +	if (!ASSERT_GT(target_id, 0, "target_1_btf_id"))
>> +		goto cleanup;
>> +
>> +	dup_fd = dup(fds[0]);
>> +	if (!ASSERT_GE(dup_fd, 0, "dup_target_fd"))
>> +		goto cleanup;
> 

