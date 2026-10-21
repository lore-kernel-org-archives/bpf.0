Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583346;
	b=UZWdQcvRgt2pcrE0Nrzg7UcyaPaZp3erSiUaN0k4W7d+sz/ps/5B1k/39OkDOk4hpyE5
	 qCG5QYZP+RO+uMaczn53cEW8V9O6axtR6vzesnZNTHePH4JwJcagiHW3NWiLLuthZ6b7b
	 zEj6t/8cOyXsTjow8lbl4Ej4uHFl7VuwFw0TfVzP/7pM3iIIbFwGwj4kCZn+Q0B0RqyPu
	 3Gc0ab5Ir+r9UgF71+AWZhv4HSVKTgMJFXVO+3mVnMPtxLSnTnwc6jjYmpzKQAwy1hLxc
	 eFEQ99exhsVg8m5pEJlKJEC6EC+o2XameMkQc9WfrFGmAPqzgvtQQ6vUoLromJVf7Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583346;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FervRqDx8i9jzj8UVggEaA9nHNLpP+QF2H9C8Xb5FdU=;
	b=5q4yRs50mI41C/5YdZNZJAtp/wOffaLiI4O5skY8lyzHAOA3G+QdmW8OrstMR4hGoYAE
	 7GG/fKC1S/+yBkpbW/Ee6wYfCFnE4aCThTsQVVDmYFWTb0fjatvrfgpXg7+zHCgyqufuA
	 381YGyEiDbbgxGxN67dzVy1dz+40oc+vWCkBA6LwjFn35LIlUU1YtUeDqZ92j+Xf4lrXZ
	 bcaWK8iXIaewsFH70TggjmxsKDZlzLaKqvpe11Kbj3ReoKOTLAJ3NWbypZozXYzd8D0g4
	 QwwGs4bhO+edg6rX1mImkqL/e60U2JnmHzLdVD1HjrQ75XQmDOgd9RVbvsviTFUQO2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmZOMLDU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389C606A331
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmZOMLDU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C721F000C5;
	Wed, 21 Oct 2026 11:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583345;
	bh=FervRqDx8i9jzj8UVggEaA9nHNLpP+QF2H9C8Xb5FdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmZOMLDUUQi0UwuwJGYhc9GR1OTOG2SutD/x/jgPrcaIL46oWA5tCp2xIyhyNlwva
	 +Rsq+OgnE7TjUoFVs4kYE+5B3ThhbO0lUX5GC4T2ZL3DoA105twL/Y4IWqAMG1Z6f2
	 LESWTrO/APG+sllWvl8QqlqKLe9sASl5Fmi8yFjWPReZC0T1z2T5+iHLsxD8I48j1D
	 Gycm1PPJxlRckBfdAcl5z/ehkoo51hHBfQThehypbdBv6pRe/N80Mr0WHPqq499orI
	 7v59VjjYx8SfwqS+bkT8Ug/7e8+mFvUHZJhq+n5H2H/Wci0HaieYHkwQLx3meB7fNA
	 BkRIe/7NPcSiA==
Message-ID: <sashiko-outbox-180181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] mm/page_owner: add open-coded page_owner
 iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261021112437.1799213-5-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
 <20261021112437.1799213-5-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:49:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] mm/page_owner: forged handle and stack UAF in bpf_page_owner_s=
tack_snprint()
- [High] mm/page_owner: bpf_iter_page_owner_next() violates sticky-NULL con=
tract
- [High] mm/page_owner: buf__uninit in bpf_page_owner_stack_snprint() poiso=
ns stack
--

commit c92f39f3d2ecdefdc5191d503168d482f4fadf55
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add open-coded page_owner iterator

This commit introduces an open-coded BPF iterator for page_owner using
bpf_iter_page_owner_new(), bpf_iter_page_owner_next(), and
bpf_iter_page_owner_destroy(), along with the bpf_page_owner_stack_snprint()
kfunc to format the current page's allocation stack trace into a buffer.

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> index 529b2c4a589a9..4b9741a2de53c 100644
> --- a/mm/page_owner_iter.c
> +++ b/mm/page_owner_iter.c
[ ... ]
> @@ -116,3 +117,66 @@ int page_owner_iter_register(void)
[ ... ]
> +__bpf_kfunc struct page_owner_scan *
> +bpf_iter_page_owner_next(struct bpf_iter_page_owner *it)
> +{
> +	struct bpf_iter_page_owner_kern *kit =3D (void *)it;
> +
> +	if (!static_branch_unlikely(&page_owner_inited))
> +		return NULL;
> +
> +	cond_resched();
> +
> +	kit->scan.pfn++;
> +	if (!page_owner_next_eligible(&kit->scan))
> +		return NULL;

[Severity: High]
In kernel/bpf/verifier.c:process_iter_next_call(), once a KF_ITER_NEXT kfunc
returns NULL and transitions the iterator to BPF_ITER_STATE_DRAINED, the
verifier assumes any subsequent call on the same iterator also returns NULL
and marks BPF_REG_0 as constant scalar 0:

	cur_iter->iter.state =3D BPF_ITER_STATE_DRAINED;
	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);

However, mm/page_owner.c:page_owner_next_eligible() iterates using a local
pfn variable and only updates scan->pfn when an allocated page is reached:

	unsigned long pfn =3D scan->pfn;
	...
	for (; pfn < max_pfn; pfn++) {
		...
		scan->pfn =3D pfn;
		scan->po_snap =3D *page_owner;

When the loop reaches max_pfn without finding an eligible page, it returns
false while leaving kit->scan.pfn at the previously matched PFN plus one (or
min_low_pfn if no page matched).

If a BPF program calls bpf_iter_page_owner_next() again after it has return=
ed
NULL, kit->scan.pfn++ advances from that earlier PFN and rescans up to
max_pfn. Because the scan is lockless and calls cond_resched(), a concurrent
allocation in that tail PFN range (or max_pfn increasing via memory hotplug)
can cause bpf_iter_page_owner_next() to return a non-NULL &kit->scan pointer
at runtime when the verifier tracks R0 as scalar 0.

Should bpf_iter_page_owner_next() latch the drained state (or set
kit->scan.pfn to max_pfn on exhaustion and check it before incrementing) so
that subsequent calls cannot rescan or return non-NULL?

> +
> +	return &kit->scan;
> +}
> +
> +__bpf_kfunc void bpf_iter_page_owner_destroy(struct bpf_iter_page_owner =
*it)
> +{
> +}
> +
> +__bpf_kfunc int bpf_page_owner_stack_snprint(struct page_owner_scan *sca=
n,
> +					     char *buf__uninit, u32 buf__sz)

[Severity: High]
In mm/page_owner_iter.c:bpf_page_owner_stack_snprint(), the buffer argument
is annotated as buf__uninit paired with buf__sz.

In kernel/bpf/verifier.c:check_kfunc_args(), the __uninit suffix is only
handled for KF_ARG_PTR_TO_DYNPTR, whereas a KF_ARG_PTR_TO_MEM and
KF_ARG_MEM_SIZE pair is validated with BPF_READ | BPF_WRITE and raw_mode set
to false:

	ret =3D check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
				 BPF_READ | BPF_WRITE, true, meta, &failure);

At the same time, the static stack liveness pass in
record_arg_access() -> bpf_kfunc_stack_access_bytes() checks
is_kfunc_arg_uninit() and returns -size for buf__uninit:

	if (is_kfunc_arg_uninit(btf, &args[arg]))
		return -size;

In kernel/bpf/liveness.c:record_stack_access_off(), a negative access_bytes
marks all covered stack slots as must_write (dead prior to the call), even
though bpf_page_owner_stack_snprint() only writes up to len + 1 bytes. At a=
ny
state-pruning checkpoint before the call (such as inside a
bpf_iter_page_owner_next() loop), __clean_func_state() marks those dead sta=
ck
slots with STACK_POISON, causing check_mem_size_reg() ->
check_stack_range_initialized() to reject the BPF program with -EACCES.

Could buf__uninit be renamed to buf (or changed to an interface where the
verifier and stack liveness pass agree on initialization semantics) so that
passing a stack buffer in an iterator loop is not rejected?

> +{
> +	int len =3D 0;
> +
> +	if (!buf__uninit || !buf__sz)
> +		return 0;
> +
> +	if (static_branch_unlikely(&page_owner_inited))
> +		len =3D stack_depot_snprint(scan->po_snap.handle, buf__uninit,
> +					  buf__sz, 0);

[Severity: Critical]
In mm/page_owner_iter.c:bpf_page_owner_stack_snprint(), scan->po_snap.handle
is passed directly to stack_depot_snprint() -> stack_depot_fetch() ->
depot_fetch_stack(). In lib/stackdepot.c:depot_fetch_stack(), the handle is
assumed to be a valid stackdepot handle:

	if (pool_index >=3D pools_num_cached) {
		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
		     pool_index, pools_num_cached, handle);
		return NULL;
	}
	...
	stack =3D pool + offset;
	if (WARN_ON(!refcount_read(&stack->count)))
		return NULL;

An arbitrary handle value can trigger WARN() on an out-of-range pool_index =
or
zero refcount, or point stack at an arbitrary offset inside
stack_pools[pool_index] where a forged stack->size causes
stack_trace_snprint() to read out of bounds past the end of the pool.

There are two ways a BPF program can supply an arbitrary scan->po_snap.hand=
le
and corrupt or retain stack memory:

1. Because struct page_owner_scan and struct page_owner in mm/page_owner.h
contain only scalar fields and char comm[TASK_COMM_LEN],
__btf_type_is_scalar_struct() returns true. In
kernel/bpf/verifier.c:check_kfunc_args(), when a non-BTF pointer such as
PTR_TO_STACK or PTR_TO_MAP_VALUE is passed as struct page_owner_scan *scan,
the verifier falls back to fixed-size memory and accepts arbitrary
BPF-controlled bytes:

	if (!__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
		...
		return -EINVAL;
	}
	kf_arg_type =3D KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
	fallthrough;

2. In mm/page_owner_iter.c:bpf_iter_page_owner_next(), the returned
&kit->scan pointer aliases the on-stack struct bpf_iter_page_owner slots as
PTR_TO_BTF_ID | PTR_TRUSTED. In kernel/bpf/verifier.c:check_kfunc_call(),
regs[BPF_REG_0].parent_id =3D meta.ref_obj.id is only set in the
!__btf_type_is_struct(ptr_type) branch, not in the PTR_TO_BTF_ID branch:

		if (meta.ref_obj.id) {
			err =3D validate_ref_obj(env, &meta.ref_obj);
			if (err)
				return err;
			regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;
		}

		if (is_kfunc_rcu_protected(&meta))
			regs[BPF_REG_0].type |=3D MEM_RCU;
	} else {
		enum bpf_reg_type type =3D PTR_TO_BTF_ID;

Because parent_id remains 0 on the returned scan pointer, calling
bpf_iter_page_owner_destroy() marks the iterator stack slots STACK_INVALID
without invalidating registers holding scan. A BPF program can then reuse
those stack slots (spilling pointers or writing arbitrary scalars) and read
them back through scan or pass the overwritten scan->po_snap.handle to
bpf_page_owner_stack_snprint().

Can this be avoided by keeping the stackdepot handle internal to the opaque
struct bpf_iter_page_owner state (having bpf_page_owner_stack_snprint() take
struct bpf_iter_page_owner *it) and tying the lifetime of the pointer
returned by bpf_iter_page_owner_next() to the iterator's ref_obj_id?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021112437.1799=
213-1-zhen.ni@easystack.cn?part=3D4
