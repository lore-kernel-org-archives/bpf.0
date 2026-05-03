Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869D3CCFAA;
	Sun,  3 May 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829724; cv=none; b=lLPt7bgDN/e2ZB+XS6biT3g886rwYMjSKcGFcbv2a6NcXuSyBMoethCi7J9KSv6Xoyy5PtrS4GplU1blsXb8/eS+KLXaSKGIwSVPZNb+zrb4e5Vu890O14L3dhkc4ukHCyb0VdYiwFt9nRz5Zm8zfXN0xKmPNwSyRDQH8XvpLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829724; c=relaxed/simple;
	bh=Lrbq7R7Bs5eWqu3TEwgo9f4OD7xPcRENrhdU2XXOl0A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dV8zAdzxW7LL4pzl1vpZt0WdRy7Qy/1tMniurou2hn62YPGpjflWjdvxci/XGDGpj6BOw+ky+ywsUo+mOVNd03h1ymp+ShyhfHTSJA85KqkGLnZz8N91qe/MDOw2SXVQe9McN/fuRKj+tKTOH5vJnCx54VhyASkr+dytY9cT+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIlgec5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIlgec5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCFC2BCC9;
	Sun,  3 May 2026 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777829723;
	bh=Lrbq7R7Bs5eWqu3TEwgo9f4OD7xPcRENrhdU2XXOl0A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VIlgec5Yh5iXUJEtyLNGJT5aaPlFySsTzVBmX5hflWEE85zhM5aC5OyUjs3u5ztrE
	 VI6f/x9ghuq5XVWhylPpM2Z24thZqpb733UVpzxUUJGRwqY86vGCjsSYIrRjS26YXX
	 ZP6R52r9MoQWLd4JO6AWWK2+LxkV6WAgp2Y2vNflCOjIigPTal74EOztAveZCDA5Hs
	 fbVYwk5eAxn7DsYWFnp5NfqqVPTPh7lUVz43vzWA8dPSYrBJ4wlE+QWHxzgX+svnx4
	 9eLjJsAPGmuOcrqmJm0QzyQootQ9/mGvFrtebKInoUIk8cPC3R0XeNF0c+09fdjBfk
	 iQoiJKDY5ZCLQ==
Content-Type: multipart/mixed; boundary="===============8100301415052033692=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c13f99d42c434ec73ec1e8cf1141047146ab359e60e56e78e1c32554d6e01e9b@mail.kernel.org>
In-Reply-To: <20260503165024.1526680-5-vernon2gm@gmail.com>
References: <20260503165024.1526680-5-vernon2gm@gmail.com>
Subject: Re: [PATCH 4/4] samples: bpf: add mthp_ext
From: bot+bpf-ci@kernel.org
To: vernon2gm@gmail.com,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,daniel@iogearbox.net,surenb@google.com
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,baohua@kernel.org,lance.yang@linux.dev,dev.jain@arm.com,yanglincheng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 17:35:21 +0000 (UTC)

--===============8100301415052033692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
> index 0002cd359fb1..2a73581876b4 100644
> --- a/samples/bpf/.gitignore
> +++ b/samples/bpf/.gitignore

[ ... ]

> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 95a4fa1f1e44..357c7d1c45ef 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile

[ ... ]

> diff --git a/samples/bpf/mthp_ext.bpf.c b/samples/bpf/mthp_ext.bpf.c
> new file mode 100644
> index 000000000000..bbee3e9f679c

[ ... ]

> diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
> new file mode 100644
> index 000000000000..0e064bad136f
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	const char *root_path = DEFAULT_ROOT;
> +	unsigned long threshold = DEFAULT_THRESHOLD_MS;
> +	unsigned long interval = DEFAULT_INTERVAL_MS;
> +	unsigned int init_order = DEFAULT_ORDER;
> +	unsigned int min_mem = DEFAULT_MIN_MEM;
> +	bool fixed = false;
> +	bool debug = false;
> +	struct mthp_ext *skel;
> +	struct bpf_link *iter_link;
> +	struct bpf_link *ops_link;
> +	struct ring_buffer *rb;
> +	int root_fd;
> +	int psi_fd;
> +	int err = 0;
> +	int opt;

[ ... ]

> +	/* Attach struct_ops to root cgroup for mthp_choose */
> +	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
> +	opts.flags = BPF_F_CGROUP_FD;
> +	opts.target_fd = root_fd;
> +	ops_link = bpf_map__attach_struct_ops_opts(skel->maps.mthp_ops, &opts);
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
Will mthp_ext compile with these symbols? A tree-wide grep shows that
bpf_struct_ops_opts, BPF_F_CGROUP_FD, and bpf_map__attach_struct_ops_opts()
do not exist anywhere in the kernel source tree:

  $ git grep -n "struct bpf_struct_ops_opts"
  samples/bpf/mthp_ext.c:260:	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);

  $ git grep -n "BPF_F_CGROUP_FD"
  samples/bpf/mthp_ext.c:261:	opts.flags = BPF_F_CGROUP_FD;

  $ git grep -n "bpf_map__attach_struct_ops_opts"
  samples/bpf/mthp_ext.c:263:	ops_link = bpf_map__attach_struct_ops_opts(skel->maps.mthp_ops, &opts);

The struct bpf_struct_ops_opts type is not defined in tools/lib/bpf/libbpf.h.
The BPF_F_CGROUP_FD flag does not appear in include/uapi/linux/bpf.h or any
other header. The bpf_map__attach_struct_ops_opts() function is not declared
in libbpf.h or exported in tools/lib/bpf/libbpf.map.

The only existing libbpf API for struct_ops attachment is:

  tools/lib/bpf/libbpf.h:
    LIBBPF_API struct bpf_link *
    bpf_map__attach_struct_ops(const struct bpf_map *map);

which takes no opts parameter and cannot attach to a specific cgroup fd.

Samples/bpf/Makefile was modified earlier in this commit to add mthp_ext to
tprogs-y, meaning the build system will attempt to compile mthp_ext.c during
make samples/bpf/. That compilation will fail with undefined type, undefined
identifier, and implicit declaration errors.

This looks like it depends on an out-of-tree libbpf extension that adds a
per-cgroup struct_ops attachment API. Is that libbpf patch supposed to be
included earlier in this series, or should the sample use a different attach
mechanism?

> +	err = libbpf_get_error(ops_link);
> +	if (err) {
> +		fprintf(stderr, "ERROR: attach struct_ops failed: %d\n", err);
> +		ops_link = NULL;
> +		goto attach_opts_fail;
> +	}

[ ... ]

> diff --git a/samples/bpf/mthp_ext.h b/samples/bpf/mthp_ext.h
> new file mode 100644
> index 000000000000..33dc01bcebd3

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25285279315
--===============8100301415052033692==--
