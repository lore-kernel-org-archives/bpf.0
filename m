Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFF3242B8
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199359; cv=none; b=RitqAEpu+AJOjkDG7Ju/9WakT9J3phNnrK/zzQHEMH1fGsD9s+/aS+YscFIOiIhdLrClNeji8VnM9gQwI+9+ALye9MWfHLVnJgY+Uvn5uE46i9Ufq47AqHph/2Ji21RfiOVfMF7LfV8OglOxCQQk1gt5OSUnxyEUrDqaihK5ZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199359; c=relaxed/simple;
	bh=8R2glEnKumosOR7bZ4t9uuLJ78O60DJfK4xmyzrFy2Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fWPaLAvVD/dZAKG0fOG4wVUFlO5+zb9BKzQUCiU1WnZ/wo3avrmYpldecZYD8jCawyOGg8Z8H+yAT47+Zwi3hTcjGw3lom1wAyKYz2kOQ2TO9seA0eT862iYT5eK7+3v0uN3eEGZY06rFc7hqTpgZIOOuxxbnT6eQweVAoBay0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLEZGkfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLEZGkfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2770C19425;
	Tue, 14 Apr 2026 20:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199359;
	bh=8R2glEnKumosOR7bZ4t9uuLJ78O60DJfK4xmyzrFy2Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QLEZGkfAkYzhUNrxptZSQxr6HC39Juiwu/SNHanoe84e9DXOszLaYXymkdvlGNl0P
	 2zu6r8myw8pjggt0+eL+00FtrNYzLRh00BjHtP0yYYnoT+1rH5TN3+Nxw2/t8jWsKo
	 fIifd2Vzojrips2JajWOMvcg4+h48oJ35t1rydDj3N+ZjFj0IWu8eVH4T+tFHMSfHX
	 xD/+qc4oORj03pPGaWv9Z5kXb4M6w6DdGCMmpSobjPtPdGCVdr1XW8Hw5qmPJkq6ua
	 5+Y5t2Sg1q4kn8nuJ/PrCp5QC8mOnCbznQ+MYoMIpkuyBEWV2qS7nfQtcZqqLgap0Z
	 EzV4BzwLVo6xA==
Content-Type: multipart/mixed; boundary="===============0605025376558028593=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9048dfaef437494bad8b50e56ea108c012cbbceaf5225f2b0086aae45b83d204@mail.kernel.org>
In-Reply-To: <20260414195019.684531-2-alan.maguire@oracle.com>
References: <20260414195019.684531-2-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Extend BTF UAPI vlen, kinds to use unused bits
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Apr 2026 20:42:38 +0000 (UTC)

--===============0605025376558028593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..1663970fc1bf 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -289,7 +288,7 @@ enum verifier_phase {
>  struct resolve_vertex {
>  	const struct btf_type *t;
>  	u32 type_id;
> -	u16 next_member;
> +	u32 next_member;
>  };

The next_member field is widened to u32 here, but
env_stack_set_next_member() still takes a u16 parameter:

static void env_stack_set_next_member(struct btf_verifier_env *env,
                                      u16 next_member)
{
        env->stack[env->top_stack - 1].next_member = next_member;
}

Both callers, btf_struct_resolve() and btf_datasec_resolve(), now use
u32 loop iterators and pass i + 1 to this function.  For vlen values
above 65535, the u16 parameter would silently truncate the index,
causing the resolve loop to resume at the wrong member.

Should the next_member parameter be u32 to match the struct field?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24420385267
--===============0605025376558028593==--
