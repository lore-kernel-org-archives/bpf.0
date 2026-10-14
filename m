Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31194DD3B7;
	Wed, 14 Oct 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979717; cv=none; b=LaE1HAuIzlNPDuMgtFQ57YpvQsbVVN8lo+PBJeVMCkeHWqrlF8Ib+XG4zYtMsSLH0wxS0Nsdba1fyvwl0NJpWIMN/CHUipJSCbwHH1dqpMshyxoIOWoAWiLmXGs1SwpP8HjJq/ObI0FN2jRjHb8sDDBUNd/0FviVSlhfIJ+T6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979717; c=relaxed/simple;
	bh=ZR8rHcBKx95/46f6zb2QBF25fwSnsa2y0fz9zjfzGbM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dCyMmxKW9jCrMJ26KWBHNXuqzE1L/H/AEjDfqifNjJZpV6mLO2aapOddlO+tQrsE6Ni+oC8sCA5/wpMKwH7Tq0YzlKBYOu0v5Ae8Q7Jo1YlJSwpcK7BWw4vTSqon/6eH4I5QbLFMHuGoJXjsTcf/G6lfQnF265Jn6s7tLX2Hv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVQ38n/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVQ38n/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2201F000FF;
	Wed, 14 Oct 2026 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791979716;
	bh=TtZrKYQsd+C3nckD5/Sr9iudnPN5dVw/X1Wfqc7RBi0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SVQ38n/1GTd+JkGNFChUbLpuNXB85MoG8O9av82zh5Brq3AcXBlZIIzUF7EdaXg/q
	 BZYxB6Zm8f7K00NPZ7y0C+yPg4EH9TynVR+PUdvg+IMdD6XlrkNMYv7fs8azZ34Pcy
	 VWe5L6EkykpGQL1UzDlXgCpKU+cD5seqWy1rs6dzylASyK7lR8U1dnlCC45ngz43A/
	 rDuucfw51IhWgQj323LYw+fegTDEJYypFrH1Q79XrBsxKcOwHUfzV+KKKOG315M/Wf
	 IXW7CK8Qadg2nDDoUNW+fwAtzU3w0dJLF+umQcPoZiWakT3GjCmCYdedOaPB9E3sTL
	 QNxtvQF5FyYSQ==
Content-Type: multipart/mixed; boundary="===============9052587526286471174=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b66b343a0a91711a6a520e11b284941771cbb23ad8c8f1bd5f831594b567b5fa@mail.kernel.org>
In-Reply-To: <20261014113043.640435-8-kafai.wan@linux.dev>
References: <20261014113043.640435-8-kafai.wan@linux.dev>
Subject: Re: [PATCH bpf-next v2 7/7] selftests/bpf: Skip compare_text subtest when stdout is not saved
From: bot+bpf-ci@kernel.org
To: kafai.wan@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,donggeunyoo.kernel@gmail.com,leon.hwang@linux.dev,kafai.wan@linux.dev,menglong8.dong@gmail.com,yatsenko@meta.com,jiangfeng@kylinos.cn,bjorn@kernel.org,puranjay@kernel.org,vineet.gupta@linux.dev,mykolal@fb.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 14 Oct 2026 12:08:33 +0000 (UTC)

--===============9052587526286471174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Skip compare_text subtest when stdout is not saved

TL;DR: Nit only: the new test__skip() in the compare_text_mismatch subtest
gives no reason for skipping; a short comment or stderr message might help.
The skip logic itself looks correct.

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> index b4cd7c7ff439..ddb6cdc1579f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c

[ ... ]

> @@ -203,14 +203,18 @@ void test_prog_tests_framework_compare_text(void)
>  	}
>
>  	if (test__start_subtest("compare_text_mismatch")) {
> -		err = compare_text_to_expected("line two\n", "line one\n");
> -		fflush(stdout);
> +		if (!env.subtest_state->stdout_saved) {
> +			test__skip();
> +		} else {
> +			err = compare_text_to_expected("line two\n", "line one\n");
> +			fflush(stdout);
>
> -		ASSERT_EQ(err, -1, "mismatch_rc");
> -		ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "-line one",
> -				  "diff_has_expected");
> -		ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "+line two",
> -				  "diff_has_actual");
> +			ASSERT_EQ(err, -1, "mismatch_rc");
> +			ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "-line one",
> +					  "diff_has_expected");
> +			ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "+line two",
> +					  "diff_has_actual");
> +		}
>  		test__end_subtest();
>  	}
>  }

This isn't a bug, but could the skip in the compare_text_mismatch subtest
carry an explanation?

	if (!env.subtest_state->stdout_saved) {
		test__skip();
	}

A subsystem guideline flags selftests that skip silently with no message,
and test__skip() here prints nothing about why the subtest was skipped.
The same condition covers -v in non-parallel mode, a libc without
open_memstream() support, and an open_memstream() failure, so the reason is
not obvious from the test output alone.

For context, the skip itself looks correct: env.subtest_state is non-NULL
inside the subtest, test__skip() sets subtest_state->skipped, and
test__end_subtest() handles a NULL stdout_saved.

The other skips in this file are also bare test__skip() calls, and
test__skip() takes no reason argument, so the guideline may not map cleanly
onto test_progs.  If a reason is wanted, would a short comment above the
test__skip() call, or a separate message printed to env.stderr_saved, be
appropriate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38559567568
--===============9052587526286471174==--
