Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538311;
	b=YLTDaoM6q/AnJWovFp12xKWAWG5/64S4+aCwRrUw5cc+AcWMK/Va0d9IfbFSEEaFBWz/
	 97wfkvzQmh6xS2JTIWkZ+MrYv+pTGGyerb4ilsU3V69bgTUuAH0g8IL0WfiaIUzWAbpeW
	 1Ib4vdvlzSo3hpkkq86rqWkKyP4xU5rLuKq+JiM04bumIfl8/eB4cjUktzk9CIX3I0xQb
	 GtiABHf4TRmas/g1w2sVX83vOdu/OUyUsDkTpg6PThaNlO0UbmNgTf60we+RtUJG0rubt
	 MvpdtgwxzH4DRX9ciJG2fAnToqDQb4zEjyFhxX1VVnC5lxhMsJcKYokC6E8c+rQ9rlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538311;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=CF40HmncrmDjp8onngTCuMMBXj87s4VG4b5VuX10IJM=;
	b=J0Jox3r0HpyKfVYCODhrzpMs48NEVmmhBjE8cj0qkhtQsxUcEwePnDnuQaGrMZvfRU/D
	 YwSixvTpKqBN3zMI3v8d+hdmUESPv3S0Hd4AxLJUKm0G18N7T58j6eIMyeq2u+D2lmPZx
	 dyvarHa5YpaHtzng0o5MrlUfnClPC1lY/CsymmJPTXxwW+34MR1xEWB+KZXdvzRUWYu6p
	 zuoZcKYf7U3y9Ik/Pz3l4IjlRKL4wYWSvZcGCVFmjN6g9G05e0WACw4hLFdWapPEwg+me
	 0YNHvMzE6W3fAW0zm7sGKdvSgyNFWTOyTrFM5Z/FtuvUwpaYkSxtia1jz962WEjNuyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aneupegZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F022606A8B6;
	Fri, 13 Nov 2026 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aneupegZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E261F000C4;
	Fri, 13 Nov 2026 02:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794538311;
	bh=CF40HmncrmDjp8onngTCuMMBXj87s4VG4b5VuX10IJM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aneupegZlVgm2YfN9T9cXdk8qq3/dyi3RxmpqCFqe94dt0H4z/v9HRNyHPfFzCIZA
	 Mng9x5wiXxtQ7z19F7LfrRIDMnh5LmyTTmtUPejKXCUYi9Dq7iKN9wroWVEZkeijWB
	 4waW0pTrY/u9U44fx/zUJz0ytbVEK5g9DbPWmvKdCRHlfiiE9197/sayeGTtHwrT/1
	 5YanObbpSphIDSPfDuElsAq5EwbOFPBccxbSgEy/JWTluCOroXifjnVaZ0IdYmgGg5
	 eDtaSV6mx1yMjtE6B86fIf/BjzyWp0RDsO5p75hs6jsDrGlzXWm7K/G/+Hi5ZIBQXp
	 Pfn3eE2CDCOug==
Content-Type: multipart/mixed; boundary="===============1717861020100970034=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b06f05b8fcb5ab7b943d4471968e02ac1667b73566c88e653bf18e1e97c35d0c@mail.kernel.org>
In-Reply-To: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com>
References: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com>
Subject: Re: [PATCH] uprobes/x86: Emulate ENDBR as a NOP
From: bot+bpf-ci@kernel.org
To: hang.zhengyang1010@gmail.com,mhiramat@kernel.org,oleg@redhat.com,peterz@infradead.org,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,andrii@kernel.org,jolsa@kernel.org,hang.zhengyang1010@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 02:51:48 +0000 (UTC)

--===============1717861020100970034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> uprobes/x86: Emulate ENDBR as a NOP

TL;DR: Design question: Peter Zijlstra objected on v1 that probing ENDBR would
cause #CP on indirect calls if userspace IBT arrives; the author agreed to
drop it, yet the patch still emulates ENDBR as a NOP.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

> +/*
> + * ENDBR64/ENDBR32 (f3 0f 1e fa/fb).  Userspace IBT is not supported, so
> + * in a user task they are NOPs, and they start most functions in
> + * binaries built with -fcf-protection.  Revisit if userspace IBT is
> + * ever enabled.
> + */
> +static bool insn_is_endbr(struct insn *insn)
> +{
> +	return insn->length == 4 &&
> +	       insn->prefixes.nbytes == 1 && insn->prefixes.bytes[0] == 0xf3 &&
> +	       insn->opcode.nbytes == 2 && insn->opcode.bytes[0] == 0x0f &&
> +	       insn->opcode.bytes[1] == 0x1e &&
> +	       (insn->modrm.bytes[0] & ~1) == 0xfa;
> +}
> +
>  /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
>  static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  {
>  	u8 opc1 = OPCODE1(insn);
>  	insn_byte_t p;
>
> -	if (insn_is_nop(insn))
> +	if (insn_is_nop(insn) || insn_is_endbr(insn))
>  		goto setup;

Peter Zijlstra objected to this approach on the v1 thread:

  Uh, no. We must not allow uprobe on ENDBR. If we ever get userspace
  IBT (people are actually looking at that), then putting a probe on it
  will make indirect function calls #CP.

Has that objection been addressed?  The thread indicates the author agreed
and planned to drop the patch, yet this commit still emulates ENDBR as a
NOP in branch_setup_xol_ops().

Link: https://lore.kernel.org/all/20261112080406.GA2668804@noisy.programming.kicks-ass.net/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43353937212
--===============1717861020100970034==--
