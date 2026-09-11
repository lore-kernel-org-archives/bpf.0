Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34933A4F5F;
	Fri, 11 Sep 2026 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097881; cv=none; b=fV6di9GUOw91v37osqn10xXWtFGjtgvhH54Rc0zlpIDyEgGgIG/MrQF7yIzYLUVRYxGhc+2kvNjJPdBB11TMKlQClPS2r8R71BdOMAQJFoamhCmUSWqAo5mDcK/NaXhfUL9fFfG/2HhKt2b+n/9tvC65wiOgS60mSYUWqwpY/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097881; c=relaxed/simple;
	bh=XuLkbYSA4icn62w5xdxUHZLq67JP/eCsH3gs+UNFrzw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=vCW1ty47fJESMbf0QgBW+P+gCDjwIEjnCGwTfCdufzDZB96mggp0T+riwAW1VdFrwg1ULcneKoox7ME87Lo3JFoXoKpXaBEueslgJXIYaoi9q4NottjDvW/WeiiC5B/ac3XJDRT7eSPQinnhiftpt5+2rBjKCC9L49EDwB0rqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVq6mkSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVq6mkSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F831F000FF;
	Fri, 11 Sep 2026 03:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789097879;
	bh=jlCmNMSKELPzmJ2R+lV/JEqLPIi9ZiPeT/IgkvGgdXM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oVq6mkSOmYIxh6I5HBZC6kFp4B2RDpbPjmpczcfHqs0A09UYVD88AF3olv9vlcNvS
	 aKQLhjCmKtXRCBBLeYTHXj7zpPndy28v4hqLDCnGSTOSTR5X1vM+pMO+QhTjNp7Puo
	 dErSSdi3Cbfpw9AGzK8Po4TVWZTDY/tRvyil+uCm4Gk/roREgPjtUN+SNUcAftjY4F
	 WF/fgp9poVcMP193jsBMfBMSWndVrTo2mBmVqoKRzU1zFxmXcVsGMeZJEtoaEQm+fT
	 sjeh+N44DCQXjAOGs1OoXZAQjpOlNR4tv7Znx2iOPq7zqIdVC6EOfHYLwkQLon8qw+
	 s98OZzKD3viow==
Content-Type: multipart/mixed; boundary="===============1385902729262254761=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7aea07c4220781305b7e972abfa9d2e4776276a64bc4837b80325d177799a371@mail.kernel.org>
In-Reply-To: <20260911025130.191011-2-diannaaav@gmail.com>
References: <20260911025130.191011-2-diannaaav@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Use batch lookups for bounded hash map dumps
From: bot+bpf-ci@kernel.org
To: diannaaav@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 03:37:58 +0000 (UTC)

--===============1385902729262254761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..ea6f1389245f 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> +/* Return 1 to use individual lookups, but only before batch traversal starts. */
> +static int dump_map_batch(int fd, void *key, void *value,
> +			  struct bpf_map_info *info, struct btf *btf,
> +			  json_writer_t *wtr, unsigned int *num_elems)
> +{
> +	__u32 capacity, count, batch = 0, next_batch = 0, i;
> +	void *keys = NULL, *values = NULL, *buf;
> +	bool first = true, can_fallback = true;
> +	int err;

[ ... ]

> +	while (true) {
> +		count = capacity;
> +		err = bpf_map_lookup_batch(fd, first ? NULL : &batch,
> +					   &next_batch, keys, values, &count, NULL);
> +		err = err ? errno : 0;
> +		/*
> +		 * Older kernels reject the command before updating count. Do not
> +		 * inspect the buffers on these errors, or fall back after progress.
> +		 */
> +		if (can_fallback && (err == EINVAL || err == EOPNOTSUPP ||
> +				     err == 524 /* ENOTSUPP */)) {
> +			err = 1;
> +			goto out;
> +		}
> +		can_fallback = false;
> +		if (err == ENOSPC) {
> +			if (capacity == info->max_entries)
> +				goto error;
> +			capacity += min(capacity, info->max_entries - capacity);
> +			/* Preserve the input cursor: the oversized bucket was not read. */
> +			goto resize;
> +		}
> +		/* In particular, EFAULT can leave count and the buffers invalid. */
> +		if (err && err != ENOENT)
> +			goto error;

[ ... ]

> +		if (err == ENOENT) {
> +			err = 0;
> +			goto out;
> +		}
> +		first = false;
> +		batch = next_batch;
> +	}
> +error:
> +	fprintf(stderr, "Error: can't lookup map batch: %s\n", strerror(err));
> +	err = -1;
> +out:
> +	free(keys);
> +	free(values);
> +	return err;
> +}

[ ... ]

> @@ -869,6 +965,9 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  		p_info("Warning: cannot read values from %s map with value_size != 8",
>  		       map_type_str);
>  	}
> +	err = dump_map_batch(fd, key, value, info, btf, wtr, &num_elems);
> +	if (err != 1)
> +		goto end_dump;

This isn't a bug, but would a separate flag for the fallback case read
more easily here?  The err variable carries three different kinds of
values: negative returns from bpf_map_lookup_batch(), then positive
errno values after the "err = err ? errno : 0" line, and finally the
special value 1 to signal fallback to individual lookups.  The sentinel
1 happens to equal EPERM numerically, though the logic does keep them
separate since all errno comparisons run before "err = 1" is assigned.
Could using something like "bool fall_back" or a small enum let err
stay purely an errno, so the caller's "if (err != 1)" doesn't have to
encode this third outcome?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34557203595
--===============1385902729262254761==--
