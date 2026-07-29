Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA551DDC07
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318121; cv=none; b=kXNW6xJW7njIVCjUw0/sPHljBaBHerHjj3PAMNRINAJ08pKhnjSesn/7+6KvY0eI5Lrij9JkVb1T0KJRV/PCfi8xdvZD2dUDteGEtiSn05rAVkvPsNECd22xOfMrBI/97hz/U80NDA+ktNhl9HJRSeWLh4tcmwrVlY/ZWoSpIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318121; c=relaxed/simple;
	bh=KNp5VOsOxh6C44kF7SQ735foW+SpnjEP6LHU/hIRGhU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k9MK2FACOGwKBb7rMjj2qQLZCGXbc5OMa02v8WvFLhK2khBTc/hkqPv3eZz3LA5Q446Qpj1WnJmgB150EcIoKzG1xa3FK2tmh/iCFa1HW4iJ6+DGpMyeqsnJUdVBrQntzWodYIyllx0zgZhFRuauiJX/hEmyu0VLwsDqzDN2iLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULDetdRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULDetdRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096A31F000E9;
	Wed, 29 Jul 2026 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785318119;
	bh=SBLFk9RsVJNJ3LdZZBY9h5hzXndUXu4qw1CkadpbiWk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ULDetdRxAktoqNjhIEaiVEj/fAHEDUBdmwiCx3KFahR3J0g/Ah5QSNlcOP9GQZOzf
	 OaPVa852M/jW3PH0OYPMN9jCOnLVz4Rrml0CdGefTa5ozgtBZjWUTbGFA+mqrRNiiT
	 0t4oDcLrrUEEUCd2yiMDXBwUGvTpMgbqf7ymtHe/nrHSSAOMibGOKY1jp9Dy5f+djw
	 M2MCFNlr4/4/znyAoDXz5Bg+sgt7tKe6PNssse6j0GrKhLUStfvH4FouBQmjdnrVuE
	 Lkc5f+wJAdY6rC5TIrMyniO7NKQNkU+CSRYpq9vXCj/5DA12+NbZ4XSEBDC9IBTCFf
	 Oqb8yMkNPoCQQ==
Content-Type: multipart/mixed; boundary="===============6720824355886084803=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c38fb6a3093763e627eb75afdbd1923f8809a74e3e741c083b33762909d9cb71@mail.kernel.org>
In-Reply-To: <20260729083807.1588544-8-jolsa@kernel.org>
References: <20260729083807.1588544-8-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 07/11] bpf: Factor callchain_finalize function from __bpf_get_stack
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 09:41:58 +0000 (UTC)

--===============6720824355886084803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 18b3db5c1fb9f..05269f2a9e085 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -769,16 +769,29 @@ static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
>  	return trace_nr;
>  }
>
> +static long callchain_finalize(void *buf, u32 size, u32 trace_nr, u32 elem_size,
> +			       bool user_build_id, bool user, bool may_fault)
> +{
> +	u32 copy_len = trace_nr * elem_size;
> +
> +	if (user_build_id)
> +		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
> +
> +	if (size > copy_len)
> +		memset(buf + copy_len, 0, size - copy_len);
> +	return copy_len;
> +}

This isn't a bug, but would it read better if callchain_finalize took the
raw flags the way callchain_store does, deriving user_build_id, user, and
elem_size internally?

The new helper takes seven positional parameters, three of which are
adjacent bools (user_build_id, user, may_fault) that could be transposed
at the call site without the compiler catching it. Two of the parameters
are also derivable: elem_size is exactly sizeof(struct bpf_stack_build_id)
or sizeof(u64) depending on user_build_id, and both user_build_id and user
come straight out of flags.

The sibling helper factored one commit earlier, callchain_store(), takes
the raw u64 flags and decodes user_build_id and skip itself, so the two
new helpers in the same series decode flags in opposite directions.

[ ... ]

>  static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  			    struct perf_callchain_entry *trace_in,
>  			    void *buf, u32 size, u64 flags, bool may_fault)
>  {
> -	u32 trace_nr, copy_len, elem_size, max_depth;
>  	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>  	bool crosstask = task && task != current;
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
> +	u32 trace_nr, elem_size, max_depth;
>  	bool kernel = !user;
>  	int err = -EINVAL;
>
> @@ -826,18 +839,12 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	}
>
>  	trace_nr = callchain_store(trace, buf, elem_size, flags);
> -	copy_len = trace_nr * elem_size;
>
>  	/* trace should not be dereferenced after this point */
>  	if (may_fault)
>  		rcu_read_unlock();
>
> -	if (user_build_id)
> -		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
> -
> -	if (size > copy_len)
> -		memset(buf + copy_len, 0, size - copy_len);
> -	return copy_len;
> +	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id, user, may_fault);
>
>  err_fault:
>  	err = -EFAULT;

This isn't a bug, but could the changelog mention that this is preparation
for moving the faultable build-id work out of the preempt-disabled section
later in the series?

The commit message says:

>     bpf: Factor callchain_finalize function from __bpf_get_stack
>
>     The new callchain_finalize function calls the build-id retrieval
>     (if needed) and zeroes the buffer.

It restates what the new function body does but not why the factoring is
wanted, and does not state that no functional change is intended. The later
commit in the same series does spell out its motivation ("makes things
easier for preemption fix in following change"), and the preemption fix
does depend on callchain_finalize sitting outside the preempt-disabled
region.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30437558115
--===============6720824355886084803==--
