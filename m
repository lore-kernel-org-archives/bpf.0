Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9E318140;
	Sat, 27 Jun 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573765; cv=none; b=WFcxMoKnqp4nBhFRx7rtLc1ApiYFfOAOFdz06PFJDWU5Mes4v5AJ3ZW9RqAwefx49T73YjhXF8yTZQ0O8aTWQtvoZoRcP+Xz0Ipy03CAusrlA0CzrtP7QCVPPhJLdnwVMcVZlkXZvylKK/7KV3mK0jnuPQqd1w49vFQIyhfg1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573765; c=relaxed/simple;
	bh=CmpZpF32Ys2IeyY0V5LPhc6y4MfJzmLlixQ1YmBa4EA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g2fHo5HKBmjt9TjMFY6hCEIbDb+7Iq9SzDfnk7A+UWAKTOFIJ+9fVUA8bYzq1VXiOa9i1s5/1QisTkyzUhR7wvV5bavu5YACqbVUDD15oMD/Ku5RWXdH+BjdXRsGD2w75bII4briQDZO5MRnv8ScmwjHnzmR6WU0A4KDbVDWZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK1SjaOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK1SjaOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AFA1F000E9;
	Sat, 27 Jun 2026 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573764;
	bh=NwTEUnrCFUvY6Yy3LeEz04BGojg8l3un5weQIU0Xh/Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lK1SjaOTdPciwcKTKWxB67HulywNVOfDX4abj7T562BSaviGU4PbBPlf7V3WZeDEX
	 5bi7eIJri3HR74N8XNp+Dewaj7luaki/f3ONrSiADoStW494s8s2PW/feSxDyirNdj
	 /djw8pN31ZAHR6tac5O37T0WwCXBNbG6fKfZMt/inL2SNGvt0vA0I7bTaTewnxpcFE
	 k90ouprhinW1zmPJUMAh76AjXIPCW6looV4zXEHprwXaoQ3Alx2L8tieGTY9frxxqd
	 lXYhiAjxF4DfQyOmGWTQkUoU1kevdQ85vi7k6ICYHEd6i0VS/tYlz6ICvOtsYA9/nw
	 hUf1c+SY+PWpQ==
Content-Type: multipart/mixed; boundary="===============5372712413806491987=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b6a647f04af08329aae672507276cad9030555dc6c1d25c9b2ed538318982728@mail.kernel.org>
In-Reply-To: <48943c5608280cade48d459ca15fd156c7470209.1782571533.git.xukuohai@huawei.com>
References: <48943c5608280cade48d459ca15fd156c7470209.1782571533.git.xukuohai@huawei.com>
Subject: Re: [RFC PATCH bpf-next 11/12] bpf, x86: Add JIT support SDT for probe
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,eyal.birger@gmail.com,rongtao@cestc.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 27 Jun 2026 15:22:44 +0000 (UTC)

--===============5372712413806491987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 054e043ffcd2..262f1bd74d53 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2797,6 +2797,16 @@ st:			insn_off = insn->off;
>  		}
>
>  		if (!jmp_offset) {
> +			int index = bpf_prog->aux->subprog_start + i - 1;
> +
> +			/*
> +			 * Emit a 5-byte NOP for SDT probe site, so it can be patched to
> +			 * a CALL instruction when observer program is attached.
> +			 */
> +			if (env->insn_aux_data[index].sdt_entry) {
> +				emit_nops(&prog, X86_PATCH_SIZE);
> +				break;
> +			}
>  			/*
>  			 * If jmp_padding is enabled, the extra nops will
>  			 * be inserted. Otherwise, optimize out nop jumps.

Can this dereference env when it's NULL?  The do_jit() function can be
invoked with env == NULL. The call path from bpf_prog_select_runtime() in
kernel/bpf/core.c goes through __bpf_prog_select_runtime(NULL, fp, err)
to bpf_prog_jit_compile(NULL, prog) and ultimately to
bpf_int_jit_compile(NULL, prog) -> do_jit(NULL, prog, ...) in
arch/x86/net/bpf_jit_comp.c.

This path is used by classic-BPF socket filters (net/core/filter.c in
bpf_prog_create), seccomp, and other internally-built programs that are
JITed without running the verifier. The code at line 2806 sits inside
the generic BPF_JMP|BPF_JA / BPF_JMP32|BPF_JA handling, reached whenever
a jump resolves to zero displacement (jmp_offset == 0):

net/core/filter.c:bpf_prog_create() {
    ...
    fp = bpf_prog_alloc(bpf_prog_size(new_len), 0);
    ...
    old_prog = bpf_migrate_filter(old_prog);
    ...
    *pfp = bpf_prog_select_runtime(fp, &err);
    ...
}

kernel/bpf/core.c:bpf_prog_select_runtime() {
    struct bpf_prog *err;
    err = __bpf_prog_select_runtime(NULL, fp, err);
    ...
}

cBPF->eBPF conversion emits BPF_JMP|BPF_JA instructions (net/core/filter.c),
so a program reaching do_jit with env==NULL can hit this branch and crash
the kernel.

The same function guards other env accesses against NULL: bpf_out_stack_arg_cnt(env, ...)
at line 1703 returns 0 if !env, and bpf_insn_is_indirect_target(env, ...) at line 1830
returns false if !env (kernel/bpf/core.c).

Also, when i==0 and subprog_start==0 for the main program, index becomes -1,
which is an out-of-bounds access into insn_aux_data[].

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28292842584
--===============5372712413806491987==--
