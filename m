Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDE3C5DB6
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786270221; cv=none; b=R5EdcD70cXJB0fgFACQQHzhVR5XKLUQy4ZL70D0W4ZCABjMGtYbXM5YGV1HbX+ifE3gmi/zoWd4BLySIjhKPDTWuzJTKFgEoE20TlygQM1F9ivF81GMz0zyYdmG2Tkp/PS5AE+owGITDERuh1FswCUuhQxkyXAMnbZ/VEDB/r3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786270221; c=relaxed/simple;
	bh=xm8YeEzDri8ek0Qeqhb4pBAMPvKfCuZhwGwF9WrIIc0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KfJd7maPVr81rrbDRVbH8Voz4ee92UH7tqYd6h/IiFP2xcmHHLJPVTRQzcC/f85a84F3GOoFoYLmi1se7Wvc/cREnfcBoJgbjQdweGv1exwpvUAfxmLUr5ZMdVmmlZryNQ9pPdMLsENniriU0ApsGdMGG9cuZTPc71V9IqQ9kCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QavOS8aM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QavOS8aM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E594C1F000E9;
	Sun,  9 Aug 2026 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786270219;
	bh=AYccX3a2ErSt2/UXskLM2cOueTqQK5TGdmNTL1vDucE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QavOS8aMGAcPehHO856oVtQL9fp03NuZy3MUIpMTH81/Yzz1YBcNs9PBKgsvFugZF
	 lfG9o3aR/3/Yx65GpGYit7AvUuJ692fioFBMaDXXPExLg5h39GrqZQNaOJE3TeCyJQ
	 QipSwQBw0/k7QY7Od3cKENTvOg786mYnBwKC2Xmx87deN+Q/uyNZQWtpQoNZwypiQL
	 gS6excioBBlCzhHCWAoeP0tI+oAfv607DjLgp7PdCHWfddHqIQnKsQPv4DyiKZo0qt
	 XzIBfKGLSEj4rT+u/rt0hrbGPzQSN9J3mKnzsyFuvF3Gd7ShZnNwMYkHany/U2c2FZ
	 BnlBfoYyItBPw==
Content-Type: multipart/mixed; boundary="===============7586025733405993948=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc4f01fc137a1c4c66bb2eb39f721654bf539f065a623af7dd05b90c32b6f569@mail.kernel.org>
In-Reply-To: <20260809085155.3305519-2-memxor@gmail.com>
References: <20260809085155.3305519-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] resolve_btfids: Emit arena attributes from kfunc parameter suffixes
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  9 Aug 2026 10:10:18 +0000 (UTC)

--===============7586025733405993948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d2e4176339da..3c88ea192f7b 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -1067,6 +1070,22 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
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

Should this be `name_len > suffix_len` instead of `name_len >= suffix_len`?

The kernel's btf_param_match_suffix() in kernel/bpf/btf.c rejects a parameter
whose name is exactly equal to the suffix:

kernel/bpf/btf.c:btf_param_match_suffix() {
    ...
    len = strlen(param_name);
    if (len <= suffix_len)
        return false;
    param_name += len - suffix_len;
    return !strncmp(param_name, suffix, suffix_len);
}

That `len <= suffix_len` early return is what both is_kfunc_arg_arena() in
kernel/bpf/verifier.c and btf_func_model_flags() in kernel/bpf/btf.c rely on.
The same helper is also used by kernel/bpf/bpf_struct_ops.c for arena suffix
matching.

With the current implementation, a parameter named exactly "__arena" would be
treated as an arena pointer by resolve_btfids (causing address_space(1) to be
emitted in vmlinux.h), but would be treated as an ordinary kernel pointer by
the verifier's is_kfunc_arg_arena().

No in-tree kfunc currently uses a parameter named exactly "__arena" or
"__arena__nullable" (checked kernel/bpf/arena.c, test_kmods/bpf_testmod.c,
and btf_data.c), and the selftests added by commit 52b915d08490 only use
names like "a__arena", so this would be a latent inconsistency rather than a
currently-firing failure.

> +
> +static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
> +{
> +	const char *name = btf__name_by_offset(btf, param->name_off);
> +
> +	return param_name_has_suffix(name, PARAM_SUFFIX_ARENA) ||
> +	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31305217088
--===============7586025733405993948==--
