Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AB355058;
	Wed, 11 Feb 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801237; cv=none; b=Wb+1PBlkUYR5CaPFvYhMFUPACAT+3bG6i13oYrfjOIBx98eOb6BDQjiZ6UZzLKi9Qm98uWiDl0rEdIFdXlX/cAhqLW0FTO5fGLAqFj9XHQHRniG48QeiyFszpMN6Nzw1/YO1hO58WcatwMCH+LX88smRZ3OmsVVaq7rAylHyFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801237; c=relaxed/simple;
	bh=jNlgvzf8r1rQ4Ylev5DBYztIK9dHpUIDgD9CjTGsq0M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GWoaWqd9sxSe/XwmXBBpKwvpaFf0aJlOCXlcuZG+AJ++6zCURJRaq5ui54Tu6B3erhZVzI4unMrMqJhA4yIVtUgd+c+Wr/ANASwwvrxFTna5r+czBF4jxOR9ppOO7lTxNVXS6S+0m7JlYRbjkyFZW/PI4nZ8EKwbegQni484zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U23KCS0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U23KCS0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE907C4CEF7;
	Wed, 11 Feb 2026 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770801237;
	bh=jNlgvzf8r1rQ4Ylev5DBYztIK9dHpUIDgD9CjTGsq0M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=U23KCS0zPPSDB/i5bueZEe6YJcYrZaegFg1QtzZ1WZ4LfaDLWvEjXwjqH6ct6HPaC
	 Gi1g8S2hV9+RZSdclqWQH6BZTQ9lA6omlGTqe1jkku2R9oZLF83DPqars1sQJsFv+W
	 ySUsAgZPYU5iV1IbQtgQF5HZJQUUm8ta1bVeHcscPE5KhPGFB1LtDjUO0YGj49Er25
	 ISW1FoyA34KOsVraiV6IYGZOlrzEvqL3GbP8pFFf2hq6P7Fud7cgbuz6wkPQxRYcOl
	 vyJ1kTVNeanDDz+yDu1dGydrHillntUz24FNJsImHfj4LLvrrmCepfCNZOE7R0E6k7
	 OgnoBQUItH47g==
Content-Type: multipart/mixed; boundary="===============5553883724585232446=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <81ed1ebeb5d6e1661ccc0804079f31ec57653ba10477b453c88ded2bb2f85945@mail.kernel.org>
In-Reply-To: <20260211084858.750950-5-jolsa@kernel.org>
References: <20260211084858.750950-5-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 4/5] selftests/bpf: Add test for checking correct nop of optimized usdt
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,songliubraving@fb.com,yhs@fb.com,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Feb 2026 09:13:56 +0000 (UTC)

--===============5553883724585232446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c

[ ... ]

> +static void subtest_optimized_attach(void)
> +{
> +	struct test_usdt *skel;
> +	__u8 *addr_1, *addr_2;
> +
> +	/* usdt_1 USDT probe has single nop instruction */
> +	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
> +	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
> +		return;
> +
> +	addr_1 = find_instr(usdt_1, nop1, 1);
> +	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
> +		return;
> +
> +	/* usdt_1 USDT probe has nop,nop5 instructions combo */
> +	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);

This comment says "usdt_1" but the code operates on "usdt_2". Should this
say "usdt_2 USDT probe has nop,nop5 instructions combo" to match the code?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21898612624

AI-authorship-score: low
AI-authorship-explanation: The code follows standard kernel selftest patterns with natural commit message style, and the copy-paste comment error is a characteristically human mistake.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Comment/code mismatch in test file where comment says usdt_1 but code operates on usdt_2; does not affect test functionality.

--===============5553883724585232446==--
