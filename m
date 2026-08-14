Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EA329E55;
	Fri, 14 Aug 2026 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674862; cv=none; b=lzmr543tzzNNT97ATYt6Q1c/XGM8LDOO9c5OuG0N4Xze9MNBKWCwqr7BDME3vEkL6xzGCkSqXeWmS2M3x9quzGsCpGwV1z3/OH0GXh5hdqSknNPkgoZ4v2+YUkAEFysjf0s8pEf+DvUTnzE23uiKpU8xybq13xQhTfO/M1+oSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674862; c=relaxed/simple;
	bh=n4Z8wREb+0cMKs2TVCMwLuj4LFW3ThceB+OLCUEtjfE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CBYQHw90UcYOeSB7TURiSZUeO8vvCc61aEV+vBrjwkx3B/dWTA4zPbevByfEeEG2ETGxctbTanKFG2YWr5F60oaQH7CAIp5OX4IgcCPhyFqEAi5fEwNL+y+jraD1dFvnCLFlIJMS1DkLMaWDLlfMwSpAgQnUnF57VJ8KuhAMaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYwBlC7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYwBlC7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5729A1F000E9;
	Fri, 14 Aug 2026 02:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786674860;
	bh=vMOiCT3HOrxIzG/6rTdRGr6YHezqxK5beLhO4yCStvU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UYwBlC7ZGCznZ0vejJ6oE4YU0fGLzkzopHWflJRVXjHRmM59ie1AFxnszUw23hEJ1
	 dBN1XxMGraOOclBiqOxzGPsTXmlcp6x3AI6skO4FvdbSBQwEbrneHV0QVIAfP+kUOj
	 +e9Osj+eefT0mJlorbrKbXOPsJAXdHlz1Afq6CgY4MrKIEo2y2ofstCakyVWKrQPjx
	 P5BJRTDT/YNrcgZL9iOsM88QsPDt3Kp4optS8ToSXt3evl7P1c1Pi2GIkrvZUJFb41
	 +05wCNL5bnNwmk2VEIYr6pZLsWh24LAx/QzLcjEDNGus4fgfXGDhg8+I8g8JPDAX9L
	 UQJwcBGwsydaQ==
Content-Type: multipart/mixed; boundary="===============3453139535058796135=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a6a17714be50f30fda2b3dee849bbc7e72cd7b2322de92b6986a1626537b89ab@mail.kernel.org>
In-Reply-To: <20260814-bpf-riscv-stack-args-v3-1-2160de56fea3@kylinos.cn>
References: <20260814-bpf-riscv-stack-args-v3-1-2160de56fea3@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, riscv: Add BPF stack arguments support for RV64 JIT
From: bot+bpf-ci@kernel.org
To: jiangfeng@kylinos.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,shuah@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,jiangfeng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 02:34:19 +0000 (UTC)

--===============3453139535058796135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 2504df1fa1118..62c84de22163f 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> @@ -1891,6 +1916,21 @@ int bpf_jit_emit_insn
>  	case BPF_LDX | BPF_MEM | BPF_H:
>  	case BPF_LDX | BPF_MEM | BPF_W:
>  	case BPF_LDX | BPF_MEM | BPF_DW:
> +		if (insn->src_reg == BPF_REG_PARAMS) {
> +			int idx = off / 8 - 1;
> +
> +			if (is_12b_int(idx * 8)) {
> +				emit_ldx_insn(rd, idx * 8, RV_REG_FP, BPF_SIZE(code), false, ctx);
> +			} else {
> +				emit_imm(RV_REG_T1, idx * 8, ctx);
> +				emit_add(RV_REG_T1, RV_REG_T1, RV_REG_FP, ctx);
> +				emit_ldx_insn(rd, 0, RV_REG_T1, BPF_SIZE(code), false, ctx);
> +			}
> +			if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
> +				return 1;
> +			break;
> +		}
> +		fallthrough;

Does this new BPF-to-BPF stack argument convention work correctly with
the existing RV64 trampoline code?

The convention here reads incoming stack arguments from FP+0, FP+8, etc
(callee FP == caller SP). But looking at store_args() in this same file,
the trampoline appears to use the native RISC-V ABI instead:

arch/riscv/net/bpf_jit_comp64.c:store_args() {
    for (i = 0; i < nr_arg_slots; i++) {
        if (i < RV_MAX_REG_ARGS)
            emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
        else
            emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);

where RV_MAX_REG_ARGS is 8, so it expects arguments 6, 7, 8 in a5, a6, a7
and arguments 9+ at FP+16.

For a BPF subprogram using this new convention, arguments 6+ arrive in
memory, not in a5-a7. When an fentry or fexit program attaches to such a
subprogram, wouldn't it read unrelated register values instead of the real
arguments?

Both arm64 and x86-64 appear to avoid this by keeping their BPF stack
argument convention identical to their native ABIs. arm64 uses
`stack_arg_reg[] = { A64_R(5), A64_R(6), A64_R(7) }` and x86-64 keeps arg6
in r9, so their trampolines work without changes.

Can fentry/fexit attach to static BPF subprograms with more than 5
arguments, or is there a verifier check that prevents this?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31761418445
--===============3453139535058796135==--
