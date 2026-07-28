Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1842874FB
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202440; cv=none; b=DLtinAmHzNz03NvVTsvYDkv66VGuGPQvY87/+QRsxKyTmuJjiwJgNOiq8zQZDOrzfLzA62NNGlXO7HftWRn3yNHOHPYpawe34fN/MbC85adszVXOcpVV3P1zQCk6MthWE9lEclsKHKPX4WitCB1B3MKtf6aOwlNhdukd/F8INPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202440; c=relaxed/simple;
	bh=AQ9TWGh1fqb6Ql7Fb1eNWMc0KI4p/ZClc4/hGwZ0Yfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEs1K75G4i36a87eGDX32JSGUXjqgtNIVk2rrEH9zc+x2Hag4RC9SDRYllDleAMSAwvG5cK6RQJl+AJf7HVQ7YEv7WVl9Vz0KWgXa/RmOqZIjO3nGYBE/8EhrSVHlJ8lVK8emd/uda8Fw3dsW6tM3ZOF6LAufl3HtPUFpcooRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=arvVJfOz; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arvVJfOz"
Message-ID: <82dea78e-7930-4380-bf57-4123f48d86b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785202435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD94w5wcckP1xGyG4NSw/YaiLcRaOIaQYBLlhFeTXrE=;
	b=arvVJfOzm9TtxYfTKVg4H6rHsZc7tsBknSgUdi9FxQAmMizDMTKkPV/03UN0k8blqf1lI9
	A9xejJVfs2vueMC7GV5NSvlcUMGFBpPoTMjQLtEol+jt7pDONH3TobKtYxyuFNh0gaGZ5X
	U9ZJO6bPkSCr3Gn8/oJ44AACko5cig4=
Date: Tue, 28 Jul 2026 09:33:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Verify rejection of
 sleepable tracing prog
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260725132624.78373-1-leon.hwang@linux.dev>
 <20260725132624.78373-3-leon.hwang@linux.dev>
 <20260725133309.B66B31F00A3A@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260725133309.B66B31F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/7/26 21:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test contains dead code after the expected failure of `fentry_sleepable__load()`. If this code executes on an unfixed kernel, it intentionally triggers a kernel BUG and crashes the test environment.
> --
> 
> --- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: Verify rejection of sleepable tracing prog ---
> commit 44292a230f0467503b72b0ecb8c6c25244de310b
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Verify rejection of sleepable tracing prog
> 
> This commit adds a selftest to verify that a sleepable tracing program
> cannot attach to a '__x64_sys' prefix program target. The test attempts
> to load the program and expects the load to fail, avoiding a kernel BUG
> on unpatched kernels.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> [ ... ]
>> @@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
> [ ... ]
>> +static void test_sleepable_fentry_to_xdp(void)
>> +{
> [ ... ]
>> +	err = fentry_sleepable__load(skel);
>> +	ASSERT_ERR(err, "fentry_sleepable__load");
>> +	if (err)
>> +		goto out;
>> +
>> +	skel->links.fentry_xdp = bpf_program__attach_trace(skel->progs.fentry_xdp);
>> +	if (!ASSERT_OK_PTR(skel->links.fentry_xdp, "bpf_program__attach_trace"))
>> +		goto out;
>> +
>> +	skel_xdp->links.__x64_sys_nop = bpf_program__attach_xdp(skel_xdp->progs.__x64_sys_nop,
>> +								ifindex);
>> +	if (!ASSERT_OK_PTR(skel_xdp->links.__x64_sys_nop, "bpf_program__attach_xdp"))
>> +		goto out;
>> +
>> +	err = system("ping -q -c 1 -W 1 127.0.0.1 > /dev/null");
>> +	ASSERT_OK(err, "ping");
>> +	ASSERT_ERR(skel->bss->retval, "retval");
>> +
>> +out:
>> +	fentry_sleepable__destroy(skel);
>> +	xdp_dummy__destroy(skel_xdp);
>> +}
> 
> [Severity: Medium]
> Since the test expects fentry_sleepable__load() to fail (meaning err < 0),
> won't the "if (err) goto out;" statement cause the test to immediately branch
> to out?

Correct.

When err, no need to create the links.

> 
> If this code behaves as expected, it appears all the subsequent logic for
> bpf_program__attach_trace(), bpf_program__attach_xdp(), and the ping command
> becomes unreachable dead code.
> 
> Conversely, if the test runs on an unpatched kernel where the load
> unexpectedly succeeds (err == 0), the test would fall through to the attach
> and ping logic. Could executing this sequence on an unpatched kernel trigger
> the exact kernel BUG mentioned in the commit message, potentially crashing
> the test environment instead of gracefully failing the test?
> 

Yes. But why do users run latest selftests on unpatched kernel? I guess
they are planning to patch the kernel.

Thanks,
Leon

