Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159895;
	b=tycITNHGgedzn0Q4uc6rwgYbaCoAx9BPUFX5C6p5/yoERFVP7bwDHAgfohpY2XNt+L5a
	 M/UjwKfzHFnlQVcywUjhxXOW2SP8+ntNSpFPT96eLqiMUREtYOBHeSUv9xkwHErlXdFH3
	 1sTy6ZZevdoT7DTFTsDJDGMuLpWqwI31vdmN+ytVq4Q2s0xrjPrslITR4ZmXsxps7eeK/
	 v+xrBoMLExw26aMbDS8lsOCGS/FaH3RphgBgrRX6VLU/wvyLaq4d11eiN3pl7egLQDDPL
	 gjwFi7q/t5Fu1ube1Aimm1isRgnOU4A0QElAlCHyiWyDoVhDBf8FrKdkyZZbbPnPKlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6grRI+4VAxB+wJwzK1mKtZQfClKFfx9TbPv66h4ZBS8=;
	b=OgpwxM6vPldSx/mT9vQJgNvmTNX5ooyW79xAhgaOQi/35YghNgdPeH3Xd0GK5OLSUeUw
	 LctpnzF9+uO3ne0RDPsTpChRryBBolG6Xuj99wkt8qz8C3p9Crp3Q7it9n3TIE4fp+ysj
	 0MVdoHlmixqoEdxQNC45QWrwFWS87kZNCJBigr8g+WgH26awtsNznLVfjg0OthOBbrV7p
	 XpVRD9Az0jA7d5RyXAAbSyb4ezbwSe+6gLx984/Snn3TwRHxJjZW3ztaHgPVbAuHeVqZ8
	 IY6rxVG4g2PHlidt8VNkYPfpuxvcJGYLJ97/vtrAkVtj4jQx79aA/PGuKemKL91dUEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUzTsBFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF09606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUzTsBFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EB01F000C4;
	Fri, 20 Nov 2026 07:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795159895;
	bh=6grRI+4VAxB+wJwzK1mKtZQfClKFfx9TbPv66h4ZBS8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GUzTsBFuTJ8DsW2EuBh4ipyY4y+Rhh38/+egONVxgBPepUWjBxNj9qJoFWKtYBLF/
	 MzFDN1GYUC8AhDbMHaI9ZK+WF8C5PvlaEOkK63zc66Q9N1/yoabyNkW4DVzmPPCUXp
	 JJQZAzjkX6daOOksK4S6hlXWsVb4hJOOCs7Dw6iKE0v70j/mzm2VCq+SMdW8TKxqfo
	 Tp38ep3T4C7kWoiZAa3jPItH0rHn+kExmsOUhghM/89/WhLXHZiZE7I5/Zre+34IOL
	 RqEL73s2GKsxykBFCJdRs00CLX3IMeS/sdVGV/mqokzYkv+uA75jRyXKFzbIxwoir8
	 8/CUjy8t9Q8kw==
Message-ID: <sashiko-outbox-224630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] bpf: Introduce classic BPF filter cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <adf466cb2cad6c674b7da5efbebfc2c3e3e8800c.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
 <adf466cb2cad6c674b7da5efbebfc2c3e3e8800c.1795139109.git.xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:31:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf: write to read-only bpf_prog in cbpf_cache_complete()
- [Low] bpf: unsnapshotted bpf_jit_enable read in cbpf_cache_tag()
--

commit 150cca79ed8acc9b4ba7fe54a3257e050436741a
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Introduce classic BPF filter cache

This commit introduces a hash table cache for prepared classic BPF filters
so identical user-space filter programs share the same prepared bpf_prog.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7fa8b81fd1dcb..f8ef6a041e8fd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -1187,6 +1193,282 @@ static void bpf_release_orig_filter(struct bpf_pr=
og *fp)
>  	}
>  }
> =20
[ ... ]
> +/*
> + * calculate tag from the allocation-time JIT and blinding states, so sy=
sctl
> + * changes produce a different tag.
> + */
> +static u32 cbpf_cache_tag(const struct bpf_prog *prog)
> +{
> +	u32 tag =3D 0;
> +
> +	tag |=3D (prog->jit_requested << 1);
> +	tag |=3D (prog->blinding_requested << 2);
> +#ifdef CONFIG_BPF_JIT
> +	tag |=3D (bpf_jit_enable << 3);
> +#endif
> +
> +	return tag;
> +}
> +
> +static u32 cbpf_cache_bucket(const struct bpf_prog *prog)
> +{
> +	const struct sock_fprog_kern *orig =3D prog->orig_prog;
> +
> +	return jhash(orig->filter, orig->len * sizeof(struct sock_filter),
> +		     cbpf_cache_tag(prog)) % CBPF_CACHE_SIZE;
> +}
[ ... ]
> +static int cbpf_cache_insert(struct cbpf_cache *cache, struct bpf_prog *=
prog,
> +			     struct cbpf_cache_entry **pentry)
> +{
> +	struct cbpf_cache_entry *entry, *hit, *cur;
> +	u32 bucket =3D cbpf_cache_bucket(prog);
> +
> +	entry =3D kzalloc_obj(*entry, GFP_KERNEL | __GFP_NOWARN);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->orig =3D prog->orig_prog;
> +	entry->cache =3D cache;
> +	entry->tag =3D cbpf_cache_tag(prog);
> +	entry->bucket =3D bucket;

[Severity: Low]
Can entry->bucket and entry->tag disagree if bpf_jit_enable changes via
sysctl while cbpf_cache_insert() sleeps in kzalloc_obj()?

Unlike prog->jit_requested and prog->blinding_requested, bpf_jit_enable is
read live from the global variable on each cbpf_cache_tag() call rather
than from an allocation-time snapshot.  If bpf_jit_enable changes between
cbpf_cache_bucket() and cbpf_cache_tag(), the entry is inserted into the
bucket hashed with the old tag while storing the new tag in entry->tag, so
future lookups in either bucket will not match it.

[ ... ]

> +/* publish the prepared result, and wake up waiters */
> +static void cbpf_cache_complete(struct cbpf_cache_entry *entry,
> +				struct bpf_prog *fp)
> +{
> +	fp->orig_prog =3D entry->orig;
> +	fp->orig_prog->cache_entry =3D entry;

[Severity: High]
Does assigning fp->orig_prog here fault on read-only memory when the filter
is not JIT-compiled on a !CONFIG_BPF_JIT_ALWAYS_ON kernel?

In bpf_prog_create_from_user(), cbpf_cache_insert() clears prog->orig_prog
before calling bpf_prepare_filter(), and cbpf_cache_complete() restores
fp->orig_prog afterwards.  However, bpf_prepare_filter() ->
bpf_migrate_filter() -> bpf_prog_select_runtime() ->
__bpf_prog_select_runtime() calls bpf_prog_lock_ro(fp), which marks all
pages of struct bpf_prog read-only via set_memory_ro() when !fp->jited and
!CONFIG_BPF_JIT_ALWAYS_ON.  Writing to fp->orig_prog in
cbpf_cache_complete() then triggers a supervisor write page fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795139109.gi=
t.xukuohai@huaweicloud.com?part=3D1
