Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293037BE6C
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541769; cv=none; b=kbzPt4Gup1fR3rchcbV1KcWRvdN9B6I1yJG9papP8xDuuq8z/jE3ff9Jr5i0WlgmodfgysbTOWpplzbHWJvP5VCmlhQhB92gzWNJEMlJCnebIbE5X+Jeef906vfGJXt2eveMBoqFVg3z6zqMvnxh1kxGYMeyP9HWL7ZzDnhIsew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541769; c=relaxed/simple;
	bh=Ao7o5pFY/C+UqVBLvTLO4NaSX0hW2lAt1qZGXosTSFo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gVUaMjJXQiQVg9GuAA9tawEj1HU3unkKrIVerXWq/vCKZHbXkgTYiEsKnBy0iQZmVliqzbkv27sKslDPm3wF28+uI3vbzlI1re64j5sKUenrCrRgNeNNbbaW9p0KmJ+dCYui+xbmGt0Ehu3Ig7rSRopsQwB3+tJAS/lcGoH6cuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua6aSkmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua6aSkmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DFF1F00893;
	Sun, 27 Sep 2026 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541767;
	bh=Ogzlx6t8Fs/KKYiqq1wR1Es5oyvP8uo+Uy4Mh7u6Rm0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ua6aSkmxoxstbbOmslblIwFcu8nR6RDiO+oyrUVRz1fgPAxplNp9Fjj8dzZHarRXU
	 c4573OobOLK0y2S9wuP/jiguJnkJk8zGy6z208+TAM2Ws9n/Esm+dAfyKnpaicNebZ
	 mBRbZ2Pt0xnUMKPO4JCMJyZA3U46pAI44pNgYBAJQAkxdENlHn7RNJ09oNGyyzVTLd
	 GuvHdaA8WNN9RnR2RSxeDSFVWWhTH55yIZO3y4u0Ix1K2wx31Nge9ZNB15EEnhpWTm
	 bOb+zBST+z/NlC8wFbDnFlCEEXShNq0RnNS7rRewVgFC0wHZ2Tptw5OGAUu7JDS+fM
	 qlx5m0cx0wq+g==
Content-Type: multipart/mixed; boundary="===============4133675119298884715=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <92725cabd34b462486052bddd62757252de036696d01a7b0b96a6dacc01a8a09@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-11-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-11-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 11/36] bpf: add bpf_reg_union()
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:46 +0000 (UTC)

--===============4133675119298884715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 719b7c7fd2f5..706fdefbc07a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1748,6 +1748,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
>  int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
>  int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		      struct cnum64 range, u16 step);
> +int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
> +		  const struct bpf_reg_state *src);
>
>  int bpf_stack_liveness_init(struct bpf_verifier_env *env);
>  void bpf_stack_liveness_free(struct bpf_verifier_env *env);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b5f45cb46f14..1ec44d72a346 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/cnum.h>
> +#include <linux/gcd.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <net/xdp.h>
>  #include <linux/trace_events.h>

[ ... ]

> @@ -16952,6 +16953,33 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
>  }
>
> +/* acc := acc U src, matching types only. Caller must clear acc's scalar ID. */
> +int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
> +		  const struct bpf_reg_state *src)
> +{
> +	u16 base, step;
> +
> +	if (acc->type != src->type) {
> +		verifier_bug(env, "union of registers with different types");
> +		return -EFAULT;
> +	}
> +	acc->r64 = cnum64_union(acc->r64, src->r64);
> +	acc->r32 = cnum32_union(acc->r32, src->r32);
> +	acc->var_off = tnum_union(acc->var_off, src->var_off);

Does this function handle pointer registers correctly? When bpf_reg_union()
widens a PTR_TO_PACKET's offset (r64/r32/var_off) but keeps its id, it can
break the id-tracking invariant.

For PTR_TO_PACKET, registers with the same id differ only by a known
constant. When adjust_ptr_min_max_vals() adds a non-constant to a packet
pointer, it gives it a fresh id:

  if (!known)
      dst_reg->id = ++env->id_gen;

find_good_pkt_pointers() depends on this rule. After a successful
'pkt_ptr > pkt_end' test, it uses reg_umax(dst_reg) as the new range
and sets reg->range = max(reg->range, new_range) on every PTR_TO_PACKET
with the same id, assuming they all track the same maximum offset.

Once bpf_reg_union() enlarges acc's umax but leaves acc in the same id
group as registers that were not widened, a comparison on acc can give
those other registers a range based on the widened umax that nothing at
runtime backs.

The comment says "Caller must clear acc's scalar ID", but for pointer
types the id has a different meaning. Later in the series when this is
called from union_any_reg() (1987b0e52b34), is_widenable_reg_type()
accepts PTR_TO_PACKET, and scratch_scalar_id() only clears the id when
reg->type == SCALAR_VALUE.

Here's a concrete example with a similar shape to the
conditional_stack_pointer_assignment selftest at the series end:

  r2 = *(u32 *)(r1 + 0)   // data: pkt, id=0
  r3 = *(u32 *)(r1 + 4)   // data_end
  r9 = r2                 // pkt, id=0, off 0
  r7 = r2
  r7 += 1000              // pkt, id=0 (constant add keeps id)
  r6 = 0
1: if r6 >= 3 goto 3f
  if r2 > r3 goto 3f      // fallthrough: find_good_pkt_pointers(r2)
  r0 = *(u8 *)(r9 + 999)
  if r6 != 1 goto 2f
  r2 = r7                 // r2 = (any r2 r7) at loop entry
2: r6 += 1
  goto 1b
3: r0 = 0
  exit

At loop entry, bpf_reg_union() turns r2 into pkt(id=0, [0,1000]), but r9
keeps id=0 and [0,0]. On the fallthrough of 'if r2 > r3',
find_good_pkt_pointers() sets r9->range = reg_umax(r2) = 1000. The load
from r9 + 999 then passes (0 + 999 + 1 <= 1000).

At runtime, on the first iteration r2 == data, so 'data > data_end'
is always false. The program then reads data[999] for any packet,
including one shorter than 1000 bytes: an out-of-bounds packet read.

Should widened PTR_TO_PACKET registers either get a fresh id (and zero
range), or should widening refuse packet pointers that share their id
with other live registers?

> +
> +	/* Retain a common congruence if the bases agree modulo the gcd. */
> +	step = gcd(acc->step, src->step);
> +	base = acc->base % step;
> +	if (base != src->base % step) {
> +		reg_step_reset(acc);
> +	} else {
> +		acc->base = base;
> +		acc->step = step;
> +	}
                ^^^^^^^^^^
                ^^^^^^^^^^

Does this commit build on its own? At ef75b765c289, struct bpf_reg_state
(include/linux/bpf_verifier.h:53) has no 'base' or 'step' members. The
struct ends with id, parent_id, map_uid, precise. Also reg_step_reset()
is not defined anywhere ('git grep reg_step_reset ef75b765c289' only
finds this call site).

So the references to acc->step, src->step, acc->base, src->base and the
reg_step_reset(acc) call all fail to build kernel/bpf/verifier.c when
CONFIG_BPF_SYSCALL=y, which breaks bisection.

The missing pieces are added later in the series by a89774dffa02
("bpf: representation for intervals with steps"), which adds 'u16 base;
u16 step;' to struct bpf_reg_state and defines reg_step_reset(). So the
tree builds again from that commit on, but ef75b765c289 and the commits
between it and a89774dffa02 (d18308307ed6, 0516ad0f46c2) do not build.
The earlier baecd299ec89 ("bpf: add bpf_set_reg_range()") has the same
dependency on reg->step/reg->base.

Would moving a89774dffa02 before these helper commits fix this?

Also, the commit message mentions merging "the circular 32-bit and 64-bit
bounds and tnums" but doesn't mention the base/step congruence merge that
the code does here.

> +	reg_bounds_sync(acc);
> +	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
> +}
> +
>  /* check validity of 32-bit and 64-bit arithmetic operations */
>  static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============4133675119298884715==--
