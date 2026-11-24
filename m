Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502440;
	b=4iFbP1UAgSNPzkjlcOSwULZ6ePUSM2TvIbfw7fiQHKZEn6jFQbFK9CmcrEcly41lfGRD
	 WQBc/ul6Ti4LZ/ZUbFOmkTd/se3w8sRaCP6JDkeVZ0j6BxDEPuEdZ4YpDT96/BZE397yE
	 uEjuchn5qjEjv3AP8zENe/sgu3+R+xGpaZ7IThCxCYpdrZbwOo4kl8pENS94Q6fADOa93
	 GZcGEZLUb0eUAvovrqsnSkXQ1zertqZQm6cKslesavRJTFlcyTEmAssX05e0UDA3XdANm
	 1P8I5Xt4GMJAU2uQel64beSErCyPgzU05A7gTMwJ+RGsNhWnsOrY7bdayfjLBgaQ98A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502440;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=6WFerpAEDPPZoYfahZkr407WjSJi5LZr5IZcjQ9ww+I=;
	b=x/FsZPp7wJxFizDu+hXO9/oq40tADVGUf6yCr4GDGL47UuFzFzDc9PT9Lqv/f++vADNM
	 SKZ0GgbpsgZM4+3wRAO8EgF7SirI5toSGC9FeJ/4dF+9XelcKuiYpUB0C24q/kLJAVso9
	 zPN1sierE+INIwJUMzEdCF9NEihiV5e2rbp8ICO/K0CyIctqZTdi1TdwlOgHtrdSfTnAP
	 WeTzjGWBIHB23c5sHcvAWqPtKPRGfImDAL/Gi0aTKffuxPEYwM7EPtCBFBMYacuGGkxnF
	 a6V78GORdjjubjxC6d4FW8HdEY/2F+kPp71BME9gGN79eXSTb7pNc3YoHHoSVadtHyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1sQlOgd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E7606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1sQlOgd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706771F000C6;
	Tue, 24 Nov 2026 06:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795502439;
	bh=6WFerpAEDPPZoYfahZkr407WjSJi5LZr5IZcjQ9ww+I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=G1sQlOgdXboFeNQ+KiVgnD5bcUxXWh6Z6e+vkWWT3OrcXXskKinaxuSJDR/Iqe+sH
	 g6SnsZirDlGUlPwqVk4CGQB+FVcGXWjoGRHJe14E7cpRuHwRQvnqQz/NPbJePGCfkf
	 pKqVX76t5tFdVuwYOVyD2fW30SXH9S9QKE0vyQb2Inl7IKdmJcVIcmmsZX0UaX7ovw
	 SO6A3ynTDvA+ZjTRxvx6f0LTmVw1d6rr0ltCiQK17ihLF6C24khBcZqTNNiQWprLGI
	 JmH7wqVJ6wLoqnD/tVIZ71eETzoEVOKtxLMKit1QHusiTUUlGswsdcz4kTMy/xXAR9
	 dwB5MF9+78Z+g==
Content-Type: multipart/mixed; boundary="===============6683580502245986455=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8d25053c76f38cd6fb9de7b1141a9221b1298eea6dbe4b8f8a976bea86086c7e@mail.kernel.org>
In-Reply-To: <20261124060357.11700-5-emil@etsalapatis.com>
References: <20261124060357.11700-5-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Test kmalloc variant selection for task storage
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 06:40:38 +0000 (UTC)

--===============6683580502245986455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test kmalloc variant selection for task storage

TL;DR: Nit only, in the selftest: the bpf_map_kmalloc_nolock fallback and its
comment look unreachable, since local storage doesn't call it in this tree.
Could both be dropped?

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c b/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c
> --- a/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c

[ ... ]

> +	/* Task storage uses the nolock allocator until the fallback is added. */
> +	prog = skel->progs.on_nonsleepable_alloc;
> +	err = bpf_program__set_attach_target(prog, 0, "bpf_map_kmalloc_maylock");
> +	if (err == -ESRCH)
> +		err = bpf_program__set_attach_target(prog, 0, "bpf_map_kmalloc_nolock");

This isn't a bug, but is the bpf_map_kmalloc_nolock fallback still needed
here?

bpf_map_kmalloc_maylock() is added earlier in this series, and local
storage does not call bpf_map_kmalloc_nolock() in this tree, so the -ESRCH
branch and the comment above it look unreachable.

Could both be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45338923700
--===============6683580502245986455==--
