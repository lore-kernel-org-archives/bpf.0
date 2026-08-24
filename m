Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750E407CF6
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569145; cv=none; b=bXuznCzY4gxl2fFVFJp3qIx3oz3Efq8hrgYxTyObPWWr7O6KnRFWJodq/Hw5Yh8trrFaPhcUUMukP6T7AbZ5tyJq3+pPXkWD7rWTH75k7jmhFA7ixKfTReS+Ys6mWs8n/9vRuXJMzdajlRKb//jABwPcQQtbHTd0TlOuVAxXmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569145; c=relaxed/simple;
	bh=K4UfoqWs5C+ZX8Sh/vDX4rOUMCv1oq4qPrS8+trHU08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UGinOsJdhLQ5qWLqJA26C7pVIse+wdhvoJvduueC1QhFYbhJAOZyOud/QlHXatVPtD5sad+u3ME6dH4RyjSA66vFHs2wPkZG1HBkwnu2sDqU0OAGGt/Ev/FMMGgQs2GaJDbm5zaoGnhVAWwPT8y3nW5bnv+LUt6kPc5xCVdb74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZNwTaZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZNwTaZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1051F000E9;
	Mon, 24 Aug 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787569144;
	bh=cEyNuHTqx1wy0X0uBn6yc2rDvT09+OVDMETm8LbI5gA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZNwTaZo979hfu0z5Da9ArHGS4/46aCgmS903rFXuOxEC0Eelz5GL1TpbR3Rd29R+
	 9siYuz5+2FmafSbvyauGTeV/j8ByyItcSvavhIeo1ipLYTBnPFHALfe/LOMobW3F62
	 RVM88ZWn5TXtCEbRpMcMFjKtKmUFyXFhhx08JSlYm2toL9TZNzP+/aqlcwqKce0oFw
	 tOSdt0K/uLOhNDCqtGAOfa+P0hsv6BMpZVYOeTgtXCjIZE7M2ZdhK82tLd9vlF2uJ+
	 u8zvWpsOZrgQj+EaLKyXqe4dq+ba5HzkYeIEqK03ad366Y/Yl/4TRnzDYUObPtMfH+
	 DqUL/zB0KZhAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Cancel special fields on rhashtab value recycle
 instead of freeing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Falak R Wani" <falakreyaz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824103502.3154292-1-falakreyaz@gmail.com>
References: <20260824103502.3154292-1-falakreyaz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:59:03 +0000
Message-Id: <20260824105904.0A1051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deferring kptr destruction to the BPF memory allocator's destructo=
r causes permanent resource leaks because the allocator routinely recycles =
elements without invoking the destructor.
--

--- Patch [1]: [PATCH] bpf: Cancel special fields on rhashtab value recycle=
 instead of freeing ---
commit 1ee647bc226bed9cb1804699aa9faf7fa9345ec2
Author: Muhammad Falak R Wani <falakreyaz@gmail.com>

bpf: Cancel special fields on rhashtab value recycle instead of freeing

This commit alters the update and delete paths for resizable hashtables
(BPF_MAP_TYPE_RHASH) to avoid fully freeing special fields like referenced
kptrs. Instead, it uses bpf_obj_cancel_fields() so that these operations are
safe to execute in NMI context, deferring kptr destruction to the allocator=
's
destructor.

Fixes: 6905f8601298e ("bpf: Allow special fields in resizable hashtab")

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d8db1cebc1936..5f521d02784f3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -2964,8 +2954,12 @@ static int rhtab_delete_elem(struct bpf_rhtab *rht=
ab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/*
> +	 * Cancel timer, workqueue, and task_work fields before deferring the
> +	 * element free. Referenced kptr destruction is not NMI-safe, so leave
> +	 * it for rhtab_mem_dtor() after the RCU grace periods.
> +	 */
> +	bpf_obj_cancel_fields(&rhtab->map, rhtab_elem_value(elem, rhtab->map.ke=
y_size));
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);

[Severity: High]
Does this code leak the referenced kptr fields if the BPF memory allocator
recycles the element?

When rhtab_delete_elem() defers the element free to bpf_mem_cache_free_rcu()
without freeing the kptr, the allocator might recycle the element directly=
=20
to satisfy a new allocation request without ever calling the registered
destructor.

For example, looking at alloc_bulk() in kernel/bpf/memalloc.c:

	for (i =3D 0; i < cnt; i++) {
		obj =3D llist_del_first(&c->free_by_rcu_ttrace);
		if (!obj)
			break;
		add_obj_to_free_list(c, obj);
	}

Because this path moves the object straight to the free list without invoki=
ng
c->dtor (which would ordinarily call rhtab_mem_dtor -> bpf_obj_free_fields),
the kptr remains intact. When this recycled element is subsequently
initialized for a new key, check_and_init_map_value() zeroes out the kptr
field, which permanently loses the reference without decrementing the
refcount.

Could this lead to permanent resource leaks of kptrs, or potentially cause a
new map element to unexpectedly inherit a valid kptr from a previously dele=
ted
element?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824103502.3154=
292-1-falakreyaz@gmail.com?part=3D1
