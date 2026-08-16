Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABB38F25C;
	Sun, 16 Aug 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786880605; cv=none; b=BHP4bMRPAfNf+liNn2aWS/grckQCpgV0NjkJl6CQly2W1ScOuohFmsJyvnmMqbAzVabcVFQ4COHtNglHXxH9jqz+tfZeLl8P7bvyEjMaNmU29HHghYdMIAEPyJg/nMR4V57aU+1GHMuesistDowasyOHb6uyNksdoYJ5Z2X7KRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786880605; c=relaxed/simple;
	bh=95qM+648/6/bwW0zTKBkD68TwnfIpwIczJEHLzfnaTg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bWuzhZoZjLgJUuIheBAM1o6s/6pXPvEjgGXXQcOpQ8mblsbRSZBkfFcD/3rkPC1I89vZRDuXtAhya2SufFrBFAa9T6LQm5QPl9kZUPagqEUTiEgs/ZVtul8/hfqg+WGeYMvxgtezQo9F5y+v9wgJ0ouNDtM0j4PPTGIB0LVt5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asw2i/4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asw2i/4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C031F000E9;
	Sun, 16 Aug 2026 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786880603;
	bh=4bwyFjrWA1ti65GnM4D0QfJ6pSauz6paINXfzFFaDX4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Asw2i/4E1aI2d1Ry/CdCXHEgT+PYz9flhFBh4JfM10KMYCDTl+DI0PHNEzBEYHgSL
	 4bcOJC4VmSykJTajJlkmmGED+XsEXzso4Xf0sZyPVjOLYdc/ypgi7cQMtMiVrs63Mn
	 Sf2IBHGGGVJXwQOvU5bOOHV7OU79kQtUHo+hhcm+kVe6PMiAVmuHa3Yh3nFjTaqzHH
	 yldXck1ihxGA2EXUrrKC+XrwmWdy4z4r0sqG10J1A1hj2TC+ttVjDqNrsmEDCrei7D
	 OtNP8l5wGJ4oudvMp5mbNaAiGlBTuMJkgkawbuALLvqH7KEJ9QbzMsFwKaE3hJUWPj
	 Lz1w3KKzG5+ig==
Content-Type: multipart/mixed; boundary="===============4573482612144578179=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <585cf79505dfbbd961eefad95a134c02d0fc30f6693b157a8ed4f1824c2e1db4@mail.kernel.org>
In-Reply-To: <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
References: <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover mixed arena and stack atomics
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 11:43:22 +0000 (UTC)

--===============4573482612144578179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> index b241bbcf54a8..b22bab33301a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
>
>  #endif
>
> +static const struct bpf_insn addr_space_cast_insn = {
> +	.code = 0xbf,
> +	.dst_reg = BPF_REG_7,
> +	.src_reg = BPF_REG_7,
> +	.off = 1,
> +	.imm = 1,
> +};

This isn't a bug, but could the struct carry the same kind of decoding
comments as the raw insns in stream.c?  The register fields are written
symbolically (BPF_REG_7) while the three fields that actually need decoding
are bare numbers: .code = 0xbf is BPF_ALU64 | BPF_MOV | BPF_X, .off = 1 is
BPF_ADDR_SPACE_CAST, and .imm = 1 is the (dst_as << 16) | src_as encoding
for as(1) -> as(0).

Could it be annotated like stream.c does (e.g. /* BPF_ALU64 | BPF_MOV |
BPF_X */, /* BPF_ADDR_SPACE_CAST */, /* (dst_as << 16) | src_as */)?  And
could the .8byte line below note that it is r7 = addr_space_cast(r7, 0, 1)?

> +
> +SEC("socket")
> +__description("arena and stack atomic at the same instruction")
> +__failure __msg("same insn cannot be used with different pointers")
> +__arch_x86_64
> +__load_if_JITed()
> +__naked void mixed_arena_stack_atomic(void)
> +{
> +	asm volatile ("					\
> +	r1 = %[arena] ll;				\
> +	r6 = r10;					\
> +	r6 += -8;					\
> +	r9 = 0;					\
> +	*(u64 *)(r6 + 0) = r9;			\
> +	r7 = 8192;					\
> +	.8byte %[addr_space_cast];			\
> +	call %[bpf_get_prandom_u32];			\
> +	if w0 != 0 goto 1f;				\
> +	r8 = r6;					\
> +	goto 2f;					\
> +1:	r8 = r7;					\
> +2:	r9 = 1;					\
> +	lock *(u64 *)(r8 + 0) += r9;			\
> +	r0 = 0;					\
> +	exit;						\

This isn't a bug, but would it be worth adding one more tab on the r9 = 0;,
*(u64 *)(r6 + 0) = r9;, 2:\tr9 = 1; and r0 = 0; lines so the line
continuations line up like the rest of the block?  Four of the seventeen
continuation lines put the trailing backslash at column 48 instead of the
column 56 used by the other thirteen lines.

> +"	:
> +	: __imm_addr(arena),
> +	  __imm_insn(addr_space_cast, addr_space_cast_insn),
> +	  __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  static __noinline
>  u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
>  {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31943300584
--===============4573482612144578179==--
