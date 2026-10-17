Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F533CEA5
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208104; cv=none; b=Ji0z1Ig+IGVUeMAWrsa/VBtPtTdn0UCidPL6FOLg6mPu8uIkTPbXKCBkU7hRBi6I9CRam3hLrN7T2Z518b4v2ImrCsBLNLCEKeFvfRLoh9hGAezYhUD3wLW2O1yCYnjSRZDhoDjtdIEXLcrHZGemjLO7lfJ27u0YQDhg/w02pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208104; c=relaxed/simple;
	bh=cke0GW+thmnyNAbtJUFodkzYGhDrfLIi5aKkep/RCNE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rXG8w3E/LBc0UgF2Y3GFaRd/FceRTXW1pXACRTndHU9gqj8Evx2wz5pxQpBT3XdLsoDaWCVTcKTzEvB3IOooi6Jgm96ewDwKIq8oqdSFOPDcUC4ohjHFSOy7KHLUXS0L7NELkm8GMXfYWrwFB1Bl5SwM407jK2N0xl5C1zd/lFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj5fJhtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj5fJhtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371601F000C4;
	Sat, 17 Oct 2026 03:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792208102;
	bh=g1c2eNXpL4znJ8MyczMCnDNESyYE1qevOMm4Bvk+w7A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kj5fJhtUVMcd4E2SHeVJuRgvgvAaE4FMC4FKgIgkrzEc0NiTcBVFmGfQ23XrajZKk
	 vuBeNfnxiLakmGcAONdW8M9BrHXtQ5gLh4lc96puFwZSV33RUdoiVTAgbqE7N3/5VZ
	 hNDQC5RaFAyPq8IjNGI7oNGMNXhptxCNEjUZeUt6FMzNZR74qYy/o3XqfE5nMayJFt
	 Jfhm6DTovQOvox6iR2BZvIpPysBn2UwwevZzjS8funu/xkCJ4IGVPn0WBL9IDEJ4WN
	 NaouG50+hLuXJLkxZp3hqOX0EqOZShAXGfd84IP+Y9F13HWAkDlh4IoydByRGdtiHZ
	 1WITxAmn0NzFQ==
Content-Type: multipart/mixed; boundary="===============0534212307443945828=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0fca81fb0b00da256b581c75751323967d8e48a600694286fea6e46ba8f811a@mail.kernel.org>
In-Reply-To: <20261017025232.1925266-1-yonghong.song@linux.dev>
References: <20261017025232.1925266-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v12 12/25] bpf: Allow a subprog to end with a call that does not return
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 03:35:01 +0000 (UTC)

--===============0534212307443945828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow a subprog to end with a call that does not return

TL;DR: Inserting exits after final calls may shift verifier log instruction
indices for newly accepted programs, which could make libbpf's CO-RE
relocation lookup miss or name the wrong field. Was this intended?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3317,6 +3317,54 @@ static void find_subprog_properties(struct bpf_verifier_env *env)
>  	}
>  }
>
> +/*
> + * Put an exit after a call that ends a subprog, so that nothing from the CFG
> + * walk on has to know a subprog can end that way. check_subprogs() only lets
> + * such a call be to a callee that never returns, so do_check() never reaches
> + * the exit.
> + */
> +static int add_exits_after_final_calls(struct bpf_verifier_env *env)
> +{

[ ... ]

> +		patch[0] = *insn;
> +		new_prog = bpf_patch_insn_data(env, last, patch, 2);
> +		if (!new_prog)
> +			return -ENOMEM;
> +		env->prog = new_prog;
> +		/* The patch moved the call's aux data, orig_idx included, to the exit. */
> +		env->insn_aux_data[last].orig_idx = env->insn_aux_data[last + 1].orig_idx;

[ ... ]

> +	}
> +	return 0;
> +}

[ ... ]

> @@ -23661,6 +23718,24 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
>
> +	/*
> +	 * After everything above has recorded insn offsets, so the patch
> +	 * adjusts them, and before an offloaded program's per-insn state.
> +	 */
> +	ret = add_exits_after_final_calls(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +

Does inserting these exits before bpf_check_cfg() and do_check() shift the
instruction indices that the verifier log reports?

Until now no pass changed the instruction count before verification, so the
indices in the log matched the instructions user space loaded.  With this
patch, every insn behind a subprog that ends with a call moves down by one
for each exit added in front of it.  The CFG walk and do_check() print
env->insn_idx, so every message about those insns now carries an index that
is not in the loaded program.  insn_aux_data[].orig_idx exists for this kind
of mismatch, but only a few messages use it.

This has a concrete effect on libbpf.  fixup_log_failed_core_relo() in
tools/lib/bpf/libbpf.c reads the index from the log and uses it to find the
relocation:

    if (sscanf(line1, "%d: (%*d) call unknown#195896080\n", &insn_idx) != 1)
        return;
    relo = find_relo_core(prog, insn_idx);

find_relo_core() needs an exact relo->insn_idx match.  Take a program whose
main subprog ends with "call _Unwind_Resume" (the prog() example in the
commit message) and that has a poisoned CO-RE relocation at index N in a
later subprog.  The kernel now logs that instruction as N+1, so libbpf
either finds no relocation and leaves the raw "unknown#195896080" message,
or picks up a different CO-RE relocation sitting at N+1 and names the wrong
field.

The cleanup-record messages are affected as well.  "resume at insn %d is not
in a landing pad" and "insn %u ... is in a landing pad" now print shifted
indices, while bpf_exc_check_info() reports the user's own offsets.

Only programs that this patch newly accepts are affected, since
add_exits_after_final_calls() patches nothing otherwise.  The commit message
says the exits are put in "before the CFG walk" but does not mention the
effect on the log indices.

Was this intended?  Would it make sense to report orig_idx in the do_check()
messages, or to handle a final call without inserting instructions until
after verification?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38997507726
--===============0534212307443945828==--
