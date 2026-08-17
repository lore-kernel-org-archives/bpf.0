Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729F46A601
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988177; cv=none; b=JX5AhOyaEwajJ0186ZyxdiGbz57u+kqC/ZnI8z6rSzL3THhcfYT43N3zAtgFpIkWPTNTVyk9iVAZ/kXOyXXbHj843APuCYHFZApgz91ifexticHxX6NP2hdWU5OwwEGXKo2n/uJn9fHffvyudz8XUa21Gy8i4oC4XPLlUN37tG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988177; c=relaxed/simple;
	bh=ULdoJc+SPYLWLbTkpihaXXsyf1JSYfckoHedcJWQqf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YB9cE2C4XX5co6wfBWKTSrg0huY61OBfgjROsWtJvolgDiMsPJBxv1WjG2chJDVkLAtppbwL0BujoNE2QJ3h3NMkfmj9LHL/179uOgfLSofUnfQ1Vo46sODJwPi9Fza5yGAbW8M7tkE1rTJOZR8LQPUgAm9CIvszCbc1mzzOyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCxNdOOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCxNdOOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59EE1F000E9;
	Mon, 17 Aug 2026 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786988175;
	bh=CoekG0a3uNSGXf4IkS2/4//XmpC00cK/0oFy3wlviwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCxNdOOc+qEu/9biGAnPH+0DRu6xrsXqCh3DSiuChl+iwnlkbLApaIEY7PecWzlky
	 yvwrYO+UI2G2kl4yC5a6xFO59mUtoc3mMGCbSv061p/pXBjTOVgiuEddx4MI444etO
	 KJLkK5nksmLo2/Ic5dEV+OSNL5jskSygr7MQX+6Z7DZbx9biiQXakaSgQZmnMuE7nb
	 rt9VeMXybkVQAXwi/aoW8pkg5O3nTHH9jRjejP2uznflcYBRgL7VUl0gZDHwcxlCG3
	 67ZsQ2uu/qxPW2WMJq5OpaDHoyNUgDKrH7PzbfmjCxxhIl0n/yE3J9n7h6lRg40b53
	 MI5OW6Tmapntg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] locking/lockdep: Fallback to folio_pool in
 alloc_list_entry when static pool is full
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-folio-pool-v1-v1-6-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-6-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:36:14 +0000
Message-Id: <20260817173614.C59EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Atomic context violation and RT-deadlock in lockdep dynamic alloca=
tion.
- [High] Use-After-Free and memory leak due to untracked dynamic lock depen=
dencies.
- [Low] Undefined behavior in pointer arithmetic for dynamically allocated =
lock entries.
--

--- Patch [6]: [PATCH 6/9] locking/lockdep: Fallback to folio_pool in alloc=
_list_entry when static pool is full ---
commit 618b3b19dc7c789afe3ea0f17bf4c674f06ef1f3
Author: Jim Cromie <jim.cromie@gmail.com>

locking/lockdep: Fallback to folio_pool in alloc_list_entry when static poo=
l is full

Use struct folio_pool to dynamically expand lock dependency storage when
the static list_entries pool is exhausted, avoiding premature lockdep
disabling.

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 2d4c5bab5af88..f0f58db090fff 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
[ ... ]
> @@ -1404,11 +1429,19 @@ static struct lock_list *alloc_list_entry(void)
>  				      ARRAY_SIZE(list_entries));
> =20
>  	if (idx >=3D ARRAY_SIZE(list_entries)) {
> +		struct lock_list *p;
> +
> +		p =3D folio_pool_alloc_type(&lockdep_pool, struct lock_list,
> +					  GFP_ATOMIC);

[Severity: High]
Does dynamically allocating via folio_pool while holding a raw spinlock
violate atomic context rules?

alloc_list_entry() is called by add_lock_to_list() during lockdep graph upd=
ates,
which always run under the raw lockdep_lock (via graph_lock()).

Even with GFP_ATOMIC, folio_pool_alloc_type() acquires a standard spinlock_t
(sp->lock) and can call into the page allocator. On PREEMPT_RT, acquiring a
sleepable spinlock_t or calling the page allocator from within a raw spinlo=
ck
section causes a kernel panic (sleeping in atomic context). On non-RT kerne=
ls,
calling the allocator inside lockdep's graph lock violates its strict
non-reentrancy rules, which risks deadlocks if the allocator triggers warni=
ngs
or console output.

> +		if (p) {
> +			nr_list_entries++;
> +			return p;
> +		}

[Severity: High]
Could these dynamically allocated lock entries cause a use-after-free and
memory leak when modules are unloaded?

Dynamically allocated dependencies are not tracked in the list_entries_in_u=
se
bitmap.

When a module is unloaded, zap_class() unlinks dependencies:

kernel/locking/lockdep.c:zap_class() {
    ...
	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
		entry =3D list_entries + i;
		if (entry->class !=3D class && entry->links_to !=3D class)
			continue;
		__clear_bit(i, list_entries_in_use);
		nr_list_entries--;
		list_del_rcu(&entry->entry);
	}
    ...
}

Because dynamic entries aren't in this bitmap, zap_class() will skip them
and fail to unlink them from class->locks_after and class->locks_before.
When the module's memory is freed, lockdep retains dangling pointers to
the module's lock structures. Furthermore, the folio_pool bump allocator
does not support freeing individual elements, making the leaked
dependencies permanently unrecoverable.

[Severity: Low]
Could this result in undefined behavior when logging lock errors?

When lockdep detects a structural mismatch, it prints an error using pointer
subtraction:

kernel/locking/lockdep.c:class_lock_list_valid() {
    ...
	list_for_each_entry(e, h, entry) {
		if (e->links_to !=3D c) {
			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s",
			       c->name ? : "(?)",
			       (unsigned long)(e - list_entries),
    ...
}

If the entry e was dynamically allocated via folio_pool, it does not reside
within the static list_entries array. Subtracting pointers from different
memory objects is undefined behavior and produces a nonsensical array
index in the log.

>  		if (!debug_locks_off_graph_unlock())
>  			return NULL;
> =20
>  		nbcon_cpu_emergency_enter();
> -		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
> +		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low and folio_pool exh=
austed!");
>  		dump_stack();
>  		nbcon_cpu_emergency_exit();
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D6
