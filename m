Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FF37F727
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411486; cv=none; b=odYxxqenlLSCdrsll1IUvg/ijOw4RJgENjXJ5ewlWJ00MJELexWDA9FWGEvZjUqWn0va4srxCnXx++O8oRlCXv/zdI4HS58GT+Rf++KQiIcSIC8B5l3YaDEpTJtWMkj7MdtMrxhM2cBf9F/OWuY3iQD5XkIi6Bqf9laS1E6rdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411486; c=relaxed/simple;
	bh=z0MEFbGJ3e56OBYnIBULetBnO1o7ofvIz/5TqAGmBus=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eoqAFZ/7hOG6w84EfOJlzbL/rfRf0USqJ6rwvmtyhWuUVpUFaZ9E5nwijZJuJUFBanD+au0It4yViZ/GpurJs/eHXbKfYbAAgcJxtUp01aHe6ui8z0PZUmypAaCH38mW1HdQaygZODVCK5U6VbisqHT6WuTHPyE537i8fCNW0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdhSqg/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdhSqg/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D91F00A3A;
	Tue, 11 Aug 2026 01:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411485;
	bh=dKeATCyZYz5yDpfsqb+G0bfYZ9dje+aps0mF7NHFAVc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BdhSqg/2B6ulg6LgcOcCok7PwmpzXvdLKHKOF7a2t00TcLfxvQPJYVN2Uga1F7es7
	 Ko8g7U4rWVmqSllGxWeoy/u1AMKH31lKftDB0qZy0kJy3C7HkWbLTgD4+yqMHHRaCK
	 D6L8mbN7GdwyRxL37L3j77mZ5HDp/PTsImCsIWre8eDSVlLYJL7EeGPJ9Ja7ZykIar
	 ykk1p038XDi/WvSACccCyjFSV4C9IwKcGQY1Mv/hOtiuSOn4e0x3TAEb8bVxRScwSM
	 r4OGCtKPwkqmnkTYBMUk0/Gq4vka+nhyrSj5kwzOZ9WT0ZlN3mXHWNqSlrHLQlcV68
	 Pj2Z9HnO25cyg==
Content-Type: multipart/mixed; boundary="===============5447536458762560471=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0796c556995285a17bc51b371fb413f000498e0d78d5a040ef8dba50010726d@mail.kernel.org>
In-Reply-To: <20260811000952.2382568-1-yonghong.song@linux.dev>
References: <20260811000952.2382568-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 08/13] bpf: Reject register-pair returns when the subprog BTF is unreliable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:24:44 +0000 (UTC)

--===============5447536458762560471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit cb2551cf6e866ae6692739f7cbb75ff97e2d1a3b
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Mon Aug 10 17:09:52 2026 -0700
>
>     bpf: Reject register-pair returns when the subprog BTF is unreliable
>
>     The R0:R2 return convention is derived from the BTF function prototype:
>     bpf_compute_subprog_ret_regs() inspects the return type of every
>     subprogram and records whether its value comes back in a register pair.
>
>     btf_check_subprog_call() can decide, at a call site, that this BTF is
>     not to be trusted and mark the subprogram unreliable, which happens when
>     compiler optimizations remove arguments from a static function or when a
>     mismatched type is passed to a global one. From that point on the
>     verifier falls back to conservative, R0-only, semantics for the
>     subprogram, while the compiled code keeps returning a pair and leaves
>     the upper half in R2 behind the verifier's back.
>
>     Rather than silently mistracking R2, reject a return value larger than
>     8 bytes as soon as the prototype it was derived from becomes unreliable.
>     Add subprog_ret_pair_unreliable() and test it at the two places that can
>     observe the flag: check_func_call(), for the call itself, and
>     prepare_func_exit(), for the return from an inlined static subprogram.
>
>     Note that the main program needs no such check: a >8 byte return from
>     subprog 0 is rejected at BPF_EXIT regardless of whether its BTF is
>     reliable. Callbacks need none either: a callback address only becomes a
>     PTR_TO_FUNC through check_ld_imm(), which already rejects any callback
>     returning more than 8 bytes.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for register-pair return support. Should this
include:

  Fixes: d280e9c973c5 ("bpf: Add verifier support for 16-byte returns in R0:R2")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 944f0721086bd..8f0c4aed0781f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -438,6 +438,21 @@ static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>  	}
>  }
>
> +/*
> + * A >8 byte BPF return changes the calling convention to R0:R2, so the
> + * verifier can only allow it while the subprogram's prototype remains
> + * reliable. Once BTF is marked unreliable, reject the feature instead of
> + * silently falling back to R0-only semantics.
> + */

Does the verifier actually fall back to R0-only semantics? The return
convention is read through bpf_ret_reg_pair():

  include/linux/bpf_verifier.h:
  static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
  {
          return subprog_info(env, subprog)->ret_reg_pair;
  }

and ret_reg_pair is computed once in bpf_compute_subprog_ret_regs() from
the BTF return type. It is never recomputed or cleared when unreliable
becomes true.

Grepping every reader of func_info_aux[].unreliable finds exactly three,
none of which touches the return convention:

  - btf_check_subprog_call(): returns -EINVAL early on a later call site
  - btf_prepare_func_args(): verifier_bug() + -EFAULT
  - bpf_check_attach_target(): sets 'conservative' for fentry/fexit

So when unreliable becomes true, prepare_func_exit() still computes
nregs = 2 and still models R2. For a static subprogram the verifier walks
the callee, prepare_func_exit() propagates the callee's real R0/R2, and
clear_caller_saved_regs() marks R0-R5 NOT_INIT at every call, so a caller
that reads R2 without the callee having written it gets 'R2 !read_ok'.

Worth either citing the concrete path where R2 is mistracked, or dropping
the claim and stating the real motivation (unreliable BTF means the
prototype the convention was derived from cannot be trusted at all)?

> +static bool subprog_ret_pair_unreliable(struct bpf_verifier_env *env, int subprog)
> +{
> +	struct bpf_prog_aux *aux = env->prog->aux;
> +
> +	return bpf_ret_reg_pair(env, subprog) &&
> +	       aux->func_info_aux &&
> +	       aux->func_info_aux[subprog].unreliable;
> +}
> +
>  static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
>  {
>  	struct bpf_func_info *info;
> @@ -9459,6 +9474,11 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	err = btf_check_subprog_call(env, subprog, caller->regs);
>  	if (err == -EFAULT)
>  		return err;
> +	if (subprog_ret_pair_unreliable(env, subprog)) {
> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable BTF\n",
> +			subprog, subprog_name(env, subprog));
> +		return -EINVAL;
> +	}

Does this break git bisect? At this commit the new check makes every
static (local) subprogram that returns a 9..16 byte struct or union
unloadable, which the parent commit d280e9c973c59 accepted.

The two conditions in subprog_ret_pair_unreliable() are guaranteed to be
true together for such a subprogram at this point in the series:

1. bpf_compute_subprog_ret_regs() at verifier.c:429 sets ret_reg_pair
   from the BTF return type for structs as well as scalars:

     if (type && (btf_type_is_struct(type) || btf_type_is_scalar(type)))
             subprog_info(env, subprog)->ret_reg_pair = ret_regs_cnt(type->size) > 1;

   so a 16-byte struct return gets ret_reg_pair = 1.

2. btf_validate_return_type() in kernel/bpf/btf.c still ends with 'return
   -EOPNOTSUPP;' for anything that is not void/int/enum (or an arena
   pointer), i.e. for every struct/union return. That -EOPNOTSUPP
   propagates through btf_prepare_func_args() and btf_check_func_arg_match()
   to btf_check_subprog_call(), which sets
   prog->aux->func_info_aux[subprog].unreliable = true precisely because it
   deliberately swallows any error other than -EFAULT for static
   subprograms.

So btf_check_subprog_call() marks the subprogram unreliable, returns
-EOPNOTSUPP (not -EFAULT, so the early return above does not fire), and
the new check then rejects the call with 'Func#N (...) returns >8 bytes,
which requires reliable BTF'. Before this patch the swallowed error was
harmless: the verifier walked into the static callee and prepare_func_exit()
copied the real R0 and R2 state back to the caller.

The series' own selftest proves the intended behaviour. The file
tools/testing/selftests/bpf/progs/aggregate_ret_func.c (added later in the
series by f40812d018cc3) has:

  static __naked __noinline struct ptr_pair static_ret_ptr_pair(void)  /* 16 bytes */
  ...
  SEC("tc") __success __retval(0)
  __naked int aggregate_ret_static_ptr_pair(void)

tagged __success, with the comment 'A static subprogram is verified inline,
so prepare_func_exit() hands the caller the callee's actual R0:R2 register
state ... which is why btf_validate_return_type() does not apply the
scalar-only restriction to a local function.' Built at this commit that
program would be rejected.

The later commit b12c58bbc5e59 'bpf: Enable aggregate return types up to
16 bytes' relaxes btf_validate_return_type() to accept a struct of size
<= 16 for a local function, and its own comment states the reason: 'What it
avoids is needlessly marking the subprogram's BTF unreliable.' Only
__int128 returns are unaffected (int passes btf_validate_return_type()).

Consider reordering so the return-type relaxation lands before this
rejection, or noting the dependency in this commit's changelog?

> @@ -9832,6 +9852,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>
>  	callee = state->frame[state->curframe];
>  	r0 = &callee->regs[BPF_REG_0];
> +	if (subprog_ret_pair_unreliable(env, callee->subprogno)) {
> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable BTF\n",
> +			callee->subprogno, subprog_name(env, callee->subprogno));
> +		return -EINVAL;
> +	}

Can this check ever fire? The changelog claims it is needed 'for the
return from an inlined static subprogram', but the check appears to be
unreachable.

unreliable is monotonic (only ever set to true) and has exactly two
writers:

  - btf_check_subprog_call() at verifier.c:9357, called from
    check_func_call() and push_callback_call()
  - do_check_common() at verifier.c:18591, which sets
    func_info_aux[0].unreliable for subprog 0 only

For a frame to reach prepare_func_exit() it must have been pushed by
setup_func_entry() via one of these paths:

  - check_func_call(): the new hunk above runs immediately after
    btf_check_subprog_call() and before setup_func_entry(), so a subprog
    that just became unreliable is rejected there and never gets a frame.
    Since the flag cannot be set later for that subprog without going through
    check_func_call() again (which would reject again), the exit check can
    never see it true.

  - push_callback_call(): check_ld_imm() is the only producer of
    PTR_TO_FUNC and already rejects bpf_ret_reg_pair() callbacks ('callback
    function with >8-byte return value is not supported'), so a callback
    frame never has ret_reg_pair set.

  - subprog 0 is frame 0 and is never a callee frame; check_cfg() rejects
    a call back into subprog 0.

The two other callers of prepare_func_exit() are equally excluded: the
tail-call path at verifier.c:10797 and the LD_ABS path at verifier.c:16533
can only run in a subprog whose BTF return type is a small int, because
check_btf_func() in kernel/bpf/check_btf.c rejects BPF_LD_ABS and tail
calls in any subprog that fails btf_type_is_small_int() (int of size <= 8),
which excludes every ret_reg_pair subprog.

If the check is intended as defence in depth for a future caller of
btf_check_subprog_call(), saying so in the changelog would help; otherwise
the hunk can be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============5447536458762560471==--
