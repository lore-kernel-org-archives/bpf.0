Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF574A33E1
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657485; cv=none; b=smxp9dv/5LiJpzPjjn8MJisbe3KiY/I8txnQH9z8AaESIbHrYOIWvXCJmYk9mDZsLZjysan4pf2zs1rD3Mv89Q9ESisdc2jrByWe7duxF2K1cJc5rhPs5WQa3AQDdNAH/PFf8LONAjDFmxJbW358Pnbp5QEHm19S+zRNGl+LWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657485; c=relaxed/simple;
	bh=vM4q4ahwHf8n8FYZbA/Vd07heuW1SM2oXM8fb2Qrk+8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t/VO3d+oqNV1ll3grWzT6IZIP5g0YE8oUPf9ZmsUcgOGjLV5MyY0nadMo9aiAACFXpTByuVGwAjezZWT5jjApC3QYEDQ1G7tDgpxU4yAQ35doSc3XUAESVcg+SB3lIDPgpG/Vb5KdYz23bXLTI3i39sCzt/XDh1/4YTjub5ALLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewXg4Gs4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewXg4Gs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348591F00A3A;
	Thu, 13 Aug 2026 21:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657483;
	bh=UZd3RDx3PDUkMWRVUSXtfD5ca7mkfkNRHt0ONkNTIds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ewXg4Gs424QGfJiVrejeSxkPSlKVrPmgHl9ypq+8FqS0H9XCM9MiM0t8X+kV+JqPl
	 xXBTCofAFKcxE/z7ON4J3yADxwAu3exRyTo2NPmw0PDolHjb//w83kjlk2pzowBl9s
	 pJv3VN48fnKg7ooepEZpUceaSv0SgM2LaZTIfK+b8pCroxD/eVmYmpoURcJEhvB69D
	 zf1GWgkzrnxqw9/3Q9moOX2S37KzZWzRzOwjbv5yVqgerNJUHU1/mOqZg1Wk/+pBcj
	 0nW99sfjtsqAwPKzlSQR7sqfd7kPJMYzBLuORv4fJipvGaKIhZIKKVveJEQniTo6Do
	 g5l0jR25wqvIA==
Content-Type: multipart/mixed; boundary="===============6562638934275398395=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d2d0f3a003386d4c2a47d4621df47a7c56707accdc8eefe4ae9f63028fb68a4@mail.kernel.org>
In-Reply-To: <20260813204032.644949-4-daniel@iogearbox.net>
References: <20260813204032.644949-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add tests for pointer type merge at a shared load
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,eddyz87@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:44:43 +0000 (UTC)

--===============6562638934275398395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
> index b91271d4caa48..127b745bb0b7d 100644
> --- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
> +++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c

[ ... ]

> +static __noinline u32 *get_mem_or_btf_id_addr(u32 *mem)
> +{
> +	struct task_struct *task;
> +
> +	/*
> +	 * Try to avoid compiler hoisting load to if branches by using
> +	 * __noinline func.
> +	 */
> +	if (zero)
> +		return mem;
> +
> +	task = bpf_get_current_task_btf();
> +	/*
> +	 * A plain BTF pointer walk yields a bare PTR_TO_BTF_ID, and
> +	 * task->nameidata is NULL unless the task currently is in the
> +	 * middle of a path lookup.
> +	 */
> +	return (u32 *)&task->nameidata->flags;
> +}

[ ... ]

> +static __noinline u32 *get_rdonly_mem_or_btf_id_addr(u32 *mem)
> +{
> +	struct task_struct *task;
> +
> +	/*
> +	 * Try to avoid compiler hoisting load to if branches by using
> +	 * __noinline func.
> +	 */
> +	if (zero)
> +		return mem;
> +
> +	task = bpf_get_current_task_btf();
> +	return (u32 *)&task->nameidata->flags;
> +}

This isn't a bug, but get_rdonly_mem_or_btf_id_addr() looks identical to
get_mem_or_btf_id_addr() above (same signature, same branch structure, same
BTF pointer walk). Since libbpf appends a referenced static subprog to every
main program that calls it anyway, could mixed_rdonly_mem_btf_id_type just
call the existing helper?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31743446421
--===============6562638934275398395==--
