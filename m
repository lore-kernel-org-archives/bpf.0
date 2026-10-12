Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF74AA417;
	Mon, 12 Oct 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822807; cv=none; b=ZP4bo09rHuCrBtPT+N4lXjJY3H5kIK24PdsRsN4uRIt+eLCcWbGe5Y1VJZGhXbZYoiJ6sUJuAxwUEStlNIQDsmLFZhpjH8MoM5AWxdAxlAjT+DKHnaX6eBAo7ZIAn87N0G/hV2x9g4CVqab8vyGGwNPeFnLhlJfU57VWMo3MjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822807; c=relaxed/simple;
	bh=jvItHi2UvJAznfCaLCZ6hV+RAv58pFYv8RxZJsURjeo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iaoUy/8m9ZonFm5pwbEMDPBjih0dZjRYZmssrgVTVqreyG1rOSDJlrxIRFGNZj+EcBS8x3IPk6XGHjWEpN6iemwF5VoKHkK4FzixM8HgQjlKOspqGjwAZtJQE1CG56tk3Bumh/pm3YAAeOmP4rG8bHygVa7Mj7Gi44RtY/jxbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0S0nwof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0S0nwof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C661F0089B;
	Mon, 12 Oct 2026 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822805;
	bh=wlX8X2NZGEScWXWg0vLkTJT/Pqvxgu0kjIejsLhRrl8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=j0S0nwofyjl8bQ174JRosoDjc2X3x+g84LsGU2AXH8avlLzeRaiSfTHs7JxrJFgxj
	 y3fpbOMTt00ID4dHLGCcLK9oThGNEWAtryz1TguI8O44t8pzWYHzMdJBuQeyPwh6OR
	 s9ZmZC2fxiaZCdD9//jFQAhOTJbl3HqinBQ9fonLuUOuyBWQJXAP3O1RCF3c90Kkm8
	 tUFFE4yLoDTJ92oX58AzDrRU9qVnQU6eidKeeQQtNyEiU9GPucoUtgUyq2KAtp0UXZ
	 SOl2tMsa178mFzWqpsheUu1711k1lkRq7nmgczqwc/4DSdD70xClSm8rk6T6AyHJUF
	 NPDGctDgiRmQA==
Content-Type: multipart/mixed; boundary="===============2648014642368256279=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7dcfb26401d414261ad488284abf342f0d11c7888a1dd3512b1a9ad1878478b1@mail.kernel.org>
In-Reply-To: <20261012154024.29423-10-leon.hwang@linux.dev>
References: <20261012154024.29423-10-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 09/21] bpf: Add bpf_trampoline_multi_prog_attach/detach()
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:33:22 +0000 (UTC)

--===============2648014642368256279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_trampoline_multi_prog_attach/detach()

TL;DR: bpf_trampoline_multi_prog_detach() may, if one unlink fails (e.g.
-ENOMEM), still commit and free old images after a failed batch poke, so other
targets could run freed trampoline memory.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1918,6 +1923,217 @@ static int bpf_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt)
> +static void bpf_trampoline_multi_prog_commit(struct bpf_trampoline *tr)
> +{
> +	struct bpf_tramp_image *old_image = tr->multi_attach.old_image;
> +
> +	tr->cur_image = tr->multi_attach.new_image;
> +	tr->multi_attach.old_image = NULL;
> +	tr->multi_attach.new_image = NULL;
> +	tr->multi_attach.old_flags = 0;
> +
> +	if (old_image)
> +		bpf_tramp_image_put(old_image);
> +}
> +
> +static void bpf_trampoline_multi_prog_rollback(struct bpf_trampoline *tr)
> +{
> +	if (tr->multi_attach.new_image)
> +		bpf_tramp_image_put(tr->multi_attach.new_image);
> +
> +	tr->flags = tr->multi_attach.old_flags;
> +	tr->multi_attach.old_image = NULL;
> +	tr->multi_attach.new_image = NULL;
> +	tr->multi_attach.old_flags = 0;
> +}

[ ... ]

> +void bpf_trampoline_multi_prog_detach(struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_tracing_multi_node *mnode;
> +	int i, err;
> +
> +	trampoline_lock_all();
> +
> +	for_each_mnode(mnode, link) {
> +		bpf_trampoline_multi_attach_init(mnode->trampoline);
> +		err = __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline, NULL,
> +						   &trampoline_multi_prog_ops, NULL);
> +		if (WARN_ONCE(err, "__bpf_trampoline_unlink_prog failed: %d\n", err))
> +			bpf_trampoline_multi_prog_rollback(mnode->trampoline);
> +	}

If __bpf_trampoline_unlink_prog() fails for one trampoline here, can this
leave other targets calling freed trampoline images?

The failure is reachable.  bpf_trampoline_update() returns an error when
bpf_trampoline_get_progs() or bpf_tramp_image_alloc() fails (-ENOMEM), or
when bpf_jit_charge_modmem() returns -EPERM because bpf_jit_limit is
exceeded and the task closing the link fd is not bpf_capable().  The comment
in bpf_trampoline_multi_attach_free() already treats this failure as
reachable on the ftrace detach path.

Say the unlink fails for trampoline B:

1. bpf_trampoline_multi_attach_init() has set old_image = cur_image, which
   is still live in the text, and new_image = NULL.

2. bpf_trampoline_multi_prog_rollback() then clears old_image to NULL as
   well.

3. bpf_text_poke_init() therefore builds a poke for B with old_addr and
   new_addr both NULL (BPF_MOD_NOP to BPF_MOD_NOP), while B's entry still
   holds a call or jump to its live image.

4. On x86, bpf_arch_text_poke_batch() checks every poke before patching
   anything:

       if (memcmp(poke->ip, old_insn, X86_PATCH_SIZE))
           return -EBUSY;

   B's check fails, so no text is patched for any target in the link.  The
   generic fallback rolls back the pokes it already applied, with the same
   result.

> +
> +	for_each_mnode(mnode, link) {
> +		link->pokes[i] = &mnode->poke;
> +		bpf_text_poke_init(link->pokes[i], mnode->trampoline);
> +	}
> +
> +	WARN_ON_ONCE(bpf_text_poke_batch(link->pokes, link->nodes_cnt));
> +
> +	for_each_mnode(mnode, link)
> +		bpf_trampoline_multi_prog_commit(mnode->trampoline);

The batch error only triggers WARN_ON_ONCE(), and
bpf_trampoline_multi_prog_commit() still runs for every node.

For every other target A in the link, old_A is passed to
bpf_tramp_image_put() and freed after a tasks-rcu grace period.  A's entry
still calls old_A, because it was never repointed, so the next run of target
A executes freed trampoline memory.  Meanwhile new_A becomes cur_image
without ever having been installed.

For B itself, commit sets cur_image to NULL while the text still calls the
old image.  That image is never put, so it leaks along with its trampoline
reference.  If another prog (for example a plain fentry) is still attached
to B and is later detached, bpf_trampoline_update() reaches total == 0 and
calls unregister_fentry(), which dereferences tr->cur_image->image while
cur_image is NULL.  Any new attach to B instead goes through
register_fentry(), expects a nop at the entry, and fails with -EBUSY.

The ftrace-based bpf_trampoline_multi_detach() avoids this.  On unlink
failure it leaves cur_image unchanged, and bpf_trampoline_multi_attach_free()
skips freeing old_image when old_image == cur_image.  Could the prog detach
path get the same treatment?

For example, on unlink failure the trampoline could be kept on its current
image (new_image = old_image, so the poke is an identity poke and commit
neither puts nor drops cur_image), or the node could be left out of the
batch.  It also seems that images should not be committed when
bpf_text_poke_batch() fails.

This path is not called by this commit.  It is wired up later in the series
by b56b0344ff12 ("bpf: Add tracing_multi link support for bpf progs"), where
bpf_tracing_multi_link_release() calls bpf_trampoline_multi_prog_detach().
The function is unchanged at the end of the series, so no later commit
fixes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============2648014642368256279==--
