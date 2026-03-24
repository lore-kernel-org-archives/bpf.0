Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED92E975E;
	Tue, 24 Mar 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356365; cv=none; b=qkY4jwNUCH/gFhtPolpfidea8KWGwsMVkY6TWbefokfWC6WxDx9WD8epnkoIsRlSomU9PVMX9QVgtbtNMgPkNxRi666boyjRnExds/Ge/O/eo70phs8fb1K0NnrmSJrmTmpiW0gTB+mHPQJ273WYwZy9kpqqbHaa6FWWS3rPD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356365; c=relaxed/simple;
	bh=7v2y5R7yJ+aJsFUsyYdAnXA4i1XNAA7BioxYMzzceMY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=usEhZDxYq4/H9BFTl7mNcVEz45HukCkaG+c167X9WKCpt83p6OcCCNk9U6mHNz3QYkV4G5KU6reN5CGb9zwe+frn28gZH9Q+JvaOxjvroC2YFNltg+mEy7f2DODF+AJvuLapgY2ZYImWrbS/AOLH1j9HM4eGt/w9vSuB+RgTQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpUp9+0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpUp9+0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAE0C19424;
	Tue, 24 Mar 2026 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356365;
	bh=7v2y5R7yJ+aJsFUsyYdAnXA4i1XNAA7BioxYMzzceMY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hpUp9+0q79/nhSZp/N+0EmJv88hJup8Y83RJNwgl83DCCVzJel2/YgZ4f+S85T+O+
	 RNoskRd5pFp1FIaDU1vjaP1erzeMG3f9VX9c6D1bWjkfnhdZgWS/KYOdvScUDLnUuL
	 sXoohTFcfHrSvK1mVU81EC1bxivfCUTgir/fYcqppOvTCYZbzQVBncSMlbd+QCn2Ig
	 3vyll3UYkh/pfMVCmBtV7Jn/ei7HOSprPLGK7Vf7NLVTKYiIZLx9nXu6fd9dheHiNE
	 iYokbijN5Lus10fk67m5gJ4E4k7S+g5PDUgd6Daz3b8BKwHMloPC8eXKjm3P0qgUOH
	 xROe/dROsk7iA==
Content-Type: multipart/mixed; boundary="===============5284341796206288996=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <edfa617891aa2e2980ecfb8037a7a4ed069e518bbce1777e331c737024feb1da@mail.kernel.org>
In-Reply-To: <20260324122052.342751-2-xukuohai@huaweicloud.com>
References: <20260324122052.342751-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v10 1/5] bpf: Move constants blinding out of arch-specific JITs
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 12:46:04 +0000 (UTC)

--===============5284341796206288996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 67eb12b637a5..8f52f4b6c3af 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -1507,13 +1507,16 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
>  #endif
>  }
>
> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
> +struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
>  {

[ ... ]

> -		tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
> -		if (IS_ERR(tmp)) {
> +		if (env)
> +			tmp = bpf_patch_insn_data(env, subprog_start + i, insn_buff, rewritten);
> +		else
> +			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);

When env is non-NULL, bpf_patch_insn_data() adjusts env->insn_aux_data
via adjust_insn_aux_data() and env->subprog_info via
adjust_subprog_starts(). This shifts subprogram start positions to
account for the expanded instructions.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cd008b146ee5..1b2b99f2d859 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

>  static int jit_subprogs(struct bpf_verifier_env *env)
>  {
> -	struct bpf_prog *prog = env->prog, **func, *tmp;
> +	struct bpf_prog *orig_prog = env->prog, *prog, **func, *tmp;
>  	int i, j, subprog_start, subprog_end = 0, len, subprog;
>  	struct bpf_map *map_ptr;
>  	struct bpf_insn *insn;
>  	void *old_bpf_func;
>  	int err, num_exentries;
> -	int old_len, subprog_start_adjustment = 0;
> +	bool blinded = false;
>
>  	if (env->subprog_cnt <= 1)
>  		return 0;
>
> +	prog = bpf_jit_blind_constants(env, NULL);
> +	if (IS_ERR(prog))
> +		return -ENOMEM;
> +	if (prog != orig_prog)
> +		blinded = true;

[ ... ]

> +	if (blinded) {
> +		bpf_jit_prog_release_other(orig_prog, prog);
> +		env->prog = prog = orig_prog;
> +	}
>  	/* cleanup main prog to be interpreted */
>  	prog->jit_requested = 0;
>  	prog->blinding_requested = 0;
> -	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> -		if (!bpf_pseudo_call(insn))
> -			continue;
> -		insn->off = 0;
> -		insn->imm = env->insn_aux_data[i].call_imm;
> +	/* we already rolled back to the clean orig_prog when blinded is true */
> +	if (!blinded) {
> +		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> +			if (!bpf_pseudo_call(insn))
> +				continue;
> +			insn->off = 0;
> +			insn->imm = env->insn_aux_data[i].call_imm;
> +		}
>  	}
>  	bpf_prog_jit_attempt_done(prog);
>  	return err;

When blinded is true, the rollback restores env->prog to orig_prog, but
env->subprog_info still holds the shifted start positions from blinding
(adjusted by adjust_subprog_starts() in bpf_patch_insn_data()). The
commit message states "env->insn_aux_data and env->subprog_info are no
longer used after JIT failure." However, on configurations without
CONFIG_BPF_JIT_ALWAYS_ON, fixup_call_args() falls through to the
interpreter fixup loop after jit_subprogs() fails:

fixup_call_args() {
    err = jit_subprogs(env);          /* fails, e.g. -ENOTSUPP */
    ...
    for (i = 0; i < prog->len; ...) {
        ...
        depth = get_callee_stack_depth(env, insn, i);
    }
}

get_callee_stack_depth() computes a target address from orig_prog's
original instruction offsets and calls find_subprog(env, start). Since
env->subprog_info start positions were shifted by blinding but the
instruction addresses are from the unblinded orig_prog, find_subprog()
fails to find a matching entry and returns -ENOENT, triggering a
spurious "verifier bug" warning and rejecting the program.

Could env->subprog_info be restored alongside the prog rollback, or
could jit_subprogs() return -EFAULT when blinding was active to skip
the interpreter fallback path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23488858455
--===============5284341796206288996==--
