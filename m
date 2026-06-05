Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931BF2EEE6E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644179; cv=none; b=Qx/EmE5kSx9n3zMY75cZcIyk9Viae1Y/LtcpP52gmFBtbRcG8ClcOUAEfUnwcH36EVl87XxdFXxanvvXfkOcak2V5SZbWKqB2kNApXI2e5VvkiACLRZ04WhFeVZYtHK99rhQh1u5GHxYCf6cL3DjDTNj4KRZ9ONxtHkNQPQz2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644179; c=relaxed/simple;
	bh=blPO2dzFBMqOBwjA+0ZACNibMJ+FvnKglHTugSxnzds=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g26RloegDIPd5VdronOObx8B8ehqJMfy/nsQOBRdOujl/nuIhuh8AuCF6TVemLllMy+p2U8qAl6Sr6WSKCC7Ev7CvIVO8PiIfImo88D/0bgo/d3/Z1bEUgHjoszq/cfkvqekQW6Dzyb8sqk2/3/6Xbr19yp8j3QSPpCijHEZkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4nJ90Aj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4nJ90Aj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A1B1F00898;
	Fri,  5 Jun 2026 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644178;
	bh=VKga1nnZ221YtrZTLnCH0Hmy+f86N++rlh4uwq7QKIQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K4nJ90AjZywTGdhfNAFQ+P2tGQzWo/De5aWcMovREmW58SkT8oj64Pz0kbvGySWiU
	 eoPg0QPaSDfqU0OiFAGbIPOpVKszkouYHEX9J9lyv5sSuI3+lwx17HNVpUjZAsEL01
	 eib+yIJ0VeizJWSChmQ4Iuc8tqJRWYtAbeDt8dq/k8IPfXB0Vg4dwABIhh4750GKVT
	 HVYw0zJZ5drNnlRhBf2TzSZnv54dbEYBsb7v0KkKLPBsOHQ8INXGSR2oOxginQ9kKf
	 0SX1+gEI4gBS9OzZvQEinHZlwdv4gJ83G59hv9X2kxplmFKgDIioRDfmSMITma/EQ4
	 +Fvp9i5pyLlIw==
Content-Type: multipart/mixed; boundary="===============0677829864853650184=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb354248514f9e95ee0a390a36761ebc121ad69dfa80d625bf9efc313b4c2954@mail.kernel.org>
In-Reply-To: <20260605063412.974640-14-memxor@gmail.com>
References: <20260605063412.974640-14-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 13/17] bpf: Report Program Structure CFG errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:22:57 +0000 (UTC)

--===============0677829864853650184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 2d8417f4efff..24096bb7ca87 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e30d79149cc7..325c162e3df0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2879,6 +2879,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  	int i, subprog_start, subprog_end, off, cur_subprog = 0;
>  	struct bpf_subprog_info *subprog = env->subprog_info;
>  	struct bpf_insn *insn = env->prog->insnsi;
> +	char reason[160];

The format string contains 142 characters of static text and accepts 5
integer arguments. Because BPF programs can contain up to 1,000,000
instructions, instruction indices can take up to 7 digits. Formatting these
integers can add up to 31 characters, resulting in a string length of around
173 bytes. Since the reason buffer is limited to 160 bytes, scnprintf() will
silently truncate the output and the user will see a cut-off diagnostic
message.

Reference: https://lore.kernel.org/bpf/20260605065130.BB6CA1F00893@smtp.kernel.org/

>  	int insn_cnt = env->prog->len;
>
>  	/* now check that all jumps are within the same subprog */
> @@ -2907,6 +2908,15 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  		off = i + bpf_jmp_offset(&insn[i]) + 1;
>  		if (off < subprog_start || off >= subprog_end) {
>  			verbose(env, "jump out of range from insn %d to %d\n", i, off);
> +			scnprintf(reason, sizeof(reason),
> +				  "Instruction %d jumps to instruction %d, but subprogram %d only contains instructions %d through %d. A branch target must stay inside "
> +				  "the same subprogram",
> +				  i, off, cur_subprog, subprog_start,
> +				  subprog_end - 1);
> +			bpf_diag_report_program_structure(env, i,
> +							  "jump out of range",
> +							  reason,
> +							  "Keep branch targets within the same subprogram, or use an explicit subprogram call.");
>  			return -EINVAL;
>  		}
>  next:
> @@ -2919,6 +2929,13 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			    code != (BPF_JMP32 | BPF_JA) &&
>  			    code != (BPF_JMP | BPF_JA)) {
>  				verbose(env, "last insn is not an exit or jmp\n");
> +				scnprintf(reason, sizeof(reason),
> +					  "Subprogram %d reaches its last instruction %d without an exit or jump, so control could continue into the next subprogram",
> +					  cur_subprog, i);
> +				bpf_diag_report_program_structure(env, i,
> +								  "subprogram can fall through",
> +								  reason,
> +								  "End each subprogram with exit, throw, or an explicit jump that keeps control flow inside the subprogram.");

The newly added suggestion advises users to use throw to end subprograms.
However, the immediately preceding logic in check_subprogs() verifies the
final instruction using:

    if (code != (BPF_JMP | BPF_EXIT) &&
        code != (BPF_JMP32 | BPF_JA) &&
        code != (BPF_JMP | BPF_JA))

This condition does not account for bpf_throw(), which is a kfunc and
evaluates as a BPF_JMP | BPF_CALL instruction. If a user writes assembly
following the newly provided suggestion and places a bpf_throw call as the
absolute end of their subprogram, won't the verifier still reject it and
print this exact error?

Reference: https://lore.kernel.org/bpf/20260605065130.BB6CA1F00893@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============0677829864853650184==--
