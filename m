Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B946F4BA
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406205; cv=none; b=mWDENEQdYT7Y+oVs57icIAOcrxsot6O9JxkWlir0TK6OPgCS1gwn/DwAIqy4hE0uE8JT4wtOfmnqRdnHHvkYqg5avFWW8c68Vm8eq4fGWLi2zeH7AJGFiA25XlwFXyZ9RZ6AwgyYTQxBGA3Q8HiPKYgE1dLe+5q2Xh0EFuc/we8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406205; c=relaxed/simple;
	bh=BWRmDAwW8/TQJtGMlGFLKIinMWFYb6Q5nBxjGnQ8lSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ckL6BjOHyiqwQ0gBsG1OPNx5uPcui/mi0Y2zQridAT1/8wbbBqUCG2PorJarzSPYw8mIihFPdqH90xUQbDJPpJpaCoxBaWLoWq5Eyq2zB8tUk19ndYEZ9OUmztjydnofZw9AI7dwlbBp9I6o+P0Y1anoj93Lpu44awbfdl8Dqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHvn0OwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHvn0OwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438DE1F000FF;
	Mon, 14 Sep 2026 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406204;
	bh=Lol7C2YQ87PNzXkMFR1B5g23cgY0acOVoZfUy8Re/Fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHvn0OwGnqFvPkzfnk0lc0/gYjO/w90shfd0fftPEuw/nqptSrmxCpjQtThc0yUP1
	 Q4hldpvhj/hlijl0TL64wVs9KP2W6lpBUUXsWqGfhNN5SusKt0BVnDKfwuSyDRudzu
	 2r0SD35yZmT3q4oyD1A7E1nkDrrqppqsENCHJCn6gusKOdTLUu51e8TtY1pEAmHX1D
	 Lzqc0LwLjZGnWkSHl/z5cHLM6a3qbz7nuEYRfBek0WuPBAs+/Rk5vxhvUkwMVSUJep
	 TQnA9iFeZKwdr5NjKI9uqMU9Xg9znCl7jd6yVw46ogXcv53LhJKWeqqclLaG2khi1y
	 1kTL41Rv9TjRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Skip unsettled links in link iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260914170206.170723-2-bestswngs@gmail.com>
References: <20260914170206.170723-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:16:43 +0000
Message-Id: <20260914171644.438DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting race condition between btf_put() and btf_idr iteration=
 causes refcount saturation and Use-After-Free.
--

commit c9cafeb12312032e3482a8253aec4ec8da20e91f
Author: Weiming Shi <bestswngs@gmail.com>

bpf: Skip unsettled links in link iterator

This commit fixes a use-after-free in the BPF link iterator by ensuring
unsettled links (with ID zero) are skipped during IDR traversal. It prevents
taking references on transient links that might be freed concurrently.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 853b47f813842..244a939b9d2da 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6042,7 +6042,10 @@ struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
>  again:
>  	link =3D idr_get_next(&link_idr, id);
>  	if (link) {
> -		link =3D bpf_link_inc_not_zero(link);
> +		if (link->id)
> +			link =3D bpf_link_inc_not_zero(link);
> +		else
> +			link =3D ERR_PTR(-EAGAIN);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at this fix for
bpf_link IDR iteration, is there a similar race condition in the BTF IDR
iteration?

In kernel/bpf/btf.c, btf_put() decrements the refcount outside the IDR lock:

kernel/bpf/btf.c:btf_put() {
    if (btf && refcount_dec_and_test(&btf->refcnt)) {
        ...
        /* btf_free_id(btf) is called later, acquiring the lock */

Concurrently, iterators like bpf_find_btf_id() or bpf_core_add_cands()
iterate over btf_idr holding btf_idr_lock and unconditionally increment
the refcount via btf_get() (which maps to refcount_inc()).

Could this lead to btf_get() incrementing a 0-refcount object before it is
removed from the IDR?

If the refcount is incremented from 0, it saturates the refcount and trigge=
rs
a kernel warning.

Furthermore, after the iterator drops btf_idr_lock to do a slow linear
search without holding rcu_read_lock(), btf_put() can proceed to remove
the ID and schedule the RCU callback to free the BTF memory.

Does this expose the iterator to a use-after-free when accessing the BTF
object later?

Would it be safer to use refcount_inc_not_zero() during BTF IDR traversal,
similar to how bpf_link_inc_not_zero() is used here?

>  		if (IS_ERR(link)) {
>  			(*id)++;
>  			goto again;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914170206.1707=
23-2-bestswngs@gmail.com?part=3D1
