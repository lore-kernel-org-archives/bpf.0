Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AF5695;
	Fri, 21 Aug 2026 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354699; cv=none; b=tmjGC1jh+Nwt+AZ+/jde4md+v3xBPMq4zTcvCyNpgVF23jr3VJoiDeyqTS5gptUhIC/D0Yq2prDWERlgxeAmprSvAjvh0tCyUEA6C5rCeP/cvIY3enCG9ykVqudjuoPdWblKnEE7mrCTZsFl8+29FXzNYs7Fmcrr2nWk/mNafWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354699; c=relaxed/simple;
	bh=llrd405ymITcCe7oclu0PC1CMDPWqVTzrXbgmTrXnms=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hRseUPgQaGlgwpgln8M/Y06P0pwraaLm5LpRf/fO9XSKIblRPdJAAMxlLz7agbss7cMnabgpiIK3gn/9k32o1j67aoq9xDFXXPfwjVfvb2Ecaq4QbzkBijwsSMcp7KaAO8+7wR2LBAilOzc3A5H84bGwCRZnOmK9NsyUHDGiYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m41YMl8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m41YMl8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636981F000E9;
	Fri, 21 Aug 2026 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787354698;
	bh=DKkB54kHOxAtMQt10UJpB+CGTeDAHSHmdNkyuIycIxY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m41YMl8HpVnMVS81xQRfmlmf37/c/5Jsrc/Qa95/P754fkpj7W1KrwQC1fhv+OOmr
	 Yq7z/wTfsqyerA3aFwBBidvq3y/szocRYeLBkVIUQ9ZrJO1g7bxZdpkqiL7PQjLas0
	 AnCoNQEWu08KoxkL/GnRJzEjXCaGaq9LEpYVaoAN5vRwg6fb40nP8tAJzJqnv1ptXw
	 EEmxhnvq7NfXXzUozK/jsxwUk08MtppXXAGhm87bI9MZ3aYbvUMzvJVC9TCNZSm8+B
	 Oa6Fx7NAzdrWnqnI28XglsoFn873o/x8FpBPw9ltW0NFqWsZQFUOJVELmKZPNmD9YF
	 nrB1879wX0NsQ==
Content-Type: multipart/mixed; boundary="===============6897875638889964055=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6a88fe55d543f5fe2a6d9e856acb4cf1b87b8210de58459df1272c8a456d926@mail.kernel.org>
In-Reply-To: <20260822-kasan-v7-1-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-1-99afee6ef7fd@bootlin.com>
Subject: Re: [PATCH bpf-next v7 1/9] bpf: mark instructions accessing program stack
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 23:24:57 +0000 (UTC)

--===============6897875638889964055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 004b06785521..412a13a664fa 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -725,6 +725,8 @@ struct bpf_insn_aux_data {
>  	u16 const_reg_map_mask;
>  	u16 const_reg_subprog_mask;
>  	u32 const_reg_vals[10];
> +	/* instruction can access non-stack memory */
> +	bool non_stack_access;
>  };

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e036ae20bf6b..040af75d9550 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3272,6 +3272,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
>  	env->insn_aux_data[idx].indirect_target = true;
>  }
>
> +static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
> +{
> +	env->insn_aux_data[idx].non_stack_access = true;
> +}
> +

[ ... ]

> @@ -6654,6 +6659,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>  				clear_scalar_id(&regs[value_regno]);
>  		}
>  	}
> +
> +	if (!err && reg->type != PTR_TO_STACK)
> +		mark_non_stack_access(env, insn_idx);
> +
>  	return err;
>  }

Does this test read the correct register type? For a load instruction where
dst_reg == src_reg (e.g., rX = *(u64 *)(rX + off)), check_mem_access()
receives reg = &regs[src_reg] and value_regno = dst_reg, so reg points to
the same slot that gets overwritten by the load.

When the pointer is PTR_TO_STACK, check_stack_read() runs:

check_stack_read_fixed_off() {
    state->regs[dst_regno] = *reg;  /* or mark_reg_stack_read() */
}

By the time execution reaches the new test, reg->type is the loaded value's
type (typically SCALAR_VALUE), not PTR_TO_STACK. The condition evaluates to
true and marks a stack-only access as non-stack.

Both check_load_mem() and check_store_reg() snapshot the pointer type before
calling check_mem_access():

    /* verifier.c check_load_mem */
    src_reg_type = regs[insn->src_reg].type;
    err = check_mem_access(env, env->insn_idx, ...);

    /* verifier.c check_store_reg */
    dst_reg_type = regs[insn->dst_reg].type;
    err = check_mem_access(env, env->insn_idx, ...);

Could check_mem_access() snapshot reg->type at entry and test that snapshot
instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32534828209
--===============6897875638889964055==--
