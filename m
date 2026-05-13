Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652B37F746
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705060; cv=none; b=ZQu28YBRs8Fhh1HrsNaACbxR1jp4H7leF0pinss3O7ooy/N1Yx9lc5s7FmBmNZrlNd4sui73ACl5saTS9sgVMBsNSg6HqcDz9rUe9lN/oFOaO29LVw158rvmete/3EOT1ubYtq6Ow89eBjBMapn51/8iaNPHw5VxH1QxuCo/0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705060; c=relaxed/simple;
	bh=JR/zBJG9CLpWEMsWlHxHFyhgAQeFUjczYE4sdKZ5Bks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B8R8aKGUw7Kq3IftJi3QI/XkOJtgVtjm0Ssas1a+F7FsnODM0pMfmH6qtUK+35MZYwiVIQtAYJ3yM3NT9tQKsv5xHFn6AOXJHdM+EFW/ENRnkqxp3by3LaCphndjNNOP41aXOu6X5qAsNBguEf9M52kLaz2vwTZu7Q4PiaTjhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObTZiJzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObTZiJzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB22C19425;
	Wed, 13 May 2026 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778705060;
	bh=JR/zBJG9CLpWEMsWlHxHFyhgAQeFUjczYE4sdKZ5Bks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ObTZiJzrvK8iQFQ1IvojUwZ9TJ6c5tq/A6o35RUGeoW37ZtrG/9wi8q/5we++Hso2
	 m19iNt87QehAYbR0SNkKgzOhTYkhbsIPYmD2GcNuvI3EfiftkK6vPVx+C3ImBg/fVH
	 quQ8csljq/J4MAVOMwf1c+sutvxSK+YRnz3Sg6Fecfo7VBS/ikyOK5tJVMUEjyrDNu
	 7Pn7LvJxu4gf64nATsFSqNUvW5gbQeVP+JlqaKbmP7KHuk3IY76IQifXPquZUrvmhf
	 Q2RFk7G2cBBoafHt0sOrf1XndjV/DcBi3sVVjozPpLGH1hDbFq+7P+5YobU5vy62TT
	 WqxynF2QonbcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v10 5/8] bpf: Add bpf_list_add to insert
 node after a given list node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512055919.95716-6-kaitao.cheng@linux.dev>
References: <20260512055919.95716-6-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:44:19 +0000
Message-Id: <20260513204420.2BB22C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf_list_add drops the 'new' node on runtime failure, but the =
verifier unconditionally converts 'new' to a non-owning reference, leading =
to a reliable Use-After-Free.
- [High] The bpf_list_add kfunc is marked with KF_IMPLICIT_ARGS but lacks t=
he required _impl counterpart, causing the verifier to unconditionally reje=
ct it.
--

commit 2a493a875461b6ae4bffbc4548a568dfaca01438
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: Add bpf_list_add to insert node after a given list node

This patch adds a new kfunc bpf_list_add() to insert a node after a given
list node in a BPF linked list. The new node must be an owning reference
which is consumed by the kfunc, and on failure, the kernel drops the
passed-in node.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5388078f31710..2b8e8d4284a54 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2570,6 +2570,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf=
_list_head *head,
>  	return bpf_list_push_back(head, node, meta__ign, off);
>  }
> =20
> +__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list=
_node *new,
> +			     struct bpf_list_node *prev, struct btf_struct_meta *meta,
> +			     u64 off)
> +{
> +	struct bpf_list_node_kern *n =3D (void *)new, *p =3D (void *)prev;
> +	struct list_head *prev_ptr =3D &p->list_head;
> +
> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, o=
ff);
> +}

If __bpf_list_add() fails at runtime (e.g., because prev is not in the list
indicated by head), it drops the 'new' node:

__bpf_list_add()
...
fail:
	__bpf_obj_drop_impl((void *)n - off, rec, false);
	return -EINVAL;

However, the verifier unconditionally converts 'new' into a non-owning
reference during check_kfunc_call(). If __bpf_list_add() fails, the BPF pro=
gram
retains this non-owning reference to a freed node. Could this allow the pro=
gram
to trigger a use-after-free within the lock critical section?

[ ... ]
> @@ -4748,6 +4758,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT=
_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
> +BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)

Since bpf_list_add is marked with KF_IMPLICIT_ARGS, won't the verifier look
for a bpf_list_add_impl counterpart during program load?

Without defining and registering a bpf_list_add_impl function,
find_kfunc_impl_proto() will fail to find the required _impl suffix in the
vmlinux BTF. Will this cause the verifier to unconditionally reject the kfu=
nc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512055919.9571=
6-1-kaitao.cheng@linux.dev?part=3D5
