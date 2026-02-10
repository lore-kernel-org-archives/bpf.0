Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1733366DC6;
	Tue, 10 Feb 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732730; cv=none; b=gZf2Qzkir4jFA7jN7hlnhnAIh/r32Y3tDtlStXv/3yN44AashFA0+D8RtCoNhh3UCfPc0zrR+1f06nnAsGyMjiqH8shW6rHsJeWFvoymQhg92c3Ec3Y1KJfXskinnN0eTRFJgzJ8FUjhQOrnBTE6OzszEdxNzgB3OoEFD/M1NEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732730; c=relaxed/simple;
	bh=erDlkinvoJfZplkTIRgKMkz/La6E009uV3O1gxUqF8s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sG+2afeYJ7rz22iRl9Qd/ASGbwxpknwBRiOCqGr9Q72mOOWsmPsi+UrOPreaW+XRknRScLKwbL6rCorY4nRkhhrUiSX9biw/h3Q7Vn75h+56tbbYJ7x0tEhUOlQaS6fMqywJSfbAVGalh673mCrmQfHmx2yKZk4lGdwAUpjYHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E32YNz+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E32YNz+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D13AC19423;
	Tue, 10 Feb 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732729;
	bh=erDlkinvoJfZplkTIRgKMkz/La6E009uV3O1gxUqF8s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=E32YNz+B4+iEJvQXVMHi4RiU0zVw5p++wGI7j+fxu3W4txXPxQVsxY6VpH1p1f133
	 a4MlupvxRKqeIhzkwoEST67VWBOZ/BEkyxlvhoUdOp7DcX8G2ekWamFcdsYR//+a85
	 ECQV0TUIAQLHoBRFi6v9f+VLtBatXnN/O8a9Ze1QsXS4D2En/kyo/u2fIj2tX9prNt
	 wdTWt98BFMsz/LpGZi1MMhO58bC4b5S96VqikaSyNiR0xpr467YgojdsJ7UCpN98BE
	 xT8ZJK3UXZ/gRbl8HIgG4X/Y5HruQbQF62+F3elgx5bJTOBq7sEpNZIb0xL7oYLvcu
	 NUzzWbOCZy2Tg==
Content-Type: multipart/mixed; boundary="===============2032293975303444444=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <189eab8445c1c9fa3b7e4c6dde23b4a30dc7f63ed2d3df62a1f8c889280f5927@mail.kernel.org>
In-Reply-To: <20260210133649.524292-5-jolsa@kernel.org>
References: <20260210133649.524292-5-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 4/5] selftests/bpf: Add test for checking correct nop of optimized usdt
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,songliubraving@fb.com,yhs@fb.com,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 14:12:09 +0000 (UTC)

--===============2032293975303444444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c

[ ... ]

> +#ifdef __x86_64
          ^^^^^^^^
Should this be __x86_64__ (with trailing underscores) to match the standard
GCC predefined macro? The call site in test_usdt() uses __x86_64__:

> @@ -516,6 +599,8 @@ void test_usdt(void)
> #ifdef __x86_64__
> 	if (test__start_subtest("basic_optimized"))
> 		subtest_basic_usdt(true);
> +	if (test__start_subtest("optimized_attach"))
> +		subtest_optimized_attach();
> #endif

Without the trailing underscores, the function definition will not be
compiled on x86_64 while the call will be, leading to a linker error.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21867569087

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel selftest patterns with a natural coding style and contains a typo characteristic of human error rather than AI generation.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: The mismatched preprocessor macro will cause a linker error on x86_64 builds, preventing the test from compiling.

--===============2032293975303444444==--
