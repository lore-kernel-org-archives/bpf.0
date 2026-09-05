Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A563BD22C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648286; cv=none; b=J+Y7+FpbiLN+xfx5V7zMCTdEXlF+PGfpSvKOaB0uVsvTlm0dZmJW3NYreyeUiN75JVSxyINmfinN8eksHfdycbgd68mYGiAXU+ZuHRizjBZ8n5qzpO8bMPWSnWYzr3pRhBtUh6YhQxc38hEVLMpzkB7HImmGILNMErFlAc0Af90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648286; c=relaxed/simple;
	bh=p8qZM2WrvawBC8qMrVDjfqOtKh7+uiCqZ2VGN9vXcwI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AibSX5/PX3CRVHKBkWY0O14gN81TsqX6uRHPiEW9TCfHNv6L1hOD0LM67y6VVf4urhppmKt+tQd2tFezEV2z1MWH3EEvKbWG9uSJcZHe0g43VwG78IcdSrWKupveoy9h8UHGUAKwKvHJO/HWzQITjPloDQm8fumdUN5NKY5/d9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c10emfFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c10emfFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23DD1F00A3A;
	Sat,  5 Sep 2026 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648285;
	bh=NLOu0rKL8amB/K9ofKLwWIu6BvcfY5V4Xvwv5kZK9I0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c10emfFjJNBc62N5QPHpJE2cna8kdw8OMbBn55bZTEspNYgUOODIU5f9dr6K+C7OJ
	 hscqsjT5Xs6oRCP34nmkndekvBO0AHxwmLn6iSB9Wygu5lB6G59NA3qD84a3aW75QV
	 wq61kZeowAb2ZcLhAaS24Y6AyHF2nN3l7qBdDYsHqTM7ZbyYPPwZ7JRBgyXIT+FnGf
	 AB0tu+flxBLw0mq1pyjfuAWKQ93tYrcSIudGl2JJgaKKgBIS4fkRfqgKewtwZ4xbkt
	 ctQzW1Nb8jejibrtmyc8jKlnEAVRAK67GDHmNyjRKWyHXN9QUODv4eFY92YP+S5lkW
	 Po/9mhVDDVGUQ==
Content-Type: multipart/mixed; boundary="===============7051810086597514831=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a578e5a3739a469e7c8c1150b31b719b013f85c22d725d2bcc4a444199759e78@mail.kernel.org>
In-Reply-To: <20260905220117.922028-12-ameryhung@gmail.com>
References: <20260905220117.922028-12-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/22] bpf: Set MEM_RCU when generating kfunc argument types
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 22:44:44 +0000 (UTC)

--===============7051810086597514831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f43462a43ee9..c5b394e847e6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12239,6 +12239,14 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  	if (is_kfunc_release(meta) && arg == 0)
>  		arg_type |= OBJ_RELEASE;
>
> +	/*
> +	 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
> +	 * otherwise demand a referenced or trusted one. Only ARG_PTR_TO_BTF_ID
> +	 * looks at where its register came from, so leave the other kinds alone.
> +	 */
> +	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID && is_kfunc_rcu(meta))
> +		arg_type |= MEM_RCU;
> +

This isn't a bug, but would it be clearer to state the actual reason
for the ARG_PTR_TO_BTF_ID guard here? The comment says only
ARG_PTR_TO_BTF_ID looks at register provenance, but several other
kinds handled in this same function do inspect provenance:
ARG_PTR_TO_ALLOC_BTF_ID and ARG_PTR_TO_REFCOUNTED_KPTR check
reg_is_referenced()/type_is_ptr_alloc_obj(), and
ARG_PTR_TO_LIST_NODE/ARG_PTR_TO_RB_NODE/ARG_PTR_TO_LIST_HEAD/ARG_PTR_TO_RB_ROOT
check type_is_non_owning_ref().

The guard is actually needed for the reason the changelog gives: to
prevent MEM_RCU from leaking into arguments whose handling compares
the whole arg_type, like the ARG_PTR_TO_CTX test in
check_func_arg_reg_off().

>  	return arg_type;
>  }
>
> @@ -13174,7 +13182,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  			    reg2btf_ids[base_type(reg->type)]) {
>  				if (!is_trusted_reg(env, reg) ||
>  				    bpf_type_has_unsafe_modifiers(reg->type)) {
> -					if (!is_kfunc_rcu(meta)) {
> +					if (!(arg_type & MEM_RCU)) {
>  						const char *expected_type;
>
>  						expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============7051810086597514831==--
