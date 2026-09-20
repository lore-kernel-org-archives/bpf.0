Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7537DAD0
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885916; cv=none; b=XeXUxpass5RPtiFB+MEjlxWmbgw+2W42BB2D8Vls3Um4pvSik6xn1FiDlzyERQ6rn1q/CqqZAwSwkHgsyzwsxam23BDaU7diaHlidIhkT747+LJOrteOJ3wCRuzxW4BcwRhfqZO2RYGoqM7wUdhCF97QOGlBxr0Og/B64Mc9d4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885916; c=relaxed/simple;
	bh=K90b6s5wmWhKp5e1RMMVKwc92fnowWYkpo3yQUh8zss=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jDDmMG5TTwL7zloUF8O9F/MqjVKXDj/6o+UDOtutZp4XLi/C2YnV6Yc7SHrvNW60CKmSqqa4OqodX8GSpPWf7neIkedw98PUGrcieVqAXF+MG5tg1pFHFRpdLCiAjbRby5ZFiwO41OiOIIqPZb+LOYsDumQm2ILtUfhnYcz8sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0dKG0dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0dKG0dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F3A1F000FF;
	Sun, 20 Sep 2026 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885915;
	bh=sOnd1ppRL6ng58ovyu2aYaGJj03NdgXHnljRUFsGQkY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b0dKG0dkDvVkhOIXT+4aLkBfyTuuS7ifMJvoc7kLB3Y+AvwrMCwOZW4XZxcBPZEZ4
	 srz4+puODR+KLfXeEFoXDQs6uzVF7FjmvY6/0hUUyvrg24dLhtZ3BcGPzqoA2BnETi
	 UVEJA/bghQMdfzov44ojLnIJGl0uEEkqcjyFg+rtV/Pc5tXszVbK1YmMSytV3Qc9jP
	 VSQz4rcR5Yo+95EsRTq/VXdCwX1w6aw2CAxqaCPYNumwsN5PiLDAKurL9NtQgda52j
	 TsevakXUHhaEUCYm9ceeyJwH2njZ4tyVfT2+8sRJa5zEaQ+V7sPsJjbiNAdKwOG3rr
	 1zLng57D4xE6w==
Content-Type: multipart/mixed; boundary="===============6774932007669049647=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb1fb8d9a506beb7657f12aa599bce576b6e97f4329b91ab874e5c4bb595ebb3@mail.kernel.org>
In-Reply-To: <20260920054241.866442-1-yonghong.song@linux.dev>
References: <20260920054241.866442-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 03/20] bpf: Add lookups for exception cleanup resumes and landing pads
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:31:54 +0000 (UTC)

--===============6774932007669049647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c08505b9ba82..f9bccd3e0f4d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -681,6 +681,11 @@ struct bpf_insn_aux_data {
>  	bool needs_zext; /* alu op needs to clear upper bits */
>  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
>  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
> +	/*
> +	 * 1 + the instruction index of the exception cleanup landing pad this
> +	 * call site unwinds to, or 0 for none.
> +	 */
> +	u32 cleanup_pad;
>  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
>  	u8 alu_state; /* used in combination with alu_limit */
>  	/* true if STX or LDX instruction is a part of a spill/fill

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 2add8001c3ec..dd1a6b5a6afd 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -261,6 +261,11 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  		}
>  	}
>
> +	if (env->cleanup_info_cnt)
> +		for (i = 0; i < prog_len; i++)
> +			if (data[i].cleanup_pad > off + 1)
> +				data[i].cleanup_pad += cnt - 1;
> +

Does this miss the case where the original instruction is not placed last
in the patch buffer? Looking at adjust_insn_aux_data(), there's logic
earlier in the function that handles non_stack_access when the patched
instructions contain the original:

kernel/bpf/fixups.c:adjust_insn_aux_data() {
    for (i = off; i < off + cnt - 1; i++) {
        /* Expand insni[off]'s seen count to the patched range. */
        data[i].seen = old_seen;
        data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
        if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
            data[i].non_stack_access =
                data[off + cnt - 1].non_stack_access;
            data[off + cnt - 1].non_stack_access = false;
        } else if (bpf_is_mem_insn(insn + i)) {
            data[i].non_stack_access = true;
        }
    }
}

The memcmp branch transfers non_stack_access from data[off + cnt - 1] to
data[i] when it finds the original instruction. A bit further down,
indirect_target gets similar treatment.

cleanup_pad is a property of one specific call instruction (the landing
pad this call site unwinds to), not of an instruction slot. When
bpf_patch_insn_data() parks the original instruction's aux record in
data[off + cnt - 1] but the patch buffer places the original instruction
at position i (not last), shouldn't cleanup_pad be transferred the same
way?

Without this transfer, after such a patch the surviving call instruction
would have cleanup_pad == 0 (no landing pad) and an unrelated newly
generated instruction would carry the pad index instead. The CFG edge from
the call to its pad would disappear, and an exception unwinding through
that frame would silently skip its cleanup.

A later commit (d710bf82c5e9, "bpf: Dispatch exception cleanup pads from
bpf_throw()") adds these lines to the memcmp branch:

    data[i].cleanup_pad = data[off + cnt - 1].cleanup_pad;
    data[off + cnt - 1].cleanup_pad = 0;

Should that transfer belong in this commit, which introduces the field and
claims to keep it in step?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============6774932007669049647==--
