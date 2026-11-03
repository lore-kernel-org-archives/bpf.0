Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732379;
	b=WkTLZWHemBh4Baoj9DoMKxO2nMTrdgaTY9H2SqzjTBkNXna/tPbE9r3SqRNh7GZkVLd9
	 SeZlEFOcKWFiQRauQuAd/seNFtZjjy7FBrI1KeIFElDqqyrFo20yYHPP/0XGWZNs5RQaP
	 Am9id64KWzZ98EDKo8tIJYoyvXkBEgYqe63GA+qVIDtJ2jO/uHunFj1ZP2NLI1NhjXeMZ
	 Xf5o9Tzr6Pmtz452d3y0qj5tzWDrpvobdq/bkzic7HHHggxTdRbV7UtSb6iAGGkapWaAM
	 eS6ZJn+Q1VI6LNb523/WCbF1SmMQ1HZdn+kVqRJB4UZdT3LQt2nMRu1LGWJYw9BYjnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732379;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J7jFrnBmk5PEeG6vzzjWP1vl3VCKIzoINpotNoygRBQ=;
	b=jj+fKuOnUSOcwiwEOKedLL4YfBRIW8/lfWKInb/7zbzA4hFoB0uwwc9GRrI4mpXG6Y+C
	 rxfgJxYo2k2zq9rsWK7tPE8w525G+GhPI6E5MSTBbaoce4m4E5zkuLxUO53+zJicS5Sdl
	 U/DCzJ21jHiD+ZCAZZ4jsrI+FYx3k2vIc6I+O1hGG/LI4ylfbHvrOnEHV3Z4sTdqhZSyf
	 14W8DimMrAPkx9MKicwVzNxDUbeOpxbo3eL7UDUAPFMsshWFuPFJ1kXzVkALfnOMzOk6n
	 3ycx/br2WppyzEntAVZZ/7+pzz+w7cTjnb6sqoVGTQu7nruYw1uceHHL7Ok3ygnPgtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiDiUF3X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F213606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiDiUF3X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B49F1F00919;
	Tue,  3 Nov 2026 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732379;
	bh=J7jFrnBmk5PEeG6vzzjWP1vl3VCKIzoINpotNoygRBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hiDiUF3XWYmmikww9kjYhMVqELJMLOxMf3rY5jyDqR9ydKzcV56pCKqSIS1ZSB174
	 /Evd0GKkhH2i+AFNJW1mqLTsmsP8kLC5PT37H4uP8A0zRczawxSdraDG1vwPoSPU8A
	 A+SVI8H3QlfF7ChqY8RJgxT7OS5BzCepkvmTKyWpdZLLLdKveVAT6VWnSFctER5xZo
	 CmvpSyscv40tBOTQbAA7aDQeGpvm1bEhIiXWbz9Liw5hedg6op7yNfsEfi46kNx00s
	 kLBDxSQIz4noXHAJFeHf2WJbzdDVyIeJlnwQqjmlYghhSpky13spVK2MtKfeXk7RMG
	 XiVC+P8QjVwTw==
Message-ID: <sashiko-outbox-195871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fail rhtab inserts and deletes with IRQs
 disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mani Tofigh" <mt4022@columbia.edu>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
References: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:59:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: livelock in rhtab_lookup_elem() when interrupting rhashtable_=
rehash_one()
--

commit b84a73a0b5e527ae59fe3ae2f05ee59cd4d31935
Author: Mani Tofigh <mt4022@columbia.edu>

bpf: Fail rhtab inserts and deletes with IRQs disabled

This commit rejects rhtab element deletions and new insertions with -EBUSY
when IRQs are disabled to prevent same-CPU deadlocks on rhashtable bucket b=
it
spinlocks. Lookups and updates of existing elements continue to run without
checking irqs_disabled().

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6e2115477cb9e..1a9f07b71bca2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3144,11 +3144,14 @@ static int rhtab_delete_elem(struct bpf_rhtab *rh=
tab, struct rhtab_elem *elem, v
>  	int err;
> =20
>  	/*
> -	 * disable_instrumentation() mitigates the deadlock for programs runnin=
g in NMI context.
> -	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may=
 reenter
> -	 * rhashtable code, bpf_disable_instrumentation() disables programs run=
ning in NMI, except
> -	 * raw tracepoints, which we don't have in rhashtable.
> +	 * rhashtable takes its bucket bit locks with IRQs disabled and can't
> +	 * detect re-entry. With IRQs already disabled this CPU may already
> +	 * hold one, e.g., in NMI or in a program attached inside the resize
> +	 * worker's locked section.
>  	 */
> +	if (irqs_disabled())
> +		return -EBUSY;

[Severity: High]
Can a BPF program running with IRQs disabled still livelock in
rhtab_lookup_elem() before reaching this check, or during
rhtab_map_lookup_elem() and rhtab_map_update_elem()?

Both rhtab_map_delete_elem() and rhtab_map_lookup_and_delete_elem() call
rhtab_lookup_elem() before calling rhtab_delete_elem(), and
rhtab_map_update_elem() also calls rhtab_lookup_elem() before checking
irqs_disabled():

kernel/bpf/hashtab.c:rhtab_map_delete_elem() {
	guard(rcu)();
	elem =3D rhtab_lookup_elem(map, key);
	if (!elem)
		return -ENOENT;

	return rhtab_delete_elem(rhtab, elem, NULL, 0);
}

During a resize in
rht_deferred_worker()->rhashtable_rehash_table()->rhashtable_rehash_chain()=
->rhashtable_rehash_one(),
the worker holds the old_tbl bucket bit lock with IRQs disabled and splices
the tail entry of the old_tbl bucket chain onto the head of the new_tbl
bucket chain before unlinking it from old_tbl:

lib/rhashtable.c:rhashtable_rehash_one() {
	...
	RCU_INIT_POINTER(entry->next, head);

	rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry, flags);

	if (pprev)
		rcu_assign_pointer(*pprev, next);
	else
		/* Need to preserved the bit lock. */
		rht_assign_locked(bkt, next);
	...
}

Between RCU_INIT_POINTER(entry->next, head) and unlinking entry from old_tb=
l,
walking that bucket chain in old_tbl follows entry->next into new_tbl and
terminates at RHT_NULLS_MARKER(&new_tbl->buckets[new_hash]) instead of
RHT_NULLS_MARKER(bkt).

If an NMI or kprobe fires on the same CPU during this window (for example in
rht_assign_unlock()) and the BPF program calls rhtab_lookup_elem() for a key
in that old_tbl bucket that is not found in the chain, __rhashtable_lookup()
sees he !=3D RHT_NULLS_MARKER(bkt) and retries in a loop:

include/linux/rhashtable.h:__rhashtable_lookup() {
	...
	do {
		rht_for_each_rcu_from(he, __rht_ptr_rcu(bkt, freq), tbl, hash) {
			if (params.obj_cmpfn ?
			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
			    rhashtable_compare(&arg, rht_obj(ht, he), params))
				continue;
			return he;
		}
		/* An object might have been moved to a different hash chain,
		 * while we walk along it - better check and retry.
		 */
	} while (he !=3D RHT_NULLS_MARKER(bkt));
	...
}

Because rhashtable_rehash_one() is interrupted on the same CPU and cannot
finish unlinking entry from old_tbl, wouldn't __rhashtable_lookup() spin
forever here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-bpf-rhtab-=
irqs-disabled-v1-1-9874d96a088c@columbia.edu?part=3D1
