Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584023C4F3
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540609; cv=none; b=hdcGY59paANELCRBLwBNImZ3V1S+EGjcNZnB/WIPaLbLtKD4eeQ3lkeHNghEJ8nrSQ36ZTGDwEcvKcpLIzgHW7s85w9Jv+84RDzUdo1RxLVMoRhoAPFygSni8e4JAdAH58H90eFzLFSStAA+SjqQHZvk2KYhfumSbBIkq9ZdUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540609; c=relaxed/simple;
	bh=X3k9SdyuA+m9e5NzDahAOsMvPt3HDEPdfCm5GfWa54Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sUKdJDSxZsw8rEIUzFr7UG9O2tlNitfpaT21W0NmQdhNknTZCAiuWXPhJRlitSudBejUl6UFLCFLQiZEF0ah4bg525TxFHv4JjNZuvNHzJf/uOjZsPi4euAWEcIIJ1Dc6xeLPETrehhr05frNDeeepzi7lj5KfdvwN57g3phul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM1JBo4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM1JBo4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0357DC116C6;
	Tue,  7 Apr 2026 05:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775540609;
	bh=X3k9SdyuA+m9e5NzDahAOsMvPt3HDEPdfCm5GfWa54Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GM1JBo4WI+1Dmc5Z9GBlpcSRUJrwYpD5i/rJ0mf0K9o2JmFjLts+BUtCTX1GNCsSX
	 UnNzvTVWTNNOAX1wyQBAlL27MGAU8SSlQS5PktH4W1R17daZ3S5+4jc8SIWdwHkcto
	 uzvjcDlMW9eKsRuULnoN9mxuGoq9Vj9YOIDYzk4i8+8xWFeO3zS1K5452qgOJhYreF
	 TD/5WGKu350jrLybK+rOGeYLJHgnrHgRDaml2E5f8Tn6FsCdffn6eBxBvaMxv6p9p9
	 +lXe41MZuSj2VQKTSD7PPUqU0ffxRUyt/tO2VhLikTF2TTYHd1Yslqg4n/MGntq1Vo
	 ATPJ05U9TpYrw==
Content-Type: multipart/mixed; boundary="===============7018480421653137301=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cdf2be9110da344647f88bc76fc7bc9b7ee91cb8f27354a84ab57e6955ff783d@mail.kernel.org>
In-Reply-To: <20260407045730.13359-9-emil@etsalapatis.com>
References: <20260407045730.13359-9-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 8/9] selftests/bpf: Add buddy allocator for libarena
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  7 Apr 2026 05:43:28 +0000 (UTC)

--===============7018480421653137301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> new file mode 100644
> index 000000000000..4343e39760ab
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> +static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
> +{
> +	u8 result;
> +
> +	_Static_assert(BUDDY_CHUNK_NUM_ORDERS <= 16,
> +		       "order must fit in 4 bits");
> +
> +	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
> +		arena_stderr("setting order of invalid idx\n");
> +		return BUDDY_CHUNK_NUM_ORDERS;
> +	}

This is a getter function, but the error message says "setting order".
Looks like it was copied from idx_set_order().

> +
> +	result = chunk->orders[idx / 2];
> +
> +	return (idx & 0x1) ? (result & 0xf) : (result >> 4);
> +}
> +
> +static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
> +{
> +	u64 address;
> +
> +	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
> +		arena_stderr("setting order of invalid idx\n");
> +		return NULL;
> +	}

Same issue here -- idx_to_addr() converts an index to an address, but
the error message says "setting order of invalid idx".

[ ... ]

> +__weak int buddy_free_internal(struct buddy *buddy, u64 addr)
> +{
> +	int ret;
> +
> +	if (!buddy)
> +		return -EINVAL;
> +
> +	if ((ret = buddy_lock(buddy)))
> +		return ret;
> +
> +	buddy_free_unlocked(buddy, addr);

Should the return value of buddy_free_unlocked() be captured here?
It returns -EINVAL on error (e.g., unaligned address), but
buddy_free_internal() always returns 0 after a successful lock
acquisition regardless of whether the free itself succeeded.

Something like:

    ret = buddy_free_unlocked(buddy, addr);
    buddy_unlock(buddy);
    return ret;

> +
> +	buddy_unlock(buddy);
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24065579421
--===============7018480421653137301==--
