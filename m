Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C37311977
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433838; cv=none; b=BRO34/UbYZ8GKKtX8wr4G18kdURffC1YWGIcTE6j8loFldl1TBeFDqecmFSzo/q+vRqPFkX7mQ+7EVF+kepzyhpwnVThod0yPf0cghqV3MWNw6TsoSSZc/VhyOE0YVfT5q2sVM51tfWBahZlqY1a776AXCANWZYFb7cPHLtVHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433838; c=relaxed/simple;
	bh=Xhle6P63cdQ/bk9ZHlO9/401RHNDNYmm7hRUBCJZ4og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYNg76DeEEKwy8bx65wbDqQFBx6/lq7nrsDvXn9SwduBlQ8V0PfxiScrz/LkLsuMiWOcJz1jPJMLqIULSxsFo3z3OeonkEfV49Ee+nv0VhiZsZVk35JBqyUeIkYSHBqQPXK8XTwo5Hm/VtFMHo7P9jZZlYTFaULeRZaea2nad4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4oNpLG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4oNpLG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDBE1F00893;
	Tue,  2 Jun 2026 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780433837;
	bh=w84YggQhrz020kqPFJLlUmPp43v7TsdTnbgRv3oCw9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4oNpLG8VKbk3Ifmv71hk6YQnqRazgZl2LjEZc8jPLYxBMgZRq3XMLUrF4lYXa2Z+
	 D9YYShENXjJNonDJmJOKzCtyK8tEmmyyT3CBgDZHkMJDBgTsge20CL1EGiIINY8TO/
	 Frev1TUl6ued6kz413uRhHpFvYI++0Cwjbp9+d/t2hIMSgPMHdpR3mtdnh6h6qUErj
	 iLo34IsCf2QD+gvBBZYKsgWpprIjjI8aOifK34+0ZYlzeP+3R+fQHy/uLMrzOlD+Sb
	 88UbUhFE7mR/7cVsNaYJNLObTJ8LPE5FgU1jJhnutbLWP2EDGGZpjh3H4MxB/Lix2d
	 svQT1Aj95GrsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 01/11] rhashtable: Add rhashtable_next_key()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:57:16 +0000
Message-Id: <20260602205716.BCDBE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rhashtable_next_key() enters an infinite loop if duplicate keys ar=
e separated by a hash collision, leading to an RCU stall.
- [Medium] The iterator silently skips adjacent duplicate keys, failing to =
visit all elements and contradicting its own documentation.
--

commit b366f42abdf91779a5e3f642f8f7f76f7fa5895b
Author: Mykyta Yatsenko <yatsenko@meta.com>

rhashtable: Add rhashtable_next_key() API
   =20
Introduce a simpler iteration mechanism for rhashtable that lets
the caller continue from an arbitrary position by supplying the
previous key, without the per-iterator state of the
rhashtable_walk_* API.

> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece364..7bcc380ec192b 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -650,6 +650,110 @@ static __always_inline struct rhash_head *__rhashta=
ble_lookup(

[ ... ]

> +static __always_inline struct rhash_head *__rhashtable_next_in_table(
> +	struct rhashtable *ht, struct bucket_table *tbl,
> +	const void *prev_key, const struct rhashtable_params params)
> +	__must_hold_shared(RCU)
> +{
> +	struct rhashtable_compare_arg arg =3D { .ht =3D ht, .key =3D prev_key };
> +	struct rhash_head *he;
> +	unsigned int b =3D 0;
> +	bool found =3D false;
> +
> +	if (prev_key) {
> +		b =3D rht_key_hashfn(ht, tbl, prev_key, params);
> +		rht_for_each_rcu(he, tbl, b) {
> +			bool match =3D params.obj_cmpfn
> +				     ? !params.obj_cmpfn(&arg, rht_obj(ht, he))
> +				     : !rhashtable_compare(&arg, rht_obj(ht, he));

[Severity: High]
Can this iterator enter an infinite loop if duplicate keys are separated
by a hash collision?

Since rhashtable prepends new elements, a bucket could end up with
interleaved keys like A2 -> B -> A1.

If an iterator encounters this, wouldn't it result in an endless cycle?
Passing prev_key =3D A finds A2 at the head and returns B.
Passing prev_key =3D B finds B and returns A1.
Passing prev_key =3D A again finds A2 at the head and returns B.

Even if the structure enforces unique keys, could a concurrent deletion
and insertion of key A create an RCU bucket chain of A_new -> B -> A_old
and trap an iterator holding the RCU read lock?

> +			if (found) {
> +				/* Skip duplicate keys. */
> +				if (match)
> +					continue;

[Severity: Medium]
Does this skip adjacent duplicate keys instead of visiting them,
contradicting the documentation?

The rhashtable_next_key() function is documented to handle tables with
duplicate keys, visiting each duplicate once.

If a bucket contains adjacent duplicate keys sharing key A (for example,
A2 -> A1 -> B), passing prev_key =3D A matches A2 and sets found =3D true.

The loop then evaluates A1, sees it is a match, and hits the continue
statement. This returns B and skips visiting A1 entirely, causing data
omission during iteration.

> +				return he;
> +			}
> +			if (match)
> +				found =3D true;
> +		}
> +		if (!found)
> +			return ERR_PTR(-ENOENT);
> +		b++;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-rhash-v6-0=
-1bfd35a4184f@meta.com?part=3D1
