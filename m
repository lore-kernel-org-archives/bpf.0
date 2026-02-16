Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CA271443
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239042; cv=none; b=OajPZJrW/JJpAzY6jSnNiGF0+0HC8fhwDPWCBoB1pkSr4WDJXJZ8+MRHvFrJbXqwzSCsLLD2tHSAbVxhA2sGdtMjH6UhzAV6+SMAgVqyFRZE8KcsEP+fbV5xl36T0/96jwKmExxi0WqZxGDhPdiPphGI/H56ExSvWwM1lYIa8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239042; c=relaxed/simple;
	bh=SlCa7iijd6YimdLQ8812y/Spgl/WvF8IFqOjV1zktiA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uqaZbdYO4klV/6XIOChCOUfiqcJb6OdIysMwtHgjJP+4gLJgEQh+wLyV551oBX5jJs2b/+sBt36lywQcJ7d7+AZ7uBxU/qqHdFSXJ701yuvNvOUl3erEqW3zj/8zEXizVCUHLCe4v4Vlj4PJfkldlDp1UyIkqG0TqVw/0bau4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBMTW5zK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBMTW5zK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B56C116C6;
	Mon, 16 Feb 2026 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771239042;
	bh=SlCa7iijd6YimdLQ8812y/Spgl/WvF8IFqOjV1zktiA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=bBMTW5zK5+cv4R3scVjmm91cPOGj1uakO+y+KT0nLKB+NlBO1KTXMMoCft3+rmV9T
	 Hja1V+HxZs5RYWjJMFyRmat/5TlBgZRgeeFQAjcotLKCdhTvxg4NvlvHnIKJ3AdHRO
	 Ppkr1LIOUi5xWpMCatwwPt2kYUCtpqiQs2BBQ8e3+uXBk3l7A3CChJtuqRDspa4ebV
	 lBYq9nfZe2MsB8jEPqJMNEodyVKmysipBt6iQOIrNPOFsrwwSZJloS+vLVAMt6YMOl
	 mjcXzayNvKN1eQ9N6D6QeNCTI2Rh637ZK1jFXWejWgpCr77uLU7EjyUhRUNUF9LKE+
	 g+zFB/WJnwI+A==
Content-Type: multipart/mixed; boundary="===============3828383631417245113=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0263fb1687612da60c26fc7ab569190aa94e7d6f9b3ebd23b80b4bbf7751c27e@mail.kernel.org>
In-Reply-To: <20260216152234.36632-1-adubey@linux.ibm.com>
References: <20260216152234.36632-1-adubey@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc64/bpf: Implement JIT support for private stack
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev,chleroy@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Feb 2026 10:50:41 +0000 (UTC)

--===============3828383631417245113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -140,6 +173,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	struct codegen_context cgctx;
>  	int pass;
>  	int flen;
> +	int priv_stack_alloc_size;
> +	void __percpu *priv_stack_ptr = NULL;
>  	struct bpf_binary_header *fhdr = NULL;
>  	struct bpf_binary_header *hdr = NULL;
>  	struct bpf_prog *org_fp = fp;

[ ... ]

>  	}
>
> +	if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {

On extra_pass (when jit_data->addrs is non-NULL), the local
priv_stack_ptr is still NULL because it was initialized to NULL above
and is never loaded from fp->aux->priv_stack_ptr. This means the
allocation will happen again on extra_pass, leaking the per-CPU
memory allocated during the first pass and overwriting
fp->aux->priv_stack_ptr with the new allocation.

Both the x86 and arm64 implementations load the existing pointer
before this check:

arch/x86/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    priv_stack_ptr = prog->aux->priv_stack_ptr;
    if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
    ...
}

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    priv_stack_ptr = prog->aux->priv_stack_ptr;
    if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
    ...
}

Is this missing a similar assignment before the check?

> +		priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
> +							2 * PRIV_STACK_GUARD_SZ;
> +		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
> +		if (!priv_stack_ptr) {
> +			fp = org_fp;
> +			goto out_priv_stack;
> +		}
> +
> +		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_size);
> +		fp->aux->priv_stack_ptr = priv_stack_ptr;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22059200816

AI-authorship-score: low
AI-authorship-explanation: The code shows human copy-and-adapt patterns from existing x86/arm64 implementations, with a characteristic human omission bug and copied pre-existing typo, inconsistent with typical AI code generation.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Per-CPU memory leak on extra_pass in bpf_int_jit_compile due to missing load of existing priv_stack_ptr from fp->aux before allocation check, affecting programs with subprogs using private stack on powerpc64.

--===============3828383631417245113==--
