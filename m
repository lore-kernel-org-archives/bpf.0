Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0260311C1D
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996768; cv=none; b=h3p60n1pVcvRktBPMSpWN4MqYg30dW75qBn3KmP+CmYUBGu2jEGjqNW8TKAVve17Jg8XtN6Cia5dVZ/9ta+cntQ/n3SFdbtb12e3CA9HSZhJNvN9rSVDBMF2qARR8cc8v7OC1QiyJLS/Q1tqCCBa47f4/Avz3BRsoSVvoS2Zvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996768; c=relaxed/simple;
	bh=kQmviInZ20D2HcK2kSSCt5cTmnk3+Fqqn7WkdZF+etA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQ8KHbHpG2NGCWCaPeGGwalk1aTKb9kmGBwt+Z6kKRUNwFTANnCfqJJvRc5FP0EIYlzz5gTkG4qieXKzH6+2C5KyWLxfZu4jYikeaaYDtrwcVlTdzW/EwtznzC3Y7AiAwD6fvGfSIbfHijzVLKb3ZdWWgmffuxpZzIjb7ZALnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDSfmHcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDSfmHcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A87F1F00A3A;
	Thu, 28 May 2026 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996766;
	bh=sP0pjsqk4PRboLtUNe+ZRBTRCAFBDrJ5uWAdSaA2rKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDSfmHcT+UBC/t10hBfnyTVvy5EUWHqsLPyOR1eIdUBzTAlAAcoljPjvphB+QvrOl
	 vz+0rWmsMxCLO7pmZZ4RUtujIA1Ms30cZZfcii2mWDIEoWlr8I4bh82VjA78Ad0GVU
	 +Cekf71JC0FIjIVPImAugFv59lkDF171OGEEDCBK3pvE//X3eTB28oCMECjVfLKvD0
	 BN6ObJpMGk4/QXaqsUCx3D25qt0DJwS5hcSl+cozzE5aF193MpzMjp3Knl3Zf+iFN3
	 u44J/lY2LraSN9m2Tc0LYW8qREKlD2fMIlrXzKffoQVno6GoEH4YO/UWRFnqVNke3p
	 LOh0XefmLqhRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/3] selftests/bpf: Stress LRU rqspinlock
 recovery paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-lru_map_spin-v1-3-4f52223170cf@meta.com>
References: <20260528-lru_map_spin-v1-3-4f52223170cf@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 19:32:45 +0000
Message-Id: <20260528193246.4A87F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `drain_and_refill` function fails to detect partial node leaks=
 because LRU map eviction transparently hides lost capacity.
- [High] Stack buffer overflow when using `CPU_SET` on systems with a large=
 number of CPUs.
- [Medium] Using glibc's `rand()` in concurrent userspace threads causes se=
vere lock contention, serializing the stress threads and defeating the test=
's purpose.
- [Medium] Unchecked return value from `libbpf_num_possible_cpus()` is used=
 to allocate Variable Length Arrays (VLAs).
- [Medium] Double close of the PMU perf_event file descriptors due to missi=
ng ownership transfer accounting.
--

commit de08c9fe543d53ce17c858bad1ef0cdae6fb41af
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Stress LRU rqspinlock recovery paths

This commit replaces the single-CPU NMI re-entry reproducer with a
parameterized stress harness to exercise LRU rqspinlock recovery paths.
It runs subtests against common LRU, per-CPU LRU lists, and per-CPU LRU
maps using multiple userspace threads and perf_event NMI BPF programs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c b/tool=
s/testing/selftests/bpf/prog_tests/lru_lock_nmi.c
> new file mode 100644
> index 0000000000000..15b6606fef4d4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c

[ ... ]

> +static void *hammer_thread(void *p)
> +{
> +	struct hammer_arg *a =3D p;
> +	__u64 val[a->nr_cpus];
> +	cpu_set_t cs;
> +	__u32 key;
> +
> +	memset(val, 0, sizeof(val));
> +	CPU_ZERO(&cs);
> +	CPU_SET(a->cpu, &cs);

[Severity: High]
Could this CPU_SET call write out of bounds on the stack?

The cpu_set_t structure is statically sized and often defaults to supporting
1024 CPUs. On machines with 1024 or more CPUs, setting a bit beyond
CPU_SETSIZE might corrupt memory. Would it be safer to use dynamically
allocated CPU sets via CPU_ALLOC and CPU_SET_S here?

> +	pthread_setaffinity_np(pthread_self(), sizeof(cs), &cs);
> +
> +	while (get_time_ns() < a->deadline_ns) {
> +		bool do_update =3D rand() & 1;
> +
> +		key =3D rand() % KEY_RANGE;

[Severity: Medium]
Will the use of glibc rand serialize these userspace threads?

Because rand uses a global internal lock to protect its PRNG state, calling
it in a tight loop across multiple threads pinned to different CPUs could
cause massive userspace contention. This might serialize the threads before
they enter the kernel and defeat the test's goal of stressing cross-CPU LRU
lock contention. Could a thread-local PRNG like rand_r be used instead?

> +		if (do_update)
> +			bpf_map_update_elem(a->map_fd, &key, val, BPF_ANY);
> +		else
> +			bpf_map_delete_elem(a->map_fd, &key);
> +	}
> +	return NULL;
> +}

[ ... ]

> +static int drain_and_refill(int map_fd, int nr_cpus)
> +{
> +	__u64 val[nr_cpus];
> +	__u32 key;
> +
> +	memset(val, 0, sizeof(val));
> +	for (key =3D 0; key < KEY_RANGE; key++)
> +		bpf_map_delete_elem(map_fd, &key);
> +
> +	for (key =3D 0; key < MAP_ENTRIES; key++)
> +		if (bpf_map_update_elem(map_fd, &key, val, BPF_ANY))
> +			return -ENOMEM;

[Severity: High]
Does this check reliably detect partial leaks in an LRU map?

Since this is an LRU map, if the usable capacity shrinks (for example, to 63
due to a leaked node), the 64th insertion will likely not fail with -ENOMEM.
Instead, it will evict the first inserted element and succeed.

Should the test perform lookups for all inserted keys after this loop finis=
hes
to ensure none were prematurely evicted, in order to accurately verify that=
 no
capacity was lost?

> +	return 0;
> +}
> +
> +static void run_variant(enum bpf_map_type type, __u32 map_flags,
> +			const char *name)
> +{
> +	struct perf_event_attr attr =3D {
> +		.size =3D sizeof(attr),
> +		.type =3D PERF_TYPE_HARDWARE,
> +		.config =3D PERF_COUNT_HW_CPU_CYCLES,
> +		.freq =3D 1,
> +	};
> +	int nr_cpus =3D libbpf_num_possible_cpus();
> +	int pmu_fds[nr_cpus];
> +	struct bpf_link *links[nr_cpus];

[Severity: Medium]
What happens if libbpf_num_possible_cpus returns a negative error code?

Passing a negative size to these variable length arrays would result in
undefined behavior and immediate stack pointer corruption. Should we check
if nr_cpus is positive before using it to declare these arrays?

[ ... ]

> +	for (i =3D 0; i < nr_cpus; i++) {
> +		pmu_fds[i] =3D syscall(__NR_perf_event_open, &attr, -1, i,
> +				     -1, 0);
> +		if (pmu_fds[i] < 0) {
> +			if (i =3D=3D 0 &&
> +			    (errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP)) {
> +				test__skip();
> +				goto cleanup;
> +			}
> +			continue;
> +		}
> +		links[i] =3D bpf_program__attach_perf_event(skel->progs.oncpu,
> +							  pmu_fds[i]);
> +		if (!links[i]) {
> +			close(pmu_fds[i]);
> +			pmu_fds[i] =3D -1;
> +		}
> +	}

[Severity: Medium]
Could this result in a double close of the PMU file descriptors?

When bpf_program__attach_perf_event successfully attaches, the returned
bpf_link takes ownership of the perf event file descriptor and will close it
automatically during bpf_link__destroy.

Since pmu_fds[i] isn't set to -1 on a successful attachment, the cleanup lo=
op
later in the function will call close on pmu_fds[i] after bpf_link__destroy
has already closed it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-lru_map_sp=
in-v1-0-4f52223170cf@meta.com?part=3D3
