Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD11C861D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203046; cv=none; b=p56QJlJ9tLrPhIUBA+GDuoRycqa1ZuwK4bvwCsKhMMjLlHgXLwozWHnZjn5M7F2CnAfY/DAtrAFGeRKqlG0adY3L66nB0KjqyPABPHta6OObOmjgDbbdxm/RWW6I06/pqtNrk0/Em8SiMoVi3TPmafk5QqUbgKX63Y7TwLROIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203046; c=relaxed/simple;
	bh=TuJBEz50TxvhRzr4yvXD1FuX6AlixrVEzjdQt60iS/A=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=bO7iUZFsHnP/hB8ei5aMuQKZG72U2nvuhpc3QC/mJIwRzsUbmZUskCXwv4/hes8bLK53XCgnMHIT0fKRlGMrtqQ8drTLpOKyldmwgiVLlWhmBOdlnm5pneZj2glENRXcun3PFymfmFH7ba5kAy7gMo/BbsYcchnb6nfvRNH+Ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCvbeWhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCvbeWhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEE31F000C4;
	Sat, 17 Oct 2026 02:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792203044;
	bh=yE3PXSQgdYA+/TW+sIymBwIa7dAoaEbYGir9lmMy/c0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GCvbeWhrFrsbJn+BmZihSkNQLNeazbZdxSN+qriHDs5GOUyq1TuT2Jj1XXDNerhNz
	 7s7RnpYdbag1+dTlfJaON0eLt297JEDxvu529QNHWTUnUxf5WuGxwd41MVQlDrZ6cA
	 2ZSKfI7kmfPeHD/JnrvE6T+4BSapuKFdr80PiL9TVwojs1ypVNFtjtzjMJgByivMj5
	 C9juWaR64ik8Me+ObYZH8SuAWE75E9lkvI0KcAqvnFTp34I8FMHAtfwCbR+NT9AIpO
	 75bQGGwTDOpWCWqCmxhFA8WdUFq960w/SbqnuQG3VmN3apqusCsDaOWg0yaF6loVKX
	 lk+8kFP4zh2xA==
Message-ID: <sashiko-outbox-175195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 29/38] bpf: Keep values of a dead owner for
 sleepable programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-21-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-21-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:10:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: premature bpf_obj_free_fields() in bpf_selem_unlink_nofai=
l()
- [High] bpf: uncounted sleepable users in bpf_selem_unlink_nofail() via fr=
eplace
--

commit 8642076a3bb10a2ade07f6d402a14e8067337799
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Keep values of a dead owner for sleepable programs

This patch defers freeing local storage elements behind an RCU Tasks Trace
grace period when an owner is destroyed if the storage map has sleepable
users or has been used as an inner map.

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index f234f671e75f8..3d0c455d258c2 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -352,7 +352,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *s=
elem)
>  static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
>  				    struct bpf_local_storage_map_bucket *b)
>  {
> -	bool in_map_free =3D !!b, free_storage =3D false;
> +	bool in_map_free =3D !!b, free_storage =3D false, sleepable_users =3D f=
alse;
>  	struct bpf_local_storage *local_storage;
>  	struct bpf_local_storage_map *smap;
>  	unsigned long flags;
> @@ -362,6 +362,10 @@ static void bpf_selem_unlink_nofail(struct bpf_local=
_storage_elem *selem,
>  	smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
> =20
>  	if (smap) {
> +		/* A map that is freed, or NULL here, has no program left. */
> +		sleepable_users =3D !in_map_free &&
> +				  (atomic64_read(&smap->map.sleepable_refcnt) ||
> +				   READ_ONCE(smap->map.was_inner_map));

[Severity: High]
Can a BPF_PROG_TYPE_EXT (freplace) program extending a sleepable target
program bypass this sleepable_users check and trigger a slab use-after-free
on SDATA(selem)->data?

In kernel/bpf/verifier.c:can_be_sleepable(), BPF_F_SLEEPABLE is rejected for
BPF_PROG_TYPE_EXT programs, so ext_prog->sleepable is always false:

kernel/bpf/verifier.c:can_be_sleepable() {
	if (prog->type =3D=3D BPF_PROG_TYPE_TRACING) {
		...
	}
	if (prog->type =3D=3D BPF_PROG_TYPE_LSM)
		return prog->expected_attach_type !=3D BPF_LSM_CGROUP;

	return prog->type =3D=3D BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
	       prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS ||
	       prog->type =3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT ||
	       prog->type =3D=3D BPF_PROG_TYPE_TRACEPOINT;
}

When maps are bound to ext_prog in __add_used_map() or bpf_prog_bind_map(),
map->sleepable_refcnt is only incremented if bpf_prog_runs_sleepable(prog)
is true.

However, check_attach_btf_id() and __bpf_trampoline_link_prog() allow a
non-sleepable BPF_PROG_TYPE_EXT program (where ext_prog->aux->might_sleep is
false) to replace the main entry or a global subprogram of a sleepable
target program (where tgt_prog->sleepable is true) without propagating
sleepable status or incrementing map->sleepable_refcnt on ext_prog's
used_maps:

kernel/bpf/verifier.c:check_attach_btf_id() {
	if (tgt_prog && prog->type =3D=3D BPF_PROG_TYPE_EXT) {
		env->ops =3D bpf_verifier_ops[tgt_prog->type];
		prog->expected_attach_type =3D tgt_prog->expected_attach_type;
	}
}

At runtime, tgt_prog enters via __bpf_prog_enter_sleepable() or
__bpf_prog_enter_sleepable_recur(), which only acquires
rcu_read_lock_trace() and migrate_disable(), and jumps directly into
ext_prog->bpf_func.

If ext_prog looks up a value from a local storage map bound only to ext_prog
(so sleepable_refcnt is 0 and was_inner_map is false) via
bpf_task_storage_get() and then releases the owner or exits
bpf_rcu_read_unlock(), bpf_local_storage_destroy() ->
bpf_selem_unlink_nofail() will see sleepable_users =3D=3D false and free se=
lem
via kfree_rcu() while ext_prog still accesses SDATA(selem)->data.

>  		b =3D b ? : select_bucket(smap, local_storage);
>  		err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
>  		if (!err) {
> @@ -434,11 +438,12 @@ static void bpf_selem_unlink_nofail(struct bpf_loca=
l_storage_elem *selem,
>  	 *
>  	 * The owner that map_free() takes an selem from is alive: sleepable co=
de, which
>  	 * is in no RCU read side critical section, may be walking its list for=
 another
> -	 * map.
> +	 * map.  And it can still use a value that it got before it let go of a=
n owner
> +	 * that destroy() is called for.
>  	 */
>  	if (unlink =3D=3D 2 ||
>  	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) =3D=3D =
SELEM_UNLINKED)
> -		bpf_selem_free(selem, !in_map_free);
> +		bpf_selem_free(selem, !in_map_free && !sleepable_users);

[Severity: Critical]
When sleepable_users is true, bpf_selem_free() defers freeing selem to
bpf_selem_free_trace_rcu() because a sleepable program may still be reading
or writing SDATA(selem)->data.  However, earlier in
bpf_selem_unlink_nofail(), bpf_obj_free_fields() is still called
immediately under b->lock and SDATA(selem)->smap is cleared to NULL:

kernel/bpf/bpf_local_storage.c:bpf_selem_unlink_nofail() {
		err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
		if (!err) {
			if (likely(selem_linked_to_map(selem))) {
				hlist_del_init_rcu(&selem->map_node);
				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
				unlink++;
			}
			raw_res_spin_unlock_irqrestore(&b->lock, flags);
		}
		WARN_ON_ONCE(err && in_map_free);
		if (!err || in_map_free)
			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
}

Doesn't calling bpf_obj_free_fields() before the RCU Tasks Trace grace
period cause a physical page use-after-free for BPF_UPTR fields and a kptr
leak for BPF_KPTR_REF or BPF_KPTR_PERCPU fields?

For a BPF_MAP_TYPE_TASK_STORAGE map with a BPF_UPTR field:

1. A sleepable program obtains SDATA(selem)->data (or loads the uptr's
   PTR_TO_MEM register via mark_uptr_ld_reg()) and releases the task
   reference or exits bpf_rcu_read_unlock().

2. When the task exits, free_task() -> bpf_task_storage_free() ->
   bpf_local_storage_destroy() -> bpf_selem_unlink_nofail() runs after
   exit_mm() has already unmapped the task's user address space.

3. bpf_obj_free_fields() immediately calls unpin_uptr_kaddr() ->
   unpin_user_page(virt_to_page(kaddr)) without waiting for the RCU Tasks
   Trace grace period and without clearing the pointer in SDATA(selem)->dat=
a,
   dropping the last reference to the physical page while the sleepable
   program can still read and write to it.

Similarly, for BPF_KPTR_REF or BPF_KPTR_PERCPU fields, the running sleepable
program can store a new kptr into SDATA(selem)->data via bpf_kptr_xchg()
after bpf_selem_unlink_nofail() has already called bpf_obj_free_fields() and
set SDATA(selem)->smap to NULL.  When bpf_selem_free_trace_rcu() later runs
after the RCU Tasks Trace grace period:

kernel/bpf/bpf_local_storage.c:bpf_selem_free_trace_rcu() {
	smap =3D rcu_dereference_check(SDATA(selem)->smap, 1);

	if (smap)
		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
	kfree(selem);
}

SDATA(selem)->smap is already NULL, so bpf_selem_free_trace_rcu() skips
bpf_obj_free_fields() and leaks the newly exchanged kptr.

> =20
>  	if (free_storage)
>  		bpf_local_storage_free(local_storage, !in_map_free);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D29
