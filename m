Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF53B27C6
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307693; cv=none; b=owYIByofdTmy90s8tJ/IAdD4F3EEIKGYca2oIjdY9D6vjcycLVnVGuB0sGQOlvqUeKsKxzsa2AVa2HNurzDPjxLHymt7yCzQAmtnh09SkVXiwIF7WEl7QtkUF3j8/TKI/1fyqq6x/Ns3bkHhFWDJk0Kr4Wpmj8n93ngyM+m9XvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307693; c=relaxed/simple;
	bh=tK/FoEHtZwZAqLW5lNtr6xUmpWgrIFzTeXodW3ii9qI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGckrKt27FWpTBROpvJzGLYcG9gUUmPw5DsgUyl1k07AAphXcHslndfxs03Rn3325DbGZtY7e5aG1DPX7BkarWXXvF8Odt8AsD/cnI+eMat0yUeabpgcTdgqFRRsFoxUWBSpo4NLD4Sjh4Y4oFf/eW0dG/+wIXZ5q9ju7Wg2r6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7wDMA8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7wDMA8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8A71F00A3A;
	Wed, 24 Jun 2026 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307691;
	bh=KvzQ9V205xhceJCkG6h72QO6J7oeCduylZQaQXIXB/0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=B7wDMA8Gk+3zJiGeFO0mlNehIUAndDVXJVtNcV7hS5WB1imd6hti5CmpWlTp9NU4z
	 +n8v9bRl+3t4w5ZW8OSSjuvwhU8UsXsBXDY88SmzYnfDULEOUWPck4h12pIdlmJBD4
	 yJ6aTPAi7zK3z065M65nUmEC1SU+ewBkQE4ZvSB8T8XDds+o+Zw+jZB9WUFMY88Ndf
	 UFjh5TzY2zoxilIXQaUb02HwCqHLt/zJOxgHcnXrFMO/16qsG90F5FsIeSdpVOTYeb
	 xEMqzm2kMBG1zIl/4YTf+ebbpxMuUyy29GsqlsUxsyXMMSwsRr7uv1EUs8YVKKr4LD
	 SSKi2Ij9dzO7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/4] mm/memcontrol: do not drain objcg stock when
 spinning is not allowed
Reply-To: sashiko-reviews@lists.linux.dev
Cc: mkoutny@suse.com, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-1-fdf4d17351dd@kernel.org>
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <20260624-kmalloc-nolock-fixes-v1-1-fdf4d17351dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:28:10 +0000
Message-Id: <20260624132811.5C8A71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The fallback path in `__refill_obj_stock()` indefinitely accumulat=
es memcg charge without uncharging it, leading to a massive memcg leak and =
premature OOM for `!allow_spin` workloads.

Pre-existing issues:
- [High] `__memcg_slab_free_hook()` unconditionally drops object references=
 via `obj_cgroup_put()`, causing spinlock acquisition on PREEMPT_RT even wh=
en `allow_spin =3D=3D false`.
- [High] `kfree_nolock()` can still acquire a sleeping lock on PREEMPT_RT t=
hrough `obj_cgroup_uncharge_pages()` when `allow_spin =3D=3D false`.
--

commit f6eb6f507d999767dfe0866c3a461084a0d9e774
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/memcontrol: do not drain objcg stock when spinning is not allowed

This commit updates kmalloc_nolock() and related objcg functions to avoid
draining the objcg stock when spinning is not allowed, aiming to fix
lockdep warnings on PREEMPT_RT. It falls back to atomics if the objcg
doesn't match and draining is unsafe.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 29390ba13baa2..5bb5e75ef5b0c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -3346,6 +3347,13 @@ static void __refill_obj_stock(struct obj_cgroup *=
objcg,
>  out:
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);

[Severity: High]
This is a pre-existing issue, but can this call to
obj_cgroup_uncharge_pages() still acquire a sleeping lock on PREEMPT_RT?

Even with allow_spin =3D=3D false, __refill_obj_stock() calls
obj_cgroup_uncharge_pages() if the object's objcg matches the CPU's cached
objcg and the accumulated bytes exceed PAGE_SIZE, or if falling back with a
large object.

obj_cgroup_uncharge_pages() unconditionally calls refill_stock(), which
uses local_trylock(&memcg_stock.lock).

Per kernel guidelines, acquiring a local_lock (even via trylock) within a
raw spinlock or hardirq context causes an Invalid wait context lockdep splat
due to wait-type mismatch.

> +	return;
> +
> +fallback:
> +	nr_pages =3D nr_bytes >> PAGE_SHIFT;
> +	nr_bytes =3D nr_bytes & (PAGE_SIZE - 1);
> +	atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> +	goto out;
>  }

[Severity: High]
Does this fallback path indefinitely accumulate memcg charges without ever
uncharging them?

When __refill_obj_stock() is called with allow_spin =3D=3D false and the ca=
ched
objcg doesn't match, it jumps to this fallback path. It adds the remaining
bytes to objcg->nr_charged_bytes via atomic_add(). Because nr_bytes is
typically less than PAGE_SIZE, nr_pages is 0.

Since the function returns immediately via the out label without checking if
the newly accumulated nr_charged_bytes exceeds PAGE_SIZE, the charge is
never uncharged.

If a workload exclusively uses kfree_nolock(), could the memcg charge grow
unbounded and cause a premature OOM?

[ ... ]

> @@ -3535,7 +3547,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, s=
truct slab *slab,
>  		obj_ext->objcg =3D NULL;
> =20
>  		stock =3D trylock_stock();
> -		__refill_obj_stock(objcg, stock, obj_size, true);
> +		__refill_obj_stock(objcg, stock, obj_size, true, allow_spin);
>  		__account_obj_stock(objcg, stock, -obj_size,
>  				    slab_pgdat(slab), cache_vmstat_idx(s));
>  		unlock_stock(stock);

[Severity: High]
This isn't a bug introduced by this patch, but does __memcg_slab_free_hook()
still unconditionally drop object references via obj_cgroup_put() right
after unlock_stock() returns?

If this drops the final reference to an offline memcg, obj_cgroup_put()
synchronously invokes the release callback obj_cgroup_release(), which
acquires the sleeping objcg_lock lock.

Could this trigger the exact Invalid wait context lockdep splat or deadlock
on PREEMPT_RT that this patch intends to prevent, even when allow_spin is
false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-kmalloc-no=
lock-fixes-v1-0-fdf4d17351dd@kernel.org?part=3D1
