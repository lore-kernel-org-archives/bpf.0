Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505840;
	b=ilYTxzNZGpmZ689IZtljzfzdluY0Xq2tgpG7qy8b9XqLT00la3QgC4TGdPaFBK/OWDky
	 8HLezXEzsb2z03aiO/84Bd6WReJgc6oGv42yHCltAFAvZuv0830GqlqQhAh5Kb6ud6ey8
	 G8pD9IKjdH6xfhkSY/BzPQT1T4fghtMKMK76+5tj9TpQq1+SZM8M6dk5N6OD2WxUC9kd/
	 x4tt/4x2uSSXE1bgjHXHkd64hKFcijng4xBPOFxQNRuYrfTUbcSj+3EYTfoq6DwhM7lUy
	 6LqvdtMB1hGVyVGwPgQ78zbUTJr62hi0WY/kGBdl/8A58HxlnnmwR/h/T4CQ7ClWlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505840;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=h9yFrw4govaK3v2B/JZCV+F4mrTwJZiAYy2bn7NeXj4=;
	b=oSDYkF2sUtzAIR+YzzIGL/+9mbKpiBOVDNSeVsvQxSroB2fSawDNdjoCeeoPLLes2c6E
	 DJNnaFBHCYSVNy4EZ5fEdahDanq+tLXqBPW4qfYpPE8VGzz1s4nC5LUaCvd3UU98mFOpH
	 21yNZJUVFivyZuPXzUnJ8Xqgk9+9x4fMZLBFKBpIcl8gby+EsG9HaGw9ZjIkXgomFzCBc
	 fSNn0wKFyylFq7gX3Hj9Chp4N3n9SLU1+hg2qG4A2xLikEuvKz0pdGZzGVz2vRY1bDSS3
	 l8C4Oj/rbOCrf6hMIQx2RqcZH5RA7HoCrYJdAE+2XrL0LWkAW9c2PIi7oDmID0xPuyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhZ1P3H1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5941606A33F;
	Tue, 20 Oct 2026 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhZ1P3H1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE261F000C6;
	Tue, 20 Oct 2026 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505839;
	bh=h9yFrw4govaK3v2B/JZCV+F4mrTwJZiAYy2bn7NeXj4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fhZ1P3H1tBUmwM9HzEn3AeGsUuz44m2Brj5kxPXNjGJBd6SB94xB0JX0iHKhQOstF
	 YzjznTKYD0uXT+2iY8NkL3omUuMutB7kRnb01psYk1hA+S1JUPeN5Asg9BlbiAufvW
	 JrdfGVWaF3N+Biu2WIEE3awVIDF6W5CUyeHLSaaGV12tur53P4d1FUzgPyqOmEW3KP
	 XIRUws95xq15LbW89ONdx8ifiuWnpiKSr1+OWLR1qb7d8ShctxneKcrfTgfpUlJ3ea
	 +/VM3vTYq+nswD22/CjT/5B4VTK8w8vRbd/lLAuxw8Q2x53OrNFmLRGggGQNQG7mzd
	 33eYnrF6OnlKA==
Content-Type: multipart/mixed; boundary="===============1170969253696388872=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8279ae353583c0148d24530d4aebb476539793bbedbf7883110a7f39c7249278@mail.kernel.org>
In-Reply-To: <114861b89f9ea8789e8572c53b1c88774c311460.1792503001.git.xukuohai@huawei.com>
References: <114861b89f9ea8789e8572c53b1c88774c311460.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 04/16] libbpf: Copy the percpu chunks into the bpf arena
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:19 +0000 (UTC)

--===============1170969253696388872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Copy the percpu chunks into the bpf arena

TL;DR:
- arena_percpu_populate() may pin the loader thread to cpus the app excluded
  (isolcpus)
- the final affinity restore may permanently shrink the thread's cpu mask, and
  its failure is unchecked

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5649,6 +5650,49 @@ static struct bpf_map *bpf_object__sec_map(struct bpf_object *obj, int sec_idx)
> +/*
> + * Copy the percpu chunks into the mmapped bpf arena, one chunk at a
> + * time. Before copying each chunk, pin the thread to the chunk's cpu,
> + * so the copy faults the chunk's pages in from that cpu's NUMA node.
> + * If pinning fails, fall back to copying on the current cpu.
> + */
> +static void arena_percpu_populate(struct bpf_object *obj, void *arena_mmaped)
> +{
> +	size_t chunk_sz = obj->arena_percpu.chunk_sz;
> +	cpu_set_t *saved_set = NULL, *one = NULL;
> +	size_t set_sz;
> +	void *base;
> +	int cpu;
> +
> +	base = arena_mmaped + obj->arena_percpu.offset;
> +
> +	set_sz = CPU_ALLOC_SIZE(obj->arena_percpu.nr_chunks);
> +	saved_set = CPU_ALLOC(obj->arena_percpu.nr_chunks);
> +	one = CPU_ALLOC(obj->arena_percpu.nr_chunks);
> +	if (!saved_set || !one || sched_getaffinity(0, set_sz, saved_set) != 0) {
> +		/* no affinity info, fall back to copying on the current cpu */
> +		for (cpu = 0; cpu < obj->arena_percpu.nr_chunks; cpu++)
> +			memcpy(base + cpu * chunk_sz, obj->arena_percpu.chunk, chunk_sz);
> +		goto out;
> +	}
> +
> +	for (cpu = 0; cpu < obj->arena_percpu.nr_chunks; cpu++) {
> +		CPU_ZERO_S(set_sz, one);
> +		CPU_SET_S(cpu, set_sz, one);
> +		sched_setaffinity(0, set_sz, one);

Can this loop move the calling thread onto cpus the application deliberately
excluded?  saved_set is fetched but never consulted, so the loop pins to
every cpu in [0, nr_chunks) regardless of the caller's mask.

The kernel's __sched_setaffinity() only intersects the new mask with
cpuset_cpus_allowed(), not with the thread's earlier mask.  An application
that limited its threads with taskset or sched_setaffinity() (for example to
housekeeping cpus 0-3 on a box booted with isolcpus= or nohz_full=4-63) would
have libbpf run on every isolated cpu during bpf_object__load().  Each pin
also forces a migration through stop_one_cpu() that preempts whatever is
running on that cpu.

Would it work to pin only to cpus that are set in saved_set, and copy the
remaining chunks without pinning?

> +
> +		/* faults the chunk pages in from the target cpu's NUMA node */
> +		memcpy(base + cpu * chunk_sz, obj->arena_percpu.chunk, chunk_sz);
> +	}
> +
> +	sched_setaffinity(0, set_sz, saved_set);

Does this final sched_setaffinity() actually give back the original state?
The kernel's sched_getaffinity() returns:

    cpumask_and(mask, &p->cpus_mask, cpu_active_mask);

so saved_set holds only the cpus that are active at the time of the call, not
the thread's full cpus_mask.  A thread with default affinity has a cpus_mask
covering all possible cpus, so after this call its cpus_mask shrinks to the
cpus that were online when the object was loaded.

Because the syscall sets SCA_USER, that snapshot is also stored as
p->user_cpus_ptr, and __set_cpus_allowed_ptr() clamps later cpuset updates
to it:

    if (p->user_cpus_ptr && !(ctx->flags & (SCA_USER | ...)) &&
        cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
            ctx->new_mask = rq->scratch_mask;

For example, take a vm with possible=0-63 and online=0-15, loading an object
that has .arena.percpu variables.  From then on the loader thread, and every
thread or process it creates afterwards (cpus_mask and user_cpus_ptr are
inherited), could never run on cpus 16-63, even after they are hot-added or
the cpuset is widened.  Before this patch, bpf_object__load() never touched
scheduling state.

The return value of this sched_setaffinity() is also ignored.  If it fails
(-ENOMEM from alloc_user_cpus_ptr(), or -EINVAL when a concurrent cpuset or
hotplug change leaves saved_set with no allowed or active cpus), the thread
stays pinned to the last cpu it was moved to, and nothing reports it.

The commit message and the function comment only cover the case where pinning
fails.  They do not mention changing or restoring the caller's affinity, and
no later patch in this series changes arena_percpu_populate().

Would doing the per-cpu copies in a short-lived helper thread avoid touching
the caller's thread altogether?  Otherwise, could the return value of the
restore at least be checked and reported with pr_warn()?

> +
> +out:
> +	CPU_FREE(saved_set);
> +	CPU_FREE(one);
> +	zfree(&obj->arena_percpu.chunk);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============1170969253696388872==--
