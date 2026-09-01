Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8424908BE;
	Tue,  1 Sep 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285356; cv=none; b=M2UdY3rWJkQYlpRXYU5WKu6PPC67sAiGMOI8qGJuQSPWVmZC/TZQLxLxWTtZAf5RoJEL7O86HwXS6ItIvY+ln48ftCVSGbqiTuZ2XuOdMtjXmwdEBdGLMbwhj+Y9ZtE8PsUsjdavGXjxD753SxHb4zxob5IT3lGtKJCcpwS4J6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285356; c=relaxed/simple;
	bh=XHd6HJWq3ys/utuUshD4ZRaW9IQGVGvzlYo3Kc9ecbY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M3xgI3nC2vuaowbivQtCuQ1WLcz0E/pCOwkIyAwwlYeN1Kz2exwWJISyYPKezoBMkkieedWE0cqj+8nrPqRCx3UhxJ18juyJcSbNVTDe4UY/Xskeb7J+VmY3Rog1R1FNgcb9ABQ/T/9tyrtv27mlNFXJdF751FVhTGUW1L6HY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QObf9jSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QObf9jSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8045C1F000E9;
	Tue,  1 Sep 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285354;
	bh=k67nwCXmygGrlR9rsNPedRLOqFL+om388FJIIpdaczo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QObf9jSQfxK3h0qIrIm7nWCx5xopev3yTjYm/uAWbSRnOVF/uz+450Ep8KgFlql8N
	 tNTgiuylpmwTRpIx3wZ6GovIhpY9yO9QLu+pue3Vs61DGoYS5NHMvjiwx5Td1U0L/a
	 DSbSDhBEbr9zEtTlIMBsKX7JpXNvBLMiQTeLxrYIvCEhfvBJQV89dC8RA+8E+jIjY8
	 yNRAcR29UyTGpPsufqmtQwm2CAGkDqiNW12oJi689zJ9eTVIva0vfe22rFrP/U18Ag
	 mfkyH+274zoh8Ezu33zGFyLvplqZmP+BTQ+i+Bv500wrQC8rd399CuV2dx4IIA82oJ
	 sqkjI7C7Ps23g==
Content-Type: multipart/mixed; boundary="===============7407090014249990527=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <718a4dc33d7b2b529bb8d5749581bb2c132314e6c69a9dcab7ae2a84ea7623d5@mail.kernel.org>
In-Reply-To: <20260901165757.801449-17-alan.maguire@oracle.com>
References: <20260901165757.801449-17-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 16/18] btf: Relocate inline BTF for modules with distilled base BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:53 +0000 (UTC)

--===============7407090014249990527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2ac1f1d39660..2f3e8cea7dfc 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -6727,15 +6727,140 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
>
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>
> +static struct btf *btf_parse_split(struct btf_verifier_env *env, const char *name,
> +				   const void *data, unsigned int data_size,
> +				   struct btf *base_btf)
> +{
> +	struct btf *btf;
> +	int err;
> +
> +	btf = kzalloc_obj(*btf, GFP_KERNEL | __GFP_NOWARN);
> +	if (!btf)
> +		return ERR_PTR(-ENOMEM);
> +	env->btf = btf;
> +
> +	btf_set_base_btf(btf, base_btf);
> +	btf->kernel_btf = true;
> +	btf->named_start_id = 0;
> +	strscpy(btf->name, name);
> +
> +	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
> +	if (!btf->data) {
> +		err = -ENOMEM;
> +		goto errout;
> +	}
> +	btf->data_size = data_size;
> +
> +	err = btf_parse_hdr(env);
> +	if (err)
> +		goto errout;
> +
> +	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
> +
> +	err = btf_parse_str_sec(env);
> +	if (err)
> +		goto errout;
> +
> +	err = btf_check_all_metas(env);
> +	if (err)
> +		goto errout;
> +
> +	err = btf_check_modifier_chain_length(env, btf, btf_nr_types(base_btf));
> +	if (err)
> +		goto errout;
> +
> +	return btf;
> +
> +errout:
> +	btf_free(btf);
> +	return ERR_PTR(err);
> +}

[ ... ]

> @@ -6759,67 +6884,75 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
>  				    unsigned int data_size, void *base_data,
> -				    unsigned int base_data_size)
> +				    unsigned int base_data_size, const void *inline_data,
> +				    unsigned int inline_data_size, bool vmlinux_inline,
> +				    void **relocated_inline_data)
>  {
> -	struct btf *btf = NULL, *vmlinux_btf, *base_btf = NULL;
> +	struct btf *btf = NULL, *inline_btf = NULL, *vmlinux_btf, *base_btf = NULL;
> +	struct btf *inline_base_btf;
>  	struct btf_verifier_env *env = NULL;
>  	struct bpf_verifier_log *log;
> +	u32 old_module_type_cnt;
> +	u32 *module_str_map = NULL;
>  	int err = 0;

[ ... ]

> -	btf = kzalloc_obj(*btf, GFP_KERNEL | __GFP_NOWARN);
> -	if (!btf) {
> -		err = -ENOMEM;
> +	btf = btf_parse_split(env, module_name, data, data_size, base_btf);
> +	if (IS_ERR(btf)) {
> +		err = PTR_ERR(btf);
> +		btf = NULL;
>  		goto errout;
>  	}

[ ... ]

> +	if (inline_data_size) {
> +		/*
> +		 * Ordinary module inline BTF is split relative to the module BTF.
> +		 * The btf_vmlinux_inline delivery module instead carries BTF split
> +		 * directly relative to vmlinux.
> +		 */
> +		inline_base_btf = vmlinux_inline ? vmlinux_btf : btf;
> +		inline_btf = btf_parse_split(env, module_name, inline_data,
> +					     inline_data_size, inline_base_btf);
> +		if (IS_ERR(inline_btf)) {
> +			pr_warn("failed to validate module [%s] inline BTF: %ld\n",
> +				module_name, PTR_ERR(inline_btf));
> +			inline_btf = NULL;
> +		}
> +	}

[ ... ]

>  errout:
> +	kvfree(module_str_map);
>  	btf_verifier_env_free(env);
> +	btf_free(inline_btf);
>  	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
>  		btf_free(base_btf);
> -	if (btf) {
> -		kvfree(btf->data);
> -		kvfree(btf->types);
> -		kfree(btf);
> -	}
> +	btf_free(btf);
>  	return ERR_PTR(err);
>  }

Can btf_free() handle NULL pointers safely? Both inline_btf and btf are
initialized to NULL and can remain NULL on several error paths:

btf_parse_module() {
    struct btf *btf = NULL, *inline_btf = NULL, ...

If btf_parse_split() fails for the module BTF at the call site above,
the code sets btf = NULL and jumps to errout, which then calls:

errout:
    btf_free(inline_btf);  /* NULL */
    ...
    btf_free(btf);         /* NULL */

Looking at btf_free(), its first statement is
btf_free_struct_meta_tab(btf), which dereferences btf->struct_meta_tab
without a NULL check. Similarly, inline_btf is only assigned inside the
if (inline_data_size) block, so it remains NULL on modules without inline
BTF or when inline parsing fails.

The pre-patch code guarded the btf free with:

    if (btf) {
        kvfree(btf->data);
        kvfree(btf->types);
        kfree(btf);
    }

while this patch replaces it with bare btf_free() calls. btf_parse() in
this same file still uses the guarded pattern: if (btf) btf_free(btf).

Three paths that can trigger this:

1. btf_parse_split() fails for the module BTF due to -ENOMEM from
kvmemdup, bad BTF magic/version in btf_parse_hdr(), malformed type
metadata in btf_check_all_metas(), or -ELOOP from
btf_check_modifier_chain_length(). Both btf and inline_btf are NULL at
errout.

2. btf_parse_base(".BTF.base", ...) fails for an out-of-tree module.
Both btf and inline_btf are still NULL.

3. btf_relocate() fails on a module with no .BTF.inline section, or whose
inline parse already set inline_btf = NULL. btf_free(NULL) at errout.

CONFIG_MODULE_ALLOW_BTF_MISMATCH exists so BTF validation failure
degrades gracefully instead of failing module load, but with this patch
the errout path would crash first.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============7407090014249990527==--
