Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188136655F
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638991; cv=none; b=tUTAGa9k3fFpn1WP/3RGLOpnK2Er1vmVsv09sHoO/19HorPWQ9iK2jk4/azc/juy4TtfCX6+0/S+gbLIzYm7s4yC7uyAAYrZ0j1fOB0Necw958Nkj3u88sJIWmDY33xwFlfys+S6ni04wxlIUNeZNyWKm7uad+TF707fO3B4V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638991; c=relaxed/simple;
	bh=5+MrdGxgMBAvGIPalV/oBFptCoYB7+kEHKB3ldxvWgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOc2mpK8APK+5/zPiW84vayRml0gbgm0tKg6ogxKyge2DZ741Qfazu6S6+ucyFn/Y+b9Ub1t/qsOAH8WJFr7AsW6UciQcLVlaZ+cd3PtHm6HSr/Wfb0mUqbOtIyPvu5VliAN3H96KesGOVkZLk8TfvEGVN6eIq8T8MpKjgD503Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcUGLRSY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcUGLRSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21797C2BCB0;
	Wed, 13 May 2026 02:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778638991;
	bh=5+MrdGxgMBAvGIPalV/oBFptCoYB7+kEHKB3ldxvWgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EcUGLRSYRirMmDrrWFkMrKY1NK83TqLrM0ggHggPi+fnXTTVu5qloMohP4KXzOxRi
	 uSvYlKQVYeShRJcRshGvUT4N2z1+6CYp2n35Bgl6yR1ai6xW/0uX0F2/6NcNc/Tmec
	 R19L2JwcmKZEXeGc95qoKkN0bnz7m89vD6WTdUXz0YRsgbWzMACuD+3ThZ48r9C8we
	 gntxct0UYuaS8C8S+3CGCGETPu3l2qYOQ99180Dwtb2ATFupFj2g2IHypcvcdPF7QF
	 VyIfZ/W5dzhc/hVkIP6q/NOa7qpRLDK9jgHYdEwyE8vTn4XHuTPVY4RzyOVEB+77So
	 VRJYnhuApVrpg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH bpf-next 2/2] selftests/bpf: libarena: Add
 Lev-Chase queue data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511214100.9487-3-emil@etsalapatis.com>
References: <20260511214100.9487-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:23:10 +0000
Message-Id: <20260513022311.21797C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use of undefined `malloc()` and `free()` instead of `arena_malloc(=
)` and `arena_free()`
- [High] Missing acquire memory barrier when reading `lvq->bottom` in `lvq_=
steal()` leads to stealing uninitialized data
- [High] Early loop termination via `can_loop` causes silent data corruptio=
n and wild pointer frees
--

commit f362e0549cb75d0f854b07e362d4f47abea9daf9
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add Lev-Chase queue data structure

Expand libarena with a Lev-Chase deque data structure. This is a single
producer, multiple consumer lockless queue that permits efficient
work stealing. The structure is lock-free and wait-free to minimize
overhead.

> diff --git a/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
> new file mode 100644
> index 0000000000000..b93c4f9d1c929
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
[ ... ]
> +static inline
> +void lv_arr_copy(lv_arr_t *dst, lv_arr_t *src, u64 b, u64 t)
> +{
> +	u64 i;
> +
> +	for (i =3D t; i < b && can_loop; i++)

If can_loop breaks early, won't this array expansion silently abort without
copying all queue items?

lvq_owner_push() doesn't seem to have error handling for this, which might
lead to published, partially empty arrays and permanent queue data loss.

> +		lv_arr_put(dst, i, lv_arr_get(src, i));
> +}
> +
> +static inline
> +int lvq_order_init(lv_queue_t *lvq __arg_arena, int order)
> +{
[ ... ]
> +	arr->data =3D (u64 __arena *)malloc((LV_ARR_BASESZ << order) * sizeof(*=
arr->data));

Should this be arena_malloc() instead?

Standard C library functions are typically not available during BPF target
compilation, which could cause build or linker errors due to undefined
symbols.

> +	if (!arr->data)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
[ ... ]
> +__weak
> +int lvq_steal(lv_queue_t *lvq __arg_arena, u64 *val)
> +{
> +	volatile u64 b, t;
> +	lv_arr_t *arr;
> +	ssize_t sz;
> +	u64 value;
> +
> +	if (unlikely(!lvq || !val))
> +		return -EINVAL;
> +
> +	t =3D smp_load_acquire(&lvq->top);
> +
> +	/*
> +	 * It is important that t is read before b for
> +	 * stealers to avoid racing with the owner.
> +	 * Races between stealers are dealt with using
> +	 * CAS to increment the top value below.
> +	 */
> +	smp_rmb();
> +
> +	b =3D READ_ONCE(lvq->bottom);

Could reading lvq->bottom without smp_load_acquire() (or a following
smp_rmb()) cause the stealer to read uninitialized data?

In lvq_owner_push(), the array is updated before lvq->bottom is updated
via smp_store_release(). On weakly ordered CPUs like ARM64, the control
dependency (sz <=3D 0) below does not guarantee read-to-read ordering.

Could the CPU speculatively execute lv_arr_get(arr, t) before fetching the
updated lvq->bottom, resulting in a successful steal of garbage data?

> +	arr =3D READ_ONCE(lvq->cur);
> +
> +	sz =3D b - t;
> +	if (sz <=3D 0)
> +		return -ENOENT;
> +
> +	value =3D lv_arr_get(arr, t);
[ ... ]
> +__weak
> +u64 lvq_create_internal(void)
> +{
> +	/*
> +	 * Marked as volatile because otherwise the array
> +	 * reference in the internal loop gets demoted to
> +	 * scalar and the program fails verification.
> +	 */
> +	volatile lv_queue_t *lvq;
> +	int ret, i;
> +
> +	lvq =3D malloc(sizeof(*lvq));

Is it possible this should be arena_malloc() as well?

> +	if (!lvq)
> +		return (u64)NULL;
> +
> +	WRITE_ONCE(lvq->bottom, 0);
> +	WRITE_ONCE(lvq->top, 0);
> +
> +	for (i =3D 0; i < LV_ARR_ORDERS && can_loop; i++) {

If this initialization loop terminates early due to can_loop, will the
remaining lvq->arr[i].data pointers retain uninitialized memory from the
allocation?

If so, could the subsequent iteration in lvq_destroy() call free() on those
wild pointers, causing memory corruption?

> +		lvq->arr[i].data =3D NULL;
> +		lvq->arr[i].order =3D i;
> +	}
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

Should these be arena_free() calls?

> +
> +	free(lvq);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511214100.9487=
-1-emil@etsalapatis.com?part=3D2
