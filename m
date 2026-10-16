Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615185650FA
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171288; cv=none; b=sqwIGmztCZLW3dFfyRyZofV9O6rH3skJxsuZQR9I66CaVwxT4yE3lUD9RaB2EL+GoqcYdLOL76eW3UoLk33nU9DgQKIZXaUJ2gBrEkdqvfR/TZUyLjDbBhqEVhl6zxs7rYcBsJTjt6fxla3MbPeKhbT45ZYjv2zNK7DJeVP8vwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171288; c=relaxed/simple;
	bh=vKdcFacvYBWaNrrWSFQIjmej3w4ReFDif5XM7lfu8iw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=OGkYI1YQCdtUL40kmuKUYankU5dffBDYi9ySKK91Rie2CH8oFkN1VBjdnJzpXRWj62sR2xq0HtJJNZQXHma7JDVinFh1RSHr3vzYpSUuO46NoDDNWn4xYJJZXwtFlq7jbwy+wz/h1f3u9QIil4skndKsjY66UPJuKobLrQ0hdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7UrhW8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7UrhW8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58A01F000C4;
	Fri, 16 Oct 2026 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792171287;
	bh=18kVp+xF39fu/uP6Klmq+m/ALMfY/rFLsHPZrtNc7/w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=K7UrhW8bfkoe72+0CF6Ro2655DK3fqdky3bzmMt9jHdG+D1U5vz22GwhWBis5sMnB
	 SPP/CPIbe47DkUuoqXOMPmEwE7dbedqecGihRpwId8lM+MepR8wW5V0SbbIYmhUUuG
	 1jVrEUL0na/JbTLe9H4AfgI+upb+5iEHi/6TJLATnGnRYKWwzluHw+QOMZ95ZvZ4lm
	 1nbeGaLJXoMRjkUB/52XZAUmp9ZxRNJ4jHBlnsJtseaX/ppYR+AnVBuER57/iLGRvT
	 Woywq4ozTtO0WHHDmZnHhgLF9/C9alRagb61fJrnO0VdKw+1VF6m8Ex58Xs/4rEzL8
	 QkXksxcPRRZYA==
Message-ID: <sashiko-outbox-174717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Test fetching AND/OR/XOR
 atomics in arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261016171319.1623447-3-puranjay@kernel.org>
References: <20261016171319.1623447-1-puranjay@kernel.org>
 <20261016171319.1623447-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:21:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: uaf test silently passes on ARM64 instead of skipping
--

commit a4f52eddc0e670a7a41a5b1939916ca84274f849
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Test fetching AND/OR/XOR atomics in arena
   =20
The arena and/or/xor tests never exercised the fetching form of the
instruction. Commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics
failure due to llvm change") deliberately switched them to
__c11_atomic_fetch_*() with memory_order_relaxed, which clang lowers to a
non-fetching locked instruction when the result is unused, because
x86-64 could not JIT the fetching one against an arena.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/too=
ls/testing/selftests/bpf/prog_tests/arena_atomics.c
> --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
[ ... ]
> @@ -160,6 +199,18 @@ static void test_uaf(struct arena_atomics *skel)
>  		return;
> =20
>  	ASSERT_EQ(skel->arena->uaf_recovery_fails, 0, "uaf_recovery_fails");
> +
> +#ifndef __powerpc64__
> +	/*
> +	 * A fault clears the fetched register and leaves the address alone. The
> +	 * powerpc64 JIT does not clear the register of a faulting atomic yet.
> +	 */
> +	ASSERT_EQ(skel->arena->uaf_r1_after_dst_r0, 0, "uaf_r1_after_dst_r0");
> +	ASSERT_EQ(skel->arena->uaf_r0_after_dst_r0, skel->arena->uaf_r0_before_=
dst_r0,
> +		  "uaf_r0_after_dst_r0");
> +	ASSERT_EQ(skel->arena->uaf_r0_after_src_r0, 0, "uaf_r0_after_src_r0");
> +	ASSERT_EQ(skel->arena->uaf_reread, 0, "uaf_reread");
> +#endif
>  }

[Severity: Low]
Does this test silently pass on ARM64?

In the uaf program in arena_atomics.c, the fault testing logic is compiled
out when __TARGET_ARCH_arm64 is defined:

#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
	defined(__BPF_FEATURE_ADDR_SPACE_CAST)

Because the BPF program does nothing on ARM64, the global variables
(uaf_r1_after_dst_r0, uaf_reread, etc.) remain untouched and hold their
zero-initialized default values. The host runner here unconditionally
asserts that these variables equal 0, which makes the assertions
tautologically succeed on ARM64.

Could the BPF program export a flag so the userspace runner can explicitly =
call
test__skip() when the test is unsupported, instead of silently passing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016171319.1623=
447-1-puranjay@kernel.org?part=3D2
