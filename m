Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E393BADB9
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749399; cv=none; b=HtDaAOijeiCpvh3CFhTenIYGt5+JNmy+aCAP/ohkBJ/1+XkZleKxjHAx5CMWbZKBKWrGMAd9zGK4Hg8iUZ3UF5wPHj70qaKvqcLX0uYJvSYOG2ULUmQFe6PUuVoqFN/MERF44hg9Ba+VzLLWHR/P3ewZaGAsKqSH4V5ynEJjdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749399; c=relaxed/simple;
	bh=2o8wyuKSQ9e0pqBU2aWi+X7DNLqFJR3JYPzHzdnvZa8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ITfy+z/5FbvF6o6t4qPIVDfdoEzVZD4o+I9dnbwjS30WzKkCEj++G/tEq56jxIoukya1mMvvRcltMuJNKl3zoJGI7qP7Xr2RRwO5FdBmKuKi7p8WeMyPO24i/wuGKeyjVC5fsoLkKUQVyRaS0w2v9GlGSoAbojCFVh6qPr2MjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1TMkprc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1TMkprc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CCCC2BCB0;
	Tue, 17 Mar 2026 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749399;
	bh=2o8wyuKSQ9e0pqBU2aWi+X7DNLqFJR3JYPzHzdnvZa8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=s1TMkprcFd68b52UjSNem/imquVzXh+UrjdkkKPhcVFn8a1+oQ7eWSiTedNcafXBd
	 E+yNr5h5IAdYWnth1IBmptMU9i1E1HZik+O9bi7YXve6xw9l2o1iR56muz4Pxd9FlM
	 9MbQhqfjRViOy/oqx4iZ7vRDJ8YgNS3GLREeLAPNUgJMfhg8oOm+JUzoqT88O11hNX
	 4tKrUysvZybJheGRWjMHyhTfNdKrh9f+l4vZxcPIV2CPgqx6dfEVDHmb+wpw9JrVyr
	 /C+3tmQmsTLzzcoJSXUpUhbyM8EA1Cr0jm0eFEfGzfQ5xw8cXu1Iw3fJmet314fmb3
	 jmiMxfNIUm6vQ==
Content-Type: multipart/mixed; boundary="===============0973729749928231204=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f866e392e5e59050f6cd4a2f28f94e87a0f1c7852a76197c6628af0584bed6cd@mail.kernel.org>
In-Reply-To: <20260317111850.2107846-2-memxor@gmail.com>
References: <20260317111850.2107846-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Support variable offsets for syscall PTR_TO_CTX
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: tj@kernel.org,dschatzberg@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Mar 2026 12:09:58 +0000 (UTC)

--===============0973729749928231204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9710,6 +9716,11 @@
>  		 * still need to do checks instead of returning.
>  		 */
>  		return __check_ptr_off_reg(env, reg, regno, true);
> +	case PTR_TO_CTX:
> +		/* Allow fixed and variable offsets for syscall context. */
> +		if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
> +			return 0;
> +		fallthrough;
>  	default:
>  		return __check_ptr_off_reg(env, reg, regno, false);
>  	}

Since check_func_arg_reg_off now returns 0 unconditionally for syscall
PTR_TO_CTX, can a modified (offset) PTR_TO_CTX be passed into a global
subprog via btf_check_func_arg_match?

The global subprog is verified independently with a fresh PTR_TO_CTX
at offset 0, so its max_ctx_offset only reflects its own local accesses.
But at runtime the subprog receives the caller's shifted pointer. For
example:

  main program:
      r1 = PTR_TO_CTX
      r1 += 400
      call global_subprog(r1)

  global subprog (verified independently):
      accesses ctx[0..100]  ->  max_ctx_offset = 100

  runtime:
      subprog gets ctx_base+400, accesses ctx_base+400..500

In bpf_prog_test_run_syscall, the buffer is allocated based on
max_ctx_offset:

    ctx = memdup_user(ctx_in, ctx_size_in);

With max_ctx_offset = 100 instead of the needed 500, a 100-byte buffer
would be accepted and the subprog would read or write 400 bytes past
the end.

It looks like the series patch 3/4 ("bpf: Reject modified syscall
PTR_TO_CTX for global subprogs") adds a check in btf_check_func_arg_match
to reject this case. Would it make sense to fold that restriction into
this patch so the intermediate state does not have the gap?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23192407921
--===============0973729749928231204==--
