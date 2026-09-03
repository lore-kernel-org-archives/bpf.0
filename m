Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB04CB8CC;
	Thu,  3 Sep 2026 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448704; cv=none; b=LW9Z9jjRXt5x5ILNOaTXDvn6wGGutZcYuKQbKKvIMJeg0e569YPq2m9FRmbvJ2FwjMkrMSnwkYpzzQqBN+kpWGGrHzazED56HVxKLSrxv+L2d4UXOiFA0haGREn50ZnpQ3NaEcfEE2Z2JEmZqDOc9DlhSfZr+YzA0XBvyb7IBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448704; c=relaxed/simple;
	bh=K+3XtnaLaBRlMJPB0HqYncegYf6uuHGpL2ye+UaIzDI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RNSv/EZaq4PACdO2lfyQ3UfklEpbADeNQARUhop0lOgLAIATPpA7KeimxyfvQNw00lO5jcTtHuna+u7FdImsnWXRLx2Ww1kfqk4f2qENoUGtOPryklHIy69jX6eEXjsejUg7TaARDMPs0lJnn+MXzWySyU5GDcAHllGj4ajohQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOdy5/tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOdy5/tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520051F000E9;
	Thu,  3 Sep 2026 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448701;
	bh=KS7VzY6XVTvxoOS9vBIQvuzrq/thBiw/e/tBSedfwmo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JOdy5/tpltyrZGwwrgKdAos529q42Romwrzx1S77tZZWW3zvQy2MLldaPo1JOBzL0
	 dL6uH1IKQvQEol/cW1331WXNgzlBXV5NR46qgrj/rw6zxLdo0X2WtkWMsqzLYNhxKU
	 osxvFrTu9i7yF+zmcqyiDhSPjUfiOAEh+VADvGFFuLG0U8dJu5qB9USUNRjvBXtmlb
	 1jrmNda2AXO2dX5xN4faERvPn96/FxMad2o0y07p9oalKimCc/jFkXfN+mDjF7gp6i
	 /gbwiUPW1VG1POpWaAVYkNXRSKYIxctVdGUcKaekJalJPQKp3ajYsnG5d5yr3ek8lZ
	 ffiscBSfjjJ/g==
Content-Type: multipart/mixed; boundary="===============7840538112734453755=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aaaee75404be1c0851e0da15b1f2903eb6bf768bc2e763fcfa5a1d45e1ffc498@mail.kernel.org>
In-Reply-To: <20260903-kasan-v9-4-2407fe99255a@bootlin.com>
References: <20260903-kasan-v9-4-2407fe99255a@bootlin.com>
Subject: Re: [PATCH bpf-next v9 4/8] bpf, x86: emit KASAN checks in x86 JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:18:20 +0000 (UTC)

--===============7840538112734453755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The main instructions being targeted are BPF_ST, BPF_STX and BPF_LDX,
> but not all of them are being instrumented:
> - if the load/store instruction is in fact accessing the program stack,
>   emit_kasan_check silently skips the instrumentation, as we can already
>   benefit from guard pages to monitor stack accesses.
> - if the load/store instruction is a BPF_PROBE_MEM or a BPF_PROBE_ATOMIC
>   instruction, we do not instrument it, as the passed address can fault
>   (hence the custom fault management with BPF_PROBE_XXX instructions),
>   and so the corresponding kasan check could fault as well.

This isn't a bug, but could the changelog be more precise about where
the stack-access skip happens?

The text says emit_kasan_check() "silently skips the instrumentation"
for stack accesses, but the decision is actually made in do_jit() by the
new accesses_stack_only test:

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
    insn_idx = i - 1 + bpf_prog->aux->subprog_start;
    accesses_stack_only =
        env ? !env->insn_aux_data[insn_idx].non_stack_access :
              false;
    ...
}

which reads the verifier's per-instruction non_stack_access flag set by
mark_non_stack_access() at kernel/bpf/verifier.c:6665.

emit_kasan_check() only skips when the address register is literally
BPF_REG_FP or BPF_REG_PARAMS. The list also omits BPF_PROBE_MEM32
(arena) accesses, which are handled by separate case labels and likewise
left uninstrumented.

[ ... ]

> @@ -1914,6 +2032,10 @@
>  		EMIT_ENDBR();
>
>  	ip = image + addrs[i - 1] + (prog - temp);
> +	insn_idx = i - 1 + bpf_prog->aux->subprog_start;
> +	accesses_stack_only =
> +		env ? !env->insn_aux_data[insn_idx].non_stack_access :
> +		      false;

This isn't a bug, but would a positively named predicate read more
directly here?

When env is NULL the fallback value false means "this access is not
stack-only", so every load/store takes the !accesses_stack_only path and
calls emit_kasan_check(), which immediately returns 0 because of its own
if (!env) return 0; guard at arch/x86/net/bpf_jit_comp.c:1129.

The intent (no instrumentation without a verifier env) is expressed
through a double negative plus a second guard in the callee. Would
accesses_stack_only = !env || !env->insn_aux_data[insn_idx].non_stack_access
(or a want_kasan_check predicate) make the no-env case self-evident and
drop the redundant callee check?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33766012402
--===============7840538112734453755==--
