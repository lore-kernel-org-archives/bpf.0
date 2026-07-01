Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25F48BD46;
	Wed,  1 Jul 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911568; cv=none; b=VJ08/mzAKUJ7vfliYpJRuojg+CcbanEbcZkqT5lGxJRCgDP5Cq4O7rZ68GUTFLTUkhXhxTBsunpaLIe+ZLcaS6b1H8xd72vlmsWhdOcy7J/CpPtbCsuTNlaNLts9QxukW2Eo5zbDd7WdzCv89CYjFR26bMjYDBdC0I8/6SD2sws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911568; c=relaxed/simple;
	bh=O4oJ9RaiSgBDNCGSfOEkKzhw0dcoX/rFqEZ3zh6i9R0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FZQdTXtzuiI3wWKW7MNODHLWCY27jQDC7AAk0nokZbCAsWgwm4e3gpnP+Y0k2nkV66sm6npF0ffmKNFL8O6bnLAdG3YdAqIvvCwRTpH5zvZXbhAeEcHcv5T3HiAhwQ+xNqAffT9JWSvTIk5zaZONwjskUtxg0RxopMNlAVFsDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6B704Mg reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6B704Mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D301F000E9;
	Wed,  1 Jul 2026 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782911566;
	bh=91uk3L99OWz781fU570Nvcxs1RgxF76hCIkEAl460QA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O6B704Mgvju/Ngdd1VbVKl0dbadn+4zuNw4UCqU9OwhtQxYQ1fO1eeNawxcTx7Nbw
	 aXfOMPV5NhTp9JgBqcn7SsZlimNjZ31SGM/Hd0Dh2tV8YTyKpycqS2V7v1vILKeoRW
	 5XJgR5/Bozvjndkz/hfuiOlHcALUeKsilMlgMk7pMHjKaUzvK3E4EytUGgeub5f51F
	 QRwY5RumucwkLPyq60/BGF4+6Q4mlvKfzGVAK4pcJYe+Qe3pMsiWAQY3nya5ud6NQK
	 cVyqKkfazNv1oPEvdn4YyoKLii7qUC+Lg7jlaYiI9qA//lBx6Vql9SdH0Ef5ft1I5G
	 70jCf5SchPRdA==
Content-Type: multipart/mixed; boundary="===============4080985512832073215=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fcc8e7d5146cf4c85f081ad21175c0da4b359b8c68c8305b2671c49de1a19807@mail.kernel.org>
In-Reply-To: <20260701122948.57584-3-cuiyunhui@bytedance.com>
References: <20260701122948.57584-3-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v6 2/3] riscv: introduce percpu.h into include/asm
From: bot+bpf-ci@kernel.org
To: cuiyunhui@bytedance.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,dennis@kernel.org,tj@kernel.org,cl@gentwo.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,thuth@redhat.com,ajones@ventanamicro.com,ben.dooks@codethink.co.uk,rkrcmar@ventanamicro.com,cuiyunhui@bytedance.com,samuel.holland@sifive.com,zong.li@sifive.com,conor.dooley@microchip.com,tglx@kernel.org,debug@rivosinc.com,seanwascoding@gmail.com,andybnac@gmail.com,menglong8.dong@gmail.com,cyrilbur@tenstorrent.com,wangruikang@iscas.ac.cn,atishp@rivosinc.com,apatel@ventanamicro.com,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,arnd@arndb.de,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,qingfang.deng@siflower.com.cn,linux-arch@vg
 er.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 13:12:45 +0000 (UTC)

--===============4080985512832073215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
> new file mode 100644
> index 000000000000..34483253e946
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h
> @@ -0,0 +1,284 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __ASM_PERCPU_H
> +#define __ASM_PERCPU_H
> +
> +#include <linux/bits.h>
> +#include <linux/preempt.h>
> +
> +#include <asm/alternative-macros.h>
> +#include <asm/cmpxchg.h>
> +#include <asm/cpufeature-macros.h>
> +#include <asm/hwcap.h>
> +
> +#define PERCPU_RW_OPS(sz)						\

[ ... ]

> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\

[ ... ]

> +#define PERCPU_OP(name, amo_insn)					\

[ ... ]

> +#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)		\

[ ... ]

> +#define PERCPU_RET_OP(name, amo_insn)					\

[ ... ]

> +#define PERCPU_8_16_GET_SHIFT(ptr)	(((unsigned long)(ptr) & 0x3) * BITS_PER_BYTE)
> +#define PERCPU_8_16_GET_MASK(sz)	GENMASK((sz) - 1, 0)
> +#define PERCPU_8_16_GET_PTR32(ptr)	((u32 *)((unsigned long)(ptr) & ~0x3))
> +
> +#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr, asm_op)			\

[ ... ]

> +#define PERCPU_OP_8_16(op_name, op, expr, final_op)			\

[ ... ]

> +#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_expr)			\

[ ... ]

> +#define _pcp_protect(op, pcp, ...)					\

[ ... ]

> +#include <asm-generic/percpu.h>
> +
> +#endif /* __ASM_PERCPU_H */

This isn't a bug, but the header defines a fairly large set of broadly named
helper macros (PERCPU_RW_OPS, PERCPU_OP, PERCPU_RET_OP, PERCPU_8_16_OP,
PERCPU_OP_8_16, PERCPU_8_16_RET_OP, the PERCPU_8_16_GET_* helpers, and the
__PERCPU_AMO_*_OP_CASE helpers) and never #undefs any of them before pulling
in <asm-generic/percpu.h>.

arch/arm64/include/asm/percpu.h #undefs its PERCPU_RW_OPS, PERCPU_OP,
PERCPU_RET_OP and __PERCPU_OP_CASE helpers once they have been expanded.

Would matching that here be worthwhile, so these generically named helpers
(for example PERCPU_8_16_GET_MASK) do not stay in the global macro namespace
for every translation unit that includes this header?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28518481105
--===============4080985512832073215==--
