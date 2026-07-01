Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2D4279E3;
	Wed,  1 Jul 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902686; cv=none; b=oYcBPNUIgvutwJv0tz0hmZcErZceRKAJ6gYXlmQ7jDCgPh36IqsPoWdBymwP/+YY0c1tafxvPxXriGL1OZsFdYKaVZcqdjWjUCQvsm9vEwhE7wiuvqjh9gXNvlZ1eL+jsCUtjd7IJzaK+CEiDZZlkGIRgzP/6jhpT70a6SRnCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902686; c=relaxed/simple;
	bh=22BN81haHn9CcqmXBudCyd1BJcedm/mnjx51lMVR+/c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WFNk+UjshSarn+RrkqJNNZRHJ7L3m1O2e5VviK0Ppy64Q/9nNLjacFh7d1ho/XBXMk11Cn0Oasuo/kL/zmynS24V+bEdK+b1kRYlZ4yurJ8oy9W18EBZcAzlUNoSfgMvZRblBzHlX5V70ckddFou4jh1eWW528XjfxdYhQzYAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ2ClB/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ2ClB/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771901F000E9;
	Wed,  1 Jul 2026 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902683;
	bh=wepbMP3/BE7g6nzDnaTC409Q7bb2wwQ00wd49MBIFS4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aJ2ClB/4GvUEVbOPbZBJgpnoVlMou74R1uqSxFTGOR1aHCRW8no2ZmGxV6HDJPWy2
	 QuatUXASx5aDH3Ztnv6YL490yUwnCP3Yi01zsiruA+u09PtPJW3GlYxJW+2cs/I25d
	 KE30dfFK7GncpgMOq+HJnAfFiwIvev6SkhmmM4FdKhcmjStrAFfdBC+BGKsy0jb8Z7
	 OqapWfr1NINuWMQA83gQ9WoQ4J1eF6kUmPrJ9whkiz61JxeDeecxAGu24Oj+zyG2NR
	 q7gDXnkpCA39IGizkSXxcEVvvCwKxaWTwEP+YErtd/4xNZifwuz5q/bf8oo05xMumI
	 pZv3V7LhIJx9Q==
Content-Type: multipart/mixed; boundary="===============0014069580846647058=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e3bce1e3c102583e483b4089fb4dc62c8663036a2907e478ae0c29e07ee31543@mail.kernel.org>
In-Reply-To: <20260701-kasan-v3-6-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-6-bd09bb942d86@bootlin.com>
Subject: Re: [PATCH bpf-next v3 06/10] bpf, x86: emit KASAN checks into x86 JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 10:44:43 +0000 (UTC)

--===============0014069580846647058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b70cecfec179..a383ffc8f289 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2605,14 +2640,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			}
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
> +			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +			u32 real_src_reg = src_reg;
> +			u32 real_dst_reg = dst_reg;
> +			u8 *branch_target;
>  			if (insn->imm == (BPF_AND | BPF_FETCH) ||
>  			    insn->imm == (BPF_OR | BPF_FETCH) ||
>  			    insn->imm == (BPF_XOR | BPF_FETCH)) {
> -				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> -				u32 real_src_reg = src_reg;
> -				u32 real_dst_reg = dst_reg;
> -				u8 *branch_target;
>
>  				/*
>  				 * Can't be implemented with a single x86 insn.
> @@ -2626,7 +2661,19 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				if (dst_reg == BPF_REG_0)
>  					real_dst_reg = BPF_REG_AX;
>
> +				ip += 3;
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				err = emit_kasan_check(env, &prog, real_dst_reg,
> +						       insn, ip, false,
> +						       accesses_stack_only);
> +				if (err)
> +					return err;
>  				branch_target = prog;
> +			}
> +			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> +			    insn->imm == (BPF_OR | BPF_FETCH) ||
> +			    insn->imm == (BPF_XOR | BPF_FETCH)) {
>  				/* Load old value */
>  				emit_ldx(&prog, BPF_SIZE(insn->code),
>  					 BPF_REG_0, real_dst_reg, insn->off);

This isn't a bug, but the FETCH-op check

	insn->imm == (BPF_AND | BPF_FETCH) ||
	insn->imm == (BPF_OR | BPF_FETCH) ||
	insn->imm == (BPF_XOR | BPF_FETCH)

is now spelled out in two adjacent if blocks in this case, where it was
written once before the patch.

Could it be hoisted into a single local (e.g. bool is_fetch = ...) so the
two copies don't have to be kept in sync on later edits?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28510424881
--===============0014069580846647058==--
