Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DA3AFD16
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027811; cv=none; b=JMeNpZhQ4Nau4KqTxo9rxDGpxTosdakKtQnE1BHgrOi4sBMcILWdnmCvJvXpAm7vgA9hLKrCPpSVMQSihz2XLvJuD+Ng+/5Y0dgjkfaEo5YJrjw+f5rmtX+aV2bIIZVcycYvGvaBARIXuOzUQhFJLhR1fktmHxWMBDQ7nhn/zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027811; c=relaxed/simple;
	bh=flymVxaESJmcNzEwb8revyfMIk/AqVamBzkRhPDa5r4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G2dnV4vhqP/hNW/AkVvsvKku1kJDnIugFxwd+XfocnaHo+5I0bNdfL9drN7MmOodG1oY+ULacJq2JKjM6xoDnys6esyF2X/8cMyWj1fGKu/tf4r4qotqUJjCUA06TpYxagZxGT6r3W0jO1boLax8L/ODYFLrCL+3rRuUuT3+ZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9/mVFNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9/mVFNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1498E1F000FF;
	Mon, 21 Sep 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027810;
	bh=d7TghIZ70u4huxeNHZ1ddszij0ZnW0gIvxjHQCcNz0Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J9/mVFNl8+DdFn2weiZcNahJT2WOevPrAdWOcukEfElZl18Stoj09OEW36z1MXPbl
	 aqLuC72KXlV5Unm4he0K43fMsxbvUKTF71XEe5fxX14eNBmq//s3nBkcceJ3qXyA4m
	 kH66GLm95XQvoXxaasMo57uI6gXSwcgm65tDbmwCL/2TFbDXeJdVmISQbsOvThUxcC
	 sFv5i9yedKDClB6TG+rO1dl4UbKfKdI+yWzMA5M5Qrr+M6mKbtHYrO9XqxCZFDtXqw
	 X9aQXVo5apN4k9oG1oXlg8pZgtHY5sw/4HMsOJYma1VckKLooMbsA2+Nw4aFqj7RFM
	 mpq9OIuJKxcOw==
Content-Type: multipart/mixed; boundary="===============5978879528784475066=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63ad27833368df7c3cf2f4d1fd582a1306663c96c207f7745bd656e8011ed3a4@mail.kernel.org>
In-Reply-To: <20260921210205.1724656-1-yonghong.song@linux.dev>
References: <20260921210205.1724656-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 18/20] selftests/bpf: Add an end-to-end .bpf_cleanup exception test
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 21:56:48 +0000 (UTC)

--===============5978879528784475066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> new file mode 100644
> index 000000000000..c932da7cbec1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c

[ ... ]

> @@ -0,0 +1,121 @@

[ ... ]

> +	err = exceptions_cleanup__load(skel);
> +	if (err) {
> +		if (err == -EOPNOTSUPP &&
> +		    strstr(log, "exception cleanup needs a JIT that can dispatch landing pads"))
> +			test__skip();

A subsystem pattern flags this as potentially concerning: the load failure
is correctly turned into a skip rather than a failure, but the skip carries
no reason. test__skip() is called with nothing printed, so the only output
is the harness' bare '#N exceptions_cleanup:SKIP' line. Is there a reason
to omit the skip message here?

A reader of a CI log cannot tell whether the test was skipped because the
JIT cannot dispatch landing pads, because the test was denylisted, or for
some other reason. Roughly a third of the existing test__skip() sites in
prog_tests/ print a reason, e.g. fprintf(stderr, "%s:SKIP: JIT cannot
dispatch landing pads\n", __func__) alongside test__skip(). (Note that
test_progs' test__skip() has no message parameter, so the reason has to be
printed separately.)

The skip decision itself is correct and precisely gated on the kernel's
message from kernel/bpf/exception.c:440, so this is a diagnosability nit
rather than a functional defect.

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
> new file mode 100644
> index 000000000000..a3a8c14e0db2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c

[ ... ]

> +static __used __noinline __u64 foo3(__u64 x)
> +{
> +	bpf_preempt_disable();
> +	if (x > 100)
> +		asm volatile (
> +		"r1 = %[cookie];"
> +	"1:"	"call bpf_throw;"		/* cleanup region */
> +	"2:"
> +		"goto 3f;"
> +	"4:"					/* landing pad */
> +		"r7 = r0;"
> +		"call bpf_preempt_enable;"
> +		PAD_RAN("%[ran]")
> +		"r1 = r7;"
> +		"call bpf_unwind_resume;"

This isn't a bug, but is the r7/r1 shuffle in foo3()'s pad meant to
demonstrate that callee-saved state survives a pad-internal call, or can
those two instructions be dropped so all three pads call bpf_unwind_resume()
the same way?

The pad saves r0 into the callee-saved r7 across the bpf_preempt_enable()
call and restores it into r1 immediately before 'call bpf_unwind_resume'.
bpf_unwind_resume() is declared as taking no arguments, and at pad entry r0
is not the throw cookie but the fixed constant the kernel writes there
(BPF_PAD_ENTRY_R0 == 1), so both instructions appear to be dead stores.

The two other pads in the same file (foo2 label 6 and foo1v label 8) call
bpf_unwind_resume without any register setup.

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 000000000000..db6ac7d8bd6d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c

[ ... ]

> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)

[ ... ]

> +static __used __naked __noinline __u64 stack_arg_pad_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +"1:"	"call inner_throw;"		/* cleanup region */
> +"2:"
> +	"call bpf_preempt_enable;"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	"r1 = 1;"
> +	"r2 = 2;"
> +	"r3 = 3;"
> +	"r4 = 4;"
> +	"r5 = 5;"
> +	"*(u64 *)(r11 - 8) = 6;"	/* the sixth argument */
> +	"call six_args;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 kfunc_arg_pad_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = 11;"
> +"1:"	"call bpf_throw;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	"r1 = 1;"
> +	"r2 = 2;"
> +	"r3 = 3;"
> +	"r4 = 4;"
> +	"r5 = 5;"
> +	"call bpf_kfunc_call_test_pair_arg_nofit;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

This isn't a bug, but since case 14 (kfunc_arg_pad_frame) is rejected on
the kfunc's BTF argument-slot count before do_check() runs, do the r1..r5
assignments there carry any weight, or were they carried over from case 13
(stack_arg_pad_frame)?

kfunc_arg_pad_frame() is instruction-for-instruction identical to
stack_arg_pad_frame() except that the '*(u64 *)(r11 - 8) = 6; call
six_args;' pair is replaced by a single 'call
bpf_kfunc_call_test_pair_arg_nofit;', and both carry the same __msg()
expectation. In case 13 the r1..r5 setup pairs with the r11 store that the
kernel rule actually matches on; in case 14 the rejection comes purely from
the kfunc's BTF argument-slot count, which the verifier computes before
do_check() ever runs, so the five register assignments carry no weight
there.

Would a shared macro for the repeated frame skeleton ('call
bpf_preempt_disable / 1: call inner_throw / 2: call bpf_preempt_enable / r0
= 0 / exit / 3: ...') make the one differing instruction in each case easier
to see? The same six-instruction frame skeleton is repeated verbatim across
roughly eleven __naked frames in the file.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472
--===============5978879528784475066==--
