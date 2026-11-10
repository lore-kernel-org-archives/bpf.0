Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286275;
	b=PHwTHzbWO1Sgf6Kqrc1IIizV9ViD5qOHg3RXKxROtN3nHFwaADwiUBVYKjk9mAt67Pbg
	 Qn43ZXsJ9kXj0tguZfdTDooh8ASyIq1TVGGk8di2TDmGWjotyfCDG+euvfvb+t8YfKlYs
	 aBDX+6QkWtvLiLoqzfgcTlQFYhsNspiDn1CwI8ItsSd0l9UDSfQf3dPRHJoQTGstOswIg
	 5pPoVy4XTallyS+m+XEgvcTdnIjrXC1RBrlfdh+e7r5q2dpv2Fo0ysal21c3THm8FRlwK
	 syCxfBs9FWIwl6WynhXEgbeaMWFRt6DD0ap5UoVm/x5tzLBQ6RiGx1YGCJ34sB9cJng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286275;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=szESm3sydnu6tGXxhtwJ3Uszu+ynDxhOJRPZ5qVcTt0=;
	b=drdO2lHsWCl+cCcVf9zFIa9/fYRVdQsEDvzZyF+clTaj2+/K8V24XATfFcfdjgClFcrE
	 rGAPuC1d/mVpgS7za1f9eh4GAol8twa0RMd6CSvmmmyjKXBkx7o5/4RqxoqytlHy2NSkH
	 EItXx7n4bNrmXW8BkxrccOTOUCjBni3Iv16uHchk0hmFu/Wha7sftXDBMq9kIAZcPKOtK
	 H8/QRWEie3to22l2TicWjQER8YDPr4gS2EBobGDjnPOL0ZwnHYgop/YIRTxFv2yj4N2AZ
	 KZeK3C6XxffppjRJ/uN3o9G/k3DJr+WgNXckeGkp1fKqZMGvDnJTujjgMOVDGmLtAgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IElSsEtW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC29606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IElSsEtW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D871F0089F;
	Tue, 10 Nov 2026 04:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286274;
	bh=szESm3sydnu6tGXxhtwJ3Uszu+ynDxhOJRPZ5qVcTt0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IElSsEtWPE3ppod7B+ylrA9q0z9tICJlQaPBJFy+Bm/aThcqJ6oKsYWWA8RlC/iN1
	 rLeMrFXFSs7XpGuLKwxV6h7l2nvg2OS2s15FVNRYbc3jKWBL/cbKtVoFHlUc3wk0i8
	 kfH5uFCHGy2K9heiOTnrSHVk5LFC6+RprugB0T28KPfB/pgSVLgGOrUISH0KfDtt/P
	 YrA0I0JexQnv+vyNCIVEpLbkR+YgE6uR5094JLND7A/Pev8l2oNuid8yj14QYPl4dP
	 q8SXVraFS6LvRhYKx9JWU/sNfBdi9PXyRsBYBUkkV5WfiFmNGcOIiI+HzxJZZo7JiB
	 vaMi/cQ5XfTjQ==
Content-Type: multipart/mixed; boundary="===============6021103609634742832=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f03cef10c23b8fee04cb99ae8ea90f9e65a0bc8c06c0a4e405d1d9d205e3b502@mail.kernel.org>
In-Reply-To: <20261110003838.8739-8-emil@etsalapatis.com>
References: <20261110003838.8739-8-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: libarena: Refill local caches in batches
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:51:14 +0000 (UTC)

--===============6021103609634742832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Refill local caches in batches

TL;DR: Nit only: the new comment in buddy_cache_alloc() saying NMIs only use
cached objects looks inaccurate, since NMIs can still trylock the buddy lock
on miss or spill; the commit message omits the NMI exclusion.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -140,7 +158,11 @@ static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t size, size_t order)
>  	if (!cache)
>  		return NULL;
>  
> +	/* NMIs cannot take the buddy lock, so they only use what is already cached. */
>  	address = buddy_cache_pop(cache, order);
> +	if (!address && !bpf_in_nmi())
> +		address = buddy_cache_refill(buddy, cache, size, order);
> +
>  	buddy_cache_exit(cache);

This isn't a bug, but is this comment accurate?  buddy_lock() uses a trylock
in NMI context rather than refusing the lock:

    #define buddy_lock(buddy, flags) \
        (bpf_in_nmi() ? arena_spin_trylock_irqsave(&(buddy)->lock, (flags)) : \
                        arena_spin_lock_irqsave(&(buddy)->lock, (flags)))

On an NMI cache miss, buddy_cache_alloc() returns NULL and buddy_alloc()
goes on to buddy_alloc_memory(), which calls buddy_lock().  An NMI free into
a full cache also reaches the lock:

    buddy_free() -> buddy_cache_free() -> buddy_cache_spill() ->
    buddy_free_bulk() -> buddy_lock()

So NMIs do not only use what is already cached, and skipping the refill does
not keep NMIs off the buddy lock.  Would something like "NMIs may only
trylock the buddy lock, so do not refill the cache from NMI context" describe
the intent better?

The commit message does not mention the NMI exclusion either.  The later
commit 74ddd93cc764 ("selftests/bpf: libarena: Add a transfer cache") removes
this comment and the !bpf_in_nmi() check.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755638928
--===============6021103609634742832==--
