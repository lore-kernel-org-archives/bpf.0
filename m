Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EC358363
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792021968; cv=none; b=aj/hhMt4FmdxPgA5DNfJUA4vfQ4SISbL3cie0NPU0jx+mS9xoxa6XXkpVBNUdJxxLWXsu+DICSTa8IdvjWzo7/ToaitzyCLSIEQDO1AMLqpTbxFTX3Dfbx9YZ9FU16c08jmTTFDYr9g71/kwCwgfQLDODmumzaAk0R0R1hpuqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792021968; c=relaxed/simple;
	bh=IRCnxzI948S5Og4ZhtiZtAWYE+6UtOp5H0yeU5aw+RU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=asoaElTQ7QD/MyG4oINo2paksBGbAikY5s6A0lMWphfNb3YkSOhUgV0XldLRQofEtmrH1XBBuLWgWlWyfjLvEKJYstp3xNAedwD14JnDTA82QeBvJuyn4xAcHOp4wCCwtCs7llR411p/cB1MsrgY28fO72AHkcLd6cFxSI9UxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxO76Dqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxO76Dqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEAC1F000C4;
	Wed, 14 Oct 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792021967;
	bh=P2ZHEa72eEAqgBIyJ0HB2fj+nWXSh8yaVXs+lTcf2BQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gxO76DqsLksKTseQPf7SsGS0RZi7QGUTEq8BQfpjcnJDc6LbfQpztSs03r5R2bE8c
	 BEYS/ACXge2JXcE2t2PMjFsfa/g3c6JWl1myGO3MdwnMC66UPF4we1uC28CJsyC5Gx
	 Kry9mle46R0dbYj/NKF0Ad/0cF9+FC0tQsSci+dCb8ubIxKSFA4fPtcfeUcEgqzWWW
	 1xoyQ7KqNLzH3O2INunzwqaEYvPgwtbUKO9bIrE0tNub1ai2XeNM3NInz75rfhbaJE
	 SwX5AkCUEldRCj8kipHh/PpW/S8j9mnqKVOFBER/94eicJUWimROQ4/f3Vdv+QGI/r
	 GqrpKL0SjgIzQ==
Message-ID: <sashiko-outbox-172035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: Add arena allocation
 race tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261014233442.8392-9-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <20261014233442.8392-9-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 23:52:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: bpf_alloc_page() leaks uninitialized kernel memory to use=
r space
--

commit 367216c19f195164e634a02e469d1a5439a1941c
Author: Emil Tsalapatis <emil@etsalapatis.com>

    selftests/bpf: Add arena allocation race tests
   =20
    Add selftests for arena allocation, teardown and fault races.

>     Cover unavailable ranges and kernel/user mapping coherence during
>     synchronous and deferred frees and concurrent faults.

[Severity: Critical]
While testing concurrent faults, does the allocation fallback path leak
uninitialized kernel memory to user space?

Looking at kernel/bpf/syscall.c:bpf_alloc_page(), it omits the __GFP_ZERO f=
lag
on the fallback path:

	if (!sleepable || !can_alloc_pages())
		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);

When preallocation fails in kernel/bpf/arena.c:arena_vm_fault(), the fault
handler falls back to the non-sleepable allocator:

	new_page =3D bpf_alloc_page(map->numa_node, false);

When sleepable preallocation fails due to memory pressure, or when a
non-sleepable BPF program allocates arena pages, the non-sleepable allocator
returns an uninitialized page.

Since the BPF arena is memory-mapped into user space, this allows
unprivileged users to read stale physical memory contents. Furthermore, on
PREEMPT_RT kernels, can_alloc_pages() is always false, so every arena
allocation unconditionally leaks uninitialized memory.

Also, regarding the behavior of concurrent faults, transiently missing pages
appear to correctly return VM_FAULT_NOPAGE or trigger a retry rather than
causing a fatal signal. In kernel/bpf/arena.c:arena_vm_fault():

	if (ret =3D=3D -EAGAIN) {
		/* Non-retryable GUP callers recheck the PTE on NOPAGE. */
		if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY)) {
			fault_ret =3D VM_FAULT_NOPAGE;
			goto out_err_locked_memcg;
		}

Is the premise that concurrent faults cause a SIGBUS crash inaccurate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014233442.8392=
-1-emil@etsalapatis.com?part=3D8
