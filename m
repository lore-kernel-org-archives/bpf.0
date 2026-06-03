Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD23D8115;
	Wed,  3 Jun 2026 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486616; cv=none; b=MCqKUlZkpbY/tgIKu67mlGDeGMpq4Waw3VmT0oXkMrP4172iLrXMkgfObp6FMkvPTzitBYHt1EDxowGV0PhzrMa70YHjw/C29XgC/K74jhzvbWybOD6gb8rMfbdRbRyJO5E9o0uXGoQ8/pBtuc87e7aUhJl+5KZu4KYzzGj4I24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486616; c=relaxed/simple;
	bh=YW8kkIJdYVeZe7qZ9DgM8Kkwybil4J2n+LDNMDCmHJM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lpmrBnqKX4NCq3iTliuX+MePB33EQFFiEbUcmJmMYL+yomXx2YvBI0Y4gK9cuDxlCHYye+Z0B4zhqkoVbaQzC5qEBbpBWVDmUcBvwLKkrHHPuZTgcoyYdXLvTg0cgDQkXUNIaJVtlyL4ettEzIbS+Rl+5MIuB8VQBpbamzOUGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czyAk7CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czyAk7CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBDF1F00893;
	Wed,  3 Jun 2026 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486615;
	bh=ckAkhNJD2MZZQw23jIrGRMI0F7mneyfTDmFw0mOfiqg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=czyAk7CSGWhr2hJcDvGnYWYFTvWkDLNjD245yUysLBLv7jtPEnPdoQOuehXrxB+wD
	 0TDxZBBa32aQnmjxHNxVzxvNbd4xcCUt8yqb0Dil3uFswDFy4OGuiZa7tsM4cXKHZd
	 vlttOuddxgtI/lUhjp96vrgW8av9EBirtyjBZSmIsVoY11g0WqafIhy72c4AmZggZf
	 xeovQlRAdcT0wlRgnKRA6eFg9vibn4QGU8evDDfqK4tv8mfZlj/zvc05fsq1K8WU8N
	 TqdmZUBpFMA2PQOlstfxvC1t2M7GzN1SPCWm9/8cSqcanYgncDVeK4AYbDXgT5nHxU
	 9Wg4Nmr3kvkcg==
Content-Type: multipart/mixed; boundary="===============6897628447651191803=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <834bf41fbb40c56f79fc5442688b6aa410fa1d3f4a87af31f11c34b40cd14c21@mail.kernel.org>
In-Reply-To: <20260603105317.944304-2-dawei.feng@seu.edu.cn>
References: <20260603105317.944304-2-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v3 1/3] bpf: NUL-terminate replaced sysctl value
From: bot+bpf-ci@kernel.org
To: dawei.feng@seu.edu.cn,martin.lau@linux.dev
Cc: emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kees@kernel.org,joel.granados@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,jianhao.xu@seu.edu.cn,dawei.feng@seu.edu.cn,zilin@seu.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 11:36:54 +0000 (UTC)

--===============6897628447651191803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> When writing to sysctls, proc_sys_call_handler() guarantees that the
> buffer passed to proc handlers is NUL-terminated. If
> bpf_sysctl_set_new_value() replaces the pending sysctl value, it can
> hand a replacement buffer directly to proc handlers. However, the
> helper currently copies only buf_len bytes into that buffer without
> appending a NUL terminator, leaving downstream parsers vulnerable to
> out-of-bounds access.
> Fix this by appending a '\0' after the replaced value to restore the
> expected sysctl semantics. Since the helper already rejects buf_len
> greater than PAGE_SIZE - 1, there is always room for the extra byte.
> [ ... KASAN report snipped ... ]
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

This looks like a fix for a bug introduced when the helper was first added.
The pattern this corrects, the memcpy(ctx->new_val, buf, buf_len) without a
trailing NUL together with the buf_len > PAGE_SIZE - 1 check the fix relies
on, was added by commit 4e63acdff864 which introduced
bpf_sysctl_set_new_value().

Should this carry:

  Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")

The bpf CI review bot raised the same point during the v2 review:

  https://lore.kernel.org/all/12a9251e9f1a616fc86f4a2b6a87e547d75f820ce517895cdbf87bae81c970f1@mail.kernel.org/

  "This fixes an out-of-bounds read in bpf_sysctl_set_new_value(). The
  missing NUL terminator after the memcpy() of the replacement value looks
  like it was introduced by the commit that added the helper. Should this
  carry: Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
  helpers")"

The v3 commit still has no Fixes: tag and that suggestion does not appear to
have been answered. Without it the fix is unlikely to be picked up for stable
backporting.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881443787
--===============6897628447651191803==--
