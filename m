Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1734261B9E
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466918; cv=none; b=n1Qw7ehB2u4BNcqnRcPXIiouDaVWAY7gsWuQNF2LH6A96CosBnexFKitv0a2ARfysHePyiWH4RcGEIZNcxTKlCeIadV6spMr7btrZVLy49cefAPg7ModT1UIUDPXeYF1eBuDhJDpOY8+hYXi8ezOSFnomFJ49UF7yqeuWISFqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466918; c=relaxed/simple;
	bh=w5qG3jSaIxMhTZhaQQ1xBbH60hJxBlzcv+N3c1sKcgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SL1Cg14ylqB4lBcAgIrM39NB37SKtexEKE8hzpLp3Neq6yHIJ6kbOo3YmdL8+98YOToaXKE35XpnSKvmMHx/s64CqKOqzZi25PSHzlztxSbf8UfJ64X67b/UDT/rM2FzybaTxDR2fRZnV2+KRs62jHoDYyXxrdeWf0Y0wKZUIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz3vk0VL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz3vk0VL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EAA1F000FF;
	Sat, 26 Sep 2026 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466916;
	bh=RTn9oGpiBkDrlbwcXX7ioUFWt4ll3ytnng7IodvfUlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dz3vk0VLQ2dKjTQrf+U6H1Y2vhX0+rJICiSFhngPk5tsLeuQH/JUBacPmsBksDa5W
	 LPS8WzjRCnb8JCK/qHj6Yvs1eCFRWHViw1o0aid0vxFxYzQ1DcBPZVlKUb9rh8IRkm
	 i90khCj8bJxtsd7+RGNazVKcUdTmLkUG9qR0TQ0qs+4jb95paXXSiDk1X4N+oWk+Gv
	 t/hf0q84q01lxR/juzixURmM+UAMC1L/iY1MGzTzoFTQnrny8tQPEdiFdqNVztjjQ4
	 YTSZfozbmhKjECZYlhYAOaSKY/rx9VNevwuRtNuWLS4iuVDsI8899VcczoPlV65k6P
	 OtLqfZsZBKn9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 09/16] bpf: Add typed arena page
 allocation and release kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-10-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-10-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:55:15 +0000
Message-Id: <20260926235516.28EAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] bpf: stale TLB use-after-free window in allocation error path
- [High] bpf: uninitialized kernel memory leak via arena page allocation
- [High] bpf: TLB shootdown race due to premature state publication
- [High] bpf: TOCTOU vulnerability via double fetch of user-provided page_c=
nt
- [High] bpf: state machine corruption race between worker and page fault h=
andler
- [Medium] bpf: memory leak when resilient spinlock acquisition fails
- [Medium] bpf: incorrect memcg charging in tracking struct allocation
--

commit fcd33d7dbae3719eae8ea173b7e1a7f8cbe911c9
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add typed arena page allocation and release kfuncs

This patch introduces typed arenas for BPF programs, allowing them to
allocate and release contiguous memory regions mapped as real objects
rather than scratch pages. It exposes two new kfuncs,=20
bpf_typed_arena_alloc_pages() and bpf_typed_arena_free_pages(), which=20
interface with a lock-free page allocator and defer the release via RCU
workers.

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -686,6 +1045,8 @@ static unsigned long typed_arena_alloc_pages(struct bp=
f_typed_arena *ta, unsigne
 					     u32 *page_cnt, int node_id)
 {
[ ... ]
> +	if (node_id !=3D NUMA_NO_NODE &&
> +	    ((unsigned int)node_id >=3D nr_node_ids || !node_online(node_id)))
> +		return 0;
> +	if (!*page_cnt)
> +		return 0;
> +	chunk_cnt =3D DIV_ROUND_UP((unsigned long)*page_cnt, typed_arena_chunk_=
pages(ta));

[Severity: High]
Does this code introduce a TOCTOU vulnerability? Because page_cnt is a poin=
ter
to memory that can be shared with BPF programs or userspace, it could be
modified concurrently. If the value is changed to zero between the
if (!*page_cnt) check and the DIV_ROUND_UP() calculation, chunk_cnt will
evaluate to 0. This would cause bitmap_find_next_zero_area() to return 0 and
grant the BPF program a valid pointer to the arena's base address without
actually allocating any pages, potentially leading to memory corruption.

[ ... ]
> +	data.arena =3D arena;
> +	for (done =3D 0; done < chunk_cnt; done++) {
> +		head =3D alloc_pages_nolock(__GFP_ACCOUNT, node_id, order);
> +		if (!head) {

[Severity: High]
Does this allocation leak uninitialized buddy allocator memory?
The call to alloc_pages_nolock() omits the __GFP_ZERO flag. Since arena
memory is exposed to BPF programs (and potentially mapped to userspace),
untrusted code could read stale kernel data. Furthermore, during teardown,
the kernel might invoke bpf_obj_free_fields() on this uninitialized garbage,
which could lead to panics if random memory is treated as valid kptrs.

> +			ret =3D -ENOMEM;
> +			goto back_out;
> +		}
> +		data.head =3D head;
> +		data.start =3D start + (done << ta->chunk_shift);
> +		data.i =3D 0;
> +		ret =3D apply_to_page_range(&init_mm, data.start, chunk, apply_range_s=
et_typed_cb,
> +					  &data);
> +		if (ret) {
> +			/* The fault path took this chunk: give back the allocation whole. */
> +			cdata.arena =3D arena;
> +			cdata.ta =3D ta;
> +			if (data.i)
> +				apply_to_existing_page_range(&init_mm, data.start,
> +							     (unsigned long)data.i << PAGE_SHIFT,
> +							     apply_range_clear_typed_cb, &cdata);
> +			free_pages_nolock(head, order);
> +			goto back_out;
> +		}

[Severity: Critical]
Does this code clear PTEs and free physical pages before flushing the TLB?
When apply_to_page_range() returns -EBUSY, the partially installed PTEs are
cleared and the pages are immediately freed to the buddy allocator via
free_pages_nolock(). The actual TLB flush happens later at the back_out
label. This creates a window where freed pages can be reallocated
elsewhere in the kernel, while stale, writable VMA translations remain cach=
ed
in the TLB, allowing arbitrary memory overwrite.

[ ... ]
> +back_out:
> +	/*
> +	 * Back out the chunks installed before the one that failed. On -EBUSY
> +	 * that chunk is the one the fault path took, and it keeps its mark.
> +	 */
> +	init_llist_head(&freed);
> +	cdata.arena =3D arena;
> +	cdata.ta =3D ta;
> +	for (i =3D 0; i < chunk_cnt; i++)
> +		if (ret !=3D -EBUSY || i !=3D done)
> +			clear_bit(coff + i, ta->chunks);
> +	for (i =3D 0; i < done; i++) {
> +		cdata.head =3D NULL;
> +		apply_to_existing_page_range(&init_mm, start + (i << ta->chunk_shift),=
 chunk,
> +					     apply_range_clear_typed_cb, &cdata);
> +		if (cdata.head)
> +			__llist_add(&cdata.head->pcp_llist, &freed);
> +	}
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	flush_tlb_kernel_range(start, start + (chunk_cnt << ta->chunk_shift));

[Severity: High]
Does this sequence create a TLB shootdown race? By clearing the allocation
state bits (ta->chunks) and dropping the spinlock before calling
flush_tlb_kernel_range(), it creates a window where concurrent allocations =
can
immediately claim the chunk and expose new mappings. Other CPUs might retain
stale TLB translations to the old pages that are about to be freed, leading=
 to
silent data corruption or use-after-free conditions.

[ ... ]
> +static void typed_arena_free_pages(struct bpf_typed_arena *ta, unsigned =
long addr, u32 page_cnt)
> +{
[ ... ]
> +	first =3D off >> ta->chunk_shift;
> +	last =3D (off + ((unsigned long)page_cnt << PAGE_SHIFT) - 1) >> ta->chu=
nk_shift;
> +
> +	s =3D kmalloc_nolock(sizeof(*s), __GFP_ACCOUNT, NUMA_NO_NODE);

[Severity: Medium]
Does this structure allocation incorrectly charge the current context's mem=
ory
cgroup? Because this is a generic kfunc that can be invoked from arbitrary
execution contexts (like tracepoints or network packets), __GFP_ACCOUNT will
charge whichever random user task happens to be interrupted. Shouldn't this=
 be
wrapped with bpf_map_memcg_enter() and bpf_map_memcg_exit() to charge the
map's memcg?

> +	if (!s)
> +		/*
> +		 * The chunks stay allocated until the map is freed; nothing can
> +		 * be retried from here.
> +		 */
> +		return;
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +		goto free_span;
[ ... ]
> +	irq_work_queue(&arena->typed_free_irq);
> +	return;
> +
> +free_span:
> +	kfree_nolock(s);
> +}

[Severity: Medium]
Does failing to acquire the resilient spinlock cause a silent memory leak?
If raw_res_spin_lock_irqsave() fails (e.g., due to lock contention), the
tracking struct is freed and the function returns without error. The reques=
ted
chunks remain marked as taken indefinitely, but the BPF program assumes they
were successfully queued for release, leaking arena chunks until map teardo=
wn.

[ ... ]
> +static void typed_arena_free_worker(struct work_struct *work)
> +{
[ ... ]
> +		while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +			cpu_relax();
> +		for (i =3D 0; i < s->chunk_cnt; i++) {
> +			cdata.head =3D NULL;
> +			apply_to_existing_page_range(&init_mm, start + (i << ta->chunk_shift),
> +						     bpf_typed_arena_chunk(ta),
> +						     apply_range_clear_typed_cb, &cdata);
> +			if (cdata.head)
> +				__llist_add(&cdata.head->pcp_llist, &heads);
> +		}
> +		typed_arena_chunks_mark(ta, s->coff, s->chunk_cnt, false);

[Severity: High]
Does this create a destructive state machine race with the page fault handl=
er?
The worker clears the PTE mappings under the spinlock, but the page fault
handler (typed_arena_handle_page_fault()) runs locklessly. If a page fault
triggers on a cleared chunk just before typed_arena_chunks_mark(..., false)=
 is
called, the fault handler will install a scratch page and set the chunk bit.
The worker will then blindly force the bit to 0. The chunk becomes marked as
'free' but contains a scratch page, causing all future allocations of this
chunk to permanently fail with -EBUSY.

> +		bitmap_clear(ta->pending, s->coff, s->chunk_cnt);
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +		flush_tlb_kernel_range(start,
> +				       start + ((unsigned long)s->chunk_cnt << ta->chunk_shift));

[Severity: High]
Can this sequence lead to a TLB shootdown race? Similar to the allocation
error path, clearing the allocation state bits and dropping the spinlock
before flushing the TLB allows concurrent allocations to claim the chunks
while stale translations remain cached, introducing memory corruption risks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D9
