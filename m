Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AFD39C626;
	Tue,  3 Feb 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113635; cv=none; b=lAvNnanNyiZHxviCgeaqHe6eNVfXPnvXE8SqC9rNcV6B41xRimiyUaY4I1IoPkk3M6ORkXrYbzqwXdpzRGjwtB+NobqwZAvA8TG5icG1dkwP8ltfhX2eCNsEcFfqBuERFmaWwlb4rqSPwHOUfPTJYyrf9XMolbBMevBRl5DAEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113635; c=relaxed/simple;
	bh=1h0MZLglRRwXDdr7ohwTbBSyhYXXX46bnWf57fAx2WA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CGO1jrl0bDKTMfykWHfjfTEKy52SoFBbN2otv7oN/E6rm+LYvZb0+Z85Kl3Jo7gsbQEOBwNtTFkDW9NHmrwnNehtCPZ9EExDEzPXgLLeCYsIThDQpg4jJdOlmhp7dHLNGwszQub+BMGehymiiBpyV7+ZHXZvJzIoIwrNRfm2VYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHoLipoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHoLipoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61280C116D0;
	Tue,  3 Feb 2026 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113635;
	bh=1h0MZLglRRwXDdr7ohwTbBSyhYXXX46bnWf57fAx2WA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oHoLipoN+ckQHvDzL76XK4wCBOeKM8tmHz5YE+4DwubvhNx2+hnFOa3BA/yPJ8V62
	 U2WO55xaYL70pa3Rz6OPWzqB8Apkeo6ivpWQdcjKIsZ/K/ozxEpfw7YxB+H2U9vHFG
	 2zd2sqN9nAJB2Rla7zWSonDDuwZUScZlbN2RM0yz3xUG7zcydhhWpQutGiXF//hfQb
	 Y3n5ND3LO1LQN4ct7x4NMsvnkL7lzYu6CcLOD7pIdWcQ2w3sMRj/HB4ftrWa6L2q5e
	 26RKg56cdRp8WF1Zx5VM+veM3L+z0JvakuwkcFYlPZ8crTkhr3osgKJa2ZR09UI4TA
	 z9GJEa8VqGiQw==
Content-Type: multipart/mixed; boundary="===============5549325204459829390=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd5126aaea4095fde41096caf553d7ab7c42efc42ee2bf8a5897be48a0e66a41@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-11-jolsa@kernel.org>
References: <20260203093819.2105105-11-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 10/12] selftests/bpf: Add fentry tracing multi func test
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:13:55 +0000 (UTC)

--===============5549325204459829390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> new file mode 100644
> index 000000000..e5efa9884
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c

[ ... ]

> +	} else if (ip == &bpf_fentry_test3) {
> +		char a, b;
                      ^

The commit message states "We need to cast to real arguments types in
multi_arg_check, because the checked value can be shorter than u64."

Should variable b be declared as int instead of char?

The kernel function signature is:

    noinline int bpf_fentry_test3(char a, int b, u64 c)

The second parameter is int, not char. While the test passes with the
current test value of 5, this appears inconsistent with the stated goal
of matching argument types.

> +		__u64 c;

[ ... ]

> +	} else if (ip == &bpf_fentry_test6) {

[ ... ]

> +		e = (void*) value;;
> +		if (bpf_get_func_arg(ctx, 5, &value))
> +			return;
> +		f = value;;
                      ^^

This isn't a bug, but there are extra semicolons on these two lines.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel conventions with minor human-typical inconsistencies, and the author is a known BPF subsystem developer.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Minor code quality issues in test code: a type mismatch in variable declaration and extraneous semicolons, neither affecting test functionality.

--===============5549325204459829390==--
