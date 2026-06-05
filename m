Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC437E2EE
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662132; cv=none; b=jZyonRN/zeHYfqt3netRQL92rZp/LRpH09P+Rvq7sKFZzNEfD13YBFsmRLmwQPeg12H7NHDwnWSpnIESkEkJJz3nwbXsPfnpiN84ofzlnMU11l3R7J75Qjvm/TGWJIprWv+5d0KI4UJQspK6T9QzwEMUgUyvMDJWc8jv9ijacG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662132; c=relaxed/simple;
	bh=FkhXNTuRdMOWnGzKFAZXbJcvhCSfm+nl2opUkNJDGVw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EXhOW5mPfSl8oDw8f7pacwaSDffUzBShgND8sc1IkAwsACP7ZEYuJD5xIiXeoTS1Xhsec2orsdnO4v3jO3OMqaXkwPs+cGR4XFruXhUzFgyYHXQyK8GDuV3ZCOI737p781sylpImoNQ7giww9lnC4NF8tX4gv8dzoy55Ek/NYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZlSpeGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZlSpeGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF46C1F00893;
	Fri,  5 Jun 2026 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662130;
	bh=FdDMoNMGPQQ4E2Es54PvHiWabNTkCm6aTMPzj7SaZIw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kZlSpeGuH5saKGtZ+5xkCnZz8p3x6ZVlRON1p2r81uzgMTv3v2jcJNkf7GYJNU9SS
	 OAlH0ZiBjC06jT3cbdBIrViyNgXLuzEiiXMBd/0P/Eof+FC6U2yveVtLhIo00hoTt2
	 4Hh4+L0A4eRz3k8ri+gcnOzJ5Ty6S6MG2H1HXdVAY1tYMALinFD5luJMIWXJttTSUn
	 fx9orBClCghXeSlK3XW2OSIVDfcUI88LsQwdidtG0VoJe/7NFsG4z/8RYeYMXxDYkv
	 25WakuEul1BKUwu4ODEi5Cf0aqChrE4HOl2nRWbvZ6x0nU24t7LrXTa1MZ90VlEfJV
	 E01rLzcfdRQKg==
Content-Type: multipart/mixed; boundary="===============1327767064383600339=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22927163b097eb5fccb320750193dcdaccc1a0c31add85153903234b19b8b7a3@mail.kernel.org>
In-Reply-To: <20260605-rhash-v7-7-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-7-5b8e05f8630d@meta.com>
Subject: Re: [PATCH bpf-next v7 07/12] bpf: Optimize word-sized keys for resizable hashtable
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 12:22:09 +0000 (UTC)

--===============1327767064383600339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 7b9408b8320c..b4366cad3cfa 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2763,6 +2763,31 @@ static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
>  	return l->data + round_up(key_size, 8);
>  }
>
> +/* Specialize hash function and objcmp for long sized key */
> +static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_arg *arg,
> +					      const void *ptr)
> +{
> +	const unsigned long key1 = *(const unsigned long *)arg->key;
> +	const struct rhtab_elem *key2 = ptr;
> +
> +	return key1 != *(const unsigned long *)key2->data;

Could dereferencing these pointers directly cause alignment faults on
architectures that require strict alignment?

Since BPF programs can pass unaligned pointers (such as from packet data
in skb->data) directly to map helpers, using get_unaligned() might be
necessary here to prevent kernel panics.

Previous discussion: The author responded in v5 that "the same problem
exists for the htab jhash2" but did not address the concern. This issue
was raised by sashiko-bot in v5 and v6, and repeated by BPF CI bot in v6.

Reference: https://lore.kernel.org/bpf/20260528182522.23D121F00A3C@smtp.kernel.org/

> +}
> +
> +static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, u32 seed)
> +{
> +	u64 k = *(const unsigned long *)data;

Same alignment issue here: direct dereferencing could fault on
strict-alignment architectures like ARM32 or SPARC.

> +
> +	return (u32)(k ^ (k >> 32)) ^ seed;

Does applying the seed after folding the key make hash collisions entirely
independent of the seed?

If a BPF program or an attacker inserts keys constructed as:

    k = (Y << 32) | (X ^ Y)

These keys will all fold to exactly X before the XOR with the seed, meaning
the hash output for all such keys satisfies:

    f(key1) ^ seed == f(key2) ^ seed

for any random seed.

If rhashtable detects a long bucket chain and triggers a background rehash
with a new seed, won't all these colliding keys move together to the same
new bucket?

This might trap the rhashtable worker in an infinite loop of rehashing,
leading to a 100% CPU livelock.

Previous discussion: The author acknowledged in v5 that "the attack is
possible in theory" but decided to "leave for performance" without
addressing it. This issue was raised by sashiko-bot in v5 and v6, and
repeated by BPF CI bot in v6.

Reference: https://lore.kernel.org/bpf/20260528182522.23D121F00A3C@smtp.kernel.org/

> +}
> +
> +static const struct rhashtable_params rhtab_params_long = {
> +	.head_offset = offsetof(struct rhtab_elem, node),
> +	.key_offset  = offsetof(struct rhtab_elem, data),
> +	.key_len     = sizeof(long),
> +	.hashfn      = rhtab_hashfn_long,
> +	.obj_cmpfn   = rhtab_key_cmp_long,
> +};

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27013077824
--===============1327767064383600339==--
