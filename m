Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386D282F30
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988735; cv=none; b=qq3SgAGM/kuC/Ojclhge57ziwmocicRL1ooA3S3SyNt/T8W21S6wJJ694si72MKbmvnay3QFeGIT9Hl6OXqO/oZ2E2yZx1nA9JB2UuOt1gd1fhAsJR8AF1unwknFhJC/3wVswOc0lawEwQlr3dUNt+YGUamQvGxKazUvhPL5IxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988735; c=relaxed/simple;
	bh=LkY0Mu3r0aZcdPCuh5pn1odM7M6J7ERIuZkXsGF3VR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXy3DnBMZwK7Pb1huzIuNb1FC9rAhPZDnkq4Qk7hfPBUUdeAtMIUs2Yca785I+v89gu1bvsbsPtH4a46wgGEObYOEECs+AiL037JQq5k7bryDHaUhNIJxk8JSX21bZD3F1B7/VI9My+Ie0arVbppvODkcvExGcUZRexS6HKp3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkn1E/88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkn1E/88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B119D1F000E9;
	Mon, 17 Aug 2026 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786988731;
	bh=uUIQa4vKwDy93ZBecWhIbUIe9MDSR23rTM5YYiOU4/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkn1E/88VLTQuZ3NQLJHhNBr3mB4kkwJFZmTUsMEm8OAH6p2WlGDi5SvSC0LaclT3
	 SEambVTuDsTYDiNsjCd52LzDBJ60zMBKFRSU/yxWdUEfUOcS2C3edXu7jKijEJ34aX
	 bq7psj8aHyD9+FoMZCzggOZISq6R8q82GWTwzuj0tAKskhMeyoo6oaTG3u9W0PMwWx
	 Rs0AdjMx0f0B4dsB3MCTGWXroFtccF9zGGGmN2O/nZz4PeLG5mO3xY40U5nGEHqbvO
	 QWjQwueyYCvBgJ4yE8Q3IPskudvKytzIav2BLvQ08rV+xQ+829F7FQvdAyidjGXMRC
	 VqJPayoSiokTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] locking/lockdep: Migrate and compact boot-time
 dependency graph from __initdata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-folio-pool-v1-v1-9-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-9-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:45:31 +0000
Message-Id: <20260817174531.B119D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Invalid Wait Context on PREEMPT_RT and potential buddy allocator r=
ecursion.
- [High] Use-After-Free triggered by reading /proc/lockdep after boot compa=
ction failure.
- [High] Permanent memory leak of dynamically allocated lock graph edges on=
 module unload.
- [Medium] Integer underflow in global active edge counter `nr_list_entries=
`.
--

--- Patch [9]: [PATCH 9/9] locking/lockdep: Migrate and compact boot-time d=
ependency graph from __initdata ---
commit f7e00f7b01be3f305f806e2c70e4d05c87137496
Author: Jim Cromie <jim.cromie@gmail.com>

locking/lockdep: Migrate and compact boot-time dependency graph from __init=
data

This commit moves early boot lockdep nodes to __initdata and compacts them
into folio_pool allocations during late_initcall to save memory.

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 5968a976bf8ea..d9541207b342b 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c

[ ... ]

> @@ -6295,30 +6308,26 @@ static void zap_class(struct pending_free *pf, st=
ruct lock_class *class)
>  	list_for_each_entry_safe(entry, tmp, &class->locks_after, entry) {
>  		list_for_each_entry_safe(other, other_tmp, &entry->links_to->locks_bef=
ore, entry) {
>  			if (other->links_to =3D=3D class) {
> -				if (is_bootstrap_entry(other))
> -					__clear_bit(other - list_entries, list_entries_in_use);
> +				clear_bootstrap_entry_bit(other);
>  				nr_list_entries--;
>  				list_del_rcu(&other->entry);

[Severity: High]
Does this leak the dynamically allocated edges?

When lock classes are dynamically destroyed during module unload, zap_class=
()
unlinks their graph edges using list_del_rcu(). With folio_pool allocations,
there is no explicit kfree() or folio_pool_free_obj() called. Discarding the
pointers leaves the memory stranded, leading to a permanent memory leak unt=
il
the bump allocator is exhausted.

[ ... ]

> @@ -6733,12 +6745,101 @@ void __init lockdep_init(void)
>  static int __init lockdep_boot_report(void)

[ ... ]

> +static int __init lockdep_compact_boot_graph(void)
> +{
> +	struct lock_class *class;
> +	struct lock_list *entry, *tmp, *new_entry;
> +	unsigned long flags;
> +	unsigned long migrated =3D 0;

[ ... ]

> +	raw_local_irq_save(flags);
> +	if (!graph_lock()) {
> +		raw_local_irq_restore(flags);
> +		return 0;
> +	}
> +
> +	list_for_each_entry(class, &all_lock_classes, lock_entry) {
> +		list_for_each_entry_safe(entry, tmp, &class->locks_after, entry) {
> +			if (is_bootstrap_entry(entry)) {
> +				if (new_entry) {
> +					*new_entry =3D *entry;
> +					list_replace_rcu(&entry->entry, &new_entry->entry);
> +					new_entry =3D NULL;
> +				} else {
> +					struct lock_list *slot;
> +
> +					slot =3D folio_pool_alloc_type(&lockdep_pool,
> +								     struct lock_list,
> +								     GFP_ATOMIC);

[Severity: High]
Can this cause an invalid wait context panic on PREEMPT_RT?

The folio_pool_alloc_type() function is called here while holding
graph_lock(). Because graph_lock() acquires a raw spinlock with local IRQs
disabled, it cannot safely call into folio_pool_alloc_type().

Internally, folio_pool_alloc_type() acquires a standard spinlock_t, which
maps to a sleepable rt_mutex on PREEMPT_RT. Acquiring a sleeping lock inside
a raw spinlock context violates the wait context rules.

Additionally, if the pre-allocated chunk is exhausted, this could call
folio_alloc(), which takes sleepable MM zone locks and triggers the exact
recursion the pre-allocation was intended to avoid.

> +					if (!slot) {
> +						debug_locks_off_graph_unlock();
> +						raw_local_irq_restore(flags);
> +						pr_err("lockdep: folio chunk exhausted during boot compaction\n");
> +						return -ENOMEM;

[Severity: High]
Could this lead to a use-after-free when reading /proc/lockdep?

If folio_pool_alloc_type() fails, this error path disables lockdep and
aborts. However, the partially migrated dependency graph still contains
pointers to early_list_entries, which resides in the __initdata section.

When free_initmem() later reclaims the __initdata section, these pointers
become dangling.

If /proc/lockdep is read, l_show() unconditionally traverses the
class->locks_after list without checking if debug_locks is enabled, which
would dereference the freed init memory.

[ ... ]

> +		}
> +	}
> +
> +	/* Adjust counter so compaction does not double-count migrated nodes */
> +	nr_list_entries -=3D migrated;

[Severity: Medium]
Is this subtraction correct?

The compaction loop replaces boot nodes with new allocations directly from
folio_pool without incrementing nr_list_entries. Subtracting migrated from
nr_list_entries here reduces the counter even though the active edge count
remains unchanged.

When these dynamically allocated lock classes are later freed during module
unload, zap_class() unconditionally decrements nr_list_entries--, which will
cause the global counter to underflow.

> +
> +	bootstrap_entries =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D9
