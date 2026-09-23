Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A944C678
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193466; cv=none; b=cB+aXV6RaO44Fe5Zl5bun1egfgeJ1p4xjRzKlgYOJJvHQxr6I0F8IocXwJPS9uAMfRYUntx55eMijorAZqPpu0fLy2Vv+h/sJcScQHR/Pjq6Mrwc8ujI0yCg8wmlcjrHzXhVAx1ibfLZs6zaUbW9VWaobaTLPzzCjmS5V+FAxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193466; c=relaxed/simple;
	bh=Z/4NfYRkerR6Fzitixj4zJL0aK/hzEtXn1IbKrmLi1w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R8kESt5pPSKwnbbf5Kx4TJj6nqlOwqDq5jC6fthhKqSf6gFykZ9C9FpqeFcgA3tRrVdPyaFsaRrwoo42a01HfRAFAqnJPUQtMilx6lN/7ErGoUt0IsdPWdNKqujfP88TNVaJo77EV2wNU8JaAAS5R9+NWmhBNPMvXp3mNlm1jzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH62cn4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH62cn4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63411F000FF;
	Wed, 23 Sep 2026 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790193465;
	bh=aOnXOFsPdWZC4sLr9f0Wb2KrKnurVAs33OnmYE5Syn4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZH62cn4icn25krMIy+xRObUW0KQwYxUtIlvsEdu43GpasUhi2SUSpNE9t+CxHaU0n
	 ONLC1Zaac6G9r0B/R354V974tak+zFl/aI6GDCBLnlx/xrJLoOi2wQlLE1ZHx6TXTB
	 KRWcy/iZs+3JL+mzPCckyk+5wUIzKXnZpnwUL9mf1Ut3emCfuWcWIi5kLnYiQ/Tm/n
	 VHTF7CW3+1AtMiA7u01Hrp6u1L7ywidkBIfJuJuYCtHxdwv3IoKzhvM+VZgHwDp7nY
	 Y9Tx+pJLKhuLNCF3nygEdL8UGicZPk6DaHV8GdhwkWPnf7z/aeKIyv0UjJWWT5gRKU
	 RWCsS+ZIfjd8g==
Content-Type: multipart/mixed; boundary="===============8478301700528267284=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <731653ff84bafb19361b62836f366d369799041bf18166b016dc7ff13eff5b73@mail.kernel.org>
In-Reply-To: <20260923191139.2816206-2-memxor@gmail.com>
References: <20260923191139.2816206-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/18] bpf: Add accessors for verifier stack slots
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 19:57:43 +0000 (UTC)

--===============8478301700528267284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add accessors for verifier stack slots
>
> The verifier indexes a frame's stack state directly through
> state->stack[spi] and computes the number of tracked slots as
> allocated_stack / BPF_REG_SIZE in every file that touches stack slots.
> Route all of these through two helpers, bpf_stack_slot() and
> bpf_stack_nr_slots(), so the layout of the per-frame stack state is
> visible in one place and can change without touching every user.
> Both take a const frame: the slot accessor returns the slot through the
> frame's stack pointer, so read-only code such as the state printer can
> use it without giving up its qualifiers. Functions that look up the
> same slot repeatedly now fetch it once.
>
> No functional change.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The commit message makes two universal claims that the tree does not back
up after this patch.

1) "Route all of these through two helpers ... so the layout of the
per-frame stack state is visible in one place and can change without
touching every user."

At least two users of struct bpf_func_state::stack still depend on the raw
layout:

drivers/net/ethernet/netronome/nfp/bpf/verifier.c:nfp_bpf_map_update_value_ok():

    state = env->cur_state->frame[reg3->frameno];
    ...
    soff = -(off + i) - 1;
    stack_entry = &state->stack[soff / BPF_REG_SIZE];

This is the exact state->stack[spi] indexing the message says was removed.
It was not converted.

kernel/bpf/diagnostics.c:reg_to_target(), which this patch edits (the nslots
line), still does raw pointer arithmetic that assumes stack is a flat array:

    start = (unsigned long)state->stack;
    end = (unsigned long)(state->stack + nslots);
    ...
    spi = ((const char *)reg - (const char *)state->stack) /
          sizeof(*state->stack);

If bpf_stack_slot() ever stops being &frame->stack[spi], both sites will
silently compute wrong slots. So the stated goal (the layout can change
without touching every user) does not hold yet.

Nothing later in 277f2757dee8..7757cddf610a changes the helpers, the layout,
or the nfp code, so this is not a runtime bug in the series. It is an
incomplete conversion, or a message that needs narrowing.

2) "Functions that look up the same slot repeatedly now fetch it once."

Several converted functions still call the accessor twice for the same
index:

bpf_get_spilled_reg():

    (1 << bpf_stack_slot(frame, slot)->slot_type[BPF_REG_SIZE - 1]) & mask)
    return &bpf_stack_slot(frame, slot)->spilled_ptr;

bpf_mark_all_scalars_precise():

    if (!bpf_is_spilled_reg(bpf_stack_slot(func, j)))
    reg = &bpf_stack_slot(func, j)->spilled_ptr;

bpf_mark_chain_precision():

    if (!bpf_is_spilled_scalar_reg(bpf_stack_slot(func, i))) {
    reg = &bpf_stack_slot(func, i)->spilled_ptr;

The same pattern appears in states.c (propagate_precision,
iter_active_depths_differ, mark_all_scalars_imprecise) and verifier.c
(check_stack_write_var_off, get_constant_map_key, collect_linked_regs,
widen_imprecise_scalars). Only some functions, such as
print_verifier_state(), were changed to fetch once.

Should nfp_bpf_map_update_value_ok() be converted to bpf_stack_slot(), and
reg_to_target() given a note or helper for its address-range check?
Otherwise the changelog could be narrowed to match what the patch actually
does.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35909853278
--===============8478301700528267284==--
