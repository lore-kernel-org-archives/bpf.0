Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA473FADF7;
	Fri, 17 Jul 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295594; cv=none; b=C/i3XaYMNHeSaf1GUnpukUR7xnsM8kJlMleGUjDTkVMZQDl0UX6illxYb4sOMpOKDgsnDAs0KYz64Dkg6HHdk1tWFl0XsyBoWWEcrvKXGFOPmjWsE468ttbbEPmkGwIx6KJUHfPCyfb0uNr1/nlFB5BogI5amU6MHp+DgFs2tU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295594; c=relaxed/simple;
	bh=r6IotnTKVygiKU6UYYfwUo/IEGkYtQtM7Ccok2kFVNA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=A3JqGrTBvLXU1MYC1fkpBwluLx0cJCMFWGKYgEtjezBsBzJhVGIQysI8eNYIjiqRGT4jIbXfcYiKW6FBW5kICs+NaWQLrj1l5njc/RC90rj8L0aLJwkRb9b9ZY6yXhyp1L/1iAZ19/U0FRUIYlVQLJ4vXOtqlvhYQI5L9v72oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLTNWQ/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLTNWQ/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722081F00A3A;
	Fri, 17 Jul 2026 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295589;
	bh=8dKjV9J7mSDwpPNf/dtsVoaiOrUJ4UDn310tC5VmjjU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NLTNWQ/bMLw58ivZQrEqQWx8Mxs9brxlUPo+Tdin3h9pdxLCeHEa0rZo+m4gFz4pg
	 Iyt+OQ1wSKURIblMZHp6wXwERZOA+u+a+8P1yxE6CPOEV7A4iqnQHBABuRQUIS9tnn
	 M2rQb8oHatJb/dLd1Jjbw3WuEL7px8BrkNum1mHImjRXzja6hzyrNv983I92JfrvfB
	 rW/ESDOn7WqEiIF/vDVIVW3WRFb9HMJLMEt1hm947zqBZP+SRXQJQBU2xLtJg2ZBfi
	 XlLC8M+FyLUuG8hkOYiHbbdXfUWuCyKY3Rs3U7X7XxqnWKgiuAlx4pL6yf4RC76qiV
	 SwtMmkTLyaUUw==
Content-Type: multipart/mixed; boundary="===============6957346281921798468=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c2d83f4a75b2084a2db6a3b0895ae6781284385e7768a3e72d65db71c410a9f@mail.kernel.org>
In-Reply-To: <20260717-c10-031-public-bpf-next-v2-b4-v2-2-54b555443a7c@mails.tsinghua.edu.cn>
References: <20260717-c10-031-public-bpf-next-v2-b4-v2-2-54b555443a7c@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover scalar arena frees below the base
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: chenyy23@mails.tsinghua.edu.cn,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,emil@etsalapatis.com,puranjay@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Jul 2026 13:39:49 +0000 (UTC)

--===============6957346281921798468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Cover scalar arena frees below the base
>
>     Add a verifier_arena case that fills a two-page arena, calls
>     bpf_arena_free_pages() with a scalar address one page below the arena
>     base, and then verifies that another allocation is still rejected.
>
>     Before the runtime guard, the invalid free can repopulate the free
>     tree with an out-of-domain offset and the final allocation succeeds.
>
>     Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>     Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

This test covers a memory-safety issue where bpf_arena_free_pages()
accepts a scalar address below the arena base and repopulates the free
tree with an out-of-domain offset, so a later allocation can return an
address below the arena mapping.

The clipping logic in arena_free_pages() that only bounded the upper end
(uaddr_end = min(...)) without checking full_uaddr >= arena->user_vm_start
was introduced in commit 317460317a02a.  The paired kernel fix
a6ceda1f4a47 also carries that tag.

Should this include:

  Fixes: 317460317a02a ("bpf: Introduce bpf_arena.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29583169394
--===============6957346281921798468==--
