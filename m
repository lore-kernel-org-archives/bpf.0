Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A323F4DFE
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592164; cv=none; b=me/iIRZ6mXD2foYzF3xq3HQKWebp/yr95QUNUUvLRHGjWxAZ1z4K3PvzoB8l/IArgOhBfCKDWHK26LsXvSvPaGMUpCCDlcUrK3Mxl9lSmJFfqZJKMw2Nzo0Q6i3tdeW0VoOCRE0+3w6RGs9DCxaSovnm1JllzGJa32LPcf7SCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592164; c=relaxed/simple;
	bh=d2HwYwHkuMKFUNANX/vhaUj15ARCyANGK1tIcTW/gNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IdGkdo0r5fzxF0glDR8nJ0L6JT/hn86CnEf+DZK1efjSVmlnkadQyuKdQKO/GJrONYvkZVMwnFF7D7M12axCWXwAHnCDj1bcWYH7x4HR/rWeczkTvgHju9odOoK4hnlwRwIgt2hqDXuaPkgwCjNzr52mNskTxKpujuBWxK8KCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgNoZi2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgNoZi2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB0D1F00A3D;
	Sat,  5 Sep 2026 07:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788592151;
	bh=pv0UaPnhg44b0M7xrz0Fj0q1rSC9XrA3d+gs/NHty0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgNoZi2bYTjSFnGAml8ItdcJsPWkXU70d6jl//8ECTnfmMn5srnSQ+m52jrwv2QQj
	 XiGmvrwz+vJ9lpuiMY4nM4UscddnTkpF4oVsgI+5oI+4pk0jE6iaIm5J+UOSfQZsUt
	 oZ1VYMT0IYXtB1hQ/mKSlzRCpY8yFrIm42wy4NoifXLfqjt5HvzMXOCXn/SUPGI4Gi
	 RuF6r9G9EK0kHQ7k1BQvCCjssPqcayAHLd2HsLuUNdDbtknwyPI/PAhve+BVDY8AyH
	 1or+UuA6Om6ZkEyL7ROzWyzYYVRMQhbLMlSi93gkTheSfSxEOuc3pwYlhcHtwOagaU
	 hbx2v6GqSu8qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Enable stack argument
 tests for RV64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905070409.4141522-4-pulehui@huaweicloud.com>
References: <20260905070409.4141522-1-pulehui@huaweicloud.com>
 <20260905070409.4141522-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 07:09:11 +0000
Message-Id: <20260905070911.CAB0D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch misses updating the architecture check in `tools/testi=
ng/selftests/bpf/progs/exceptions.c`, leaving stack argument exception test=
s permanently disabled on RV64.
--

commit 064ba72e246734f0b6e1f3e1f7a66bfe6a3a8b0e
Author: Feng Jiang <jiangfeng@kylinos.cn>

selftests/bpf: Enable stack argument tests for RV64
   =20
Enable the stack argument selftests for RV64. The riscv guard is
restricted to __riscv_xlen =3D=3D 64 since stack arguments are only
supported by the RV64 JIT.

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

[Severity: Medium]
Should tools/testing/selftests/bpf/progs/exceptions.c also be updated=20
with this new architecture guard?

It looks like the same has_stack_arg guard is used there:

tools/testing/selftests/bpf/progs/exceptions.c:

#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) \
	&& defined(__BPF_FEATURE_STACK_ARGUMENT)

const volatile bool has_stack_arg =3D true;

Without updating it, the C preprocessor will take the #else branch on RV64,
defining has_stack_arg =3D false. At runtime, prog_tests/exceptions.c check=
s=20
skel->rodata->has_stack_arg and silently bypasses the stack argument except=
ion=20
tests.

Could this be added to ensure the exception tests are not permanently=20
disabled on RV64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905070409.4141=
522-1-pulehui@huaweicloud.com?part=3D3
