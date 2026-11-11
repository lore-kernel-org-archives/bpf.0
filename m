Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405881;
	b=nOWZdrhTi2EgzDCbvV2UPVISc7UxSkx0jPd3Wh3NZ2Ez0cFP84qBmxbp6oBJpXcg80LG
	 zGeBXTNWt3CKCvb6S2jiMPnLK2belxN+JSpZdFvAcpMMxLwHdf++aqAjM7AslrNxVz+fA
	 bogOkgwyacobz4/QUqdJurrVvutp9boNnWPC9onobF32HXPutNfdomLgTNRuCBi5IQ9nK
	 EipT+lXWs0rk5rTOYXrqwozhlFCk0c7o43i2Vpkl23ho975UzvQhiJ0M3x/Q3c7ldRV29
	 7MUFLhcEtJzwwzfxQEUw0meR1zoEFVAJ77QsZtHjqufBJfHqTyPtKwx87YdHlrLQa8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405881;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=o5ZE/+0oHBwkJKyG4WqyWXkISS2MczO/O4zxU+tIv8E=;
	b=00u6DYjkYtQ/HA2AY1ddr0eBS9O04+Aw0exo59+j+He120X6iczBYxGL1vButS3xEOAO
	 c82J8ctQYaYYXlRA95LlrSRdGZLa4U3H7Bu/yqk7ox2vANardE9RPp3eFCAZ72EW9SxwW
	 3BYj3mNidqCzMrSnrieV4lfyutQ5eB9G32USQvIeXG5j1RFzi4K7eOXMB/l5RcJ/81Hvz
	 ljqTTutCqeYnq+BFWo2Y60fl//2bFGzm3hM78+KVhpPIRWUo3U33wJoM6sKV0wSotgKxi
	 gbmrvlK9+zj9eRlLQqEhtC7fPaiGZ0WDX0Hst1WeOywW4O2/2bEzttVzBGymArC+U3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMzKjEl7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF701606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMzKjEl7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E27A1F00A06;
	Wed, 11 Nov 2026 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405881;
	bh=o5ZE/+0oHBwkJKyG4WqyWXkISS2MczO/O4zxU+tIv8E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FMzKjEl7s0u59/iqXTKzTLYSJkq2HDOIsUe/4PKMstvDMosbedfdT41+uH+aueivF
	 eRtJ3XtZWdz+ID0PbwRrvGKOEAH1veQBUuUq2jKXOJATWElPFShJHUDCD6uDIGQHYn
	 1WilzUzuTu+imV3/DqWPoaCZqVirFm4iiyvIyACpaoz0GFocr7BsFdT9GIbzLrEeiq
	 V/3Cfh6mpaQokeYzkWb4/lz6M/hFdC9FzAEd194IZ4BTHvEIyo5MAojLZGBc3Jx1lT
	 T63UdUJSrVfMFZ0kPUuK/nOlChFmuLpY4+KoDzOc6pB7KR1IfOYYoC9DoIAy4S9tT3
	 3twHYQkkfQKfg==
Content-Type: multipart/mixed; boundary="===============7778115237014732538=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <03f25862377a9544ab5674ed566eac08115ccda82730091f79040a57c258c68c@mail.kernel.org>
In-Reply-To: <8861d3d06eadcff128742ac81b2ba9c54f71c523.1794399387.git.memxor@gmail.com>
References: <8861d3d06eadcff128742ac81b2ba9c54f71c523.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 16/29] bpf: Describe locks at throw sites
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:40 +0000 (UTC)

--===============7778115237014732538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Describe locks at throw sites

TL;DR:
- Possible s16 overflow of adj - acq->adj in ref_locations() may make
  bpf_throw unlock a wrong address, corrupting kernel memory
- Possible new load rejections for programs taking different locks at one lock
  insn
- Global locks past 32KB may lose their address (nit)

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +static int resource_of_lock(struct bpf_verifier_env *env, const struct bpf_reference_state *ref,
> +			    const struct bpf_reg_state *reg, s16 *off, u8 *flags)
> +{

[ ... ]

> +	memset(&res, 0, sizeof(res));
> +	res.kind = ref->type == REF_TYPE_LOCK ? BPF_RESOURCE_SPIN_LOCK : BPF_RESOURCE_RES_LOCK;
> +	if (!reg || !tnum_is_const(reg->var_off) ||
> +	    reg->var_off.value != (u64)(s16)reg->var_off.value) {
> +		*flags |= BPF_RES_F_NO_PTR;
> +		return resource_intern(env, &res);
> +	}
> +	*off = reg->var_off.value;
> +	map = reg->type == PTR_TO_MAP_VALUE ? reg->map_ptr : NULL;
> +	for (i = 0; map && i < env->used_map_cnt; i++)
> +		if (env->used_maps[i] == map)
> +			break;
> +	if (map && i < env->used_map_cnt && map->map_type == BPF_MAP_TYPE_ARRAY &&
> +	    map->ops->map_direct_value_addr && !map->ops->map_direct_value_addr(map, &base, *off))
> +		res.addr = (void *)(long)(base + *off);
> +	return resource_intern(env, &res);
> +}

This isn't a bug, but the comment above resource_of_lock() and the commit
message both say that the lock of a global variable gets a class that gives
its address.  The s16 test on reg->var_off.value runs before the used_maps
and map_direct_value_addr() lookup.

Doesn't that mean a global lock more than 32767 bytes into its section, for
example a lock placed after a large array in .bss, gets BPF_RES_F_NO_PTR and
no address?  array_map_direct_value_addr() takes a u32 offset and a fixed
entry needs no adjustment, so the s16 limit would not seem to apply there.
Such a lock still takes a hidden slot and its inserted instructions.

[ ... ]

> @@ -414,8 +452,7 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
>  	*flags |= BPF_RES_F_ARG;
>  	if (ref->type & REF_TYPE_LOCK_MASK)
> -		return resource_of_kind(env, ref->type == REF_TYPE_LOCK ? BPF_RESOURCE_SPIN_LOCK :
> -								   BPF_RESOURCE_RES_LOCK);
> +		return resource_of_lock(env, ref, in_reg ? &frame->regs[regno] : NULL, adj, flags);

Before this patch every lock acquisition got the same class and an adj of 0.
Now the class carries the lock address for a global or single-element array
map lock, and the acquisition records the lock offset in adj and may set
BPF_RES_F_NO_PTR.

acq_add() still requires one bpf_spin_lock()/bpf_res_spin_lock() call insn
to have the same res, flags and adj on every path:

	if (a->res != res || a->flags != flags || a->adj != adj || a->obj_off != obj_off) {
		verbose(env, "frame_desc: insn %d acquires resources of different types on different paths\n",

Can this reject programs that loaded before?  Any program that may throw
(describe_frames is set from might_throw) is rejected when one lock insn is
reached with locks of different objects, for example a static __noinline
helper that takes &lock_a and &lock_b from two private(A)/private(B)
sections, a global lock and a hash map element, or map values whose lock
offsets differ.  This happens even if no throw ever finds the lock held.
The parent commit loads such programs, and the hidden slot does not depend
on the lock class since emit_acquire_before() stores R1 whatever the lock is.

The commit message does not mention a new rejection, and says a lock not
described at a site "still takes a hidden slot".

A later patch in the series, 0ed33b5c066c ("bpf: Apply hidden slot limits
only when a slot is needed"), makes acq_add() create one acquisition per
class, so the case where no throw finds the lock held loads again.  At the
end of the series, a lock insn reached with two different lock objects that
a throw finds held still gets two acquisitions that each need a slot, and
slot_can_be_kept() rejects them with the same message.

[ ... ]

> @@ -805,42 +844,50 @@ static void ref_locations(struct bpf_verifier_env *env, const struct bpf_verifie
>  		loc->at[loc->cnt].off = spi_off(k);
> -		loc->at[loc->cnt].reg = false;
> -		loc->at[loc->cnt++].adj = adj;
> +		/* the acquisition of a lock has how far the lock is into what it is in */
> +		loc->at[loc->cnt++].adj = lock ? adj - acq->adj : adj;

[ ... ]

>  		loc->at[loc->cnt].off = site_regs[k];
>  		loc->at[loc->cnt].reg = true;
> -		loc->at[loc->cnt++].adj = adj;
> +		loc->at[loc->cnt++].adj = lock ? adj - acq->adj : adj;

Can adj - acq->adj overflow the s16 stored in at[].adj?

Only the two inputs are checked to fit in s16: adj by reg_ref_off(), and
acq->adj by the (u64)(s16) test in resource_of_lock().  The difference can
be as low as -65535 and is silently truncated when stored into at[].adj and
then into bpf_frame_desc_entry::adj.

A privileged program can keep a map value pointer far below the element.
With bypass_spec_v1, adjust_ptr_min_max_vals() and sanitize_check_bounds()
accept a constant r7 += -32768 on a PTR_TO_MAP_VALUE and keep its id:

	r0 = lookup();
	r7 = r0;
	r7 += -32768;
	r1 = r0;
	r1 += 4;
	call bpf_spin_lock;
	r1 = 0;
	call bpf_throw;

Here adj = -32768 and acq->adj = 4, so -32772 is stored as 32764.  Every
visit agrees on R7, so the site gets an entry with no hidden slot.  Then
bpf_unwind_release_desc() computes:

	handle = val - ent->adj

which is value - 65532 instead of value + 4, and bpf_unwind_release()
calls bpf_spin_unlock() on that address.  Doesn't this write into unrelated
kernel memory while the real lock stays held?

Before this patch locks never used site locations, and object locations use
adj directly, so they cannot overflow.  Would skipping the place when the
difference does not fit in s16 fix it?  The same expression is still in
ref_locations() at the end of the series, so no later fix was found.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============7778115237014732538==--
