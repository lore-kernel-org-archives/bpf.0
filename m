Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72743D9025
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568267; cv=none; b=UxVP18qEXFelD5UUJXVoi6tmRYhONkrk2VNjq1vPvwPuD19nl9Q4OjcgnSmoljBqVWghGvnHlwpR40O4Zp9GmsVP5G6q7CCzG4eLy9EsBk3m9L/MlitWj/Gz61Z5Cyll14gljpp/Dfq9m11AmLho9DmWXRC7COLEZ3d0ffI3KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568267; c=relaxed/simple;
	bh=mnRE4BZ6EInQYSQy9PODht+kGgjEzHtWpAerWGjjfe4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RtWumm4eVTefxdF8GJJPF2oKYTIuE/9QKjOD7hpbzUYZJcEFrIXYfxMk6qGwLfFSQsMvntJYiy7kOpZxYt9TzI5UyalV/pllUDX2rQ138HBwzUeaZt3bjTqSf6JhJV4RSbL+AvnXlnECEge1xItogfPWtDuzQcWBpTnjdw2runU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL5UabQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL5UabQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8FB1F00A3A;
	Wed, 12 Aug 2026 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786568265;
	bh=LsAqF6Ph8lQGxNyJ+vJWwWy/xjAgec3jMXFkrC8DjY0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PL5UabQcxdGt1Ce3g3NTkwIVKbpqWOwgOvLafTCshdeYaUOf4M4+e3klUkM0Wf8hS
	 zUjQrZWrg1HjhcNA4umaCuotfBOzn5dgNFuCjSunCYekYrA1jeAn6RM4Qx0eIkQHx9
	 biUt/Ci9CyMREKogau5INEAgmMv69ReUbbjpEZstqWb7StIs4K3UPuxa5KLCIjAzXc
	 0ew6qBx7eIdoaXwMNDaIMAXGOJP8/lB1tQdk/eXXMCD+tCbbdfhoYaulSEtHZQP216
	 csSoizYIy6Gz3OATk4jaYt7A6y//yu3Q7APLUvrWfC/DNdh65YW+ZnvTS2Ksu/KoQF
	 7htukYESr6lLw==
Content-Type: multipart/mixed; boundary="===============3542402620321549889=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b79dc1dd49e77f0ac33db634050651db29bc9349415954e5c8e4645bc668a0b1@mail.kernel.org>
In-Reply-To: <20260812193842.2879226-2-memxor@gmail.com>
References: <20260812193842.2879226-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] resolve_btfids: Emit arena attributes from kfunc parameter suffixes
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 20:57:44 +0000 (UTC)

--===============3542402620321549889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     resolve_btfids: Emit arena attributes from kfunc parameter suffixes
>
>     Kfunc declarations can identify arena arguments through parameter name
>     suffixes without repeating KF_ARENA_ARG flags in their BTF ID sets.
>     resolve_btfids currently misses those arguments when synthesizing the
>     address_space(1) attributes used by generated vmlinux.h files.
>
>     Teach the arena prototype rewrite to recognize __arena and
>     __arena__nullable directly on each parameter. Keep KF_ARENA_ARG1 and
>     KF_ARENA_ARG2 handling for explicitly flagged kfuncs, while allowing
>     suffixes on any argument without synthesizing kfunc flags.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for missing arena suffix handling. Should this
include:

  Fixes: 27a78c2e7eee ("resolve_btfids: Process KF_ARENA_* flags in resolve_btfids")

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 1004eb0bec617..10e725cbe64cd 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst

[ ... ]

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d2e4176339da6..37d7e7224207d 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -1067,6 +1069,22 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
>  	return 0;
>  }
>
> +static bool param_name_has_suffix(const char *name, const char *suffix)
> +{
> +	size_t name_len = strlen(name);
> +	size_t suffix_len = strlen(suffix);
> +
> +	return name_len >= suffix_len && !strcmp(name + name_len - suffix_len, suffix);
> +}

Does this accept parameter names that are exactly "__arena" or
"__arena__nullable"?  The kernel's btf_param_match_suffix() in
kernel/bpf/btf.c deliberately rejects that case:

    len = strlen(param_name);
    if (len <= suffix_len)
            return false;

Both verifier and JIT go through that helper. If resolve_btfids uses >= but
the kernel uses >, a parameter whose whole name is the suffix would get
address_space(1) in the generated vmlinux.h but would be treated as an
ordinary pointer by the verifier and JIT. The header and kernel would then
disagree about the calling convention.

Should the comparison here be name_len > suffix_len to match the kernel?

> +
> +static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
> +{
> +	const char *name = btf__name_by_offset(btf, param->name_off);
> +
> +	return param_name_has_suffix(name, PARAM_SUFFIX_ARENA) ||
> +	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
> +}

[ ... ]

> @@ -1299,8 +1317,12 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
>  	return 0;
>  }
>
> -static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
> +static bool is_arena_arg(const struct btf *btf, const struct kfunc *kfunc,
> +			 const struct btf_param *param, u32 idx)
>  {
> +	if (is_arena_param(btf, param))
> +		return true;
> +
>  	switch (idx) {
>  	case 0:
>  		return kfunc->flags & KF_ARENA_ARG1;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31635245405
--===============3542402620321549889==--
