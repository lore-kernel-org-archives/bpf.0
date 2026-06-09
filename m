Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2073AF646
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999366; cv=none; b=VxCpiZtFTb6dRbyApm2W6PQniSgmu9tVwN50bdQ44MxXi6Mk2HOfiU0E0z/aYsgkqeJnikv2O1hR60CBMwC5H8a2/jW8P7cPon0uBf7ZaVidYIhNA8D64gAjN8YdB7KIa4Yu1iZbVuAVt3onhJN9X+K2tMw5W+rJMDtp2eNQL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999366; c=relaxed/simple;
	bh=RwwlXsYWpv5/4HOh1nA1cNBwZh9t5+NRbiiZssh73xQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqciOd8VVT3DsnM+fQI21YcQj+xOT312Ce+2Uck50avNVTJjVRLZf6SWC3qjAKnx7xTJ8EcGRz0tBg73Zk16kluZWwWthWyadIABONiKFSJchuTkIva2vjihHyWZkVMaHvXHlwuZa4QYEhFj8goqJfUG9dzWR6isxAOoX0JCpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbiNLtcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbiNLtcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A401F00893;
	Tue,  9 Jun 2026 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780999365;
	bh=Rz6gpNcea764HxcvwpZK0WOyqiiyL6lEUvBfXL+kpkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbiNLtcTxc5sL7spcAzMjf5sfSr6K+sE30HxbbOjXWYm0V3tSZCLdeTjKnnrP+bff
	 mcNFF5Prh92fDMYyB2Nf+wIRozVjf1cX2M9BNiMICeOBZL9s+rWheP7Im42lzPW1tK
	 /sV9uYDE8hA2OMLXZZXKT9oz8tjwjpkqXadXqYAu/RLngrtwFmpQrq8lWlKSO4VVe/
	 eITNS1NZDKNuacY2AKzNMoR3+Rjboj0fXSIFrnPob4YPFqctnMDoKm3KqI8hSY75YQ
	 QquZHjqaC2IQFFB2bcyBkpoOz98FQOFkiD9Ck33Z8lzeqfY75dZlSDFuvRNw8C9d/6
	 3XXLhEoyXZgEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Exercise unsafe obj
 drops from tracing progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609093719.2858096-4-memxor@gmail.com>
References: <20260609093719.2858096-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:02:44 +0000
Message-Id: <20260609100245.28A401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest `task_kfunc_obj_drop_nmi_with_kptr` uses the x86-on=
ly `nmi_handler` tracepoint, breaking the test suite on other architectures.
--

commit 1282fb89cc1ac86a478ae0747dc71f01a3bfc729
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Exercise unsafe obj drops from tracing progs

This commit adds task_kfunc failure cases for bpf_obj_drop() on local
objects with referenced kptr fields. It introduces tests for tracing and
NMI tracing programs to ensure they are rejected by the verifier.

> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c

[ ... ]

> +SEC("tp_btf/nmi_handler")
> +__failure __msg("bpf_obj_drop cannot be used in tracing programs on type=
s with NMI unsafe fields")
> +int BPF_PROG(task_kfunc_obj_drop_nmi_with_kptr, void *handler, s64 delta=
_ns,
> +	     int handled)

[Severity: Medium]
Will this break the selftest suite on non-x86 architectures?

The nmi_handler tracepoint is only defined and instantiated on x86
architectures. On non-x86 architectures like ARM64 or RISC-V, libbpf will
fail to resolve the BTF ID for this tracepoint, and the BPF program load
will abort before the verifier is invoked.

Consequently, the test_loader framework will not find the expected verifier
failure message in the log, causing the test to incorrectly report as faile=
d.
Is there an architecture-independent tracepoint that could be used instead,
or should this test be skipped on non-x86 platforms?

> +{
> +	struct __tasks_kfunc_map_value *local;
> +	struct task_struct *task, *acquired, *old;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609093719.2858=
096-1-memxor@gmail.com?part=3D3
