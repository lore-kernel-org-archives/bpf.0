Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BE3921CD
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121643; cv=none; b=nyEo6xoyTKFlBkbsGonHI0A7C6PmJkRkSaGzNBRPmr1Z0ySi04WFG6OBgLBj4fvzpmk9e6p+ITTOCHP+EQz/xfAjUDvCRFKCCl3a4PjokZwbU4SmEc49Sk6yhaDO6afaND4KAeGHRbOLTIdmfZzeuplXIx5JZxlGYTKv+jON2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121643; c=relaxed/simple;
	bh=OpDLCg7Obn93vC11jb4gR4GxMDWinh0DftexZG1jS9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7ioeSfPvs5vrjAFatoQsDmiz9lKCeLwpvw259/5Pm6VajSaUrwXpakQvL5KPgI6XgZ9dMWAH6p9llQjgl89GJNQwXLFz+O1E9o6rcKkfiB7cqTx69Pv0r4IMEtOgiVjdPRgEGY9x+oZDwJDskfBNhHJDn+xbvrBRBg/80nRMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu1PzlTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu1PzlTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F41F000FF;
	Sun,  4 Oct 2026 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121641;
	bh=5E5S8Vg0beLuZNVVor8Ye7VX7DY2VyLweFj8eFvL2ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bu1PzlTZOvmDlohLOvD6xo6Z1TtdY0OfPRIxKJn/SeAyGwmKT6uWCf0dtLtUPHxwb
	 9tLSshqFVtHtLEr/kw6Ipu3gDec0otgSO+MW/wtpxXiT3pE7eWAsjlk2u6quAKr0w9
	 xZAF4lLa3TtTkvyIBJwwlxGiGJF0mcJ/QgpbLEBCM3Gnz0ghl4IQiPtp7+PYGxorjh
	 +mcpPpoB/wYL1wCeUhFbzFjqYvVUx+Ij618qhT6B9adC0BkU/Q48Xqp6yu0WtuFCBi
	 d+jdRfSsAy/Qx36oKu74hZqaj5+sjOl28y9e7NUJX5OnsJTecr5DpPTfIU1062EuT9
	 82Fk3IWoOAq1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 23/43] bpf: add a min-heap for ordered
 analysis worklists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-23-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-23-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:47:20 +0000
Message-Id: <20261004134721.6F0F41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: bpf_min_heap backing array uses krealloc leading to -ENOMEM
- [Low] bpf: custom min-heap reinventing generic include/linux/min_heap.h
--

commit 962cfb7ee3152595af40dbe59bd87156cd6e55d1
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: add a min-heap for ordered analysis worklists

This commit adds a small integer min-heap implementation for the BPF
verifier. It orders instruction indices by their CFG ranks for SCEV basic
block processing, growing a backing array on demand.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
[ ... ]
> +/*
> + * Simple binary heap implementation as described by
> + * https://en.wikipedia.org/wiki/Binary_heap
> + */
> +struct bpf_min_heap {
> +	int (*compare)(int, int, void *); /* ordering function for @elements */
> +	int *elements; /* min-heap ordered by @compare */
> +	void *arg; /* 3rd argument passed to @compare */
> +	int capacity;
> +	int count;
> +};

[Severity: Low]
Does this custom structure reinvent the generic min-heap implementation alr=
eady
available in include/linux/min_heap.h?

The kernel already provides a well-tested API. If dynamic reallocation is
necessary, could it be wrapped around the existing struct min_heap and its
callbacks rather than completely duplicating the core logic?

> +
> +void bpf_min_heap_init(struct bpf_min_heap *heap, int (*compare)(int, in=
t, void *), void *arg);
> +void bpf_min_heap_free(struct bpf_min_heap *heap);
> +int bpf_min_heap_push(struct bpf_min_heap *heap, int elt);
> +bool bpf_min_heap_pop(struct bpf_min_heap *heap, int *elt);
> +
>  #endif /* _LINUX_BPF_VERIFIER_H */
> diff --git a/kernel/bpf/heap.c b/kernel/bpf/heap.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/bpf/heap.c
[ ... ]
> +void bpf_min_heap_free(struct bpf_min_heap *heap)
> +{
> +	kfree(heap->elements);

[Severity: Medium]
If the allocation in bpf_min_heap_push() below is changed to use kvrealloc(=
),
does this need to be updated to kvfree() to avoid crashes?

> +	heap->elements =3D NULL;
> +	heap->capacity =3D 0;
> +	heap->count =3D 0;
> +}
> +
> +int bpf_min_heap_push(struct bpf_min_heap *heap, int elt)
> +{
> +	int new_capacity, i;
> +	int *elements;
> +	void *tmp;
> +
> +	if (heap->count =3D=3D heap->capacity) {
> +		new_capacity =3D heap->capacity ? heap->capacity * 2 : 16;
> +		tmp =3D krealloc(heap->elements,
> +			       sizeof(*heap->elements) * new_capacity,
> +			       GFP_KERNEL_ACCOUNT);

[Severity: Medium]
Could this krealloc() fail with -ENOMEM when loading large BPF programs on
fragmented systems?

Since the backing array scales up proportionally to the number of basic
blocks, this attempts to allocate physically contiguous memory. This can
frequently fail for high-order allocations when dealing with complex
programs that push the capacity to several megabytes.

Would it be more reliable to use kvrealloc() here to match the scalability
of the other SCEV verifier data structures?

> +		if (!tmp)
> +			return -ENOMEM;
> +		heap->elements =3D tmp;
> +		heap->capacity =3D new_capacity;
> +	}
[ ... ]
> +static inline void sink_root(struct bpf_min_heap *heap)
> +{
> +	int *elements =3D heap->elements;
> +	int i =3D 0;
> +
> +	while ((left_child(i)  < heap->count && greater(heap, elements[i], elem=
ents[left_child(i)])) ||
> +	       (right_child(i) < heap->count && greater(heap, elements[i], elem=
ents[right_child(i)]))) {

[Severity: Low]
Does this function unnecessarily duplicate the sift-down logic already
provided by min_heap_sift_down() in the core kernel API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D23
