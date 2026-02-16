Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D96A8D2
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268683; cv=none; b=DFwBh6m9WyY7GfFjxlSZuNHWChy2cTQDKv60SUrEMZZ7pRkT7GUpXLlGYIBc0p9IzC4VbzSFya5/WqY6yJan3bg0ziMI67rNvqPrhokSoQRy+HBie1VQzEU6nq3CkECfOqOCww6uKdXwL5xEmL4EsF7biGCV2PXQ+LFk678Smz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268683; c=relaxed/simple;
	bh=yjI1pebaI6r7KQ2q6CILtkaWvaMMBPInfZh8nsKzr9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLbM0WWlHLhTWLl2WvdseLFjzhMNTmCzWcNs2jMJ793FmmSPWG2YuMcWtrLftUZuuFKBnljRyghUEJqoAasJ/Hl4Bojq1yFHsbAQWzs+AGc3Af1Jp/5KHP/VopvqVY0Nc5KYuzcV+6KMDIaeajKCr9Y5UtYJfb4P3YdSZeTP3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EThKEibe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EThKEibe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E34BC116C6;
	Mon, 16 Feb 2026 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771268682;
	bh=yjI1pebaI6r7KQ2q6CILtkaWvaMMBPInfZh8nsKzr9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EThKEibemDxLo+tGw8ZUDqUS+Yv/ylWGFCUrJTXOJoYALAl0tiyRqOtqF0yHFYHco
	 yLTewKZOtrpFPQfHKFJtt3oQF0BqRCsNhXn8mlm+MsgS5XaYOsUyQj8VA6ycM5uNWw
	 fZysvq/LC+qCyqUtQ0GCFiiVLRJJm6KXzp7udgLD0dxritkL6/wqDu9LtUUukT+yb9
	 ltHTW0+aOtP66n5+m7Z77Prn4uMBLfycYkwWkUNOJZhxb1FfnG2+raEPKzti8W6ydA
	 7PJT8XoftHqRuX9hk7zeqEqZ/MRMSo0765UvFxaUIFJCJiuaepufYfg8ycWQQVGkJT
	 tvcb6Ms25oP1g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, martin.lau@kernel.org, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, Emil Tsalapatis
 <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2] bpf: Bump maximum runtime call stack depth
 to 16
In-Reply-To: <20260210213606.475415-1-emil@etsalapatis.com>
References: <20260210213606.475415-1-emil@etsalapatis.com>
Date: Mon, 16 Feb 2026 19:04:25 +0000
Message-ID: <m2ms18h5mu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emil Tsalapatis <emil@etsalapatis.com> writes:

> The BPF verifier currently limits the maximum runtime call stack to
> 8 frames. Larger BPF programs like sched-ext schedulers routinely
> fail verification because they exceed this limit, even as they use
> very little actual stack space for each frame.
>
> Bump the maximum runtime call stack depth to 16 stack frames. Also
> adjust selftests that assume the max runtime call stack depth is 8.
>
> This patch does not change the verification time limit of 8 stack
> frames. Static functions that are inlined for verification purposes
> still only go 8 frames deep to avoid changing the verifier's internal
> data structures used for verification. These data structures only
> support holding information on up to 8 stack frames.
>
> Global functions are each verified in isolation, so the old 8 stack
> frame limit now only applies to call stacks composed entirely of
> static function calls.
>
> This patch also does not adjust the actual maximum stack size of 512.
>
> CHANGELOG
> =========
>
> v1 -> v2 (https://lore.kernel.org/bpf/DG510ANGXEZH.BJ9EMMKHP5WT@etsalapatis.com)
>
> - Adjust patch to only increase the runtime stack depth, leaving the
> verification-time stack depth unchanged (Alexei)

If I am not mistaken, writing the Changelog here will get it into the
commit history. I always put it below the --- line below Signed-off-by:

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h                  |  3 +-
>  kernel/bpf/verifier.c                         | 40 +++++++++-----
>  .../selftests/bpf/progs/test_global_func3.c   | 52 ++++++++++++++++++-
>  3 files changed, 78 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index ef8e45a362d9..057f52a6b840 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -321,7 +321,8 @@ struct bpf_func_state {
>  	int allocated_stack;
>  };
>  
> -#define MAX_CALL_FRAMES 8
> +#define MAX_CALL_FRAMES 8 /* How many frames we can verify at the same time */
> +#define MAX_CALL_DEPTH 16 /* How deep of a stack we can have at runtime */
>  
>  /* instruction history flags, used in bpf_jmp_history_entry.flags field */
>  enum {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edf5342b982f..7e41d1dad284 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6660,17 +6660,17 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>   * and recursively walk all callees that given function can call.
>   * Ignore jump and exit insns.
>   * Since recursion is prevented by check_cfg() this algorithm
> - * only needs a local stack of MAX_CALL_FRAMES to remember callsites
> + * only needs a local stack of MAX_CALL_DEPTH to remember callsites
>   */
>  static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  					 bool priv_stack_supported)
>  {
>  	struct bpf_subprog_info *subprog = env->subprog_info;
>  	struct bpf_insn *insn = env->prog->insnsi;
> -	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
> +	int depth = 0, frame = 0, calldepth = 0, i, subprog_end, subprog_depth;
>  	bool tail_call_reachable = false;
> -	int ret_insn[MAX_CALL_FRAMES];
> -	int ret_prog[MAX_CALL_FRAMES];
> +	int ret_insn[MAX_CALL_DEPTH];
> +	int ret_prog[MAX_CALL_DEPTH];
>  	int j;
>  
>  	i = subprog[idx].start;
> @@ -6724,7 +6724,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		depth += subprog_depth;
>  		if (depth > MAX_BPF_STACK) {
>  			verbose(env, "combined stack size of %d calls is %d. Too large\n",
> -				frame + 1, depth);
> +				calldepth + 1, depth);
>  			return -EACCES;
>  		}
>  	}
> @@ -6740,7 +6740,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  				continue;
>  			if (subprog[idx].is_cb)
>  				err = true;
> -			for (int c = 0; c < frame && !err; c++) {
> +			for (int c = 0; c < calldepth && !err; c++) {
>  				if (subprog[ret_prog[c]].is_cb) {
>  					err = true;
>  					break;
> @@ -6757,8 +6757,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
>  			continue;
>  		/* remember insn and function to return to */
> -		ret_insn[frame] = i + 1;
> -		ret_prog[frame] = idx;
> +		ret_insn[calldepth] = i + 1;
> +		ret_prog[calldepth] = idx;
>  
>  		/* find the callee */
>  		next_insn = i + insn[i].imm + 1;
> @@ -6786,7 +6786,17 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		if (subprog[idx].has_tail_call)
>  			tail_call_reachable = true;
>  
> -		frame++;
> +		if (!subprog_is_global(env, sidx))
> +			frame++;
> +		calldepth++;
> +		/* Total call depth including globals */
> +		if (calldepth >= MAX_CALL_DEPTH) {
> +			verbose(env, "total call depth is %d frames, too deep\n",
> +				calldepth);
> +			return -E2BIG;
> +		}
> +
> +		/* Total stack frames in use (globals not included). */
>  		if (frame >= MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);
> @@ -6800,7 +6810,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
>  	if (tail_call_reachable)
> -		for (j = 0; j < frame; j++) {
> +		for (j = 0; j < calldepth; j++) {
>  			if (subprog[ret_prog[j]].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
> @@ -6813,13 +6823,15 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	/* end of for() loop means the last insn of the 'subprog'
>  	 * was reached. Doesn't matter whether it was JA or EXIT
>  	 */
> -	if (frame == 0)
> +	if (calldepth == 0)
>  		return 0;
>  	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
>  		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
> -	frame--;
> -	i = ret_insn[frame];
> -	idx = ret_prog[frame];
> +	if (!subprog_is_global(env, idx))
> +		frame--;
> +	calldepth--;
> +	i = ret_insn[calldepth];
> +	idx = ret_prog[calldepth];
>  	goto continue_func;
>  }
>  
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
> index 142b682d3c2f..9cef3ee3b473 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
> @@ -53,9 +53,57 @@ int f8(struct __sk_buff *skb)
>  	return f7(skb);
>  }
>  
> +__attribute__ ((noinline))

Using __noinline is better but the file already has this pattern so we
can  leave it.

> +int f9(struct __sk_buff *skb)
> +{
> +	return f8(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f10(struct __sk_buff *skb)
> +{
> +	return f9(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f11(struct __sk_buff *skb)
> +{
> +	return f10(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f12(struct __sk_buff *skb)
> +{
> +	return f11(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f13(struct __sk_buff *skb)
> +{
> +	return f12(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f14(struct __sk_buff *skb)
> +{
> +	return f13(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f15(struct __sk_buff *skb)
> +{
> +	return f14(skb);
> +}
> +
> +__attribute__ ((noinline))
> +int f16(struct __sk_buff *skb)
> +{
> +	return f15(skb);
> +}
> +
>  SEC("tc")
> -__failure __msg("the call stack of 8 frames")
> +__failure __msg("total call depth is 16 frames, too deep")
>  int global_func3(struct __sk_buff *skb)
>  {
> -	return f8(skb);
> +	return f16(skb);
>  }
> -- 
> 2.49.0
