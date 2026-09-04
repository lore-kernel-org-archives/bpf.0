Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D747DFBE;
	Fri,  4 Sep 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522548; cv=none; b=qE2Z62BxJ3kANL3qRG89JOaO7Mdxhhh1WQMnt1IOEeqfxjGzu56CkNw7lGKtm+4lDAUXc5LsQsvSC+COpzntOXXRn9XmXPRfo1X0I9yJojcMl5Jtrs9kK3b235WC8BqqNgBgFOGzmHi6eBXixNycZokmPkGmU1IpEOnn6Tsm7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522548; c=relaxed/simple;
	bh=YSdVMdHCxdqTkxdlgKdDoXIRmVXR+t4WXWhIWUXRIKQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tRKq4gvlDNIdT+upF06HkDoT6jE4CD6XORyXHsAAH0NmBBiCqMY/jJF0GpO/eP63jDsfUyd/81ouQDjQsauQWDIhXjmwo2r4hAEvP+vsiWK0Uam/j0SBywr1me9uFOlwRgOQmf6pGF+w1RfCknHuFHt7Hl9rQP/16qP8qgklp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDcpVtt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDcpVtt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243241F00A3E;
	Fri,  4 Sep 2026 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522547;
	bh=IO+JaPkkhHlt89fKykaxRyJf4ib1adAbOW8qeasOOsQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RDcpVtt9UENkGiR9OM7+eILwqCJ9bq4kyY2x7ZcdjXIgMjSajS2QQ7PPLa+oQflg+
	 RyMOA6OhOlHhbl6/5kt7b9F99wd7x6wPUeuojlqzMVybHFV+bk5nP6bc1pjbAiFAO9
	 awKEUteGgvaHBISrTkOb+nV0QT+/nJuakUj93lyq+j3xZFhgc1sWoPpYcWL023/XSP
	 b8s1tVT9TyeOELihG3TXPQSuV01MzGX7VvgjtIDKJoREhzzTeUBDWFq6t/BEm6pPit
	 0dwAbqHmOjb4MK6L6LUC6XnPzQK6C9n8Vym7xy8bUOobSALrZFgoYHOU5kKwiQUkMb
	 WBEX08+Vt06YA==
Content-Type: multipart/mixed; boundary="===============7659003284560239661=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f91a0667d1921b17106b5ce94539ed6d64059b206cdba8c237e5b76b5e4a6aba@mail.kernel.org>
In-Reply-To: <20260904105743.39799-7-hemanth.selam@gmail.com>
References: <20260904105743.39799-7-hemanth.selam@gmail.com>
Subject: Re: [PATCH 6/7] tools/lib: fix typos in comments
From: bot+bpf-ci@kernel.org
To: hemanth.selam@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:49:06 +0000 (UTC)

--===============7659003284560239661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8417de92d0282..c1745bee37c0a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3843,7 +3843,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
>   * types, in general, can form graphs containing cycles, not just DAGs.
>   *
>   * While algorithm does deduplication, it also merges and resolves type
> - * information (unless disabled throught `struct btf_opts`), whenever possible.
> + * information (unless disabled through `struct btf_opts`), whenever possible.
>   * E.g., in the example above with two compilation units having partial type
>   * information for structs `A` and `B`, the output of algorithm will emit
>   * a single copy of each BTF type that describes structs `A`, `B`, and `S`
> @@ -5644,7 +5644,7 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
>   *
>   * After we established for each type its corresponding canonical representative
>   * type, we now can eliminate types that are not canonical and leave only
> - * canonical ones layed out sequentially in memory by copying them over
> + * canonical ones laid out sequentially in memory by copying them over
>   * duplicates. During compaction btf_dedup->hypot_map array is reused to store
>   * a map from original type ID to a new compacted type ID, which will be used
>   * during next phase to "fix up" type IDs, referenced from struct/union and
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 2e56e3ab5b6cc..c0933580930bc 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -144,7 +144,7 @@
>   * about. This state has to be maintained per-BPF object and coordinate
>   * between different USDT attachments within the same BPF object.
>   *
> - * Spec ID is the key in spec BPF map, value is the actual USDT spec layed out
> + * Spec ID is the key in spec BPF map, value is the actual USDT spec laid out
>   * as struct usdt_spec. Each invocation of BPF program at runtime needs to
>   * know its associated spec ID. It gets it either through BPF cookie, which
>   * libbpf sets to spec ID during attach time, or, if kernel is too old to

This isn't a bug, but both files here are under tools/lib/bpf/, where recent
commits use the 'libbpf: Fix ...' subject form - would 'libbpf: Fix typos in
comments' fit the tree's convention better?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33866776554
--===============7659003284560239661==--
