Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2165208B9
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030081; cv=none; b=ETBI/3RSyITw7ZPSM117PL6NTcijasVlz4V1/wdu7wK03L4tdY9eEjhqMLfLgV5V8HkxD6d79pimnw9YKuNhj524nPGWuQwocEVop1QLiNCxRq1fHaD+3mrpDdpUVxX4IkuWCy2CZxsSXf5doVVhPjggwx6G60+n8ZZztls9MHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030081; c=relaxed/simple;
	bh=m+NQxY/JHe6IrbMXVIjjkrSYGkZt5xA3xOXQOZUdDJE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nwnDt43AF4xEV/XWq2G5gMmzkx92pjdV17l+B7aerkdwg5qdMkit7rr/xIIfZPfh5WBJMg7sZKrYyTc08/0GoGw7Ay1NXtVOeGxzxqa/d+h4Ten/LuprXnIXQpL0RRHV3P+U8Ab87lhn0gPtfaZX3uysp2lyOJDV/EsM7SLT4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFplHNAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFplHNAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DA91F00893;
	Mon, 21 Sep 2026 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790030080;
	bh=HUpRa3/A2OOS5ogIhpzPex70XfPpBjiTbWCU4AAFLy4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bFplHNAECLm4x13rcQC9xmSStClX5MuahpKke0bZnYatgdLqej/mYLm1QPR+66ZCI
	 0Cb5ed080I0p0aTMYG2PqFvto9KraUvaobkkwdsMqGp21M3isLT1auAeNTIwbRXg4C
	 jAFNApXy579Mn7vmH/xmFcaQickkLiIExOdr0CWmTsjbduX+d8jjDzefsetfOnDjDG
	 eAB8sImv/PStY6+srF56msY88xOAwrEKWZkcEzTRO4xtUmTXlZuVPoTBJCpgx4U0cR
	 cVHWwKtEhhgsQcIzv6Fhgpx3rDDXTF0hba6pyLaaTgETz6X5rnNRm01w628r4j/+fD
	 DeEfeLLtCFKsw==
Content-Type: multipart/mixed; boundary="===============7899129799709695997=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9df62abd0ea5564c35bff6a3eb407abac79085c7785343abe30b01a49619b60@mail.kernel.org>
In-Reply-To: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 22:34:38 +0000 (UTC)

--===============7899129799709695997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6f331c80130d7..77c96105eda84 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>   * The return value is adjusted by BPF instructions
>   * in htab_map_gen_lookup().
>   */
> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>  	struct hlist_nulls_head *head;
>  	struct htab_elem *l;
> -	u32 hash, key_size;
> +	u32 hash;
>
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
>
> -	key_size = map->key_size;
> -
>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
>
>  	head = select_bucket(htab, hash);
> @@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>  	return l;
>  }
>
> +static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	return __htab_lookup(map, key, map->key_size);
> +}
> +
> +static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
> +{
> +	return __htab_lookup(map, key, sizeof(u32));
> +}
> +
> +static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
> +{
> +	return __htab_lookup(map, key, sizeof(u64));
> +}
> +

Does the comment block at the top of this hunk still describe the right
function? It says "arguments have to match bpf_map_lookup_elem() exactly",
but __htab_lookup() now takes three arguments (map, key, key_size) rather
than two. The comment also says the function is called directly from BPF
programs or syscalls, but __htab_lookup() is __always_inline, so it is
never the target of BPF_EMIT_CALL() in htab_map_gen_lookup().

The signature constraint looks like it actually applies to the three new
wrappers added below (__htab_map_lookup_elem, __htab_map_lookup_elem_u32,
__htab_map_lookup_elem_u64), which all take two arguments and are the real
call targets. Those wrappers carry no comment at all.

Should the "arguments have to match" note move down onto the wrapper group?

There is a related staleness in the call-flow comment at htab_map_gen_lookup()
around the BUILD_BUG_ON():

>  * do:
>  * bpf_prog
>  *   __htab_map_lookup_elem

The body now emits calls to __htab_map_lookup_elem_u32 and
__htab_map_lookup_elem_u64 for 4- and 8-byte keys, not just
__htab_map_lookup_elem.

> @@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>
>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> +	if (map->key_size == sizeof(u32))
> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
> +	else if (map->key_size == sizeof(u64))
> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
> +	else
> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>  				offsetof(struct htab_elem, key) +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35659099108
--===============7899129799709695997==--
