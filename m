Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505696;
	b=YXGnCAaI5d7mHcKIQjSd1RH959dCC5tbbsIJHZKflkOPI8eoVfrMEt1nqmKzjRY/1RlT
	 Y6RIvB7oB7zCQKsmv8Q/hgwJztUZRkXcD4dJkvii5QgbCyQtAjpBukhatybUE1IMcjwIj
	 O/7CFgIapbnjKnMG+QRieo6ChzD74Wwnx1OU6LsmAMYBz8joYhSmQRLp9x0lqlcYwcXSS
	 DGqVm9JQaqLENhj4sZGz6kj1AMFP+9digyHvpYEZ4xJrnHIseypEgl64uhdAAy0290K4O
	 Eh1FNT9PBM2BUp6VT8kmrU3u90upTqUOoySyD+XLMcxThWbAtHIjfhVmBfbiZ5fdXAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505696;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YIb1/60yiq3BE5CYoBMnetbl65jMTxxiurJw6dD4E5I=;
	b=3hWjUs90NnawXewucKiJgg7czkPjpRCenjq03L91z8yDcRgLd6rzyjUfN91sIA3LzzNp
	 3ADVHDI5zCxkdXxfzneJ5LRyshlWJJ3olBjJx/Vgj5qActsroeVdN8yZoaCLKNGDg/usO
	 TGbtsH1wdDPGa2RGmUzGNJIjWgldJYWJ5CsLzTMIoCrf2lNUvVfWCrhbZa/7zEoPBYruE
	 KUajgRMUgDeuG6rI98lvux9SQ2mjts0KNWLyQb0KaycjL4M1bIMjmn6ccEWhR3SdChRqq
	 3weMThzKAsGPewsGI099csc9WBYrXy2eE82VudHO0F41T+XjeZng4n2bu0UFIaboqXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BTxetl1/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF696606A338
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTxetl1/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A691F000C4;
	Thu, 12 Nov 2026 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505696;
	bh=YIb1/60yiq3BE5CYoBMnetbl65jMTxxiurJw6dD4E5I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BTxetl1/V29Sv3CcSwklfO7HWe3d+OtVFtAaT2sqrKp7uj7jyk5LkQYYtAOdeBqY9
	 4ZVXd3hscresWMVxSgTa4UCBLfPu7Q9ipL6vug3d8jEDU7MASNrgOL1fzCrhvuoFS7
	 MlFSTI1SS8CErbGZtTD97NWnDeikP3j+xdGEgnElkS7tB0AeaN6xhfyWBBvQX5INSm
	 AjpxRshdDB0UOObq0SFYyQIqa4KqLJdyHH2ZPvrRdfjqflV/elMhfESsj1aW21vF7j
	 i7KdZK4t76TrAhupHLcfPq8spsXIGh8KPY/hiJp/2do3QfOfs2ZGdLobn7Nap/i/GE
	 IY14aHy8MWtYw==
Content-Type: multipart/mixed; boundary="===============1902834181508043836=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <53b3e2c4c5932ab921b3980122dbbcecb52faefe4474dfa5fb07fe178abe72aa@mail.kernel.org>
In-Reply-To: <20261112164610.1917256-9-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 08/10] resolve_btfids: Don't list an error that follows work on an argument
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 17:48:15 +0000 (UTC)

--===============1902834181508043836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Don't list an error that follows work on an argument

TL;DR: On x86-64, a push of a pointer argument may make RSP count as "based",
so passing a local's address to a void callee could wrongly drop later errors
from the fmod_ret list.

> diff --git a/tools/bpf/resolve_btfids/text_flow.c b/tools/bpf/resolve_btfids/text_flow.c
> --- a/tools/bpf/resolve_btfids/text_flow.c
> +++ b/tools/bpf/resolve_btfids/text_flow.c

[ ... ]

> +/* Return the registers which hold a based pointer behind INSN, if BASED do before it */
> +static u32 transfer_based(const struct text_flow *flow, const struct text_insn *insn, u32 based)
> +{
> +	u32 defs = insn->defs;
> +
> +	/* endbr64, pause, the ud2 of WARN(): LLVM does not say what it writes. It may be nothing */
> +	if (defs == TEXT_ALL_REGS)
> +		return based;
> +	if (insn->kind == TEXT_CALL)
> +		return based & ~(defs | flow->arch->caller_saved);
> +	if (insn->kind != TEXT_OTHER && insn->kind < TEXT_BRANCH)
> +		defs |= BIT(insn->dst);
> +	if (insn->kind == TEXT_MOV_IMM || insn->load || !(insn->uses & based))
> +		return based & ~defs;
> +	return based | defs;
> +}

Can the stack pointer end up in the based set here?

On x86-64 the decoder reports push as TEXT_OTHER with load false, as the
self-test in text_mc_x86.c shows:

    T("50", TEXT_OTHER, .defs = BIT(RSP), .uses = BIT(RAX) | BIT(RSP)),  /* push %rax */

After "push %rbx", where rbx holds the pointer argument (GCC pushes
outgoing 7th and later arguments), insn->uses & based is non-zero, so the
last line returns based | defs and RSP becomes based.

Nothing clears it afterwards:

  - a call has defs 0 on x86 and RSP is not in caller_saved, so
    "based & ~(defs | flow->arch->caller_saved)" keeps it
  - "add $N,%rsp" and "sub $N,%rsp" read the based RSP, so they keep it

Then "lea 0x10(%rsp),%rdi" or "mov %rsp,%rdi" makes RDI based.  Passing the
address of a local (blk_finish_plug(&plug), finish_wait(),
destroy_timer_on_stack() and similar) to a void callee passes the
"pointers &= reach[i].based" filter in text_flow_solve() and is counted as
an effect.  transfer() then clears the facts there, and scan_func() drops
each error returned only after it.

This disagrees with what text_flow.h says based means ("computed from the
argument without a load, so it points into the same object"), since a stack
address does not point into the caller's object.  It also disagrees with
the rule in the commit message, and the list of things the tool does not
see does not mention this case.

The result is errors and targets lost on x86-64, not added, so an fmod_ret
program that the rule would allow is rejected.  arm64 is not affected
because SP is not among the modeled registers.

Would it make sense to keep the stack pointer out of the based set, for
example "return (based | defs) & ~stack_pointer" with an arch-provided
register, or to not propagate based to registers that a store only writes
back?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43267213382
--===============1902834181508043836==--
