Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FA399365
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865083; cv=none; b=kTJkHBhsohApG3D9um7x6zFeaWFXk7/JC1XlVjEmV0wKL8fTWZdBBHl9ueI+w/xEGOvUsOS4scdSnV2rWOYm2XbivwHCKXuJhjabgH54P511y8CBD0SKoA3P0H+rMcmhjh98uVx1itH3P/ckTYwfDm2x8qL9dlswl80OXA7qjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865083; c=relaxed/simple;
	bh=dRc+XQWITVaBQWNPZkzK0B99opncJxOUlWfouULJdOI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WAuLu6TQTmBF3tdQlGqkSh0dpUkrJ5J3ssQpHB3bjI3O1nkv4v7Y4o9GzeaeK5+AQrbA7rX+owsTmENnhmGQe9AyO7Kxcq9XTRhYRBP0DU8jUYyUre9ugNgMQsxM6dGE72NNDvPs426bujeA8uuwcmvt7uTZNynML5x7Zj+JkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvuN5oIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvuN5oIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0051F00899;
	Thu,  1 Oct 2026 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865077;
	bh=PyjbqLz+zkmqiGqeZILoYC95hyeZNtwkXAUs2vI2kR4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fvuN5oIEIFqkCJdB+fSI0bVyGNGBfVHlMp0F729zD7JK1CN5FpOutAdMQhsKg2JAC
	 NVNhnvolt8pleXafLjMUG09hBREBxQNWS4l1Eq/f8VF/HXkEBSG8yAcG8qLpbEka5c
	 Busz7OoSV7nERjMrDnzD5VHDpn7xIM20Q7dcBa/IBHl/EUhmoW+Nm4yt0tJ+lqqrgD
	 OWAdgvlI5VMB08DvafBGqkrCda3Lp6r5tO49sFNPTbYfpz8UEGZdq/5zSApKZMo1wG
	 QwwWCxliEzCMJmBQ5clMmvU6J1X4npE/hBGELEfdkZO29elJciM9itW2D1g3XQSu4i
	 4uUBPGu75BHJQ==
Content-Type: multipart/mixed; boundary="===============8208732037198948693=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b58f9d00b6f644f682dd854f6e70f63f9e7dcf21deed32913df3838bf0947b21@mail.kernel.org>
In-Reply-To: <20261001133103.1340994-1-yonghong.song@linux.dev>
References: <20261001133103.1340994-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 11/22] bpf: Dispatch cleanup pads by rewriting return addresses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 14:31:17 +0000 (UTC)

--===============8208732037198948693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Dispatch cleanup pads by rewriting return addresses

TL;DR: Design question, not a bug: bpf_exc_attach_main_prog() in
bpf_prog_jit_compile() builds a table for single-function programs that seems
never to be read, so it and its error paths could possibly be dropped.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index d813fdde29e3..60905643cb9c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -2632,9 +2633,14 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>  {
>  #ifdef CONFIG_BPF_JIT
>  	struct bpf_prog *orig_prog;
> +	int ret;
>  
> -	if (!bpf_prog_need_blind(prog))
> +	if (!bpf_prog_need_blind(prog)) {
> +		ret = bpf_exc_attach_main_prog(env, prog);
> +		if (ret)
> +			return ERR_PTR(ret);
>  		return bpf_int_jit_compile(env, prog);
> +	}
>  
>  	orig_prog = prog;
>  	prog = bpf_jit_blind_constants(env, prog);
> @@ -2648,6 +2654,12 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>  		goto out_restore;
>  	}
>  
> +	ret = bpf_exc_attach_main_prog(env, prog);
> +	if (ret) {
> +		bpf_jit_prog_release_other(orig_prog, prog);
> +		return ERR_PTR(ret);
> +	}
> +
>  	prog = bpf_int_jit_compile(env, prog);
>  	if (prog->jited) {
>  		bpf_jit_prog_release_other(prog, orig_prog);

this isn't a bug, but is the table that bpf_exc_attach_main_prog() builds
for a single-function program read anywhere?

It only attaches a table when there are no subprograms:

kernel/bpf/fixups.c:bpf_exc_attach_main_prog() {
    if (!env || env->subprog_cnt > 1)
        return 0;
    return exc_info_for_subprog(env, prog, 0, prog->len);
}

The only reader of the table that I can find is bpf_unwind_rewrite(), and it
returns at the first BPF frame before it does the pad lookup:

kernel/bpf/helpers.c:bpf_unwind_rewrite() {
    ...
    if (ctx->cnt == 1)
        return bpf_is_subprog(prog);

    rec = bpf_exc_pad_for_ip(prog, ip);
    ...
}

With no subprograms, the main frame is the only BPF frame, so it is always
the one with ctx->cnt == 1 and bpf_exc_pad_for_ip() is not reached for it.
The bpf_unwind() calls in such a program are already sent to their pad by
the jump that bpf_exc_patch_unwind_calls() inserts.

If that is right, could bpf_exc_attach_main_prog() and its two call sites in
bpf_prog_jit_compile(), with the new 'return ERR_PTR(ret)' paths, be dropped
so that bpf_prog_jit_compile() stays as it was?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096
--===============8208732037198948693==--
