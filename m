Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B522A7F0
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227639; cv=none; b=ksghTwVzwUdwSWASPZpgSEsiUN6KCO7MFesMAS1y3CdB1HWCXMt4H2+hr7lOcMRuXqnNKqileAUVWe/B4LR9Hj+X3eKd8ZjSxKBKZp+n4c9RyICw4s7in5YDLybH5VITmXpJRvK2SH3hxvp1j/dF4SfmZxJDUmSfE5wuAMjKdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227639; c=relaxed/simple;
	bh=YFOf7AKprHvDPCY9j8wl9hPwmTggebXDjHUk82eHMKQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bs/vSnsNWCafAqJFHv8uYev9tRT5acXH9Q0E3AObSBlADUVIesgNnBLCM9Mxk9rsnsNjCsbjPV8QiGuIAQNjbSai/d1JHqFKeiVr+qxBh6EDahCFGilN12bKMpK4aeamerjYk2/cOzpFqp3rUcdegfu/6fmgGUvLAuAba+mJOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzEJnSJa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzEJnSJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF38BC116C6;
	Mon, 16 Feb 2026 07:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771227639;
	bh=YFOf7AKprHvDPCY9j8wl9hPwmTggebXDjHUk82eHMKQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IzEJnSJaUzMQkB6A9mEBX19Emxjz3FaKAu/TxYp8xkXFl1kzcwlMxGTen9qMmwVtk
	 5S5mmZ1b6217YMXhKoa23Z4MMkIO9hs9OSO6IdQYHF442zGQOFLvhKFV6dvc1zmeXz
	 kBY8uSZX/7s858aOmZLvPqxR15MagXhvY0INfBJbXi3eErpTT3o4AlyEXnHKE5Z4DT
	 V7twneerEpnDrDiNz2QXgahJjs7YDf8Zpt3eUEXJ3iQ4e55Vt9MvctmWon8ePeQyEC
	 W9nuMIPorrIri4lB2jlI9eBV4wln1GKuWL9R6EFCGFRT0Mi9t0z3uLjnRxc+CFhdWY
	 O8SxaYuw9WhcA==
Content-Type: multipart/mixed; boundary="===============5622546097200743244=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f92f12e74b1c8d6fa54ec72590d5087a3c8b7ac2d7302309936db6bd196f5cc@mail.kernel.org>
In-Reply-To: <20260216065639.1750181-6-hbathini@linux.ibm.com>
References: <20260216065639.1750181-6-hbathini@linux.ibm.com>
Subject: Re: [PATCH 5/5] powerpc64/bpf: fix handling of BPF stack in exception callback
From: bot+bpf-ci@kernel.org
To: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,skb99@linux.ibm.com,adubey@linux.ibm.com,bot+bpf-ci@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Feb 2026 07:40:38 +0000 (UTC)

--===============5622546097200743244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> @@ -287,6 +285,22 @@
>  		 * program(main prog) as third arg
>  		 */
>  		EMIT(PPC_RAW_MR(_R1, _R5));
> +		/*
> +		 * Exception callback reuses the stack frame of exception boundary.
> +		 * But BPF stack depth of exception callback and exception boundary
> +		 * don't have to be same. If BPF stack depth is different, adjust the
> +		 * stack frame size considering BPF stack depth of exception callback.
> +		 * The non-volatile register save area remains unchanged. These non-
> +		 * volatile registers are restored in exception callback's epilogue.
> +		 */
> +		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R5, 0));
> +		EMIT(PPC_RAW_SUB(bpf_to_ppc(TMP_REG_2), _R1, bpf_to_ppc(TMP_REG_1)));

Are the operands to PPC_RAW_SUB reversed here? At this point R1 holds
boundary_sp (set by the MR above) and TMP_REG_1 holds prev_sp (loaded
from [R5+0]). Since the stack grows downward, boundary_sp < prev_sp.

PPC_RAW_SUB(d, a, b) computes d = a - b, confirmed by how BPF_SUB is
emitted in bpf_jit_build_body():

    case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
        EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));

So this computes TMP_REG_2 = R1 - TMP_REG_1 = boundary_sp - prev_sp,
which is a negative value. After the ADDI subtracts BPF_PPC_EXC_STACKFRAME,
the result is still negative (a large unsigned value near 2^64).

The subsequent CMPLDI unsigned comparison against ctx->stack_size (at
most 512) can therefore never be equal, making the conditional branch
dead code. The fallthrough path always creates a new frame.

The intended computation appears to be
prev_sp - boundary_sp = frame_size, which requires swapping the
operands:

    EMIT(PPC_RAW_SUB(bpf_to_ppc(TMP_REG_2),
                     bpf_to_ppc(TMP_REG_1), _R1));

The code still works because always creating a new frame from prev_sp
produces correct NVR offsets, but the optimization to skip re-framing
when stack depths match never fires.

> +		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
> +			-BPF_PPC_EXC_STACKFRAME));
> +		EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), ctx->stack_size));
> +		PPC_BCC_CONST_SHORT(COND_EQ, 12);
> +		EMIT(PPC_RAW_MR(_R1, bpf_to_ppc(TMP_REG_1)));
> +		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_EXC_STACKFRAME + ctx->stack_size)));
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22053464899

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates deep domain knowledge of powerpc64 BPF JIT internals and the operand swap bug is characteristic of human error with the non-intuitive PPC_RAW_SUB macro.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The PPC_RAW_SUB operands are swapped making the stack size comparison dead code, but the fallthrough path always creates a correct frame so there is no crash or data corruption.

--===============5622546097200743244==--
