Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296ED357D13
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140340; cv=none; b=XVGU9KlXQb2P6MUzaW7QtlyDsaCgSetQwzQTspTvWbAOWLUtsWtN8t+F91D+FIGMkN4zZYbN3lds6IN9H7qY4tXI2E88Uw1CyRMZHOiagqPMWzVU0Nz5pKH9EqA02vDMWXyIMvQT9FSGgG12XXhL2qlY4up1bk2kHRlnPguOcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140340; c=relaxed/simple;
	bh=RjF1xwkqN0us7ZobjkA6LFr1nWqKPsD+4gUHVBLOWwM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YZ/cvralRrwMOt03xelX6dubWip1mGHDCpCGkskWTKhFKwVjIaqsZL5Ni71bImB+YTtn8gXdfNb8pelsMTrLzThaJUR6e8vjgC/1gYyzUJ3rUfUlVe4UvRFtOXiy268yGCiiB8dPMWYHTSQkTv+MU5qeSt1PGdXNyuiVptUyH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrf5qWTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrf5qWTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CE01F000E9;
	Fri,  7 Aug 2026 22:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140338;
	bh=51p0XlU1+pEu/N4ijqHuGF/MwTtUdmmz6sTFt7v7zzI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jrf5qWTqCunu8/DMwgWYgPoTHS9R0fkMrL7KBemswTgPWYCTuUpSm7fJD7fX+W1uu
	 XdjvFoyZUdAlzlukF4k/f8B86KjOcNLhU+CaRhZxN9HNJ3XuYtRVBfJ+DCKFCuiSIW
	 58RgoVjyV+YeUx+w2Q2NtMc9g/Mr8naZ7nkhDlymYfJFgaYVJytoaqgVVwQJpFiqS+
	 P1W0d9oUOQxywPUyVWZKQp1zOkJxMTBehKL0wqMMzqEbRQ38QAFfuOmhQDpWmNs2N2
	 mblPwVOO0Thm3+3rxy7c3pclMU6q/nUaU36N8tYJ7B++C2HZ+dpMzFuWW5pTdxjzu8
	 yWcSdzeHgBN/A==
Content-Type: multipart/mixed; boundary="===============9176586124023585756=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a72e7c20020f3470a22de6ac06e51ce44e24fb2b65cee70528cec4de56ed7cf@mail.kernel.org>
In-Reply-To: <20260807204434.1036279-3-vineet.gupta@linux.dev>
References: <20260807204434.1036279-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: add --no-error-summary to skip end-of-run error log dump
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,yonghong.song@linux.dev,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 22:05:38 +0000 (UTC)

--===============9176586124023585756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index aa06bab30966..b274d98faac4 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c

[ ... ]

> @@ -424,10 +424,12 @@ static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_
>  	}
>  }
>
> +/* @quiet elides the human readable output, the JSON report is unaffected */
>  static void dump_test_log(const struct prog_test_def *test,
>  			  const struct test_state *test_state,
>  			  bool skip_ok_subtests,
>  			  bool par_exec_result,
> +			  bool quiet,
>  			  json_writer_t *w)
>  {

[ ... ]

> @@ -1462,7 +1472,7 @@ static void run_one_test(int test_num)
>
>  	free(stop_libbpf_log_capture());
>
> -	dump_test_log(test, state, false, false, NULL);
> +	dump_test_log(test, state, false, false, false, NULL);
>  }

This isn't a bug, but with the new @quiet parameter, dump_test_log()
now takes three consecutive bool parameters (skip_ok_subtests,
par_exec_result, quiet), so the call sites read as a row of anonymous
literals: false, false, false. The other call sites have similar
patterns:

In dump_crash_log():
    dump_test_log(env.test, env.test_state, true, false, false, NULL);

In dispatch_thread():
    dump_test_log(test, state, false, true, false, NULL);

In calculate_summary_and_print_errors():
    dump_test_log(test, state, true, true, !env->error_summary, w);

Would a small flags parameter (or naming the arguments at the call
sites) make these invocations more readable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31218024081
--===============9176586124023585756==--
