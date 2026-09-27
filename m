Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8343BFAF2
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540825; cv=none; b=Vzz1RW70LcbXfZ31DA0V/xtGPfraHD5ZKOj4xgTGext/Op6U0MO9vZVNrx7Y3zLY+76PbwJR+8UL8GyX6Q4rDR4qcKimxbNtSm7EK8h6guIQDatQPdKM9DqsTQTNumGsw8bzPwjJ5Uw2tZq68YYnR+xi+4jduv9jUjjQRcfdu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540825; c=relaxed/simple;
	bh=DxduA3Q+HBlfUmr6nZU62u/OyFhg+PUNxXOyGsc4EgY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VE3XqpYaxmlypPqj5FShWgCL3lqvsB8UMW7aEgt8Ll4kFU3lt0DvA6ITu8WQtlugfu6kJJKhYO4THUAJpdFLSLHvuibjx+pmTZXqq9QuCIK/dkOxneb3yGoxVH0SvYi+UWzeGtTBQCUFErJvJXfLopHqbfF7o/NnNZ1cmrSgeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVj0cU5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVj0cU5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D6A1F00893;
	Sun, 27 Sep 2026 20:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540824;
	bh=uhXnzdAyb+gOP7Rdh0QMmEsoShv2wXLFCpsPDtSp634=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UVj0cU5lSFQgFGPSi2LJscIptkqnYjFikNjgYFewf9gLCkmyF2uUOPFaKrMkoYfYx
	 A4q/jc61IJKRCRbHoKFTaOvy9bJNPuSr5fCdpmZSL95auEhceMzOUOPQkYpEnORaJK
	 Ddz11j/E4DnNpk/VMtqudPwkemaQUsvl3I7B41FICOG7XAH6RTPaBXTf//4GIHVEdx
	 fkgS3Snn0UE+UhQ6AKPcuCu6kPzWwkzzC0mK5Gl0NO4Ev7d6WqnlQPy4svpcfyn48D
	 qbkrnaD9DPMvhFUMQBQQOyAf0DdQZRWQdgR2HLiK5ThjkIHQZAuqTFP8WNVZuPnJZq
	 yJubb5NGhCu8g==
Content-Type: multipart/mixed; boundary="===============6733957262452500444=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d5eed8a76106def474e99ba47cc8d71becf6e5c623e498c1359b147d864abe7b@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-4-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-4-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 04/36] bpf: summarize regs that may hold a frame pointer in insn_aux_data
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:27:03 +0000 (UTC)

--===============6733957262452500444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: summarize regs that may hold a frame pointer in insn_aux_data
>
> SCEV needs to know which registers might be stack pointers at a
> particular instruction. This information is used to invalidate SCEV
> expressions for slots that might be overwritten by indirect writes.
>
> liveness.c:compute_may_write_masks() already tracks this information.
> This commit modifies it to save the information in insn_aux_data for
> further usage.

Are these two claims accurate?

First, the changelog says compute_may_write_masks() already tracks which
registers hold frame pointers. Looking at that function, it only folds the
per-instance FM_MAY_WRITE and FM_LIVE_BEFORE frame masks into
aux->may_write_mask and aux->live_stack_before:

    half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
                       rel_mask(fm, i, FM_MAY_WRITE), nbits);

The register FP identity comes from the arg_track dataflow in
compute_subprog_args(), and that is where the new hook sits:

    record_stack_ptrs(env, idx, at_in[i]);

The patch does not touch compute_may_write_masks().

Second, the changelog states the information is used to invalidate SCEV
expressions for slots that might be overwritten by indirect writes. Looking
at the series up to commit 4a6395b27755, reset_scevs_at_indirect_writes()
in kernel/bpf/scev.c uses bpf_may_write_mask(env, idx) for that purpose,
not stack_ptrs.

The only reader of stack_ptrs is collect_store_base_regs(), added by
commit 7d5002bca1de ("bpf: avoid widening registers that hinder exact
stack-slot tracking"):

    base_regs &= aux[idx].stack_ptrs;

That code decides which loop-entry registers must not be widened because
they form stack base addresses for spills, fills and fixed-offset
stack-object calls. It does not invalidate SCEV expressions.

Should the changelog name compute_subprog_args() (the arg_track pass) as
the source and describe the widening-suppression use, rather than pointing
at compute_may_write_masks() and SCEV invalidation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============6733957262452500444==--
