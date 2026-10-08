Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDA438026
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456745; cv=none; b=Hg5FVEEZDRGyF9R6GM3ifGTS2J0unr/p/I4NFJwqVC26/kuGQADmy2FAlYfeQ0JROGAMY3x/8xS88TGP52bxfR+gt8Dy11+TcxMpqFzjyGpbE7Jfp3zDjqWp37Juz2nmnWjL2tPnzu7n+Ws6UyU/MYQa846Jn8mJQg8EjvHM54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456745; c=relaxed/simple;
	bh=NCijQdO+s0MVGEiuHS26aEBYa08V1bD/BDaJAeGqKSE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BjJdjQCV6JOLrNNLbykddS6SuijnvQ0JKwJzfQgrqt70ADZsv37TXvF2ysPZHfeIf0V4xsJxsvvt3FKskhpscD8zDYO4sFZBgmd5fPJh7mpyXVJibbb7thoS25lwpWxnlwBO7IDb+clPd6Xb/8MIaCmRMAjSL+crNdegGNF65hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3NVwPee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3NVwPee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30661F000FF;
	Thu,  8 Oct 2026 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791456743;
	bh=IhSGmEo5jYn5uVUTjOWZrnpKpdXaSrb74bZ1uZArN6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3NVwPeevMG5Xme3REf4eEj2+0uOHKuuTPJi6/KT8TO8S0YChXI7yzdudsKPzpksu
	 +t9nRtRBRMQL4ollibkLd6SmKD9myTzCzdIL3KbvCW9Ns+5z69zPRcj+HsDer/AGsY
	 7YcN6QA2QXDeU6pqqnrgL9Gg2iLbo+k5coRZQcKOqqbiBDuh0WU50EfJGnzc/GHBd9
	 Lqk5WeXOUA9QBbtJqJx0b/SJIUG30sKxi0h6OpSL5nlgNpnS8OPvUokG9QIsq2AEjl
	 DXRq+ViFSguEL42vW/CzgLjjtZ8bb/x2nAJwh/CPSaiPfDcnyZR3m2P4OhILiHoxyI
	 kKGLxSGJ/iO/g==
Message-ID: <sashiko-outbox-164052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008104108.993791-3-tjmercier@google.com>
References: <20261008104108.993791-1-tjmercier@google.com>
 <20261008104108.993791-3-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:52:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: lockless RCU reader race due to delayed key overwrite in recy=
cled elements
--

commit 4208dd21bf1b230b07d30630716cc32b6b4f2404
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Reduce elem_size by 8 bytes for small key sizes

This commit reduces the element size for standard and PCPU hash maps
with small key sizes by removing the 32-bit hash value. For these cases,
only the key field guards lookups, and the new key assignment is moved
to the end of alloc_htab_elem().

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 810db9c436534..9d4791ee17411 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -1241,7 +1347,11 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,
>  		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
>  	}
> =20
> -	l_new->hash =3D hash;
> +	if (htab_has_hash(htab))
> +		htab_elem_set_hash(l_new, hash);
> +	else
> +		WRITE_ONCE(*(unsigned long *)l_new->key,
> +			   htab_zero_extend_key(key, key_size));

[Severity: High]
Can this delayed key overwrite lead to a race with lockless RCU readers
when elements are recycled?

When a preallocated element is recycled, it retains its old key until this
WRITE_ONCE. However, copy_map_value() was already called just above this
location to populate the value for the new key.

If a lockless reader is concurrently executing __lookup_elem_raw() and
searching for the old key, the reader only checks the key without a hash:

    if (READ_ONCE(*(unsigned long *)l->key) =3D=3D k)

Since the old key is left intact while the value is updated, couldn't the
reader successfully match the old key but erroneously return the new,
unrelated value?

Would it be safer to invalidate the key before calling copy_map_value(),
perhaps combined with a memory barrier, to prevent a reader from matching
the old key while its value is being overwritten?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008104108.9937=
91-1-tjmercier@google.com?part=3D2
