Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B025B0BD
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317488; cv=none; b=QCXKQ9MIbsOiNta3DdEqy5MuOPS8jCkS/GfXGP2Vd2FTbJMu41v4sYE2sKlV/KfBXZk2Y843ta/ahcSWGsQ7BYNz4IGzGhhxOWfJqlqtOaqHhQi85p6rc7a5N9+/Q536oFVrt77qq1I3/NMJVRWkJKRPM0xDtnMhNFbS3oEnIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317488; c=relaxed/simple;
	bh=XF36YVLCaDzg5XPgUZ/sKSy4YjSUj7Pff0k8dfhsohM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NvQCo5yMV3ersOdxPaemVGDfe4FuyGD9mBF8rPI3gNOFT4p5A0yYfJjFpYQll08xh5d+37oy4HvCKVdz7k2fZbldnh8LUf2fvb4N4NOTfrbCCr1oB3dmJCTXhQJEB3ePHE4fAhehdlrWJRNnXHUbyHgDt62ojm6UGrZ9C4265rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgGdHVGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgGdHVGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B611F0089B;
	Tue,  6 Oct 2026 20:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791317487;
	bh=+6dfx/BKTxsMImnmaXw4cpzX56WFgvOg1ILHLPGTDQM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HgGdHVGeMeGDJUxrldI6Lhi/nQBGGO6FFe+UkalGOivC9jgkHVsrUY/q2fA3nEBfN
	 TJ8pNTnOaQu5hDf2LAPX9xSsCwCdnDn5UAAZ1cxracp9Yj/c3E6IeZ2ZoFR9bFeaw1
	 fUf23iSzJhafwgeloz23au6F4AsmkCD35141shD44Wy+6l9Ua5M7gWzGAXKjHvv6gH
	 XM+hEvbXImV3A3FUUiVTzWrTxl07Q/HVlI8HZzItYaVbflaUXK8pWhjjpntyv2JzPY
	 CvYbpSZ/dumU5o1EPvxzcZrwVBUTN5GSX1tgCplP+bjQuk0He1t22QglAxEQ9NlnsD
	 wYxDTGAoMoiNQ==
Content-Type: multipart/mixed; boundary="===============2807580648002233165=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f370cac05a8389c9e6abe2555e7a5491ce341263cb82c2fd6b6715773dcf9fac@mail.kernel.org>
In-Reply-To: <20261006192840.155680-1-dmantipov@yandex.ru>
References: <20261006192840.155680-1-dmantipov@yandex.ru>
Subject: Re: [RFC PATCH] bpf: test: parallel execution of basic tests
From: bot+bpf-ci@kernel.org
To: dmantipov@yandex.ru,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,dmantipov@yandex.ru,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 20:11:26 +0000 (UTC)

--===============2807580648002233165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: test: parallel execution of basic tests

TL;DR:
- test_bpf fill_helper() runs up front, so ~125MB may be live at once; failed
  allocations could silently skip tests
- Buffered output may hide which test oopsed or hung
- legacy parameter lacks documentation

> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index af6f3340c034..270899aed1e7 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c

[ ... ]

> @@ -15155,6 +15175,9 @@ module_param(test_id, int, 0);
>  static int test_range[2] = { 0, INT_MAX };
>  module_param_array(test_range, int, NULL, 0);
>  
> +static bool legacy;
> +module_param(legacy, bool, 0);
> +

Is a description of the new legacy parameter needed somewhere?

A subsystem pattern flags this as potentially concerning: module_param(legacy,
bool, 0) can also be set as test_bpf.legacy= on the kernel command line, but
the patch adds no MODULE_PARM_DESC() and does not touch
Documentation/admin-guide/kernel-parameters.txt.  Nothing tells users that
parallel execution is now the default or how to restore sequential execution.

On the other hand, TEST_BPF is 'depends on m && NET', so the parameter is
normally passed through insmod or modprobe, and the existing test_bpf
parameters (test_name, test_id, test_range, test_suite) are not listed in
kernel-parameters.txt either.

Would a MODULE_PARM_DESC(), or a note in Documentation/networking/filter.rst,
be the better place to document it?

[ ... ]

> @@ -15345,65 +15368,80 @@ static __init int test_skb_segment(void)

[ ... ]

> +	test_log(test, "#%d %s ", test->index, test->descr);

[ ... ]

> +	pr_info("%s", test->output);
> +}

Can the test that triggers an oops or hang still be identified?

The "#%d %s " header and the "jited:%u " text now go into test->output, and
nothing reaches the log until this pr_info("%s", test->output) at the end of
test_bpf_work_handler().  Before the patch the header was printed with
pr_info() before generate_filter() and run_one() were called.

If bpf_prog_select_runtime() or __run_one() oopses, hangs or triggers an RCU
stall, the log no longer says which test was running.  The backtrace only
shows a kworker in test_bpf_work_handler(), and with several tests running in
parallel the last test that did print says nothing about the one that failed.

Could the test number and description be printed before the program is JITed
and run?

[ ... ]

> +static __init int test_bpf(void)
> +{
> +	int i;
>  
[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		if (exclude_test(i))
> +			continue;
> +
> +		if (tests[i].fill_helper &&
> +		    tests[i].fill_helper(&tests[i]) < 0) {
> +			pr_err("#%d %s: FAIL to setup helper\n",
> +			       i, tests[i].descr);
> +			continue;
>  		}
> +
> +		INIT_WORK(&tests[i].work, test_bpf_work_handler);
> +		tests[i].index = i;
> +		queue_work(bpf_wq, &tests[i].work);
>  	}
>  
> +	flush_workqueue(bpf_wq);

Can the fill_helper() calls in this loop leave most of the test programs
allocated at the same time?

The loop calls every fill_helper() up front and only queues the work, and
the insns buffer is freed later by test_bpf_work_handler() after
generate_filter().  Nothing throttles the loop, and flush_workqueue() is the
only wait.  The loop just builds instruction arrays, while each worker has to
copy and JIT a program of up to ~200K instructions and then run it, so nearly
all of the buffers are likely live at once.  Before the patch each buffer was
freed right after generate_filter(), so only one was live at a time.

__bpf_fill_pattern() allocates len = 3 + count * emit_max instructions, with
count = 14112 for the imm variants and 22176 for the reg variants.  Roughly:

  ~790KB for each ALU imm test and each JMP/JMP32 imm test
  ~1.6MB for each ALU reg test
  ~1.24MB for each JMP/JMP32 reg test

That is about 125MB of high-order kmalloc allocations live at once, compared
to a peak of about 2MB before.  This also happens with legacy=1, because the
producer loop is the same and the ordered workqueue only serializes the
execution.  Is that consistent with the commit message's "fallback to
similar-to-legacy behavior"?

On small or 32-bit boards these high-order allocations can fail.  A failed
fill_helper() only prints "FAIL to setup helper" and continues, without
touching err_cnt, so tests are silently skipped and test_bpf() can still
report 0 FAILED and return 0.

Should fill_helper() be called from test_bpf_work_handler() instead, or
should the loop be throttled?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37521119328
--===============2807580648002233165==--
