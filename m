Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82417361DC1
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779273; cv=none; b=nfIdjYlZe/L8hXlvS2PDW8kX84F3wbvrREHyScdlTdHBozB0caId28TREcyQVNBtTdzsSpdvqV/O0nMi1YRLdcvZ+PB3LF96J6W5mDZrBUjQNwS2mKnzjMz5sGYl52jeYcAEuZ7O6wJAINlg41uMO/aRI92ZQisU1ZcnUTrc6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779273; c=relaxed/simple;
	bh=/rBmCbXwsr9Ea175NzCDRidQh3z1vyl0zHwxwxfsnGs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NwFOR/vMdfwCp29WxYC9sl5+5OzF8V6f9J4rD3b8h0kad+qFsJilwahGjI6rKuX0zzManc71gQJF7dG2WyaYA8vESvuUQ4yqskuMJG8rDazc8o6uXQbJ89U1/YauwtE0tVFxsCF81IjOTVuT80KZW9RDPI1UE619AAJ3gKFtXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfWu4LIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfWu4LIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9600A1F000E9;
	Sat, 15 Aug 2026 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779272;
	bh=g2EEelWDgQB1DFcBu8Gj+zE3EeKauSrqDPWFtuc6tsc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RfWu4LIE4wnhD2rD5ZYjDcttpeBuJ/HfYGu4CmY5ouauN+njYgSG71Hvt/DFwGKQF
	 moyNYVt1wQFeOTmhIaYOYcw6P/v5dXs34HG/7XA6seAj1lF/XYwSOzvOAx2soQbLiG
	 nxyrfio8lvQiNNTEtCjRTvGK+HOQZQmuvSU1YpNwWlfo+I/2Ukl/vwt+2QBLt+xffZ
	 yfhIMk1AoAWF6nRMX1/mRAz0Q3y6j8xC5BkDIRZB0F+kZH/6tfksiETuFqyvqkMDsJ
	 MjTBhu/XYb7z31zSTQo+oe7tvofTtYwuU+4/gpcB004exxAZh4URBKJUcao4fMB2vl
	 qzwPNwdjpNTww==
Content-Type: multipart/mixed; boundary="===============2928070511263479366=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org>
In-Reply-To: <20260815064612.378577-14-memxor@gmail.com>
References: <20260815064612.378577-14-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 13/14] bpf: Report Program Structure CFG errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:31 +0000 (UTC)

--===============2928070511263479366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c

[ ... ]

> @@ -315,6 +326,11 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
>
>  	if (!jt) {
>  		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
> +		bpf_diag_program_structure(
> +			env, subprog_start, "missing jump table",
> +			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
> +			"No jump table was found for the subprogram that starts at instruction %u.",
> +			subprog_start);
>  		return ERR_PTR(-EINVAL);
>  	}

The new report passes subprog_start as insn_idx to
bpf_diag_program_structure(), which means the "At" section will
annotate the first instruction of the subprogram rather than the gotox
instruction that actually failed.

Looking at the call chain:

    create_jt(t, env)
        jt_from_subprog(env, subprog_start, subprog_end)

create_jt() knows both t (the failing gotox instruction) and
subprog_start. jt_from_subprog() only receives subprog_start and
subprog_end, so it can't point at the right instruction.

For example, if the program has main at insns 0-9 calling subprog f at
insns 10-20 with a gotox at insn 15 and no matching jump table,
create_jt() will call jt_from_subprog() with subprog_start = 10.
The diagnostic would annotate insn 10 (f's first instruction) even
though the gotox is at insn 15.

Should the report receive t from create_jt(), or should create_jt()
emit the report itself so it can use both t and subprog_start?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[ ... ]

> @@ -3020,6 +3020,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  		off = i + bpf_jmp_offset(&insn[i]) + 1;
>  		if (off < subprog_start || off >= subprog_end) {
>  			verbose(env, "jump out of range from insn %d to %d\n", i, off);
> +			bpf_diag_program_structure(
> +				env, i, "jump out of range",
> +				"Keep branch targets within the same subprogram, or use an explicit subprogram call.",
> +				"Instruction %d jumps to instruction %d, but subprogram %d only contains instructions %d through %d. "
> +				"A branch target must stay inside the same subprogram.",
> +				i, off, cur_subprog, subprog_start, subprog_end - 1);
>  			return -EINVAL;
>  		}

Can these two bpf_diag_program_structure() calls in check_subprogs()
produce the source context that the patch advertises?

Looking at the verifier initialization in bpf_check():

    ret = bpf_prepare_btf_info(env, attr, uattr);
    ret = add_subprogs(env);
    ret = check_subprogs(env);
    ret = bpf_check_btf_info(env, attr, uattr);

check_subprogs() runs before bpf_check_btf_info(). Inside
bpf_check_btf_info(), check_btf_line() sets prog->aux->linfo and
prog->aux->nr_linfo. Before that, both are zero.

In bpf_diag_source():

    linfo = bpf_find_linfo(env->prog, insn_idx);
    if (btf && linfo)
        bpf_get_linfo_source(btf, linfo, &src);
    if (!src.file || !*src.file || !src.line || !*src.line) {
        diag_write(env, "  insn %u\n", insn_idx);
        ...
        goto out_restore;
    }

bpf_find_linfo() needs nr_linfo to be nonzero. Since check_subprogs()
runs before check_btf_line(), nr_linfo is still zero, so bpf_find_linfo()
returns NULL and bpf_diag_source() takes the degraded branch: bare
"insn %u" plus an instruction dump, with no source file:line:col and no
subprogram name.

The other 8 new report sites in this patch (push_insn, create_jt,
jt_from_subprog, visit_gotox_insn, bpf_check_cfg, sort_subprogs_topo)
all run after bpf_check_btf_info(), so they do get source context.

Should these two reports move to a later point where line info is
available, or should the commit message acknowledge that source context
isn't available yet for these early checks?

> @@ -3032,6 +3038,11 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			    code != (BPF_JMP32 | BPF_JA) &&
>  			    code != (BPF_JMP | BPF_JA)) {
>  				verbose(env, "last insn is not an exit or jmp\n");
> +				bpf_diag_program_structure(
> +					env, i, "subprogram can fall through",
> +					"End each subprogram with an exit or an explicit jump that keeps control flow inside the subprogram.",
> +					"Subprogram %d reaches its last instruction %d without an exit or jump, so control could continue into the next subprogram.",
> +					cur_subprog, i);
>  				return -EINVAL;
>  			}
>  			subprog_start = subprog_end;

[ ... ]

> @@ -3104,6 +3115,11 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
>  					verbose(env, "recursive call from %s() to %s()\n",
>  						bpf_subprog_name(env, cur),
>  						bpf_subprog_name(env, callee));
> +					bpf_diag_program_structure(
> +						env, idx, "recursive subprogram call",
> +						"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
> +						"This bpf2bpf call would make the subprogram call graph recursive. "
> +						"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
>  					ret = -EINVAL;
>  					goto out;
>  				}

The "recursive subprogram call" report's Reason section carries no
information about which functions are involved, but the verbose() call
immediately above it does:

    verbose(env, "recursive call from %s() to %s()\n",
            bpf_subprog_name(env, cur),
            bpf_subprog_name(env, callee));

Both cur and callee are in scope here, and bpf_diag_program_structure()
was given a vararg signature (__printf(5, 6)) so the reason string can
be formatted. Every other new report in this patch uses format
specifiers to include program-specific details.

Could the Reason include the function names to tell the user which
edge creates the cycle?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============2928070511263479366==--
