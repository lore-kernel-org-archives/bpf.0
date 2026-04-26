Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22497083C
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232786; cv=none; b=jcjB28Z2Twfr2aiGMwXyuB5zEXSXoSd8nkiOEaVnVXT1cPGXRsYCn9kgvbSCWMpOO/ogkzPlN/Sqkcuz45gzgKxoRbNl+Yb6Syj2v7BNXZ1WTXobX8kAJCWtrC3G5VjQgjRWGKIzrSYW6WqZ2/HjuuAVnuio4nEY5a0XU8miiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232786; c=relaxed/simple;
	bh=V73rgJKu1hVKzuUZmHQaxR0s32/DW4RQ1pGuzYnaYCI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hXEftaWyVrUEuQNDKpzeNRo28DD5tIOtFCbl5QScllk7T1Mg/BJQ41cANmGrf8kAbmEEP0SF36lBTRzP5hd9OJO5BgBj9Ddp12beOO4i7xgdAFzt99Wbich3m2GiuEA8oWh5nxxwK55yBEK6LAYBwV1jw7CEaG/KhUveCAGVQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT4xMl7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT4xMl7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D08BC2BCAF;
	Sun, 26 Apr 2026 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777232786;
	bh=V73rgJKu1hVKzuUZmHQaxR0s32/DW4RQ1pGuzYnaYCI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nT4xMl7MKwL6kzodA9qz2U0l6GEl7J3qeFtq3LtiKSY+I6UHDamXE2S3QrXmWpGEm
	 PCt/h/bZg7O1EoyTtgrvklXNsrMDcIzUIZT7BEHc32U8TXo6KuUidjp8lsdNVx5Ezj
	 X/HF7kapHfCQLLy1/zgrjG81UTmC8WOEA85rcAMPw8mLBKFt4vXGqOo57eQgfa5ZqL
	 A08lk75j+wjlX4AbEQEtY3PKN3kbbat7zscAjp/nruaKXIvkCCJxYmAwt9H/oFX42Z
	 72UPE8rR7dMStKv2A0/zZmVq2sGELbFTpX3vgWdmn/erWnlkGs6S/+UvdsXCgupLRk
	 oSKD7d0N6fJag==
Content-Type: multipart/mixed; boundary="===============3191914057017115011=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7ba54d5c33e4cc8382b0f5f1d36666cfd42e59dffe46736a256b5f68279c60e6@mail.kernel.org>
In-Reply-To: <20260426190338.4615-7-emil@etsalapatis.com>
References: <20260426190338.4615-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v9 6/8] selftests/bpf: Add buddy allocator for libarena
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 26 Apr 2026 19:46:26 +0000 (UTC)

--===============3191914057017115011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> new file mode 100644
> index 000000000000..00e2437128ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h

[ ... ]

> +struct buddy_header {
> +	u32 prev_index;	/* "Pointer" to the previous available allocation of the same size. */
> +	u32 next_index; /* Same for the next allocation. */
> +};

In v4, Alexei Starovoitov requested a mathematical analysis of the memory
savings from using u32 indices instead of pointers in this structure:

  "BUDDY_CHUNK_ITEMS is used like NULL? The header is u32 + u32. Is it
  really worth saving 8 bytes? Use two proper pointers? How many headers
  are there? ... if everything is a pointer the whole algorithm would be
  so much easier to understand. Is it worth it to keep indices vs
  pointers? Please do the math and explain the savings."

  https://lore.kernel.org/bpf/CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=ipffWS4GVNg6rFQ@mail.gmail.com/

The response explained the rationale for ASAN effectiveness and memory
corruption protection (headers in free blocks offset at byte 8 to catch
off-by-one errors), but did not provide the quantitative memory savings
analysis that was explicitly requested.

The bot in v8 also flagged this as unaddressed:
https://lore.kernel.org/bpf/f6f35b4cb34724773df4e2f2d5014f64048931cd6eeb747875a84f3a9d1db4ed@mail.kernel.org/

Would it be possible to add a comment documenting the mathematical
trade-off analysis, or include it in the commit message?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24964771851
--===============3191914057017115011==--
