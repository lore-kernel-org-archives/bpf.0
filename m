Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515F3DDDA0;
	Thu, 12 Mar 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337823; cv=none; b=NOe8nVd0x6UlqK7efXxAvAwMb8MrUP1MYKU1hIJshG7VGjktatwNWU1tr/kCmaH36xxOmrWwrOOtA48Go2LpVN1DeshJ6t1EqiTFDMIp3nFiDQSpGTf5hxULG9cO6BNIO5RsJYoWL69NvLXJrbwcrSpFr07doS/OR1QCOQotVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337823; c=relaxed/simple;
	bh=7LHsz76bEPqqBt9H8LYH0PqAphw8gf+XDpTaqmgHOmI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hnlrfVR4ArLnc6p+v/UrCHNWsQHZ8tYNnyF7MJGHyQ2DL+4wlYAArdd8qWayQthxPJCHM/sTM3jq11hhxAV6WS1qKjc/BGoi/vNdwdb+mOJFdhiCAmr5DE6Gzsc3HQKA+NGwoEuiXNTCZ+OF/TN6W8IJSaB2c24q23H3KFGRzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5MfLluO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5MfLluO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46092C4CEF7;
	Thu, 12 Mar 2026 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337822;
	bh=7LHsz76bEPqqBt9H8LYH0PqAphw8gf+XDpTaqmgHOmI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Y5MfLluO4eYtVYnyRsyCg4YgMaE467xspw1/uiQe2SJreUpRoMggueZPG5j5w54io
	 3WOmwjGq6lyvPFvi5DwbaCAhnMOlpKUGghaWXTs9XvDrZzvtZslSbz3chuRz+2aA+T
	 qpSFAJ5gcYJu44pF1C5lrS3ADap7MIWLI7oEgZfvyNkk6B5CK6zUYNxoZJolKEHv1k
	 CG9BeD02oAmwoShQsfAhaVjqXXTLQiqH/QwEPOrnShxBYoWdSerxnzBRNpy3uYbgI6
	 IaEshcZZ4Y8MtsEOqPorJ5lamF7AftIP8NExndqjcldWd0XLsLh9dXPZWBt/wMFt5C
	 cTe61v1IpLI5Q==
Content-Type: multipart/mixed; boundary="===============1276411357989145504=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23f4b038b245167ff440b79c0a445fcbc12e0a102884759623dd59b3d64d2ade@mail.kernel.org>
In-Reply-To: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
References: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of arch-specific JITs
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Mar 2026 17:50:22 +0000 (UTC)

--===============1276411357989145504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..3ccefd13121b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22843,17 +22843,23 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>
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

When env is non-NULL, bpf_jit_blind_constants() uses
bpf_patch_insn_data() to insert blinding instructions.
bpf_patch_insn_data() calls adjust_insn_aux_data(), which expands
and shifts entries in env->insn_aux_data to match the now-longer
blinded program.

> +
>  	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {

[ ... ]

> @@ -23114,6 +23122,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	}
>  	kfree(func);
>  out_undo_insn:
> +	if (blinded) {
> +		bpf_jit_prog_release_other(orig_prog, prog);
> +		env->prog = prog = orig_prog;
> +	}
>  	/* cleanup main prog to be interpreted */
>  	prog->jit_requested = 0;
>  	prog->blinding_requested = 0;
> +	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
>  		if (!bpf_pseudo_call(insn))
>  			continue;
>  		insn->off = 0;
>  		insn->imm = env->insn_aux_data[i].call_imm;
>  	}

After bpf_jit_prog_release_other() reverts to orig_prog, this loop
iterates using the original program's indices and length. However,
env->insn_aux_data was expanded and shifted by bpf_patch_insn_data()
during blinding to match the blinded program's instruction count.

The call_imm values were saved at blinded indices (earlier in
jit_subprogs, after the bpf_jit_blind_constants call), so reading
them back at original indices gets the wrong aux data entries.

On !CONFIG_BPF_JIT_ALWAYS_ON configs, could this cause incorrect
imm values to be restored into pseudo_call instructions, breaking
interpreter fallback?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23013190773
--===============1276411357989145504==--
