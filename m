Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFDB37AA77
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764451; cv=none; b=csGH8ZSUa2tMh7OCBJYfLdcFO7VEOL6Pne2XOhX1LTt4K17CpYsl66U1ypkfyVfSMwFcUYfDEX7zL4gyD/MSavYeWTkvsh6skCErLqaRO88GeZmTXOp3uJqS7anqWfNCaO4vOmKjIUUX9yyHvk2ybbZ/HccxZyhUehCqmxOk9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764451; c=relaxed/simple;
	bh=DMTiWGJlGhv4WvXRy+VaIiTjtjHu/ms7BbZ0zVYJNlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JGR3+gC5BXAcDbGHabKWazE8ltpRgfqOXnR9zOP+ZnoRqEaRUs9JLQ+fzw5rmRGbQBtMnUqpNm1onpqBC3JZ8ob+tbmWJ8tiRr0jKG+T/Hq0OnjBd/ilIctHHXYZ2H3YgmaRtIeTnjcOnikLvUr4mBWl8bZbcNRJ18zJT186mKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVAvpL2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVAvpL2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F851F000E9;
	Tue, 26 May 2026 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764450;
	bh=lmsAtC86TC5Kr4fucDYMSjXARHYyBFd2RL4s7tsWKGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVAvpL2dJmJBqsV2E2N2ZuFGJ+Tj1e8Ea0yhQPaT8X+57oZJYfdjJjv/FqJGTNxNg
	 WOVNxFzgMUfj9vNg61C9jhDmszkC4et7jpr4ka6O8BAVza7u8JisKQjIDiyHfxgY+O
	 brz6meuVs/LVIIHQFvBlixBahUox7Z9ldva20UyWzsAy6SgWzlFzBfQm2EBUxiamkU
	 nsWoh/x60idydhqOx+mgE5tDxwf8NPftnuFyDlqYwL+UGEzD8TOS+RonsffF5JSwML
	 8W60VxQEOwWdLsWHmRbp0WAE82+fHln5ZP4hHCA2fkLuN1whxoet9nnhyY90x85Nqu
	 y8thcBNXK8BYw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 02/11] bpf: allow attaching struct_ops
 to cgroups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <a7bf069cbc39930fad3740269aa82f1acadb029b.1779760876.git.zhuhui@kylinos.cn>
References: <a7bf069cbc39930fad3740269aa82f1acadb029b.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:00:49 +0000
Message-Id: <20260526030049.E5F851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Concurrent execution of cgroup release and link deallocation l=
eads to critical Use-After-Free.
- [Critical] Premature publication of the link in the `bpf_struct_ops_link_=
create()` error path causes a Use-After-Free if initialization fails.
- [High] A race condition between link creation and cgroup release allows a=
 struct_ops link to bypass auto-detachment when its cgroup is deleted.
- [Medium] Links that survive `cgroup_bpf_release()` retain list pointers p=
ointing to a destroyed stack frame.
--

commit 4637164a31e8f2395a0e21ae383236036263c3ba
Author: Roman Gushchin <roman.gushchin@linux.dev>

bpf: allow attaching struct_ops to cgroups

This commit introduces the ability to attach bpf struct_ops to cgroups
using the BPF_F_CGROUP_FD flag. The cgroup maintains a list of attached
links, which are auto-detached when the cgroup is deleted.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 7ad3b1a49dee8..e63f926d87283 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1256,6 +1258,10 @@ static void bpf_struct_ops_map_link_dealloc(struct=
 bpf_link *link)
>  		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>  		bpf_map_put(&st_map->map);
>  	}
> +
> +	if (st_link->cgroup)
> +		cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
> +
>  	kfree(st_link);
>  }

[Severity: Critical]
Can this cause a use-after-free if it races with cgroup_bpf_release()?

If a link's file descriptor is closed, this function runs concurrently with
cgroup release. cgroup_bpf_release() iterates over the links holding
cgroup_lock, sets st_link->cgroup to NULL, and increments their refcount.

If dealloc() checks st_link->cgroup without a lock and sees NULL, it will
bypass cgroup_bpf_detach_struct_ops() and proceed directly to kfree(st_link=
).
Meanwhile, cgroup_bpf_release() continues operating on the freed memory.

A similar race appears to exist in bpf_struct_ops_map_link_detach().

[ ... ]

> @@ -1414,11 +1447,26 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
>  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_ma=
p_lops, NULL,
>  		      attr->link_create.attach_type);
> =20
> +	init_waitqueue_head(&link->wait_hup);
> +
> +	if (attr->link_create.flags & BPF_F_CGROUP_FD) {
> +		cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
> +		if (IS_ERR(cgrp)) {
> +			err =3D PTR_ERR(cgrp);
> +			goto err_out;
> +		}
> +		link->cgroup =3D cgrp;
> +		err =3D cgroup_bpf_attach_struct_ops(cgrp, link);
> +		if (err) {
> +			cgroup_put(cgrp);
> +			link->cgroup =3D NULL;
> +			goto err_out;
> +		}
> +	}
> +

[Severity: High]
Could this allow a struct_ops link to bypass auto-detachment?

The link is published to the cgroup list here before link->map is initializ=
ed
and the program is fully registered. If the cgroup is deleted during this
narrow window, cgroup_bpf_release() will attempt to detach all links.

Because bpf_struct_ops_map_link_detach() observes link->map as NULL, it
might silently return 0 and fail to unregister the link. When this create
function resumes, it will fully register the program and initialize link->m=
ap,
leaving the link active in the kernel despite its cgroup being destroyed.

>  	err =3D bpf_link_prime(&link->link, &link_primer);
>  	if (err)
> -		goto err_out;
> -
> -	init_waitqueue_head(&link->wait_hup);
> +		goto err_put_cgroup;

[ ... ]

> @@ -1429,13 +1477,16 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
>  		mutex_unlock(&update_mutex);
>  		bpf_link_cleanup(&link_primer);
>  		link =3D NULL;
> -		goto err_out;
> +		goto err_put_cgroup;
>  	}
>  	RCU_INIT_POINTER(link->map, map);
>  	mutex_unlock(&update_mutex);
> =20
>  	return bpf_link_settle(&link_primer);
> =20
> +err_put_cgroup:
> +	if (link && link->cgroup)
> +		cgroup_bpf_detach_struct_ops(link->cgroup, link);
>  err_out:
>  	bpf_map_put(map);
>  	kfree(link);

[Severity: Critical]
Is it safe to directly kfree(link) here after it was published?

If initialization fails, the code jumps to err_put_cgroup and eventually ca=
lls
kfree(link). However, since the link was made visible to the cgroup earlier,
a concurrent cgroup_bpf_release() could have already observed it, grabbed a
reference, and queued it for detachment.

If cgroup_bpf_release() already set link->cgroup to NULL, the cleanup
bypasses cgroup_bpf_detach_struct_ops(), leading to a direct kfree() while
the release path still holds a reference. This will cause a use-after-free
when the release path later calls link->ops->detach().

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b61..b593ebb30a4e0 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -307,12 +308,23 @@ static void cgroup_bpf_release(struct work_struct *=
work)

[ ... ]

> @@ -346,6 +358,11 @@ static void cgroup_bpf_release(struct work_struct *w=
ork)
> =20
>  	cgroup_unlock();
> =20
> +	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
> +		st_link->link.ops->detach(&st_link->link);
> +		bpf_link_put(&st_link->link);
> +	}
> +
>  	for (p =3D cgroup_parent(cgrp); p; p =3D cgroup_parent(p))
>  		cgroup_bpf_put(p);

[Severity: Medium]
Should these links be removed from the list before putting them?

The st_links list head is a local stack variable in this function. Links
that survive this function (kept alive by userspace file descriptors) are
never removed from this list via list_del().

This means the long-lived st_link objects retain list.next and list.prev
pointers that point to a destroyed stack frame, which could leak stack
addresses or cause memory corruption if the list fields are accessed later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D2
