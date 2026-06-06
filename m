Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765323F417
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780713409; cv=none; b=NB/aWclbLj3fCGAd2E40r4JloSvXzXje9PkLqcC6CA1HEMqQOS5yFjAi2SNhVNEidwPvWo8XHVNMlYgzY0/6yptVmIStPoDnEDiRgPbZa3s6K73/tZBBxj6iye3epYQyMq3zdwn35n+E7cKfDT9tP9E0H1E2+yS+r6UQ/Fyi90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780713409; c=relaxed/simple;
	bh=zfYYcv/JvkYtUlJ2AfXVToXCsPTPFi3WrimVV2eMRMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hcABRGrEbVzmgg71ovqNPQ+TpAuiESW1NbHODHVBCGb8cbMpWyX4UJPZznGheFNKJoP54rW6f0e2Ow7GwGi+rJs6l5+eu8/VLoauu61TCNmM5KypFMdqRaKBXnpxnhcBLc7Ts4zoBU6zUp9Ncnoor8xywtPGtbwsVY9AtcwGaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwiJ7Jwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwiJ7Jwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1D11F00893;
	Sat,  6 Jun 2026 02:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780713407;
	bh=9HpXCCZ84KS4sSkzXKBxy6ubThn1HezVCCRgpk+x/Uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwiJ7JwtVz5vrNByQZCjz4QwCpA0HeTvuuKxDIC68QWG+o09AkHKf58RM7k3i+v5P
	 qLTQQXQ5JNvJ39i79uILL//io2oC/nc55wiIG6TJRLDBvy9Eq9dcjW2coHR0PY9ZLh
	 872dMQ4IYvyHqKokgNQMS7//ow4duv9xRdQKQ2+Q1TblSlyP1dFfpX3OKo8U7V2gz+
	 xhcV2aluADKHFay/tQ/GLYSba0XX/D6BP9BJexzIzmVF16qL/lmShL84CSXK2PoU6O
	 9ZFf3vIt3eJrlNMa6MipYeVi8Miyk7n4H/ntVwOAaqQe3YLANhkaRtsBVLs1TeBW1e
	 DFkr+/gRSztNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: defer freeing htab internal structs to workqueue
 to fix sleep-in-atomic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luo Gengkun" <luogengkun2@huawei.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606022827.3553277-1-luogengkun2@huawei.com>
References: <20260606022827.3553277-1-luogengkun2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 02:36:47 +0000
Message-Id: <20260606023647.6D1D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Incorrect `container_of` usage in `htab_map_free_internal_stru=
cts_deferred` computes an invalid map pointer, leading to severe memory cor=
ruption and kernel panic.
- [High] Unbalanced `bpf_map_inc()` when `schedule_work()` returns false ca=
uses a permanent map reference leak.
- [High] Deferring the clearance of hash map internal structs to a workqueu=
e creates a data race where active timers/kptrs can be wrongly destroyed if=
 the map is concurrently resurrected.

Pre-existing issues:
- [High] Unsafe non-RCU list traversal under RCU read lock allows concurren=
t modifications to cause data races and torn pointers.
--

commit 8d67520d6573d4b74187481274921ee2cb635076
Author: Luo Gengkun <luogengkun2@huawei.com>

bpf: defer freeing htab internal structs to workqueue to fix sleep-in-atomic

This commit reverts commit 4f375ade6aa9 to restore VFS RCU protection, and
defers the freeing of htab internal structs to a workqueue. This avoids a
sleep-in-atomic bug that occurs when calling cond_resched() inside an RCU
grace period.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4f..6d6f1faeec67a 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -102,6 +102,7 @@ struct bpf_htab {
>  	u32 n_buckets;	/* number of hash buckets */
>  	u32 elem_size;	/* size of each element in bytes */
>  	u32 hashrnd;
> +	struct work_struct work;
>  };

[ ... ]

> @@ -1606,18 +1610,27 @@ static void htab_free_malloced_internal_structs(s=
truct bpf_htab *htab)
>  	rcu_read_unlock();
>  }

[Severity: High]
This is a pre-existing issue, but looking at the function
htab_free_malloced_internal_structs() ending here:

Is it safe to use hlist_nulls_for_each_entry() inside the RCU read lock?

While the map's usercnt is zero, attached BPF programs can still execute in
parallel and modify the map. Since hlist_nulls_for_each_entry() does not use
rcu_dereference(), couldn't concurrent modifications cause torn pointers
and lead to data races or infinite loops?

Should this use hlist_nulls_for_each_entry_rcu() instead?

> -static void htab_map_free_internal_structs(struct bpf_map *map)
> +static void htab_map_free_internal_structs_deferred(struct work_struct *=
work)
>  {
> +	struct bpf_map *map =3D container_of(work, struct bpf_map, work);
>  	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);

[Severity: Critical]
Is the container_of macro calculating the correct map pointer here?

The work item was initialized using &htab->work, but here it is cast via
container_of(work, struct bpf_map, work). Since 'work' is a member of
struct bpf_htab and not struct bpf_map, doesn't this shift the map pointer
into the middle of the struct instead of its start?

Could this lead to memory corruption when bpf_map_put(map) is subsequently
called with the invalid pointer?

Should this be calculated as:
	htab =3D container_of(work, struct bpf_htab, work);
	map =3D &htab->map;

> -	/* We only free internal structs on uref dropping to zero */
> -	if (!bpf_map_has_internal_structs(map))
> -		return;
> -
>  	if (htab_is_prealloc(htab))
>  		htab_free_prealloced_internal_structs(htab);
>  	else
>  		htab_free_malloced_internal_structs(htab);
> +	bpf_map_put(map);
> +}
> +
> +static void htab_map_free_internal_structs(struct bpf_map *map)
> +{
> +	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
> +	/* We only free internal structs on uref dropping to zero */
> +	if (!bpf_map_has_internal_structs(map))
> +		return;
> +
> +	bpf_map_inc(map);
> +	schedule_work(&htab->work);

[Severity: High]
What happens if schedule_work() returns false?

A userspace program could repeatedly fetch the map via BPF_MAP_GET_FD_BY_ID
and close the file descriptor. Each closure drops usercnt to 0, triggering
this function.

Since bpf_map_inc() is called unconditionally, but schedule_work() returns
false if the work is already pending, won't this result in unbalanced
reference counts and permanently leak the BPF map?

[Severity: High]
Does deferring this operation to a workqueue introduce a race condition?

When usercnt reaches zero, we queue the internal structs (like timers and
kptrs) for deletion. Because map->refcnt can still be positive, can't
userspace immediately resurrect the map via BPF_MAP_GET_FD_BY_ID, bumping
usercnt back above zero?

If new timers or kptrs are then inserted, won't the deferred work eventually
run and indiscriminately destroy the internal structs of a now-active map?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606022827.3553=
277-1-luogengkun2@huawei.com?part=3D1
