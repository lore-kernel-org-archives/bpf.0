Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0823A963A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765061; cv=none; b=dumwJq8rerDHsWnC8fBtp62vuikAwCnFuJwMD1Ay61Jj38A7Wg7Ws0VEFOKymrMefYtmMsJJHdhrYi85mxjaS05KZYYXmQztYU8YIeHCqj5WIqzyqi6YcrUhYoLj31sx8t4hcCwuoxz3ctjmGPt63t2EySZJ5w45FgRZVn+/if8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765061; c=relaxed/simple;
	bh=iXYr1AMu/gnNQIY54OR1MHNCkjdoE2LybCYm1T0L1fE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OB1L66mfAUJRkU0uJUNH8kzGtWowRwHF4jNFqwbluMjNMF3X3DRijm9j5+W6n/IjO4MF5VX8x9c39oyjmRKPUTsHigXsuSCQ6Gh0RbUcQ31DkKqx1J6u9CBQSCmIa7rNvkVNnK96zXS+3JgtAT2a4UBjeRKX7vnsK+rzP2Ptw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZQFnrgF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZQFnrgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF2D1F000E9;
	Tue, 26 May 2026 03:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779765058;
	bh=7piWC9I/W1z1aAhKh5m2yhLiZ0vyi0DB1p5c6NXyG4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZQFnrgF98DtNCfAKCj5tCe18vNOA2D/EbTSgm5unsOtAu8BdcGO2/8I4MQt9dpyN
	 rC1q02VqoiSeZoSjuV/qUuKnunCeljkUG5VtO03kVegsYCyS1Rb0Pz2mnH5WezETPr
	 pS4PGr1e80lfxbUVMcZYJtmKgoLWc3DgxvHcYA6pMHuvJVYoTulrJDqmYrro7Gpj8s
	 lYxGaE0nzsGIUTL4WOBIRPoW5CloT24cjQz9xw6tb449Pg5bnKpFq8dM4z60t/JDwq
	 i8MdKhH1uM+cPVJPpl3gwnpGXdO+05dN2mBFtPEHJfOW249IzZF/wcyiw6W4avXIVy
	 VwAfy84659eoQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 11/11] samples/bpf: Add memcg priority
 control and async reclaim example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, bpf@vger.kernel.org, mkoutny@suse.com
In-Reply-To: <39784d6dba757f4fb82134192419094ce42c5af5.1779760876.git.zhuhui@kylinos.cn>
References: <39784d6dba757f4fb82134192419094ce42c5af5.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:10:57 +0000
Message-Id: <20260526031057.DAF2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Non-atomic updates to the global `aggregation_map` in the `handl=
e_count_memcg_events` tracepoint lead to data races and lost PGFAULT update=
s.
- [Medium] Atomic one-shot guards permanently leak in error paths, deadlock=
ing the async reclaim functionality.
- [Low] `parse_u64` relies entirely on `errno` and fails to detect complete=
ly non-numeric input strings, silently returning 0.
- [Low] Ignoring the return value of `__atomic_add_fetch` and using a subse=
quent `READ_ONCE` introduces an unnecessary race window.
--

commit 0eac8db0526f6826e19ed8ba2b922d7d358b6032
Author: Hui Zhu <zhuhui@kylinos.cn>
Subject: samples/bpf: Add memcg priority control and async reclaim example

This commit adds a sample program demonstrating the memcg_bpf_ops feature.
It provides priority-based memory throttling and workqueue-driven
asynchronous page reclaim using a BPF program and userspace loader.

> diff --git a/samples/bpf/memcg.bpf.c b/samples/bpf/memcg.bpf.c
> new file mode 100644
> index 0000000000000..0995284794ac7
> --- /dev/null
> +++ b/samples/bpf/memcg.bpf.c
[ ... ]
> +static int async_free(void *map, int *key, void *value)
> +{
> +	struct cgroup_memcg cm;
> +	bool started_wq =3D false;
> +	int i;
> +
> +	if (get_cgroup_memcg_from_id(local_config.low_cgroup_id, &cm) !=3D 0)
> +		return 0;

[Severity: Medium]
Can the async_free_run guard permanently leak if get_cgroup_memcg_from_id
fails? Returning early here skips the lock release at the end of the
function, which would deadlock the async reclaim functionality.

> +
> +	for (i =3D 0; i < ASYNC_FREE_LOOP_MAX; i++) {
[ ... ]
> +	}
> +
> +	put_cgroup_memcg(&cm);
> +
> +	if (!started_wq)
> +		__atomic_exchange_n(&async_free_run, 0, __ATOMIC_RELEASE);
> +	return 0;
> +}
[ ... ]
> +SEC("tp/memcg/count_memcg_events")
> +int handle_count_memcg_events(
> +		struct trace_event_raw_memcg_rstat_events *ctx)
> +{
[ ... ]
> +	current_ts =3D bpf_ktime_get_ns();
> +
> +	if (current_ts - data->window_start_ts < ONE_SECOND_NS) {
> +		data->sum +=3D ctx->val;

[Severity: Medium]
Can this non-atomic update to the global aggregation_map lead to data races
and lost PGFAULT updates? Since this map is shared across all CPUs,
concurrent PGFAULT events executing the tracepoint might perform read,
modify, write operations simultaneously.

Should BPF atomic instructions or a bpf_spin_lock be used here?

> +	} else {
> +		data->window_start_ts =3D current_ts;
> +		data->sum =3D ctx->val;
> +	}
[ ... ]
> +static __always_inline unsigned int
> +__memcg_charged_impl(struct mem_cgroup *memcg, unsigned int nr_pages)
> +{
> +	struct wq_elem *elem;
> +	__u32 key =3D 0;
> +	u64 expected =3D 0;
> +	s64 cur_allocated;
> +	s64 cur_old_allocated;
> +
> +	__atomic_add_fetch(&allocated, nr_pages, __ATOMIC_RELAXED);
> +	cur_allocated =3D READ_ONCE(allocated);

[Severity: Low]
Is there a race window introduced by ignoring the return value of
__atomic_add_fetch and performing a separate READ_ONCE? A concurrent
increment by another CPU between the add and the read could cause
cur_allocated to observe an inconsistent or skipped value.=20

Could the return value of __atomic_add_fetch be assigned directly to
eliminate this window?

> +	cur_old_allocated =3D READ_ONCE(old_allocated);
> +	if (abs_diff(cur_allocated, cur_old_allocated) < ONE_MB_PAGE_COUNT)
> +		goto out;
> +	WRITE_ONCE(old_allocated, cur_allocated);
> +
> +	if (get_usage() < local_config.async_trigger_bytes)
> +		goto out;
> +
> +	if (__atomic_compare_exchange_n(&async_free_run,
> +					&expected, 1,
> +					false,
> +					__ATOMIC_ACQ_REL,
> +					__ATOMIC_RELAXED)) {
> +		elem =3D bpf_map_lookup_elem(&wq_map, &key);
> +		if (!elem)
> +			return 0;

[Severity: Medium]
Does this early return also leak the async_free_run guard if the map lookup
fails? Like the early return in async_free, this skips resetting the guard
and could deadlock the state machine.

> +
> +		bpf_wq_start(&elem->work, 0);
> +	}
> +
> +out:
> +	return 0;
> +}
[ ... ]
> diff --git a/samples/bpf/memcg.c b/samples/bpf/memcg.c
> new file mode 100644
> index 0000000000000..0929d868e6d8f
> --- /dev/null
> +++ b/samples/bpf/memcg.c
[ ... ]
> +static uint64_t parse_u64(const char *str, const char *prog)
> +{
> +	uint64_t value;
> +
> +	errno =3D 0;
> +	value =3D strtoull(str, NULL, 10);
> +	if (errno !=3D 0) {

[Severity: Low]
Does this code silently return 0 for completely non-numeric input strings?

The strtoull function does not set errno if the input string contains no
valid digits. Since the endptr argument is NULL, could malformed arguments
like --async_trigger_bytes abc silently return 0 instead of raising an
error?

> +		fprintf(stderr, "ERROR: strtoull '%s' failed: %d\n",
> +			str, errno);
> +		usage(prog);
> +		exit(-errno);
> +	}
> +	return value;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D11
