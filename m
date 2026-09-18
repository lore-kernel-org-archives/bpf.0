Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48B4E73BD;
	Fri, 18 Sep 2026 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731503; cv=none; b=cP/HVIq/ciFRIzpTuOYOFaaWTpt8e4DOUcRDgL6DYB9TpVZK+y4X6ep4fRpHMrFSfkdIw4NkNzMLLqrPKxAnjU8Jx2aWKP9K8K1ODGaQ3FTN4ouCgIQb0Tt9dATJn9faN9x4OjAkxmASzCjCmaYf0+9NfwgBY1gQTebKCNrYoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731503; c=relaxed/simple;
	bh=cyAVSGBj4MxcphXDuk4hLGth/l6+n086Ayxk9p9wQBQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mlUjMdfmodr9Jx3OjD+4l+N3YCS7al+nx1IaXWmn1+e8FtuUyKdJ/7mYzlR6BjaX8AumIHqCwGglM4+tFWRtZzXm3fsythS/VFQR36l4MTdPO0cGsz55sgOjMKN5C77iQ72ojF0H5649GsFxefLpNHAg7p7tnXiZSrQMhFy65vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMHsRTEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMHsRTEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8D21F00893;
	Fri, 18 Sep 2026 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731501;
	bh=MIbbaHQVR5XHtn/5JytKapn7PAjU6r4XS2BAeISdu7I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NMHsRTErkV8oOj14seSLEpQRBFbzQVLuGFUmHjLHGw7xMkaDfJ1fkFK9SKimonRPH
	 E5zF5VG2TejAx+gTwhA0QkT05IXpKAyIC09rLy17EcUA61qroG8mcTCU5V298fjqhl
	 ntlrHmIGiX5wdHfq9o8meMHf8tL+uT+OifpYShYRGzqNjwi0rOZXY3ASESf/3DETJ4
	 mqC7/31bkdk8auGxVXrhAsmIBH20oCvNM/G32puwYtiTLGm1TJOn1PkI6wZj9PcuPt
	 FI0wW8UoGnMY0s7cQviBTD6RA+OSpiO5eprekUmDsM7dmpaFbqArEXUvMd82fB3CD5
	 dDOTzmqUUKPKA==
Content-Type: multipart/mixed; boundary="===============2482914401454666331=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8133502bddeca543340dd7440a6472273559f0eb58beac25e737474e13da9070@mail.kernel.org>
In-Reply-To: <20260918102052.1247819-2-sh_def@163.com>
References: <20260918102052.1247819-2-sh_def@163.com>
Subject: Re: [PATCH bpf v2 1/2] bpftool: Fix CPU IDs in per-CPU map output
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 11:38:20 +0000 (UTC)

--===============2482914401454666331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Fix CPU IDs in per-CPU map output
>
> bpftool uses dense per-CPU value-buffer slots when printing per-CPU map
> values. It also uses the slot index as the CPU ID, which produces
> incorrect labels when the possible CPU mask is sparse, such as 0,2-3.
>
> Parse the possible CPU mask and use the corresponding logical CPU ID in
> plain, JSON, and BTF-formatted output. Keep the dense slot index for
> accessing the per-CPU value buffer, and propagate CPU-ID lookup and map
> output errors through the shared output path to its callers.
>
> Tested:
> - Built tools/bpf/bpftool successfully on the host.
> - Booted an arm64 QEMU guest with a patched virt device tree reporting
>   possible=0,2-3, present=0,2-3, and online=0,2-3.
> - Compared pre-fix and fixed plain and JSON map output in that guest:
>   labels changed from CPU 0,1,2 to CPU 0,2,3.
> - Loaded a BTF-described per-CPU array and dumped it with the fixed
>   bpftool in plain BTF and JSON formats; both formats reported CPU 0,2,3
>   while preserving the three dense per-CPU values.

This isn't a bug, but could the Tested: block be trimmed to the reproducer
(possible=0,2-3) or moved below the --- line, keeping the changelog focused
on the problem and the why? The first paragraph already mentions the sparse
mask, and the build-succeeded and format-by-format walkthrough lines restate
what the diff does.

> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index ef366ccc96501..ad10bfe8a0fc3 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c

[ ... ]

> @@ -655,6 +656,45 @@ unsigned int get_possible_cpus(void)
>  	return cpus;
>  }
>
> +int get_possible_cpu_ids(int **cpu_ids)
> +{
> +	const char *possible_cpus_file = "/sys/devices/system/cpu/possible";
> +	bool *mask = NULL;
> +	int mask_sz, nr_cpus = 0;
> +	int *ids = NULL;
> +	int i, res;
> +
> +	*cpu_ids = NULL;
> +
> +	res = parse_cpu_mask_file(possible_cpus_file, &mask, &mask_sz);
> +	if (res) {
> +		p_err("failed to parse possible CPU mask: %s", strerror(-res));
> +		return res;
> +	}
> +
> +	for (i = 0; i < mask_sz; i++)
> +		nr_cpus += mask[i];
> +
> +	ids = calloc(nr_cpus, sizeof(*ids));
> +	if (!ids) {
> +		p_err("failed to allocate possible CPU IDs: %s", strerror(ENOMEM));
                                                                     ^^^^^^^^^^^^^^^^

This isn't a bug, but would p_err("mem alloc failed") (or strerror(errno))
fit the surrounding style better here, since strerror(ENOMEM) always prints
the same fixed string? This is the only strerror(ENOMEM) in common.c; every
other strerror() call passes errno, and the file's idiom for a failed
allocation is the terse p_err("mem alloc failed").

> +		res = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0, nr_cpus = 0; i < mask_sz; i++) {
> +		if (mask[i])
> +			ids[nr_cpus++] = i;
> +	}
> +	*cpu_ids = ids;
> +	ids = NULL;
> +	res = nr_cpus;
> +out:
> +	free(ids);
> +	free(mask);
> +	return res;
> +}
> +

[ ... ]

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb724146..586c9e076a483 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -833,6 +834,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	void *key, *value, *prev_key;
>  	unsigned int num_elems = 0;
>  	struct btf *btf = NULL;
> +	int *cpu_ids = NULL;
>  	int err;
>
>  	key = malloc(info->key_size);
> @@ -845,6 +847,16 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>
>  	prev_key = NULL;
>
> +	if (map_is_per_cpu(info->type)) {
> +		int cpu_cnt;
> +
> +		cpu_cnt = get_possible_cpu_ids(&cpu_ids);
> +		if (cpu_cnt < 0) {
> +			err = cpu_cnt;
> +			goto exit_free;
> +		}
> +	}
> +

This isn't a bug, but since both callers only look at the sign of
get_possible_cpu_ids(), would it read better to either pass cpu_cnt down
next to cpu_ids as the loop bound, or have the helper return plain 0/-errno
so there is one source of truth for the array length? Right now the
consumers derive the loop bound independently from get_possible_cpus().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35336124623
--===============2482914401454666331==--
