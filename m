Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F9225A38
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430184; cv=none; b=cK6mZDhOkksUNgkptGI6DAfYYHmksvTg8+OuQ7nTWfReH7XEX9BPGLR5rmQNDQ76ytFOqGxs8gNzucWFweR3CkOcuh8NqsaGkajzKDqBiMoscW6MPSgSuVsUzLF7rchKdkS8+NS63CSisUM+IaswEw8rsXZkYgq+qIuinWayzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430184; c=relaxed/simple;
	bh=UBr3As8VuTlZ3p0+z3f6dBPX/TCdYOlHEfPJsaqzM+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cP4ku7KUYA0tSokDY4YqpzkOMJzPuTfYrb8ZXoPsd5AoCxHYqaSZJU5YVX1dDpZxS8Y7Jev8WpQDQp7RvAsdjajFAtqMK3/O2axRb2BC7HyMZfOJi2Ba82yH/gF6C2PkzU4yu6UGKNnycGeqXjJNK/q1YN/7DEtVYMnJQWFFGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/6pyNky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/6pyNky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73482C2BCB7;
	Wed, 29 Apr 2026 02:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777430183;
	bh=UBr3As8VuTlZ3p0+z3f6dBPX/TCdYOlHEfPJsaqzM+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W/6pyNkyUXDwbhz43C11S9K2kZIxlI8+Iy7LjWmw8OMkcPfTOSfkEm3ufCV3Ygk1V
	 2ZJYw1jVS1L2iEDcjKrXinPBd/6PYuFiLM+NczvAG/cKH/QNgFFjUXBRuxrKBpE/F9
	 JFjhbjMmUR/TbAq7bTvFcYaQJ9QSI6IdBtx6aUcBPQsu6JoeNxpFhW1fqGVeAJ33LT
	 OQk/GH6d7/M7lVXMiDBGsFpKEWjR4gdE+17G3rJIXuYXzsdQpsM5Hok76MQrg1Xc9m
	 HZ2QU4UFtCOr10x5FS3gcEavA8N7xJMspdnSM1rMMQmIIYAr8l58ujpomdq9SbdunI
	 fqQL1WyM0yaWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test insns processed
 breakdown
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <24f2a5b5f8e3041d03d78305ca0e2277f684d588.1777398528.git.paul.chaignon@gmail.com>
References: <24f2a5b5f8e3041d03d78305ca0e2277f684d588.1777398528.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 02:36:22 +0000
Message-Id: <20260429023623.73482C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Asserting exact verifier instruction counts in C-based BPF selft=
ests causes test flakiness.
- [Low] Unused test configuration from blindly elevating log levels to 6 wi=
thout corresponding assertions.
--

commit c4e03a953efa7cd8cf2e1a288a0c55c4f73cace2
Author: Paul Chaignon <paul.chaignon@gmail.com>

selftests/bpf: Test insns processed breakdown

This patch updates global subprog selftests to verify the new verifier
log breakdown of instructions processed by global subprogs. It does this
by increasing log levels and adding new message assertions.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 1e08aff7532e..7092a046c018 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c

[ ... ]

> @@ -186,21 +187,24 @@ __weak int raw_tp_u64_array(u64 *ctx __arg_ctx)
>  }
> =20
>  SEC("?raw_tp")
> -__success __log_level(2)
> +__success __log_level(6)
> +__msg("insns processed 12+5+2+2")
>  int arg_tag_ctx_raw_tp(void *ctx)

Will hardcoding exact instruction counts cause the tests to become flaky ac=
ross
different LLVM/Clang versions or optimization levels?

Since test_loader.c natively supports regex matching within __msg using the
{{...}} syntax, would it be more reliable to use a pattern to validate the
log format?

For example, __msg("insns processed {{[0-9]+(\+[0-9]+)*}}") might prevent
failures when the compiler generates slightly different assembly.

[ ... ]

> @@ -321,14 +331,15 @@ int BPF_PROG(arg_tag_ctx_fexit)
>  }
> =20
>  SEC("?fmod_ret/" SYS_PREFIX "sys_nanosleep")
> -__success __log_level(2)
> +__success __log_level(6)
> +__msg("insns processed 7+2+2")
>  int BPF_PROG(arg_tag_ctx_fmod_ret)
>  {
>  	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
>  }
> =20
>  SEC("?lsm/bpf")
> -__success __log_level(2)
> +__success __log_level(6)
>  int BPF_PROG(arg_tag_ctx_lsm)
>  {
>  	int ret;

Is the log level increase to 6 intentional for arg_tag_ctx_lsm and other
similar tests in this patch (like anon_user_mem_valid and arg_tag_dynptr)?

These tests don't appear to have corresponding __msg assertions added to
actually verify the resulting stats breakdown, which might just add
unnecessary overhead and log data to the test execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5c3514dbc879f22ba3f=
9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com?part=3D2
