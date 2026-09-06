Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20741D641;
	Sun,  6 Sep 2026 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704546; cv=none; b=upTy2rbnYufQha6fodwkMWfx9Oizw6tUXwllAvG1l/s385FwXHJY4pDVyCF14Xs2u8Y8olckL+GwOvWZMY6U1/gnQPQG9hQU9bjW16l/Y6M+xAiq3RI8TlTP2kNE0aDwOk1/5iASdDME4ApD67NyomSxhFIxZmMXyrA+cfCUHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704546; c=relaxed/simple;
	bh=zqH1RcBR6v+MtsHjl9SPGmCiVfl1G6ZTVoqV6PRXYzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ArG7JVuXp2YXr7Sc9vod+mH5Bgqwoshqb8lx4kfHfXGFPbJguvudkFK1AEh3lSorZLeV6MmOwCikvgIbLTt1myqiC2DOfhafavCc+rwd+sYVorJ9BDGYZMJfyAMUd4Ig6gcthfkUosBXVQY2v3j08jCQnMzHuma6CHE+ex8kHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZblscgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZblscgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECD1F00A3A;
	Sun,  6 Sep 2026 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788704544;
	bh=+iuN3pHM7H7qaeZ7YQCVLQF26/aiYKUGjIlZGSFrPeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mZblscgqbwUkobSCBQptaHGtuReGM+jExs45B99PBXQoXDaGzn771F7+2rKb3Iq79
	 fVuBrYKLUItbDAceDIVYCP2rSzRC97TnWRaaGpsDM+c2dX3Q3pnsmSF/TFknm7BsUg
	 bWjn6hjOm7BoEAYhPZ2cpjQh3lfugiVRdfVPY5DNsvMx6K9ALszieAF3pawIh/cLSY
	 N9h11JVeEoytR+1Jy2X8WRXH/2yeidn96dlu45DXKxWJMP9X/MtA579qJmG4a3UYkR
	 AP6F21Z+8AGFxC9Atjmwr/7ZZWfAVrFUvDHWBAr3iwLAuHf+b8axppN+3oXBH5YkkT
	 6GxTUzp2mooIg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Feng Jiang
 <jiangfeng@kylinos.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre
 Ghiti <alex@ghiti.fr>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v5 0/3] Add bpf stack arguments support for RV64
In-Reply-To: <20260905085857.14143-1-pulehui@huaweicloud.com>
References: <20260905085857.14143-1-pulehui@huaweicloud.com>
Date: Sun, 06 Sep 2026 16:22:21 +0200
Message-ID: <87zexuo3xe.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> Implement bpf_jit_supports_stack_args() on RV64 JIT to allow bpf
> subprogs and kfuncs to pass and receive more than 5 arguments.
>
> Tested on riscv64 QEMU with LLVM main [1]; BPF-to-BPF and kfunc
> selftests pass.
>
> [1] https://github.com/llvm/llvm-project/pull/189060
>
> ---
> Changes in v5:
> - Add RV_EXTRA_STK_ARGS macro to represent the exceeding stack args
>   passed in riscv arg regs. (BPF CI)
> - Optimize emit_stack_arg_st() by materializing immediates directly
>   into destination registers. (BPF CI)
> - Update stale comments. (BPF CI and sashiko)
>
> Changes in v4:
> - Remap BPF_REG_0 and RV_REG_TCC to align the calling convention of
>   bpf2bpf and kfunc calls with the riscv abi.
> - Adapt the bpf stack arguments implementation based on change 1.
>
> Changes in v3:
> - Drop the exceptions.c guard change: the guarded programs use
>   bpf_throw(), unsupported by the RV64 JIT, so the test is denylisted
>   on riscv64 and the guard has no effect. (BPF CI)
> - Link to v2: https://lore.kernel.org/r/20260813-bpf-riscv-stack-args-v2-=
0-efea8f9b3fe1@kylinos.cn
>
> Changes in v2:
> - Sign-extend 32-bit kfunc arguments passed on the stack (args 9+),
>   matching the register path and the RISC-V psABI. (Sashiko)
> - Restrict the riscv selftest guard to __riscv_xlen =3D=3D 64 so the
>   tests are not enabled on RV32. (Sashiko)
> - Link to v1: https://lore.kernel.org/r/20260812-bpf-riscv-stack-args-v1-=
0-67b246806e59@kylinos.cn
>
> Feng Jiang (2):
>   riscv, bpf: Add BPF stack arguments support for RV64 JIT
>   selftests/bpf: Enable stack argument tests for RV64
>
> Pu Lehui (1):
>   riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC

Thanks!

For the series:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
