Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15103E51F7
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820479; cv=none; b=llelk8NBZ9njFX4k+7nR5ZNweI4Tdwgh4j/re1QL/CBxHBQ9s/2efRgK7ASiBJGNhz4A09wRm1X5vsD3cfUoy6T2MhxR/MVGZkqQ+/avOVnYy0J0Gxya3M34JQ85hu3nVS8W7mECnTSlFDkgRc3wXPjufeHzSZfZTq2qpLy1oDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820479; c=relaxed/simple;
	bh=3MPl8uxL9YnDh0y4iN0U01UWSMEDL+66Gpkf5nyB/Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mmIixi5dTanWj9pis27UVS0s3v3H/SaJ7ySsUQmjC49xSjsmIxXn+d6GXwNakEwKEseasvktNtYFz2WApLDyBODcJGnl/9JtCp2xiH8DIi/wew2uTbBxHVn0vRUhFse7woskw0xeADil5YUiAn/pOLBG7NqCi/1zhWpCgAsQXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6ggKRhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6ggKRhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4271F000E9;
	Thu, 27 Aug 2026 08:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787820477;
	bh=x82JocE8wGdq5jTNlO3Rg6zqkHx/RzFFnPim/VHyrjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6ggKRhFFVxMHHsneQCmxFArg2CX3eHLsm1vQQoIE0gEggovrgyUBJGE9jqr5v8ak
	 POYxR5jsdWNY2NZAE5oKeYRCl8ZZvBeWaZiJEkROSX/xzsg7re+V7cybESqA49R4PH
	 FUdXmx63zdAQ5EsIqEIuYWVbImFeBN3bO39DSLRhMnPHFF4jbMCsQ/Qzc2V2fWMe+L
	 aUfBa1k4LunS+kg91KLYMh3nFmE4oJG9e2mtrZnhai6oaegl3L9lS61oJx3X/ssyl5
	 +J93WQ77YyZTXTg/2iFYm9pIQy8JN++C+2xmPM7jYgLxoRZzRORcOppOG6mJ1VLfCE
	 HrNjLRew64MBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260827084013.1062816-1-pulehui@huaweicloud.com>
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:47:56 +0000
Message-Id: <20260827084756.EC4271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes concurrent consumption for `waiting_for_gp_ttrace`=
 but incorrectly claims `free_by_rcu_ttrace` is safe. A race condition duri=
ng cache destruction leads to a Use-After-Free on `free_by_rcu_ttrace`.
--

commit ed5f43858e59ce799a585eeedfe466c5543df6aa
Author: Pu Lehui <pulehui@huawei.com>
Subject: bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace

This commit fixes a use-after-free caused by concurrent consumption of
waiting_for_gp_ttrace nodes by alloc_bulk() and __free_rcu(). It introduces
a raw spinlock to synchronize operations on this list.

The commit message notes:
> Note that free_by_rcu_ttrace does not suffer from this issue as it only
> has a single active consumer during normal operation.

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198fe..58296e92a4fed 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
[ ... ]
> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, vo=
id *obj)
>  static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  {
>  	struct llist_node *llnode, *t;
> +	unsigned long flags;
> =20
>  	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>  		if (unlikely(READ_ONCE(c->draining))) {
>  			llnode =3D llist_del_all(&c->free_by_rcu_ttrace);
>  			free_all(c, llnode, !!c->percpu_size);
>  		}

[Severity: High]
This is a pre-existing issue, but does free_by_rcu_ttrace actually suffer
from a similar race condition during cache destruction?

If userspace triggers destruction of a BPF memory allocator via
bpf_mem_alloc_destroy(), CPU 0 sets c->draining =3D true and synchronizes
the irq_work:

CPU 0: bpf_mem_alloc_destroy()
    WRITE_ONCE(c->draining, true);
    irq_work_sync(&c->refill_work);

Meanwhile, CPU 1 could be executing alloc_bulk() inside the refill work,
consuming from free_by_rcu_ttrace:

CPU 1: alloc_bulk()
    obj =3D llist_del_first(&c->free_by_rcu_ttrace);

If CPU 1 reads the head pointer in llist_del_first() but is delayed before
READ_ONCE(entry->next), and concurrently an RCU callback on CPU 2 calls
do_call_rcu_ttrace(), CPU 2 will observe draining =3D=3D true here and
immediately free the nodes.

When CPU 1 resumes and executes READ_ONCE(entry->next), won't this result
in a use-after-free on the node that was just freed to the slab allocator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827084013.1062=
816-1-pulehui@huaweicloud.com?part=3D1
