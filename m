Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC57449992
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641736; cv=none; b=l75MvBd2ZxJobpozK4DPiM8vSuRj1iEwt0blOReEbFggLO/NdlLbTJwVCetMXLio16LT0D/KbHdWmJ7k8bvPGj/BpYwPeHGPU37w8Kwu3g+1DPdGhvmni+ZiyMYp5hH3hd1VfyaQlXJTQped5ZZ2PeEAqtUWQsSTKU7cO2rthxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641736; c=relaxed/simple;
	bh=2MtfCDdBjD2zStaCOaudWLu0EoNyIOuqHHyPP/yJCa0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VvYNmGKzTFiAlJ1MSe0GxYZBUBwL2ilnqmVYKNQh7P4izoC9/NF4+zxSaF5dvpF7ZWQbL6v7ft3CPPfgkJOhOq8Fdhud6dYN8EW1b0/15Z/2seM4QdfZpXKvvSLY2XXMcJLIfydSL/LxjW3Np3s3sxOJ4UbWHZdQpC+VayEKjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg4IUJ8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg4IUJ8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E47E1F000E9;
	Fri, 10 Jul 2026 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783641734;
	bh=ptKpKSrLWKgbXzy9kiWCAMHbsTxonY7QILSMSDdOrEE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hg4IUJ8TFZ0HfPiVSLMUSHR8KDYFZ4RsOWdQv85Zn9gVXPuGvwx/rWdjgMdGfkUs/
	 /pZr7symd4KA35CAbFKM+TSzHMDFVVQZtww2QqMvn13PmIMTunMRY4WGJo7HvEjbsQ
	 xLRngJq/hCPLh/T3CPJAy9xcZ1gka5CVJm4ct+qR8d4RioN8nGO/pgiCE6rufa+rpc
	 O6Ktrv4dobhfjbJL/K2OH5xoTChmCs/qysFG+2Snd2tSVtotjsoULIf1azM/v5Upl+
	 CVSDexcMD7Pt+92NZ4PjoGsIJP8zveZUrbsbuoXfAlZM+H34V9ZOlqrBdbBqXi/QUa
	 mnYp3po/tXoJQ==
Content-Type: multipart/mixed; boundary="===============7516700718939624386=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20627c9430fb5b3386a52b95973fc39936e205e23a15995d8bfce3aceafdb567@mail.kernel.org>
In-Reply-To: <20260709230242.2003459-4-ameryhung@gmail.com>
References: <20260709230242.2003459-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Unify helper and kfunc allocation-size argument handling
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Jul 2026 00:02:14 +0000 (UTC)

--===============7516700718939624386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Unify helper and kfunc allocation-size argument handling
>
>     The constant "size of the PTR_TO_MEM returned in R0" argument is handled by
>     both helpers (ARG_CONST_ALLOC_SIZE_OR_ZERO) and kfuncs (__rdonly_buf_size /
>     __rdwr_buf_size), each with its own meta field (meta->mem_size,
>     meta->r0_size) and duplicated validation. Add struct arg_alloc_mem_desc
>     and a shared process_const_alloc_mem_size(), and replace both fields with
>     meta->arg_alloc_mem.
>
>     The desc records presence with a 'found' flag instead of using a non-zero
>     size as the sentinel. This also fixes a pre-existing bug on the kfunc
>     return path: "no size argument" was tested as r0_size == 0, so an explicit
>     __rdonly_buf_size/__rdwr_buf_size of 0 was treated as absent and fell
>     through to btf_resolve_size(), giving R0 the size of the pointed-to return
>     type instead of 0. With 'found', an explicit zero size is honored and
>     btf_resolve_size() is used only when no size argument was passed.
>
>     The size is stored in a u32, matching regs[R0].mem_size. The U32_MAX
>     check now apply to both helper and kfunc through
>     process_const_alloc_mem_size().
>
>     Fold bpf_session_cookie return size assignment into current kfunc return
>     size resolution path.
>
>     Note that verifier saves kfunc return size through r0_size instead of
>     mem_size. The later has no active readers so remove it.
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

The changelog describes fixing a pre-existing bug on the kfunc return path,
where an explicit __rdonly_buf_size/__rdwr_buf_size of 0 was treated as
absent and fell through to btf_resolve_size().

That sentinel-based fallback looks like it dates back to when fixed-size
memory pointer returns were added for kfuncs, where the
"if (!meta.r0_size) { ... btf_resolve_size(...) }" block first appeared
alongside the rdonly_buf_size/rdwr_buf_size handling that set meta->r0_size.

Should this carry a Fixes: tag so the fix can be backported?

  Fixes: f4b4eee6169b ("bpf: add support for fixed-size memory pointer returns for kfuncs")

This isn't a bug, but would it be worth tidying the changelog wording?
"The later has no active readers" reads as "The latter", and "The U32_MAX
check now apply to both" reads as "now applies".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29057017398
--===============7516700718939624386==--
