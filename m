Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72E3932F9;
	Thu, 24 Sep 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273258; cv=none; b=s8/DW3naq33DDpd4qJ+vFsbnnz6GjJldiVOUGoz/AanDRM/9iFsYTX+VMxyHy7IFmVkU2Hlo3JzINyqZ83nkZNJaMIkWIRvV0CP7e7Wv4jpbWIvCDMYYscHmdGaAssPWBSRNiVAVd9w09FdarmMeGTH9yaW39qbNEI1qPhv/H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273258; c=relaxed/simple;
	bh=7uR3oDpTd2IAe31pis/y6K5hu6L4SKhG6gEzQD+QyCw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ug6uF6J9jsWZSupfzTbmUF8qb/WYJuIjzbFI8gEAYX+QhVwyjs21IB/V+CgHkEQGqYEjvPlxMGvuWOUmIfn8qCUHs6TZ+M6r5icz1N2DmqL8JanpgSUZ3sG4QyWtn/O+IQVI0AgiCYeLW4SmjS4Y9EGTiB3L3yfL8ZuNnWaTPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkwSeHjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkwSeHjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0C81F000FF;
	Thu, 24 Sep 2026 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273256;
	bh=HJTn/uGAR0rF8xvQ/LSrVRIuvWIjfRHpr7wp/c1qUBk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nkwSeHjIYpMZGuAKCUjgq2aps2C8gk1kqJ77KodfPwYp9r9POiqd64K3klJDdb+7J
	 6i2EHeZVAfCivX0Kimgmd1AxQpFQfyBuwvQvyYWewJX0CM818ptR0oP/5adAGP5HSs
	 Pxpbo6+yjKE8vut6fvty9INFG3UBtDnKWUgU1/P3ERc9aU0QbWd18439tzMBk5O2pr
	 ThCaIP8t85hkPlcK0mawzFztbZE7t1+uBFG0IooiyHhbd1L5aPY4x0N8iMyrD/NhPy
	 lEdRzP4rwEBlNKj78f4qYb3Ha7axhINnTvu1IU3QL5g4fRfRzKZS9mA+jw4MS2hDQJ
	 1otsMVMBxlm4Q==
Content-Type: multipart/mixed; boundary="===============7630020204762002033=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1af4e60e20bc3fa1547c0ad4a8d72b904535ec2a4c40d620d59142bb630742f3@mail.kernel.org>
In-Reply-To: <20260924170543.1017048-3-florent.revest@linux.dev>
References: <20260924170543.1017048-3-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v3 2/3] bpf: Skip the progs of trampoline images that are being freed
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 18:07:32 +0000 (UTC)

--===============7630020204762002033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2853e87797a7..7ef5c8efc882 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3217,16 +3217,21 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
>  }
>
>  static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> +			   struct bpf_tramp_image *im,
>  			   struct bpf_tramp_node *node, int stack_size,
>  			   int run_ctx_off, bool save_ret,
>  			   void *image, void *rw_image)
>  {
>  	u8 *prog = *pprog;
> -	u8 *jmp_insn;
> +	u8 *jmp_insn, *skip;
>  	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>  	struct bpf_prog *p = node->link->prog;
>  	u64 cookie = node->cookie;
>
> +	/* nop, patched to skip this prog when the image is put */
> +	skip = image + (prog - (u8 *)rw_image);
> +	emit_nops(&prog, X86_PATCH_SIZE);
> +

The patch adds a 5-byte nop in front of every prog call sequence on x86
but keeps BPF_MAX_TRAMP_LINKS at 38. This adds 38 * 5 - 5 = 185 bytes to
the worst case image size, which was already close to PAGE_SIZE.

Example worst case: 19 fsession progs (38 link slots because each counts
twice) attached to a function with 7-9 argument registers, each calling
bpf_session_cookie() and bpf_get_func_ip() with a 64-bit link cookie.

With 7 args the image reaches about 4040-4043 bytes, above
PAGE_SIZE - BPF_INSN_SAFETY = 4032. With 10 args it reaches about
4106-4109 bytes. An attach that used to succeed now fails with -EFAULT
and a WARN_ON_ONCE() splat.

The size pass writes to a single PAGE_SIZE execmem buffer with only an
end-of-pass WARN_ON_ONCE check:

arch/x86/net/bpf_jit_comp.c:arch_bpf_trampoline_size() {
    image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
    ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, ...);

arch/x86/net/bpf_jit_comp.c:__arch_prepare_bpf_trampoline() {
    if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
        ret = -EFAULT;
        goto cleanup;
    }

With 10 args the size pass writes past the end of the execmem buffer
before the check is reached.

The commit message says the extra nops break the page budget only on
arm64 and loongarch. Should x86 get a lower BPF_MAX_TRAMP_LINKS too, or
should the x86 size pass bound-check as it emits?

[ ... ]

> @@ -3368,7 +3377,7 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>  	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
>  	for (i = 0; i < tl->nr_nodes; i++) {
> -		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size, run_ctx_off, true,
> +		if (invoke_bpf_prog(m, &prog, im, tl->nodes[i], stack_size, run_ctx_off, true,
>  				    image, rw_image))
>  			return -EINVAL;
>
>  		/* mod_ret prog stored return value into [rbp - 8]. Emit:
>  		 * if (*(u64 *)(rbp - 8) !=  0)
>  		 *	goto do_fexit;
>  		 */

invoke_bpf_mod_ret() now passes im to invoke_bpf_prog(), so every
fmod_ret prog gets a skip nop that bpf_tramp_image_put() patches to a
jump. The skip target is before the cmp/jne check. A skipped fmod_ret
prog therefore leaves the previous return value in place (0 from the
initial mov after xor eax,eax), and the original function is called.

Before this change only fexit progs were skipped in a put image, and
those only observe. fmod_ret progs always ran. Any trampoline update puts
the old image, including attaching or detaching an unrelated prog.

BPF LSM progs on int hooks become BPF_TRAMP_MODIFY_RETURN:

kernel/bpf/verifier.c:bpf_attach_type_to_tramp() {
    case BPF_LSM_MAC:
        if (!prog->aux->attach_func_proto->type)
            return BPF_TRAMP_FEXIT;
        else
            return BPF_TRAMP_MODIFY_RETURN;

Hooks such as bpf_lsm_file_open and bpf_lsm_bprm_check_security are in
sleepable_lsm_hooks. A possible sequence:

  task T in image I of bpf_lsm_file_open,
    sleeping in sleepable LSM prog S (returns 0)
                                     attach another prog to the hook
                                      -> new image, bpf_tramp_image_put(I)
                                      -> nop before enforcing prog P patched to jmp
  T returns from S
  jmp over P (P is still attached)
  cmp [rbp-8], 0 -> equal, call bpf_lsm_file_open() -> 0
  open allowed although P would have denied it

On a preemptible kernel the window exists even without sleepable progs:
anywhere between trampoline entry and P's nop.

The commit message says still-attached progs are skipped "like they
already skipped its fexit progs". For fmod_ret, though, skipping changes
the traced function's return value instead of just losing an event.

Is it intended that a concurrent attach or detach on the same hook can
bypass an attached LSM or fmod_ret prog?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d4f732996b47..9c61803380c2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1258,11 +1258,15 @@ struct btf_func_model {
>  #define BPF_TRAMP_F_INDIRECT		BIT(8)
>
>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> - * bytes on x86.
> + * bytes on x86. The trampoline image has to fit in PAGE_SIZE.
>   */
>  enum {
> -#if defined(__s390x__)
> +#if defined(__s390x__) || defined(__powerpc64__)
>  	BPF_MAX_TRAMP_LINKS = 27,
> +#elif defined(__loongarch__)
> +	BPF_MAX_TRAMP_LINKS = 33,
> +#elif defined(__aarch64__)
> +	BPF_MAX_TRAMP_LINKS = 37,
>  #else
>  	BPF_MAX_TRAMP_LINKS = 38,
>  #endif

BPF_MAX_TRAMP_LINKS drops from 38 to 27 for every __powerpc64__ build
(and to 37 for every __aarch64__ build), whatever the page size. The
updated comment says the constraint is that the image has to fit in
PAGE_SIZE, and bpf_trampoline_update() does check the size against
PAGE_SIZE.

PPC_64K_PAGES is the default for PPC_BOOK3S_64, and 38 progs fit easily
in a 64K image. On common ppc64le configurations (and arm64 with 16K/64K
pages), attaching the 28th to 38th prog to one function now fails with
-E2BIG where it used to work.

The commit message's "already didn't on powerpc" only holds for 4K pages.

Could the limit depend on PAGE_SIZE instead, keeping 38 when the page is
larger than 4K?

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 9d69c066a817..0d7aa1b0fe30 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -611,6 +612,8 @@ static void __bpf_tramp_image_put_rcu_tasks(struct rcu_head *rcu)
>
>  static void bpf_tramp_image_put(struct bpf_tramp_image *im)
>  {
> +	int i, err;
> +
>  	/* The trampoline image that calls original function is using:
>  	 * rcu_read_lock_trace to protect sleepable bpf progs
>  	 * rcu_read_lock to protect normal bpf progs
> @@ -621,10 +624,17 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
>  	 *
>  	 * The trampoline is unreachable before bpf_tramp_image_put().
>  	 *
> -	 * First, patch the trampoline to avoid calling into fexit progs.
> -	 * The progs will be freed even if the original function is still
> -	 * executing or sleeping.
> -	 * In case of CONFIG_PREEMPT=y use call_rcu_tasks() to wait on
> +	 * First, patch the trampoline to avoid calling into progs. The progs
> +	 * will be freed even if a task is still in the trampoline, e.g.
> +	 * sleeping in the original function or in a sleepable prog.
> +	 */
> +	for (i = 0; i < im->nr_skips; i++) {
> +		err = bpf_arch_text_poke(im->skips[i].nop, BPF_MOD_NOP,
> +					 BPF_MOD_JUMP, NULL, im->skips[i].target);
> +		WARN_ON_ONCE(err);
> +	}

Now that every prog nop in the old image is patched, a task still in that
image also skips the fmod_ret progs that are still attached, not only
fentry/fexit progs.

Before this change only ip_after_call was patched. It sits after the
original function call, so fentry and fmod_ret progs always ran and only
fexit progs could be skipped.

The commit message justifies skipping attached progs "like they already
skipped its fexit progs". That comparison holds for observe-only
fentry/fexit progs, but fmod_ret progs decide the return value and
whether the original function runs.

BPF LSM progs on int-returning hooks are attached as
BPF_TRAMP_MODIFY_RETURN. Scenario:

1. Task T enters image I_old for bpf_lsm_file_open. It is either
   preempted or sleeping in an earlier sleepable lsm.s prog, e.g. blocked
   in bpf_copy_from_user(). Either way it has not yet reached the nop of
   enforcing LSM prog L.

2. Someone attaches or detaches any other prog on the same trampoline.
   bpf_trampoline_update() -> modify_fentry() -> bpf_tramp_image_put(I_old)
   turns all nops of I_old into jumps, including L's.

3. T resumes and jumps over L's call sequence. In x86 invoke_bpf_mod_ret()
   the result slot [rbp-8] was zeroed and nothing stores to it, so the
   following cmp/jne does not branch to do_fexit. The original
   bpf_lsm_file_open() stub is called and returns 0.

The hook fails open for T even though L is still attached and would have
denied access. The sequential pokes can also leave T running some
fmod_ret progs but not others. The sleepable case makes the window as
long as the earlier prog blocks.

Should fmod_ret progs that are still attached keep running, with only the
progs being removed skipped? Otherwise, is this fail-open behaviour for
BPF LSM and fmod_ret acceptable, and should the commit message and comment
say so?

> +
> +	/* In case of CONFIG_PREEMPT=y use call_rcu_tasks() to wait on
>  	 * first few asm instructions to execute and call into
>  	 * __bpf_tramp_enter->percpu_ref_get.
>  	 * Then use percpu_ref_kill to wait for the trampoline and the original

This isn't a bug, but the multi-line comment has the opening slash-star on
the same line as the comment text. BPF subsystem style in kernel/bpf/ has
the opening slash-star on its own line for new multi-line comments:

	/*
	 * In case of CONFIG_PREEMPT=y use call_rcu_tasks() to wait on
	 * first few asm instructions to execute and call into


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36034251810
--===============7630020204762002033==--
