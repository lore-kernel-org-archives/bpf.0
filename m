Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCC391826
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781351663; cv=none; b=kxDiAZ+BqChVHbEOiFW21pj1S+1TWjHYPWdLWrwoKuVDsmY2Ei3M9yBjgMyBbSf65DGxgqSH8E0u72yvkQazf84nzf8C5vRVEEphrgWbtC6ZjfG6eyB/d/hmfuIqsZ7hY10/nxZOAlWn7tdSMP9aUxDfJmEOneAuifeAB1m2RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781351663; c=relaxed/simple;
	bh=fILlKMVyK9/yE7JMS/a4+oXA0d51I1G639TygNvtTaM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m0MX0KLNdmvxlhuy5I8c2n9a3sHlcZhg1uXvNpCW+4Cs7lPgkH3WhxDdkvgHmHNe3ByEINVKy+817q1wyQ0QhOPdD5mbqDivABkDBL6FurR90oF6iZj8ghwty6dO3ZAuDBJ3c5LQAXY8vEcR1AgBLWkbswrXtUWg+qFIymZPEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW+9NKk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW+9NKk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E261F000E9;
	Sat, 13 Jun 2026 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781351662;
	bh=OWSmy61Vy0c/Y6HqxkaI9KWr0HDjESIB3D3GRZ/whUE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lW+9NKk6RsNs0wudHBtuWUYQkJdEFGgbH/2vtoBeTQfvbCJRZgkOgHQkiPnQRfsdN
	 Lqwou8kR4TqmBmz2kj3tZlFV9vKTg6AjcA7tgGWAE0kyHxGPvEjd7oXghIjSU34Uwl
	 FqQ/P+WiaxE7Ne35UjfaolrMTJGgUaSoq8M35OsB0AqKNJkUO6LaJ3rlB7GXXg6GeT
	 c1Ao+gXop5d7ej1cm8fgrnz53Hk0HM1T3Eo68ULh708TBtet6Ez9eRbnc1b0pXccfy
	 ruryoueMjkVF9Fyo1Wd38zOTTEKa6YYR30H976c5d2ndqvwELyHcCxArYOXsYzDx/H
	 UThsxnOXntOhw==
Content-Type: multipart/mixed; boundary="===============8935061741098376344=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d4728398d9cca082283a8eeacdde187e0a989a804a467b1faceb6e0cc5e7d95@mail.kernel.org>
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve scalar zero spills for var-offset stack reads
From: bot+bpf-ci@kernel.org
To: random6.xyz@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,random6.xyz@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 13 Jun 2026 11:54:21 +0000 (UTC)

--===============8935061741098376344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Variable-offset stack reads can read back bytes that belong to a
> previously spilled scalar constant zero. Today mark_reg_stack_read()
> only treats STACK_ZERO bytes as known zero bytes, so the destination
> register becomes unknown for such reads even though every byte in the
> read range is known to be zero. This can lead to rejecting otherwise
> valid programs once the loaded byte is used as a pointer offset.
>
> This pattern is not limited to hand-written verifier tests. clang
> 22.1.6 at -O2 and -O3 emits it from a small helper-based BPF C
> reproducer; the resulting program is rejected before this change and
> accepted afterwards. No deployed-program regression is currently known,
> so target bpf-next rather than bpf.
>
> Teach the variable-offset stack read path to also consider STACK_SPILL
> bytes backed by a spilled scalar constant zero as zero bytes. When a
> zero result depends on such a spill, mark the contributing stack slots
> precise before accepting the const-zero result so pruning cannot reuse a
> zero-spill state for a later non-zero spill state.
>
> Keep fixed-offset stack reads out of this eager precision marking path,
> as the new behaviour is only needed when filling a register from a
> variable-offset stack byte range.
>
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>

This looks like a bug fix for the variable-offset stack access feature.
The commit message describes that mark_reg_stack_read() only treated
STACK_ZERO bytes as known zero bytes, causing the verifier to incorrectly
reject valid programs. This behavior appears to have been introduced when
the variable-offset stack access feature was added in commit 01f810ace9ed3.

Should this include:

  Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27465403255
--===============8935061741098376344==--
