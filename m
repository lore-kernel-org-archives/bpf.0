Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099F3FADF2
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063213; cv=none; b=P2fPE86zIoVjh8TPQv60ZZlAQUsBV60JOqI0vIJ/tes7D3yVC8csEnYNjrE8Sp7pf7dBi2WIwoTIMulZyIoCjx5msn961I0N0Zo+Yv/RDgB5to9Mg8iqFkTItDAJR6P7n77EF2Yg/NU1MXYZUvLuIq297opGlkMLtwp2UoCnSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063213; c=relaxed/simple;
	bh=hT284cGS7bob7LorULEs5qCokvTi1Es+yCme8G4VbJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mGBk3M3/X9x1HU/p10LG4S/bUBNEjBpnntopJUszhienSL9MTQlbPxPMlfco0ajD4iUaK3jwwZU/ZqfdgJDvUdUNnZj9h1uWF1LTGcCrQrvtNYJTjZGKZ/rWhQICnWF89Vmswh6lXKqSeBd1vwPE1cFHcIfa+hImaj8HiiIJrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl3vwBvO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl3vwBvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C7BC19425;
	Fri, 24 Apr 2026 20:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063212;
	bh=hT284cGS7bob7LorULEs5qCokvTi1Es+yCme8G4VbJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Kl3vwBvOCI8DJgUSyc7fcjhcrNBMG6ajO+p3o7s2uEN96n8ZjwYfjx6NRw8YStr7C
	 bpDnvwse4RBc/F6O/WmG52+EP2ZRcDz4NmtLo8dpRlOZo4TCK8LSAU80vwguTk33MR
	 fVgasRJij9G1cKGa2CxUMzkhEN9NsVJjW/in4ISQqw/O2BB3x3+GTckZie4F95dkY9
	 kpgBgfzqV2HEjOvtHl7uIZTQntjYZKLCxRhW7mWBSWYrG5mq3RJd3JQAv67RTkhy2a
	 Y5FBAqBkolIKaPwFugWHTv8ZaAc6ijwnVbJQsLqp+MLLiq/cqp8hYWsESKp+PU0YF7
	 Kxaq3yWK8+Mcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Implement resizable hashmap
 basic functions
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 20:40:11 +0000
Message-Id: <20260424204011.E6C7BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Using rhashtable for BPF map updates/deletes is unsafe and wil=
l lead to hard deadlocks from IRQ/NMI/softirq contexts.
--

commit 47c235933705172d3a36c4339c754282500161f1
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement resizable hashmap basic functions

This commit adds a new BPF map type BPF_MAP_TYPE_RHASH backed by the kernel
rhashtable implementation. It provides basic map operations like lookup,
update, and delete using rhashtable APIs.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4fb..a37bd2a7b30f4b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem =
*elem)
> +{
> +	int err;
> +
> +	err =3D rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);

Can this lead to a deadlock when used by non-sleepable BPF programs in
interrupt or softirq contexts?

The verifier permits BPF_MAP_TYPE_RHASH to be used by non-sleepable BPF
programs, such as those attached to XDP or TC, which execute in softirq
context and do not check bpf_prog_active.

Map operations like rhashtable_remove_fast() and
rhashtable_lookup_get_insert_fast() internally use bit_spin_lock() for
bucket-level synchronization. This locking mechanism disables preemption
but leaves hardware and software interrupts enabled, unlike the
raw_spin_lock_irqsave() approach used by the standard htab.

If a syscall updates the map from process context and acquires the bucket
lock, and is then preempted by a hardware interrupt that schedules a softirq
on return, the softirq will execute the XDP or TC BPF program.

If this BPF program attempts to access the same hash bucket, wouldn't it sp=
in
indefinitely waiting for the bit_spin_lock held by the interrupted process,
causing a system deadlock?

[ ... ]

> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *=
value, u64 map_flags)
> +{
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *elem, *tmp;

[ ... ]

> +	tmp =3D rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhta=
b->params);

Does the same deadlock mechanism apply here as well, given that
rhashtable_lookup_get_insert_fast() also relies on bucket-level locks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-rhash-v3-0=
-d0fa0ce4379b@meta.com?part=3D1
