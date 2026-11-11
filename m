Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414291;
	b=ehpl5SgRSWFxH5sOY43cmHZqL8gqZ2meqE0qTsnCbvj4TpZIKOCFUy1EIh+y8l/gKmZq
	 a/LZMxNnT1h3LO9ILqKZpvzmHLGMX/ht20qS/ajb5j3zWCSCHqEcuYe+jJzjBVNiv/VxD
	 5Cd281cWRaTv3qKj5/iSd2XrY029MvgjlTUCk62VrJnNGbWAR125gylmpuUERGwEj5hdJ
	 eofRNFlHTalf0quO/efe5Mucqr84WMJ4UYkwAz9ZHRB9+sOl0x5b06sNSUxdZINe86PNc
	 Y8K1t1LumBYLbCnyfenjgzM7hGSAqfnnFQipLdRGKJOywZr2x5LhX1lGeSGsKilfx8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414291;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jNntaP3XwTuZXmgecucET7NTUcEEL+E3l6G+ho6z4r8=;
	b=SrbgxJI5xBSzUgbzJUiCz0ny0oueZjHtUPIFXDXj34/r1SMwud8fGpIZK2Xa8NG2ZgGE
	 KtQvMCk8s9anbLT2GbY1h5zINebGAXRrYZxJRmuNftCXcvzz2fFE5jTM3LVH2qSogilnU
	 cy+LgY5/AKBquJo4oVjXW4B2y8ajBPiPaOae4As0ANy3QlezTl5d4ZBShY31tMFfLW9vL
	 HvkVLc/2eujfeV6ckEeLrbGieIMRWOJev2W2vml9rGL5H7tqKsYvvdlTUiksEbXIITx/G
	 vjSv3RMNZH+wtADhGD36seMgRy6ZO+VxOp9sroDTz/g7/q8+8dtmcnQ5epBE+Waza8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzRpG63W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A1606A88A;
	Wed, 11 Nov 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzRpG63W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BB11F00A05;
	Wed, 11 Nov 2026 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414291;
	bh=jNntaP3XwTuZXmgecucET7NTUcEEL+E3l6G+ho6z4r8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KzRpG63WF601aVxCqPnmcBV5FPY+g/t+VUS+dLF+ARoLBoDIIjLxtIx8sVTOljiND
	 febIiSOycx24TrKU+bHTbungmbQeX9e7ZcnBiHioplZusgrl+qJ5yHaGqPOTJqEo0M
	 tXbuNXWKhn9HSjH+j7TMxJw5a8tIN7PpoUbTnAMOFRguiLkeipYMyu3SMyonIHpX0E
	 DUY1o9DGeIRolnsBM8i+nkhHlwSIKP72/YASPxdadT19XA6NSt+zRu5Cia0IS07jKm
	 /yaklZy95Nmlnjc5s22yC84TWLiNi5V79ty/6O5TziC9PM0OPhhgwA833e43c4gjY5
	 RG6uCqre5Qx4w==
Message-ID: <447aeaaa-dd74-47c2-b517-790ae98e8962@kernel.org>
Date: Wed, 11 Nov 2026 16:24:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 2/3] bpftool: Add recursive map dumping
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ihor.solodrai@linux.dev
References: <cover.1794380385.git.hi@tychen.cc>
 <237281e76007092c3cd8debdc8dddce418f7354b.1794380385.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <237281e76007092c3cd8debdc8dddce418f7354b.1794380385.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-11 16:19 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Dumping an array_of_maps or a hash_of_maps shows the IDs of the inner
> maps but not their contents. Add a recursive keyword to map dump that
> also dumps each inner map in the entry that references it. JSON gains
> an "inner_map" object next to "inner_map_id". Plain output separates
> inner maps with blank lines and indents their raw entries and element
> counts. Output without the keyword is unchanged.
> 
> The kernel permits only one map-in-map level. Look up outer entries
> individually, then open, dump and close each referenced inner map
> immediately. This uses one extra map FD; inner dumps may still use batch
> lookups. Shared inner maps are dumped at every referring entry. If an
> inner map has disappeared, report the error in that entry and continue.
> 
> Link: https://github.com/libbpf/bpftool/issues/58
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |  10 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   3 +
>  tools/bpf/bpftool/map.c                       | 123 +++++++++++++++---
>  3 files changed, 113 insertions(+), 23 deletions(-)
> 

[...]

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 9e4dc3881060..79d33af257b6 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[...]

> @@ -1003,6 +1036,43 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	return err;
>  }
>  
> +/* The kernel has one level of map-in-map: inner maps have no inner maps. */
> +static void dump_inner_map(__u32 id)
> +{
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts, .open_flags = BPF_F_RDONLY);
> +	struct bpf_map_info info = {};
> +	json_writer_t *btf_wtr = NULL;
> +	__u32 len = sizeof(info);
> +	int fd;
> +
> +	fd = bpf_map_get_fd_by_id_opts(id, &opts);
> +	if (fd < 0) {
> +		p_err("can't get map by id (%u): %s", id, strerror(errno));
> +		return;
> +	}
> +	if (bpf_map_get_info_by_fd(fd, &info, &len)) {
> +		p_err("can't get map info: %s", strerror(errno));
> +		goto out;
> +	}
> +
> +	if (!json_output && info.btf_value_type_id)
> +		btf_wtr = get_btf_writer();


This will not indent inner map entries for inner maps with BTF info,
will it? But I guess indenting them would require changing the JSON
writer, probably not worth it. It's probably OK if we have blank lines
to delimit the different maps in that case.

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

The series will need to be rebased once the batch lookups are merged, so
that it can go through CI.
