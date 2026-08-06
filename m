Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2DCA6B
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974504; cv=none; b=rAaV4XFvNynU7Sb81SS00L78rDCBPKO6wCiFOREmd+L4itoJYl2Rs7oczGE0NDLmADsQa7r0OxkoH87DZwta+6IdzHaIrZuRwD/R7hMA9htMcfTNx0e3LJZrQqSEdCyCoIU4Zo4Xo7/Y3eIgXeB72IdAHQhzl0yHooR+qcqLnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974504; c=relaxed/simple;
	bh=oFI+QNIVE6ifKL0C9MlYPkQmlmVrw+d1LLlld+qt+6o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B21ieWQUKIsB+FIeZ1aiLSuOjdlphWvwXgTItwRv/fIB+//zQbE9qlBwUvAQQGDA1WPN4j+GvtX4mpmxIuz2RL7puJ97+tJgk5TAvSYcOijBGN7jDsXctDb95+Zobw2LhDltkQMmj6yO1TAKyVFq+qKx5ormrOf3cz2eO2YVpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0G4tBAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0G4tBAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0957B1F000E9;
	Thu,  6 Aug 2026 00:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974496;
	bh=rjpNuDI/Qm2ACi7uT99xMepC+YCGu+E52G6IwRVIbPE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=o0G4tBAcxidSF++P9Cn+MllY9fb4bLI8qAjrLarcZpubf3Eh4//v0+sBYcS8pU9c+
	 JmXNNZgEdvH5n5QV1aUFj25+Ix8+xdohbyEUbB4U9NqX2a4v+928xPaQz+rJ6MLO8S
	 GYNoGilJymfC702d1rOqVYYkUL+qUQvElDk5OEPqppqSKSHH8bUR5W8D/zFDtYFRiN
	 5gRYavJFpf/2xPRNmO6nScohUkVPeiz4rE6y6xf1B2eoJfphqmvmjHTezyMAhmbbcE
	 8ixLSyCzasiBpknLZFa0I8ZuwW6h4KJH99UWNZn4QhWmp7UzI9XRp6y48oUNC7Z8xH
	 gDHfikulevNXg==
Content-Type: multipart/mixed; boundary="===============1085032769381649560=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a55ccb52e205bc8a32d3ae6c179de333746ef912a9a259f18425b33935509653@mail.kernel.org>
In-Reply-To: <20260805230648.2354989-7-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-7-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF annotation emission
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  6 Aug 2026 00:01:35 +0000 (UTC)

--===============1085032769381649560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index cbde86d082cce..c60fc574e8b06 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -472,6 +472,14 @@ type. An example is shown below::
>          }
>          late_initcall(init_subsystem);
>
> +At kernel build time the ``resolve_btfids`` tool discovers all kfuncs from the
> +registered ``BTF_SET8_KFUNCS`` sets and emits their BTF annotations into the
> +kernel's BTF; these annotations were historically produced by pahole. For each
> +discovered kfunc ``resolve_btfids`` emits a ``bpf_kfunc`` BTF decl tag, a
> +``bpf_fastcall`` decl tag when the kfunc is flagged ``KF_FASTCALL``, and the
> +``address_space(1)`` type attribute on the return value and/or arguments flagged
> +``KF_ARENA_RET``, ``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).

Emil Tsalapatis suggested in v1 replacing "address_space(1)" with "arena"
throughout the documentation for better readability. This nit was not
addressed in v2.

The term "address_space(1)" appears in four locations across this commit
(kfuncs.rst, changes.rst, Makefile.btf, and main.c). Would using "arena"
be clearer, especially since the code already defines TYPE_ATTR_ARENA?

> +
>  2.7  Specifying no-cast aliases with ___init
>  --------------------------------------------
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 1ca8c5f73ad00..6d1dbe4abf0f0 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
>  modules as well.  This requires pahole v1.22 or later.
>
> -Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
> -or later.  Without it, such kfuncs will have incorrect BTF prototypes in
> -vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
> -with vmlinux" error.  Many sched_ext kfuncs are affected.
> +Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the arena
> +address_space(1) type attribute) are emitted in-tree by resolve_btfids from the
> +BTF_KFUNCS sets, so they no longer depend on a specific pahole version.
>
>  It is found in the 'dwarves' or 'pahole' distro packages or from
>  https://fedorapeople.org/~acme/dwarves/.
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index a1812985a61aa..717e76ce96a71 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
>  else
>
>  # Switch to using --btf_features for v1.26 and later.
> +#
> +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
> +# address_space(1) type attribute) are emitted by resolve_btfids, not pahole.
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>
>  pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index ea25ca34aa006..66f4014e6aa17 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -58,6 +58,17 @@
>   *             __BTF_ID__func__vfs_fallocate__5:
>   *             .zero 4
>   *	       .word (1 << 3) | (1 << 1) | (1 << 2)
> + *
> + * In addition to resolving BTF IDs, resolve_btfids performs kernel-specific
> + * BTF-to-BTF transformations for kfuncs found in BTF_SET8_KFUNCS sets. For
> + * each such kfunc it:
> + *
> + *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL is set;
> + *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
> + *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type attribute;
> + *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
> + *
> + * These kfunc annotations were historically produced by pahole.
>   */
>
>  #define  _GNU_SOURCE


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31056256483
--===============1085032769381649560==--
