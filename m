Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B170326938
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809352; cv=none; b=RLandC1UBX4ApKwxvJawq6TTrHtpBZE7Bq22haWq5N5pUhqC96pGfOKye/7Bf3un6f91Y663LdQMFGxUw0lfx7icxnVHYIby8b0IDy6avn/gZdq6//2UviVZo7pBW9Ll0WY5Q+RGWIHVM0XpvhgKJGe1glvTsKX4ts6UeQcV52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809352; c=relaxed/simple;
	bh=WOrP3l7LvZk96p2cQNjhiCbld/nQiJyyFCnH3XwZtjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZpbqRo+8xg0+29luJKpYYk3zO/Kgx9zsINk4xrSf1d+G7N5D0YcbJNycGDQ6ediJHXyONrByC2qCucPHqHKhX7PioE1EJh7oW0fSaLgn/zXTCfSka7kVeTHet3dzE0nJyoFAOt+62fZkd4TUrIFHs7jwDDWkBEr0PQL2vnG6qYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARAFatNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARAFatNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C3A1F000E9;
	Tue, 30 Jun 2026 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782809351;
	bh=Y6Us6DY3wg7QtsVeRSL3sSVvll7Jt96AKhtshPRlbUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARAFatNvRuccYBOdyIA867PEugsI0mnHcIn/B8ybvTvYd3nJzi8Nel/Gecwhn+hzZ
	 x9YVQdinIKWj0FvbXYGYamr4oJSzqcM2bCCzQSjFcJKgrJzByd4Q7wA1dMN7XbZQnc
	 NjTKBv2BPiVuei8/xdIM4RVetUnwNOJAwfmuI4g2Z4ddrFoANdC4jrggN9fFBmGWQh
	 5CPJ+eKYXBco4K1PSLSLp1C5Ml7pIWwccSr41y9TjV5DBxgn0amcqqbh+Yvm+Tks4z
	 K6qGRSu7xGRMWJd26DDYNXiv4Lf7J0Q1KBfx9oFfL6JKzmvAvaJEjqNE4jIj6EWYnF
	 1FeKfDyVudwPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix smp_processor_id() call trace for preemptible
 kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Edward Adam Davis" <eadavis@qq.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_C4C3064909A16EDCAEDB0C8767D886D01206@qq.com>
References: <6a436023.b42ede87.8e801.0003.GAE@google.com>
 <tencent_C4C3064909A16EDCAEDB0C8767D886D01206@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:49:10 +0000
Message-Id: <20260630084910.D5C3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silencing a preemption warning with `raw_smp_processor_id()` leave=
s a severe cross-CPU task migration hazard intact, leading to lockless list=
 corruption in the BPF memory allocator.
--

commit b3d3adf96792401d9a691908ba210c6315bac1bb
Author: Edward Adam Davis <eadavis@qq.com>

bpf: Fix smp_processor_id() call trace for preemptible kernels

This patch attempts to resolve a preemption warning in
bpf_mem_cache_free_rcu() by replacing this_cpu_ptr() with per_cpu_ptr()
and raw_smp_processor_id().

Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1f

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198fe..f2b7828e6ac7c 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -951,7 +951,7 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_al=
loc *ma, void *ptr)
>  	if (!ptr)
>  		return;
> =20
> -	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
> +	unit_free_rcu(per_cpu_ptr(ma->cache, raw_smp_processor_id()), ptr);

[Severity: High]
This is a pre-existing issue with bpf_mem_cache_free_rcu() being called in a
preemptible context, but does silencing the warning with
raw_smp_processor_id() leave the underlying cross-CPU task migration hazard
intact?

If a task evaluates raw_smp_processor_id(), gets preempted, and then migrat=
es
to another CPU, unit_free_rcu() will execute on the new CPU while still
operating on the original CPU's cache.

Since unit_free_rcu() only disables local interrupts for the current CPU,
the original CPU can concurrently modify its own cache. This could lead to
data races on the local_t active counter and concurrent execution of the
non-atomic __llist_add() operation, as seen here:

kernel/bpf/memalloc.c:unit_free_rcu() {
    ...
    local_irq_save(flags);
    if (local_inc_return(&c->active) =3D=3D 1) {
        if (__llist_add(llnode, &c->free_by_rcu))
    ...
}

Could this concurrent access corrupt the lockless lists?

>  }
> =20
>  /* Directly does a kfree() without putting 'ptr' back to the free_llist

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_C4C3064909A=
16EDCAEDB0C8767D886D01206@qq.com?part=3D1
