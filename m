Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4683F7ABE
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661005; cv=none; b=St/rVvRdVMmRscFq0wW1h1fVAdHDVxR4QuttU/Tndr5Qv4AMsdBNMk1Bh2lL6NBMBU+5qO8+wUBbkAQG0WP+hSmqqKFNb7O3aITK01ke/TLUmIgixbJU63yvU8Tcg8E8g4P/cZpx8UJ4P2NNUSXp1VxExwJxEvOxny7Zt2IwZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661005; c=relaxed/simple;
	bh=d4PwBW21g4Ve1O5g7jGKmONknIFdCBpqKFa8o5bREgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqaLfxymfGaSodL1djbjNYYpRQ81wrS/qPqq9tMWsAlyyDAURjKGsWlZL8kuOFZ9QvfB7qPzRXtVsp6L+aLAVbiJxy9DO5rwPBIt0PLeMTgn/r9t3NTu7sW94XGhVRhNhwPb7Dr7VI2EgyNbJ5Pw0SArLgHQQ873Hje3kAu2wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeHcWj5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeHcWj5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE651F00893;
	Fri,  5 Jun 2026 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661004;
	bh=I5uZzzI1hku2tP7ET9pUS0VXgKOx7ws46o0iwlasAt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BeHcWj5oODPvHhDzfhv/wsX7GKas/g9SKEskZY/Ge+3862JEcmpsV4DxLXPSumMsJ
	 zB3c8zwr2fkMTAAsz06OgyciT/rBiH6omkpVV4mP32XE1o0mVwRTq2Pwjke0s2meL+
	 6VQPyKtxWBuRoqadcRdNH2qVHCFus7KcVBUyhr3uEr9L9Eb3jV6xzx3mbrYONBmofd
	 sLrVmGsZWtvmkQbO/2DPCGh1nAroxccbSVa9VMA23kJ7+ycZzqGfKfIRjC5KxVB+Ro
	 kGVfeff3U0BcgPQcIrg5owXXHmX+Su9BpMTViDXbKIeu7OHJhs2uuu72pMiW2zJH8P
	 i5UUTSDcM3I8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 12/12] selftests/bpf: Add resizable hashmap
 to benchmarks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605-rhash-v7-12-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-12-5b8e05f8630d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:03:23 +0000
Message-Id: <20260605120323.DBE651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The bpf-rhashmap-full-update benchmark measures the -E2BIG error=
 path instead of successful map updates, invalidating the commit message's =
performance claims.
--

commit c016012bca8439800d9763b0e9dbdba68b4e1642
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add resizable hashmap to benchmarks

This patch adds support for resizable hashmaps in BPF map benchmarks.
It claims a 5.25x speedup for rhtab over htab during full updates.

>     2. FULL UPDATE  (M events/sec per producer)
>    =20
>       htab  per-producer:
>         20.33   22.02   19.27   23.61   24.18   23.17   21.07
>         mean  21.94   range  19.27 - 24.18
>    =20
>       rhtab per-producer:
>        133.51  129.47   74.52  129.29  102.26  129.98  107.64
>         mean 115.24   range  74.52 - 133.51
>    =20
>       speedup (mean): 5.25x   (+425 %)
>    =20
>     In-place memcpy avoids the per-update alloc + RCU pointer swap
>     that htab pays.

[Severity: Medium]
Are these benchmark results measuring successful updates, or just the speed=
 of
the -E2BIG error path?

In tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c:hashm=
ap_full_update_setup(),
the userspace setup pre-fills the map to its maximum capacity:

    /* fill hash_map */
    map_fd =3D bpf_map__fd(ctx.skel->maps.hash_map_bench);
    max_entries =3D bpf_map__max_entries(ctx.skel->maps.hash_map_bench);
    for (i =3D 0; i < max_entries; i++)
        bpf_map_update_elem(map_fd, &i, &i, BPF_ANY);

The BPF program then attempts to insert a new key that doesn't exist in the=
 map
in tools/testing/selftests/bpf/progs/bpf_hashmap_full_update_bench.c:benchm=
ark():

    u32 cpu =3D bpf_get_smp_processor_id();
    u32 key =3D cpu + MAX_ENTRIES;
    ...
    bpf_loop(nr_loops, loop_update_callback, &key, 0);

Because the map is already full, does every update attempt immediately fail=
 with
-E2BIG without performing any updates or memcpy?

For htab (which preallocates), returning -E2BIG requires a slow fallback
traversal of all other CPUs' empty freelists. For rhtab (no prealloc), it is
a fast atomic check against the element count.

Does this regression mean the benchmark is comparing the speed of error pat=
hs
rather than successful map updates, which might invalidate the performance
claims?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rhash-v7-0=
-5b8e05f8630d@meta.com?part=3D12
