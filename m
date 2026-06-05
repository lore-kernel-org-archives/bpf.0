Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7647F2E5
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646263; cv=none; b=pYnxAhlY1lRXU3WEcrrR+TbFDKNanBNpUcXfvHG7F301mP1NvtlVBZD5eAObVasOYozokuvwad7mANpscYaYmtwVyvAujjtF0l+shPW/4nHyG0/0rv7Z6tt8RRm8YNH1U/6GIFYEu6fCSkpmzSsOcaWFEINNG8bImUy1zHaECW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646263; c=relaxed/simple;
	bh=7PTjVIJj5G9IN7yDeG34h052xZd5Z0nrXOlAgGam5K0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g1zb3RRq8XzF2Wdmw2Z0nbkh4CSedhKD53Fe0+wFsHPOZwQAXrQKm8EiHzgC/H+9W/qk/5HTapxRe/eK33//YDnLshpLvlnw9hFHGkg2fU9UudYHtvg4guwsVyZYSjsDbcKSY17V/dIK5hfjFBlwKVmaJ6lxvSbJ6HtgdMVFzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbhzzp7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbhzzp7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338C1F00898;
	Fri,  5 Jun 2026 07:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646262;
	bh=TTq/lvSPmtam5XQ396a7njZXh4K+b5kHTav5vGp8H80=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cbhzzp7+JKHsr+NdbKQstWr8H1p6Xt8iONxINrFvabfjm89RMt+S6dQICxNV5nmwP
	 MzKw/lKD3/JCasYi4oFugaCVc7yPob1IgelyrFZZzVzANmMMFgiPLsxKK+jKpkhBCl
	 m6R8KzyQX2djkThyODBiHPloQkz6Pt+DJanBx9hgJGTiK2vOno1Vkkg9E9xNBquD4P
	 XNpduzVaXeeY74TULORsn09HFMHmYQMthB256jkIeCYciozR1WD1egOyyPmOx0oYIs
	 0jKAogTh6KHiyVcRQsfoKlcbaXlHnaLJ2JyKR+uwTyLcS96GysfwUi7aPW3KnBcwAF
	 fk+6eGaJmwFlA==
Content-Type: multipart/mixed; boundary="===============2303025633360591505=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fbfd6c93648afc57326ad44ad5fd9d6ae5a4e403b2a279a8298e8423751c9379@mail.kernel.org>
In-Reply-To: <20260605063412.974640-5-memxor@gmail.com>
References: <20260605063412.974640-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/17] bpf: Track verifier branch diagnostic history
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:57:41 +0000 (UTC)

--===============2303025633360591505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c248ff41f42a..55921b8a5d5c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 652d4627c2b0..50cc50a394ca 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> +void bpf_diag_copy_history(struct bpf_verifier_state *dst,
> +			   const struct bpf_verifier_state *src)
> +{
> +	struct bpf_diag_history_event *history;
> +
> +	if (!src->diag_history_cnt) {
> +		bpf_diag_clear_history(dst);
> +		dst->diag_history_omitted = src->diag_history_omitted;
> +		return;
> +	}
> +
> +	history = krealloc_array(dst->diag_history, src->diag_history_cnt,
> +				 sizeof(*history), GFP_KERNEL_ACCOUNT);
> +	if (!history) {
> +		kfree(dst->diag_history);
> +		dst->diag_history = NULL;
> +		dst->diag_history_cnt = 0;
> +		dst->diag_history_omitted = src->diag_history_omitted +
> +					    src->diag_history_cnt;
> +		return;
> +	}
> +
> +	dst->diag_history = history;
> +	memcpy(dst->diag_history, src->diag_history,
> +	       src->diag_history_cnt * sizeof(*dst->diag_history));
> +	dst->diag_history_cnt = src->diag_history_cnt;
> +	dst->diag_history_omitted = src->diag_history_omitted;
> +}

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a..d60e1309957a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -1624,6 +1626,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
>  	if (!dst_state->jmp_history)
>  		return -ENOMEM;
>  	dst_state->jmp_history_cnt = src->jmp_history_cnt;
> +	bpf_diag_copy_history(dst_state, src);

Does this cause massive memory bloat when verifier logging is enabled?

Because is_state_visited() caches states by calling bpf_copy_verifier_state()
and adding them to the explored_states list, the diagnostic history is copied
for every cached state.

Since the diagnostic history can grow up to 1024 entries per state, caching
this for tens of thousands of explored states could easily lead to gigabytes
of wasted memory, potentially hitting memcg limits via GFP_KERNEL_ACCOUNT or
causing -ENOMEM specifically when a user enables logging to debug an issue.

Because cached states are only used for state equivalence checks and precision
propagation, neither of which use the diagnostic history, could we avoid
copying the diag_history into cached explored states?

This concern was raised by sashiko-bot@kernel.org at
https://lore.kernel.org/bpf/20260605065017.D9F401F00893@smtp.kernel.org


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============2303025633360591505==--
