Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF434404E
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064737; cv=none; b=aJoq63QB3bRpqD/gPxuEC+s9/8g2GcfCOHC5DMmR38QMZzfysGXKk7gINXZtXEzlcrWNL0K2NjMxydD5/y552aIhmt3Off+RFN7lIbHKg63hhGqwzXmmMXgRpsb/QVDWJ+gC+PH2g1ljoXFV6zU5b0OS/KamS63XSPkBzmoTd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064737; c=relaxed/simple;
	bh=IkyzoOEdYPRGJEytdqcIvZFAjbCjtueEVnRmMOsPTM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QXcZhtK7Jnt0mm1t0C87ca46dawFkpZPSTAgeLdD+iFAlzTyRGrHUv533PBJxcXf9H8o0GMz1YKpcUQ3vyuAux/MhZVsQFlDdG5Nl9SfuuXlkgov0GJD9X4MANqgqgvNQxbd9CPQBHlLRfb5nWvmtkrgdU3Sxojf5f6B8owTUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7DjG3FK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7DjG3FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D82C19425;
	Fri, 24 Apr 2026 21:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777064737;
	bh=IkyzoOEdYPRGJEytdqcIvZFAjbCjtueEVnRmMOsPTM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=U7DjG3FKehP00e4k5pVg68HqLNhuxr6zOId55w0r89dbvzYCz0e3Mw2kt+fE4pE89
	 Qk76vk3wZIRSAnnsxvwLphPwal814rKzB6s3CJ17BjljDcC55IWBRWDJj3HV+CbjSz
	 PxoZEmH1K1/LMB6jNv+KSHSuRDUwZFOE3hjzNKe2nwNufG0h73qD+gG7COcqNkG6ru
	 4Izqh69/Xv73NZVv9VsA3c/FYAaQbAMyFL6Ab9WnKWKJr7uY3xG2y+26NqA3cW0lsw
	 E2y5M3j/9DLCq9WgbXOrESFApwVXoU31vBi442JULqZo7RzaKKvLL9ZkuENqv+8Etb
	 plE9fcTtnASKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 05/10] bpf: Allow timers, workqueues and
 task_work in resizable hashtab
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-rhash-v3-5-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-5-d0fa0ce4379b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 21:05:36 +0000
Message-Id: <20260424210537.57D82C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unbounded iteration over the entire hash table inside a single RCU=
 read-side critical section in `rhtab_map_free_internal_structs`.
- [High] Race condition in `rhtab_map_update_existing` allows concurrently =
initialized special fields (timers, kptrs) to survive map updates.
--

commit 1516bbfa3123276ce6abdd224ad40eb2ca633302
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Allow timers, workqueues and task_work in resizable hashtab

This commit allows resizable hashtab maps to support deferred callbacks by
enabling timers, workqueues, and task_work field types. It also wires up
bpf_obj_free_fields during element deletion and map teardown to properly
clean up BTF record fields.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 000caa2c7f4cd9..ba03797b896020 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -2945,11 +2944,15 @@ static int rhtab_map_lookup_and_delete_elem(struc=
t bpf_map *map, void *key, void
>  static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_=
elem *elem, void *value,
>  				      u64 map_flags)
>  {
[ ... ]
> +	/* Free special fields, and reuse memory similar to arraymap */
> +	rhtab_check_and_free_fields(rhtab, elem);
> +
>  	if (map_flags & BPF_F_LOCK)
>  		copy_map_value_locked(map, old_val, value, false);
>  	else
>  		copy_map_value(map, old_val, value);

Does calling rhtab_check_and_free_fields() before copy_map_value()
create a race condition with concurrent BPF programs?

If a concurrent program acquires the spinlock and initializes a new
timer or kptr right after rhtab_check_and_free_fields() finishes,
would those newly initialized special fields survive the update?
The subsequent copy_map_value() call intentionally skips special fields.

Should rhtab_check_and_free_fields() be called after the copy completes
to ensure no concurrent modifications survive the element update?

[ ... ]
> @@ -3033,6 +3037,25 @@ static struct rhtab_elem *rhtab_iter_next(struct r=
hashtable_iter *iter)
> =20
>  static void rhtab_map_free_internal_structs(struct bpf_map *map)
>  {
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhashtable_iter iter;
> +	struct rhtab_elem *elem;
> +
> +	if (!bpf_map_has_internal_structs(map))
> +		return;
> +
> +	/*
> +	 * An element can be processed twice if rhashtable resized concurrently.
> +	 * Special structs freeing handles duplicate cancel_and_free.
> +	 */
> +	rhashtable_walk_enter(&rhtab->ht, &iter);
> +	rhashtable_walk_start(&iter);
> +
> +	for (elem =3D rhtab_iter_next(&iter); elem; elem =3D rhtab_iter_next(&i=
ter))
> +		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_siz=
e));
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
>  }

Can this loop trigger RCU CPU stall warnings for large hash maps?

The function rhashtable_walk_start() explicitly acquires the RCU read lock,
meaning this entire iteration over potentially millions of elements occurs
inside a single RCU read-side critical section.

If the map contains many elements, looping without yielding could block
RCU grace periods for an extended time.

Would it be better to periodically drop the lock and yield, similar to
how other map structures handle large iterations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-rhash-v3-0=
-d0fa0ce4379b@meta.com?part=3D5
