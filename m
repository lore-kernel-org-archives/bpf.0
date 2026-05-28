Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5794028FB
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992723; cv=none; b=uc/92IwKiA3MM2ayky1JyUrsxofJHolvT+HUwM4SixZ6WYnJrA31G9ZeZlbw17Bkw+8euIKuOufRbBSsPXKNfch5/rlJs5hCB8WM28A8PL6D0CD6aXKCUtYCDsyISpEz7Jck9hcy/vghJamz7SNYM6Y5CzIE321VbFRW8MUDh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992723; c=relaxed/simple;
	bh=atHZiVIqpOj6ZK49l97klIBL+5nx0aHnMcjFtTn6sD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ol3tEMFxpzuLQl2NhrSWLYz+xsBY9peaGZhKVln7mohg5ViGblWxzecZCpulMPLfCcEQLS2vcFSjUJxYGeq8XgcyRf4ByBtUiJCtI+ehr9xhy/m0rYIluz9Rbr05YpPcifFvkaoX/0tC4wMg0BAAGXFDFxg4nwNdOjYyeklY4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhM6v3M5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhM6v3M5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D121F00A3C;
	Thu, 28 May 2026 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992722;
	bh=g9m83s0B7Lxn1ZGsU57UlM1v2ErwozbLyYCRbgzGeaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhM6v3M5ZrFHBZjmOsXPcyd3fyWXWDJJM7jnsdIFHIx1INGlnOSJPywazks/H1zfg
	 /ONY1V1lbL+aRj/sVg7bVnHRTtYmHuscEbN/PZVYT8ww4hpGvV37q/9ntB4DwXjRnf
	 rCbqTRHZiBxMAbUSXuw5RTMJGIz76W0dbbJeqeP1jbFdrrFuUQuLCRRz61EqQhCksw
	 X7RRtUEh0tM9DzY54YshjYjEHAbwzCwBQ5vWxbhyQhHw/S646ayTCcTop3aqeW4R+q
	 vC6HgOI3vb9qb6iu24vLa6TzztU+jhziGL547S5ouznBegcUaE9zX6alx+uiCrQdBw
	 OI1e8PaLaYkyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Optimize word-sized keys for
 resizable hashtable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-rhash-v5-6-7205191b6c57@meta.com>
References: <20260528-rhash-v5-6-7205191b6c57@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:25:21 +0000
Message-Id: <20260528182522.23D121F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Trivial hash collisions in `rhtab_hashfn_long` defeat rhashtable's=
 DoS mitigation, leading to infinite rehashing and 100% CPU livelock.
- [High] Direct dereferencing of potentially unaligned map key pointers in =
the optimized hash and compare functions will cause kernel panics on strict=
-alignment architectures.
--

commit 40f8c726140c6268e5f797c092818cebd3cfc282
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Optimize word-sized keys for resizable hashtable

This commit specializes the lookup, update, and delete paths for word-sized
keys in resizable hashtables. It introduces a custom XOR-fold hash function
and single-word equality comparison to bypass the indirect jhash dispatch.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> +/* Specialize hash function and objcmp for long sized key */
> +static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_=
arg *arg,
> +					      const void *ptr)
> +{
> +	const unsigned long key1 =3D *(const unsigned long *)arg->key;

[Severity: High]
Could dereferencing this pointer directly cause alignment faults on
architectures that require strict alignment? Since BPF programs can pass
unaligned pointers (such as from packet data in skb->data) directly to map
helpers, using get_unaligned() might be necessary here to prevent kernel
panics.

> +	const struct rhtab_elem *key2 =3D ptr;
> +
> +	return key1 !=3D *(const unsigned long *)key2->data;
> +}
> +
> +static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, =
u32 seed)
> +{
> +	u64 k =3D *(const unsigned long *)data;
> +
> +	return (u32)(k ^ (k >> 32)) ^ seed;

[Severity: High]
Does applying the seed after folding the key make hash collisions entirely
independent of the seed?

If a BPF program or an attacker inserts keys constructed as:
k =3D (Y << 32) | (X ^ Y)

These keys will all fold to exactly X before the XOR with the seed,
meaning f(key1) ^ seed =3D=3D f(key2) ^ seed for any random seed.

If rhashtable detects a long bucket chain and triggers a background rehash
with a new seed, won't all these colliding keys move together to the same
new bucket? This might trap the rhashtable worker in an infinite loop of
rehashing, leading to a 100% CPU livelock.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-rhash-v5-0=
-7205191b6c57@meta.com?part=3D6
