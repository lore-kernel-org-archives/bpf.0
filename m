Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FA37E5F7;
	Wed, 19 Aug 2026 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132238; cv=none; b=AEdO0XFCow7QBhz7kGsgEvSH5ovrbq8/J/o7O6XCk9tNTGhsZ5i9E89XK2pPjWDQxmric6KDVKcTBKSOVUmLz9u5ywRw36mCjNfxxQIRBJJATjN3lKgAJrOyfFzgC+pJsf2G9ZSKARrqZGTiLyb+l6+kLl4YjLZPEm5HvvFNWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132238; c=relaxed/simple;
	bh=hLshNJs6H6l1gMd8UezDIYuK43TzULmCLg+KG7lUOvU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZLsfCc6Y13gJAxOD2fIT5v83t49bWjA0QWQYHaeqP+vfTnaXLbfyJQyJi9rNHKg5fFkOqGQ0J6ggOGKQKJztSeFLsNP09u4SwZ5GjxTIX/vN7ldzQSP6/1obMtayU8cwc04awFxTx/uNgJaytJqF8QlUCJNn00AAkeRPxlZqYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZf4dKXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZf4dKXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801D21F000E9;
	Wed, 19 Aug 2026 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132236;
	bh=fJyoGP3XrQkM2JSSX+2B6BjxD7+I7azMU6AfMEN4XO8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mZf4dKXt+JxLXKKzkZzp7KFmsjX4X0lXTiZ8DJZp9K5kxGopcmYfkd2ACAlqn29Yv
	 +Vm2WPhmpPrpqpBUT+YPULtrzu4/NfiCX7AdpRjGsBpr1CFHQWhOSSb4GF4X2WVaZI
	 XfYKDlojX8jExZ/v/QGLJF34VrrqbHiS7dDTCykg+JHkauna9rk1slBzOgpdj8xpfH
	 0n3hnpVy9l/TtndPBpOLBBNALw0C9IQUN6tssFnvD5OVQ4Wqs2K8qkexDP3gLiMFdo
	 npLytyEKw9mScsbXewMidpeZF8cguRilxIk4kC0RtobkSnzshHpUH6F+ciypCAoa9i
	 9sGNIIpd9rFNg==
Content-Type: multipart/mixed; boundary="===============7477287384193181481=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6d031ece454ad8a2a3e09bbdf48d9030c74cb6741f76aabf58bf7af1931abfd@mail.kernel.org>
In-Reply-To: <a78cd29b238aa1aba87efeb2fc09d25a56c22f69.1787128322.git.cp0613@linux.alibaba.com>
References: <a78cd29b238aa1aba87efeb2fc09d25a56c22f69.1787128322.git.cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, riscv: Add support for signed arena loads
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,shuah@kernel.org,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 09:37:15 +0000 (UTC)

--===============7477287384193181481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 74efe4b138d2..56196b001286 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> @@ -1908,13 +1910,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>  	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>  	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> +	/* LDX | PROBE_MEM32SX: sign-extending arena load */
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>  	{
>  		bool sign_ext;
>
>  		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
> -			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
> +			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
> +			   BPF_MODE(insn->code) == BPF_PROBE_MEM32SX;
>
> -		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
> +		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
> +		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
>  			emit_add(RV_REG_T2, rs, RV_REG_ARENA, ctx);
>  			rs = RV_REG_T2;
>  		}

This isn't a bug, but would the comment fit the surrounding style better as
an expression? The neighbouring case-group comments all spell the access
out in pseudo-code form:

    /* LDX: dst = *(unsigned size *)(src + off) */
    /* LDSX: dst = *(signed size *)(src + off) */
    /* LDX | PROBE_MEM32: dst = *(unsigned size *)(src + RV_REG_ARENA + off) */
    /* ST | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = imm */
    /* STX | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = src */

Something like this would match the pattern:

    /* LDX | PROBE_MEM32SX: dst = *(signed size *)(src + RV_REG_ARENA + off) */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32235574103
--===============7477287384193181481==--
