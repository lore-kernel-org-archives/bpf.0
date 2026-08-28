Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DB37F33B
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942797; cv=none; b=C5vMM+G3XUkX8z2vRXYUWfJz3kCgl48qMS9x77MGRDarKZIfiXXGX+jdsnHsS4ezEaRz2D9IkaF+2H/bm+wTCQ5LMQnO41lJ3JsPktqgXly9bRTF8glNq17jMmoqjknf0gfIm/g5RsqQfkIQjbvKUK36KxqLCmbf0tCG0ISHRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942797; c=relaxed/simple;
	bh=ry5V4l1utXN3KGZBKyfy7oAhW5W3lGBY1lU7uSLiddQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HITLc2GTpmF6ZPsCTcQ9u5+nOOjqKaItOovwooGiqRLZdjB4iqN0IeJkelaQxhxml1EL2xw3Ge1T5Zmi+Kl8KjtKVPVEBLJmKRb6NEOgujDLXa/vPCccu/xorN3H+dtkE/gbx751qYNyvnk+5Jx6hazHaEL94FFpDAi3+5WPPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl2UkFQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl2UkFQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6F21F000E9;
	Fri, 28 Aug 2026 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942796;
	bh=T8boEacMI26or/yQQ1FLPrpmX7YUdKNWRkT8PTOg9H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fl2UkFQ0OQgXCOm5nLlIu+12NGgrJ1mJc4HYzvSepMYI1vqNijXQpoUrME4J23wXL
	 79OiJh0JJazg1/o/KKTcXsXv+OE1apxJv6IQBG3QRPgJeawsQ1weoaiLx/xqAyHUeA
	 240E9oDLP7qkp6C1qXQMpBcDzlonYOwlsiZswP+6MK2iFbvWN0lYpbjl0in414CxSc
	 VkXy4i02qbyH9XcVDGQZ3BBn7Vgsjx1sOKb2Kua2hntdTTrYeOGeCYr4qZzFtn0IbA
	 qmHKKkLkZ/rnn1dC5NNHl6ApJMBbJQHKGQ3OOJyeyNCMZUMrwyuBaYX7sxXWG4T4Az
	 VGu6HSFkBcVSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: bound resizable hash map iteration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260828183326.3330530-1-sh_def@163.com>
References: <20260828183326.3330530-1-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:46:35 +0000
Message-Id: <20260828184636.1C6F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The iteration budget `map->max_entries` is insufficient to prevent=
 severe RCU stalls because RHASH maps decouple `max_entries` from memory co=
nstraints.
--

commit e7196eb4e04d6b29df6a798ca5bcbe264c41d6e2
Author: Hui Su <sh_def@163.com>

bpf: bound resizable hash map iteration

This patch attempts to fix an unbounded iteration loop in bpf_each_rhash_el=
em
by using map->max_entries as an iteration budget. Duplicate visits consume =
the
budget to ensure termination under concurrent mutations.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446ca..3772e63f2f12f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3212,7 +3212,8 @@ static long bpf_each_rhash_elem(struct bpf_map *map=
, bpf_callback_t callback_fn,
>  	 * elements are deleted/inserted, there may be missed or duplicate
>  	 * elements visited.
>  	 */
> -	while ((elem =3D rhashtable_next_key(&rhtab->ht, prev_key))) {
> +	while (num_elems < map->max_entries &&
> +	       (elem =3D rhashtable_next_key(&rhtab->ht, prev_key))) {

[Severity: High]
This is a pre-existing issue, but will this bound be sufficient to prevent
RCU stalls if max_entries is set to its maximum limit?

For a BPF_MAP_TYPE_RHASH map, max_entries can be up to 1UL << 31=20
(2.14 billion) because the map requires BPF_F_NO_PREALLOC. This decouples=20
max_entries from memory constraints, meaning a user can instantly create a=
=20
map with the maximum limit using negligible memory.

If a user invokes the bpf_for_each_map_elem helper on this map while
concurrently mutating it from user space, the loop could repeatedly yield
duplicate elements.

Executing this callback 2.14 billion times inside an rcu_read_lock section=
=20
without cond_resched() will still take dozens of seconds. This easily=20
eclipses the standard 21-second RCU stall or 20-second soft lockup=20
thresholds, allowing a Denial of Service.

Could a smaller, fixed iteration limit or a time-based check be used here=20
instead to ensure the loop terminates before a stall occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828183326.3330=
530-1-sh_def@163.com?part=3D1
