Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E5427F9E
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315098; cv=none; b=Kp7iLMywMQlPI01gzskcs9XyDM1z5t7T2Dbl5YyFgzet/THxcwYzENit+yXJ2t71RaTd+lfre5Hl2oD/5bHy/GC1tqjX8SgkaC8psx/JFcUl18ZFmP11t5GkSmUHFGFRYKh3+r5uZNWrSzhWHerM07RYW6MTxlM3b1ZmXtNtogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315098; c=relaxed/simple;
	bh=XXlAOvmWcwfCHCku4Do8gUW4MI4lUS7LC30u8y86x4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LbUU3BdpPb2e4C0fbLHvZ6bwWq6pGh72gqZ+Ur9p2ennjGBbW0qBMJVnFXdTnfybHNe6r7GX/Is48F9xVN7hSMBP4U1HAwFuHXcr6asR4g1YEvEE/y7MSQVJ0FdLHpu9sxvNOVluV7wFH7zx7HkBhL0QTNA23KjholShGhQ5xRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvxtKjRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvxtKjRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9B71F000E9;
	Wed, 29 Jul 2026 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785315096;
	bh=y3HOcq2fog/GZC6CqaXbx5l40RTqrhGIyZfk9PtYH/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SvxtKjRET9mu4hWWINdXi716K+9hf3Ib0w1WsS4TlEp2HGtSoRSwLKo6Q5oHWrB6S
	 UJlqwStwRG4PNokg2uq0VDG1tkIX2/qehVxHlXm4AX+Pq5rBV9NqhBan71NXSnpwJh
	 m+2qejsJJMO+MAhzZccK3PUWb39mB76uRudAncJ2zUXOpv9RHG9uHgoayDvw9b7om6
	 wp/cN0DkGzP4AAeRJ3tyt0WxvIyrlR0IrWlqmDPVXd5fWwoBjuk35jNk5I0l1XlyFJ
	 BAdYX/IRCnaYxhatHts2Kz5g/gm1h7vZ7D3d6TILvE/3ZZ7l4cs+vE69wcEDeDGgAU
	 D7E/ViWtnu/Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 01/11] bpf: Factor stackid_init function from
 __bpf_get_stackid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729083807.1588544-2-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:51:36 +0000
Message-Id: <20260729085136.9E9B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A TOCTOU race with `sysctl_perf_event_max_stack` causes an integer=
 underflow in the `max_depth - skip` calculation, leading to a massive heap=
 buffer overflow when copying stack traces.
--

--- Patch [1]: [PATCHv2 bpf-next 01/11] bpf: Factor stackid_init function f=
rom __bpf_get_stackid ---
commit 94626e7c900d701c2d2326e06f48ebc28e1f6e93
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor stackid_init function from __bpf_get_stackid

The new stackid_init function stores all the necessary bits for stackid
trace and it will be used by other functions in following changes.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 41fe87d7302f2..0eafe55b18289 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -504,33 +504,54 @@ get_callchain_entry_for_task(struct task_struct *ta=
sk, u32 max_depth)
[ ... ]
> +static int stackid_init(struct stackid *stackid, struct bpf_map *map,
> +			struct perf_callchain_entry *trace, u64 flags)
>  {
>  	struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack_map, =
map);
> -	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> -	u32 hash, id, trace_nr, trace_len, i, max_depth;
>  	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> -	bool user =3D flags & BPF_F_USER_STACK;
> -	u64 *ips;
> -	bool hash_matches;
> +	u32 max_depth;
> =20
>  	if (trace->nr <=3D skip)
>  		/* skipping more than usable stack trace */
>  		return -EFAULT;
> =20
>  	max_depth =3D stack_map_calculate_max_depth(map->value_size, stack_map_=
data_size(map), flags);
> -	trace_nr =3D min_t(u32, trace->nr - skip, max_depth - skip);
> -	trace_len =3D trace_nr * sizeof(u64);
> -	ips =3D trace->ip + skip;
> -	hash =3D jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
> -	id =3D hash & (smap->n_buckets - 1);
> -	bucket =3D READ_ONCE(smap->buckets[id]);
> +	stackid->nr =3D min_t(u32, trace->nr - skip, max_depth - skip);

[Severity: High]
This is a pre-existing issue, but can this max_depth - skip calculation
underflow?

If a BPF program is attached to a perf event using bpf_get_stackid_pe(),
the callchain is generated using the current sysctl_perf_event_max_stack
limit. If an administrator concurrently reduces sysctl_perf_event_max_stack=
 to
a value smaller than the skip parameter, stack_map_calculate_max_depth()
clamps max_depth to this new smaller sysctl value:

kernel/bpf/stackmap.c:stack_map_calculate_max_depth() {
    ...
    u32 curr_sysctl_max_stack =3D READ_ONCE(sysctl_perf_event_max_stack);
    ...
    if (max_depth > curr_sysctl_max_stack)
        return curr_sysctl_max_stack;
    return max_depth;
}

This would cause max_depth - skip to underflow into a huge u32 value. Since
min_t() is used with u32, a large trace->nr - skip could be selected, which
might exceed the stackmap bucket capacity and lead to a heap buffer overflow
when copying the stack trace later in __bpf_get_stackid():

    memcpy(new_bucket->data, stackid->ips, stackid->len);

Does this sequence need to be protected against sysctl changes between trace
gathering and max_depth calculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729083807.1588=
544-2-jolsa@kernel.org?part=3D1
