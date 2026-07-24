Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995A44C651
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906026; cv=none; b=Cbqs7TlgeslaSHGdlLOCQqfmycKcZBluDhsd6R+lL3AdgDnj7ppZq2BG9We8M3ShqvJ05yPDiA+/d9KzEmhOKASHwa7WGKNtKo2UK0DTDK2bI5zzHjoOE19sGm88Tye0cabbFHo2SZGxJ6AqwImO+S4a9cFa8Mm/vJmxooeH9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906026; c=relaxed/simple;
	bh=fbK7gbwmYpruVS9HOopPXASVqJUk88CJW+fUf/SbSdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJSSFha6vqavJuTZGG7zko5aZub+SZforH7eQoDwSiLSGnTKGTU53yuIcQ82Sjnafw5diTbvtesqVcXUb9bKREdK0jbnfU0RDr+jwIFBagncehNIIFpmjndA/nZ+nXgeG+I3fLUY1AT5ZNZS33Mn4rAAWxCux8MyVeMKwudMmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAASzZfC; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAASzZfC"
Message-ID: <bf20e32c-3753-4fa8-a825-c9fb24c821b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784906020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HR6+rJuQhXK8lSuL+MOWredCCVtvuTH8EDprV/plxc=;
	b=SAASzZfC+klWBAe4Jo/RD7xpddGui8N2tNhdGxAvWUnLzi483uCb9TtXxa7h5odCOAD8W+
	ZEjyCWiDKjHD/fZJiHlGaNpQh+EwKrmsaL0xoPPAhlqELoKdVSY+0zeiUaG+gMVh9tnG8R
	yvUmz+bGsV4iVSandnvfS8toIJjNfpM=
Date: Fri, 24 Jul 2026 23:13:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify rejection of sleepable
 tracing prog
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260724141422.10463-1-leon.hwang@linux.dev>
 <20260724141422.10463-3-leon.hwang@linux.dev>
 <20260724142418.B7E191F00A3D@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260724142418.B7E191F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/24 22:24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test incorrectly handles the expected failure of `fentry_sleepable__load()`, leading to dead code on patched kernels and an intentional kernel BUG on unpatched kernels.
> --
> 
> --- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Verify rejection of sleepable tracing prog ---
> commit 21867bb1ed07f00930e4aa9f252967deb7c142a2
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Verify rejection of sleepable tracing prog
> 
> This commit adds a BPF selftest to verify that a sleepable tracing program
> cannot attach to a '__x64_sys' prefix program target.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> [ ... ]
>> @@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
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
> 
> [Severity: Medium]
> Is it intended that the attach and ping logic only executes on unpatched
> kernels?


Yes. It is intentional.

> 
> When run on a patched kernel, fentry_sleepable__load() fails as expected
> (err != 0). The ASSERT_ERR(err) check passes, but the if (err) block then
> causes the test to jump to 'out', making the remaining attach and ping code
> unreachable.
> 
> When run on an unpatched kernel, the load succeeds (err == 0). The
> ASSERT_ERR(err) check fails, but because err is 0, the test proceeds past
> the if (err) check. It then attaches the program and triggers it via ping,
> which intentionally crashes the system with a kernel BUG (as noted in the
> commit message) instead of failing gracefully.
> 
> Could this be resolved by either removing the unreachable attach and ping
> code entirely, or by changing the check to if (!err) to prevent the test
> from crashing unpatched kernels?
> 

The ping is to prove the issue: there was a true BUG caused by the
sleepable tracing prog with bpf prog target.

If remove the attach and ping code entirely, it can only confirm that
there was a potential BUG caused by the sleepable tracing prog with bpf
prog target. But, what was the potential BUG?

Thanks,
Leon

