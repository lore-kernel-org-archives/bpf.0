Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075E3B635A;
	Sat, 27 Jun 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573769; cv=none; b=JN0jSrgc76b6JGhZ8Xy9Fbg3z3YZajCP03HFf+eD3xZFpYOoxdDiMtmnGGt/dD7rvRQO3TugEcDmHJColvD/l4Vi7Gb60H7Ud/+baeCl9esEgFCMl9tNoh9X7lCSOSWa2GhOqUYrDCyaveXVQpglIZrIAai1P0SYMUfFzg2A/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573769; c=relaxed/simple;
	bh=B5yZ9AA+EkoQ4QBLE10avQI2RLUE6oWH9jne7MpdMEg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n+irAP7FwJQWyrGZX7tj8i8A7//Bq0+4Ycd3rczNjfqLzOm/dW2JOKVHlnrFSeKvty9j+RNXtGO/I+JXjdd4nt5LxJWBD6POb7DSV/VVfxak828eW8E2P5OyAM+6NEGBznT1dbAQSwfWC7oMCTjDphHn42i31aQaxGFG0ob6f00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckDOnDnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckDOnDnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624101F00A3A;
	Sat, 27 Jun 2026 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573767;
	bh=VX7qa6DAgT32zsUpRrlBmQ/Zt1V7PeZlg7Z3rVbQhSE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ckDOnDnWzXcrN8nglvb0jtDMOqeT2HNPOXvCaeRoKeqkFQeVb0Sca8rOk+fsatM1A
	 HS/Ibz1AecIS9kM38fUzzlnOWA83W9pTyD/2GuDFXyELcORAaxEotwTAd43ZTvMZCs
	 pjjX+sAFqckhOFvdRXmFSC70D6gVorIvX5C4qzpPDQRbGo4HzAHIGpWRT/7QZNbmbI
	 DOf263TzMyuNv/LGezcZ/G+OXQwFh0j/JI7EDCVfT8Cia6fURm5NzmfAVkU048FBjs
	 hwmfXQ5K0DBtkOXp2ant9Y2w5YPAg9sQ6PsxdCme3PVM9RuCWwnF3DzxVAtkxjqn9f
	 l08npYeO4qf8Q==
Content-Type: multipart/mixed; boundary="===============5237146780607374025=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <659952bc287b99a3e86866cd561bbf69c8675704f5e3435e8308c6fac2df060b@mail.kernel.org>
In-Reply-To: <e5e991c7573600676c0de49b7b794e1f2b6d956a.1782571533.git.xukuohai@huawei.com>
References: <e5e991c7573600676c0de49b7b794e1f2b6d956a.1782571533.git.xukuohai@huawei.com>
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add kernel support to load SDT observer program
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,eyal.birger@gmail.com,rongtao@cestc.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 27 Jun 2026 15:22:47 +0000 (UTC)

--===============5237146780607374025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index dc881e5ad411..8b2c73bb6c2a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2454,6 +2454,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>  	kvfree(prog->aux->linfo);
>  	kfree(prog->aux->kfunc_tab);
>  	kfree(prog->aux->ctx_arg_info);
> +	kfree(prog->aux->sdt_probe);
>  	if (prog->aux->attach_btf)
>  		btf_put(prog->aux->attach_btf);

[ ... ]

> @@ -3082,33 +3085,75 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
>  		btf_get(attach_btf);
>  	}
>
> +	/*
> +	 * find the probe site in the target program at load time of the
> +	 * observer program, so the verifier can check the observer's context
> +	 * arguments from the probe's FUNC_PROTO.
> +	 */
> +	if (attr->expected_attach_type == BPF_TRACE_SDT) {
> +		struct bpf_insn_array_value sdt_val;
> +		struct bpf_sdt_probe_info *sdt_probe;
> +		unsigned long probe_ip;
> +
> +		if (!bpf_jit_supports_sdt_probe()) {
> +			err = -EOPNOTSUPP;
> +			goto put_token;
> +		}
> +		if (!attr->sdt.target_prog_fd) {
> +			err = -EINVAL;
> +			goto put_token;
> +		}
> +		dst_prog = bpf_prog_get(attr->sdt.target_prog_fd);
> +		if (IS_ERR(dst_prog)) {
> +			err = PTR_ERR(dst_prog);
> +			dst_prog = NULL;
> +			goto put_token;
> +		}
> +		err = bpf_insn_array_get_sdt_probe_by_name(dst_prog, attr->sdt.name,
> +							   &sdt_val, &probe_ip);
> +		if (err)
> +			goto put_sdt;
> +		sdt_probe = kzalloc_obj(struct bpf_sdt_probe_info, GFP_USER);
> +		if (!sdt_probe) {
> +			err = -ENOMEM;
> +			goto put_sdt;
> +		}
> +		sdt_probe->val = sdt_val;
> +		sdt_probe->probe_ip = probe_ip;
> +		prog_sdt_probe = sdt_probe;
> +		attach_btf_id = sdt_val.btf_id;
> +	}
> +
> +
>  	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
> -				       attach_btf, attr->attach_btf_id,
> +				       attach_btf,
> +				       prog_sdt_probe ? attach_btf_id : attr->attach_btf_id,
>  				       dst_prog, multi_func)) {
> -		if (dst_prog)
> -			bpf_prog_put(dst_prog);
> -		if (attach_btf)
> -			btf_put(attach_btf);
>  		err = -EINVAL;
> -		goto put_token;
> +		goto put_sdt;
>  	}
>
>  	/* plain bpf_prog allocation */
>  	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
>  	if (!prog) {
> -		if (dst_prog)
> -			bpf_prog_put(dst_prog);
> -		if (attach_btf)
> -			btf_put(attach_btf);
>  		err = -EINVAL;
> -		goto put_token;
> +		goto put_sdt;
>  	}
>
>  	prog->expected_attach_type = attr->expected_attach_type;
>  	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
>  	prog->aux->attach_btf = attach_btf;
> -	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
> +	if (prog_sdt_probe)
> +		prog->aux->attach_btf_id = attach_btf_id;
> +	else
> +		prog->aux->attach_btf_id =
> +			multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
>  	prog->aux->dst_prog = dst_prog;
> +	prog->aux->sdt_probe = prog_sdt_probe;
> +	/* ownership of dst_prog/attach_btf/prog_sdt_probe moved to prog->aux */
> +	dst_prog = NULL;
> +	attach_btf = NULL;
> +	prog_sdt_probe = NULL;

After this ownership transfer, prog_sdt_probe is NULL. Several error paths
below this point (copy_from_bpfptr failures, license checks, signature
verification, dev_bound initialization, find_prog_type, bpf_obj_name_cpy,
security_bpf_prog_load) all jump to the free_prog label.

Does the free_prog path correctly free prog->aux->sdt_probe?

Looking at the error paths:

kernel/bpf/syscall.c:bpf_prog_load() {
    err = copy_from_bpfptr(...);
    if (err)
        goto free_prog;
    ...
    err = bpf_prog_verify_signature(prog);
    if (err < 0)
        goto free_prog;
    ...
    err = bpf_prog_dev_bound_init(prog, attr);
    if (err)
        goto free_prog;
    ...
}

> @@ -3242,6 +3287,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
>  	if (prog->aux->attach_btf)
>  		btf_put(prog->aux->attach_btf);
>  	bpf_prog_free(prog);

The free_prog label calls bpf_prog_free(), which in turn calls
bpf_prog_free_deferred(). That function frees used_maps, used_btfs,
kfunc tables, and the JIT image, but not aux->sdt_probe. The only place
that frees aux->sdt_probe is __bpf_prog_put_noref(), which is reached
through the normal bpf_prog_put() teardown (the free_used_maps label),
not through this error path.

> +put_sdt:
> +	kfree(prog_sdt_probe);

This kfree handles the local prog_sdt_probe, which is NULL after the
ownership transfer above. It won't free the allocation now owned by
prog->aux->sdt_probe.

Can prog->aux->sdt_probe leak when a BPF_TRACE_SDT load succeeds past
the probe resolution but fails before bpf_check() completes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28292842584
--===============5237146780607374025==--
