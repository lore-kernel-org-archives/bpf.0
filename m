Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126005695
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783141588; cv=none; b=ocxNH6GTipn4rJ6us0FRcVf8hKqC6tFIq6/pveDHQzDj9Z88S6N43JjCqJ0ySnyd9/kA34Rr5MgngZMv06szj/IYLgQP88ffMw+mlBIc2C2sqRhE8pHqT0A+uI02EDImrHg3BXnUembQhLapcZ3qHtdVd4MH8oJ+Rrr+2lQZ7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783141588; c=relaxed/simple;
	bh=TpikXZgnFFU6QwxVv/bkljNC3YzQlCKHASQTTzJKP4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WiPU+pUXZTd3cVBTvxlGeQQ31lmSqksLWRjaWj4qal14i2hRc+vJRxbfjE8k4gsfPPM7LmKZB4XqRMFuNYqTsNQUffLd/OwEq11GXbJ5yjBqzI/sP5nRf74nNVWoKMdKw9IH6+u3sksH66zEU9HaMzmOPdLhKSP0rCY+Qj8GCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZgJV8Qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZgJV8Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520011F000E9;
	Sat,  4 Jul 2026 05:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783141586;
	bh=+9q1HHnU8CBKHnzEoKlGNO5+AvBEMSLZrwfgYBwj0ZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZgJV8Qm7D9c1v5N+abqKBhv06DYfF8iq1nMLZ3P6SSPqBZ8aDGpMN4bi374AlAwB
	 7e+6RAj6/NFu2u9l6Bdgia4mvW0edyxCfkDTu4XESO0dDK5fBWLuJLsRpzIdBi9ee4
	 6bYju2m/W8p0m5C0QdxO6YJrC8IXGL1rrdxkXjtctZv3rMFL6CbaBvromgnqIv6XmC
	 Q+IVuSiaPkBQuXtqjJZ7Vg50pYyhkmTRenDMjhdfgzpmfcpkWVRgQl+LrOZwn6LQZa
	 xV6sYv/jJC9jNkwjpFy35D/AcX+VJ1xMkvXVKCwCriG7gEXgzKWOoz7DCWklJDt5BZ
	 wxD9ceulCw4Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] selftests/bpf: add memcg_stat_reader
 BPF-vs-memory.stat benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20260704045617.487664-2-ziyang.meme@gmail.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
 <20260704045617.487664-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 05:06:25 +0000
Message-Id: <20260704050626.520011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Multi-line comments in the BPF selftest header `memcg_stat_reader.h=
` violate the BPF subsystem comment style guidelines by not having the open=
ing `/*` on its own line.

Pre-existing issues:
- [High] The kfunc `bpf_mem_cgroup_vm_events` allows an out-of-bounds array=
 read due to a missing negative bounds check on its signed enum argument.
--

commit 4ae0facb76303e67faffbd1e910d6587123d09d6
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/bpf: add memcg_stat_reader BPF-vs-memory.stat benchmark

This commit adds a BPF selftest to benchmark reading memory cgroup statisti=
cs
by walking the cgroup subtree using a BPF program and comparing the cost
against traditional userspace file reads.

> diff --git a/tools/testing/selftests/bpf/memcg_stat_reader.h b/tools/test=
ing/selftests/bpf/memcg_stat_reader.h
> new file mode 100644
> index 0000000000000..72afebe95ccb8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/memcg_stat_reader.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#ifndef __MEMCG_STAT_READER_H
> +#define __MEMCG_STAT_READER_H
> +
> +/*
> + * One per-cgroup snapshot, produced by the BPF cgroup iterator and read=
 back
> + * from a BPF hash map keyed by cgroup id.  The "matched" subset is alwa=
ys
> + * populated so it can be compared field-by-field against what userspace=
 parses
> + * out of memory.stat / memory.current / memory.max.  The "full" fold is=
 only
> + * populated when collect_full is set and exists to (a) force the extra =
kfunc
> + * reads to happen (so the full-vs-matched timing is honest) and (b) giv=
e a
> + * coarse, informational signal of how many fields the full path touched.
> + */
> +struct memcg_stat_snapshot {
> +	__u64 cgroup_id;
> +
> +	/* Matched subset. Page-state values are in bytes (already unit-scaled
> +	 * by the kernel), so they compare directly against memory.stat.
> +	 */

[Severity: Low]
Does this multi-line comment follow the modern kernel formatting rules?
The BPF subsystem requires the opening /* to be on its own line, rather than
sharing a line with the comment text.

> +	__u64 anon;		/* NR_ANON_MAPPED, bytes */
> +	__u64 file;		/* NR_FILE_PAGES, bytes */
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/memcg_stat_reader.c b/tool=
s/testing/selftests/bpf/progs/memcg_stat_reader.c
> new file mode 100644
> index 0000000000000..a2c1b1b483646
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_stat_reader.c
[ ... ]
> +	/* Matched subset: always collected so correctness holds in both modes.=
 */
> +	snap.anon =3D bpf_mem_cgroup_page_state(memcg,
> +			bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));
> +	snap.file =3D bpf_mem_cgroup_page_state(memcg,
> +			bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES));
> +	snap.shmem =3D bpf_mem_cgroup_page_state(memcg,
> +			bpf_core_enum_value(enum node_stat_item, NR_SHMEM));
> +	snap.file_mapped =3D bpf_mem_cgroup_page_state(memcg,
> +			bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED));
> +	snap.pgfault =3D bpf_mem_cgroup_vm_events(memcg,
> +			bpf_core_enum_value(enum vm_event_item, PGFAULT));

[Severity: High]
This is a pre-existing issue, but does bpf_mem_cgroup_vm_events() prevent an
out-of-bounds read when a BPF program passes a negative event index?

Since the verifier does not check enum ranges, a negative value can reach
memcg_vm_event_item_valid() via this kfunc:

mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events() {
    ...
    if (unlikely(!memcg_vm_event_item_valid(event)))
        return (unsigned long)-1;
    ...
}

In memcg_vm_event_item_valid(), the index is compared against
NR_VM_EVENT_ITEMS using a signed comparison:

mm/memcontrol.c:memcg_vm_event_item_valid() {
    if (idx >=3D NR_VM_EVENT_ITEMS)
        return false;
    ...
}

Because both idx and NR_VM_EVENT_ITEMS are signed, a negative index bypasses
the check. This could allow the negative index to be used when accessing
the events array, resulting in an out-of-bounds read of kernel memory. Shou=
ld
memcg_vm_event_item_valid() include a check for negative values, or cast the
value to an unsigned integer?

> +
> +	/* page_counter fields need no kfunc; read them off the trusted ptr. */
> +	snap.usage_pages =3D BPF_CORE_READ(memcg, memory.usage.counter);
> +	snap.max_pages =3D BPF_CORE_READ(memcg, memory.max);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704045617.4876=
64-1-ziyang.meme@gmail.com?part=3D1
