Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2F35E1B2
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380708; cv=none; b=rmNUQlqSY8w7kovomNj/Bof64ci9YAbc+Y+n05rUWB47yWTJRcu32ZZzKtD7ChfNsnolZ70tg7AVIkBfV/EMsiG66c7LoECxZIhBZx9lE6lD/QUIO2UA1nXEfMeskCwkheu4MQDg46jPp+0W9GWDLGYEvgapX+pybAiIT99KeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380708; c=relaxed/simple;
	bh=8UmLJhHODv+jWbG8zfMrUNGJVmHVQ4LZvVgODHsHICE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQCjkjgv7T4SySsKO5Lzh0SezsGLypqfFsZDNg1+1gUfl4xh718Z34e+f3I5N/aWF4YN2icAhCfPwOeAm/9ZIXncnkybOEv8CKRuiPTfPP3s2+go5qK7EqPyLSsbbpTdpw6fi3z7Vr3tSTi2BKDYBimRvBf2MY/BzQrTAMhNe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPgeTTck; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPgeTTck"
Message-ID: <a3f40063-9142-4bb3-afc4-046b73f462ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786380704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkF+nvzdOLAxOh+q6y8bPGgGWXsr3dD/p5QQC6oJDQk=;
	b=MPgeTTck3/N5e29CxA/CmNTvIvib43Awx6Ekq7boNcKLJw8NDiY56ntnT0FvM0bnmlSMML
	hThHEQFApY21vLa1v3LVVPrX43KexsruBbXuN0BWRrkJ9rZAKXUPVzqoOtRipWaj9QANoQ
	/p3hcLNm3nddVefg4zJsMmRJcFj6Hq0=
Date: Mon, 10 Aug 2026 09:51:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 10/13] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190413.1902293-1-yonghong.song@linux.dev>
 <20260808192726.EBB0E1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260808192726.EBB0E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/8/26 12:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `aggregate_ret_kfunc_c` test will fail to load instead of gracefully skipping on 32-bit kernels when compiled with LLVM >= 23, due to a mismatch in `__SIZEOF_INT128__` definitions causing a ksym resolution failure.
> --
>
> --- Patch [10]: [PATCH bpf-next v3 10/13] selftests/bpf: Add C tests for 16-byte returns in R0:R2 ---
> commit 34be80f3aa8159c8e9fb57e485947ec4dc335cca
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add C tests for 16-byte returns in R0:R2
>
> This commit adds selftests that exercise a 16-byte return value passed in the
> R0:R2 register pair. It covers __int128, 16-byte struct, and 16-byte union
> returns. It also adds tests for __int128 and 16-byte struct returns from a
> kfunc, with bpf_kfunc_call_test_i128() guarded by __SIZEOF_INT128__.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> new file mode 100644
>> index 0000000000000..e4317399d711b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> [ ... ]
>
>> +static void test_kfunc_c(void)
>> +{
>> +	struct aggregate_ret_kfunc_c *skel;
>> +	bool supported;
>> +	int err;
>> +
>> +	skel = aggregate_ret_kfunc_c__open();
>> +	if (!ASSERT_OK_PTR(skel, "skel_kfunc_c_open"))
>> +		return;
>> +
>> +	supported = skel->rodata->has_reg_pair_ret;
>> +
>> +	/*
>> +	 * Where the JIT cannot hand the second half of a >8-byte kfunc return
>> +	 * back in R0:R2, bpf_add_kfunc_call() rejects the call with
>> +	 * -EOPNOTSUPP. Asking the kernel keeps this test free of a list of the
>> +	 * JITs that can, which would have to be updated as the rest of them
>> +	 * learn.
>> +	 */
>> +	err = aggregate_ret_kfunc_c__load(skel);
>> +	if (err == -EOPNOTSUPP)
>> +		supported = false;
>> +	else if (!ASSERT_OK(err, "skel_kfunc_c_load"))
>> +		goto out;
> [Severity: Medium]
> Will this load fail with an assertion error instead of gracefully skipping on
> 32-bit kernels when compiled with LLVM >= 23?
>
> If the host kernel is 32-bit, bpf_testmod is built without __SIZEOF_INT128__,
> omitting bpf_kfunc_call_test_i128 from the module BTF.
>
> However, because the BPF program aggregate_ret_kfunc_c.c is compiled for a
> 64-bit BPF target, __SIZEOF_INT128__ will be defined, and it will
> unconditionally reference the bpf_kfunc_call_test_i128 kfunc via the
> bpf_testmod_kfunc.h header.
>
> During aggregate_ret_kfunc_c__load(), libbpf will attempt to resolve the
> kfunc, but since it is missing from the 32-bit kernel's BTF, it will fail and
> return a relocation error (such as -ENOENT) rather than -EOPNOTSUPP. This
> would cause the ASSERT_OK(err) check to fail.

To avoid complexity, the current implementation should be okay. The CI tests
only for 64bit arch (x86_64, arm64 and s390x). Running selftests with 32bit arch
may fail (or fail with other tests too).

