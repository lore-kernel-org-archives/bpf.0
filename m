Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C3429000;
	Sat, 12 Sep 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211481; cv=none; b=t0/dy6D74eIDER1YPNUlsP2j9fwJyzf6xX2ShCrZVEC4AQTppwFKYBbW0/4shmrvh8/KByolvQ6G1xJ4GavR4jdl0o6efuBrF/kgCfugPs0kIwCo7FUNB2K/G2Uie3aE3x/G+2HavwGUX0Vh38Z7sDBS8GumtTLgCvNl34gGan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211481; c=relaxed/simple;
	bh=RyYLhLuGGL/X5+6M8M6vstsnUIR/qykkQ6oE71q43Lk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KqH9sRl1S3ne/v+JCNOXbnZxa+QJ6o2sEvpT0PO0Lq6I3iHwlO7iEorhT+adDybSFQZ/IbNUwOw+E/kBPIjZNuNtg+Shqj8AqSWLmbKwly3KRRAQ79RNzIozRc7KHK6jAp8+/QH8Ie2uZQtqnkd9yE6MwMTK9rKGfeXuxpIledk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu7y13jP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu7y13jP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C201F00898;
	Sat, 12 Sep 2026 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211479;
	bh=YmxGJgRErJMTgGMl4gFEV6eVzM7Y1PU9efzzgGgS47M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bu7y13jPj2uqBBgzltp0n2bR8UW2M59MdWDOGGiT/MifLFdUu878ElGMQKO9LOqeV
	 Z7M7m6WF75zxyB4pCu2H6ug3m0c0k/LIOEIsNnwowRYE4QVW78nZtTT4GmmTPvhyWB
	 d0B5OoHmPyBcI6ZzZR80Run5WJDzQmpRj0kD4mp/Mf3G+HYqFEl5aa9v1PRnMKazVd
	 dgC2TWd4KQxXAaV/NWUXqCxu3c3N62hCs3zLbbE7pg2wybYUWhaDWtqaj5UshSNCdY
	 6mez2u4yQHDdNYI8jvPUwWUTmmzG0mZRGEIkNoXjJuWJqUkR/tE3dSUsC4tYJE+5ia
	 Xt4yxcmw8OE9w==
Content-Type: multipart/mixed; boundary="===============7598360419197445268=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <701db29c4de4f408d9c82041d51586a88ccbd9c19f4dc739253733c4cc5edd7a@mail.kernel.org>
In-Reply-To: <20260912095924.866254-2-florent.revest@linux.dev>
References: <20260912095924.866254-2-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline images that are still in use
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 12 Sep 2026 11:11:18 +0000 (UTC)

--===============7598360419197445268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 4da278900938..0e6f1ad36c2d 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -2178,7 +2189,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  {
>  	int ret;
>  	struct jit_ctx ctx;
> -	struct bpf_tramp_image im;
> +	struct bpf_tramp_image im = {};
>
>  	ctx.image = NULL;
>  	ctx.idx = 0;

Does arch_bpf_trampoline_size() need to initialize ctx.ro_image?
invoke_bpf_prog() now reads ctx->ro_image unconditionally:

arch/loongarch/net/bpf_jit.c:invoke_bpf_prog()
    void *skip = ctx->ro_image + ctx->idx;

but arch_bpf_trampoline_size() only assigns ctx.image and ctx.idx. Before
this patch the sizing path read ctx->ro_image only under
BPF_TRAMP_F_CALL_ORIG, so fentry-only trampolines never touched it. The
result is discarded (bpf_tramp_image_add_skip() returns immediately
because im.skips == NULL), so there is no functional misbehaviour, but it
is a read of an uninitialized automatic variable.

The arm64 side of the same patch already uses a designated initializer:

arch/arm64/net/bpf_jit_comp.c:arch_bpf_trampoline_size()
    struct jit_ctx ctx = { .image = NULL, .idx = 0, };

Making the loongarch declaration 'struct jit_ctx ctx = {};' would avoid
the issue.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 151031e97a24..21f8ce2ec89a 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -904,12 +904,18 @@ static void emit_store_stack_imm64(u8 reg, int stack_off, u64 imm64,
>  	emit_sd(RV_REG_FP, stack_off, reg, ctx);
>  }
>
> -static int invoke_bpf_prog(struct bpf_tramp_node *node, int args_off, int retval_off,
> -			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> +static int invoke_bpf_prog(struct bpf_tramp_image *im, struct bpf_tramp_node *node,
> +			   int args_off, int retval_off, int run_ctx_off, bool save_ret,
> +			   struct rv_jit_context *ctx)
>  {
>  	int ret, branch_off;
>  	struct bpf_prog *p = node->link->prog;
>  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> +	void *skip = ctx->ro_insns + ctx->ninsns;
> +
> +	/* 2 nops for auipc+jalr, patched to skip this prog when it is detached */
> +	emit(rv_nop(), ctx);
> +	emit(rv_nop(), ctx);

This isn't a bug, but should BPF_MAX_TRAMP_LINKS be lowered for riscv64?

The commit message states "With the extra nops, BPF_MAX_TRAMP_LINKS progs
no longer fit in a page on arm64 and loongarch ... so lower the limit
there like s390 does." The limits in include/linux/bpf.h were changed:

  arch       added per prog   BPF_MAX_TRAMP_LINKS change
  arm64      4 bytes            38 -> 37
  loongarch  20 bytes           38 -> 33
  powerpc64  4 bytes            38 -> 27
  s390x      6 bytes            27 (already lowered)
  riscv64    8 bytes            38 (unchanged)
  x86_64     5 bytes            38 (unchanged)

riscv64 gains 8 bytes per prog (two rv_nop()s) but its limit is
unchanged. For 38 progs that is 304 extra bytes, which could push
trampolines close to the PAGE_SIZE limit over the boundary.
bpf_trampoline_update() rejects the update with -E2BIG if size exceeds
PAGE_SIZE, so this is a graceful reduction in the maximum attachable
progs on riscv64 rather than memory corruption.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 90b70ea0d370..b82d8592319a 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -565,14 +566,21 @@ static void bpf_tramp_image_free(struct bpf_tramp_image *im)
>  	arch_free_bpf_trampoline(im->image, im->size);
>  	bpf_jit_uncharge_modmem(im->size);
>  	percpu_ref_exit(&im->pcref);
> +	kfree(im->skips);
>  	kfree_rcu(im, rcu);
>  }
>
>  static void __bpf_tramp_image_put_deferred(struct work_struct *work)
>  {
> +	struct bpf_trampoline *tr;
>  	struct bpf_tramp_image *im;
>
>  	im = container_of(work, struct bpf_tramp_image, work);
> +	tr = im->tr;
> +	trampoline_lock(tr);
> +	list_del(&im->list);
> +	trampoline_unlock(tr);
> +	bpf_trampoline_put(tr);
>  	bpf_tramp_image_free(im);
>  }

[ ... ]

This isn't a bug, but the comment at the call site of
__bpf_tramp_image_put_deferred() appears stale. bpf_trampoline_update()
now does:

kernel/bpf/trampoline.c:bpf_trampoline_update()
    /* track the image until it is freed, for bpf_trampoline_skip_prog() */
    refcount_inc(&tr->refcnt);
    im->tr = tr;
    list_add(&im->list, &tr->images);

so every live bpf_tramp_image holds a reference on the trampoline and
tr->refcnt cannot reach 0 while any image is alive. The comment in
bpf_trampoline_put() says:

kernel/bpf/trampoline.c:bpf_trampoline_put()
    /* This code will be executed even when the last bpf_tramp_image
     * is alive. All progs are detached from the trampoline and the
     * trampoline image is patched with jmp into epilogue to skip
     * fexit progs. The fentry-only trampoline will be freed via
     * multiple rcu callbacks.
     */
    hlist_del(&tr->hlist_key);

but the guarded block is now reached only after the last image has been
unlinked, typically from __bpf_tramp_image_put_deferred() rather than
from the detach syscall.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34688142088
--===============7598360419197445268==--
