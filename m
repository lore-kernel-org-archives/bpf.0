Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6A40855
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742547; cv=none; b=nl3Y2DT+fHHETE6EyopHMYGGzTVWwG+CB5Ap8xTRqIJiujDdp55X8gJWsj0lh9HOCHXa9WGY4WYAg879XX07S7RKdrXwYFfYR1ticg4Y7nzHZQ5mqT31ZP9I35zpTv2Q59McFkloYjsxTMw/CVWAqg7xF6ZTL4uWoIK61fpVfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742547; c=relaxed/simple;
	bh=weK8sD6lcPva7/knSegaeoRf+ram8jaIrm0xX1NICzg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tlf/h2ifv2Xgywql6AMk9yhAL6Y/c5BT7xw7aBOV7AL89+5R4HNuPQFpd4KgyIKmRlBvq42sKmMg0frZ8QXXGfGy9r/WmnRo0DsfC0ATP6Y74Xg4NMX+fkO5jThcAaUoCjtWVManbVi/VZZz49RzvsYUJp6p7dDBCejWLyfssgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmlJ0uTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmlJ0uTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996921F0089B;
	Sun, 11 Oct 2026 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742545;
	bh=K3P7hxQHyfbccUervGCZcEwBb6pcTM+GpbCsLAfOGy0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FmlJ0uTKZQnYALDRnm3WVQyvbnXN5Gs+w9QblrL+eZ2seITpW4ZMMFZgRPOJOjaem
	 xuPY71LYq7SyVbVKOS0e9OGzbLM70XvX3yeVFqPsfv/YbgZECtC1zl7GTmH4Uv+gNC
	 ZIAK+6tvZYfPQjbZvrMNHI31gEbX2144xAKl3kGLsMtrrHwUWKzi+O2E07oYBtRAKL
	 sxIT2r8K7AVIR32IfmJwpX81Qy+bDerWtJXAhRsknoupNpc1VKzD9Soxk1cZfQGVcQ
	 wP4a5+/yuo5xFHryHWgwGmddTPOYRFl0W6y4gB30iZCYUvW1CsUK4iSbq1r+eHmDpg
	 ArodNM8eQO4qw==
Content-Type: multipart/mixed; boundary="===============5233060581224098274=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d51031962737267f48d83c86738616656b3024c9c7bed42330c77b3c6936cae1@mail.kernel.org>
In-Reply-To: <20261011164836.2233874-3-alexei.starovoitov@gmail.com>
References: <20261011164836.2233874-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test tracing_multi link with BTF ids of the same address
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 11 Oct 2026 18:15:44 +0000 (UTC)

--===============5233060581224098274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test tracing_multi link with BTF ids of the same address

TL;DR: Test nit only: the attach_same_addr subtest skips without printing a
reason, so a SKIP is hard to interpret. A printf() before test__skip() could
help, though the review says a bare skip may be acceptable.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c

[ ... ]

> @@ -662,6 +662,97 @@ static void test_attach_api_fails(void)
>  	free(ids2);
>  }
>
[ ... ]
> +static void test_attach_same_addr(void)
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	struct tracing_multi_fail *skel;
> +	struct bpf_link *link;
> +	__u32 ids[2];
> +	int i;
> +
> +	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +		return;
> +
> +	if (!get_same_addr_ids(ids)) {
> +		test__skip();
> +		return;
> +	}

A subsystem pattern flags this skip as potentially concerning.  The
selftests guide says to report a test that skips silently with no
message.

When get_same_addr_ids() finds no __x64_sys_X / __do_sys_X pair that has
BTF FUNC entries and shares an address, test__skip() is called without
printing a reason.  The commit message says which pairs exist depends on
the compiler, so this skip can happen on some toolchains.

Someone looking at an "attach_same_addr:SKIP" line cannot tell whether
vmlinux BTF lacks the aliases or kallsyms did not resolve them.  Would a
one-line printf() before test__skip() make the skip self-explanatory?  For
example:

	printf("no __x64_sys_/__do_sys_ alias pair with BTF ids\n");

On the other side, test__skip() takes no arguments and the framework does
print a SKIP line for the subtest.  A bare test__skip() is a common idiom
in prog_tests/, and this file already uses it twice for the non-x86_64
skip, so this may be acceptable as is.

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38159103930
--===============5233060581224098274==--
