Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274495;
	b=4T79MAtgr+Wt0PS209FXixcP14R4rPEKqVDHTOm31dKwIFiHv48414wcDvhhpg3Lk987
	 XKxGuuzkRZ5ZLgNtuutQyxkBz4X3cSo631Y4H5axnWVQxgum165GuLPeHWD0mvH7x8c+O
	 qWp9BxFZOqxcd/9MB3COAWT+1IZIi7GUS7VhHnDkc0qUtXMX2u/Z2zmBCBuloNfhlQ6kQ
	 tIjUqjBsCbmDZTrhwWBFA4GTgB8OSy6fGyMwTmLsm6sglV33Fhi33xQmBuGz/oBr7XmFd
	 RePS2c0rrcnH/hxl9KXykWDSsPMyiI2pP1yCNzztWGWOwHC8CtoGNeUt48QqdJ2HQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LwQHPSBJ1ViplmiXM5k8hFlaCvbdPMvwMCBJY2BT8p8=;
	b=RLXDQJIJoK2kftwS+yMzW2q2L1h/PswQifrECNTF9rVHASE3GQCug9+D5Zgt4D/j4jcU
	 dFW+bTOZQWQNCn/HG733skjYjc5tUELk4i7e4nxgnn2SsrdIo/31/FFt5IaWQTtGimpzG
	 jMxyGaZZhRvRkFMJBGqtpwJkRXnXKkMfaWYCVAiFyHGs9Q7dEPXE+mEcMxDz4ZQos3zJh
	 PJpdZxtORCA+ly5USe3u99VTMmevpsYEqWXnWUMisNcSUU/Q/ebMz7VCWaWQpPsG/ECCV
	 ppcgplyM/8ngLdFDAy4wE9jj06ov7z8YxqD8Wl3su8i76nCbXMZlS2WZrWZ5XFNNqrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diUeNT4q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F572606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diUeNT4q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3431F0089F;
	Tue, 10 Nov 2026 01:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274494;
	bh=LwQHPSBJ1ViplmiXM5k8hFlaCvbdPMvwMCBJY2BT8p8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=diUeNT4qZnT63mW3Q/c/2XaDmYbWoYkAegu6G2DAZ8MpIXlRlzxvM4WTASNlMIVzt
	 WmZx36XR3jrvZEQAWchROnruS2c8Z8vZA0rtwDwNfXH3Ki/4a/ze7zIBj2L+aeMJJa
	 aox+lVvt0GY2JTKoNzv03hZ1XFrFf0qeD2zqPD1Ex9/FOLcBd5X05mfYN9WyvfsxPO
	 B3n91XY/7vFnk/5Z0nVd7Rw8Da022W6bOWlWLkrT6iWC9oK28+TcfOqNlO2RWpFVd+
	 twcd3ENIEwEjvCoMlMS84CyKIzDwIzb0tCrIG1ouipZchnBJgkPTtcrJTrS0WDikBT
	 MFMHumfTkgczg==
Message-ID: <sashiko-outbox-205971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 6/9] selftests/bpf: libarena: Handle NMI
 reentrancy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261110003838.8739-7-emil@etsalapatis.com>
References: <20261110003838.8739-1-emil@etsalapatis.com>
 <20261110003838.8739-7-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:34:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: inconsistent error return in
  buddy_deferred_free_start_bulk()
--

commit 6751ae768506dfa7101c71c63c2aa51a0d3eb6cc
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Handle NMI reentrancy

This commit handles NMI reentrancy in the libarena buddy allocator by using
a trylock in NMI context and deferring frees onto an intrusive lockless list
when the buddy lock cannot be acquired.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 58e666210fdbd..7fd74f4c50526 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -1187,6 +1201,98 @@ static __always_inline int buddy_free_unlocked(str=
uct buddy __arena *buddy, u64
>  	return 0;
>  }
> =20
> +static bool buddy_deferred_free_pending(struct buddy __arena *buddy)
> +{
> +	return buddy->deferred_free !=3D NULL;
> +}

[ ... ]

> +static int buddy_deferred_free_start_bulk(struct buddy __arena *buddy,
> +		 void __arena * __arena *addrs, size_t naddrs)
> +{
> +	void __arena *first, *last, *addr;
> +	unsigned int i;
> +	int ret =3D 0, order;
> +
> +	/*
> +	 * Chain the allocations into a local linked list. Possible because
> +	 * allocations are 16 bytes minimum and so fit a pointer.
> +	 */
> +	first =3D NULL;
> +	last =3D NULL;
> +	for (i =3D zero; i < naddrs && can_loop; i++) {
> +		addr =3D addrs[i];
> +		if (!addr)
> +			continue;
> +
> +		order =3D buddy_cache_get_order(addr);
> +		if (order >=3D BUDDY_CHUNK_NUM_ORDERS) {
> +			ret =3D -EINVAL;
> +			continue;
> +		}
> +
> +		asan_poison(addr, BUDDY_POISONED, BUDDY_MIN_ALLOC_BYTES << order);
> +		asan_unpoison(addr, sizeof(void *));
> +
> +		if (!first)
> +			first =3D addr;
> +		else
> +			*(void __arena * __arena *)last =3D addr;
> +
> +		last =3D addr;
> +	}
> +
> +	if (!first)
> +		return ret;
> +
> +	/* Splice the local list onto the deferred-free list. */
> +	buddy_deferred_free_push(buddy, first, last);
> +	return 0;
> +}

[Severity: Low]
Is the return value of buddy_deferred_free_start_bulk() intended when an
address in addrs[] has an invalid order?

When a batch contains both an invalid address and at least one valid
address, the final "return 0" discards the "ret =3D -EINVAL" recorded in the
loop.  Conversely, when every non-NULL address in the batch is invalid,
"!first" is true and this returns -EINVAL, whereas the locked path in
buddy_free_bulk() returns 0 and leaves invalid-object reporting to
buddy_free_unlocked() (which is also skipped for addresses filtered out
here).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110003838.8739=
-1-emil@etsalapatis.com?part=3D6
