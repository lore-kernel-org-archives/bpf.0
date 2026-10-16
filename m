Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB022C3245
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110514; cv=none; b=jJRKaUpFCTKgTlmDH/DMDyLtLDuzZm3h+3aYX78Px0siTqF5xoljY7eX5sHaNVdgl8sA8ZtabO9Su8ow/RFDglq9aNuhbthXjw8Uy1Ah1f0iRW65iUqUbwc3WpehleCZvGJkRARY9gug1DlTk0IMgy1Ez0gzRDbwSRWCxEb6VPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110514; c=relaxed/simple;
	bh=SyvjCCcswG5j9RQbiZBTnLIFTCbTYO1U7oXHLDnER2s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=soeO6W65lWR/4RR5BEm26xH1O3K2iLmpHshcZdqKZcEfLMAxca2HdsI+dUu1ZU54pnKY3T+e7kPFlh7mXdJ8XhUaYz090Ma+Va9dLx3JnxNs5ft7Sq1KTresWZ2jqhk6hrl7X4vWPJpqdF6xmTSzdMKPPfQKNRaSZquc0HxEcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGr8Ufbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGr8Ufbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E357D1F000C4;
	Fri, 16 Oct 2026 00:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110513;
	bh=pSJLjUILzb5hyXXJM1k6OxhVcoSGe1lp5Gv+nrBBZYY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mGr8UfbdHo9/HbAtHM1Yb7co38MR4iKmagXMCY3UP2FXIRyCQJK5rUXKPA4325jDO
	 1t0x1JNEnEviM7ifwhaoWIG7BgzxvIXFrVW3x+rSa2yGumm1mwuYnGp8EfEGhbSTO0
	 ednc4c27jimjuuUmsecdDYw3C0XoF+Wdzl7KPqVwaCEBqqTBJSG03K08CNcWWN0RKA
	 tVGTk61m9VyN8Da4JdKraV34O/3PhtWhZcGGrl5Nv4arDNc/Qrt/3zTWWlrnzJbzbM
	 JoVWNShLPEfAqjNNh9VDTmEpIqFn+CtdQjG7oQhsUzI1a5j1anYn3vhmAi3n8wWeos
	 yL5fkcSyaDnqw==
Content-Type: multipart/mixed; boundary="===============6294980444073911556=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33fa4fbf4a2047c0af0a6b729a16b7684dd742665f5afedc92ea5ffc01c0c8b8@mail.kernel.org>
In-Reply-To: <20261015234125.3152346-11-memxor@gmail.com>
References: <20261015234125.3152346-11-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/15] libbpf: Bind the arena of an object to every program in it
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 00:28:31 +0000 (UTC)

--===============6294980444073911556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Bind the arena of an object to every program in it

TL;DR: Binding the arena to every program in libbpf may make the arena_kfunc
and verifier_arena_scalar no-arena selftests fail at this commit, breaking
bisectability until a later patch; fold the selftest changes in?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fcedb78abe00..bd4df22a8a95 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -8804,6 +8805,47 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,

[ ... ]

> +static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_program *prog,
> +				  struct bpf_prog_load_opts *load_attr)
> +{

[ ... ]

> +	obj->fd_array[0] = map->fd;
> +	load_attr->fd_array = obj->fd_array;
> +	/* with slot 0 filled every slot handed out is valid, so the array can go with a count */
> +	load_attr->fd_array_cnt = obj->fd_array_used;
> +	return 0;
> +}

With the arena now bound to every program of an object that has an arena
map, do the selftests that rely on a program in such an object having no
arena still pass at this commit?

Two programs look affected.  In progs/arena_kfunc.c:

	SEC("syscall")
	__arch_x86_64
	__arch_arm64
	__failure __msg("arena pointer requires a program with an associated arena")
	int arena_arg_no_arena(void *ctx)
	{
		bpf_kfunc_arena_arg_test((u64 *)1);
		return 0;
	}

The object declares an arena map, so on a kernel with fd_array_cnt this
program now gets the arena and no longer fails with that message.

In progs/verifier_arena_scalar.c, no_arena() expects:

	__failure __msg("R6 invalid mem access 'scalar'")

That object declares an arena map too, so this program should now load as
well.

Both programs are moved to a new object without an arena map by 02f4766a965c
("selftests/bpf: Test arena binding by libbpf"), later in the series.  Until
then test_arena_kfunc and the verifier_arena_scalar tests would fail, so the
series is not bisectable for them.

Could those selftest changes be folded into this commit, so that each step
stays green?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38826834739
--===============6294980444073911556==--
