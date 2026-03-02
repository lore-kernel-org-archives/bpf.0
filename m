Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5C350A1F;
	Mon,  2 Mar 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448403; cv=none; b=FnKM1nC/cPzJtma+6XPkilSI2ZZURMC7GsCBSb7A9hothC786mBC2rXVPGC+1yh2VJXYGh1Go48lbOHZW+Di+5cv4fDyx8acxKj94tqDLgUMCCHT2PHw6gwUYevcJxvYUAdfNY/w6Xf5kO+yMvo+49KsGbIg5M5lHaKq8a8Rdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448403; c=relaxed/simple;
	bh=mRfUlHrS586k2FuQiBvSGHu6OuLzbXNHA5neBpISxiM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tTpUPS6P1USHXlzY2CBvOYyVqRV2bXTxb9tzYCJpCM1Qu98nWx/XZcqEfARrgT6cJh9zDEmphVQVLkJYSOHdTh9dM8MYLH0/uV5voBkmYOC6nMEpdHCeb6AILJwjBObxm8+8QP9A/cm43wVadC+cHJgkGH3nMU+TVFjBeJrcuhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQQLhZbo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQQLhZbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A53C19423;
	Mon,  2 Mar 2026 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772448403;
	bh=mRfUlHrS586k2FuQiBvSGHu6OuLzbXNHA5neBpISxiM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WQQLhZbo0Xgxn3IvHIU9hbySnqnUuWRbCx+Ts3KIxJM3/gYsRP1Tx9d6jBg2X++Eb
	 eEMPO0rmguDM3XcBAXTmPyVTv2GxPAwxs0zInEwUXLTsRpA78uCMFLLS4mdufL3+bf
	 osUSeG54d8M3Ecsn8FUdHGq6EKh+/jdULGbOIFoV2+BkvfHxcE88yvzmw8bzA/RsCS
	 gscgRxbD/HcRfAkA+Ypxpgzwso5ulC1WmeIFSV9C8c22AOMKAQheH6258IfGXamQsC
	 1p2LldK+SFZITq0rKRIo8UGCGOwggtZZzO6zF7ezKSEBLNu+5wUtjHvQ7LUDCYwWzo
	 abiDzpTxQqJjA==
Content-Type: multipart/mixed; boundary="===============2186911870242448320=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cae8a7cfe54f2f1f66bde10df2026eb2c1076998bef9e483b513abd3bb5722c3@mail.kernel.org>
In-Reply-To: <20260302102726.1126019-2-xukuohai@huaweicloud.com>
References: <20260302102726.1126019-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Move JIT for single-subprog programs to verifier
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 10:46:43 +0000 (UTC)

--===============2186911870242448320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fc4ccd1de569..ab2bc0850770 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -26086,6 +26086,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  		convert_pseudo_ld_imm64(env);
>  	}
>
> +	/* constants blinding in the JIT may increase prog->len */
> +	len = env->prog->len;
> +	if (env->subprog_cnt == 1)
> +		env->prog = bpf_prog_select_jit(env->prog, &ret);
> +
>  	adjust_btf_func(env);
>
>  err_release_maps:

[ ... ]

> @@ -26111,7 +26116,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  err_unlock:
>  	if (!is_priv)
>  		mutex_unlock(&bpf_verifier_lock);
> -	clear_insn_aux_data(env, 0, env->prog->len);
> +	clear_insn_aux_data(env, 0, len);
>  	vfree(env->insn_aux_data);

Can the len variable be stale when reaching clear_insn_aux_data()
through an error path?

At the top of bpf_check(), len is first assigned as:

    len = (*prog)->len;

This original value is used to allocate insn_aux_data. Later,
instruction rewriting passes like convert_ctx_accesses() and
do_misc_fixups() can change env->prog->len and resize
insn_aux_data to match via bpf_patch_insn_data().

The second assignment added by this patch:

    len = env->prog->len;

is only reached on the success path, after all instruction
rewriting and after the maps/btfs allocation. If an error occurs
between the rewriting passes and this reassignment, for example
bpf_vlog_finalize() returning an error, copy_to_bpfptr_offset()
failing, or kmalloc for used_maps/used_btfs failing, the code
jumps to err_release_maps and eventually reaches
clear_insn_aux_data(env, 0, len) with the original program length
rather than the current post-rewriting length.

If rewriting increased env->prog->len (the common case for
programs with context accesses), the iteration stops short of
the actual insn_aux_data size, potentially leaking jt fields in
the unvisited entries.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22571297111

AI-authorship-score: low
AI-authorship-explanation: Standard kernel refactoring by a known BPF contributor with non-native English patterns in the commit message.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Stale len variable in bpf_check error paths can cause insn_aux_data jt field memory leaks when instruction rewriting changed prog->len before an error between rewriting and the len reassignment.

--===============2186911870242448320==--
