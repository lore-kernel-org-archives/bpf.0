Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD644065B;
	Wed, 23 Sep 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144930; cv=none; b=LHgboYSgi4Qa+9Iqi+0mu9UDSRAGJDaK50WuhWlmLTsXJhQqkJ/MVF3LInCg+sPojLoeB+zl7SL5zK3UCV/O2AWMUfjKlpQZRh/WlVsLw7np7YYj1GH/0SDnKl/7T/ZUN3LPpsl5UGPpOksxEd/2VKNkQj9XSOJFuiVzQMwaMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144930; c=relaxed/simple;
	bh=b3K674XacfU9HJDGPP3f22Z84mjfKdkKProo6csmN0w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fVQXKcu0pYigkIfhmPf2QI8taTOLTlnLBlzg8+XKUVqtHSEPdD2di6spjZZwLN9YAZakovrRkP3/n+KtPwid0JYBpq/zyLBroVF3kUPUgcYUzv8SZqqa2F+TW5uNPMxy/6A7zOH34ZEhrIlCG0QkQ+4lX86y+kpZ/RM5asGrdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2LDhSM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2LDhSM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2951F00893;
	Wed, 23 Sep 2026 06:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790144926;
	bh=eI6+XHcjsk+Aomoq3O+3u/S9cWaPPzDXPaoa4YU8VL4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E2LDhSM3PpD0MkV00TYcoliypTLubCqwFI6LJFK91oEyrg/57Gy7h/OcWb6+kfZfP
	 3aTuZQvfoRYlXRdwqF76kUQ+tj9I+2ATTk7pSm36p8oHy4dwCqc+vwbAXzWAt1Bf6z
	 nVzCise2kn7SLe8xWVgpFmOlzO+JapnX/yFodht20zT2/hsQBEozR6mEhvUAoajztz
	 5utTZ51r6HgkDgz7VGoMqTr/+IK8X/orwj6X8Lw7xVXRk+JkpF1W9qL8hUnZhR3KJt
	 uLDwOV3TKDFDClS3sy5ZIX+ILTwmh377YNzcmbjQGpK3pGFf6mQYobKlaXGOCfBLyT
	 3Hwyv0d5wZKOw==
Content-Type: multipart/mixed; boundary="===============1161609189727594346=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39f6151d364d966f70b7802cfd4bbca15734a7945478265ecc681f1779e50abb@mail.kernel.org>
In-Reply-To: <20260923053948.30617-4-wanjay@amazon.com>
References: <20260923053948.30617-4-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: fetch the vmlinux BTF where kernel types enter a program
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,linux-modules@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 06:28:43 +0000 (UTC)

--===============1161609189727594346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e7c5e203eddd..a3c4caad5dfc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3165,6 +3165,7 @@ static inline s32 bpf_call_args_imm(s16 idx)
>  #endif
>
>  struct btf *bpf_get_btf_vmlinux(void);
> +struct btf *bpf_peek_btf_vmlinux(void);
>
>  /* Map specifics */
>  struct xdp_frame;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7c9e2d8965d..2425ea74b61d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21724,7 +21762,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret)
>  		goto err_prep;
>
> -	bpf_get_btf_vmlinux();
> +	/*
> +	 * The vmlinux BTF is not fetched up front: with CONFIG_DEBUG_INFO_BTF=m
> +	 * it is loaded on demand, at the points where kernel types enter the
> +	 * program (attach_btf, kfuncs, ksyms, map pointers, BTF-typed helpers).
> +	 */
>
>  	/* Serialize verification of unprivileged programs. */
>  	if (!is_priv)

Does removing this unconditional bpf_get_btf_vmlinux() call break
program-context type resolution? The removed call was the sole caller of
btf_parse_vmlinux(), which is the only place that populates the file-scope
bpf_ctx_convert.t table needed by find_canonical_prog_ctx_type().

On a CONFIG_DEBUG_INFO_BTF=m kernel where the BTF hasn't been parsed yet,
consider this chain:

bpf_check() -> do_check_subprogs() -> do_check_common() ->
btf_prepare_func_args() -> btf_is_prog_ctx_type() ->
find_canonical_prog_ctx_type()

At this point, find_canonical_prog_ctx_type() returns NULL because
conv_struct = bpf_ctx_convert.t is still NULL. Then btf_is_prog_ctx_type()
logs "btf_vmlinux is malformed" and returns false.

A global subprog argument like 'struct __sk_buff *skb' or 'struct xdp_md
*ctx' then falls through to the 'generic user data pointer' branch and gets
typed ARG_PTR_TO_MEM instead of ARG_PTR_TO_CTX. At the call site
btf_check_func_arg_match() -> check_mem_reg() rejects the caller's
PTR_TO_CTX register with a confusing type error.

When libbpf emits the common 'arg:ctx' decl tag, btf_prepare_func_args()
-> btf_validate_prog_ctx_type() returns -EINVAL directly with "btf_vmlinux
is malformed".

The same NULL bpf_ctx_convert.t also breaks btf_ctx_access() ->
btf_translate_to_vmlinux() for BPF_PROG_TYPE_EXT programs loaded with
attach_prog_fd, so ctx member access in the replacement program fails.

The changelog lists the new fetch sites: kfuncs, ksyms, map_ptr access,
BTF-typed helpers, attach_btf. None of these cover the program-context
path, which needs the vmlinux BTF but never touches a PTR_TO_BTF_ID
register. The claim that "every PTR_TO_BTF_ID register a program can hold
originates from one of these sites" is true but insufficient as a coverage
argument.

The failure is non-deterministic: if anything else (a kfunc-using program,
mounting bpffs, BPF_BTF_GET_NEXT_ID) already forced the parse, the same
program loads fine. Programs that work on CONFIG_DEBUG_INFO_BTF=y
intermittently fail on =m.

Commits later in this series make this reachable: d80d57b4ec13 defers
kfunc registration until the BTF is available (removing the boot-time parse
from the first kfunc registration), and 2f5aab95d2b8 makes
CONFIG_DEBUG_INFO_BTF=m selectable. A search of the forward range
90fe51b6b36a..2f5aab95d2b8 for bpf_ctx_convert, find_canonical_prog_ctx_type,
btf_is_prog_ctx_type and btf_prepare_func_args finds only
comment/documentation text - no fix.

> @@ -21790,0 +21832,5 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (IS_ERR(btf_vmlinux)) {
>  		/* Either gcc or pahole or kernel are broken. */
>  		verbose(env, "in-kernel BTF is malformed\n");
>  		ret = PTR_ERR(btf_vmlinux);
>  		goto skip_full_check;
>  	}

This check a few lines below the deleted fetch was the consumer of that
fetch: bpf_get_btf_vmlinux() stores an error pointer with
smp_store_release(&btf_vmlinux, btf) on parse failure, and bpf_check() then
converted it into the "in-kernel BTF is malformed" diagnostic.

With the fetch gone, this check reads a global that this program hasn't
caused to be populated. Whether a malformed-BTF kernel reports the clear
error or a confusing downstream one now depends on whether some earlier,
unrelated program already triggered the parse.

It also reads btf_vmlinux directly rather than through the new
bpf_peek_btf_vmlinux() accessor, so the load is not ordered against the
smp_store_release() that publishes it.

Could this check either move next to a real fetch or be dropped and let the
per-site IS_ERR_OR_NULL() handling report the failure?

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 195f78db9bda..c022b2877f0b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1015,7 +1015,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
>  	if (btf_ptr_size != sizeof(struct btf_ptr))
>  		return -EINVAL;
>
> -	*btf = bpf_get_btf_vmlinux();
> +	/* Called from a running program: only use the BTF if it is parsed. */
> +	*btf = bpf_peek_btf_vmlinux();
>
>  	if (IS_ERR_OR_NULL(*btf))
>  		return IS_ERR(*btf) ? PTR_ERR(*btf) : -EINVAL;

Swapping bpf_get_btf_vmlinux() for bpf_peek_btf_vmlinux() is correct as a
sleeping-in-program-context fix, but does anything in this commit arrange
for the BTF to have been parsed by the time bpf_snprintf_btf() or
bpf_seq_printf_btf() run?

The compensating verifier-time fetch in check_helper_call() is gated on
helper_uses_vmlinux_btf(), which only matches base_type(ret_type) ==
RET_PTR_TO_BTF_ID or base_type(arg_type[i]) == ARG_PTR_TO_BTF_ID.

bpf_snprintf_btf_proto and bpf_seq_printf_btf_proto contain neither: their
arguments are ARG_PTR_TO_MEM / ARG_CONST_SIZE / ARG_ANYTHING and the return
is RET_INTEGER, because the BTF type id travels inside the struct btf_ptr
the program passes by value rather than in a register type.

So helper_uses_vmlinux_btf() returns false for exactly the two helpers
whose runtime fetch was just weakened.

On a CONFIG_DEBUG_INFO_BTF=m kernel where the BTF is present but not yet
parsed, bpf_peek_btf_vmlinux() returns NULL and the helper returns -EINVAL.
A working bpf_snprintf_btf() or bpf_seq_printf_btf() call silently starts
failing, depending on whether unrelated activity already triggered the
parse.

The changelog frames this as behaving "as they do on a kernel without BTF",
but the BTF is available, just unparsed, and the previous code would have
produced correct output.

Should the fix be at verify time - teaching helper_uses_vmlinux_btf(), or
check_bpf_snprintf_call(), or the *_btf protos, to force the fetch? The
forward range 90fe51b6b36a..2f5aab95d2b8 contains no code change for this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35824427607
--===============1161609189727594346==--
