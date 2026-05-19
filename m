Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80A3002DF
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155483; cv=none; b=rDKKOM6AcLRJBlYrsqXKBHw0136Vqd1TMsN8nPPsXlqvTxypg96czqoFl+nOjjq5kvduu1MAWXew9+uW/cj87PfiU6+cJesPN1Sp61cMBTYTHWU/U+3SSlgxkJEM/PCyZvt/FmDeKvNBjL1FdoiIcCNOI3PZTNVBvL/z3+Dybb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155483; c=relaxed/simple;
	bh=eSFu48ti2dQtVCWZAFejm66c8HE8ncAqwITPH3x+yyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZDU4WwtoITWTCZIWpOKZJfwfVcWdM9UpNzlD1itX43qfEOylF/tGTFLAnXNCO7YPUd1lF/gSiSqTc8QqHcqH7hRnYx91jGetRVcwKPQAFimXzPbv9zJNymOZFKdpDqP6sfkVU+F8uj8ZKW7XVtCpmIQ8JlUUHHpUlKXP/hZ1wEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9x1PPVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9x1PPVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36096C2BCB7;
	Tue, 19 May 2026 01:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779155483;
	bh=eSFu48ti2dQtVCWZAFejm66c8HE8ncAqwITPH3x+yyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Q9x1PPVEpEbHSHau1YOV84+Wcdv0rzZNQkMcRKgaMnjGFQWF3DtTMi6g64bFnl5iz
	 JZgh3JuBL2cQzuevKrqobE3aVj75SP1yQSYLRP1ayv1tId+S1eeG+0osYP0uI6gqwP
	 YuNqGVZBJe/vr/2VVgth++PVYLVUP//1LDo9/NaeQABUNt1LvfmI5QfNSwz/CBSwAK
	 WtqMEavyeyBSt1xaco7hF07goFsYDMsKgYKg3Rvowb7TaLlASrY/9dI/9Q9Rl7pxU/
	 nAV2dBFYLYlkx/C0P3g8riyWKDu3116pcI88iCqIJR74aw2L/fnEuFDM2XAIgUc4un
	 XhIKNzlj8GJlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519011450.1144935-2-utilityemal77@gmail.com>
References: <20260519011450.1144935-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 01:51:22 +0000
Message-Id: <20260519015123.36096C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] LRU maps containing NMI-unsafe fields (like BPF_KPTR_REF or BP=
F_LIST_HEAD) will permanently leak these fields and corrupt map state when =
updated or deleted in an IRQ-disabled context.
- [High] Modifying the generic `bpf_obj_free_fields()` to silently skip des=
truction in IRQ-disabled contexts causes permanent memory leaks for callers=
 lacking deferred destructors (like `bpf_obj_drop` and Array maps).
- [Medium] Forcibly mutating the user-requested `map_flags` to include `BPF=
_F_NO_PREALLOC` silently breaks performance expectations and UAPI transpare=
ncy.
--

commit 3fbec1aa4107fa1f73249893a4ed21fd7d2213fa
Author: Justin Suess <utilityemal77@gmail.com>

bpf: fix deadlock in special field destruction in NMI

This commit relaxes bpf_obj_free_fields() to skip async work cancellation
and unsafe free operations in IRQ-disabled contexts. It converts hash maps
with NMI-unsafe fields to non-preallocated maps using bpf_mem_alloc to
defer the cleanup. LRU maps and preallocated hash maps are adjusted to
support this mechanism.

Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@=
gmail.com/
Link: https://lore.kernel.org/bpf/DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com/

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4f..0db1dc8ae0bec 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -522,13 +532,53 @@ static int htab_set_dtor(struct bpf_htab *htab, voi=
d (*dtor)(void *, void *))
>  	return 0;
>  }
> =20
> +static int htab_convert_to_non_prealloc(struct bpf_htab *htab)
> +{
> +	bool percpu =3D htab_is_percpu(htab);
> +	int err;
> +
> +	htab_free_prealloced_fields(htab);
> +	free_percpu(htab->extra_elems);
> +	htab->extra_elems =3D NULL;
> +	prealloc_destroy(htab);
> +	htab->map.map_flags |=3D BPF_F_NO_PREALLOC;

Does mutating the map flags post-creation to include BPF_F_NO_PREALLOC alter
the memory model and user-visible flags without warning? If userspace queri=
es
the map info via bpf_map_get_info_by_fd(), will it see flags it never
requested?

Would it be better to explicitly reject this configuration and return -EINV=
AL
rather than secretly altering the underlying memory model?

[ ... ]
>  static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  			      const struct btf_type *key_type, const struct btf_type *value_t=
ype)
>  {
>  	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
> +	int err;
> +
> +	if (!htab_has_nmi_special_fields(htab)) {
> +		if (htab_is_prealloc(htab))
> +			return 0;
> +	} else {
> +		if (htab_is_lru(htab))
> +			return 0;

Since LRU maps are exempted from conversion to non-preallocated mode here,
they do not use bpf_mem_alloc and completely lack the deferred destructor
mechanism relied upon by this patch.

When an LRU element is replaced or deleted, htab_lru_push_free() is called
and synchronously invokes check_and_free_fields() which eventually calls
bpf_obj_free_fields().

If this executes in an IRQ-disabled context, will the new if
(irqs_disabled()) checks in bpf_obj_free_fields() silently skip freeing
the special fields?

Does this cause a permanent memory leak since the element is then
immediately pushed back to the LRU free list? When the element is
subsequently popped and reused, could it inherit stale pointers and
corrupt map state?

[ ... ]
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6600e126fbfb4..1f52453d5a2f1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -839,6 +839,8 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
>  			break;
>  		case BPF_KPTR_REF:
>  		case BPF_KPTR_PERCPU:
> +			if (irqs_disabled())
> +				break;
>  			xchgd_field =3D (void *)xchg((unsigned long *)field_ptr, 0);
>  			if (!xchgd_field)
>  				break;

Because bpf_obj_free_fields() is a generic helper used throughout the BPF
subsystem, does silently skipping destruction in IRQ-disabled contexts
cause leaks for callers that lack deferred destructors?

For example, if a BPF program running in an NMI or kprobe drops an object
containing nested kptrs via __bpf_obj_drop_impl(), will the nested fields
be skipped and permanently leaked when the outer object is queued for
freeing via bpf_global_ma?

Does this similarly affect in-place updates to Array maps which rely on
bpf_obj_free_fields() to clear old special fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519011450.1144=
935-2-utilityemal77@gmail.com?part=3D1
