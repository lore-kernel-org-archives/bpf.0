Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B433FBEDF;
	Wed, 29 Apr 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468409; cv=none; b=PbS+X+5CWY9yaexxVVfPkap0cvyInkthiJbwi315JSuf9aLtPH0UnhCPy+7rJ3p6fO2JFV/6J77wa04W9mmEOXwjwd2dFC+ZQFBavVKbxOqEiK6b6seI33vqvATm8n5LVa6v1xvtP6/3QXbgtLgf1kwpSg2XPdPStlAW71YnBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468409; c=relaxed/simple;
	bh=Y2qL98TARnuiC1jVU3x3sOclRr22lCOklsNDxNc9vdc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s6CkWD6WBAluNMY3MOWSYaenAH76V7j6u8dYUvrTGhLrc7kwpfgSpwk8f7PnhziD1d3cENd/Zxo65E7KH8ZntlKNk3gipkMaT8NoHuWYAtoLpC2jq1KdJ1Jq3Xf7hpI43dSq7zAwZazTo7sN25SjqO1rpHWhcsZdW+nO/Ymf5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6Ch2JGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6Ch2JGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484A0C19425;
	Wed, 29 Apr 2026 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468409;
	bh=Y2qL98TARnuiC1jVU3x3sOclRr22lCOklsNDxNc9vdc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=D6Ch2JGWVZ8Tft5JXU6C0bsMDvui3u9jUGBh3FSF/mpKbQ1xO3oNnLRq9Rux7gRhC
	 Ya0b/wjD0BcMKeafB1wmHtPfO9EXd4NDnCuD/jSDSawdJNvRaJ+wrAFpl1/XGxQmW5
	 oe5QdKAOJ/Vrn2oGA0H1smNUY0xX4RFsrqVzaB46Khfz3v8GFHaZ0ivxcgDBq2apR9
	 dq7lmEngs2tq5tCzkauG1CuDZ421+B7KAPdJwuRD7/7k5z38suTqd9Dj0mrbZl9RS9
	 j5suNipYUjUwlIn3KaeSufi9e0L1M/9LmPHh2tU4wHLxvdhOMDUnUvctFywTDb1cPo
	 QBn1a2EMO7q9g==
Content-Type: multipart/mixed; boundary="===============3577337078344571119=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e8e7111d2d5abc2947cda9233d9fea7399a89bf1ab0ba3ae14724bb8b71a1d8@mail.kernel.org>
In-Reply-To: <20260429123513.3477780-4-visitorckw@gmail.com>
References: <20260429123513.3477780-4-visitorckw@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] riscv, bpf: Add 32 bit atomic operations to RV32 JIT
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,luke.r.nels@gmail.com,xi.wang@gmail.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,alex@ghiti.fr,jserv@ccns.ncku.edu.tw,eleanor15x@gmail.com,marscheng@google.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 13:13:29 +0000 (UTC)

--===============3577337078344571119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index f8509950fed4..710c56b20f98 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c

[ ... ]

> @@ -902,11 +902,40 @@ static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
>  		case BPF_MEM:
>  			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
>  			break;
> -		case BPF_ATOMIC: /* Only BPF_ADD supported */
> -			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
> -			     ctx);
> +		case BPF_ATOMIC:
> +		{
> +			s8 fetch_reg = (imm & BPF_FETCH) ? lo(rs) : RV_REG_ZERO;
> +
> +			switch (imm) {
> +			case BPF_ADD:
> +			case BPF_ADD | BPF_FETCH:
> +				emit(rv_amoadd_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_AND:
> +			case BPF_AND | BPF_FETCH:
> +				emit(rv_amoand_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_OR:
> +			case BPF_OR | BPF_FETCH:
> +				emit(rv_amoor_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_XOR:
> +			case BPF_XOR | BPF_FETCH:
> +				emit(rv_amoxor_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_XCHG:
> +				emit(rv_amoswap_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;

Do the aq=0, rl=0 arguments provide the correct memory ordering for the
FETCH variants and XCHG?

Looking at the BPF specification in include/linux/filter.h, these BPF
atomic operations map to Linux kernel atomic_fetch_* and atomic_xchg
primitives, which require full memory ordering.

The RV64 BPF JIT in arch/riscv/net/bpf_jit_comp64.c emits these same
operations with aq=1, rl=1 for FETCH variants and XCHG:

  case BPF_ADD | BPF_FETCH:
      emit(is64 ? rv_amoadd_d(rs, rs, rd, 1, 1) :
           rv_amoadd_w(rs, rs, rd, 1, 1), ctx);

  case BPF_XCHG:
      emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
           rv_amoswap_w(rs, rs, rd, 1, 1), ctx);

The kernel's arch_atomic_fetch_add in arch/riscv/include/asm/atomic.h also
uses amoadd.w.aqrl (which corresponds to aq=1, rl=1).

With aq=0, rl=0, the atomic operations use relaxed memory ordering, which
could allow loads and stores to move across the atomic. Could this cause
BPF programs using atomic_fetch_*/atomic_xchg on RV32 to observe
memory-ordering violations that wouldn't occur on other architectures?

Note: For the non-FETCH variants of BPF_ADD/AND/OR/XOR (the return-void
operations), aq=0, rl=0 appears correct since those map to relaxed
atomic primitives.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25109627626
--===============3577337078344571119==--
