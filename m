Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5720F08C
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889845; cv=none; b=GwIXTY7UYXKNa9z29EIvE+V/CqQWJDJdXfAzjMe9SJxFkuEAgMDzwqdp8SPO/Gc3IQshmnxo0riyb2PpESPqVrKNPghuOCRKBRtVhEUcsLbWyLjxByqLnyW5/95UBb/pv/aZcfXV1Qdk3WJfCP48rV580Xn+sJaYqfK3qRExpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889845; c=relaxed/simple;
	bh=lh6GDFC6eCJ4fFxSsLsRa+QkF6tll16fRtH9JVuiIRw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YBrrDyE+jYXpmABb5jObYrrovyXBEL54KHI2oakuUrxBYGSaN+9MZPuZl5f/BdW6t0E8NronEC+6g3e1UuU8MiJPk6MCUCQWXHYUrsVB5zljlm13SgFmJ7MdRPq6do48kbZT8HtBYIILsKBZQf8Ulmz75nOkuuw+MiYAji82adA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDUIWYN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDUIWYN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E612FC19425;
	Wed, 22 Apr 2026 20:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776889845;
	bh=lh6GDFC6eCJ4fFxSsLsRa+QkF6tll16fRtH9JVuiIRw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QDUIWYN0JATAp2TIavWcA8UgKJrnUwz0+LigiWjsuD+J9lSnyAeQCvXr49vdFFNhA
	 hG9pubc9Kn+zHJDyIeCU1Rbh6qiGtRTup8TPDSKgRfbzqNZOz7vboNE1F++10Naabc
	 khcRg6ZmrUOOH4LO8LkxfpfBUHsfhe9Fa6rwXqnYt3oFZ8PirMb9/hvD0W6oS8EwHH
	 M46WHjcJdDYWP108oRyd9x9eKJ1dd8uDn7zrpg2j1Z7LPxTKrXgtKTTpqDOx7v5z+x
	 eaml852dPvX0HAyjlWdY/xKHY6LSXSvEDIQatdD/Mf4GufIKggEajQeceAMB1m//fX
	 hPK4QD7ARSB/A==
Content-Type: multipart/mixed; boundary="===============9019930717188933539=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ca1420ce830b146a1ed429af9af7bb489a7959bad702d7080d3be6a325a483d@mail.kernel.org>
In-Reply-To: <20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com>
Subject: Re: [PATCH bpf-next v13 6/6] selftests/bpf: Add tests for sleepable tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,peterz@infradead.org,rostedt@goodmis.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 20:30:44 +0000 (UTC)

--===============9019930717188933539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c

[ ... ]

> @@ -0,0 +1,142 @@
> +void test_sleepable_tracepoints(void)
> +{
> +	struct test_sleepable_tracepoints *skel;
> +
> +	skel = test_sleepable_tracepoints__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	if (test__start_subtest("tp_btf"))
> +		run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
> +	if (test__start_subtest("raw_tp"))
> +		run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
> +	if (test__start_subtest("tracepoint"))
> +		run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
> +	if (test__start_subtest("sys_exit"))
> +		run_auto_attach_test(skel->progs.handle_sys_exit_tp, skel);
> +	if (test__start_subtest("tracepoint_alias"))
> +		test_attach_only(skel->progs.handle_sys_enter_tp_alias);
> +	if (test__start_subtest("raw_tracepoint_alias"))
> +		test_attach_only(skel->progs.handle_sys_enter_raw_tp_alias);
> +	if (test__start_subtest("raw_tp_bare"))
> +		test_raw_tp_bare(skel);
> +	if (test__start_subtest("tp_bare"))
> +		test_tp_bare(skel);
> +	if (test__start_subtest("test_run"))
> +		test_test_run(skel);
> +	if (test__start_subtest("test_run_on_cpu_reject"))
> +		test_test_run_on_cpu_reject(skel);
> +	if (test__start_subtest("raw_tp_non_faultable"))
> +		test_attach_reject(skel->progs.handle_raw_tp_non_faultable);
> +	if (test__start_subtest("tp_non_syscall"))
> +		test_attach_reject(skel->progs.handle_tp_non_syscall);
> +	if (test__start_subtest("tp_btf_non_faultable_reject"))
> +		RUN_TESTS(test_sleepable_tracepoints_fail);
> +
> +	test_sleepable_tracepoints__destroy(skel);
> +}

In v8, Andrii Nakryiko suggested simplifying this test structure by using
an array-based approach instead of individual if statements for each test
case:

  "why not have an array

  struct { const char *name; struct bpf_program *prog } cases[] = {
     { "tp_btf", skel->progs.handle_sys_enter_tp_btf},
      ...
  }

  and then do the tests in a loop?"

Reference: https://lore.kernel.org/bpf/CAEf4BzZ_YOb1MNpUxuhFESqRWARFiBJ6yGZ-Z8xBqdCvqi_Bow@mail.gmail.com/

Would an array-driven approach reduce repetition and make it easier to
maintain as new test cases are added?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24799223877
--===============9019930717188933539==--
