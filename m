Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603720;
	b=cjHmn1p87+nM8EzxZE3tPQMJDxyeZVd7q9UN2E2IidyZY1DvcIbPjSL42aZeHl1ZvsgO
	 5J+El3XRjAoym2Js67Bge52HaZwKBBZgXv9t7nMth63N0AkUfkdk+Mwlk2lgEnlVziHa9
	 N4XPd7iCG+MdwXX2ixloQrtkCzaILslxX4C3mx8uCC1V8m0T73w2eT3MFT1FjVTN4T4s8
	 qrZ43UJPyrNW/sGuqc9W4MpBRWC92H8TTYANuKFaEf6ZzUxGygIE8/4Ks4tppK4b9GHDf
	 EX2QYTDkdixraK9SgFrYM5edujwB2EW3FcxPyvERcZsgzypn9oTTGUrjRYm8DEVOlUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0dEY7QwFo7y7A1OmKTX/624e5nWdVoCuPz4X8W4hjew=;
	b=s2Vjj7GBwap3HOdMT5jDU4t8geG/BcepgLzogyJnG1CfO2XKljZ1RkfYcSfZ0H3pOQ/k
	 7gQKO+uHHmS2tAZ6s9puGNZJdM6kO5KFOLflU8WvfRoHRV7rg9lnpNkDX+Dq5vZbnp9nt
	 mAj5m15UuubgffCEXj4+8wvJmpcZ9Hx86QBfSK+0aZeDi/HBuE8146iTk8KJGsaOkeuyj
	 E075UFR4LnWN46cKfJYOUO4FlJjngv/1b+IyjrhSV/4iS16zlnluFF92fCMDQnN2xH2sZ
	 b56KJUvTUelZ2hltn5ZfxLdfhz663HPz7qbEKNWflTCTOxbduJeO5Tao7a6lK/lTLlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mf+Evl6R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDA60A260A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mf+Evl6R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3861F000C4;
	Wed, 21 Oct 2026 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603719;
	bh=0dEY7QwFo7y7A1OmKTX/624e5nWdVoCuPz4X8W4hjew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mf+Evl6RuWX+evHUPgBTuaqe3wll4mr3BF17xU5mQz9CK4LeEqIkyRoLmbqXmEyn9
	 vNEi/1/4Aao+1K7nGVHGKdYKj6N3G5dtwGaDr+8Tm9FLFwP78fhIgRjRZcxFUN70IC
	 GQvWdY13p4f8wHZGD9U7r+8ekv0jaZkQmHJep6ZOJjc8VlQ0WFHomHhMWsybtaZpWM
	 D5Ykpx5IAChCFyfPjDSKaL5+8nW/lODVxedHlbgFvL/J1jZXo4L2InllDccfqIKFOI
	 IDsJz3jDjS0sw6/kHnGHymgOTl/wVIwcM0N2AolW2Wy6sCGXLQy06HoZnoMT9fg7bq
	 VjxgR7EGP0yAg==
Message-ID: <sashiko-outbox-180524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] bpf: Fix stackmap overflow check in
 __bpf_get_stackid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261021171625.206-1-artem@trailofbits.com>
References: <20261021171625.206-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:28:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: integer underflow and OOB write in __bpf_get_stackid()
--

commit 8a7616c005136eb52127894543c589eeca649242
Author: Arnaud Lecomte <contact@arnaud-lcm.com>

bpf: Fix stackmap overflow check in __bpf_get_stackid()

This commit bounds trace_nr in __bpf_get_stackid() to prevent a slab
out-of-bounds write into a stack map bucket when a perf callchain contains
more entries than the bucket can hold. It also restores trace->nr after
both branches of bpf_get_stackid_pe().

Link: https://lore.kernel.org/bpf/20251025192941.1500-1-contact@arnaud-lcm.=
com

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 458bb80b14d57..60ecf3e82d97b 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -213,7 +213,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  	struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack_map, =
map);
>  	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>  	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> -	u32 hash, id, trace_nr, trace_len;
> +	u32 hash, id, trace_nr, trace_len, max_depth;
> +	u32 curr_sysctl_max_stack;
>  	bool user =3D flags & BPF_F_USER_STACK;
>  	u64 *ips;
>  	bool hash_matches;
> @@ -222,7 +223,12 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  		/* skipping more than usable stack trace */
>  		return -EFAULT;
> =20
> -	trace_nr =3D trace->nr - skip;
> +	curr_sysctl_max_stack =3D READ_ONCE(sysctl_perf_event_max_stack);
> +	max_depth =3D map->value_size / stack_map_data_size(map);
> +	max_depth +=3D skip;
> +	if (max_depth > curr_sysctl_max_stack)
> +		max_depth =3D curr_sysctl_max_stack;
> +	trace_nr =3D min_t(u32, trace->nr - skip, max_depth - skip);

[Severity: Critical]
Can max_depth - skip underflow here and bypass the bucket size check when
__bpf_get_stackid() is called from bpf_get_stackid_pe()?

When a perf event has PERF_SAMPLE_CALLCHAIN enabled, ctx->data->callchain is
populated by perf_callchain() -> get_perf_callchain() with add_mark =3D tru=
e.
In include/linux/perf_event.h:perf_callchain_store_context(), context marke=
rs
such as PERF_CONTEXT_KERNEL and PERF_CONTEXT_USER are appended to entry->ip
without incrementing ctx->nr:

include/linux/perf_event.h:perf_callchain_store_context() {
	if (ctx->contexts < sysctl_perf_event_max_contexts_per_stack) {
		struct perf_callchain_entry *entry =3D ctx->entry;
		entry->ip[entry->nr++] =3D ip;
		++ctx->contexts;
		return 0;
	} else {
		return -1;
	}
}

Because ctx->nr is bounded by sysctl_perf_event_max_stack while context
markers are counted separately up to sysctl_perf_event_max_contexts_per_sta=
ck,
trace->nr can legitimately exceed curr_sysctl_max_stack (for example, up to
curr_sysctl_max_stack + 2 on x86_64 or curr_sysctl_max_stack + 8 on powerpc
when interrupt or signal frame markers are present).

In kernel/bpf/stackmap.c:bpf_get_stackid_pe(), skip comes from
flags & BPF_F_SKIP_FIELD_MASK (up to 255), and for BPF_F_USER_STACK it also
adds nr_kernel:

kernel/bpf/stackmap.c:bpf_get_stackid_pe() {
...
	} else { /* user */
		u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;

		skip +=3D nr_kernel;
		if (skip > BPF_F_SKIP_FIELD_MASK)
			return -EFAULT;

		flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
		ret =3D __bpf_get_stackid(map, trace, flags);
	}
...
}

If curr_sysctl_max_stack < skip < trace->nr, the trace->nr <=3D skip check =
in
__bpf_get_stackid() passes, and clamping max_depth to curr_sysctl_max_stack
makes max_depth smaller than skip. The u32 expression max_depth - skip then
wraps around to a large unsigned value, so min_t() selects trace->nr - skip
without clamping it to map->value_size / stack_map_data_size(map).

When trace->nr - skip is larger than the number of elements that fit in
new_bucket->data (for example, on a small stack map with a 1-entry bucket),
wouldn't stack_map_get_build_id_offset() or memcpy(new_bucket->data, ips,
trace_len) in __bpf_get_stackid() still write past the end of
new_bucket->data, and subsequently cause bpf_stackmap_copy() to overflow
value in memcpy() and underflow map->value_size - trace_len in memset()?

kernel/bpf/stackmap.c:__bpf_get_stackid() {
...
		new_bucket =3D (struct stack_map_bucket *)
			pcpu_freelist_pop(&smap->freelist);
		if (unlikely(!new_bucket))
			return -ENOMEM;
		memcpy(new_bucket->data, ips, trace_len);
	}
...
}

kernel/bpf/stackmap.c:bpf_stackmap_copy() {
...
	trace_len =3D bucket->nr * stack_map_data_size(map);
	memcpy(value, bucket->data, trace_len);
	memset(value + trace_len, 0, map->value_size - trace_len);
...
}

Also, when skip =3D=3D curr_sysctl_max_stack and trace->nr > skip, max_dept=
h -
skip evaluates to 0, which records an empty bucket with new_bucket->nr =3D =
0;
and when skip < curr_sysctl_max_stack < max_depth, clamping max_depth to
curr_sysctl_max_stack before subtracting skip truncates frames that would
otherwise fit in the bucket.

Since trace is already unwound before __bpf_get_stackid() is called, should
__bpf_get_stackid() clamp trace->nr - skip directly against the bucket
capacity map->value_size / stack_map_data_size(map), matching how
__bpf_get_stack() clamps trace_nr against num_elem?

kernel/bpf/stackmap.c:__bpf_get_stack() {
...
	trace_nr =3D trace->nr - skip;
	trace_nr =3D (trace_nr <=3D num_elem) ? trace_nr : num_elem;
...
}

>  	trace_len =3D trace_nr * sizeof(u64);
>  	ips =3D trace->ip + skip;
>  	hash =3D jhash2((u32 *)ips, trace_len / sizeof(u32), 0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171625.206-=
1-artem@trailofbits.com?part=3D1
