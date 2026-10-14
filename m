Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FA3B0585;
	Wed, 14 Oct 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979712; cv=none; b=Qkg8GqXVIvQAcQvH/VY/yipLODCxsGrZqkFR/XSQvX8hyxlkQ2Lmt3rrRQcvqZeJYPSFDZPqNcdCwyZDNp/yuzERfCuxLkVXCn5vWlYMOg1QJtyZBVLc4ZLkdUDg9XCOJcwBLIVrC5e+Q/XCG5t+cHBaGif+QRpxIxVwnGI9K7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979712; c=relaxed/simple;
	bh=8srh08bJ65OMJv4V0T3YCQy/3UpU/gzsPkXQtZerZPw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G0nEevaPrjL6IX2N96hhTLRYZcOHNbAWfgEMkndLnkNxdX+qW2s6WJnQHGKlvrTsh0W0Sf1AEzM5Im5R/C1/ydIEbE8xIli3Y54zWM8mnj1KqLitMbpJBAUcExAf7Xuw84R4qL9MK+nRxOX6M8ip4srKJZ1Z5kD9Q37U2Xt6d2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ2XUk68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ2XUk68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDE11F00893;
	Wed, 14 Oct 2026 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791979710;
	bh=RkPzH8AiUmVWxmo+r8PBPfKDIWyGTyfyapAMQW+wpTM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MJ2XUk689T956w2OMUQGjcny5Yk/kSD4bhOq0hjk76MH7O5XP73tzpi2JUO2HT230
	 uAuUeuAzB3PoxgdbddmMpc2N95VrguF4hf5MqznZ+s9qFmF/u9aeT9bZbRM7XYgaGf
	 wvx45vJOmKNjD6PdVBxRshVk1R3+GB+QPAr0xcAnCmxzidITWtGvjD2mmSFu3Nv135
	 WBcRe6w4hKq7513yIm6VOjChl1geqR28pbziEQLreKJjWWvBJr368yeBcVxGZEhwx8
	 fp+vdRCmRWwC3PV11trUWm8LLkmC0MNPdurF2MCrMq8hWLKbmJPTIUAnntPP98rATS
	 LTYpa95E1EcVA==
Content-Type: multipart/mixed; boundary="===============0467513707440129016=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b00556c5b846e17d2f940c8b007b64b37dc24219d9c0a31ebbfbedb02f74ea3@mail.kernel.org>
In-Reply-To: <20261014113043.640435-7-kafai.wan@linux.dev>
References: <20261014113043.640435-7-kafai.wan@linux.dev>
Subject: Re: [PATCH bpf-next v2 6/7] selftests/bpf: Skip expected_msgs subtests when stdout is not saved
From: bot+bpf-ci@kernel.org
To: kafai.wan@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,donggeunyoo.kernel@gmail.com,leon.hwang@linux.dev,kafai.wan@linux.dev,menglong8.dong@gmail.com,yatsenko@meta.com,jiangfeng@kylinos.cn,bjorn@kernel.org,puranjay@kernel.org,vineet.gupta@linux.dev,mykolal@fb.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 14 Oct 2026 12:08:27 +0000 (UTC)

--===============0467513707440129016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Skip expected_msgs subtests when stdout is not saved

TL;DR: Nit only: the new test__skip() in the expected_msgs selftest is silent,
so -v output doesn't say why subtests were skipped; the review asks whether to
print a short reason. The skip logic itself looks correct.

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> index 53347f379924..b4cd7c7ff439 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c

[ ... ]

> @@ -169,6 +169,12 @@ void test_prog_tests_framework_expected_msgs(void)
>
>  	for (i = 0; i < ARRAY_SIZE(cases); i++) {
>  		if (test__start_subtest(cases[i].name)) {
> +			if (!env.subtest_state->stdout_saved) {
> +				test__skip();
> +				test__end_subtest();
> +				continue;
> +			}
> +

This isn't a bug, but a subsystem guideline flags a test__skip() that is
issued silently, with no message.

test__skip() here is called without any explanation, so a -v run only shows
the generic "#N/M <subtest>:SKIP" line from test__end_subtest().  Someone
reading that output has to look at the code or the commit message to learn
the subtests were skipped because stdout is not captured in non-parallel
verbose mode.

The skip itself looks correct, since stdio_hijack_init() returns early when
verbose() && env.worker_id == -1 and leaves subtest_state->stdout_saved and
log_buf unset.  test__skip() takes no reason argument, and many other
test__skip() callers in prog_tests are also bare.

Would it be worth printing a short reason before test__skip(), for example:

    fprintf(stderr, "SKIP: stdout is not saved in non-parallel verbose mode\n");

>  			error_cnt = env.subtest_state->error_cnt;
>  			msgs.patterns = cases[i].pats;
>  			msgs.cnt = 0;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38559567568
--===============0467513707440129016==--
