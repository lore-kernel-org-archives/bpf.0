Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60023FC41
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854892; cv=none; b=TzWWMtT+Sc/5NfPcrXOItDBSgmnFWueyVTvVSGOWIXEpH27xFej6lC93u7Szhik5Q/Ix+DVb4I3Kw0jrfl3CKEPn2D5FzWS6rQ5lSJqRLLXAswu0V/JoZXeGtcmyz8x+Qi1t0Vrm6X4/J65KMhGEozHa1TOj9poxoN4csZH49V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854892; c=relaxed/simple;
	bh=ZcbZWpIPfEUZojHqSNlJG8dhIh3rR+sfdVwVQn9dcU8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B9WCf3041doaqfHA2giuSh9KUbkQb7uKR8yvNlxCE0TXHHk4a1QeswR8+H/tvG+YFHCy50RMSaI9vrhdx5KKNHVv1C/U3LLAWEexvDBsg0zZ4nUpNXpctPc6LOT2WWgMmETxuyEyT6wabPowJ6V9qZ0c2NdQGa5qNCXKdKGDy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDovUohi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDovUohi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB441F0089B;
	Tue, 13 Oct 2026 01:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791854890;
	bh=+XJg2hf1Xe2zkdjKU+CHlYb32t8u9d1nDXUr3jcLOfo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aDovUohiXNWzHtX7eNPEFBCOL24JjLnowouJ+M+CXZ8XONE8mIKNjTQO4EMB7uP47
	 Avc/WJyHqbSrBI/DK3iaERIDbDwnOiLmlYoVKTz2kXbsI28N9AiCzZSgJ/fk7xNSlU
	 j0qsYPLtIQP5cHKXylapMR+4/ke3pHnz7bJL6waQcm1j9TPk9FZizm2DhIzJL1qFu0
	 ndsKO+DoqEwZcHmkMH/zGSiUIRgv6RmVr5eEQ/iZZBc4EOw2q15mQOY247DymCfzjG
	 nQ4EPStncDUyJE9/zuho/fnUiZ0IIt0KPm9TeaOm9JedPXyHkGDgMOtEzgwdIt4v4K
	 6zNkw3tsmxX+A==
Content-Type: multipart/mixed; boundary="===============7385103576608012665=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1e2e14c0e37c53d1bee32ec10d50b60f46c645c37b2b1cbf832a66c8fb84967@mail.kernel.org>
In-Reply-To: <20261013003515.1860439-1-yonghong.song@linux.dev>
References: <20261013003515.1860439-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: Test trampolines on more BPF functions with stack args
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 01:28:09 +0000 (UTC)

--===============7385103576608012665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test trampolines on more BPF functions with stack args

TL;DR: Nit only: the callee_split() comment in the selftest says h is split
between register and stack, but that is x86-64 specific; on arm64 nothing is
split. Suggests saying so.

> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
> --- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c

[ ... ]

> @@ -44,6 +44,25 @@ static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
>  	       i * 10;
>  }
>
> +/* BPF code splits h between the last argument register and the stack. */
> +static __noinline __u64 callee_split(__u64 a, __u64 b, __u64 c, __u64 d,
> +				     __u64 e, struct int128_arg h, __u64 i)
> +{
> +	return a + b * 2 + c * 3 + d * 4 + e * 5 + (__u64)h.v * 6 +
> +	       (__u64)((unsigned __int128)h.v >> 64) * 7 + i * 8;
> +}

This isn't a bug, but is this comment accurate for every architecture this
test runs on?

test_int128_tgt_prog() is built for x86-64 and for arm64, and a..e already
occupy R1-R5 in BPF terms, so h and i are each stack arguments as far as
the BPF ISA is concerned.

The split between a register and the stack only comes from the x86-64 JIT,
which maps the first stack argument slot to r9:

arch/x86/net/bpf_jit_comp.c:x86_arg_reg[] = { BPF_REG_1, ..., BPF_REG_5,
X86_REG_R9 }

On arm64 the first three stack argument slots are mapped to x5-x7, so h
would land in x5/x6 and i in x7, with nothing split.

The commit message already says "on x86-64 it is passed split between r9
and the stack", and the comment on the neighbouring callee_stack() names
x86-64 and arm64 separately.

Could this comment say that the split is x86-64 specific, for example "x86-64
BPF code passes h in r9 and its first stack slot"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38329598343
--===============7385103576608012665==--
