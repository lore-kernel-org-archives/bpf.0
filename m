Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFB3C1961
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740824; cv=none; b=lL0bdTAROteuJVhTp2J5PCyiizLLrPHja90BPly9BTPfLMA9dFLclCInfbYHxObj1jPtR2cZsrktykqXNv1P7A0eFnz8Kx8bjiKomxve+B2l3jP2rKOkDkehh4k+CbtVtlEy+Js6OYPrF/TDfcyGqC+Bz7LkkE4N3hqGhqUbuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740824; c=relaxed/simple;
	bh=QIrIeQcku+52/alx8lrBZn4CH4wwm/tu7nfTtyj2dpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nds6r2u4koDk59/YBVcjKIzBxbWHWFu7Sms6xCGzNA77IPwwK84akEzmgBmo2GwdTVo/m8qlt1LrhY1bRwM65Z21ncUOhW2fYePu+GI/ixRbl93cht+sGtsOb+AdEQhLbHEOxgDK/JmN4g4/aDZ/zHUyo+3xxC/AzBncKO2Rbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcxTDrkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcxTDrkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF61F000E9;
	Wed, 26 Aug 2026 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740818;
	bh=uPk1n6PehxcOZN05Gw7b5O3HsZji5Hg5Q+aw6TpQmfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LcxTDrkSLgP0Av+7BkmSlWSE7Ktru3YP+y6zHQeu5VnfoWBECAG9WhsogFsckDZ2q
	 ihatwzymrRcx51h5cDx3neJYULze7UYT6QTgm96tj4Y75cOczWuzXJv8UTPBtX8haH
	 GXWaw+rmSEc2V/GIBl525ZU78lMoyEClZiGUylZK7nlT4rKjqV4RqGWm27NoJinAVf
	 i9V2Cm2Hp5Sv7MR9pqIhmOzeQgVB3tuH+hIbQ3a+yZLWnPCa0LIiZTRSZEXLL1mI0D
	 hxxYpJwGo9/Y9AYGvH8XRlYgywonYLwd6pMnlDzqlwqgBk/jWueXe2RWcIW0HSsgss
	 Jk8UPa6+j12eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826103615.932094-1-pulehui@huaweicloud.com>
References: <20260826103615.932094-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:40:17 +0000
Message-Id: <20260826104017.EEDF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Incorrect struct member used in container_of() in __free_final=
_rcu() leads to a misaligned pointer and severe memory corruption.
--

commit bc9dc5f25db638cea0ee9ae53e66c94250192d0e
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace

This commit addresses a use-after-free in alloc_bulk() by deferring the node
reclamation of waiting_for_gp_ttrace. It detaches the nodes in the __free_r=
cu()
callback and queues them for final reclamation via a new normal RCU callbac=
k.

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198fe..fb1e733bfb829 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
[ ... ]
> @@ -276,12 +278,28 @@ static int free_all(struct bpf_mem_cache *c, struct=
 llist_node *llnode, bool per
>  	return cnt;
>  }
> =20
> +static void __free_final_rcu(struct rcu_head *head)
> +{
> +	struct bpf_mem_cache *c =3D container_of(head, struct bpf_mem_cache, rc=
u);

[Severity: Critical]
Does this calculate the correct base pointer?=20

Since the callback is queued using the rcu_reclaim field in __free_rcu(),
computing the container using the rcu field will result in a misaligned poi=
nter.

Because rcu_reclaim is located after rcu in struct bpf_mem_cache, the offset
subtraction leaves c pointing past the actual object's start address. When
this corrupted pointer is passed to free_all(), could it cause memory
corruption or a crash by reading an invalid function pointer for c->dtor?

> +	struct llist_node *llnode =3D c->waiting_for_reclaim_gp;
> +
> +	c->waiting_for_reclaim_gp =3D NULL;
> +	free_all(c, llnode, !!c->percpu_size);
> +	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
> +}
> +
>  static void __free_rcu(struct rcu_head *head)
>  {
>  	struct bpf_mem_cache *c =3D container_of(head, struct bpf_mem_cache, rc=
u_ttrace);
> +	struct llist_node *llnode =3D llist_del_all(&c->waiting_for_gp_ttrace);
> =20
> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
> -	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
> +	if (!llnode) {
> +		atomic_set(&c->call_rcu_ttrace_in_progress, 0);
> +		return;
> +	}
> +
> +	c->waiting_for_reclaim_gp =3D llnode;
> +	call_rcu(&c->rcu_reclaim, __free_final_rcu);

[Severity: Critical]
Should __free_final_rcu() use container_of(head, struct bpf_mem_cache,
rcu_reclaim) to match this call_rcu() usage?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826103615.9320=
94-1-pulehui@huaweicloud.com?part=3D1
