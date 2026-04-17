Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344602BEFED;
	Fri, 17 Apr 2026 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457358; cv=none; b=SHlF3Np0OU4tnkGBb476PSA7QY7g1u3NZ6QVOTf+NXhcoKY0O51jlSnYPGL4P+859zahFOdZdw54tUzcKG2JJSsiNtH5y9xixQxtHZRF5mx5qAUJ6z3uFueNS6nWiAOjmTy892V68dfi965Do6eRnKjWfa7C5R99ZpEc3vi+kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457358; c=relaxed/simple;
	bh=IL6zTx+HOobx7dJe/hhBiNKwnu2bkwQuObg1FlHnvoc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y+QvjDp0J6VW9XU7zvdz6WaylKCpO9TBMOr20zgX5hK+VPFlS3DIuHE748FHfYsIHakCBiibDDn0smiR885mRv4K5oW5LNg9/Dk4qF4oLTCr0aUJKONiZQtE/f6dzHzUi74Yl2lpQT90v0LEKdWrvTEQOgaWSnJZQRcxtTry65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOdUoqOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOdUoqOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8BDC2BCB3;
	Fri, 17 Apr 2026 20:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776457357;
	bh=IL6zTx+HOobx7dJe/hhBiNKwnu2bkwQuObg1FlHnvoc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FOdUoqOoYO2gcvfPqxAOni6LX492xkdH6H6alTWxbewqNh4vVQ4dyO6eTDhEL401b
	 eaXejmY7Dmuhd3UUu0JARcxJHMc9w/xM+M512qCRXChczdYOcdddodCNY24YPuiTxc
	 QjeLVEpuOFc6J5RwCeBWkpgD7B83AVECOwEnP6jTluMzLyKG22UA3mhQ/RHowzjJ5i
	 AFxOA3kqyin1CZwUx22Ei07NrnKk32Xuq6jz6QTbLPK8l/Iw7UYpl/Op7vjhG2vI5w
	 Ao12+plWGJgy2OfmexcT+HzKc8q1EMvayeRCJORZoFQqQG6g9oSbF53wAOkjh4sstX
	 c3+Ucl8xp7azg==
Content-Type: multipart/mixed; boundary="===============3321761069462388994=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <271b995e13e83f4063fef240bbf4e1450c0706b9dfb5ed985aaa18c6196ea4c5@mail.kernel.org>
In-Reply-To: <20260417192502.194548-9-jolsa@kernel.org>
References: <20260417192502.194548-9-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 08/28] bpf: Add struct bpf_tramp_node object
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: hengqi.chen@gmail.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:22:37 +0000 (UTC)

--===============3321761069462388994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 50103b3794fb..b97d9f68fc40 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -827,14 +827,14 @@ static void bpf_trampoline_restore_args_stack(u32 *image, struct codegen_context
>  static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_image,
>  					 void *rw_image_end, void *ro_image,
>  					 const struct btf_func_model *m, u32 flags,
> -					 struct bpf_tramp_links *tlinks,
> +					 struct bpf_tramp_nodes *tnodes,
>  					 void *func_addr)
>  {
>  	int regs_off, func_meta_off, ip_off, run_ctx_off, retval_off;
>  	int nvr_off, alt_lr_off, r4_off = 0;
> -	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> -	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> -	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> +	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
> +	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
> +	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
>  	int i, ret, nr_regs, retaddr_off, bpf_frame_size = 0;
>  	struct codegen_context codegen_ctx, *ctx;
>  	int cookie_off, cookie_cnt, cookie_ctx_off;
> -	int fsession_cnt = bpf_fsession_cnt(tlinks);
> +	int fsession_cnt = bpf_fsession_cnt(tnodes);
>  	u64 func_meta;

[ ... ]

> @@ -906,7 +906,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	}
>
>  	cookie_off = bpf_frame_size;
> -	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> +	cookie_cnt = bpf_fsession_cookie_cnt(tnodes);
>  	bpf_frame_size += cookie_cnt * 8;
                                             ^^^^^^

Does this code compile? The refactoring renamed the parameter from 'tlinks'
to 'tnodes', but this call to bpf_fsession_cookie_cnt still passes 'tlinks',
which is no longer in scope. Should this be bpf_fsession_cookie_cnt(tnodes)?

>
>  	retval_off = bpf_frame_size;

[ ... ]

> @@ -1050,21 +1050,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>
>  	cookie_ctx_off = (regs_off - cookie_off) / 8;
>
> -	for (i = 0; i < fentry->nr_links; i++) {
> -		if (bpf_prog_calls_session_cookie(fentry->links[i])) {
> +	for (i = 0; i < fentry->nr_nodes; i++)
> +		if (bpf_prog_calls_session_cookie(fentry->nodes[i])) {
>  			u64 meta = func_meta | (cookie_ctx_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
>
>  			store_func_meta(image, ctx, meta, func_meta_off);
>  			cookie_ctx_off--;
>  		}
>
> -		if (invoke_bpf_prog(image, ro_image, ctx, fentry->links[i], regs_off, retval_off,
> +		if (invoke_bpf_prog(image, ro_image, ctx, fentry->nodes[i], regs_off, retval_off,
>  				    run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET))
>  			return -EINVAL;
>  	}

Did the for-loop's opening brace get dropped by mistake? The loop header
changed from:

    for (i = 0; i < fentry->nr_links; i++) {

to:

    for (i = 0; i < fentry->nr_nodes; i++)

The closing brace at line 1064 is still there, but now there's no matching
opening brace. This creates two problems:

1) The braces are unmatched, which should cause a compilation error.

2) If the compiler somehow accepts this structure, the loop body would
consist only of the first if-statement (the cookie handling), and the
invoke_bpf_prog() call at line 1061 would execute AFTER the loop completes.
At that point, i == fentry->nr_nodes, so fentry->nodes[i] would be an
out-of-bounds access.

The parallel fexit loop later in the file was correctly updated with both
braces preserved.

>
> -	if (fmod_ret->nr_links) {
> -		branches = kcalloc(fmod_ret->nr_links, sizeof(u32), GFP_KERNEL);
> +	if (fmod_ret->nr_nodes) {
> +		branches = kcalloc(fmod_ret->nr_nodes, sizeof(u32), GFP_KERNEL);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
--===============3321761069462388994==--
