Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E34386544;
	Sat, 11 Apr 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918639; cv=none; b=HvXe9htTYfVAVDau6v0xb1EccoD5QJYfQe65YTJnE4sdFGEKGcwF9HrMrLbrdkRyoKEirMYOrtOS6i+4un5uhYrvyeRMpnuNM2Nn5t4z1zqgaYLMmnjNle1HSFuhAuWjamdFP2FxTkznZXwijNemldcaVTmbtg34hX9l5rEjrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918639; c=relaxed/simple;
	bh=57CK0l47W/yUIcext4eyuju0/nugILwSpCFYoiLQZ1w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qo1W5OHdzo4ouoUrOdtiN5AzD9S5Wc6WjuGVThxuEjtIIXruWA4NjfXVpZ5xGkXvvhCP8vdC19G2s1AqGim5b2+6EhOuZsAYIq4AuYuL5s0Zzgl/pqHJ7GgP8o0XTKak7e7jveB4b7mDRrW1SpWqGkzyp1HECRng4ECAmvSFr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVNETH1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVNETH1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF43C4CEF7;
	Sat, 11 Apr 2026 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775918639;
	bh=57CK0l47W/yUIcext4eyuju0/nugILwSpCFYoiLQZ1w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YVNETH1dUEX7yY7UewBlhZDFbFt/WffNDaRp7atNEDrAsN+cU2zTUdxljF1UAjRLJ
	 hwLGarf7aRIF6f0Ipxm58l/e4zZdrVrdv+Yl9s15V+qrjlHR8DSXHb87HBugMnDOOH
	 xSpKZo0ocgd+yWwmzjB31dvWG+IvO3IcbEmFeYXq8PCfGbM8dFggH8CKVnTYnISXLE
	 bsqA5sgzbWwQDveasfkEb3NTjILzQZ5z4hx0QZ08YhcrgW56tpf4AyCzXB6FRICbG+
	 39hHNRWBBmNMGTOkEh5mvjcUEViK9T7Pw+ieLQktr+Xfz357kHHSuHjaivQk10ZjwE
	 fC9z7IvBe5Udg==
Content-Type: multipart/mixed; boundary="===============3603684705991622016=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebe116b9417e77b2f1a7d0d9f07cd1fc5d162c23992fe35e84190c1ddbb3ed3c@mail.kernel.org>
In-Reply-To: <20260411133847.1042658-2-xukuohai@huaweicloud.com>
References: <20260411133847.1042658-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v13 1/5] bpf: Move constants blinding out of arch-specific JITs
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 14:43:58 +0000 (UTC)

--===============3603684705991622016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> leaving the global env->prog->insni and env->insn_aux_data untouched.

The struct field is insnsi, not insni. The same paragraph also says:

> this approach result in incorrect index for the insni array

Should this be "results in" and "insnsi"?

The commit message also refers to clean_insn_aux_data():

> it is freed by clean_insn_aux_data() at the end of bpf_check().
> Before freeing, clean_insn_aux_data() loops over env->insn_aux_data

The function is actually clear_insn_aux_data(), not
clean_insn_aux_data(). Searching the tree for clean_insn_aux_data
returns no results.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 066b86e7233c..3fa3c74869d0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1508,7 +1508,10 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
>  #endif
>  }
>
> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
> +/* Now this function is used only to blind the main prog and must be invoked only when
> + * bpf_prog_need_blind() returns true.
> + */
> +struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)

The BPF subsystem convention is for multi-line comments to have the
opening /* on its own line. Should this be:

/*
 * Now this function is used only to blind the main prog and must be
 * invoked only when bpf_prog_need_blind() returns true.
 */

[ ... ]

> @@ -1550,21 +1557,34 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)

[ ... ]

> +		if (env)
> +			env->prog = clone;
> +		else
> +			/* Instructions arrays must be updated using absolute xlated offsets.
> +			 * The arrays have already been adjusted by bpf_patch_insn_data() when
> +			 * env is not NULL.
> +			 */
> +			adjust_insn_arrays(clone, i, rewritten);

Same comment style question here.

[ ... ]

> @@ -2533,6 +2553,34 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)

[ ... ]

> +	prog = bpf_jit_blind_constants(NULL, prog);
> +	/* If blinding was requested and we failed during blinding, we must fall
> +	 * back to the interpreter.
> +	 */
> +	if (IS_ERR(prog))

And here as well.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 56fcc96dc780..0cca590915ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +	} else {
> +		if (err != -EFAULT) {
> +			/* We will fall back to interpreter mode when err is not -EFAULT, before
> +			 * that, insn->off and insn->imm should be restored to their original
> +			 * values since they were modified by __jit_subprogs.
> +			 */

Same comment style question.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24284268460
--===============3603684705991622016==--
