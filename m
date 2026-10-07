Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A224B44DB
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387621; cv=none; b=WSG+aCCC4DiYDeC4V6UMVMcq8xlFFIUC0S6zu7H9mLW9d7W+6LkrMfPkgCjYbp5sSdorBzgETatNCuoLga3Fxt3YotWZ05OBB4PwGBLqCd/ZMkEeCLkMTykOwOrz3Gw0+9ZQvjIbk9a3wQM1nLTZcJUmNWstQc1LtAxKP/rIeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387621; c=relaxed/simple;
	bh=zQkf7Yuo5P2eDbCjvfzERIPP5i1NQZf9noss0XTkGnY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rr0NlOkIy8Q8obCDCmm2FieMi+KBl/efQErWKsqfHyaBYFK74nC+4ZfZGHCQYVBHy0HqLnv7/ku72mOmdTKI5DoKb8fFRbzak51eQRH5PV2+Zpg4DFyLIIyFkNYAZ6SRCuDWQxBsxG9opSxuiGyHfxMRpbONKVdrX+axdaFJ2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2sYVbxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2sYVbxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072371F000FF;
	Wed,  7 Oct 2026 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791387616;
	bh=TaVFq/05//OOQjpReEZ2FXtKdmSg31PX5NH86O4S9fA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T2sYVbxRy3f3Ikz1L/UUxLAqOPvszUuG09sMLQojS7D1w8NykOWsVWkOWlI52vays
	 d0fjvci/JM1aV8BhJUQmmjXs71UW3KQa/PiSEmMY6bFRaTLi4x9stSibw+r0x3+YtA
	 Gndf+ZbW+NaVt0TAXhds+HB4775pBxPPg3yjJHBVbOEO8qPY/e5p6/mCrOFfWTtqK2
	 CkydFyzsVB3ak6xb5Mh1dCAe7BZinKQKgjiOxbrlV4hNwBDnniLwO2hkwd11WmBirr
	 5y5Z5XuMVGcUVFJRF5Ozhxpt51KryYg0Ej9NkUel9aNY23wU/nulpdWYkkVTEw8xhZ
	 OCn+RU9nqbdGg==
Content-Type: multipart/mixed; boundary="===============5228617564175613132=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b41c6c375852bc827ec5c58a80f9582fdac24fcedca5d787f2316dbed2a2aca@mail.kernel.org>
In-Reply-To: <20261007150549.1334-1-rahadbhuiya2021@gmail.com>
References: <20261007150549.1334-1-rahadbhuiya2021@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: mark kfunc memory size argument precise when buffer is null
From: bot+bpf-ci@kernel.org
To: rahadbhuiya2021@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,rahadbhuiya2021@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  7 Oct 2026 15:40:14 +0000 (UTC)

--===============5228617564175613132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: mark kfunc memory size argument precise when buffer is null

TL;DR: The extra mark_arg_precision() on the null-buffer kfunc size looks
unnecessary: size is unused there and __szk is already marked precise. It may
reduce pruning and cause complexity-limit failures. Asks for a concrete
wrongly-accepted program.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5f874979b8d7..206e10158938 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13219,8 +13219,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  				return -EINVAL;
>  			}
>  
> -			if (bpf_register_is_null(buff_reg))
> +			if (bpf_register_is_null(buff_reg)) {
> +				ret = mark_arg_precision(env, argno);
> +				if (ret)
> +					return ret;
>  				break;
> +			}
>  
>  			ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
>  						 BPF_READ | BPF_WRITE, true, meta, &failure);

The commit message says that checkpoints on the null-buffer path "would
prune against arbitrary scalar values in the size register."  Is that
actually a soundness problem?

Precision is only needed when a scalar's value affects a verifier decision.
That is why 506ada89629e ("bpf: mark a NULL kfunc argument precise") and
1a3a10b030c9 mark the NULL pointer precise: whether it equals 0 decides
whether checks are skipped.  On this path nothing reads the value of the
size register:

    if (reg->type != SCALAR_VALUE) { ... return -EINVAL; }   /* type only */
    if (bpf_register_is_null(buff_reg)) {
            ...
            break;                                  /* size value unused */
    }

check_mem_size_reg() is skipped, so there is no smin/umax/zero-size check
and no meta->msize_max_value.  That field is only used by
do_refine_retval_range(), whose only caller is check_helper_call(), so
kfuncs never use it.

regsafe() already requires the register types to match, so the SCALAR_VALUE
check is safe to prune on.  The buffer register, whose zero value does
decide this branch, is already marked precise one iteration earlier:

    if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type)) {
            ret = mark_arg_precision(env, argno);

Helpers are different, since check_helper_mem_access() lets a NULL mem
through only when the size is 0, so the size value does matter there.

Looking at the two size cases separately:

For KF_ARG_CONST_MEM_SIZE (__szk), the only in-tree kfuncs with a
__nullable buffer plus size are bpf_dynptr_slice() and
bpf_dynptr_slice_rw(), each declared as 'void *buffer__nullable,
u64 buffer__szk'.  The value is used there for regs[R0].mem_size via
meta->arg_constant.value, but process_const_arg() has already marked it
precise just before the fallthrough:

    case KF_ARG_CONST_MEM_SIZE:
            ret = process_const_arg(env, reg, argno, meta);  /* marks precise */
            ...
            fallthrough;
    case KF_ARG_MEM_SIZE:

Commit f16e80c2c451 ("bpf: Fold __szk const size handling into the scalar
arg path") closed exactly this gap, and the selftest
verifier_mem_size_reg.c:dynptr_slice_null_buf_size_precise covers it.  Isn't
the new mark_arg_precision() call just re-marking the same register, at the
cost of one more backtracking walk on every such call?

For KF_ARG_MEM_SIZE (__sz) with a nullable buffer, no in-tree kfunc has this
combination.  Any scalar size is accepted when the buffer is NULL, so
pruning on an imprecise size cannot hide an unsafe state.  Could marking it
precise instead push precision back into parent states and their source
registers (for example a loop counter)?  That would reduce pruning and might
stop open-coded iterator loops from converging, so programs that loaded
before could hit the complexity limit with no soundness benefit.

Could the changelog name a concrete program that is wrongly accepted
without this change?  If there isn't one, the change and its rationale look
unnecessary.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37642948251
--===============5228617564175613132==--
