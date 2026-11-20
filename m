Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211507;
	b=kSN36lLo7D6TPa8x4KnjScoTOsNKjNlNeRx6WtZUKx8AC3nrmvU+7CXeMh82RheQ6qO1
	 nWN8vwGT1065Yj7QocC5ytgZHgb6SA8XrJGIAbU42fdmCC/TSCNY1rvTJzyAtqAS+EmaM
	 4WMmS5y3YqirU117UNHJQCwTxN+nyj56kzUQr0bdBBL+XdHKoL/CQuzBht4s1lewAGIKP
	 vx4bct/DOgI3guaG+bZJePa8x68bvErWMhW5Wc/fCekc2u39ff5xtbt7qng4OvkoElnqy
	 ZLXJ7UJq6t8ys0e8sIWx7+YBY4yidX5BogNLLoZ4S+kIArtUc2Pm/2rgmgysO1v4zxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211507;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HkClxND7LfQtg5pxy69i2JJdQrIexTqBCwT6TsFW0/Y=;
	b=0QRy58gGOaO+oj3D1CqJl0godKQ3k+q80Xu+G8W4DK4xes7kM7b0TY+l6zr/ORE5O9Pk
	 BCcd7RaiIRcemyajE8SdcAUC736SOrkpp4+oJYxNdOxoDmUM4lkndt0q7NG87kYuyEIFG
	 c2Akd0hNAtpV6jFmqD6LrSORs4Di5Juh0UmuY9YvrFUj7uxRrCY9rwokFHCXhgWSIqRRZ
	 Ylq/F4hhBzyG9d0P2J+p+UNiZ2gIlMyw4GAOn6DIomtvYK1SXT3PDMV4/TvOaaVgSO3Y2
	 84GCEClbHn1aPImyVv1WtE8d5Hqkk1uDR3/tk1vxj206L5ukLlSlUr38dXHwJ+22Hlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/FrPEiC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8D606A6AB
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/FrPEiC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCC1F000C0;
	Fri, 20 Nov 2026 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211506;
	bh=HkClxND7LfQtg5pxy69i2JJdQrIexTqBCwT6TsFW0/Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P/FrPEiCzwnhVEyrTCGOg1HlFjAix3qOObLJON70aloxM+QzHAkNVq8av5siEbPv1
	 HUqZNMc1WtwT1uTxucz6xVm3FNlOkgzn+1Wu7J7OUGgqL50ouArqu5Z7GKicGin+Eh
	 8X6U3ionwbCJQ6pKqtfxrpKFC96LH+ledCrLneZBPmYzhIBli1juwQ9tCNkmr3oUkW
	 uAjr0Q3GMk5fF2Tj3gbwvUaTZ2ICnd1OfMcat13dUpYe8oH4+W/NAb+Sri3pzr8QXD
	 9rDEooYtbv76L75AQrbaNiaba8wcA60udobwbWI+xGoKiP4mhyGOuu0gJPPJZh9aPU
	 r6l/YUPrrESuw==
Content-Type: multipart/mixed; boundary="===============1519614845726449351=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <534d6c966f57da77b15e013cf7529350caadd9987b6bf4da11fcdde30071bfc6@mail.kernel.org>
In-Reply-To: <20261120204959.614908-23-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-23-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 22/49] bpf: Continue a pass after an unproven insn
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:45 +0000 (UTC)

--===============1519614845726449351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Continue a pass after an unproven insn

TL;DR:
- Possible NULL env->precision dereference on any rejected program, a kernel
  oops that breaks bisection until a later patch
- note_error() zeroes log level, so failed-load logs and stats may be lost
- Early return may skip noting an unproven insn

> diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
> --- a/kernel/bpf/precision.c
> +++ b/kernel/bpf/precision.c

[ ... ]

> +bool bpf_same_insns_unproven(struct bpf_verifier_env *env)
> +{
> +	struct bpf_precision *prec = env->precision;
> +
> +	return env->for_log || (prec->last_unproven_left == 1 && !env->new_linear_xreg &&
> +				test_bit(env->insn_idx, prec->last_unproven_insns) &&
> +				!test_bit(env->insn_idx, prec->this_pass.unproven_insns));
> +}

Can this dereference a NULL prec?  Nothing in this commit assigns
env->precision, and env comes from kvzalloc_obj() in bpf_check(), so the
pointer stays NULL.  env->for_log and env->path_sensitive are not written
either, so both stay false.

A rejected program then reaches the new code in do_check_block():

> +		} else if (error_is_recoverable(err) && !env->path_sensitive) {
> +			env->insn_idx = prev_insn_idx;
> +			if (bpf_same_insns_unproven(env))
> +				return err;

For example a socket filter with r0 = *(u32 *)(r1 + 0xffff) returns -EACCES
from do_check_insn(), and bpf_same_insns_unproven() reads
prec->last_unproven_left through NULL.  Before this patch the load was
rejected with the error.

The same NULL pointer is used by these paths:

  note_error() -> bpf_note_unproven_insn()
      __set_bit(..., prec->this_pass.unproven_funcs)
      (reached from do_check_common() for any error of a state, e.g.
      -EFAULT)

  check_held_in_leftover() -> bpf_same_insns_unproven()

  fixups_differ() -> bpf_note_fixups_differ() -> suspect_loops_of_insn()
      env->precision->this_pass.suspect_loops |= ...
      (reached before the nospec_ends_path() check, so a speculative state
      that hits "same insn cannot be used with different pointers" also
      crashes, where it used to be accepted with a nospec)

Any user who can load BPF programs can trigger this.

The allocation is added later in the series: bpf_precision_init() in
61b3482f7d0f ("bpf: Partition the states after an error"), first called
from do_check_all() in 02e7abee2ca0 ("bpf: Verify in passes").  The commits
from this one up to that point oops on any rejected program, which breaks
bisection.  Should the allocation, or a NULL check on env->precision, be
part of this commit?

The commit message also says check_after_pass() uses
bpf_find_unproven_after_pass(), but nothing calls that function until
02e7abee2ca0.

Also, in this commit do_check_common() and do_check_main() still return
"ret".  If env->precision were valid, a program with a failed check would
be skipped past by skip_unproven_insn() and could be accepted with
ret == 0, although the commit message says "Such a pass accepts nothing".

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* The pass has an error. The log ends with the first error. */
> +static void note_error(struct bpf_verifier_env *env, int err)
> +{
> +	if (!is_error_of_state(env, err))
> +		return;
> +	if (!env->err) {
> +		env->err = err;
> +		env->err_insn = env->insn_idx;
> +		env->log.level = 0;
> +	}

Is the user's log level restored before bpf_check() calls
bpf_log_attr_finalize()?  bpf_vlog_finalize() treats level 0 as "no log":

    *log_size_actual = 0;
    if (!log || log->level == 0 || log->level == BPF_LOG_KERNEL)
        return 0;

For a failed load with a log buffer this means:

- log_true_size is reported as 0 instead of the needed size
- a log that wrapped in the default rotating mode is not rotated back
- a truncated log no longer returns -ENOSPC
- print_verification_stats() checks env->log.level, so the "processed N
  insns" and stats lines are no longer printed for a failing program

At this commit the NULL env->precision dereference in the
bpf_note_unproven_insn() call below happens first.  At 61b3482f7d0f the
problem is visible, because the level is still not restored.  92146e43b75d
("bpf: Reproduce an error on one path, with no joins") saves and restores
env->log.level later in the series.  Could this commit restore the level
before the log is finalized?

[ ... ]

> @@ -21380,12 +21532,29 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
>  			need_nospec(env, prev_insn_idx);
>  			free_pushed_states(env);
>  			goto process_bpf_exit;
> +		} else if (error_is_recoverable(err) && !env->path_sensitive) {
> +			env->insn_idx = prev_insn_idx;
> +			if (bpf_same_insns_unproven(env))
> +				return err;
> +			if (from_unproven)
> +				bpf_note_reads_from_unproven(env, prev_insn_idx);
> +			else
> +				note_error(env, err);

When bpf_same_insns_unproven() is true this returns before note_error(), so
the insn that ends the pass is never set in precision->this_pass.unproven_insns.
The fallback in do_check_common() does not help once another insn has
already failed in the pass:

    if (ret && !env->err)
        note_error(env, ret);

check_held_in_leftover() has the same shape: it returns -EINVAL before
note_error() when bpf_same_insns_unproven() is true.  bpf_flow_edge_unproven()
handles this differently: it computes "last" with bpf_same_insns_unproven(),
calls note_error() anyway, and only then returns.

At the series tip, bpf_partition_more() swaps this_pass into last_pass,
copies last_pass.unproven_insns into last_unproven_insns and ANDs
err_insns with it.  The lost insn is dropped from the next pass's set and
from the insns where the failing path can end.

A concrete case: pass N has unproven insns {X, Y}, with X as err_insn.
In pass N+1, Y fails first and is noted, so last_unproven_left drops from 2
to 1.  Then X fails:

    last_unproven_left == 1
    X in last_unproven_insns
    X not in this_pass.unproven_insns

so do_check_block() returns without noting X.  partition_helped() then
evaluates !test_bit(first_unproven_insn, this_pass.unproven_insns) as true
even though X failed again, and the partition is reported as helpful.  The
path-sensitive run that follows cannot end at X, because X was masked out
of err_insns.

The verdict stays safe since a pass with env->err set accepts nothing, but
the partitions kept, the number of passes and the failing path that is
logged can differ.  Should note_error() be called before this early return,
as bpf_flow_edge_unproven() does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============1519614845726449351==--
