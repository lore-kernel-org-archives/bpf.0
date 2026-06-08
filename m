Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699631E820
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934187; cv=none; b=KNuI3vILCzkz0cruio5jDBWZ6YaC9t2SIZIAqUGLDc0rJ8qOzdNx0gTVPQVPMh6YhNJzS963HVDQUaacAiEIu01p+5DhjR1J1+Nc6e80mgP+TKWynb2ZODnbX79oOl+zboG2qdkqAce6+LngyoEPGPOGueuvqLpf5VuK+CqF1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934187; c=relaxed/simple;
	bh=FP6ydiX8S0TPC1DxSia8xvmBQQkV7Rf78cUGlLimpOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxZ+JUQKCpwWV076+8y9mq6C1P52+/p1NMV2wWrmV05aT4LWBcOD16XpWcZlux1ZSM3CO1/hnIzJkN1qgAPaBiiTWyUsGQsStEHQjaR8FKrTPSkokbszCsj5MybMAVZtzzYLBTb+IY7+LZ5M/odSb6yq2/kmNYBHJNJopVyO0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEAL8Zmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEAL8Zmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F03C1F00893;
	Mon,  8 Jun 2026 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934186;
	bh=xv118yzOoEZACwYPT54eBHkhS1ajC1NTX92AdTWLi90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEAL8ZmxDQDRG6/5ceDCoFfwE3iRC3yFftb5Dp2CDO/5lkDL0suvKZV99a7HmJqBI
	 SZMNGU0vWEFHeFeheTfs+WiZAK4HL/VpFDimxFUC7bc/CjaLuxbA6FpKeW+sldCtPj
	 Q0AKSloMmLB99nMfYoVNVwkOy4mRsHdEDi5MfmQmHKaE3TJ6TAORS+2oAnUHlOdK6U
	 2029kwvHmplZh4rNy5cqiZ0f44Q/7eDQABog6ZfOPS3RmoOcGYxHctonKDfO+Dfl65
	 B+ScerKixZRHHsSJRD42zOvC7YVztouWSEQ3ZU3My1wuBQkZAuE2FZdTt3YsNZOMtp
	 B3D4s/g+7sakA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Cancel special fields on map value
 recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608144841.1732406-4-memxor@gmail.com>
References: <20260608144841.1732406-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:56:25 +0000
Message-Id: <20260608155626.1F03C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing bpf_obj_free_fields() with bpf_obj_cancel_fields() in ma=
p update and delete paths fails to clear BTF special fields (kptrs, list he=
ads, etc.), causing recycled map elements to silently inherit these fields =
from previously deleted or overwritten keys.
--

commit 0b4e0636a1d77531077ad0491c76e6b6595a28c6
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Cancel special fields on map value recycle

This patch introduces bpf_obj_cancel_fields() to replace
bpf_obj_free_fields() in map update and delete paths. It restricts
eager cleanup to timers, workqueues, and task works, leaving other
fields attached for final map destruction.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index e6271a2bf6d64..4e8d6fe6999bf 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -384,7 +384,7 @@ static long array_map_update_elem(struct bpf_map *map=
, void *key, void *value,
>  	if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
>  		val =3D this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  		copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(array->map.record, val);
>  	} else {
>  		val =3D array->value +
>  			(u64)array->elem_size * (index & array->index_mask);
> @@ -392,7 +392,7 @@ static long array_map_update_elem(struct bpf_map *map=
, void *key, void *value,
>  			copy_map_value_locked(map, val, value, false);
>  		else
>  			copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(array->map.record, val);

[Severity: High]
Does this prevent userspace from clearing kptrs in array maps?

Because bpf_obj_cancel_fields() leaves kptrs untouched and copy_map_value()
skips copying BTF fields from the user, array elements are updated without
freeing or zeroing old kptrs.

This permanently attaches the kptr to the array slot until map destruction,
making it impossible to clear them by updating the element with zeroes.

[ ... ]

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b4366cad3cfa5..a9b2b882b90f2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -833,8 +837,8 @@ static int htab_lru_map_gen_lookup(struct bpf_map *ma=
p,
>  	return insn - insn_buf;
>  }
> =20
> -static void check_and_free_fields(struct bpf_htab *htab,
> -				  struct htab_elem *elem)
> +static void check_and_cancel_fields(struct bpf_htab *htab,
> +				    struct htab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(htab->map.record))
>  		return;
> @@ -844,11 +848,11 @@ static void check_and_free_fields(struct bpf_htab *=
htab,
>  		int cpu;
> =20
>  		for_each_possible_cpu(cpu)
> -			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
> +			bpf_obj_cancel_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
>  	} else {
>  		void *map_value =3D htab_elem_value(elem, htab->map.key_size);
> =20
> -		bpf_obj_free_fields(htab->map.record, map_value);
> +		bpf_obj_cancel_fields(htab->map.record, map_value);
>  	}
>  }

[Severity: High]
Does this allow recycled hash map elements to silently inherit kptrs from
previously deleted keys?

When an element is deleted, it goes back to the freelist or memory allocator
cache. Since check_and_cancel_fields() no longer clears BTF special fields
like kptrs or list heads, these fields remain intact in the recycled memory.

When alloc_htab_elem() reuses this memory for a new key, copy_map_value()
intentionally skips over BTF fields.

The new element will thus silently inherit the kptr from the old element,
breaking cross-key isolation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144841.1732=
406-1-memxor@gmail.com?part=3D3
