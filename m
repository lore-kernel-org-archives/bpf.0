Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECB330307
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980659; cv=none; b=W0li+tJOC94KLVeR/OnAYbdJ1SYcCMPfilHjyww4du9uW9+GRu+TmehekTURJeTEp5yqCvEvuYLG18bvY6wsbNw+waykLezkSotEwCJd+0c1vOcphVenZ/Jf4Z+/2zk6GP+67r4qfJwJUVVw64Lsla+qz3ekr4zMtRlan0jMIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980659; c=relaxed/simple;
	bh=oI6zWjbcXZWB68FpjI7jTxXKEfZqmqBavkWbQehTQhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soTm6vhDBBF9Aa1YpPH7bKTeIitWGNgSIGDmieFywt7NQyAI0CRZB6cMNT+QpYuY8YJfB9a29ddK0LtQjxeJuhlAyGguUd0sdfWw47/L4/4qVpkj+b/+VLbkXspXaufRCAvDiDZI8FB8mPvdyrs3Ilcwg/j6frdMQqRmZnA6a4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hj/0y18u; arc=none smtp.client-ip=91.218.175.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hj/0y18u"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oI6zWjbcXZWB68FpjI7jTxXKEfZqmqBavkWbQehTQhQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788980654; v=1; x=1789585454;
 b=Hj/0y18uoRDqJFQD050tYqbF6vetH5OKAawWQIXpW9612N2uBV56TJw0/2Okfa6Pq0j4dPqw
 yBSyqZMcUUTjHNqCpN4+LmYOfCtu8jMOQ0GntOtljSUAvviC1dmJ7GtSoWAeI6jW+Oq3B0RaQpC
 f4qg1ReW2neQRl4gfC8WfK18=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dca87e68235aa534;
	Wed, 09 Sep 2026 19:04:14 +0000
X-Mizu-Trace-ID: dca87e68235aa534
X-Migadu-Flow: FLOW_OUT
Message-ID: <261c5e00-31d8-4090-aab4-a633924d336c@linux.dev>
Date: Wed, 9 Sep 2026 12:04:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] libbpf: Add bpf_program__add_flags() and
 bpf_program__clear_flags()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
References: <20260903092416.223294-1-toke@redhat.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260903092416.223294-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/26 2:24 AM, Toke Høiland-Jørgensen wrote:
> When changing BPF program flags, applications often need to just add or
> remove a single flag. The bpf_program__set_flags() function clobbers any
> existing flags value, making this awkward to do non-destructively.

I think the whole "non-destructively" language in the series is misleading.

    bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);

does exactly the same thing as 

    bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);

That is: overwriting the prog->prog_flags value. Where is the non-destructiveness?

Let's call this for what it is: a convenience API.

pw-bot: cr

Other than that the series looks good to me. Feel free to add:

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Assuming the commit message changes.

Thanks!


> 
> Add two new convenience helpers, bpf_program__add_flags() and
> bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
> bitwise operations required to avoid clobbering things.
> 
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c   | 10 ++++++++++
>  tools/lib/bpf/libbpf.h   |  6 ++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..221c4fe1fb31 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9938,6 +9938,16 @@ int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
>  	return 0;
>  }
>  
> +int bpf_program__add_flags(struct bpf_program *prog, __u32 flags)
> +{
> +	return bpf_program__set_flags(prog, prog->prog_flags | flags);
> +}
> +
> +int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags)
> +{
> +	return bpf_program__set_flags(prog, prog->prog_flags & ~flags);
> +}
> +
>  __u32 bpf_program__log_level(const struct bpf_program *prog)
>  {
>  	return prog->log_level;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..3932bf9cb490 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1011,6 +1011,12 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
>  LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
>  
> +/* Convenience helpers to non-destructively add or clear the specified flags
> + * instead of clobbering them as bpf_program__set_flags() does.
> + */

nit: this comment is unnecessary

> +LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 flags);
> +LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
> +
>  /* Per-program log level and log buffer getters/setters.
>   * See bpf_object_open_opts comments regarding log_level and log_buf
>   * interactions.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 08ab2ea881fb..a811a1b3a085 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,7 +458,9 @@ LIBBPF_1.7.0 {
>  
>  LIBBPF_1.8.0 {
>  	global:
> +		bpf_program__add_flags;
>  		bpf_program__attach_tracing_multi;
> +		bpf_program__clear_flags;
>  		bpf_program__clone;
>  		btf__find_by_name_kind_own;
>  		btf__new_empty_opts;

