Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C856373C1D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637894; cv=none; b=GfHcXgAMR9XQkSG7efI/hPMf1HLQk7RuJ5ohdAtVu0vpIDWLySaMaoCTMDtGMZSD7Xx/C1teTKVBR8eHX/lPvzRiWDDOVjPTo43p4Q0nRihyCj5O6UduL3rHAxervETzx8shEGMCX+h/TnXdYFK5JE5ZEjDFWlg7hxkOH+Hs8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637894; c=relaxed/simple;
	bh=iPx0Z6nqVtWLhmOq/r40I3iEdpITjG7agQPJNjU/QzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uykQW0sXp6GiecLIhntngG44JtbSA+HUxNYNVrHdP9EAKz60V5baEy2QNY+QK44NjXA3wlzmRDN5digbcxnp4XVDtHBUIMOwMg4uDAS86SY+LGNl/55E3LuIvcjUgU/NelQq8QJ46XaVlIy8i1SNxvhi0kJzyN7yE5QGfmcZmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EttbE3nV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EttbE3nV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1770CC2BCB0;
	Wed, 13 May 2026 02:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778637894;
	bh=iPx0Z6nqVtWLhmOq/r40I3iEdpITjG7agQPJNjU/QzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EttbE3nVNniKoxrTTn/f2md7MviFMpD4SwSlRPkBJidrSEdnl62442Y75tXhZ9CFC
	 Rf2MwF6JY7fs3jFJqy/FF2CQcnbhDutOIXjKvR1v1aU7/O/V0tJzKLGkXpPBOtd3df
	 dYKNGHeMBtIMfUBBWnhzsPK9TPUuzRic5yeNOBF7Icl5/zCokcPMbvLFApZTqn84Zc
	 To6gFPUP0Q+wm9jwUQR1Xt4Nqsd0neDXXA+JOxND+QgVBmfHmjDQpGEuLSSbQDiWMy
	 4SR7z0aC8iEniLG+Wba505OpIG9zpUvGYZx/Pgsz65ki3vA8mWk3TuHsb8CXClU/O3
	 wonjhwvNzehVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: libarena: Add Lev-Chase
 queue data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511210740.5395-3-emil@etsalapatis.com>
References: <20260511210740.5395-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:04:53 +0000
Message-Id: <20260513020454.1770CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Missing acquire memory barrier in `lvq_steal` allows speculative e=
xecution to read stale or uninitialized queue elements.
- [High] `lvq_destroy` unconditionally calls `free()` on NULL pointers, whi=
ch corrupts the selftest memory allocator state.
- [High] The use of the test-specific `can_loop` macro in library data stru=
cture logic risks silent data loss and incomplete initialization.
- [Medium] Implicit signed-to-unsigned type promotion in deque resize logic=
 could trigger erroneous array expansions.
- [Medium] The commit message incorrectly documents the data structure's pu=
sh/pop semantics.
- [Low] Pointer arithmetic is performed on a potentially NULL pointer in `l=
vq_order_init`.
- [Low] Memory leaks in selftest error paths upon assertion failures.
--

commit c550e5013d289b25ae7b41bfdffc6d59d1302758
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add Lev-Chase queue data structure
   =20
Expand libarena with a Lev-Chase deque data structure. This is a single
producer, multiple consumer lockless queue that permits efficient
work stealing.

> lvqueue_owner_push(): Push an item to the top of the lvqueue.
> lvqueue_owner_pop(): Pop an item from the top of the lvqueue.
> lvqueue_steal(): Steal a thread from the bottom of the lvqueue from
> any thread.

The code appears to implement standard Chase-Lev deque semantics where the
owner operates at the bottom and stealers operate at the top.

Is the push and pop direction described in the commit message accurate?

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bp=
f.c b/tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c
> new file mode 100644
> index 0000000000000..d53416d22f0a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c
[ ... ]
> @@ -0,0 +1,194 @@
> +SEC("syscall")
> +int test_lvqueue_steal_one(void)
> +{
> +	u64 val, newval;
> +	int ret, i;
> +
> +	lv_queue_t *lvq =3D lvq_create();
> +
> +	if (!lvq)
> +		return 1;
> +
> +	for (i =3D 0; i < 10 && can_loop; i++) {
> +		val =3D i;
> +
> +		ret =3D lvq_owner_push(lvq, val);
> +		if (ret)
> +			return 1;

Does this error path leak the queue's arena memory by returning without
calling lvq_destroy(lvq)?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
> new file mode 100644
> index 0000000000000..b93c4f9d1c929
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
[ ... ]
> @@ -0,0 +1,241 @@
> +static inline
> +void lv_arr_copy(lv_arr_t *dst, lv_arr_t *src, u64 b, u64 t)
> +{
> +	u64 i;
> +
> +	for (i =3D t; i < b && can_loop; i++)
> +		lv_arr_put(dst, i, lv_arr_get(src, i));
> +}

If the instruction budget is exhausted during a queue resize, the loop will
terminate prematurely.

The caller lvq_owner_push() will then accept the partially copied array and
replace the active queue, permanently dropping the uncopied elements without
returning an error.

Can the use of the test-specific can_loop macro here cause silent data loss?

> +static inline
> +int lvq_order_init(lv_queue_t *lvq __arg_arena, int order)
> +{
> +	lv_arr_t *arr =3D &lvq->arr[order];
> +
> +	if (unlikely(!lvq))
> +		return -EINVAL;

Compilers might deduce that lvq cannot be NULL after pointer arithmetic and
optimize away the subsequent if (!lvq) check entirely.

Does performing pointer arithmetic (&lvq->arr[order]) before checking if
lvq is NULL result in undefined behavior?

[ ... ]
> +__weak
> +int lvq_owner_push(lv_queue_t *lvq __arg_arena, u64 val)
> +{
[ ... ]
> +	sz =3D b - t;
> +	if (sz >=3D lv_arr_size(arr) - 1) {

Here sz is ssize_t (signed), but lv_arr_size() returns a u64 (unsigned).
C type promotion rules will implicitly convert sz to an unsigned 64-bit
integer.

If sz is ever negative, the unsigned promotion transforms it into a massive
positive value, erroneously evaluating as greater than the array size.

Can this logic trigger an erroneous array expansion?

[ ... ]
> +__weak
> +int lvq_steal(lv_queue_t *lvq __arg_arena, u64 *val)
> +{
[ ... ]
> +	b =3D READ_ONCE(lvq->bottom);
> +	arr =3D READ_ONCE(lvq->cur);
> +
> +	sz =3D b - t;
> +	if (sz <=3D 0)
> +		return -ENOENT;
> +
> +	value =3D lv_arr_get(arr, t);

READ_ONCE() does not provide an acquire barrier, and control dependencies
(like if (sz <=3D 0)) do not order read-to-read operations.

If a concurrent push occurs, the stealer could speculatively load the array
element before loading the updated bottom index.

Does reading lvq->bottom with READ_ONCE() allow speculative execution to
read stale or uninitialized queue elements on weakly-ordered architectures?
Should lvq->bottom be read using smp_load_acquire() instead?

[ ... ]
> +__weak
> +u64 lvq_create_internal(void)
> +{
[ ... ]
> +	for (i =3D 0; i < LV_ARR_ORDERS && can_loop; i++) {
> +		lvq->arr[i].data =3D NULL;
> +		lvq->arr[i].order =3D i;
> +	}

Can an early termination of this loop due to can_loop leave array pointers
uninitialized, leading to undefined behavior later?

[ ... ]
> +__weak
> +int lvq_destroy(lv_queue_t *lvq __arg_arena)
> +{
> +	int i;
> +
> +	if (unlikely(!lvq))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < LV_ARR_ORDERS && can_loop; i++)
> +		free(lvq->arr[i].data);

The selftest free() implementation in mm.h does not check for NULL pointers
and unconditionally decrements malloc_count:

MALLOC_VISIBLE void free(void *where)
{
    malloc_count--;
    if (!malloc_count)
        malloc_ptr =3D free_mem_ptr;
}

Since arrays are allocated lazily, higher-order array pointers will be NULL.
Calling free() on these unallocated slots will drive malloc_count negative
and permanently prevent the allocator from resetting the memory arena.

Can calling free() unconditionally on potentially NULL pointers corrupt the
selftest memory allocator state?

> +
> +	free(lvq);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511210740.5395=
-1-emil@etsalapatis.com?part=3D2
