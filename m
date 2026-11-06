Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998593;
	b=grNHU1vLjHPm3ZkMQi1bHSnZYuvH/uYEL2LKeVZwWy1zWmdQnDwM8/CoriSqfbeNpZrA
	 3fteEd4bqquSwx7szxLXBehvNpgAsmnBlvyPOn1I96EIp6vja/DGbDtw7KM2htxI4/gn+
	 s6q9hpep9fK0SBth9JyrT9Jz4XfrS/y4wFC/EUT//9s/fNW3eOWxRnoKbd9qgWe9i2+Cn
	 yt7LZRh4w118EAxpHCu8gPz5w7S/HzvYvINvVE2EYIcVyupHGgKtH0U0+2u2ff7hvOx4Q
	 FuzKLi0+neCG8ibMBi8dYYwPoWcJi5TUg96qaeKOkqMTSa+8QkC802MStEB9U8OezDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998593;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mk+orUK3RcRFbVOsHQ6ZVsi9duhIYM93qkTWFl8Ry8Y=;
	b=DBTNchl6morx9Vv6pq29SVC4svqqL0Cy7XhMTSuT0gFOcM8Q1TeSWjjPtFrCfZE9xU3U
	 /sFvkiQt8Dlj70Ph6EGmSo/wYuJFtKQktcw8TXbllIma12UZF84lDuzo7P6P2usl1kAjH
	 YI4TYbCCp8GaVhLYjwKreSQ+kGc/Rdby0wHWHrN1vuByst+rntjBKfWqvtPuZdjcqeuE4
	 el9Ttke0u2P39xiiqiY5dAYVP0wC13EK38P2sPkemgPksiC9MvEIyeIGjSo5qwDAGHVam
	 GginCm0ZYrJsAGZ5JPZcotq6Dfht/4hCNAHYcj1bBz6dbmaKtfu6OnJc4qSmCcFBhoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9rm5aIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F46606A329;
	Fri,  6 Nov 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9rm5aIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429FC1F0089F;
	Fri,  6 Nov 2026 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998592;
	bh=mk+orUK3RcRFbVOsHQ6ZVsi9duhIYM93qkTWFl8Ry8Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d9rm5aInUORd/r3BbBNkTUYOZIo1K0KDTNUHsooTlYZ1SK3OoA0G+ko9TbT2otRW/
	 Ou6xjbIwN1FWW/Padg5thkizhkL/jmDqSHZUXS7FBT+/UrDZwoxghDX2Dj8H2F55Yt
	 VdKNuX+A0B8g5WrghHrTw06vwktZ2iuAwogpJK5oPGIYLoKzOd0sszux09QmRa8o16
	 AN3YRV9yvKWxuulTw3zOW9huV9KfqmGs39PJkIXL3lIwPHzAJf2ZKRlItrWZUjcvLg
	 D4l2Xp+AZ0UL0nVd5kVQ7XsG/V6oPp/bpgrXJGQxpnjR8lPoKkcxwtf4kimNzVCmRF
	 reH/X7qHlHWFQ==
Content-Type: multipart/mixed; boundary="===============7050428587060144477=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c6ee7bccef297b8fff39e0f3a083776c50e06f1557c197c10c38616b7e0052e8@mail.kernel.org>
In-Reply-To: <20261106-lskel-struct-ops-v1-3-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-3-a4486ffc79cb@google.com>
Subject: Re: [PATCH RFC bpf-next 3/7] libbpf: Support BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gprocida@google.com,nkapron@google.com,tweek@google.com,mripard@kernel.org,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 20:56:32 +0000 (UTC)

--===============7050428587060144477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Support BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()

TL;DR: In bpf_gen__map_create(), the struct_ops module BTF fd is closed only
after BPF_MAP_CREATE, so earlier loader failures may leak that fd, and a
retrying daemon may leak one per attempt.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -568,6 +589,9 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  	debug_ret(gen, "map_create %s idx %d type %d value_size %d value_btf_id %d",
>  		  map_name, map_idx, map_type, value_size,
>  		  map_attr->btf_value_type_id);
> +	if (map_type == BPF_MAP_TYPE_STRUCT_OPS)
> +		emit_sys_close_blob(gen,
> +				    attr_field(map_create_attr, value_type_btf_obj_fd));
>  	emit_check_err(gen);

The module BTF fd is only closed here, on the BPF_MAP_CREATE path of this
map.  Is it possible for the loader to leak that fd on earlier failures?

The fd is opened by the code emitted from bpf_gen__init_kern_struct_ops(),
which runs before bpf_object__sanitize_and_load_btf() and
bpf_object__create_maps().  Between those points the loader has several
emit_check_err() jumps to the cleanup label, for example:

  bpf_gen__load_btf()
  an earlier map's BPF_MAP_CREATE
  the struct_ops init sequence checks for a second module struct_ops map

The cleanup code emitted by bpf_gen__init() closes only btf_fd,
inner_map_fd, prog_fd[] and the first nr_maps fd_array entries, so the fd
stored in the upper 32 bits of the vtype_id_off slot is never closed on
those paths.

If one of those steps fails, a module BTF fd stays open in the process that
ran the loader, and a daemon that retries the load leaks one more fd each
time.  bpf_gen__prog_load() closes its module BTF fds "successful or not"
before any error jump.

Could the vtype btf fd also be closed on the cleanup path, or be kept
somewhere the cleanup code already closes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42289585064
--===============7050428587060144477==--
