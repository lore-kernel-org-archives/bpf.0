Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0016190462;
	Mon, 17 Aug 2026 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954581; cv=none; b=eF89PvNx4PgREXmL2YQnKWNt0GH9l/sH+UM6kk+71E4HYODuhzmBZ4ncAtOzQO1JLveMPUFAx617xgX3VaUv036CtebImaO8mbW3JAffmExOX687FgMf+9pdwE8apRyyIXUQqJWWNVBjXSrDsPYIrRYNuvybjeA+iM6li1L8WGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954581; c=relaxed/simple;
	bh=jtQLzGocN23Q0QMgi5K5iOMAw+wqtNsZ8fgCr8F28YE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QdeqVw8l0vWJeTbGlLgALLYnMiBLspb3YwiTPYGtwT6y0Md+ZttpNIcP9LrGLo85NnJb++cPHVcTF3dOavsjJFGXR/8HPw+fXq22Xlxl7BrA/7c8gPYz3ngLEfkMH31EdWUPa1f0851hgOqe1IZIlK/oGo66M9ziC1wWsy5mu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf5bYs7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf5bYs7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABC21F000E9;
	Mon, 17 Aug 2026 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954580;
	bh=F2jpUDK2vjCL/A1outTMoBzvGSnEUDAg5YzlVyq4zi8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kf5bYs7RrU8xwQA4bmH6sEwol0nMSrgaDJSu6fNWmircc2WaiN8QmH5/djLQQAP1Y
	 6gXXmfv2H5aLukQi528Z/SCD5WrY3JQNbgbvxGvyk2sStDFM1bWLjcTrtgbJPdKIAZ
	 Yji/pP9VvP/333VEwnpVgwQODW0DLg4UwY6cw5m5doEkA9nS8H5OOWlJjc/jqf5DBd
	 8B7cdCP3+kC9TSSfBFSL2HJhV5yeywzsNxj8Ho/5tCsK364PbmIuvslIOdcEmDLkUb
	 o9HFSw98/Yx2597jiK9oUHHdTvICHklLoT53HChsdYSyf7/zn3wjMqx0iLXtovmk2O
	 8aywfUDYyrivw==
Content-Type: multipart/mixed; boundary="===============0242543682247471042=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e479d7398bdae62e6cd8433c941e4a4a6cc086fc7c42b77b0a08ec730ac3473@mail.kernel.org>
In-Reply-To: <3445fb0231f9c72496ae840e9dca675b15899433.1786708960.git.cp0613@linux.alibaba.com>
References: <3445fb0231f9c72496ae840e9dca675b15899433.1786708960.git.cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, riscv: Add support for signed arena loads
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,shuah@kernel.org,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 08:16:19 +0000 (UTC)

--===============0242543682247471042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf, riscv: Add support for signed arena loads
>
>     Signed loads from arena memory are currently rejected on riscv64, as
>     bpf_jit_supports_insn() refuses BPF_MEMSX loads when in_arena is set,
>     while x86 and arm64 gained support for them in v6.18. Compilers such
>     as GCC-14 are free to generate signed loads into arena memory, which
>     breaks loading of otherwise valid BPF programs on riscv64.
>
>     Implement BPF_PROBE_MEM32SX support in the RV64 JIT by reusing the
>     existing arena handling: the arena base (RV_REG_ARENA) is added to
>     the source register and the load is emitted with sign extension
>     (lb/lh/lw). Add BPF_PROBE_MEM32SX to the add_exception_handler()
>     mode gate so that faulting loads get an exception table entry which
>     clears the destination register and resumes execution.
>
>     Verified by running the arena LDSX selftests (arena_ldsx_disasm,
>     arena_ldsx_exception, arena_ldsx_s8/s16/s32) on riscv64 QEMU, all
>     passing.
>
>     Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

This looks like a bug fix for incomplete arena support added by commit
fb7cefabae81. Should this include:

  Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32007452800
--===============0242543682247471042==--
