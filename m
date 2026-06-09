Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559973AFD1F
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000431; cv=none; b=uBRSXAA/LbGqyj0zMhpcMVGbyoi3AjK+zD54ffamxxS7IcP0rluVYRJNvV+KtKIb2BrQzPjLGid72bjbbCXwxbXqN7j/B5QP3bOtoF/thmYmEDDHOJY7KNxI+w0+aUchFZjtFBmGfnZ69xYXzLEhkZ1YwEZf2EY1VMbadUOx4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000431; c=relaxed/simple;
	bh=rb/ORtDm4FTKCPdY+H0lGVUfP2Z33DJrK/qSs1c+Qao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7OL9P931kSB/i9A2pN3XirHKPtMsNRF0vuQlRg3AE1B+mCZ3RTR2JeUkLTPOUI+V8SV9ZBzCH+dcCKpbSH6mCEX5OBE/+DHuP65GgT23h/p8ibkNDhEDAwUGmbZ6/zJQZCy9NFaLz9Res/tHWXJ9BtVp3ZF2qIj7I5Krv0sc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsItqIu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsItqIu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00FA1F00893;
	Tue,  9 Jun 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000430;
	bh=LSMQ6l+5QDsLC4COponhRXFkJzRWIfMNIXA6b4XYtjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GsItqIu7a3phmnlofGZ5lk/UtkFXjOQNcbtLfM/3XvnAiiu7Pl/U5nUIQn4rzNRjP
	 SRvCemxGDJE6jssmL9re1gZlNNnNG/Gaa5sVy9QwaNfh4R6u0ORSDY/16Ax0E1a5fQ
	 LWSIi7Aw4/57NbGpvhYBJ8Zc2Sc+PH6u8yJl2ugWOsQmzoa20WDRGu/n7GOAsam9aq
	 Y6GKJsoLCWMR4NphM4Prym4nrGk1caW17D2F6KZ7nXxdmyYQjaBJv8aKubArLnl4ln
	 9tN0HiApWIhr96ATSq90+Xeb72+uttV7mIZKV71R1zjK69988xfGwWsy8BeUg1TU3N
	 eqG66Jb4z+hkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Exercise kptr map update
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609093719.2858096-5-memxor@gmail.com>
References: <20260609093719.2858096-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:20:29 +0000
Message-Id: <20260609102029.D00FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The selftests incorrectly codify a resource leak and cross-key=
 reference vulnerability for BPF kptrs in map updates.
--

commit b8d5d36d1cdd1bc97594f89c513eb183613ab05f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Exercise kptr map update lifetime

This commit adds selftests for BPF-side map updates that touch values
containing referenced kptrs in array and hash maps. It verifies that the
refcount behaves as expected when updating existing map elements from BPF.

> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing=
/selftests/bpf/progs/map_kptr.c
> index e708ffbe1f610..3fbefc568e0a6 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c

[ ... ]

> @@ -500,11 +499,95 @@ int count_ref(void *ctx)

[ ... ]

> +SEC("syscall")
> +int test_array_map_update_kptr(void *ctx)
> +{
> +	struct map_value init =3D {}, *v;
> +	int key =3D 0, ret;
> +
> +	v =3D bpf_map_lookup_elem(&array_map, &key);
> +	if (!v)
> +		return 1;
> +	ret =3D stash_ref_ptr(v);
> +	if (ret)
> +		return ret;
> +	ret =3D check_refs(3);
> +	if (ret)
> +		return ret;
> +	ret =3D bpf_map_update_elem(&array_map, &key, &init, BPF_EXIST);
> +	if (ret)
> +		return 4;
> +	return check_refs(3);

[Severity: Critical]
This isn't a bug introduced by this patch, but are these tests codifying a
kernel resource leak and cross-key reference vulnerability?

In a prior commit, bpf_obj_free_fields() was replaced with
bpf_obj_cancel_fields() in kernel/bpf/arraymap.c:array_map_update_elem()
and check_and_cancel_fields() in kernel/bpf/hashtab.c:free_htab_elem().

Because those cancel functions do not release or zero kptrs, overwriting an
array element or freeing a preallocated hash map element to the freelist
leaves the old kptr intact.

For preallocated hash maps, when a new element is popped from the freelist
and updated via copy_map_value() (which skips special BTF fields), the new
element silently inherits the stale kptr from the deleted key.

By asserting check_refs(3) here and in DEFINE_HASH_UPDATE_KPTR_TEST below
after updating the map with an empty init value, do these tests accidentally
codify this broken kernel behavior where the refcount incorrectly remains
elevated?

> +}
> +
> +#define DEFINE_HASH_UPDATE_KPTR_TEST(name, map)			\
> +SEC("syscall")							\
> +int name(void *ctx)						\
> +{								\
> +	struct map_value init =3D {}, *v;				\
> +	int key =3D 0, ret;					\
> +								\
> +	ret =3D bpf_map_update_elem(&map, &key, &init, BPF_NOEXIST); \
> +	if (ret)						\
> +		return 1;					\
> +	v =3D bpf_map_lookup_elem(&map, &key);			\
> +	if (!v)							\
> +		return 2;					\
> +	ret =3D stash_ref_ptr(v);					\
> +	if (ret)						\
> +		return ret;					\
> +	ret =3D check_refs(3);					\
> +	if (ret)						\
> +		return ret;					\
> +	ret =3D bpf_map_update_elem(&map, &key, &init, BPF_EXIST); \
> +	if (ret)						\
> +		return 4;					\
> +	return check_refs(3);					\
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609093719.2858=
096-1-memxor@gmail.com?part=3D4
