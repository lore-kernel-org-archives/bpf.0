Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD543033E7;
	Fri,  7 Aug 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112176; cv=none; b=G55n1SvltBvungufhmBW+XoAGu+XAWTC3Sra8iwkVLW3MAfx7K1VtMAWAoUfCYIxZ77zKXNoKaBmK7V7JNDOlnzqzM2NjkCLagXpUMltdGYKJA03B2tNBm+wDPChfNFDUK38M/r9aKV2b71RcPzuPSPGmPcKZAB2Eq0bxSL5f48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112176; c=relaxed/simple;
	bh=vt7CtlvPHiafxvaUEQCQjUS6XQYyYcYgu7lMoh35Ws4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BJ/UaLBXQpphCd5bDK94kFYRoU98Inou1RDJy7pLPU9N/63bez05YfZeuOSpxekIZvx7FMK2/sd/pNpfKqX3SMRoO3B7Ov/iDj09z7mJkxETRlzKIJ+7zm2JTwfCC2RcgLSNu2554X4o4imvEN6yaL9K0tfIoENAfOWtPzK01VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9XXTeWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9XXTeWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E201F000E9;
	Fri,  7 Aug 2026 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112166;
	bh=hB/l2YvBvxjMIA9JdWCc7k0OtEyzmMSFvJ9NHM4YRdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9XXTeWecSYQ+8o9y1TzyLapKn8ui7yrzLPsJJuMb+VI4OmvXf5FGC0BMf1eyjdWt
	 ZNWT9FkXHpyuGeVPclWOq+kogd6CeKIIZ0cckRqKzfWD0Xyl+42lbATDysXj2+2BsK
	 hdJaY9FIAbAWDpOUb4lBf0yHxvQ0mXu3mN/nQ6/Oua+sdFEUZpt6ObQ48v4wBBlP6z
	 OmEjeDSsa/UN+hOATTlFRHD99FwxZB9r7ZmnwbM+zfCVpdtbRGEs71mLGuB/ATzyP2
	 yKcLzXJ1SqLsKvNlHn4dNPD5NnqDvKY3wqLnHV7CRu0/5hqE07AQBgXgolJX/kB6Vm
	 ZkxtCB0gTCOwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/5] mm/slab, kfence: support kfence objects in
 kfree_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Vmxhc3RpbWlsIEJhYmthIChTVVNFKQ==?= <vbabka@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-2-ba993cbf7a60@kernel.org>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
 <20260807-kfree_nolock_kmalloc-v1-2-ba993cbf7a60@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:16:05 +0000
Message-Id: <20260807141606.43E201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Double-freeing a KFENCE object via kfree_nolock() causes critical =
list corruption (llist cycle or rcu_head overwrite), turning a detectable b=
ug into an unrecoverable crash.
- [Medium] kfree_nolock() silently bypasses KFENCE's invalid free detection=
 for offset pointers, stripping the invalid offsets during deferral.

Pre-existing issues:
- [High] KFENCE fails to safely catch double-frees for SLAB_TYPESAFE_BY_RCU=
 caches, corrupting RCU and freelists.
--

--- Patch [2]: [PATCH RFC 2/5] mm/slab, kfence: support kfence objects in k=
free_nolock() ---
commit c37e10ff24a4e2a898c52d16f3e89a13a643b486
Author: Vlastimil Babka (SUSE) <vbabka@kernel.org>

mm/slab, kfence: support kfence objects in kfree_nolock()

This commit adds support for freeing KFENCE objects via kfree_nolock(). It
defers the freeing to an irq_work context using an llist node, reusing the
rcu_head space in kfence_metadata.

> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 6577bd76954eb..42519d24687ff 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1271,6 +1271,20 @@ void __kfence_free(void *addr)

[Severity: High]
This is a pre-existing issue, but does __kfence_free() safely handle double
frees for SLAB_TYPESAFE_BY_RCU caches?

It appears that if an already-freed object is passed, it blindly calls
metadata_update_state() and call_rcu(&meta->rcu_head) without checking if
the object is already freed.

If the object is already in the RCU queue, this executes call_rcu() twice on
the same rcu_head, corrupting the RCU list. If it was already fully freed,
the state is forced back to RCU_FREEING, causing the subsequent callback to
bypass the double-free check and corrupt the freelist.

>  	}
>  }
> =20
> +struct llist_node *kfence_obj_to_llnode(void *addr)
> +{
> +	struct kfence_metadata *meta =3D addr_to_metadata((unsigned long)addr);
> +
> +	return &meta->llnode;
> +}
> +
> +void *kfence_llnode_to_obj(struct llist_node *llnode)
> +{
> +	struct kfence_metadata *meta =3D container_of(llnode, struct kfence_met=
adata, llnode);
> +
> +	return (void *)meta->addr;
> +}

[Severity: Medium]
Does this sequence bypass KFENCE's invalid free detection?

When kfree_nolock(obj) receives an invalid KFENCE address, such as an offset
pointer or redzone address, defer_free_kfence() calls kfence_obj_to_llnode()
which drops the original invalid offset.

Later, kfence_llnode_to_obj() reconstructs the pointer strictly as meta->ad=
dr,
which is the valid base address.

This passes the reconstructed valid address to __kfence_free(), masking the
original invalid pointer and preventing KFENCE from reporting the bug.

[ ... ]

> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 1f618f9b0d12d..0fca1dc2c7941 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -58,7 +58,10 @@ struct kfence_track {
>  /* KFENCE metadata per guarded allocation. */
>  struct kfence_metadata {
>  	struct list_head list __guarded_by(&kfence_freelist_lock);	/* Freelist =
node. */
> -	struct rcu_head rcu_head;	/* For delayed freeing. */
> +	union {
> +		struct rcu_head rcu_head;	/* For delayed freeing. */
> +		struct llist_node llnode;	/* For kfree_nolock(). */
> +	};

[Severity: High]
Can aliasing rcu_head and llnode risk list corruption on double frees?

If a KFENCE object is double-freed via kfree_nolock() before the pending
irq_work runs, llist_add() is called twice on the same llnode. This would
create a circular linked list and an infinite loop in IRQ context.

Additionally, for SLAB_TYPESAFE_BY_RCU caches, a double free via
kfree_nolock() during the RCU grace period will locklessly overwrite
meta->rcu_head.next via llist_add(), corrupting the active RCU callback lis=
t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-kfree_nolo=
ck_kmalloc-v1-0-ba993cbf7a60@kernel.org?part=3D2
