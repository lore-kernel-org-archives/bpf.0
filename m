Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D23B9DB3
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540813; cv=none; b=lIbgwfRZ4dJH4V8CgII/DtpCwvPz96Dx/6+mG83gkT3i6Ejt1TRGC1ERDSnOaxeFCj3kiWi9lgwNkTpCtyU2t7cC1mvM+1BcafXdJkyGyw5vuQ29JfmEAOPkyfR/HDIYsH/QSSUelBFavxvoxenAh4rXZmDBdMix8rJclBJXjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540813; c=relaxed/simple;
	bh=nbbQ90Q/NnxGHlSLt/X3nIc52+WtDpOi1tm3fUlupPw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T9rb8SV6Yr8wvUgjB+7Asd5k7Zi7GYYWSrZAmZt5wqWA2eEo7+evPZE7sBRs11ZDI8Xe5CZ41muEIM6bYD7ScwJOe3UeXi4gA1M4AwJfh37MaKbpspmUuKqNanz+93kNkb5IF5IOw7kjW6Hkrsi+oymwLsluTFz8GjfsSge44PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCSIcHgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCSIcHgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395EB1F00893;
	Sun, 27 Sep 2026 20:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540811;
	bh=P6XYOk7c+lhtlTLeR9XHs1lX7rL2L7pjZhtI+SJm2Zc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kCSIcHgjO2oTRBzWDv6gJnWWzDtk6BLSM3uzpiPTfP1hDW19E/Upx+nbgld9INu7E
	 2APxJzg02raMN9zuCt/+C5GHaNUE5yQIWX9B4jMFvNjzexJHOpyc+HVjotMnPDAbJs
	 1pTU0dYsEB2Qfe6wzmkKA8vmOCEoRf3m7KT5/rkq6SJnBLSroVolQkkDRQCjnkufeN
	 6MQMswehlYtjQuLUzey8VCc9osrWcP8vKgJZ1tPPF0vC+uJFCukVOtGg95qZfQ1jQY
	 tlfoSqBlquEFIwaBeFW1OagrUhzavmXzbzBoQgq2RGh6EN3VbR31JiL+JrGyPtrb8e
	 evH7/ac3oSvtw==
Content-Type: multipart/mixed; boundary="===============3698181780228876384=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <930065cdf0c6219809851e9b214836f7cc8f6c2ecaeb1635ffbb3da52ab5e41d@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-12-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-12-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 12/36] bpf: expose comparison opcode transformations
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:26:51 +0000 (UTC)

--===============3698181780228876384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 706fdefbc07a..075a28de2a04 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1858,4 +1858,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
>  int bpf_do_misc_fixups(struct bpf_verifier_env *env);
>  int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
>
> +int bpf_flip_opcode(u32 opcode);
> +u8 bpf_rev_opcode(u8 opcode);
> +
>  #endif /* _LINUX_BPF_VERIFIER_H */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1ec44d72a346..79aa92486154 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17565,7 +17563,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
>  /* Opcode that corresponds to a *false* branch condition.
>   * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
>   */
> -static u8 rev_opcode(u8 opcode)
> +u8 bpf_rev_opcode(u8 opcode)
>  {
>  	switch (opcode) {
>  	case BPF_JEQ:		return BPF_JNE;

The patch renames rev_opcode() to bpf_rev_opcode(), but there's still
a comment in regs_refine_cond_op() that references the old name:

kernel/bpf/verifier.c:regs_refine_cond_op() {
    ...
    case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcode() */
        if (!is_reg_const(reg2, is_jmp32))
            swap(reg1, reg2);
    ...
}

Should this comment be updated to reference bpf_rev_opcode() instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============3698181780228876384==--
