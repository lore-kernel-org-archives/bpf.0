Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505833;
	b=hn7F8x+01Y7k/eEJ3ymbhVUca5Dy6OMoYTblA0oQbayvicQjZnr2rsiJ5MITWVN3l8Z7
	 EhQ748gXUlAtQ6xfhPCjAO/ChMoHzUu501Uz7IUYdrdMDOVfb+Lv3ICsBx4ufOK/zIJCx
	 2obgC0d4Q7uBiTq6YnQJx3WbeCWRaag0/gDdjv8cidV/BFvTKt/ckbxUOqRDUBjcezBH6
	 1llRqTUdhPH/RkJqso5PG7UcX6EZvDwDzT2DME47ICuYI3862RVkE/DR4ryF1b1PsFGml
	 kbVA4V3zmx4gN9wMFaBfgQLtIcUrD5v8ipprzOyYxu7xQ3mdL+zWO5ieddicTnRhuJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505833;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5aps/Snk/97VbpxbTZxlLa446dwmv9p9tV7iyoVQ2CE=;
	b=PcvbT/PzvquT7tsbV9m7troDhLAJYib3+z+RmMD5Cql0F0Uk9KQrLwM8tSnTpguu7iZT
	 SkmBwGpilexjlhIhiw9KakvLsbFdYcczq1ENA1Q+p2NFWTexxqqhqAsy0z6jHkyBsnh2k
	 XYcjczlJovQ6s/YNgDWCPIDkcg2EIn/r4cDs8uThbjWdxPfQJl6x9WW0Os67LPOC4pQnz
	 8x8UO+pqc3gx3i6/OH34VwjUZKe/rtAjxH5ed70vkrX96bXnwS+h0nAqsPqDL659g77/m
	 xotTro8UTzpOw0vD5CI+xJIa+d//bdCDkpHjB3JTMVuq+qUdfQN60RnPpSbNgDJQ3CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWe+pKBw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38D606A319;
	Tue, 20 Oct 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWe+pKBw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D121F000C4;
	Tue, 20 Oct 2026 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505833;
	bh=5aps/Snk/97VbpxbTZxlLa446dwmv9p9tV7iyoVQ2CE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SWe+pKBwEX1q31nsvL6OeRTJx7W4k/0ZCidtjhjTRfvVOis+27Lsf+2jojlFOU8jw
	 2tJOmjB9WM5iLXk7byZI4W+5ZdTRlpSGojnBjTSD5ED5p0vpNQdzGyjdpVoIR8zEBU
	 Rbe6NiIaYj0Im+Ilkb+GF7bf6WrYet6poCYz8XeYINK3WYQA8n/hFPHZbGXCrhesSo
	 ZgY5xZ67XvGLc4IvIHjXAyqrrCiKRjeXByoYTGR7U+6Ci7NaTMU/xnO+AwsJA8vPE7
	 QM6h+Gc/qF3d2huggefJyNnCtbkopimiwhpTqDolKrY6r3iMw3ogBiwjY9k/4BkFCS
	 KcShhSOsc/TTw==
Content-Type: multipart/mixed; boundary="===============8920557451821548780=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <582d4780b89df462674ebf66e2eb1829cfe164209a095266966be9a0861ca47d@mail.kernel.org>
In-Reply-To: <e596c9878df94ac93c172d93106c8ebd2dac4bb7.1792503001.git.xukuohai@huawei.com>
References: <e596c9878df94ac93c172d93106c8ebd2dac4bb7.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 05/16] libbpf: Add the arena percpu chunk attribute to map creation options
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:12 +0000 (UTC)

--===============8920557451821548780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Add the arena percpu chunk attribute to map creation options

TL;DR: New fields inserted before log_opts in struct bpf_map_create_opts
appear to break libbpf ABI: binaries built against 1.8 may have log_opts
ignored or map creation fail with -EINVAL. They should likely be appended
after log_opts.

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -70,6 +70,10 @@ struct bpf_map_create_opts {
>  	const void *excl_prog_hash;
>  	__u32 excl_prog_hash_size;
>
> +	/* offset and size of an arena percpu chunk */
> +	__u32 arena_percpu_chunk_off;
> +	__u32 arena_percpu_chunk_sz;
> +
>  	struct bpf_log_opts *log_opts;
                              ^^^^

Does inserting these two fields ahead of log_opts break the layout of
struct bpf_map_create_opts for existing users?

log_opts was added by 702259006f93 ("libbpf: Add syscall common attributes
support for map_create") and is already in a released libbpf (3ead4ead078f
("libbpf: Start v1.9 development cycle") says libbpf 1.8.0 has been
released, and 702259006f93 is an ancestor of it).

The OPTS_HAS(opts, field) scheme relies on the caller-supplied sz and
offsetofend(type, field), which only works if new fields are appended at the
end.  On x86_64 the layout changes like this:

  old (1.8): excl_prog_hash_size @64, log_opts @72, sizeof == 80
  new:       excl_prog_hash_size @64, arena_percpu_chunk_off @68,
             arena_percpu_chunk_sz @72, log_opts @80, sizeof == 88

Consider an application built against the 1.8 headers that sets
opts.log_opts (opts.sz == 80), running against a shared libbpf that includes
this patch.  In bpf_map_create():

  attr.arena_percpu_chunk_off = OPTS_GET(opts, arena_percpu_chunk_off, 0);
      /* 80 >= 72: reads old padding */
  attr.arena_percpu_chunk_sz = OPTS_GET(opts, arena_percpu_chunk_sz, 0);
      /* 80 >= 76: reads low 32 bits of the old log_opts pointer */
  log_opts = OPTS_GET(opts, log_opts, NULL);
      /* 80 < 88: NULL */

So the caller's log_opts is silently ignored, no log buffer is filled, and
true_size is never written back.  The kernel also receives a non-zero
arena_percpu_chunk_sz.

On kernels without the arena percpu attr, BPF_MAP_CREATE_LAST_FIELD is still
excl_prog_hash_size in kernel/bpf/syscall.c at this commit, so
CHECK_ATTR(BPF_MAP_CREATE) sees non-zero bytes past that field and returns
-EINVAL.  Does that mean every map creation that passes log_opts, which used
to succeed, now fails?

On kernels with the later d7935093885b, an ARENA map would get a bogus chunk
size (rejected as unaligned, or accepted with a wrong layout), and other map
types would silently lose their log.

The reverse case also looks problematic.  An application built with the new
header sets arena_percpu_chunk_sz but not log_opts, then runs against libbpf
1.8.  The 1.8 library reads offset 72 (arena_percpu_chunk_sz plus padding) as
a struct bpf_log_opts pointer, and OPTS_VALID(log_opts, bpf_log_opts)
dereferences it.

Nothing later in this series (a6e6ab7a4b2f..08224ba2de19) touches
tools/lib/bpf/bpf.h, so this is not fixed by a following patch.

Should the two new fields be appended after log_opts instead, with the
last-field marker updated?

	struct bpf_log_opts *log_opts;

	/* offset and size of an arena percpu chunk */
	__u32 arena_percpu_chunk_off;
	__u32 arena_percpu_chunk_sz;

	size_t :0;
};
#define bpf_map_create_opts__last_field arena_percpu_chunk_sz


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============8920557451821548780==--
