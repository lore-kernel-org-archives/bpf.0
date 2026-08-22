Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778732D3733
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359598; cv=none; b=Z39ve4AiKYCdEBIsFL/uv/BGHGLWqDX4v+syDaD3kN6MSEQAC/lqQRs/dmcy4DB4Pj3zDSB2J4uS4Pk7SCTgAc90I62iw4OdYbtCmF90eWda28o1t6Ok9RRt7Rdwvbqki10KV9RWzjL8aqA5Dmgn8t1PoWRyfTJV8Fit+14KoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359598; c=relaxed/simple;
	bh=jp6DaFrVmwGFgfxwSYQI5jJbKKqYWLYkG8b0/BeEPLY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vc/XVEjH61HoR+VYS5p1MosZAfGQbGyDh34qVk7lKuuOhn/o0vs/fxo5/Ja5zUK1qUfFEWqgpuOt4mEGQUtBzA8nZKnIaV6B/ngWC+OZ/6Hl4EhLzHFEN5hLeEZrreATxJnwhjlyfX+P2WQNvduSr0AOXPgLEq3i6FtEegwrP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSnpztoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSnpztoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58CC1F00A3A;
	Sat, 22 Aug 2026 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359597;
	bh=XslTEGmcWIEQ8p09aWHx21S8NMdbNEpyUHjaQHOh1Is=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CSnpztoXhkHzUh3MBzdaQb1c3ExGVxOIkqIs3Rxq3DysJ8oSWvgaIuLCClz+pA0u1
	 Fq9eP29uw0VAlYX3ljjfXJJswEVxNOlx8ZFqROqFm2NTrFIscmj69KAlQ7V/ucDhsI
	 Ww51gKIwN/Gacui2K5PEAIRrCsv5dApSubM4Ftz/aJIw5Ha4PHBLC6xChVhkMGCW76
	 uG1aGf+p/n4TBclU18bKJ0DjnqyfI2QkFjxQM14kwt+Qk998w+kc5ozkB5NYCPPQ/I
	 fhmQd5Qa7+OUez8eSgAeGobtWvqf8PeleBZfto+yxQaABxDLvgX6jZJi5BkwXN3QZx
	 MlwBly4sCn5UQ==
Content-Type: multipart/mixed; boundary="===============0849258577982221654=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e930052da6b6bc72fdadb4dd18354afb2fed2c2380fe996acddc03568c1e79b2@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-11-memxor@gmail.com>
References: <20260821233516.3426127-11-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/14] bpf, powerpc: JIT arena kfunc argument rebasing
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:36 +0000 (UTC)

--===============0849258577982221654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index fc9db691e8203..fc235fbfbeb97 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -624,8 +624,24 @@ static int prepare_for_kfunc_call(const struct bpf_prog *fp, u32 *image,
>  	for (i = 0; i < m->nr_args; i++) {
>  		/* Note that BPF ABI only allows up to 5 args for kfuncs */
>  		u32 reg = bpf_to_ppc(BPF_REG_1 + i), size = m->arg_size[i];
> +		u8 flags = m->arg_flags[i];
> 
> -		if (!(m->arg_flags[i] & BTF_FMODEL_SIGNED_ARG)) {
> +		if (flags & BTF_FMODEL_ARENA_ARG) {
> +			if (WARN_ON_ONCE(!ctx->arena_vm_start))
> +				return -1;
> +
> +			/* rN = kern_vm_start + (u32)rN */
> +			if (zero_extend(image, ctx, reg, reg, 4))
> +				return -1;
> +			if (flags & BTF_FMODEL_NULLABLE_ARG) {
> +				EMIT(PPC_RAW_CMPLDI(reg, 0));
> +				PPC_BCC_CONST_SHORT(COND_EQ, 8);
> +			}
> +			EMIT(PPC_RAW_ADD(reg, reg, bpf_to_ppc(ARENA_VM_START)));
> +			continue;
> +		}

This isn't a bug, but the comment above prepare_for_kfunc_call lists:

/*
 * Handle powerpc ABI expectations from caller:
 *   - Unsigned arguments are zero-extended.
 *   - Signed arguments are sign-extended.
 */

After this change the function also rebases __arena arguments onto the
arena kernel base. Would it be worth adding that as a third bullet?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============0849258577982221654==--
