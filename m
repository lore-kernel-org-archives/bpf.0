Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFB3C1D56
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541781; cv=none; b=MEfMOsJT9gXHOxJPmv6HpfcOKYnAgHFbvAGzXJzbR+NTXoQlJOP/mlfvI6/pTUYIXhuRKuY+kQnvV1WHz3Da8NJ2s9vLM0iaOHRp0K26RWZpxPzlGy00h+9sTaatoOEzGtMbe+SIyqd1A6eY9/zVrUeWs7NUWh3lyN4uJuFn8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541781; c=relaxed/simple;
	bh=h8D4wSgLwSuu8NC98YRFhCpiqUOAAlRnPA4YLQ+nZvY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GR1IRjL3DC4f0Gz2dEm9Ss3h9l+HChOWZIPiok1q/+ug5Tlt/XTHO2pWAv+caYiAhR2S2wRYPod9DtwcWChFMkJXfcpyDGyihKm+y2Ire3yp4p86KpMPq9bpm5bIBmu6gIv3qjPkj/2sDbDMnOHMFjAoMivvjaCFwCqtwv2MNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDJ7i0rH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDJ7i0rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B691F00893;
	Sun, 27 Sep 2026 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541779;
	bh=yxIOnAwKvqkBKfXp3OZQF3lBzrvgrU6/7Mh+2pLuke0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SDJ7i0rHLrquzLtKWzEkNzgwdmOL2GTtdcTTsVkFg63MbzaxvyelxpMB/GtEJ13f1
	 tNXzeIzCRu1v86f8vG31oLjZTbdMMjTPRi2B1UYOBleq4ngbx6dD1GJP6rdngnf6M7
	 CjQAipM5XojXv1LSGuoEHv5CLZayywca12YWZlXfTT5FxT5Y1SaRuqm4KHfD1cmYwK
	 8fX29hKSaWuIyMfHpLAt61SSCi0HvUAV4D9IjF/7ZNeAAkpcSmPfX8f9LoNSwMc4nM
	 mecccowNZMLf4xN0w3Q12i6EsfHMzmOPdQ241VjTQhMtTkhkNCRyQqYXwL0PZBk4VB
	 SjmOB+qSEQxPg==
Content-Type: multipart/mixed; boundary="===============0160413560013895974=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0e8f09239f3e9c7a432cb1d484dbd94f817c636c56294f9e9de08e526e8a47f@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-15-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-15-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 15/36] bpf: varying offset access support for PTR_TO_BTF_ID pointers
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:59 +0000 (UTC)

--===============0160413560013895974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9bcfefdfb734..37437b93471d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7496,6 +7496,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  }
>  EXPORT_SYMBOL_GPL(btf_ctx_access);
>
> +#define MAX_ARRAYS_WALK 16
> +
> +/* Description of an array crossed while walking a BTF access chain */
> +struct array_access {
> +	u32 id;		/* BTF_KIND_ARRAY type id */
> +	u32 off;	/* offset of the access within the array */
> +};

[ ... ]

> @@ -7542,22 +7583,19 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  		/* If the last element is a variable size array, we may
>  		 * need to relax the rule.
>  		 */
> -		if (vlen == 0)
> +		member = find_flex_member(btf, t);
> +		if (!member)
>  			goto error;
>
> -		member = btf_type_member(t) + vlen - 1;
> -		mtype = btf_type_skip_modifiers(btf, member->type,
> -						NULL);
> -		if (!btf_type_is_array(mtype))
> +		moff = __btf_member_bit_offset(t, member) / 8;
> +		if (off < moff)
>  			goto error;
>
> +		mtype = btf_type_skip_modifiers(btf, member->type, &mid);
>  		array_elem = (struct btf_array *)(mtype + 1);
> -		if (array_elem->nelems != 0)
> -			goto error;
>
> -		moff = __btf_member_bit_offset(t, member) / 8;
> -		if (off < moff)
> -			goto error;
> +		if (push_array(arrays, arrays_cnt, (struct array_access){ mid, off - moff }))
> +			return -E2BIG;

Does push_array() receive the correct BTF type id here? The comment on
struct array_access documents id as a 'BTF_KIND_ARRAY type id', but this
code stores mid after btf_type_skip_modifiers() has been called with
&mid as the output parameter.

btf_type_skip_modifiers() walks through modifiers and typedefs on the
array's element type, so for a member like 'u32 foo[N]', '__be32 addr[4]',
or 'atomic_t cnt[N]', mid would point to the resolved element type (INT or
STRUCT) rather than the ARRAY itself.

In btf_struct_access(), the check_variable_offset loop calls
__btf_resolve_size(btf, t, ...) where t comes from
btf_type_by_id(btf, arrays[i].id). If arrays[i].id is not an ARRAY type,
__btf_resolve_size() would leave elem_id as 0, causing btf_resolve_size()
to fail on btf_void, and the entry would be skipped with continue.

This would affect most kernel arrays since u8/u16/u32/u64/__be* types are
typedefs.

Should this store the array id before resolving the element type, perhaps
by calling btf_type_skip_modifiers(btf, member->type, &array_id) before
the existing call, or by capturing the id when btf_type_is_array(mtype)
first matches?


> @@ -7680,6 +7718,9 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  			 *      the array's element as long as it is
>  			 *      within the mtrue_end boundary.
>  			 */
> +			if (push_array(arrays, arrays_cnt,
> +				       (struct array_access){ mid, off - moff }))
> +				return -E2BIG;
>
>  			/* skip empty array */
>  			if (moff == mtrue_end)

[ ... ]

> @@ -7772,15 +7813,29 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>
>  int btf_struct_access(struct bpf_verifier_log *log,
>  		      const struct bpf_reg_state *reg,
> -		      int off, int size, enum bpf_access_type atype __maybe_unused,
> +		      int _off, int size, enum bpf_access_type atype __maybe_unused,
>  		      u32 *next_btf_id, enum bpf_type_flag *flag,
>  		      const char **field_name)
>  {
>  	const struct btf *btf = reg->btf;
>  	enum bpf_type_flag tmp_flag = 0;
> +	struct array_access arrays[MAX_ARRAYS_WALK];
> +	const struct btf_member *member;
>  	const struct btf_type *t;
> +	u32 i, arrays_cnt = 0;
>  	u32 id = reg->btf_id;
> -	int err;
> +	s64 min_off, max_off, flex_off;
> +	int err, off, ret;

[ ... ]

> @@ -7846,6 +7905,54 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  	} while (t);
>
>  	return -EINVAL;
> +
> +check_variable_offset:
> +	if (min_off == max_off)
> +		return ret;
> +
> +	/* Find an offset at which access would go to a flexible array tail (if any). */
> +	t = btf_type_skip_modifiers(btf, reg->btf_id, NULL);
> +	member = find_flex_member(btf, t);
> +	flex_off = member ? __btf_member_bit_offset(t, member) / 8 : S64_MAX;
> +
> +	/*
> +	 * If this is a varying offset access, the step recorded within a register
> +	 * should correspond to one of the arrays visited while walking.
> +	 */
> +	for (i = 0; i < arrays_cnt; i++) {
> +		s64 array_start, array_end, access_end;
> +		u32 asize, esize, elem_id;
> +
> +		/*
> +		 * 'arrays' records top-level arrays only, use __btf_resolve_size()
> +		 * to get flattened representation.
> +		 */
> +		t = btf_type_by_id(btf, arrays[i].id);
> +		if (IS_ERR(__btf_resolve_size(btf, t, &asize, NULL, &elem_id, NULL, NULL)) ||
> +		    IS_ERR(btf_resolve_size(btf, btf_type_by_id(btf, elem_id), &esize)))
> +			continue;
> +		/* Make sure every accessed offset lands on the same field of some element. */
> +		if (esize == 0 || reg->step % esize != 0)
> +			continue;
> +
> +		array_start = min_off - arrays[i].off;
> +		/* An array within the flexible tail has no upper bound to exceed */
> +		if (array_start >= flex_off)
> +			return ret;
>                         ^^^^^^^^^^

Does this shortcut accept inner arrays that should still be bounded?

The arrays list contains not just the flexible array itself, but also
fixed-size arrays nested inside a flexible array element. When
btf_struct_walk() pushes the flex array and then walks into the element
struct via 'goto again', it pushes the inner member arrays too.

For an inner array nested inside a flex element, array_start >= flex_off
is true, so this code returns success after only checking
reg->step % esize(inner) == 0. It never verifies that the step is a
multiple of the flex element stride, and never bounds the access by the
inner array's own size.

Consider this example:

    struct elem {
        struct foo *ptrs[2];
        long val;
    };                          /* sizeof 24 bytes */

    struct top {
        u32 n;
        struct elem items[];    /* flex_off = 8 */
    };

With a trusted pointer r1 to struct top and a scalar
r2 = (rand & 1023) * 8 (step 8, smin 0), the load *(u64 *)(r1 + 8)
walks at min_off 8 and records:

    arrays[0] = {items, 0}
    arrays[1] = {ptrs, 0}

For arrays[0] (the flex array), esize is 24 and 8 % 24 != 0, so the loop
continues. For arrays[1] (the inner ptrs array), esize is 8 and
8 % 8 == 0, and array_start = 8 >= flex_off, so the function returns
PTR_TO_BTF_ID(struct foo).

At runtime, offset 8 + 16 = 24 is items[0].val (a long), not a struct foo
pointer. Loads through PTR_TRUSTED/MEM_RCU/MEM_ALLOC are emitted without
PROBE_MEM, and the mistyped result can be passed to helpers expecting BTF
pointers.

Should the 'no upper bound' rule apply only to the flexible array entry
itself (the one whose array_start == flex_off or whose asize/nelems is 0),
while inner arrays must still pass the access_end <= array_start + asize
check?



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============0160413560013895974==--
