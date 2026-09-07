Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E03E5ED7;
	Mon,  7 Sep 2026 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747701; cv=none; b=ro6XNw+cF2aJE4kbZK15UPBumVqf/oG1HygYcCyDFeQhU/cXl5MXDFDoi0GRB7FfCdI2wIAWPYls2GLZEVBvqGYs24vY85iM3Qf8+hi67LL/Tcw0kIx0fH3w7gjykGRt5O6WllkStjCMzDbLw6dJthiHuFP3u/RsvK3cL7lN9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747701; c=relaxed/simple;
	bh=2HblSqRu2XCcvW+rxyc97ECfyo2W24e10jcKZWU/aBI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hz/2IlmncC78ALuWWkKslzFWg2Co1A3akAT4t69dLC39w0YcRsxYpkDXWAbiK0xKJGgDeK6UiFc+b15roAFWwXGuy6RYqxiLzNB25Gq6Lx0FjMrIRsK0JjCxunAZnVRYzFvBxFqhiO9S6Vp2anActwK6AhBn3PuYHgqpdVOs65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJQ0I4JN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJQ0I4JN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857F21F00A3D;
	Mon,  7 Sep 2026 02:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747700;
	bh=Dd7ARHz1B7IuWza55XqcSa+1QS6JRqo1HjzEa6Ufeso=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lJQ0I4JNw23T31am1S6/7FWtCm4Gdn7S7dbYLYJdyMD3GO0I6cRLtrq+4Nl8meSju
	 HPIQeUvaqr63VTsWL45XLOIqXm19DEYCjoKmlmFG/BniBzsJkV01+SkAYaR304EHYc
	 H8jJgj2gSYHi7VRpWIKKLOjadn2HTd18PjcxYTFl94zUWxBn/bHd/r8P0i4HJtdi7K
	 vzzcLFMwmFwOH/BXT0Fi/tE+5H8BrrKdDFvnDY6rWw+KBQee+c2K3znSL1JANCKTLV
	 UGRTw4IwyGZHvqThguLORJcYx6p1Z2eOZUdOku7QTjpcqI3E7T8Wnkq0a8loueuNuC
	 pXILM+GqM9vHQ==
Content-Type: multipart/mixed; boundary="===============2543354907178818727=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <47ffafd7714d83ed25f2852752660f8e45f6ac45917db93cd33dfe7087870579@mail.kernel.org>
In-Reply-To: <178874362960.1415955.206253160275144439.batch-v2-1@tychen.cc>
References: <178874362960.1415955.206253160275144439.batch-v2-1@tychen.cc>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Use batch lookups for bounded hash map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:21:39 +0000 (UTC)

--===============2543354907178818727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Use batch lookups for bounded hash map dumps
>
> Use BPF_MAP_LOOKUP_BATCH when dumping hash maps to reduce the number
> of BPF syscalls. Share element formatting with individual lookups to
> preserve plain, JSON and BTF output.
>
> Start with up to 256 entries and grow on ENOSPC without advancing the
> input cursor. Restrict the optimization to maps whose maximum key and
> value storage fits in 4 MiB, so even a worst-case bucket can fit without
> restarting a partially printed dump. Preserve aligned element buffers
> for formatting keys and values with odd sizes.
>
> Fall back to individual lookups only if the initial batch operation is
> unsupported. Process the final partial batch on ENOENT, but never use
> count or output buffers after other errors. Report errors after batch
> traversal starts without restarting and duplicating output.
>
> Send batch failure diagnostics to stderr so JSON element arrays contain
> only map entries.

This isn't a bug, but would it help to include performance numbers in the
commit message? The stated motivation is reducing the number of BPF
syscalls, but the last three paragraphs describe what each part of
dump_map_batch() does rather than showing how much the change gains. For
a patch whose purpose is syscall reduction, showing before and after
syscall counts or wall time for a representative dump would clarify the
benefit.

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..ea6f1389245f 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> +#define MAP_DUMP_BATCH_SIZE 256U
> +#define MAP_DUMP_BATCH_MAX_BYTES (4 * 1024 * 1024)
> +
> +/* Return 1 to use individual lookups, but only before batch traversal starts. */
> +static int dump_map_batch(int fd, void *key, void *value,
> +			  struct bpf_map_info *info, struct btf *btf,
> +			  json_writer_t *wtr, unsigned int *num_elems)
> +{
> +	__u32 capacity, count, batch = 0, next_batch = 0, i;
> +	void *keys = NULL, *values = NULL, *buf;
> +	bool first = true, can_fallback = true;
> +	int err;
> +
> +	/*
> +	 * Hash lookup batches must accommodate a whole bucket. Restrict the
> +	 * optimization to maps whose worst-case bucket fits the memory budget,
> +	 * so a later ENOSPC never forces a restart after printing some entries.
> +	 * Division also bounds the allocation multiplications on 32-bit hosts.
> +	 */
> +	if (info->type != BPF_MAP_TYPE_HASH || !info->max_entries ||
> +	    (__u64)info->key_size + info->value_size >
> +	    MAP_DUMP_BATCH_MAX_BYTES / info->max_entries)
> +		return 1;

This isn't a bug, but does the eligibility test have the intended effect
for large maps? The check disables batching when (key_size + value_size)
exceeds MAP_DUMP_BATCH_MAX_BYTES / max_entries. For a hash map with 1
million entries and key_size = value_size = 4, that division yields 4, so
the test rejects it and forces individual lookups. The batching code
allocates starting at MAP_DUMP_BATCH_SIZE (256) entries and grows on
ENOSPC, so the 4 MiB budget could instead cap how far capacity is allowed
to grow rather than disqualifying the map entirely. That way large hash
maps would still benefit from batching, and only a genuinely oversized
bucket would hit the fallback path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34074207177
--===============2543354907178818727==--
