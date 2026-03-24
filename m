Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC753D9DB0;
	Tue, 24 Mar 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342721; cv=none; b=lqR1hHo+Z9BHrjHM8VYmDqC0jB3B8W6h4jYW6apaPSGkKEzJyijCbUPG88ieJGRQPJOL24z0ZuheGXZd7PamH2R3nLa/Qkbb5fnrtZweZbITWycSc4ErmctzOIg7Q4/03+unfnC/RzpbUlC7vBBYsbBv17hSH3Dq5lHboc84qHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342721; c=relaxed/simple;
	bh=CNMLTlzQJfwyHHVCCOjNDGJNV92wV6d0jkFEjyRXDuc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZwZk0MB0TKE0ThbXESZz0NWIM+8W0MBYnap5yZF/fIX40czFgqGyDUEe56pGUqUEngQSFyF4fJjWwRP/68qCERFgPfjkRh8noLDcCWBsEW1QA2kGF/+DdCIhD+JQDVseSULC8U42DJvgyWm2dPt50aYcXe1EaGR21UWWAwwmBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsWIyjVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsWIyjVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216C1C19424;
	Tue, 24 Mar 2026 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342721;
	bh=CNMLTlzQJfwyHHVCCOjNDGJNV92wV6d0jkFEjyRXDuc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TsWIyjVxb/aRLQ7/7zQIQ6o62YgM+DaDy7M3NLFYNcwjE2ZN0rraWBzz9LP6ZRElg
	 BqWSoqzjlrhgXS9wNinr6HS2/oRKwNQPqTkb4AtXxwiKAYWzaNdUWShh6u1YaDdA+j
	 /6SBfOHvXHuNKx8IOZVz/+w/tF87ug2mgNislpRvDhUrgGwr14PtB6Vc0HurW91QPK
	 /YlKFuyx4ExpBQ0o9utQfmI8lJH9ums05g9hGlzGb9hegkV0wk25M2p65X6SpIBSmj
	 9SVNypy7J4fnKHQrEGOesnCIP2mKHIXgGBBy92P1rBVQKIKFmm48DiOq4cYSY9OKw4
	 0Z0yUZwc9Ie5w==
Content-Type: multipart/mixed; boundary="===============5090762381078663218=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <711e8b90d27722e47cccfc30a1ccfe243ea7a696322997c15fda1a2147dba6a4@mail.kernel.org>
In-Reply-To: <20260324081846.2334094-10-jolsa@kernel.org>
References: <20260324081846.2334094-10-jolsa@kernel.org>
Subject: Re: [PATCHv4 bpf-next 09/25] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 08:58:41 +0000 (UTC)

--===============5090762381078663218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a9e328c0a1b3..2986e5cac743 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_tracing_multi_node *mnode;
> +	struct fentry_multi_data data = {};
> +	int i, cnt = link->nodes_cnt;
> +
> +	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +
> +	if (!data.unreg || !data.modify) {
> +		free_fentry_multi_data(&data);
> +		return -ENOMEM;
> +	}

If alloc_ftrace_hash() fails here under memory pressure, the function
returns -ENOMEM without detaching any trampolines or releasing their
refcounts.

The caller in the next patch (bpf_tracing_multi_link_release) does:

    WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));

This drops the error on the floor. The link struct is then freed by
bpf_tracing_multi_link_dealloc(), but the trampolines remain attached
with elevated refcounts, permanently leaking them and their ftrace
hooks.

Would it make sense to pre-allocate these hashes during
bpf_trampoline_multi_attach() and store them in the link struct so
that the detach path cannot fail?

> +
> +	trampoline_lock_all();

[ ... ]

> +rollback_unlink:
> +	/*
> +	 * We can end up in here from 3 points from above code:
> +	 *
> +	 * - __bpf_trampoline_link_prog or update_ftrace_direct_add failed and
> +	 *   we have some portion of linked trampolines without ftrace update
> +	 *
> +	 * - update_ftrace_direct_mod failed and we have all trampolines linked
> +	 *   plus we already un-attached all new trampolines
> +	 *
> +	 * In both cases we need to unlink all trampolines from the new program
> +	 * and update modified (data.modify) sites, because those have previously
> +	 * some programs attached and the new trampoline needs to get attached.
> +	 */

This isn't a bug, but the comment says "3 points" and then describes
two scenarios in two bullet points. Maybe say "2 scenarios" or split
the first bullet into two to match?

> +	ftrace_hash_clear(data.modify);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23480161822
--===============5090762381078663218==--
