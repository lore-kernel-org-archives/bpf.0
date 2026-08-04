Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9B343D72
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835905; cv=none; b=pJ4mQhGFplm82wtWWqu7/8OlY5o4vwFAm1SCtp/xTb+yEdIFfyoNJSGzuWdVWWlya/I1DCOoR59v02B+SrAo6qZo1bLAlar0QWAVXIWWwpRKPhP5XCEjxCGrrx6xx5ZIPkDMFwiXG27Afs7a8NAr7Q8WY5sYU/vyhdvv2t+fE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835905; c=relaxed/simple;
	bh=DLaeJPl+l8e35HwYML2lZrUaGpe7vDdyFRLd75RSjCc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=siBI2gG2KZtMJE2u9rcqsM16lqVKisMcLtZ6QG+p9KzQ0oiUZIY1nAHSKUb4arADaesU4x3sOVkCzTtBrcTsTWqShD+sJLUr76fVsbrw4bpKwOq1os5Vr8n7N1/VBLGkV4zmH6DGyi5KO/OGhF31dpXbIZPtsK5aLOmQMrJPChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz/MgcTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz/MgcTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3961F000E9;
	Tue,  4 Aug 2026 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785835903;
	bh=VtYqcNfd/vlnl1qBqRICvGtp+qOHNi/a+XjXjoq+ez4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lz/MgcTfu5yFFJeuyFIpnao8qPJitEGq7yv5cCAYJJrh0tcZXF1s90nQjfmrB8KsN
	 osJtShcuD1aSygLQtbMMmJVZ9G2x2Yw+ee3RQzBIic+myKtWsBrfoTsckupCYTaHHh
	 RHCH2zt9YNyhqX2I5iulZjBV3+M/NDZVZC+N9lMzVCH371NuKekmeuHoe5sGWuDm8W
	 D03XV9IE9l50pdnYYFv1bZLQGrF6eZvwEbhAtPGoEz/azBOeDPE7kXeAZnMXsuvBI+
	 JzHBTdOd6R7d9rWKIZg0Z5tL0isosr88rJyPOrrHasSucpIMSeUtMW00r5IOXOzdP/
	 FOJLhigLxViag==
Content-Type: multipart/mixed; boundary="===============4204528012165586130=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89233ff19ba231586f1785f43c58f90c0d0ff756a8ff2e0232c475cfaea0b599@mail.kernel.org>
In-Reply-To: <20260804081114.3871564-2-memxor@gmail.com>
References: <20260804081114.3871564-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stack depth stats
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Aug 2026 09:31:43 +0000 (UTC)

--===============4204528012165586130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd9..80c249906fd39 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18777,15 +18777,21 @@ static void print_verification_stats(struct bpf_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i = 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> -		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
> -		for (i = 1; i < subprog_cnt; i++)
> -			if (bpf_subprog_is_global(env, i))
> -				verbose(env, "+%d", env->subprog_info[i].insn_processed);
> -		verbose(env, "\n");
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
> +		for (i = 0; i < subprog_cnt; i++) {
> +			const char *name = env->subprog_info[i].name;
> +
> +			if (!name || !name[0])
> +				name = "<unknown>";
> +			if (i == 0)
> +				verbose(env, "prog (%s) insns %d stack %d\n", name,
> +					env->subprog_info[i].insn_processed,
> +					env->subprog_info[i].stack_depth);
> +			else
> +				verbose(env, "subprog %d (%s) insns %d stack %d\n", i, name,
> +					env->subprog_info[i].insn_processed,
> +					env->subprog_info[i].stack_depth);
> +		}
>  	}

The new loop prints insns %d for every subprogram, but
subprog_info[i].insn_processed is only ever written for the main program
and for global subprograms. The old code encoded exactly that with an
explicit filter:

kernel/bpf/verifier.c (old):
    verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
    for (i = 1; i < subprog_cnt; i++)
        if (bpf_subprog_is_global(env, i))          /* <-- filter removed */
            verbose(env, "+%d", env->subprog_info[i].insn_processed);

The only two writers are do_check_main() and do_check_subprogs(). The
latter is reached only after:

kernel/bpf/verifier.c:18711
    if (!bpf_subprog_is_global(env, i))
        continue;

and the whole function returns early at:

kernel/bpf/check_btf.c:1070
    if (!aux->func_info)
        return 0;

env is kvzalloc'd, so for every static subprogram, callback (bpf_loop,
timer), and every subprogram of a program loaded without BTF func_info,
insn_processed is structurally always 0. Those instructions were counted
into the caller's record, because static subprogs are verified inline as
part of the calling frame.

Does this mean that for any program using static subprograms or callbacks
the new per-subprog insns field shows 0 rather than where verifier work is
actually spent?

The patch's own new expectations confirm this. Every "subprog N (...) insns"
line added in this commit is for a non-global subprogram (dummy_loop_callback,
cumulative_stack_depth_subprog, timer_cb1, subprog1, subprog2), and each
uses the permissive {{[0-9]+}} regex that matches 0.

This directly contradicts the stated purpose: "it is hard to see where
verifier work is spent". Either the bpf_subprog_is_global() filter should
be kept (omit the field, or the whole record, for subprograms that are not
independently verified), or the field should be marked as not-measured
(e.g. insns -) so that 0 is not mistaken for a real measurement.

Related coverage loss from the same root cause:

> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 67dc352addfd7..1755f133f0205 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -52,7 +52,7 @@ __msg("('global_calls_good_only') is global and assumed valid.")
>  /* eventually global_good() is transitively validated as well */
>  __msg("Validating global_good() func")
>  __msg("('global_good') is safe for any args that match its prototype")
> -__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
> +__msg("prog (chained_global_func_calls_success) insns {{[0-9]+}} stack")

The old anchored pattern asserted that exactly three independent counts
were emitted (main + global_calls_good_only + global_good). The
replacement checks only the main-program record and asserts nothing about
the two global subprogram records. Could the one test that actually
validated per-global-subprog instruction accounting be preserved?


The BPF_LOG_STATS payload grows roughly an order of magnitude per
subprogram, which can turn a previously-succeeding program load into
-ENOSPC for callers that pass their own fixed log buffer.

Old stats output scaled at about 4 bytes per subprogram ("+%d" for the
stack chain, plus "+%d" only for global subprogs). New output emits a full
line per subprogram: "subprog %d (%s) insns %d stack %d\n", roughly 40-50
bytes plus the BTF name, which btf_name_valid_identifier() bounds only by
KSYM_NAME_LEN == 512. With BPF_MAX_SUBPROGS == 256 permitted subprograms
the stats section goes from under ~2 KB to well over ~12 KB, and far more
with long function names.

Does this matter? Looking at the load path:

kernel/bpf/log.c:45-58 bpf_vlog_update_len_max()
    tracks the required size in log->len_max.

kernel/bpf/log.c:295 bpf_vlog_finalize()
    returns -ENOSPC when log->ubuf && log->len_max > log->len_total.

kernel/bpf/verifier.c:20397-20402 bpf_check()
    err = bpf_log_attr_finalize(attr_log, &env->log);
    if (err) ret = err;
    if (ret) goto err_release_maps;

so the successful verification is turned into a failed BPF_PROG_LOAD.

A userspace loader that sets log_level = 4 (stats only) with a modest,
fixed log_buf sized against the old output will start failing to load
multi-subprogram programs after this change. libbpf only auto-retries with
a larger buffer when it owns the buffer:

tools/lib/bpf/libbpf.c:8064-8071
    if (own_log_buf && errno == ENOSPC ...)

so callers supplying their own log_buf get the failure.

Could the number of per-subprog records be bounded, or emitted only above
some log level, to avoid the behaviour change for stats-only callers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30891720984
--===============4204528012165586130==--
