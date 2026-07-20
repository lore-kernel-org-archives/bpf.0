Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED509409270;
	Mon, 20 Jul 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552954; cv=none; b=rX6Jb84BsUj+C49OzPlvnD9Gvwic0xWPPrJB2Fun216TE87r4WM2TKHfYfS/anSsz7pF8aTM5CzOiPfwvgbgcUlLZeWfKdXrOIGn5GBANVHdS8wGusGEis2+5FhNVyum27JcoGOOWbxOG99JhnheUp2F2qJrf+Dkto2y5TIvKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552954; c=relaxed/simple;
	bh=EQ0UojR8m3W+wJ1f63BQtMRphFhD6BJpJo5Kws8BthI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DGibynoWrafjcswG5GTWp1Py3yZLpOXD42TTWW2uWa/rtloH7vODAjb24u4ZzKnGH+wdQkOhxzE1nCHR9dQI30t5cIttfzPHR56Yy/EVZWNmnENiNBI3BnVc9Yh4DqsH0aUK8LnYMbBBXnVwtC4clNyLMznA3yi8Ciz4IBHOe1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQji0bv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQji0bv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8CC1F000E9;
	Mon, 20 Jul 2026 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552952;
	bh=GHXNZxjkBOmeDHJO9O1UyPxIaN6wzcWlY8HX0vfcJRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQji0bv8N67U8zef6K+7UoB7nmCOzTI6ASd5odEWDdU2TjaCSCIbqave0I6yKfMbq
	 qvrcyw9r3RjYroEL+S3C33EXzeu4jzNSRzcP+QfbVDGmuS414i+JRMcRAQAI4cfCzi
	 EFwwfq8MRkyUhXInkMq1LJ5+DPtUyImu9SUaOcn1lfgWRuAJFTJCt5sMilyR5vIKK3
	 aYIKRDy4y38XP31xFkzADEFWy1rjqRRmgRY7d7qd31IFQbq99snHerz6ZqtSxwaL69
	 vL6+u/cbnG1ENz1S62yvvg+MqdEBC4fKIa07b8K1+7t0vSgb3mkT0fODC9SwlPYnIf
	 PWlDPeWgTtj5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 6/8] mm/slab: introduce struct
 kvfree_rcu_head for kvfree_rcu batching
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260720-kfree_rcu_nolock-v4-6-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-6-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:09:12 +0000
Message-Id: <20260720130912.8E8CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KASAN tag loss in kvmalloc_obj_start_addr() causes debugobjects me=
mory leak, corrupted tracepoint offsets, and KASAN double-free bypass.
--

--- Patch [6]: [PATCH slab/for-next v4 6/8] mm/slab: introduce struct kvfre=
e_rcu_head for kvfree_rcu batching ---
commit b85878f9ac539d3e206f29f7df390cb30b50c271
Author: Harry Yoo (Oracle) <harry@kernel.org>
Subject: mm/slab: introduce struct kvfree_rcu_head for kvfree_rcu batching

This patch introduces `kvfree_rcu_head` to replace `rcu_head` for
kvfree_rcu batching. It stops storing the object pointer directly and
instead calculates the object's start address dynamically via
`kvmalloc_obj_start_addr()` to reduce structure size overhead.

> diff --git a/mm/slab.h b/mm/slab.h
> index fdd293b3efa56..1efeaceb7db32 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -351,6 +351,33 @@ static inline int objs_per_slab(const struct kmem_ca=
che *cache,

[ ... ]

> +/* kvfree_rcu_head offset can be only less than page size */
> +static inline void *kvmalloc_obj_start_addr(void *head)
> +{
> +	void *obj =3D head;
> +
> +	if (unlikely(is_vmalloc_addr(obj))) {
> +		obj =3D (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
> +	} else {
> +		struct page *page =3D virt_to_page(obj);
> +		struct slab *slab =3D page_slab(page);
> +
> +		if (!slab) {
> +			obj =3D (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
> +		} else if (is_kfence_address(obj)) {
> +			obj =3D kfence_object_start(obj);
> +		} else {
> +			struct kmem_cache *s =3D slab->slab_cache;
> +			unsigned int idx =3D __obj_to_index(s, slab_address(slab), obj);
> +
> +			obj =3D slab_address(slab) + s->size * idx;

[Severity: High]
Does reconstructing the base address using slab_address(slab) drop the KASAN
tag from the original allocation?

slab_address() returns a tagless linear map address, so the resulting obj
pointer will be untagged.

> +			obj =3D fixup_red_left(s, obj);
> +		}
> +	}
> +
> +	return obj;
> +}
> +
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8c631bf97cd5b..c1c32909fa528 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c

[ ... ]

>  static void
> -kvfree_rcu_list(struct rcu_head *head)
> +kvfree_rcu_list(struct kvfree_rcu_head *head)
>  {
> -	struct rcu_head *next;
> +	struct kvfree_rcu_head *next;
> =20
>  	for (; head; head =3D next) {
> -		void *ptr =3D (void *) head->func;
> +		void *ptr =3D kvmalloc_obj_start_addr(head);
>  		unsigned long offset =3D (void *) head - ptr;

[Severity: High]
If ptr is untagged but head still has its KASAN tag, could this cause the
offset calculation to yield a massive value due to the tag difference in the
upper bits?

Additionally, does passing the untagged ptr to debug_rcu_head_unqueue()
(called slightly later in this function) cause an exact-match hash failure
and permanently leak the tracking object?

> =20
>  		next =3D head->next;
> diff --git a/mm/slub.c b/mm/slub.c
> index deac315d0f23e..d0976396d703d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6699,43 +6699,21 @@ static void free_large_kmalloc(struct page *page,=
 void *object)
>   */
>  void kvfree_rcu_cb(struct rcu_head *head)
>  {
> -	void *obj =3D head;

[ ... ]

> +	obj =3D kvmalloc_obj_start_addr(head);
> =20
>  	if (is_vmalloc_addr(obj)) {
>  		vfree(obj);
>  	} else {
> -		unsigned int idx =3D __obj_to_index(s, slab_addr, obj);
> +		struct page *page =3D virt_to_page(obj);
> +		struct slab *slab =3D page_slab(page);
> =20
> -		obj =3D slab_addr + s->size * idx;
> -		obj =3D fixup_red_left(s, obj);
> +		if (slab)
> +			slab_free(slab->slab_cache, slab, obj, _RET_IP_);

[Severity: High]
Does passing the untagged obj pointer into slab_free() silently bypass
KASAN quarantine and double-free/use-after-free validation checks that
rely on the tag?

> +		else
> +			free_large_kmalloc(page, obj);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D6
