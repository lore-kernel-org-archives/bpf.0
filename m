Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152343C7A4
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629880; cv=none; b=tANOQADWT8wa7uXpl7Gjgg4VW7d9UdEdlv1+Q7FHL/opsKZspNzVXYQGjpAV0ywnUFr4ASkOzOf8pRy1smhh7QHeVS48yh/l/ixcY3vCyW0xaXE2ztiTwryusiByXML/7Z/nsCsjxjjhfowXk5esv79Mxwsu1xHWgxml9+L07VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629880; c=relaxed/simple;
	bh=HhMQdDpdJ4aiR0FEEcorPDP0mpgjdWdCBdel1ayrG44=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fOK7/E4HeMgteZcRSbh4ikC5K/KRPkAemvEigxLNuoWPHHopH5psTcP/Zq8udCsTdvTjdVOFGYYIyWvvzhB8qiL40XFMW2BJd2j1t/C9nQCLxXK/SzsSwN3KBkucAV0tG6uZYpL5zVz/O9D+mVX0/mjpi+AY91LZPUeIo0eyVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh8x446+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh8x446+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585F91F000FF;
	Mon, 28 Sep 2026 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790629879;
	bh=Y9gFnT1QA1uZcIMvz1HKCAaupy9YBO3hvbcWrxm80Fk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bh8x446+xrBir6ruLZ7YOZqUTNeaX1qZk29dTJX60niciSwN5N45CKAgJ9LZ7Ziiv
	 kSyV41Dzk8bx6lF+juuHTbJGkqdY0KPfRqJxS2Vek0UkDoNJ56MNMthTGEFV8JlT58
	 CS7Lj4JXS3nkU/xylk43wHCkkhbnL8lCNcKWJ8RkfsMZ18T/4uAEN7kZ0wEgNcA5jW
	 LiAUiFq+LUN1qtfTCSQpdxNtNrIQ800lpS8cKR4Xk9ufb+YSVbOMksCAES2/5S2B0s
	 FB8k5txxKfOPDWgyv4kixqfZV0i+gAZYw/68UrubR0SBZ0r+07IrIkYpPvSNocfFQb
	 84mBl0XVcuhdQ==
Content-Type: multipart/mixed; boundary="===============1712620672654090282=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <347f689699a63771b3be60c747063acb8dae433d2d7c1cde09a9d5dfe8e2ab35@mail.kernel.org>
In-Reply-To: <20260928202643.9114-7-emil@etsalapatis.com>
References: <20260928202643.9114-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 6/7] bpf: Support per-call-site kfunc specialization
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 21:11:18 +0000 (UTC)

--===============1712620672654090282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cbae5d05fe7..7bdbda7764c7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8183a8f22ed5..8ba831329ab7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22062,6 +22065,56 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>  	return 0;
>  }
>
> +static int add_kfunc_desc_target(struct bpf_verifier_env *env,
> +				 const struct bpf_kfunc_desc *target_desc,
> +				 u16 base_desc_idx, u16 *desc_idx)
> +{
> +	struct bpf_kfunc_desc desc = *target_desc;
> +	struct bpf_kfunc_desc_tab *new_tab;
> +	struct bpf_kfunc_desc_tab *tab;
> +	struct bpf_prog_aux *prog_aux;
> +	u32 i;
> +
> +	prog_aux = env->prog->aux;
> +	tab = prog_aux->kfunc_tab;
> +
> +	if (WARN_ON_ONCE(base_desc_idx >= tab->nr_base_descs))
> +		return -EFAULT;
> +	if (WARN_ON_ONCE(tab->descs[base_desc_idx].func_id != desc.func_id ||
> +			 tab->descs[base_desc_idx].offset != desc.offset))
> +		return -EFAULT;

This isn't a bug, but would verifier_bug_if() be a better fit for these
sanity checks?

Looking at bpf_fixup_kfunc_call() a few lines below, the
descriptor-not-found case uses:

  verifier_bug(env, "kernel function descriptor not found for func_id %u",
               insn->imm);
  return -EFAULT;

verifier_bug() writes the reason to the verifier log and only WARNs under
CONFIG_DEBUG_KERNEL. A bare WARN_ON_ONCE() warns on every kernel and leaves
the log with no explanation for the -EFAULT.

> +
> +	if (tab->descs[base_desc_idx].addr == desc.addr) {
> +		*desc_idx = base_desc_idx;
> +		return 0;
> +	}
> +
> +	for (i = tab->nr_base_descs; i < tab->nr_descs; i++) {
> +		if (tab->descs[i].func_id == desc.func_id &&
> +		    tab->descs[i].offset == desc.offset &&
> +		    tab->descs[i].addr == desc.addr) {
> +			*desc_idx = i;
> +			return 0;
> +		}
> +	}
> +
> +	if (tab->nr_descs == MAX_KFUNC_CALL_DESCS) {
> +		verbose(env, "too many different kernel function call targets\n");
> +		return -E2BIG;
> +	}
> +
> +	new_tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
> +			   GFP_KERNEL_ACCOUNT);
> +	if (!new_tab)
> +		return -ENOMEM;
> +	tab = new_tab;
> +	prog_aux->kfunc_tab = tab;
> +
> +	*desc_idx = tab->nr_descs;
> +	tab->descs[tab->nr_descs++] = desc;
> +	return 0;
> +}

[ ... ]

> @@ -22082,9 +22135,11 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> +	struct bpf_kfunc_desc desc_copy;
>  	struct bpf_kfunc_desc *desc;
>  	unsigned long call_imm;
> -	u16 desc_idx;
> +	u16 base_desc_idx, desc_idx;
> +	bool near_call;
>  	int err;
>
>  	if (!insn->imm) {
> @@ -22104,13 +22159,17 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     insn->imm);
>  		return -EFAULT;
>  	}
> -	desc_idx = desc - env->prog->aux->kfunc_tab->descs;
> +	base_desc_idx = desc - env->prog->aux->kfunc_tab->descs;
> +
> +	near_call = !bpf_jit_supports_far_kfunc_call();
> +	desc_copy = *desc;
> +	desc = &desc_copy;
>
>  	err = specialize_kfunc(env, desc, insn_idx);
>  	if (err)
>  		return err;
>
> -	if (!bpf_jit_supports_far_kfunc_call()) {
> +	if (near_call) {
>  		call_imm = BPF_CALL_IMM(desc->addr);
>  		if ((unsigned long)(s32)call_imm != call_imm) {
>  			verbose(env, "address of kernel func_id %u is out of range\n",

The same question applies to the WARN_ON_ONCE() in bpf_add_kfunc_call()
which checks `tab->nr_descs != tab->nr_base_descs`.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36480760039
--===============1712620672654090282==--
