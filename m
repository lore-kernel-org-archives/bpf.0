Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914532;
	b=L6obT/vOq/eGEeE2MT8zRNQOWHgnYnpV6fAveZDjPw4aQMW+VgUzif5Iegrc8W8U3eSN
	 ucXSzSKCWRp4DwrqskIRmSzNOFNNGMbtx7tZkc+LDA8JyzS+y+HbjqSQoAhsB8cCUXwRb
	 9XO7z1tRIiahTGMGHXQhSc47YRmlvA3v6ijpMDdgxHPYQHK7khfa6xzHLlrpeK0WmKQ4O
	 4J8JZGPuqdRwDoeyLVmTsaozlYnAsvqURTIeyHESPuSsH9I56aAz4aPREt3icK9yMbXk/
	 dKZ4VuwnFRORxKENm+/a0h0Il+ymybTY5kEQDd/0BXAsseiI9jMDm9VLa6cnAnR+yDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914532;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=x7mqBm/7u6iPKTFb55qo62WVnHz0Nf4KSfq7BuuA6JQ=;
	b=pv6/Dv0MOmbVebxgDdHYo9c63yByQxKR9xt53MqINShPs5zRAAlaUBbAcRsEB32eCxqS
	 15vU8A9HPh8rryWDQU25nt7RzqS5ag0prFyUx+X8aOTwdcJuJQAR0tZ9/4NWUv+V7WpSV
	 ExqFccozHUakCZpWRTahYKhd549lgSye3uZvCRw1lLJSPIxXAN8c3v4NiN9DFpFdAupZL
	 I/lW+e+yx38Bv5DVqKbBnTeuOeH7euzirHClZzJjSHPUPKbxhb5gIkKwMruFaIJCyluzU
	 oXeWszAvbiBeBNoXss3qXQdq+DmTSJWj8Vuj8pYvHEcuLm/s6Belv7Dxr4pimRq1XhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCKyVYm7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A1606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCKyVYm7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61DC1F0089F;
	Thu,  5 Nov 2026 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914532;
	bh=x7mqBm/7u6iPKTFb55qo62WVnHz0Nf4KSfq7BuuA6JQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VCKyVYm709splCFHRKvAR6ltswdGKfj64XXnL/X69kKpDgEfBSbYeUw5PBvZPR1Th
	 wSJ8p+bJMVHFGtPv8QfaEP/APASKIadpKGkVDkOpPpFsFbkrtBCnz0yIuGGhEbRJT/
	 Gc3C4Z2bAnCrVNoP1zL0t3c15wnHxYOljcoJ7/Pyr8G07LSRCK04r7ioFay+pwNxHw
	 GOqiSTIMyucKch3ejsw5fMY9FFqYohWARHQQBQGy83BlL1yQRuloIRiWjf8yeQl1n9
	 8kmEJLkWRdXcJ0Cah2Fw6+gY81oNwMroH0YETiTCa7HnESVBfUtzWkzM75+32EFpNr
	 oSXXnOdknEXuQ==
Content-Type: multipart/mixed; boundary="===============3951734016097115953=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <506d7ef52474ac7df140bd5f84ac7b7bcf359769a1a46b05aba0751fcdf065af@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-11-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-11-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 10/35] bpf: Find the registers and stack slots that later checks depend on
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:31 +0000 (UTC)

--===============3951734016097115953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Find the registers and stack slots that later checks depend on

TL;DR: flow_compute_need_const() may treat BPF_END with BPF_TO_BE
(ntohs/htons) as reading a source register, wrongly marking R0 as needed,
which could keep states apart and make loop iteration walks much costlier.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +			} else if ((class == BPF_ALU || class == BPF_ALU64) &&
> +				   (out.regs & BIT(insn->dst_reg))) {
> +				op = BPF_OP(insn->code);
> +				reg = BPF_SRC(insn->code) == BPF_X;
> +				/* the result is known when what it is made of is */
> +				keep = op != BPF_MOV;
> +				from_src = reg;

[ ... ]

> +				if (!keep)
> +					in.regs &= ~BIT(insn->dst_reg);
> +				if (from_src)
> +					in.regs |= BIT(insn->src_reg);

For BPF_END, the BPF_X bit of the opcode selects the byte order rather than
a source register, and BPF_TO_BE == BPF_X == 0x08.  Can this treat
BPF_ALU | BPF_END | BPF_TO_BE (what bpf_ntohs()/bpf_htons() compile to on
little-endian) as having a source register?

check_alu_op() requires src_reg == BPF_REG_0 for BPF_END, so for the
FLOW_NEED_ARG, FLOW_NEED_STACK_OFF, FLOW_NEED_PTR_OFF and FLOW_NEED_VALUE_OFF
tables, from_src ends up true and the code does:

    in.regs |= BIT(insn->src_reg);

which is BIT(BPF_REG_0).  BPF_END does not read R0, and
bpf_compute_live_registers() ("case BPF_END: use = dst;") treats it as a
dst-only op.

For the common pattern "off = bpf_ntohs(...); data + off", R0 would be marked
needed from the bswap back to its last definition.  Within that span
flow_needed_consts_differ() would keep states apart wherever R0 holds two
different constants, and at a loop head bpf_flow_is_needed() returns true for
R0, so bpf_compute_loop_iters() would walk the iterations instead of
forgetting R0.  The commit message itself gives 1241 insns versus 154K insns
for a walk of all iterations.

Would excluding BPF_END from reg help, for example:

    reg = BPF_SRC(insn->code) == BPF_X && op != BPF_END;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============3951734016097115953==--
