Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673049;
	b=e0fSf+IoDH6gi3m3Hxh2Hxwd1PkJQbx/x0sgvbIR3qFZM6kJG3iEiasl/XsvFVycwH33
	 LMhXpl8FWjfZ2wuFQQYH+O917dz+FqYlyPmmlRbhnZn6bSFiPts9TN7brbwps7qA2htk0
	 48UYcYSAwED0JF+CDOcavh+Dt16nKqAte5MisYA+BjYKxFnsU9knGtYdZrUYMVJzwWgLl
	 Ae0rK+14Gbxv9kmn9Fpmzy/oGm/J8mwdoUKckRKJ5IjAj2kGHRtEodjFZIa6PIAnYAtOm
	 bEk9g+YI7hh4SwCVyuNHSMnDpzcUnvYngfeZFqLgAs35RY7P61C5VcYz6QLTWeaKcaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673049;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=a6EMyBFfNowmG5YNJ/9G4LYrXwUhOiBFWZ8ljyUI6b4=;
	b=1SZwYYnNzGFDEbS9QQ7lJ7yxWaJV5ox7QKq7iDvKtI5nKyvPqO+6zEUMeiH2v75HySG6
	 lQgYoOBClDTsFoZKeNqHk2Sip5euxJwYan9aa7br97HPqNiHefH9RB/25wFYpqJok7XH3
	 ecXprMnIMeLyN+uCY76hRZtWDL7aHqjOsDtqGPec6kd5M1SZdJlPqmTih/ZZ20tNKtYSD
	 JUNIhKwjbGJtCKQbdBYKv3W8frZxHfXj3JFWkyPM24Kz48wKKotK0Mm9eKEByXMFkIduV
	 VkzpV8Ka/UztyWyHxzX7vGdLufndHQyq9XK6z23tgMN7AyBQvis9/PhhbiEHZ/sTnpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PYeK9/Uu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6D606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYeK9/Uu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E931F000C2;
	Thu, 22 Oct 2026 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673048;
	bh=a6EMyBFfNowmG5YNJ/9G4LYrXwUhOiBFWZ8ljyUI6b4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PYeK9/UunPmVIxKJiuXvkcvXNxsBLQh6t8JTn6KYOTnIjkuaNQrUyTE87uO/Ac1uc
	 5dpSS9M1EuZT/6FloqMd8Iw4dVLRS5foo/d3BsBxstcrMhYz0jAGqhlfSbf46y1PlZ
	 zXGusOyYwjPbIyAqBh2le/dEGjPHHcVGR8nya8gc3hoShFJ3pZBvog4nCBflj6fkZW
	 cWSN1eskI0yZKLvRSMmzvP0Zx8/wqRN+i1uP/cU1oZXv9Ue1SBXSDze4tv/3cuYnsB
	 qz+cIDqZaTCA8CRjuI8UDq0CRfmwRs4UyeRWyCDVKeGvNvsvYgVKjQmrJKLaegEelI
	 TVaUgcqQQUbcA==
Content-Type: multipart/mixed; boundary="===============0872173899795700015=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6896375813cf93e6e3c7ae7a8f329d9fa73568dadcb55b7ab364e5c18ce817c3@mail.kernel.org>
In-Reply-To: <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
References: <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test JIT jumps which change at a repeated image length
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 12:44:08 +0000 (UTC)

--===============0872173899795700015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test JIT jumps which change at a repeated image length

TL;DR: Test issue: the new jit_insns subtest asserts the program was JITed, so
it may fail instead of skipping when no JIT is available (JIT disabled or
unsupported architecture); suggests gating on is_jit_enabled().

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c

[ ... ]

> @@ -2881,6 +2881,63 @@ static void test_convergence(void)
>  	}
>  }
>
> +/*
> + * On x86-64 a backward jump sized from its own previous-pass address grew
> + * here while others shrank, so two passes gave the same image length with
> + * jumps still changing. The fillers are 7 and 2 bytes of native code, the
> + * conditional jumps are never taken.
> + */
> +static void test_same_len_not_converged(void)
> +{

[ ... ]

> +	int fd;
> +
> +	fd = load_prog(insns, ARRAY_SIZE(insns), "same len not converged");
> +	if (fd < 0)
> +		return;
> +	ASSERT_GT(jited_len(fd), 0, "same len not converged jited");

This isn't a bug, but should this assertion be skipped when no JIT is
available?

jited_len() returns 0 when the program was not JITed, and test_jit_insns()
itself is not gated on is_jit_enabled(); only serial_test_jit_insns_blinded()
is, and it calls test__skip() when there is no JIT.

On a kernel without CONFIG_BPF_JIT_ALWAYS_ON and with
net.core.bpf_jit_enable=0, or on an architecture without an eBPF JIT,
__bpf_prog_select_runtime() falls back to the interpreter.  The load
succeeds, jited_prog_len is 0, the program still runs correctly, and this
subtest fails on ASSERT_GT(jited_len(fd), 0, ...).

Other selftests treat a missing JIT as a condition to skip or ignore, for
example bpf_obj_id.c:

	env.jit_enabled && !prog_infos[i].jited_prog_len

and btf_rust.c, which calls test__skip() when !info.jited_prog_len.

Would something like this keep the check for JIT-enabled setups, where it
catches a silent fallback to the interpreter, without failing when no JIT is
configured?

	if (is_jit_enabled())
		ASSERT_GT(jited_len(fd), 0, "same len not converged jited");

> +	prog_run(fd, 1, 2, 11, "same len not converged");
> +	close(fd);
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39777661721
--===============0872173899795700015==--
