Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102CF2BDC28
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624256; cv=none; b=l9DnmhtcbH9zem2dxDB6SpzKoNT+1DedC1tx5mIQQdU2grTyeLi3vxnMcwi+utx1mKIcCwQbJQY4V0t4lqART+OSLuj9VopKwFRQWVycW5iwV7WlpcAO1vN+a1ooUMNPyyZPaW8NG+sx6DgCxcGlGV5HgSNTU26RMa5pJWRQzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624256; c=relaxed/simple;
	bh=jA6199zWAsmMu91t84dgGt+OcYeYbUJNZ4axBneW44k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g9hLSz4FXomSdl6pUlGzO4oXGngg9E/7Ueh7Q1GJs6Kum4+0BlPkNWeYPMFCRcrRmIHXDvFyedZ4jiJa25xacqT9nQ3v5PCR5rfF4OB65gcjV5Ilv72an/O3aXf7HE+OQxqQ4ORn75eBQF0EVcO9sGT9pwD/bWEUC413equnX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikQ1jqQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikQ1jqQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7763BC116C6;
	Fri, 20 Feb 2026 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771624255;
	bh=jA6199zWAsmMu91t84dgGt+OcYeYbUJNZ4axBneW44k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ikQ1jqQ7p2fVH/MQXF3tkeqKkPBliTeAgC3WLrO0jA/0ufB2RRrw9HCAdnfhgP4du
	 OIDGhuAmEFpsAOBVQ9pwBXd4E7zY5g13IbD0ElloqkRKE2s8L5iMrb4p6+tfVUfFEZ
	 JBHo9UGyppilbI35G5X7NyI7ynYsvw/tveU72b/1FvCd1DaUUTpQ9meBrlQDfQvyN7
	 9AaE4T9XwyzselK2ryEiUV9A87tpy/vnfp+45NCqbOJF148JWp1oSL82HiUesDXVUC
	 tc3t2fh1YeBpvLPVMKoQvX8DkjC+Jv2xHsAa255vpVEvROEAnsSSLQyRPT8ggLBJ7Q
	 zvWWeBjXGZGVw==
Content-Type: multipart/mixed; boundary="===============6835152455551477954=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b568451cfe550061db50e9e156c9f76d74a48a0b0f7d0f0a685f9f6c1f09102f@mail.kernel.org>
In-Reply-To: <cc99c07d83640039d170d20ab57c83bb7cfd2398.1771622266.git.josef@toxicpanda.com>
References: <cc99c07d83640039d170d20ab57c83bb7cfd2398.1771622266.git.josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/3] libbpf: support appending split BTF in btf__add_btf()
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,bpf@vger.kernel.org
Cc: noreply@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 21:50:55 +0000 (UTC)

--===============6835152455551477954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2004,24 +2004,47 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  {
>  	struct btf_pipe p = { .src = src_btf, .dst = btf };
>  	int data_sz, sz, cnt, i, err, old_strs_len;
> +	__u32 src_start_id;
>  	__u32 *off;
>  	void *t;
>
> -	/* appending split BTF isn't supported yet */
> -	if (src_btf->base_btf)
> -		return libbpf_err(-ENOTSUP);
> +	/* When appending split BTF, the destination must share the same base
> +	 * BTF so that base type ID references remain valid.
> +	 */
> +	if (src_btf->base_btf && btf->base_btf &&
> +	    src_btf->base_btf != btf->base_btf)
> +		return libbpf_err(-EINVAL);

The comment says "the destination must share the same base BTF" but
the condition requires both src and dst to have a non-NULL base_btf
before checking. If src_btf is split (base_btf != NULL) and btf has
no base (base_btf == NULL), the check is skipped entirely.

In that case src_start_id is computed from src_btf->base_btf, and
the remapping loop below leaves type IDs below src_start_id unchanged.
Those IDs reference the source's base types, but in a non-split dst
they point to unrelated types or to IDs that do not exist at all.

Would this be more correct?

	if (src_btf->base_btf && src_btf->base_btf != btf->base_btf)
		return libbpf_err(-EINVAL);

This rejects src=split with dst=non-split (NULL != non-NULL) while
still allowing the intended same-base case. For non-split sources the
first condition is false, so behavior is unchanged.

> +
> +	src_start_id = src_btf->base_btf ? btf__type_cnt(src_btf->base_btf) : 1;

[ ... ]

> @@ -2074,11 +2097,16 @@ struct btf_pipe p = { .src = src_btf, .dst = btf };
>  			if (!*type_id) /* nothing to do for VOID references */
>  				continue;
>
> +			/* For split BTF sources, type IDs referencing the
> +			 * base BTF (< src_start_id) remain unchanged since
> +			 * dst shares the same base.  Only remap IDs in the
> +			 * split portion.  For non-split sources src_start_id
> +			 * is 1 so all IDs are remapped as before.
> +			 */
> +			if (*type_id < src_start_id)
> +				continue;

This is where the gap described above manifests: base type IDs are
preserved as-is, which is only correct when dst actually shares the
same base.

> +
> +			*type_id += btf->start_id + btf->nr_types - src_start_id;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22241837035

AI-authorship-score: high
AI-authorship-explanation: The commit explicitly includes a Co-Authored-By: Claude Opus 4.6 tag, and the structured bullet-point commit message style is characteristic of AI-assisted authoring.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The validation condition allows split BTF sources with non-split destinations, silently producing corrupted type references, but no existing in-tree caller triggers this path.

--===============6835152455551477954==--
