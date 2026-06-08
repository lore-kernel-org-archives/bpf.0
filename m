Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAD346FA7
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935403; cv=none; b=ADgP0CQtLzBuJqo03pZ7fDudDhNUWdY6YjxjeezKJ1dc+rSwSTKKnLhr7HfiAztujxhVnrJ2FmGDGI0xLhV1xMag2Sq17JeWvuZ5C3GkvHLkHJ6MOpykJfURAXPJOP0p4k+3UxR9AWk9SkdnH3WUAiboIKndjpDl0Z0D9TkclOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935403; c=relaxed/simple;
	bh=nvGgAgTOm3N2YLQwItKO4UzTP7/A2HOfsFO6tdLVbgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dmgw6Chm5drOFvGI+cRddAuxNQuHRmyvFgO9YCOkHCeKLK8XvYze7hdscfjtVKaXTUHFm3ki+99vhtPu1z9GPVVpAJDUDWpjeIEaKCfQ9T1uXldDIngx+N4AcF/h2b6Vahi6F7JjYL65wpb4+9eSJV3INgERV6Axu6O8/VXJ1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps26+j6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps26+j6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1E41F00893;
	Mon,  8 Jun 2026 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935401;
	bh=M69V0wuNJ7Baxqz5OAWLqasuwpB6DXx6/l0XoQS6x3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps26+j6V2hoT+IbuLIerwV64JGRdu96WgiJrnUFKFypDIAJvQuXCIA1MMBrdXit9a
	 epLQ9QTAJhA8hJqeDge3b1hcDeIhHTSm7hf3IeiQ9diBhyJff3mEtHEW19R82T0TSX
	 +xVTGSWJJCbDJB5kfPvqjPibMaaPymiRLvQ3XXh/qP3iEDOnURirh3Tix92St1nItR
	 v/vjEtgZ3sLedPSVifvPvF8H0TabdVvWvlT4Z+7Jb3n8O+Xh9p4mGG3Gt46Fri/jZ+
	 HHX+/k+4q8n2QRdd2WKjnkQEofVMgWo2BC+n/jF76oJqCM53VXdm7+GtaWpJy+Ceqf
	 cA+KGIUw4MFJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/5] selftests/bpf: Exercise unsafe obj
 drops from tracing progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608144841.1732406-5-memxor@gmail.com>
References: <20260608144841.1732406-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:16:41 +0000
Message-Id: <20260608161641.CF1E41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing bpf_obj_free_fields() with bpf_obj_cancel_fields() i=
n map update and delete paths breaks BTF special field initialization and i=
solation, leading to cross-key reference hijacking in hash maps and un-clea=
rable fields in array maps.
--

commit 0b4e0636a1d77531077ad0491c76e6b6595a28c6
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Cancel special fields on map value recycle

This commit introduces bpf_obj_cancel_fields() to defer the destruction
of special fields (like referenced kptrs and graph roots) until map
teardown, rather than destroying them during map update or delete operation=
s.
It updates array and hash map paths to use this cancellation helper,
explicitly relaxing the eager-free semantics for these fields. Although tes=
ts
were added in related commits (like selftests/bpf: Exercise kptr map update
lifetime) asserting that the refcount remains elevated after an update, they
failed to account for memory reuse.

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

[Severity: Critical]
Since array_map_update_elem() updates the element in place, does this mean
array elements permanently retain old references?

If copy_map_value() skips copying over special fields, and the new
bpf_obj_cancel_fields() no longer clears them, it seems the old kptrs
are left intact on the array element. Wouldn't this make it impossible
for userspace to clear a kptr from an array map once it is set?

>  	}
>  	return 0;
>  }

[ ... ]

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b4366cad3cfa5..a9b2b882b90f2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -844,11 +848,11 @@ static void check_and_cancel_fields(struct bpf_htab=
 *htab,
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

[Severity: Critical]
Can this lead to cross-key reference hijacking when hash map elements
are reused?

When an element is deleted or updated in a hash map, its memory is pushed
back to the bpf_mem_alloc freelist (or extra_elems for preallocated maps).
Since the special fields are no longer cleared, the pushed element retains
its old kptr and lock state.

If alloc_htab_elem() later reuses this memory for a newly inserted key,
and copy_map_value() intentionally skips copying over special fields,
will the new key inherit the old key's reference? A BPF program could then
look up the new key and extract the reference via bpf_kptr_xchg(), breaking
isolation guarantees.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144841.1732=
406-1-memxor@gmail.com?part=3D4
