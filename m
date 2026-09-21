Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFA2E6CB8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027802; cv=none; b=tzlSbSamuwSNeT2Gs92h2AdblSDMyQLvos9v71VgvFIKsBpjwk8oDcv+iNEMLAvrjDc35OA5tBXU8J29BTDO7kwdDYTBgTMtDenswv9mzuFscIKnB1SwdgYIhoVqbpPkkuQBNFaGOSCE3gQgkOGKycwhKjZhTWzKuLMPh6ZJQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027802; c=relaxed/simple;
	bh=Y4d7nNsd7D3/9jMUHwzziuY/TIgXk473Z6diLSk91j0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f8RBJ7CyIHvZp1q1Fj+7IzBDAa0+LB35FuIQKYCEpGy0ycuXNV4cgtm7oxG/R30IgfNfUU1WhomRh1yb4x91IF7LK56h6Cyo96mKRZbTiQ+RjWEy+J6ikm/UkZcluyIXxYDCoUztPn7YsjIHcqucGLONythG3sLbkbpL8FGFEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvzEAmKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvzEAmKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A41F000FF;
	Mon, 21 Sep 2026 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027800;
	bh=ctvH2/bDhiAwe3vaAtfoUXDgs1MRE/3LuoHM0L5jK50=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gvzEAmKOZ/nTQx8bG9fq9YAAOM7ZWWvSekIca2dwzpGzwRZj5U7BHjbFGpp5Uies8
	 6a8pF5K2Bvna+uB4G3hPm6Mkq9B8fKXSYpDx+15Dlqei2GRDDy48hl1b5Ldbiutr3/
	 1D2FRkaJQLbKe9qbTewwo2QbV8ysboXkTBTjLrududWMIIBGAWlI1MFBnLcPxvjFNC
	 7oGRmQ4CcFkWYxmmuCw9sL47PvTGVQz5grKMkk509j0rODpMTa0AxHRrjx/8AwYMEQ
	 WJD3ojI+nuy/c/fi9hHaVyxKYe0F4iX94ZrKhaXKN0FRHjTKdzDs8k5DrawcdhVeSU
	 JolfZ1RSZ/StA==
Content-Type: multipart/mixed; boundary="===============0334522547505686193=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9dfcec80a2e1ed0d2362a2580f24da70dae6b2f4a734c59a806d2c33c2028b3@mail.kernel.org>
In-Reply-To: <20260921210038.1715324-1-yonghong.song@linux.dev>
References: <20260921210038.1715324-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 01/20] bpf: Accept the compiler's exception cleanup table at program load
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 21:56:39 +0000 (UTC)

--===============0334522547505686193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Accept the compiler's exception cleanup table at program load
>
> LLVM 23 added exception handling support for BPF with the .bpf_cleanup
> section ([1]). Rust code compiled with panic=unwind runs cleanup code
> (Drop glue) when bpf_throw() fires, and the LLVM BPF backend emits that
> section from the landing pads the frontend produced. Plain C cannot
> generate .bpf_cleanup unless inline asm is used. The Rust compiler does not
> *properly* support BPF exception handling yet, but the kernel can support
> the table today, and inline assembly is enough to test it.
>
> Add the UAPI to carry the .bpf_cleanup table into the kernel. BPF_PROG_LOAD
> grows cleanup_info, cleanup_info_cnt and cleanup_info_rec_size, and struct
> bpf_cleanup_info describes one record as a triple of instruction indices:
> the half-open call-site range [begin_off, end_off) and the landing_pad_off
> the frame resumes at. check_cleanup_info() validates the table a program is
> loaded with, so the rest of the kernel can rely on it.

This isn't a bug, but since the table is freed at the end of bpf_check()
and nothing reads env->cleanup_info yet, would it help to say here that
later patches in the series are the consumers, rather than that the rest
of the kernel can already rely on it?

>
> Link: https://github.com/llvm/llvm-project/pull/192164 [1]
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
> index 0e8b3ccc7a5b..17af0a414d74 100644
> --- a/kernel/bpf/check_btf.c
> +++ b/kernel/bpf/check_btf.c
> @@ -407,6 +407,153 @@ static int check_core_relo(struct bpf_verifier_env *env,
>  	return err;
>  }
>
> +static int cleanup_insn_subprog(struct bpf_verifier_env *env, u32 off)
> +{
> +	struct bpf_subprog_info *info;
> +
> +	if (off >= env->prog->len)
> +		return -1;
> +	info = bpf_find_containing_subprog(env, off);
> +	return info ? info - env->subprog_info : -1;
> +}

This isn't a bug, but would a name like cleanup_off_subprog() or
insn_subprog_idx() read a little less like an action here, given it
returns a subprog index?

> +
> +#define MIN_BPF_CLEANUP_INFO_SIZE	12
> +#define MAX_CLEANUP_INFO_REC_SIZE	MAX_FUNCINFO_REC_SIZE
> +
> +static int check_cleanup_info(struct bpf_verifier_env *env,
> +			      const union bpf_attr *attr,
> +			      bpfptr_t uattr)
> +{
> +	u32 krec_size = sizeof(struct bpf_cleanup_info);
> +	u32 i, nrec, urec_size, min_size, prev_end = 0;
> +	struct bpf_cleanup_info *krecord;
> +	bpfptr_t urecord;
> +	int ret = -EINVAL;
> +
> +	nrec = attr->cleanup_info_cnt;
> +	if (!nrec)
> +		return 0;
> +	/* Disjoint ranges, so no more records than instructions. */
> +	if (nrec > env->prog->len) {
> +		verbose(env, "cleanup info has %u records for %u instructions\n",
> +			nrec, env->prog->len);
> +		return -EINVAL;
> +	}
> +
> +	urec_size = attr->cleanup_info_rec_size;
> +	if (urec_size < MIN_BPF_CLEANUP_INFO_SIZE ||
> +	    urec_size > MAX_CLEANUP_INFO_REC_SIZE ||
> +	    urec_size % sizeof(u32)) {
> +		verbose(env, "invalid cleanup info rec size %u\n", urec_size);
> +		return -EINVAL;
> +	}
> +
> +	krecord = kvcalloc(nrec, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	if (!krecord)
> +		return -ENOMEM;
> +
> +	min_size = min_t(u32, krec_size, urec_size);
> +	urecord = make_bpfptr(attr->cleanup_info, uattr.is_kernel);
> +	for (i = 0; i < nrec; i++) {
> +		struct bpf_cleanup_info *rec = &krecord[i];
> +		int sb, se, sl;
> +
> +		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
> +		if (ret) {
> +			if (ret == -E2BIG) {
> +				verbose(env, "nonzero tailing record in cleanup info\n");
> +				if (copy_to_bpfptr_offset(uattr,
> +							  offsetof(union bpf_attr,
> +								   cleanup_info_rec_size),
> +							  &min_size, sizeof(min_size)))
> +					ret = -EFAULT;
> +			}
> +			goto err_free;
> +		}
> +
> +		if (copy_from_bpfptr(rec, urecord, min_size)) {
> +			ret = -EFAULT;
> +			goto err_free;
> +		}
> +		bpfptr_add(&urecord, urec_size);

This isn't a bug, but with this being the fourth copy of the
rec_size-check / tail-zero / copy_from_bpfptr preamble in this file
(prepare_btf_func, check_btf_line, check_core_relo and now
check_cleanup_info), would it be worth pulling the common part into a
small helper parameterised by the record size and the bpf_attr offset?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472
--===============0334522547505686193==--
