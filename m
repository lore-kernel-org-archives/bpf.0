Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95616336EDA
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511258; cv=none; b=bYnC9UhWSkDz88wT+TPtNMaF7PYkA8etvrrtxBd+HAZ/FV/7oLCypsYAs53SQ9NFAhQyfQilSB7g3gM948D7srHBnWFhUcg1mDi5CIg64V07GWcTQpKYsmlNJLXsxjrHolmEd9iOn7I2x6edQkq9zi9H96Qfhn2w3VscvjcNLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511258; c=relaxed/simple;
	bh=GOwOOoLthOEQY+oLJGS5XEHegAW+7GNm5yTkXH7lRNk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gSbMcOd3eUNDMALmE//QHiU+oMj0qr3dDr3UNMTNCNcCFL9QGEzPNCJgthTsBHXOHH0QFybUeHIIH2rDWPgw6mfp14cIojwk2eYSxcsQ+5BffwMT9nqcusWo7FvawKEf3+j2mG8TEqZfkuH8XueZ75+DTWkG9zePn6oI7ldZ9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7uAWnhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7uAWnhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D5E1F000FF;
	Fri,  9 Oct 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791511257;
	bh=kjt9/0I0jM3acq4Ge08UN/Yuez9SswF7oBJufL8uWQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7uAWnhRkij7CCJKmJH21xF7jWGVc5w1AgAUif+kotMOusnOmNbo7v8qgwJrULO/2
	 iS5xURI9K9F0cwt/4u4Zd7zDKxHW3BCkrpgQSac/Vn/UF27XehgDN82n6o2K+2IhqQ
	 A6exkzQMxxsJ99qZ6Kt6znkQ2O4cSnBCgTNhqQWOJn0obORwImBC9IgwXvcLc0XH2i
	 c+KAh7vrn4iiD6cyD3Yi75J10IMKOVxgr78f/gP5CWcsMjcffKM5b8VgKoHz0Eo8Hh
	 NIjNe1RdRBTKnO5Xhbigunn+20rJkdqBF6Zkbp7y0+fJK0JyyOOlyMvBfpSYkUI3JL
	 ooLdGYlVEPE0A==
Message-ID: <sashiko-outbox-164715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Return the lock error from
 buddy_init() of libarena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-selftests-bpf-libarena-nr-cpus-v1-1-e726ccc66fc6@gmail.com>
References: <20261009-selftests-bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com>
 <20261009-selftests-bpf-libarena-nr-cpus-v1-1-e726ccc66fc6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:00:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: missing ASAN poisoning on chunk free in buddy_init() error =
path
- [Low] bpf: libarena leak of reserved vaddr on buddy_init lock failure
--

commit 38d07f939b85ac6851d3855b00b730195ca11736
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Return the lock error from buddy_init() of libarena

This commit modifies buddy_init() to return the specific lock error from
buddy_lock() rather than unconditionally returning -EINVAL. This helps
distinguish between -EOPNOTSUPP, -ETIMEDOUT, and -EBUSY cases.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 2490ab1396de0..7bb99a7cb63ed 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -576,9 +576,10 @@ __weak int buddy_init(struct buddy __arena *buddy)
> =20
>  	chunk =3D buddy_chunk_get(buddy);
> =20
> -	if (buddy_lock(buddy, flags)) {
> +	ret =3D buddy_lock(buddy, flags);
> +	if (ret) {
>  		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);

[Severity: Low]
Does this code leak the reserved arena virtual address space?

Earlier in buddy_init(), buddy_reserve_arena_vaddr() is called to reserve
enough address space. If buddy_lock() subsequently fails, the error path
frees the allocated chunk, but it does not call buddy_unreserve_arena_vaddr=
()
to clean up the reserved space before returning the error.

[Severity: Medium]
Could this error path leave the freed chunk memory improperly poisoned?

When buddy_chunk_get() successfully allocates a chunk, it partially unpoiso=
ns
and poisons the memory for ASAN. In buddy_destroy(), the chunk is correctly
repoisoned by calling asan_poison(chunk, BUDDY_POISONED, ...) before the
memory is freed.

If buddy_lock() fails here and bpf_arena_free_pages() frees the chunk witho=
ut
first re-poisoning it, does this leave the ASAN shadow memory in a stale
state that might cause false positives or negatives if the pages are
subsequently reallocated within the same arena?

> -		return -EINVAL;
> +		return ret;
>  	}
> =20
>  	/* Chunk is already properly unpoisoned if allocated. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-selftests-=
bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com?part=3D1
