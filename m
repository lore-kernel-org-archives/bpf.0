Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CB49F121
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268771; cv=none; b=mStPpdJn7ER140nMucCOOSxOu6qeflMC8B4Y4P2pHBG7GLayD0uziA5+AwrLtun3UNtPQferr7u4X+4G2rAHmzen7OIV/uvfdqfTNKLIW+doWMzxNS5Pnqd/dnpyaclWHgDCCGxBuQiYyS2i+3I/VnWLW+uzh7gnm1Xe8p0yWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268771; c=relaxed/simple;
	bh=X4KZ3yYeatSHgzD9k80LTgYTTt2ON/QFP0NL+KQ141w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7e6rWycosCVfKk6crK52JYv9CDiApA1MLt3HP9frxsbl70xHKdvxVBROq0c0xp+b8kaX+p7eeX7G5X+E05ylpYXgiC7vvQDtAt4vj9XB7sjT06RrzlF9UroeIz+rlr/5hqKbLX6FiDKTF9ovbUk6F1BMGnPlJ+ViDDPTaGwa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHDwqA4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHDwqA4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C8F1F000FF;
	Thu, 24 Sep 2026 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268769;
	bh=K8+HpcqsKkefFhZCbyg8lqeAkjogVfMxH0yUQpPZovc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHDwqA4T66Jq3H6SUFdZPoNxWhbs4tvqGYRjluHftMIZlfTov1MPrAEt1kBPtu9Pp
	 Wxtls9YmNU/D532zRKSlHNTZLVYkCTuxNFKU/xSVZTM+MxWVTO3tnJIkkY9Rhc19mS
	 EKfRpse6EJ2nCXibD+o0dVIcz1shrCSM9qHrTj6BatVtsUdvOYCoQMcDZ8mN1xFq7O
	 QWeeGD6V1PpjQHnnuDJzW9XBr1ZTo5lOMnIUwALRK9xolwu1exLma6T8gf0NwBCFZ/
	 sXHIYo1iE0XpI0B0dRJnwkJJYQvfsJLHxlQIBXpMM58XRaaJVLwLTHTiZsjmfS49Md
	 ahhM/R+fENBNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Support bpf_rcu_head in hash and LRU
 hash maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924162858.2435106-2-puranjay@kernel.org>
References: <20260924162858.2435106-1-puranjay@kernel.org>
 <20260924162858.2435106-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:52:49 +0000
Message-Id: <20260924165249.A2C8F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: preallocated hash map loses per-cpu spare causing update fail=
ure
- [Medium] bpf: LRU eviction fails to cancel timers immediately for RCU cla=
imed elements
--

commit 48e7d59b1040d1c559a2c8cba927c93eb44f710e
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Support bpf_rcu_head in hash and LRU hash maps

This commit introduces bpf_rcu_head support for hash and LRU hash maps,
allowing map elements with RCU callbacks to be handled appropriately on
deletion. Elements are kept alive until the callback completes, with the
dead bit stopping further arming.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index f744a42bb8139..5e2f4cbe9d0f2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -914,15 +925,24 @@ static bool htab_lru_map_delete_node(void *arg, str=
uct bpf_lru_node *node)
>  	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>  		if (l =3D=3D tgt_l) {
>  			hlist_nulls_del_rcu(&l->hash_node);
> -			bpf_map_dec_elem_count(&htab->map);
>  			break;
>  		}
> =20
>  	htab_unlock_bucket(b, flags);
> =20
> -	if (l =3D=3D tgt_l)
> -		check_and_cancel_fields(htab, l);
> -	return l =3D=3D tgt_l;
> +	if (l !=3D tgt_l)
> +		return false;
> +
> +	/*
> +	 * An arm can land after the check above. The element is already unlink=
ed
> +	 * by now, so map_release_elem() finishes the handoff to the free list.
> +	 */
> +	if (bpf_rcu_head_claim(&htab->map, htab_elem_value(l, htab->map.key_siz=
e)))
> +		return false;

[Severity: Medium]
When an element is claimed by an RCU callback, htab_lru_map_delete_node()
returns early and skips check_and_cancel_fields(). Does this leave timers
and other special fields active after logical deletion?

The commit message mentions that timers and friends in the same value are
still cancelled on delete, but they appear to remain active here and could
fire during the RCU grace period.

> +
> +	bpf_map_dec_elem_count(&htab->map);
> +	check_and_cancel_fields(htab, l);
> +	return true;
>  }

[ ... ]

> @@ -1129,9 +1179,18 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,
>  			struct pcpu_freelist_node *l;
> =20
>  			l =3D __pcpu_freelist_pop(&htab->freelist);
> -			if (!l)
> -				return ERR_PTR(-E2BIG);
> -			l_new =3D container_of(l, struct htab_elem, fnode);
> +			if (l) {
> +				l_new =3D container_of(l, struct htab_elem, fnode);
> +			} else {
> +				/* Spend the spare; freeing old_elem refills the freelist. */
> +				if (!old_elem)
> +					return ERR_PTR(-E2BIG);
> +				pl_new =3D this_cpu_ptr(htab->extra_elems);
> +				l_new =3D *pl_new;
> +				if (!l_new)
> +					return ERR_PTR(-E2BIG);
> +				*pl_new =3D NULL;

[Severity: High]
By setting the per-CPU spare *pl_new =3D NULL and later pushing the replaced
element into the global freelist, is the per-CPU spare permanently lost?

Once all CPUs lose their spares and the map is full, could updating an
existing element fail with -E2BIG?

> +			}
>  			bpf_map_inc_elem_count(&htab->map);
>  		}
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924162858.2435=
106-1-puranjay@kernel.org?part=3D1
