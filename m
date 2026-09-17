Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991194457B4
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648187; cv=none; b=oD8MPyUtg6JTARcAbFDSZeHG/rJzB9pepetBGG4uSK3m2kakTR+5lQ0mszJ5/59pCXtOZ4vVIRUnMkYv0pZAkw575kKN0V9EW2AGXLMh0wzA4cgvN0NHApidk3XxFmgK/GMkW0ruDxL9ba1/UNpP6HZ16APdJr46YrI80+R5ZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648187; c=relaxed/simple;
	bh=qGQhmi5WmOTHC8Oy2CvcWjy+1fvtKDJSjGl0EYywXVM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d/uJpNtlPYY9QJmgYU1SWYXuj1ZxIpiWDNYh+xW5mO7LAjfvXtR8qlxVh+h3Dyu6/GcxWWheRabm4RkRa2C8ZBUEADkbYyuOvnd9Fl8tJuAYyuZQeV4jcoP8HhthoNBp7wRnmY7ZkFlZvlaHmkk0ISOnF7gjYfCV0rgfs6XfvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vms2a4z3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vms2a4z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0081A1F00898;
	Thu, 17 Sep 2026 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648169;
	bh=UYuu2HAzlU+Y/OpOucat2/sqd6N2AHuFuOCNmpY9xw8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Vms2a4z3zJ8aF73YoDcWlMy3FCq9BUOBNDLSgPckhxfKdJ9eRJ9nIfjNGp1g8x/QQ
	 e752DZt3Ki38WOx3ljX1OADb/sEBBJ8YPttfqdKPNovacDA2UEKykzqYvOl4IcYmzb
	 YJ0m4b9PtgnmgkM3SBwJlARM3yMU9925pzZN0n+RG9JJ0sVG80aAMKec0oyeL/LlP7
	 ICsfcLvQo8ElN7UB52Oo6c85zFarsmH3JcGO6caxrbSzGK+Sg9/TzOdkuKc+e+lyCE
	 HOhmlBRP2t2hydxHMNbxz+k2Sj1CshytTwWqBCe/O9OK3Oiipn1U0rMWTK3vWIIc54
	 ei8fA0PTFXvHg==
Content-Type: multipart/mixed; boundary="===============1783551769123132306=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa7824fae1e994283db3a4a81341a7d18f785098e655190dad549856fe1dfa9b@mail.kernel.org>
In-Reply-To: <20260917111127.3780880-5-memxor@gmail.com>
References: <20260917111127.3780880-5-memxor@gmail.com>
Subject: Re: [PATCH bpf v6 04/10] bpf: Apply CO-RE relocations before subprogram validation
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,eddyz87@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 12:29:28 +0000 (UTC)

--===============1783551769123132306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit dd4db8b6b10cf6508b55f2690d4135d2be05eac0
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
>     bpf: Apply CO-RE relocations before subprogram validation
>
>     check_subprogs() verifies that each subprogram ends in an exit or an
>     unconditional jump before in-kernel CO-RE relocations are applied. An
>     unresolved relocation can then replace that terminal instruction with an
>     invalid helper call. The resulting fall-through into another subprogram
>     breaks the CFG invariant used by postorder and stack liveness analysis,
>     which can write past their per-subprogram arrays.
>     Apply CO-RE relocations immediately after preparing the program BTF, before
>     subprogram discovery and validation. Keep func_info and line_info validation
>     after subprogram discovery because those records depend on the complete
>     subprogram layout.
>     Reject an ldimm64 first slot at the end of the instruction stream before
>     CO-RE can inspect its missing second slot. The regular instruction validation
>     already rejects this form, but now runs after relocation processing.

The changelog's description of what protects CO-RE from a trailing
ldimm64 first slot appears to misidentify which validation step provided
the pre-patch protection. Could the wording be clarified?

The text states "The regular instruction validation already rejects this
form, but now runs after relocation processing." That "regular
instruction validation" is check_and_resolve_insns(), which contains
this check at kernel/bpf/verifier.c:19225:

    if (i == insn_cnt - 1 || insn[1].code != 0 || ...) {
            verbose(env, "invalid bpf_ld_imm64 insn\n");
            return -EINVAL;
    }

But check_and_resolve_insns() already ran after relocation processing
before this patch too. In the pre-image, check_core_relo() was the last
step of bpf_check_btf_info(), and bpf_check_btf_info() is called before
check_and_resolve_insns() in bpf_check(). So the phrase "but now runs
after relocation processing" describes both the old and new orderings,
and doesn't explain why the explicit guard becomes necessary.

The check that actually protected bpf_core_patch_insn() from reading
insn[1] out-of-bounds pre-patch is check_subprogs(), which ran before
check_core_relo(). For a program whose last instruction is an ldimm64
first slot, BPF_CLASS(0x18) == BPF_LD, so at i == subprog_end - 1 the
terminal instruction test at kernel/bpf/verifier.c:3069:

    if (code != (BPF_JMP | BPF_EXIT) &&
        code != (BPF_JMP32 | BPF_JA) &&
        code != (BPF_JMP | BPF_JA) &&
        !insn_is_gotox(&insn[i])) {
            verbose(env, "last insn is not an exit or jmp\n");

rejected it unconditionally. That implicit protection is what this patch
removes by hoisting bpf_check_core_relo() above add_subprogs() and
check_subprogs(), and it's why the explicit guard at verifier.c:21202 is
needed.

The current wording can mislead a reader (or a stable-backport triager)
into thinking that bpf_core_patch_insn()'s out-of-bounds insn + 1 poison
write and insn[1] read were reachable before this commit and need
separate backporting. They only become reachable through the reordering
that this same commit introduces and guards.

Could the commit message state that check_subprogs() previously rejected
a trailing ldimm64 first slot before CO-RE ran, and that moving CO-RE
ahead of it removes that implicit guarantee?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35216153389
--===============1783551769123132306==--
