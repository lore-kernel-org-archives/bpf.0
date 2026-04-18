Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D333DEE1;
	Sat, 18 Apr 2026 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492656; cv=none; b=bJjxn9D509iKXwAXT6grVV5n5e9CP4SPHQuQR6XFKycpZekWI5LzUVJfCc6FM6PJZXBMX5SGkbM/LOxJDU5BNf/4IfngOrEbp7scrhCaXkwSOWEBv95+JdWvt9wWqO5T/+LDbxywOCkI/auUNJYOpXZy9c+rPGPO9I/ocdl7XsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492656; c=relaxed/simple;
	bh=N2w9KxITu7o0+fF+CFZgSW4dW0rEG9H6bkWLGeU+cBo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c70g9MWzvtt2w1lKAIoySXPwEMMLz9WXu9ehtBIhjI0/dzG3ZNwb5aLWco3ATcOhZD0AYSMKDg2BEzbf1KbtUr8eZOfH0n8CQJnjaodcFYODJMk53vCNooVoYbDXZCr4cIu+iB3/j+0AguGwuj2lTjnUEvWBBrj6xLeC8UEF80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlbVlMLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlbVlMLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91BFC19424;
	Sat, 18 Apr 2026 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492656;
	bh=N2w9KxITu7o0+fF+CFZgSW4dW0rEG9H6bkWLGeU+cBo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BlbVlMLdtbwjlBsFCT2MogysbdhBuE8cQP+8x0PaSgud83d5vLZgEYxb8CQff+g1s
	 eXcBpa0nTVAYAeAo+CN3z5ZXH5sbwXARJc7V0rwE/GwFLtsduN+ulKCpWL8IQZ3qzV
	 Zob6FHq5EkDSPDDdgWcKeISWFsktrZNEkN3jBTla+aAUrtMTIjaS/AtBMN7qklsQ7d
	 pRnxquyK9cH8GVZsEtcMlqL6Nh6i3IhBn6UWGSpjrf/1FaUSykeUznCd0eBETgM71B
	 Xew3KGXQ5N5rC+3YJ9cO1WX2RH7po98aZc8f1uoolifrf2jVHFA/rSvUrv/x7QWNaf
	 4VhV/VXcylTew==
Content-Type: multipart/mixed; boundary="===============3286668933274039727=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb38d0f3976f2225ae9781d2292bb79f4d787183360f050c08de3b4490790974@mail.kernel.org>
In-Reply-To: <20260417192502.194548-9-jolsa@kernel.org>
References: <20260417192502.194548-9-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 08/28] bpf: Add struct bpf_tramp_node object
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: hengqi.chen@gmail.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:55 +0000 (UTC)

--===============3286668933274039727==
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
                                            ^^^^^

This line wasn't actually updated in the diff. The parameter was renamed from
tlinks to tnodes, but this call site still references the old name. Does this
compile?

The same issue appears later in the function:

>  	cookie_off = bpf_frame_size;
> -	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> +	cookie_cnt = bpf_fsession_cookie_cnt(tnodes);
                                              ^^^^^

This line also wasn't updated and still references tlinks.

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

The opening brace after the for-loop was removed but the closing brace at the
end remains. This creates two problems:

First, the for-loop now only controls the inner if statement checking for
session cookies. The invoke_bpf_prog call is no longer inside the loop and
will only execute once (with whatever value i holds after the loop exits),
instead of being called for each fentry node.

Second, the unmatched closing brace at the end creates a syntax error.

The code structure should be:

    for (i = 0; i < fentry->nr_nodes; i++) {
        if (bpf_prog_calls_session_cookie(fentry->nodes[i])) {
            u64 meta = func_meta | (cookie_ctx_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);

            store_func_meta(image, ctx, meta, func_meta_off);
            cookie_ctx_off--;
        }

        if (invoke_bpf_prog(image, ro_image, ctx, fentry->nodes[i], regs_off, retval_off,
                    run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET))
            return -EINVAL;
    }

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============3286668933274039727==--
