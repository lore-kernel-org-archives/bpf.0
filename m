Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC613AEB5C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522789; cv=none; b=cc8PN7qV2TLl/G3pzLfvUItfAyKybhTsBNJS2k4PlvUwRp8DScz/oKB0Hdc6y8SriLk7ve9t14yf/DEnaCYN/QThKSKdb2KY+AHCOcXMqJVBcKFRkDrv+nInsJPwxO8ZzhyZdYLLcvQimvaZPGbpW56AUKp+qiMD/0/fQASiw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522789; c=relaxed/simple;
	bh=m+0UPlPubHgj//bN/nN4vz+diOjY813oZ1yL6lYEyjw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bSSJD4vIPEiD5mAH7SPA58euo0Kmc3yd8voHsiMoul/uZfipbg8K5nprZM+PDt6Fngs5+X5TsuFRNQJ1YWMJZeQF3MNVmrrvP2rAXRqCgX6yC1BAJSqYF17IHDbGRmrUAerwZAlUaauU1kPpDtDRo8Z1KXwVf1aJFsdFfWEfgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc4RW+eN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc4RW+eN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09421F000FF;
	Fri,  9 Oct 2026 05:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522788;
	bh=StGFMJxCgvuCnyqvozAc7z62cYRd5L4xImnhM+9/I+0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hc4RW+eNushf16UQUVko+VnK+Bp1l8miqdFX5icjYJcogqZfiEiQ23F0d41woPuwo
	 3+jFE05+qlnTs1UQaYIDomsFYHxEYCYS11Tp1maJjBNtrvJZAEJJTVnj19MXCPs6pi
	 hq0oT8ICiAXC3V7qEtIBd61sgT44tOMBKqv9ObQEJd3ROvT7fJK2U6KPzSD5eJ1roq
	 tY7hU2Cjw/YjdIqemgNUC3OHfYMpjkfoznUX07i+ULW28BlpOPLP2kkCgBYbDWDdvM
	 Aoj7AOwsCK6M+Rt4TM2aduLut9oveLkd5sYlNabtrqvf/RO84gQl4HuMza9V0LNIqB
	 7KCHKAefQeu0A==
Content-Type: multipart/mixed; boundary="===============8739963224573954399=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a00a49d056adef7ace9b597d1f682ea168bac9382001c0b31ce3ebdefbf35ba@mail.kernel.org>
In-Reply-To: <20261009041544.29907-1-yonghong.song@linux.dev>
References: <20261009041544.29907-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Prepare JITed programs for dispatching cleanup pads
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 05:13:06 +0000 (UTC)

--===============8739963224573954399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Prepare JITed programs for dispatching cleanup pads

TL;DR: keep_subprog_exits() may mark an exit seen in a never-entered subprog,
so dead-code removal can miscompute subprog starts and drop main's exit,
letting JITed main fall off its image end.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 64baee1a37e6..1cc025c45ecd 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -715,6 +716,32 @@ static void keep_funcs_with_addr_taken(struct bpf_verifier_env *env)
>  	}
>  }
>  
> +static int keep_subprog_exits(struct bpf_verifier_env *env)
> +{
> +	u32 i, j;
> +
> +	for (i = 0; i < env->subprog_cnt; i++) {
> +		bool found = false;
> +		u32 start;
> +
> +		if (!env->subprog_info[i].might_unwind)
> +			continue;
> +		start = env->subprog_info[i].start;
> +		for (j = env->subprog_info[i + 1].start; j-- > start; ) {
> +			if (env->prog->insnsi[j].code != (BPF_JMP | BPF_EXIT))
> +				continue;
> +			env->insn_aux_data[j].seen = env->pass_cnt;

Can this mark an exit as seen in a subprog the verifier never entered?

might_unwind is set statically while walking the control flow, so it is also
set on a static subprog that is only called from a path the verifier proves
dead, for example one guarded by a .rodata constant or a constant register.
None of that subprog's instructions are seen, but the loop above still marks
its last exit as seen.

Before this patch a live subprog was always entered at its first
instruction, and adjust_subprog_starts_after_remove() relies on that.  Now
the first instruction of a subprog can be dead while a later exit is kept.
bpf_opt_remove_dead_code() removes each contiguous run of unseen
instructions even when the run crosses a subprog boundary, so one run can
cover the end of the previous code and the head of this subprog, and stop at
the kept exit.

Here is a trace (privileged loader, with bpf_unwind registered and the x86
cleanup pad support from later patches in the series):

  main:  0: r1 = 0
         1: if r1 == 0 goto +2   ; always taken
         2: call P               ; dead
         3: call A               ; dead
         4: r0 = 0
         5: exit
  P:     6: r0 = 1               ; static, never entered, no unwind
         7: exit
  A:     8: call bpf_unwind      ; static, never entered, might_unwind
         9: r0 = 0
        10: exit                 ; kept by keep_subprog_exits()

The first dead run, [2,3], is removed correctly, leaving P.start = 4,
A.start = 6 and the fake subprog at 9.

The next dead run is [4..7]: all of P plus A's call and 'r0 = 0'.  It stops
at A's kept exit, so off = 4 and cnt = 4.

In adjust_subprog_starts_after_remove(), i is P.  The j loop reaches the fake
subprog, whose start (9) is not off + cnt (8), so:

	if (env->subprog_info[j].start != off + cnt)
		j--;

gives j = A.  Since j > i, P's entry is dropped and A moves into its slot,
and then the start adjustment gives A.start = 6 - 4 = 2.  The correct value
is 4.

The program is now:

  0: r1 = 0
  1: ja +0
  2: r0 = 0
  3: exit
  4: exit

with subprog starts main = 0 and A = 2, so main has lost its own
'r0 = 0; exit'.  After bpf_opt_remove_nops() main is just [r1 = 0].
jit_subprogs() then JITs func[0] with no exit, so it has no epilogue and no
ret, and the first run of the program falls off the end of main's image.  If
main had kept a jump into the reassigned tail, do_jit() would also read
addrs[] past func[0]->len.

The same miscalculation happens when P is a live subprog with only a dead
tail (the i == j case, where start != off).

Would it make sense to skip subprogs that were never entered, since they can
never be on the stack during an unwind, for example:

	if (!env->insn_aux_data[start].seen)
		continue;

Alternatively, could adjust_subprog_starts_after_remove() set the start of a
partially removed subprog to off?

None of the later commits in this series appear to change keep_subprog_exits()
or adjust_subprog_starts_after_remove().

> +			found = true;
> +			break;
> +		}
> +		if (!found) {
> +			verbose(env, "subprog %u can be unwound through but has no exit\n", i);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37884246994
--===============8739963224573954399==--
