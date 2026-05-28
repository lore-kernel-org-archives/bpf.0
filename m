Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF90408010
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992814; cv=none; b=tKTC56+ukU2ya+qeDrw59cvaKlXCRBA+wM4xhq56348FYMaNPPPG/284S/T8gNmbV24wPTe4G7F3F0lsvmQE5TL6MFoEHgOO+v2CgGdYD7xWlMlLOxEOol3CzWZ7OswgoZ6fGDR/EFyMYXi8+WUzg7xsAtUcNNfIyrqqIkE8Isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992814; c=relaxed/simple;
	bh=2cpgbS2B+eO+wCw+HgnBv/jFrJgaDVRQY9LXL1KNIO8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ANXf8Gw2Kb5CmRNLUyQdm0jF4rfT5dM/uZgGLOePodWP+FtXqaUpHPOdeg9cGbNLHHXcOalbC0Fo3YaDWoD50nwSSGP6Tv3S9VZ+BzhOYiR6i1nFQaz7UtnFIbHzBuVUB/AVBAmrrIN8uVFqHaGz4bg0mZO+N2Dzs9hKr/fWD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqUnh9tA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqUnh9tA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A011F00A3D;
	Thu, 28 May 2026 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992813;
	bh=xWKkdMdtYAY4tRuJhXR7eE72XZm/j2o50gNdwkTqffU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BqUnh9tAq6d0NNoGMFebYKPlmRWm7sIccSfUuBAeCu4zbM4DIJhF37R017lsMtgRf
	 AcNoH382QdLJih1TimTYVHTtAfyVd8EP2HcwRFvJnc+irPvPV1GG0o/c86ND4h1HtA
	 /E3iHV13QRWWX+bqQ/k/0FxmJOIuxFF/cvS3jJ1XXnKiQ0AzkpxRgYLI/YdTln9skt
	 03ajUR368eCJulwzwuKOEMLKhJTDJ+r7A5Vhi1lrxOIzw58B3DuhvG5hnhF2uC9x0H
	 /nUXRVRzM7HamZuk+06Ruv2p8ZylXI+9OnKd6jJvKW2pl1qJ0M1LsC8bShoJ6rcaez
	 SnyW1wTZrOfzQ==
Content-Type: multipart/mixed; boundary="===============3700884046334598854=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec7827303c4fdb3bc7d4153ca65387f4929d4c9e53aafd1c7d79dcabaea2b192@mail.kernel.org>
In-Reply-To: <20260528-rhash-v5-5-7205191b6c57@meta.com>
References: <20260528-rhash-v5-5-7205191b6c57@meta.com>
Subject: Re: [PATCH bpf-next v5 05/11] bpf: Allow special fields in resizable hashtab
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 18:26:53 +0000 (UTC)

--===============3700884046334598854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index a03fa5fa6545..50e9d57b2790 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -2943,6 +2965,7 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
>  static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>  				      u64 map_flags)
>  {
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>  	void *old_val = rhtab_elem_value(elem, map->key_size);
>
>  	if (map_flags & BPF_NOEXIST)
> @@ -2952,6 +2975,17 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  		copy_map_value_locked(map, old_val, value, false);
>  	else
>  		copy_map_value(map, old_val, value);
> +
> +	/*
> +	 * Torn reads: a concurrent reader without BPF_F_LOCK may observe
> +	 * the value mid-copy. Callers requiring consistent reads must use
> +	 * BPF_F_LOCK, matching arraymap semantics.
> +	 *
> +	 * copy_map_value() skips special-field offsets, so old timers/
> +	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> +	 * to match arraymap's update semantics.
> +	 */
> +	rhtab_check_and_free_fields(rhtab, elem);
>  	return 0;
>  }

In the v4 discussion on lore, a concern was raised about the ordering of
copy_map_value() and rhtab_check_and_free_fields() operations. When
copy_map_value() is called, it skips special field offsets, leaving the
old timer/kptr/etc. active in the slot during the copy.

Could a concurrent BPF program access those special fields in the window
between the copy and the free operations? Specifically, in the
BPF_F_LOCK case where copy_map_value_locked() is used, if a concurrent
program acquires the spinlock and accesses the value between the copy
completion and rhtab_check_and_free_fields() call, would it still see
the old timer/kptr that gets canceled immediately after?

The comment mentions matching arraymap's update semantics and acknowledges
torn reads for the non-locked case, but it's not clear whether the locked
case fully prevents concurrent access to special fields that are about to
be freed.

Reference: https://lore.kernel.org/bpf/252dc423a3bc75b3f4d936e7706085da71939a88a7ef148926c317d463d20a12@mail.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26592533594
--===============3700884046334598854==--
