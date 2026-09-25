Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C3369D5C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329954; cv=none; b=nZWpqODcrz23jpzatcfzvOxksV1a3XAkwPcWidtHZSakiNtLozUw9QpqhBL+z7yZOewhPtwOk8qa4fr/ZUdgc/6j+iKqtx0EIIKMwPkfRpC6Mp0ahKtKQS0nLJyHfNjP7xKycUOaSErF8pHOrFLfPGCeqB0wvmsoAGd+Fnerw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329954; c=relaxed/simple;
	bh=Wx+EFhrbfEdzhAO4bmuD5jGqGTLXWvB1P2vy1Ax2NGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fZJcUUONZtWMa9UOZ/SvEw/mRMUauWhPagpx84TPSxMR6X3o+RxbBtc1FfgAp8wZVvFVUSB5Rk/9n3+D9DiwAZbXNONnCxRL+yX2PcJ2LYd3JdTYBFhldKiABnY+gOaaw+VcCt5fHZY2R6Xx7bQy14e8Ds2zsMosf6/a9s8+/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EEH0P1Nc; arc=none smtp.client-ip=95.215.58.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EEH0P1Nc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Wx+EFhrbfEdzhAO4bmuD5jGqGTLXWvB1P2vy1Ax2NGc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790329948; v=1; x=1790934748;
 b=EEH0P1Ncda/Ju3q9g22yDWpZVwGz+7zV3TtEtH3escEZUcAwSDXvloYVwquBoiww3cKMBWpG
 TVDN3V/RlGDTsyvyHJhPCzW0Ci0HbCJd384lwZPFsD4qWXJDXRXVeVW5f/mBDXj57dw24DWXCaf
 Gsh0BCD3QlvwAx1vFz+GJ8kE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02f1bf7b80ddc990;
	Fri, 25 Sep 2026 09:52:27 +0000
X-Mizu-Trace-ID: 02f1bf7b80ddc990
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 09:52:23 +0000
Message-Id: <DLOAZXLJA4AS.1AJ6HN97DR26B@linux.dev>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
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
Subject: Re: [PATCH bpf v3 2/3] bpf: Skip the progs of trampoline images
 that are being freed
From: "Florent Revest" <florent.revest@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260924170543.1017048-3-florent.revest@linux.dev>
 <1af4e60e20bc3fa1547c0ad4a8d72b904535ec2a4c40d620d59142bb630742f3@mail.kernel.org>
In-Reply-To: <1af4e60e20bc3fa1547c0ad4a8d72b904535ec2a4c40d620d59142bb630742f3@mail.kernel.org>

On Thu Sep 24, 2026 at 6:07 PM UTC,  wrote:
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2853e87797a7..7ef5c8efc882 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3217,16 +3217,21 @@ static void restore_regs(const struct btf_func_=
model *m, u8 **prog,
> >  }
> >
> >  static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> > +			   struct bpf_tramp_image *im,
> >  			   struct bpf_tramp_node *node, int stack_size,
> >  			   int run_ctx_off, bool save_ret,
> >  			   void *image, void *rw_image)
> >  {
> >  	u8 *prog =3D *pprog;
> > -	u8 *jmp_insn;
> > +	u8 *jmp_insn, *skip;
> >  	int ctx_cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie)=
;
> >  	struct bpf_prog *p =3D node->link->prog;
> >  	u64 cookie =3D node->cookie;
> >
> > +	/* nop, patched to skip this prog when the image is put */
> > +	skip =3D image + (prog - (u8 *)rw_image);
> > +	emit_nops(&prog, X86_PATCH_SIZE);
> > +
>
> The patch adds a 5-byte nop in front of every prog call sequence on x86
> but keeps BPF_MAX_TRAMP_LINKS at 38. This adds 38 * 5 - 5 =3D 185 bytes t=
o
> the worst case image size, which was already close to PAGE_SIZE.
>
> Example worst case: 19 fsession progs (38 link slots because each counts
> twice) attached to a function with 7-9 argument registers, each calling
> bpf_session_cookie() and bpf_get_func_ip() with a 64-bit link cookie.
>
> With 7 args the image reaches about 4040-4043 bytes, above
> PAGE_SIZE - BPF_INSN_SAFETY =3D 4032. With 10 args it reaches about
> 4106-4109 bytes. An attach that used to succeed now fails with -EFAULT
> and a WARN_ON_ONCE() splat.
>
> The size pass writes to a single PAGE_SIZE execmem buffer with only an
> end-of-pass WARN_ON_ONCE check:
>
> arch/x86/net/bpf_jit_comp.c:arch_bpf_trampoline_size() {
>     image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
>     ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, =
...);
>
> arch/x86/net/bpf_jit_comp.c:__arch_prepare_bpf_trampoline() {
>     if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
>         ret =3D -EFAULT;
>         goto cleanup;
>     }
>
> With 10 args the size pass writes past the end of the execmem buffer
> before the check is reached.
>
> The commit message says the extra nops break the page budget only on
> arm64 and loongarch. Should x86 get a lower BPF_MAX_TRAMP_LINKS too, or
> should the x86 size pass bound-check as it emits?

Yep, v4 will lower it to 36.

> [ ... ]
>
> > @@ -3368,7 +3377,7 @@ static int invoke_bpf_mod_ret(const struct btf_fu=
nc_model *m, u8 **pprog,
> >  	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
> >  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
> >  	for (i =3D 0; i < tl->nr_nodes; i++) {
> > -		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size, run_ctx_off,=
 true,
> > +		if (invoke_bpf_prog(m, &prog, im, tl->nodes[i], stack_size, run_ctx_=
off, true,
> >  				    image, rw_image))
> >  			return -EINVAL;
> >
> >  		/* mod_ret prog stored return value into [rbp - 8]. Emit:
> >  		 * if (*(u64 *)(rbp - 8) !=3D  0)
> >  		 *	goto do_fexit;
> >  		 */
>
> invoke_bpf_mod_ret() now passes im to invoke_bpf_prog(), so every
> fmod_ret prog gets a skip nop that bpf_tramp_image_put() patches to a
> jump. The skip target is before the cmp/jne check. A skipped fmod_ret
> prog therefore leaves the previous return value in place (0 from the
> initial mov after xor eax,eax), and the original function is called.
>
> Before this change only fexit progs were skipped in a put image, and
> those only observe. fmod_ret progs always ran. Any trampoline update puts
> the old image, including attaching or detaching an unrelated prog.
>
> BPF LSM progs on int hooks become BPF_TRAMP_MODIFY_RETURN:
>
> kernel/bpf/verifier.c:bpf_attach_type_to_tramp() {
>     case BPF_LSM_MAC:
>         if (!prog->aux->attach_func_proto->type)
>             return BPF_TRAMP_FEXIT;
>         else
>             return BPF_TRAMP_MODIFY_RETURN;
>
> Hooks such as bpf_lsm_file_open and bpf_lsm_bprm_check_security are in
> sleepable_lsm_hooks. A possible sequence:
>
>   task T in image I of bpf_lsm_file_open,
>     sleeping in sleepable LSM prog S (returns 0)
>                                      attach another prog to the hook
>                                       -> new image, bpf_tramp_image_put(I=
)
>                                       -> nop before enforcing prog P patc=
hed to jmp
>   T returns from S
>   jmp over P (P is still attached)
>   cmp [rbp-8], 0 -> equal, call bpf_lsm_file_open() -> 0
>   open allowed although P would have denied it
>
> On a preemptible kernel the window exists even without sleepable progs:
> anywhere between trampoline entry and P's nop.
>
> The commit message says still-attached progs are skipped "like they
> already skipped its fexit progs". For fmod_ret, though, skipping changes
> the traced function's return value instead of just losing an event.
>
> Is it intended that a concurrent attach or detach on the same hook can
> bypass an attached LSM or fmod_ret prog?

As discussed with Alexei, v4 goes back to only skipping the prog that is
detached.

> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d4f732996b47..9c61803380c2 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1258,11 +1258,15 @@ struct btf_func_model {
> >  #define BPF_TRAMP_F_INDIRECT		BIT(8)
> >
> >  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit i=
s ~50
> > - * bytes on x86.
> > + * bytes on x86. The trampoline image has to fit in PAGE_SIZE.
> >   */
> >  enum {
> > -#if defined(__s390x__)
> > +#if defined(__s390x__) || defined(__powerpc64__)
> >  	BPF_MAX_TRAMP_LINKS =3D 27,
> > +#elif defined(__loongarch__)
> > +	BPF_MAX_TRAMP_LINKS =3D 33,
> > +#elif defined(__aarch64__)
> > +	BPF_MAX_TRAMP_LINKS =3D 37,
> >  #else
> >  	BPF_MAX_TRAMP_LINKS =3D 38,
> >  #endif
>
> BPF_MAX_TRAMP_LINKS drops from 38 to 27 for every __powerpc64__ build
> (and to 37 for every __aarch64__ build), whatever the page size. The
> updated comment says the constraint is that the image has to fit in
> PAGE_SIZE, and bpf_trampoline_update() does check the size against
> PAGE_SIZE.
>
> PPC_64K_PAGES is the default for PPC_BOOK3S_64, and 38 progs fit easily
> in a 64K image. On common ppc64le configurations (and arm64 with 16K/64K
> pages), attaching the 28th to 38th prog to one function now fails with
> -E2BIG where it used to work.
>
> The commit message's "already didn't on powerpc" only holds for 4K pages.
>
> Could the limit depend on PAGE_SIZE instead, keeping 38 when the page is
> larger than 4K?

Alexei prefers to leave that for later, so v4 doesn't change it.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 9d69c066a817..0d7aa1b0fe30 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
>
> [ ... ]
>
> > @@ -611,6 +612,8 @@ static void __bpf_tramp_image_put_rcu_tasks(struct =
rcu_head *rcu)
> >
> >  static void bpf_tramp_image_put(struct bpf_tramp_image *im)
> >  {
> > +	int i, err;
> > +
> >  	/* The trampoline image that calls original function is using:
> >  	 * rcu_read_lock_trace to protect sleepable bpf progs
> >  	 * rcu_read_lock to protect normal bpf progs
> > @@ -621,10 +624,17 @@ static void bpf_tramp_image_put(struct bpf_tramp_=
image *im)
> >  	 *
> >  	 * The trampoline is unreachable before bpf_tramp_image_put().
> >  	 *
> > -	 * First, patch the trampoline to avoid calling into fexit progs.
> > -	 * The progs will be freed even if the original function is still
> > -	 * executing or sleeping.
> > -	 * In case of CONFIG_PREEMPT=3Dy use call_rcu_tasks() to wait on
> > +	 * First, patch the trampoline to avoid calling into progs. The progs
> > +	 * will be freed even if a task is still in the trampoline, e.g.
> > +	 * sleeping in the original function or in a sleepable prog.
> > +	 */
> > +	for (i =3D 0; i < im->nr_skips; i++) {
> > +		err =3D bpf_arch_text_poke(im->skips[i].nop, BPF_MOD_NOP,
> > +					 BPF_MOD_JUMP, NULL, im->skips[i].target);
> > +		WARN_ON_ONCE(err);
> > +	}
>
> Now that every prog nop in the old image is patched, a task still in that
> image also skips the fmod_ret progs that are still attached, not only
> fentry/fexit progs.
>
> Before this change only ip_after_call was patched. It sits after the
> original function call, so fentry and fmod_ret progs always ran and only
> fexit progs could be skipped.
>
> The commit message justifies skipping attached progs "like they already
> skipped its fexit progs". That comparison holds for observe-only
> fentry/fexit progs, but fmod_ret progs decide the return value and
> whether the original function runs.
>
> BPF LSM progs on int-returning hooks are attached as
> BPF_TRAMP_MODIFY_RETURN. Scenario:
>
> 1. Task T enters image I_old for bpf_lsm_file_open. It is either
>    preempted or sleeping in an earlier sleepable lsm.s prog, e.g. blocked
>    in bpf_copy_from_user(). Either way it has not yet reached the nop of
>    enforcing LSM prog L.
>
> 2. Someone attaches or detaches any other prog on the same trampoline.
>    bpf_trampoline_update() -> modify_fentry() -> bpf_tramp_image_put(I_ol=
d)
>    turns all nops of I_old into jumps, including L's.
>
> 3. T resumes and jumps over L's call sequence. In x86 invoke_bpf_mod_ret(=
)
>    the result slot [rbp-8] was zeroed and nothing stores to it, so the
>    following cmp/jne does not branch to do_fexit. The original
>    bpf_lsm_file_open() stub is called and returns 0.
>
> The hook fails open for T even though L is still attached and would have
> denied access. The sequential pokes can also leave T running some
> fmod_ret progs but not others. The sleepable case makes the window as
> long as the earlier prog blocks.
>
> Should fmod_ret progs that are still attached keep running, with only the
> progs being removed skipped? Otherwise, is this fail-open behaviour for
> BPF LSM and fmod_ret acceptable, and should the commit message and commen=
t
> say so?
>
> > +
> > +	/* In case of CONFIG_PREEMPT=3Dy use call_rcu_tasks() to wait on
> >  	 * first few asm instructions to execute and call into
> >  	 * __bpf_tramp_enter->percpu_ref_get.
> >  	 * Then use percpu_ref_kill to wait for the trampoline and the origin=
al
>
> This isn't a bug, but the multi-line comment has the opening slash-star o=
n
> the same line as the comment text. BPF subsystem style in kernel/bpf/ has
> the opening slash-star on its own line for new multi-line comments:
>
> 	/*
> 	 * In case of CONFIG_PREEMPT=3Dy use call_rcu_tasks() to wait on
> 	 * first few asm instructions to execute and call into

Fixed in v4.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/360342=
51810

