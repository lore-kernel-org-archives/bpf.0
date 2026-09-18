Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5561FFC59
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710270; cv=none; b=YkTpTPIR8P2GCyYELxdIEY8YEBxohqEIl0KT+UwuxeRZMT9t6szs35oxEvJ62sEHX/bcDfZZ964NF8guUe5CXBFsq0pFUHSvdduO1JCTRz1IA1JXX2bCTH4yTZhvuPSVX7zWV4AGQMWS2ACHJzWMhBHufgvB1AEPtxZOrQYZS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710270; c=relaxed/simple;
	bh=l2VWhP5EljH96sz3KkXbETviXewJRhmjDUP2xG6yU4c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QkNLWzenVHg+R37c7LjMCVL8H6JXVd4r68SBPkPyIj2nw7k0VNhIjYcqCCnjelH1ayt777ofE6Z/cP6ZqFx/Dng/ggwYg/jHpGyY2tK8KaMhkxhbfKN2bpn/4/5o2j/74qaQkJmRAnmdjMz2hLUvT8N6Ufjb7VXrKV0SLpkZfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXwiTmln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXwiTmln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E768B1F000FF;
	Fri, 18 Sep 2026 05:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710268;
	bh=MOhj7zS7dy4krCGlOa+rShDBN3ZGe3sEDSska5oA6ds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OXwiTmlnS+DiJoYixjOfvWhQyRINZJwxKEa4IF1RrHze+yugIzbD6cutWRDpnwXVQ
	 gtkuGYukRiqdTrUAHQUka3nwEpBJKC8Gil40gW4eIydqeVjQlzbYpIMLi++tjjetDo
	 pokS0cDBN5OV/KaRFOkM0AgO+oDug+hybtSZaEZ9x4TeQX5elJcp1pfgml8GKOXGP8
	 loC85XeMrSej5MIq3ZbT/8svkHvS+YjUB3hCihQsA7ymQnRj86N0Z2ycBZl3wF4mud
	 c/0ZApZ/nNfUVsecIbUDyOb1q509HN/nA9jR0PTUwdxaVFA8Is1rrCVOAZ+YPSDznm
	 yWdfa4RlfPx5w==
Content-Type: multipart/mixed; boundary="===============5413451299901404159=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6f9de46294b24824fb67c5246d73bc720391d52e5dd4cf36af398a215fbb414@mail.kernel.org>
In-Reply-To: <20260918044221.3287431-1-yonghong.song@linux.dev>
References: <20260918044221.3287431-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 05/20] bpf: Make exception landing pads reachable in the CFG
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:27 +0000 (UTC)

--===============5413451299901404159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 44ecdc5b4ec2d..9cfd05f970bc9 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -8,6 +8,8 @@
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>
> +#include "exception.h"
> +
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>
>  struct per_frame_masks {
> @@ -256,6 +258,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>  	succ = env->succ;
>  	succ->cnt = 0;
>
> +	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
> +		return succ;
> +

Should this early return be gated on env->cleanup_info_cnt?

bpf_unwind_resume() is an unconditionally registered generic kfunc with no
KF_ flag restricting it to programs that carry a cleanup table. Its body
is empty, so at run time the call simply returns and execution continues
at the next instruction.

visit_insn() in cfg.c still gives the call a fallthrough edge, and at this
commit nothing in do_check() rejects a bpf_unwind_resume() call that is not
the tail of a cleanup landing pad. So any CAP_BPF program with no cleanup
table can call bpf_unwind_resume() and keep executing after it.

For such a program, bpf_insn_successors() reports zero successors, so
bpf_compute_live_registers() treats everything after the call as dead. The
register-cleaning side fails closed (a poisoned slot is rejected), but the
32-bit zero-extension side fails open:

insn_aux[i].zext_dst for an insn preceding the call is only set when the
hi half of the defined register is live-after, so it stays false, and
bpf_opt_subreg_zext_lo32_rnd_hi32() (kernel/bpf/fixups.c:706) then does
'if (!aux[adj_idx].zext_dst) { if (!rnd_hi32) continue; ... }' and emits
no BPF_ZEXT_REG.

On architectures where bpf_jit_needs_zext() is true and kfunc calls are
supported (s390, riscv64, powerpc64, parisc, x86-32), the upper 32 bits of
a register the verifier proved to be 32-bit bounded are left with stale
JIT-defined contents, which defeats the range checks the verifier derived
for it.

Compare with the pad lookup ten lines below:

>  	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
>  	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
>  	if (opcode_info->can_fallthrough)
> @@ -264,6 +269,13 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>  	if (opcode_info->can_jump)
>  		succ->items[succ->cnt++] = idx + bpf_jmp_offset(insn) + 1;
>
> +	if (unlikely(env->cleanup_info_cnt)) {
> +		int pad = bpf_cleanup_pad_of_call(env, idx);
> +
> +		if (pad >= 0)
> +			succ->items[succ->cnt++] = pad;
> +	}

which gates the pad lookup on cleanup_info_cnt, and with
visit_cleanup_pad_edge() in kernel/bpf/cfg.c which returns DONE_EXPLORING
when !env->cleanup_info_cnt.

Would gating the early return on env->cleanup_info_cnt fix this?  That
would be sound because a program that carries a cleanup table is
additionally constrained (bpf_jit_supports_cleanup_pads() plus, from commit
fa6890df61539 onward, the requirement that a resume sit at the end of a
landing pad), whereas a program with cleanup_info_cnt == 0 must keep the
ordinary fallthrough successor of the call.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============5413451299901404159==--
