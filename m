Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C440802C
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742238; cv=none; b=sfWfgh3DBJh12SCnwgwTW8HAzxZnk4vknc8mTbDwOtCJAdcn4TCd5vay75/Nq56Gun/PRQ/Y9Oa+dlzJanVW8Hxx4Bw3MRsnvXadeCwj2f1Q4o8WXZWy8Axy5ZCn5B8KV6qUXC4E3PcejyGUSSVm2En0TvdZNeY2kK2RNBa6K+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742238; c=relaxed/simple;
	bh=2kxmWxcETEb3vDCu1T85edgzhqCy22DHMmXVywmipRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZRi4XTsc+pfwcowvhzytYXH97dBQjo693EnKk8g0fSKez9+i7RdPHknYhZ9XECD75YJvqKAyA7ZNrrEroMklDSvVc6xwli6Mdy96FJRZhIy2X25IOT6uEWv8r3tpRfKWvD7KcOidTrre1Je+sG1kPz7maGkoI1Z+xBo5eMgN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmSFa5xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmSFa5xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F6F1F000E9;
	Mon, 29 Jun 2026 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742235;
	bh=AcXItKB7qnxqHibqhYUzLhC++idTk4yQRF+vlE3rmfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fmSFa5xabWzu8FlvyWO+v8iijFqKFA3OKfgrkVPZ7Pxp1UY4uaOtMAD4UR1coi46J
	 QJxLmT0pOroXs/1C6isEhhtijnvkSZumE+03ZjfffVarOcqkT7TZBSlqbFsX7eU1mJ
	 ImDn8E1asjC6T4EmfGLMh4QWrE4XSeEp/+cyXHErXZ909e2G78VoAxMJUAaON5w9qQ
	 40bv4Z3bHXfSCee8M1/QdVzvtEZ3np7Q/tO8v1bDvDbOZmqIjOnCrrWgdKtQIP/Yqo
	 DnXsopE6oxTDcwtb8s0owHVSw+E/atA84g4dVHLK7JntFJGV7+Y/JaT1oqCyCivybp
	 vBU5dkSKcjICA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 4/6] riscv, bpf: Add RV_TAILCALL_OFFSET
 macro to format tailcall offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629140048.733346-5-pulehui@huaweicloud.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <20260629140048.733346-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:10:34 +0000
Message-Id: <20260629141034.D5F6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The tail call offset macro `RV_TAILCALL_OFFSET` incorrectly do=
uble-counts the KCFI preamble when `CONFIG_CFI` is enabled, causing tail-ca=
lled programs to skip their stack pointer adjustment and corrupt the caller=
's stack frame.
--

commit 655037e3f7e62935bb76d41ae8cffb13d2a38d50
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset

Add RV_TAILCALL_OFFSET macro to format tailcall offset, and correct the
relevant comments.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 69512d93ca4a7..c239696cca646 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -21,6 +21,8 @@
>  #define RV_KCFI_NINSNS (IS_ENABLED(CONFIG_CFI) ? 1 : 0)
>  /* imm that allows emit_imm to emit max count insns */
>  #define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
> +/* kcfi, fentry and TCC init insns will be skipped on tailcall */
> +#define RV_TAILCALL_OFFSET ((RV_KCFI_NINSNS + RV_FENTRY_NINSNS + 1) * 4)

[Severity: Critical]
This is a pre-existing issue, but does RV_TAILCALL_OFFSET incorrectly
double-count the KCFI preamble when CONFIG_CFI is enabled?

Since prog->bpf_func already skips the 4-byte KCFI hash (because it points
to ctx->ro_insns + cfi_get_offset()), it looks like including RV_KCFI_NINSNS
here overshoots the correct jump target by 4 bytes.

Does this skip the necessary stack pointer adjustment instruction, causing
tail-called programs to execute prologue register saves using the unadjusted
stack pointer of the caller and potentially corrupting the kernel stack?

[ ... ]

> @@ -272,9 +274,7 @@ static void __build_epilogue(bool is_tail_call, struc=
t rv_jit_context *ctx)
>  	if (!is_tail_call)
>  		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
>  	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
> -		  /* kcfi, fentry and TCC init insns will be skipped on tailcall */
> -		  is_tail_call ? (RV_KCFI_NINSNS + RV_FENTRY_NINSNS + 1) * 4 : 0,
> -		  ctx);
> +		  is_tail_call ? RV_TAILCALL_OFFSET : 0, ctx);
>  }

[ ... ]

> @@ -394,7 +394,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit=
_context *ctx)
>  	off =3D ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
>  	emit_branch(BPF_JEQ, RV_REG_T2, RV_REG_ZERO, off, ctx);
> =20
> -	/* goto *(prog->bpf_func + 4); */
> +	/* goto *(prog->bpf_func + RV_TAILCALL_OFFSET); */
>  	off =3D offsetof(struct bpf_prog, bpf_func);
>  	if (is_12b_check(off, insn))
>  		return -1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629140048.7333=
46-1-pulehui@huaweicloud.com?part=3D4
