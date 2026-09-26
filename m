Received: from mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3D469832
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430873; cv=none; b=faAhfyMye2zF7HREcjGvyfAz0MGirfzOP5ux3BBT6wiX4uqjZ02BHJ8X6lHCGoAVlv+qU3olKtzIZsNI9ElZ9vUJtMg8P+e/uL1LGExlF3qMVlwxopMffJ/NPiBBfp8oQYf2waTinZsSwJIxegLznPpUSYphi+SC9pqTxcDTKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430873; c=relaxed/simple;
	bh=1lN0OelA+/aN4bSam/ZaZ/wlRZP7pBsZTyTh88y4t9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hO66nbpuEYUB2KeM8qyba64WDC/M/gwM8nwmI6nDzBjLRXD5n6YFkCgrQoWJbLn45TKZMYktMDkT5tvccYWUeO8L6PqIcdjdcCVrlgHFtTPaEFKyBVraOFE+p6q3OCDWhj3OToWBNA1VwQZSsY23O1HAkuTjUxok8zf0I0zhLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xnYIU++K; arc=none smtp.client-ip=95.215.58.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xnYIU++K"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1lN0OelA+/aN4bSam/ZaZ/wlRZP7pBsZTyTh88y4t9E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790430863; v=1; x=1791035663;
 b=xnYIU++KzXVGpA87/QScOPwD6KyvpL3WIj/lYcTfe72MIc+jEOx9qoFKRoDkbSLKXbtAeb//
 K5gA6rgw+uSZJvzXH4LcVWcxiwfQH2dDcmOKLR3F6B9+qt0r5PE7XEPsKZb/76/XrYXlF6zkMwu
 LUzHSMpWnOEcITVgWCT37xKw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 34b97dbd581e7522;
	Sat, 26 Sep 2026 13:54:23 +0000
X-Mizu-Trace-ID: 34b97dbd581e7522
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 13:54:18 +0000
Message-Id: <DLPARPC8FFLT.2FS01986F8JES@linux.dev>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kpsingh@kernel.org>, <john.fastabend@gmail.com>, <leon.hwang@linux.dev>,
 <zirajs7@gmail.com>, <rhkrqnwk98@gmail.com>, <puranjay@kernel.org>,
 <xukuohai@huaweicloud.com>, <iii@linux.ibm.com>, <hbathini@linux.ibm.com>,
 <chleroy@kernel.org>, <naveen@kernel.org>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <yangtiezhu@loongson.cn>, <hengqi.chen@gmail.com>,
 <linux-kernel@vger.kernel.org>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <mason@kernel.org>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v4 2/3] bpf: Skip detached progs in trampoline
 images that are still in use
From: "Florent Revest" <florent.revest@linux.dev>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
X-Mailer: aerc 0.17.0
References: <20260925100342.481242-3-florent.revest@linux.dev>
 <6a6d43e6bada7a1433cd525c9ec31780ed9b2401c8834894defdf671601b2f1d@mail.kernel.org>
In-Reply-To: <6a6d43e6bada7a1433cd525c9ec31780ed9b2401c8834894defdf671601b2f1d@mail.kernel.org>

On Fri Sep 25, 2026 at 10:47 AM UTC,  wrote:
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index c5f55d6161fe..bd73179c00ec 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
>
> [ ... ]
>
> > @@ -2431,6 +2432,10 @@ static void invoke_bpf_prog(struct jit_ctx *ctx,=
 struct bpf_tramp_node *node,
> >  	enter_prog =3D (u64)bpf_trampoline_enter(p);
> >  	exit_prog =3D (u64)bpf_trampoline_exit(p);
> >
> > +	/* nop, patched to skip this prog when it is detached */
> > +	skip =3D ctx->ro_image + ctx->idx;
> > +	emit(A64_NOP, ctx);
> > +
>
> Is a context synchronization event needed on the other CPUs after the ski=
p
> NOP is patched?

I don't think so. A CPU that still executes the old nop calls the prog befo=
re
it went through a quiescent state, and the prog is only freed after RCU tas=
ks
and RCU grace periods (patch 1), so it is still there. That's the same
reasoning as for the image in the existing comment, v5 adds this case to it=
.

> A subsystem pattern flags this as potentially concerning: the new per-pro=
g
> NOP becomes a B when the prog is detached. bpf_trampoline_skip_prog() ->
> bpf_arch_text_poke() -> aarch64_insn_patch_text_nosync() does:
>
>     ret =3D aarch64_insn_write(tp, insn);
>     if (ret =3D=3D 0)
>         caches_clean_inval_pou((uintptr_t)tp,
>                                (uintptr_t)tp + AARCH64_INSN_SIZE);
>
> Nothing forces an isb or exception on the other CPUs. Jump label patching
> of the same NOP<->B kind does this through
> arch_jump_label_transform_apply() -> kick_all_cpus_sync().
>
> The new site is a correctness point: after the detach, the trampoline
> relies on this jump so that a task still in the image does not call into
> the prog, which is freed after the grace periods. A CPU that has not take=
n
> a CSE may still execute the old NOP and call the prog.
>
> The existing comment in bpf_arch_text_poke() justifies the missing sync
> only for trampoline images, by pointing at bpf_tramp_image_put(). It does
> not cover the progs called from a live image.
>
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 4da278900938..df8abfa055d1 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
>
> [ ... ]
>
> > @@ -1696,13 +1696,19 @@ static void restore_stk_args(struct jit_ctx *ct=
x, int nr_stk_args, int args_off,
> >  	}
> >  }
> >
> > -static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node =
*n,
> > -			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
> > +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image=
 *im,
> > +			   struct bpf_tramp_node *n, int args_off, int retval_off,
> > +			   int run_ctx_off, bool save_ret)
> >  {
> > -	int ret;
> > +	int i, ret;
> >  	u32 *branch;
> >  	struct bpf_prog *p =3D n->link->prog;
> >  	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> > +	void *skip =3D ctx->ro_image + ctx->idx;
> > +
> > +	/* nops for move_imm+jirl, patched to skip this prog when it is detac=
hed */
> > +	for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > +		emit_insn(ctx, nop);
>
> Can a task preempted inside the skip sled resume into half of the new jum=
p
> sequence and jump to a garbage address?
>
> The skip site is a 5-instruction nop sled. bpf_trampoline_skip_prog() tur=
ns
> it into a multi-instruction sequence with bpf_arch_text_poke(skip->nop,
> BPF_MOD_NOP, BPF_MOD_JUMP, NULL, skip->target). That call goes through
> emit_jump_or_nops() -> move_imm(T1, target) + 'jirl zero, t1, 0' and
> writes the result with:
>
>     ret =3D larch_insn_text_copy(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTE=
S);
>
> This runs on detach, while the current image and any older images still o=
n
> tr->images are live. Every call of the traced function runs through the
> sled. larch_insn_text_copy() uses stop_machine_cpuslocked(), which only
> parks CPUs that are running. It cannot help a task that was preempted
> between two sled instructions.
>
> The trampoline does not disable preemption before __bpf_prog_enter*(). Wi=
th
> CONFIG_PREEMPT, PREEMPT_LAZY (ARCH_HAS_PREEMPT_LAZY is selected in
> arch/loongarch/Kconfig) or PREEMPT_RT, waking the stopper thread preempts
> whatever is running on each CPU at IPI return. That includes a task that
> has executed only some of the nops.
>
> Concrete path:
>
>   CPU0 (task A): traced func -> trampoline -> sled nop0, nop1
>                  | IPI, preempted
>   CPU1: bpf_link release -> bpf_trampoline_remove_prog()
>         -> bpf_trampoline_skip_prog() -> bpf_arch_text_poke()
>         -> larch_insn_text_copy() writes
>            lu12i.w t1 / ori t1 / lu32i.d t1 / jirl zero,t1,0 / nop
>   CPU0: A resumes at sled+8 and executes 'lu32i.d t1; jirl zero, t1, 0'
>
> Bits 31:0 of t1 still hold whatever the register contained before, for
> example a value left behind by the previous prog's __bpf_prog_exit call.
> The indirect jump goes to an arbitrary kernel address, causing an oops or
> running unintended code.
>
> Before this change, only the prog-entry sled and ip_after_call had this
> 5-instruction live poke. fentry-only trampolines had no patched site insi=
de
> the image at all. Now every detach patches one sled per image on the
> hottest path. The x86, arm64 and s390 skip sites are patched with a singl=
e
> atomic instruction change, so they don't have this problem.
>
> Could the LoongArch skip site use a single instruction instead? For
> example, a 'b' to the skip target, which is always within the +/-128MB
> range of the same image, patched from nop to 'b'. The rest of the sled
> would then be unnecessary.
>
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 9d69c066a817..ea8e67a38919 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
>
> [ ... ]
>
> > @@ -1246,11 +1289,8 @@ void bpf_trampoline_put(struct bpf_trampoline *t=
r)
> >  		if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
> >  			goto out;
> >
> > -	/* This code will be executed even when the last bpf_tramp_image
> > -	 * is alive. All progs are detached from the trampoline and the
> > -	 * trampoline image is patched with jmp into epilogue to skip
> > -	 * fexit progs. The fentry-only trampoline will be freed via
> > -	 * multiple rcu callbacks.
> > +	/* All progs are detached and the last image has been freed, images
> > +	 * hold a reference on the trampoline until then.
> >  	 */
>
> This isn't a bug, but the rewritten comment puts its text on the same lin=
e
> as the opening /*:
>
> 	/* All progs are detached and the last image has been freed, images
> 	 * hold a reference on the trampoline until then.
> 	 */
>
> The BPF subsystem's comment style asks for the opening /* of a multi-line
> comment to be on its own line in kernel/bpf/, even where nearby code stil=
l
> uses the old style. The patch replaces this comment's text, so the line
> counts as modified. The other new multi-line comment in this file, above
> bpf_trampoline_skip_prog(), already uses the preferred style. The same
> comment in that style would be:
>
> 	/*
> 	 * All progs are detached and the last image has been freed, images
> 	 * hold a reference on the trampoline until then.
> 	 */

Fixed in v5.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/361228=
63248

