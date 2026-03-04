Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A735CB71;
	Wed,  4 Mar 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665352; cv=none; b=Iyy8vtQxAvhcCUWUIeuVZNgEQLhK66OBxGJo5S6vdS0Fo6obHZos2OwjKRvKq9nmS9WGmEodcuiVskOIa7u8aCJsQHAHZL0RrTY1YhtEtJ7pmbs2vJc+f29DcvDg0ZSXJupKoARweJCmBr8mJPelzx4KCapZr+XcOasLU09bAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665352; c=relaxed/simple;
	bh=KXNBj/4X6RF8QorgSVolwBTOAIpxZG7Q1ec7vjTFzag=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fb3PMYjfFxWK+tHqitjG5MndMWOa3aGBK7GuYjeDbKLYTu2nEcLK4ml+iX2EFG9YJKZ9w38/+gmfJ/fyFujnmjGSwzoSB7Jik0oF/oa9qceODmyddslujm5/kFdYwyMJBod6+g8tcu9gJvozfQea4i2vdamDqVoW10gPO5hRluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sndp0wcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sndp0wcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C651C4CEF7;
	Wed,  4 Mar 2026 23:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665351;
	bh=KXNBj/4X6RF8QorgSVolwBTOAIpxZG7Q1ec7vjTFzag=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sndp0wcD/KwJ0XmlBjVXyqcMQkobz+oQWOmS2bFJxTZvQ9xRg+u2Fg/+S8gqhWJ1a
	 gwnIkV8zwCGquSWe7i+BW4z6Mr1WdRgzs5o6NTUBRUMsZAr8AvibPwFripJoGeaQJO
	 zke47HRjJzlwIWbxaN8WCbFTBEII7a98Vor7g84sGME2VmsAKxnVtfchAxliu62aOH
	 moAAjYSIzJDO7mWNz3iruLpgJ60hD0xWY4ztqv4dDytopPEMYoWP7wx0H4PxqfndWG
	 l2biGjmIlPuhSmspOzyj6pj/bsi90VyMkedRocqjhiEywC34a8tJx/kgMT7xfjQTqs
	 RfWQrxJ+Cf4ew==
Content-Type: multipart/mixed; boundary="===============2550562903296017055=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb15f21a9af1489fe2cee94afb78dd423be2a7a77b3dee5ed8b286dcef45f034@mail.kernel.org>
In-Reply-To: <20260304222141.497203-9-jolsa@kernel.org>
References: <20260304222141.497203-9-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 08/23] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:31 +0000 (UTC)

--===============2550562903296017055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e2f4a15886b0..c42bf16b6807 100644
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
> +		free_ftrace_hash(data.unreg);
> +		return -ENOMEM;
> +	}

If data.unreg allocation fails but data.modify succeeds, only
free_ftrace_hash(data.unreg) is called (which is a no-op on NULL).
Wouldn't data.modify be leaked in that case?

The attach function handles this correctly by using
free_fentry_multi_data() which frees all three hashes. Could the
detach error path also free data.modify?

> +
> +	trampoline_lock_all();

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============2550562903296017055==--
