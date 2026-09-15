Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B73481FD6
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499606; cv=none; b=Rh4tqM77d0lac6daraf4m7pi3wiyn6g63YOC/WSd2RlS3vSX3eNmpuHvnWy5lVUHvGw0C9u47mZ46l80i4FwC84S9okjJt2B6xsrGPqfCxRQ/8/XcSiT42X40UQ4xJdxJcojIdwmmE2eeWgeDsJjXmbHFMQ9sRQcl11d3FgAIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499606; c=relaxed/simple;
	bh=anFEelSsGeeEC3XPXvpXfQ+smHU+cXmR/GUPT+ANFwA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=j+b5PasmPPKskIEk9FwKN0k5GXlbNfhtKNh3qOC3y/BRynECPvhWDZVr1PaOba90wPwsD5QUr2s6emAPMi81IqzDoK6ohJO1FW8RWnL+iJWJ4+/JnIJr12HInoNgzpNUJE/tmiEKmb7hOFDdU3G2R/tZN4NmFsAIrItEeC1CkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y+BCn3lL; arc=none smtp.client-ip=91.218.175.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y+BCn3lL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=anFEelSsGeeEC3XPXvpXfQ+smHU+cXmR/GUPT+ANFwA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789499600; v=1; x=1790104400;
 b=Y+BCn3lL0fq8KlvuQ5f5q500/zONyT678cNRAQZ9/j20QKo2nNhtv7Iijvit/lR+53dF6XMi
 k47fdrvuF2wCR4f32vRwwEe/TSQDOtd+Gob9BtRX9R5Hjkr/sttDQSjKx8H/FeO3pZRCJ4Zrrsm
 3/T/3JgIsxZkS3nmZu0PmiUA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7210ecafb0eec5e7;
	Tue, 15 Sep 2026 19:13:20 +0000
X-Mizu-Trace-ID: 7210ecafb0eec5e7
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 19:13:15 +0000
Message-Id: <DLG4NX9R5VTO.3QXM13LGWVURY@linux.dev>
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
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
From: "Florent Revest" <florent.revest@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-2-florent.revest@linux.dev>
 <701db29c4de4f408d9c82041d51586a88ccbd9c19f4dc739253733c4cc5edd7a@mail.kernel.org>
In-Reply-To: <701db29c4de4f408d9c82041d51586a88ccbd9c19f4dc739253733c4cc5edd7a@mail.kernel.org>

On Sat Sep 12, 2026 at 11:11 AM UTC,  wrote:
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 4da278900938..0e6f1ad36c2d 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
>
> [ ... ]
>
> > @@ -2178,7 +2189,7 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
> >  {
> >  	int ret;
> >  	struct jit_ctx ctx;
> > -	struct bpf_tramp_image im;
> > +	struct bpf_tramp_image im =3D {};
> >
> >  	ctx.image =3D NULL;
> >  	ctx.idx =3D 0;
>
> Does arch_bpf_trampoline_size() need to initialize ctx.ro_image?
> invoke_bpf_prog() now reads ctx->ro_image unconditionally:
>
> arch/loongarch/net/bpf_jit.c:invoke_bpf_prog()
>     void *skip =3D ctx->ro_image + ctx->idx;
>
> but arch_bpf_trampoline_size() only assigns ctx.image and ctx.idx. Before
> this patch the sizing path read ctx->ro_image only under
> BPF_TRAMP_F_CALL_ORIG, so fentry-only trampolines never touched it. The
> result is discarded (bpf_tramp_image_add_skip() returns immediately
> because im.skips =3D=3D NULL), so there is no functional misbehaviour, bu=
t it
> is a read of an uninitialized automatic variable.
>
> The arm64 side of the same patch already uses a designated initializer:
>
> arch/arm64/net/bpf_jit_comp.c:arch_bpf_trampoline_size()
>     struct jit_ctx ctx =3D { .image =3D NULL, .idx =3D 0, };
>
> Making the loongarch declaration 'struct jit_ctx ctx =3D {};' would avoid
> the issue.

Fair, will address in v3.

> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index 151031e97a24..21f8ce2ec89a 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -904,12 +904,18 @@ static void emit_store_stack_imm64(u8 reg, int st=
ack_off, u64 imm64,
> >  	emit_sd(RV_REG_FP, stack_off, reg, ctx);
> >  }
> >
> > -static int invoke_bpf_prog(struct bpf_tramp_node *node, int args_off, =
int retval_off,
> > -			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> > +static int invoke_bpf_prog(struct bpf_tramp_image *im, struct bpf_tram=
p_node *node,
> > +			   int args_off, int retval_off, int run_ctx_off, bool save_ret,
> > +			   struct rv_jit_context *ctx)
> >  {
> >  	int ret, branch_off;
> >  	struct bpf_prog *p =3D node->link->prog;
> >  	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> > +	void *skip =3D ctx->ro_insns + ctx->ninsns;
> > +
> > +	/* 2 nops for auipc+jalr, patched to skip this prog when it is detach=
ed */
> > +	emit(rv_nop(), ctx);
> > +	emit(rv_nop(), ctx);
>
> This isn't a bug, but should BPF_MAX_TRAMP_LINKS be lowered for riscv64?
>
> The commit message states "With the extra nops, BPF_MAX_TRAMP_LINKS progs
> no longer fit in a page on arm64 and loongarch ... so lower the limit
> there like s390 does." The limits in include/linux/bpf.h were changed:
>
>   arch       added per prog   BPF_MAX_TRAMP_LINKS change
>   arm64      4 bytes            38 -> 37
>   loongarch  20 bytes           38 -> 33
>   powerpc64  4 bytes            38 -> 27
>   s390x      6 bytes            27 (already lowered)
>   riscv64    8 bytes            38 (unchanged)
>   x86_64     5 bytes            38 (unchanged)
>
> riscv64 gains 8 bytes per prog (two rv_nop()s) but its limit is
> unchanged. For 38 progs that is 304 extra bytes, which could push
> trampolines close to the PAGE_SIZE limit over the boundary.
> bpf_trampoline_update() rejects the update with -E2BIG if size exceeds
> PAGE_SIZE, so this is a graceful reduction in the maximum attachable
> progs on riscv64 rather than memory corruption.

38 progs still fit on riscv64 with the extra nops so that's ok.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 90b70ea0d370..b82d8592319a 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
>
> [ ... ]
>
> > @@ -565,14 +566,21 @@ static void bpf_tramp_image_free(struct bpf_tramp=
_image *im)
> >  	arch_free_bpf_trampoline(im->image, im->size);
> >  	bpf_jit_uncharge_modmem(im->size);
> >  	percpu_ref_exit(&im->pcref);
> > +	kfree(im->skips);
> >  	kfree_rcu(im, rcu);
> >  }
> >
> >  static void __bpf_tramp_image_put_deferred(struct work_struct *work)
> >  {
> > +	struct bpf_trampoline *tr;
> >  	struct bpf_tramp_image *im;
> >
> >  	im =3D container_of(work, struct bpf_tramp_image, work);
> > +	tr =3D im->tr;
> > +	trampoline_lock(tr);
> > +	list_del(&im->list);
> > +	trampoline_unlock(tr);
> > +	bpf_trampoline_put(tr);
> >  	bpf_tramp_image_free(im);
> >  }
>
> [ ... ]
>
> This isn't a bug, but the comment at the call site of
> __bpf_tramp_image_put_deferred() appears stale. bpf_trampoline_update()
> now does:
>
> kernel/bpf/trampoline.c:bpf_trampoline_update()
>     /* track the image until it is freed, for bpf_trampoline_skip_prog() =
*/
>     refcount_inc(&tr->refcnt);
>     im->tr =3D tr;
>     list_add(&im->list, &tr->images);
>
> so every live bpf_tramp_image holds a reference on the trampoline and
> tr->refcnt cannot reach 0 while any image is alive. The comment in
> bpf_trampoline_put() says:
>
> kernel/bpf/trampoline.c:bpf_trampoline_put()
>     /* This code will be executed even when the last bpf_tramp_image
>      * is alive. All progs are detached from the trampoline and the
>      * trampoline image is patched with jmp into epilogue to skip
>      * fexit progs. The fentry-only trampoline will be freed via
>      * multiple rcu callbacks.
>      */
>     hlist_del(&tr->hlist_key);
>
> but the guarded block is now reached only after the last image has been
> unlinked, typically from __bpf_tramp_image_put_deferred() rather than
> from the detach syscall.

Ok, will update in v3 if we keep the list.
