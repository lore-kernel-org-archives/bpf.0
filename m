Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682582FE075;
	Tue, 27 Jan 2026 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483330; cv=none; b=JuIz4urkcjzK/389maKjhqKLPjIqK5SL/Nt6MI6WzKRwUK/umC7HddW5Nh38/7NXPUWLWACbLoDbkfnEW3tzc5Gq/lPy7L5rTgHZfJjdzc9mu/1oPB2Nhoo0Mvf7X3BkLnkbR8LlkxVbHP6dMcnSzxixiOzv0gyI7hMripFOyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483330; c=relaxed/simple;
	bh=a4VyBzG5dwslC57qu5s+IUxQjhwEMBgmA6+b7sDs1Lc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sZgl3yK3IkGF+57mv3ZEkN5QEc9imk9MSREC7eiloX1tVfGefIRcQJ0jxaQmflA5C0n8nJ7cRawI+otoDrAvVa05TadCz+hzkP7HlUZhGkDXJXYzE00lTDbWRvUuyycw9QSnn4WNOcnxV4sstoo1U96PzcjLflb0lsetob5H9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKQEOq7c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKQEOq7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF41C19421;
	Tue, 27 Jan 2026 03:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483330;
	bh=a4VyBzG5dwslC57qu5s+IUxQjhwEMBgmA6+b7sDs1Lc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JKQEOq7cowOtLsJ4Z1TMDc7IHAQnmYrT/AGgqI8Cs8Ldn9Gg1LtTEkevR/3S0yBi2
	 wQubFz8NKQSakKV3FU862ym939s/n/gQP8rbolxCSW9cbVFGPsAVHtx3KY8865X6Qd
	 6hTXPWzehMbrocWt4M5AvBupot9x5oyGcIvbgN0BChRAw/aSvYk03yufwemo7st1lE
	 cE4f+W2lETLsuUqcf89RRUxe6WjkG0Mp4zlK9XgRlu9k2yS7qT45UTcG5C9Zni7Mhd
	 7Y7m70FQ5Yg3A7lO2wRcH9dA8zVMKjSkS6/eyzT9EgNcqsPGhgi9MgR3mzMLIj4nQe
	 hsqaQhvimHCYg==
Content-Type: multipart/mixed; boundary="===============2565306889531042229=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3af5210f45be4a508e584263a5517781ca762d28d4f6b831b987795662715e61@mail.kernel.org>
In-Reply-To: <20260127024421.494929-5-roman.gushchin@linux.dev>
References: <20260127024421.494929-5-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v3 04/17] libbpf: introduce bpf_map__attach_struct_ops_opts()
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org
Cc: mhocko@suse.com,ast@kernel.org,mattbobrowski@google.com,shakeel.butt@linux.dev,inwardvessel@gmail.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,surenb@google.com,hannes@cmpxchg.org,akpm@linux-foundation.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 03:08:49 +0000 (UTC)

--===============2565306889531042229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 46d2762f5993..9ba67089bf9d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -13503,7 +13510,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>  		return &link->link;
>  	}
>
> -	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> +	link_opts.flags = OPTS_GET(opts, flags, 0);
> +	target_fd = OPTS_GET(opts, target_fd, 0);
> +	fd = bpf_link_create(map->fd, target_fd, BPF_STRUCT_OPS, &link_opts);

The code reads flags and target_fd from opts, but the expected_revision field
declared in struct bpf_struct_ops_opts is never read. Looking at similar opts
structures (bpf_cgroup_opts, bpf_tcx_opts, bpf_netkit_opts), they all pass
expected_revision to bpf_link_create_opts. For example:

    link_create_opts.cgroup.expected_revision = OPTS_GET(opts, expected_revision, 0);

However, bpf_link_create_opts has no struct_ops sub-struct to receive
expected_revision, and the kernel's bpf_attr link_create union has no
struct_ops.expected_revision field either.

Is expected_revision in bpf_struct_ops_opts intentionally unused? If so,
should the field be removed from the struct to avoid user confusion? If users
set expected_revision expecting it to be honored, the value is silently
ignored.

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dfc37a615578..2c28cf80e7fe 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -920,6 +920,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> +
> +struct bpf_struct_ops_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	__u32 flags;
> +	__u32 target_fd;
> +	__u64 expected_revision;
                 ^^^^^^^^^^^^^^^^^

The expected_revision field is declared here, matching the pattern used in
bpf_cgroup_opts, bpf_tcx_opts, and bpf_netkit_opts. However, unlike those
structures where expected_revision is read and passed through, this field
has no corresponding code path in bpf_map__attach_struct_ops_opts().

> +	size_t :0;
> +};
> +#define bpf_struct_ops_opts__last_field expected_revision

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21382620878

AI-authorship-score: low
AI-authorship-explanation: The commit follows kernel conventions and existing code patterns, with an oversight (unused expected_revision field) more typical of human development than AI-generated code.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The expected_revision field in bpf_struct_ops_opts is declared but never used, causing silent data loss if users set this field expecting it to be honored.

--===============2565306889531042229==--
