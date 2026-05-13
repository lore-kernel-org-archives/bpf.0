Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAF25B0BB
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710979; cv=none; b=qdZ1VWcE9BqTG4m5UVdIPDycTOGuKj2SBvzA8PZm8+VlVMOyrumvecG4ihf8eRnRUOcFmpv9AcEE2/Hh/xs4fnu5eXZDKZNverznwuUvTcqFE6BWS2kWR0+QJNoLYj/rE/weR100MzpnOipJcPr0vM20zyKGEU4Aa0SM5so9EMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710979; c=relaxed/simple;
	bh=1RB9pLeJdkZLBz+tM3zMhgwDhS1biyluUOXNkz2C6Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1HxXayBpMFUnaIG+ju02kmhaQjQwVVuqSUldGFFkDKepE33/jkpTh3A38FhndGJ1UQ2Uh5fG9PwMEQUTOffwUxdUKdatAycgZ7v4gK6VPfgSMZS6sXABXcVVkB63R46hIXwtvEe1XYkyWZZOo8UmsJckVLf/kSj4Rv8x2FGPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNBo60Ep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNBo60Ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB08C19425;
	Wed, 13 May 2026 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778710978;
	bh=1RB9pLeJdkZLBz+tM3zMhgwDhS1biyluUOXNkz2C6Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vNBo60EpgX0z5cR7yXo0iw0R4kL/4+z4ZE4Y7a7oETI6I9S1n5cosZNvG2CcLUJV3
	 sYLO5z1dBIL/tHP1kVj5VJnyzG+ae4gEv5kYGvSjqcltTAONo5KjE9C5EEB2Bhphga
	 IEjgwyNT+WfkrmRpYWYdBtNnBiRUECgt/it00dn63ymdRVSuPNsFs/9KsgQmXNvBoU
	 GB4lT/LjL8o35yDqWw03hs05EROao1cqA59lgYOgvu1S2HXrIYpFZiQcUlpC8A1XJq
	 RlYlyRo0VN9bMSlomVEGZBnDKHCWZYQ7/5Z/iKrVSGvipqZFAazSDfxIHWZ2DK7Ock
	 dVZdrka1LmHcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v10 7/8] bpf: allow non-owning list-node
 args via __nonown_allowed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512055919.95716-8-kaitao.cheng@linux.dev>
References: <20260512055919.95716-8-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:22:58 +0000
Message-Id: <20260513222258.AEB08C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf_list_add() dynamically frees the 'new' node on failure, bu=
t the verifier unconditionally assumes success, enabling a Use-After-Free.
- [Critical] bpf_list_del() does not invalidate the passed non-owning refer=
ence, leaving a direct alias to potentially freed memory (Use-After-Free).
--

commit abe3e2cc841c335580b071d1f616bb2c9d1deba4
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: allow non-owning list-node args via __nonown_allowed

This commit introduces the __nonown_allowed annotation for list-node
arguments. It allows bpf_list_add, bpf_list_del, and bpf_list_is_first/last
to accept non-owning references.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -2571,10 +2571,10 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bp=
f_list_head *head,
>  }
> =20
>  __bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list=
_node *new,
> -			     struct bpf_list_node *prev, struct btf_struct_meta *meta,
> -			     u64 off)
> +			     struct bpf_list_node *prev__nonown_allowed,
> +			     struct btf_struct_meta *meta, u64 off)
>  {
> -	struct bpf_list_node_kern *n =3D (void *)new, *p =3D (void *)prev;
> +	struct bpf_list_node_kern *n =3D (void *)new, *p =3D (void *)prev__nono=
wn_allowed;
>  	struct list_head *prev_ptr =3D &p->list_head;
> =20
>  	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, o=
ff);

If a BPF program passes a non-owning reference from a completely different
list (protected by the same spinlock) to prev__nonown_allowed, can this
cause a use-after-free?

At runtime, __bpf_list_add() detects that the prev node doesn't belong to
the target head and aborts the insertion, calling __bpf_obj_drop_impl()
on the new node to free it back to the allocator.

However, the verifier unconditionally assumes bpf_list_add() successfully
consumed the new owning reference and safely converts it into a non-owning
reference in its internal state.

Because the verifier considers this non-owning reference valid until the
spinlock is unlocked, does this allow the BPF program to continuously
dereference the freed memory while holding the lock?

[ ... ]
> @@ -2620,9 +2620,9 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back=
(struct bpf_list_head *head)
>  }
> =20
>  __bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *hea=
d,
> -					       struct bpf_list_node *node)
> +				struct bpf_list_node *node__nonown_allowed)
>  {
> -	struct bpf_list_node_kern *kn =3D (void *)node;
> +	struct bpf_list_node_kern *kn =3D (void *)node__nonown_allowed;
> =20
>  	/* verifier guarantees node is a list node rather than list head */
>  	return __bpf_list_del(head, &kn->list_head);

Does passing a non-owning reference here create an alias that leads to
a use-after-free?

When bpf_list_del() removes the node from the list, it returns a new owning
reference (with ref_obj_id > 0) pointing to the exact same object.

The verifier does not explicitly invalidate the original non-owning
reference argument (which has ref_obj_id =3D=3D 0), so it remains fully val=
id
in the verifier's state until the active spinlock is released.

If the BPF program subsequently frees the object by passing the returned
owning reference to bpf_obj_drop(), won't the original non-owning reference
remain as a direct, unchecked alias to the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512055919.9571=
6-1-kaitao.cheng@linux.dev?part=3D7
