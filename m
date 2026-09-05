Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B13822A5
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599004; cv=none; b=Xj+O5MElW8YPKtmhcRs/SqDISPE8kV5xTewE+R+4plOoAsdLeur0RfpdN5XqHVzLLsPJatyIj1zdFGcJ+ml2mpAO/rVh9ka+r1yxzS2zddQV7NmC+iEcO5eCZiBdvsqTlxqAmPmYDaGNLt052g0CIt5FNCaVGWoQUTNOI6QJx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599004; c=relaxed/simple;
	bh=JjxYZlCULaeMRmxnbZIXd8ZRoLgMsqwaVcvQqGIhuv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrQ5jCFXHqHsSoMLBSirqNysVCPd2OyfRj3UwavzWFqA59M7FER1kR1DzSJLX4pmHb9OMQgsKdo7ZWfvP+Xso61L6yJWYoUXz4HbeRAZdia50DE5nPnlD6It6c6ruR4Fp5ahEJND2ac7Ha/9zOZ9HSCkpV/j0crcqsMM+ivVbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKI4e8hy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKI4e8hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA9E1F00A3D;
	Sat,  5 Sep 2026 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788599000;
	bh=PuHAdoy+ZTMl1z2Y+WWB6JPxOktPOUeIYbQ5VSD5aKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKI4e8hyfXE+22zC22+8Pkaqee5niiZiKevt4M11qPvkHMVx/MxXRM+/3RPTwz+DK
	 us8rmaogvirqi8uB2gKN/Sw3serj+lIG6KVUPKjva/E6I2hOlY/LeHO1u6vVxW2U6d
	 JAafdbBP7jwvs4uUNQonM1zoIU6AGBE7AB9LQ3k+lHvDA20cznd1z6UiPXJ361l6tV
	 8Lq6g4yes8cYWl026AXOglyV+o96SBkcRu3IRW0oAtjkDwyJgD91P8DgWJo4t5gkvi
	 /LkLpsg1CriXtlFWa7lJTnDMEn6klNPJxil1FOMeS+0DZjAl9h+LzQGFS0rY/PfkoQ
	 qPPLj90BlKkkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Enable stack argument
 tests for RV64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905085857.14143-4-pulehui@huaweicloud.com>
References: <20260905085857.14143-1-pulehui@huaweicloud.com>
 <20260905085857.14143-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:03:20 +0000
Message-Id: <20260905090320.8AA9E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing architecture guard update for stack arguments in `tools/tes=
ting/selftests/bpf/progs/exceptions.c`.
--

commit 7ea892ecb0a3b4c34ad8033c7d6de54aaa01a98d
Author: Feng Jiang <jiangfeng@kylinos.cn>

selftests/bpf: Enable stack argument tests for RV64

Enable the stack argument selftests for RV64. The riscv guard is
restricted to __riscv_xlen =3D=3D 64 since stack arguments are only
supported by the RV64 JIT. Keep the __BPF_FEATURE_STACK_ARGUMENT=20
gate, defined by clang with BPF stack argument support [1].

[1] https://github.com/llvm/llvm-project/pull/189060

> diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testin=
g/selftests/bpf/progs/stack_arg.c
> index 944e3bb603e7e..3e9ed37c57bb9 100644
> --- a/tools/testing/selftests/bpf/progs/stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/stack_arg.c
> @@ -21,7 +21,8 @@ struct {
> =20
>  int timer_result;
> =20
> -#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
> +	(defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64)) && \
>  	defined(__BPF_FEATURE_STACK_ARGUMENT)
> =20
>  const volatile bool has_stack_arg =3D true;

[Severity: Low]
Does tools/testing/selftests/bpf/progs/exceptions.c also need this architec=
ture
guard update?

The has_stack_arg macro in exceptions.c enables stack-argument-specific
exception tests. The RV64 architecture check seems to be omitted from that =
file
during this refactoring:

tools/testing/selftests/bpf/progs/exceptions.c:
#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) \
	&& defined(__BPF_FEATURE_STACK_ARGUMENT)

const volatile bool has_stack_arg =3D true;

When exception support is eventually added for the RV64 JIT, the stack argu=
ment
portions of the exceptions selftest will silently fail to enable, reducing =
test
coverage.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905085857.1414=
3-1-pulehui@huaweicloud.com?part=3D3
