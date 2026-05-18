Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303637701E;
	Mon, 18 May 2026 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104275; cv=none; b=Il//xUawDMKarbJEeo8ixMJ/ApYkVuDnbXYfjwMre2m1PClFEz1u98EBZPFnrqCfWsRToYt8+BgJqYZMyfyTECDH647SHNegV7XGNKrS+0Py4WT04ibGU+dnmeUOPMBQJJQPMMv1QxsPdikhA5Ez04gSLmsxN0zYMjCwFKVslxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104275; c=relaxed/simple;
	bh=mFLKcdF4mD5W12oxSsunvkQ48zPBB3c4dIipCb/DAMk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nr7hSXXN3iXsv2SmjMS0Iynyu49Pmf/viQr4BeEcPLbBjbQM9ZBrJfVf3OUlFoFdMu0SWdaGbbmwhzJBrvief2ddESqjwA+cQjRf89bkJN7+0JVUSdGzfXEmSd6N2jOy8MMCWjRD7W6v4etvzt18tUJYZwICOT0oHeUm0eVCo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+vocIlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+vocIlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAB6C2BCB7;
	Mon, 18 May 2026 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104274;
	bh=mFLKcdF4mD5W12oxSsunvkQ48zPBB3c4dIipCb/DAMk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W+vocIlb2xWrQVB/sX9E/vh+b6zGWMW6vY1BM6XYwqrO7yt7MjoQiuV9ANjw9C7hP
	 c5akx+fFU2eNVcmvSQ2343nNc7XXuC90PA876LgfQ7bZg8ZGVk87Fmju889eGX3bvL
	 7YspebOkUv79tyovHWfUIept7DUSec2F6uXWxen33cRRHQN6ss4piE9qWMJeemsBLo
	 mBTGI1G/kxGtjo7qELqsJ/s4ZEiFk+o+DBujVQcHgUlK74qfcMyUfi1R2H2pU41zEG
	 rdMLALN8N2YOQ/AqAOP6Y4GoqHjGb96rQJVW1ZINBfYbj18nBo80oPx8qXdL9pOFMa
	 L/GvhM9IhzoKw==
Content-Type: multipart/mixed; boundary="===============1181080246465089822=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <545ca16cc113f00a390baf1ffcafba33233af771fc7c879e3c850bb33949da29@mail.kernel.org>
In-Reply-To: <20260518105957.123445-6-jolsa@kernel.org>
References: <20260518105957.123445-6-jolsa@kernel.org>
Subject: Re: [PATCHv2 05/11] libbpf: Detect uprobe syscall with new error
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 11:37:54 +0000 (UTC)

--===============1181080246465089822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Detect uprobe syscall with new error
>
>     In the previous optimized uprobe fix we changed the syscall
>     error used for its detection from ENXIO to EPROTO.
>
>     Changing related probe_uprobe_syscall detection check.
>
>     Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>     Fixes: 05738da0efa1 ("libbpf: Add uprobe syscall feature detection")
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The Fixes: tag points to commit 05738da0efa1 ("libbpf: Add uprobe
syscall feature detection"), but wasn't the bug actually introduced by
commit 5c3c59c7952a ("uprobes/x86: Move optimized uprobe from nop5 to
nop10")? Commit 05738da0efa1 originally added the ENXIO check
correctly, but commit 5c3c59c7952a changed the kernel to return EPROTO
instead of ENXIO, breaking the libbpf detection. The commit message
even says "In the previous optimized uprobe fix we changed the syscall
error," which refers to 5c3c59c7952a.

Should this use:

  Fixes: 5c3c59c7952a ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..e5641fa60163 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_fd)
>  static int probe_uprobe_syscall(int token_fd)
>  {
>  	/*
> -	 * If kernel supports uprobe() syscall, it will return -ENXIO when called
> +	 * If kernel supports uprobe() syscall, it will return -EPROTO when called
>  	 * from the outside of a kernel-generated uprobe trampoline.
>  	 */
> -	return syscall(__NR_uprobe) < 0 && errno == ENXIO;
> +	return syscall(__NR_uprobe) < 0 && errno == EPROTO;
>  }
>  #else
>  static int probe_uprobe_syscall(int token_fd)
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52..c944136252c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -762,7 +762,7 @@ static void test_uprobe_error(void)
>  	long err = syscall(__NR_uprobe);
>
>  	ASSERT_EQ(err, -1, "error");
> -	ASSERT_EQ(errno, ENXIO, "errno");
> +	ASSERT_EQ(errno, EPROTO, "errno");
>  }
>
>  static void __test_uprobe_syscall(void)

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26030080109
--===============1181080246465089822==--
