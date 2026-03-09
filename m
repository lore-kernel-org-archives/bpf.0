Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206F3B5842;
	Mon,  9 Mar 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074477; cv=none; b=iS9V2undcJ9+8Ww0DZHMQ0axG/MLL8tIc8ICfj/R0DWlSAG5ymsvqoBkaLjAmlrSzsnDKQ/erIYkGLb0hWg6hXtSO8+k6K+UWtIVqWW4FFcsD861JHwyEo/OQuuLnNDjHBJ5JVhf39KBufaUADw1CB/yUeuJgAtkiEk/LSjNl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074477; c=relaxed/simple;
	bh=WZZqIFtqIPZYZHyQpm9O1q1uW+Fda3YoUn9aPIKozSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XeRE7+zSJnDIcFGPi1/l/l9483dKVJxtRbjSQreEIqfg69+ehrbqolf2CcC6kIIP4i8YPM11XwCy2422xEBZ2qgrWBXUIenpEEK/uvikS4sGywkQ8cK60m8esis79V8onEl+SiTCK4Hn9wL/cgNV9DIPyMmghE9+LJ/6w9dnbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbMNp0/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbMNp0/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAE9C2BC9E;
	Mon,  9 Mar 2026 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074476;
	bh=WZZqIFtqIPZYZHyQpm9O1q1uW+Fda3YoUn9aPIKozSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hbMNp0/ZZ7mEd+r1gU14sPhKqLx/tjJNoQ5OSJ2sgBOrrGVz4gPgbp/dV5rBDME6r
	 oxrKAiVsAjP2Lqev4llsbLj0EUfTsvtudWqd0Abb18LNcKmYwViLugczNbSuY7NMgB
	 75C/FoHo5mvenazRhk/0P9KGB8GKHYBxqp9lFZ9yP0Z+l8/H5ULCGtQuZguYk1n2OQ
	 jo3Ym/csRlumTgvgUtaKIRKuo2OPKkK+EniKx3QoxMJ4wqtxpQUH2F8EkSQGTuIFVO
	 PLibXUbqkzstpqJKeYgc7wQwTeuF84Nu775BKAhOg5NA+Ss9HeZxqy2i2FeSTL1pA8
	 Y1KH/MkL72Rew==
From: Puranjay Mohan <puranjay@kernel.org>
To: CyFun <xcyfun@protonmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org"
 <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: fix constant blinding bypass for
 PROBE_MEM32 stores
In-Reply-To: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>
References: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>
Date: Mon, 09 Mar 2026 16:41:11 +0000
Message-ID: <m24impx8ew.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

CyFun <xcyfun@protonmail.com> writes:

> To: bpf@vger.kernel.org
> Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, netdev@vger.kernel.org
> Subject: [PATCH bpf v2] bpf: fix constant blinding bypass for PROBE_MEM32 stores
>
> BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
> bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
> survive unblinded into JIT-compiled native code when bpf_jit_harden >= 1.
>
> The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
> to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
> before bpf_jit_blind_constants() runs during JIT compilation. The
> blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
> BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
> unblinded.
>
> Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
> existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
> load the blinded immediate into BPF_REG_AX via mov+xor, then convert
> the immediate store to a register store (BPF_STX).
>
> The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
> the architecture JIT emits the correct arena addressing (R12-based on
> x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
> BPF_MEM mode; construct the instruction directly instead.
>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> Signed-off-by: s4ch <xcyfun@protonmail.com>
> ---
> v2: Rebased onto current bpf tree (commit 56145d237385).
>     v1 had a malformed diff header that caused CI to reject it.
> ---
>  kernel/bpf/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55..bb2fa75de 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1422,6 +1422,24 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
>  		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
>  		*to++ = BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off);
>  		break;
> +
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> +		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^
> +				      from->imm);
> +		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
> +		/* Cannot use BPF_STX_MEM() here: it hardcodes BPF_MEM
> +		 * mode which would lose BPF_PROBE_MEM32 and break the
> +		 * arena addressing in the architecture JIT. */
> +		*to++ = (struct bpf_insn) {
> +			.code  = BPF_STX | BPF_PROBE_MEM32 | BPF_SIZE(from->code),
> +			.dst_reg = from->dst_reg,
> +			.src_reg = BPF_REG_AX,
> +			.off   = from->off,
> +		};
> +		break;
>  	}
>  out:
>  	return to - to_buff;
> --
> 2.53.0

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
