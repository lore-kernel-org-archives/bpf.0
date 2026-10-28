Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153596;
	b=i+XAObc5Ky4+VzLHed9bmo8teuYfq6RNlqNJhbTHtl13hlDX0fot9WZ9qVv7w5727Vk7
	 5M168kGIRaN4TZ4uuqJiYn2YRzGybw+I5Y7U2htXa3NGOLeMdowhJ624XOLPnvQ9IhBwj
	 1N/HO45mrcGXqAzPi6LnXfRGq2ZdhTuTIEQ2g5IddmCgY23u9Z+PFgGphNh+aYgo52Jip
	 QKsJ5DVOiLPh05AwFrwu2U9je3mzwbf7aOmp8tbnUpTOhb/zwmOl2wKKpTynNBFZ3k3Of
	 AG1Vis+7KQnMgpuVfwn43xk35L1zJ6MBWuxflbd1O++HGwGBu6fNKlSwV4jWanQZJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B281A5UtD1HWZTU2KjkcuaKvgtDD+lh7fik3l2I45lU=;
	b=QnAhCbfZl/2T+z9X5wenhtVoFAUW0ilb040mbi+6Zyo0A09cz6PQfnebGGEE8e0pTO03
	 FP1yIFPVmzFhsgwa0HpWv1FqFBLwIyppH3WL/khzcQrWEaASr8P1NUCeX3zuwobLpIZUK
	 GDgEYaf0jetRwDGIIRdmK7dbwUGZFxsc0cL2b0cIY9lU+1zZ/zV8RnNnLPMexH8dPwFut
	 fmENAIV9kaKIeUNuIxjXXsoCgFNew2ayAh2bcCBTU/1/5Zy+H9sa4G4NapFPOQR68+klc
	 2aPHORbRMyd16rosfhjNIf2G5hqHds22ub7BLqmZp7BjWuJIZD1Y6Hi4BrJ6UVYR7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfNqHlxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC89606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfNqHlxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29531F031E2;
	Wed, 28 Oct 2026 02:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793153596;
	bh=B281A5UtD1HWZTU2KjkcuaKvgtDD+lh7fik3l2I45lU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RfNqHlxzKE8tZgozPgWvmUzR/6fhkUjqm4S4YTZzWa6Vxhy6bh6Q5kI7GivnFv1jU
	 JZmD+OUpMY8BfjC6l6J0/ENNvNw0CSG6kX51lD8Wowjjr1VDJY7xMK2a1780OHNAGO
	 5F3/LZTMI6WzEiwctAOy+Nrg0341lZ2vO+zHb5OmBTq/IbFE4O7E1w4MyIrIu4BcL8
	 bkFJMciXwb2wehM4Jq550OF618AGzp/9y/Khdm8ds9eO3eD+bpsYXfRT+Zf77jf7Lh
	 qoo7XmHrnHNkmwp9b6ZZ2k1Ilo/rViXRjPKbp+S4O3bkwOtyCoAdlC96hi5zKLdhWY
	 VP3dKIqC1cEpw==
Message-ID: <sashiko-outbox-187334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add arena fault recovery tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261028015141.10710-3-emil@etsalapatis.com>
References: <20261028015141.10710-1-emil@etsalapatis.com>
 <20261028015141.10710-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 02:13:15 +0000
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
- [Medium] selftests/bpf: unguarded arena dereference in arena_fault breaks=
 no_alu32/bpf_gcc
--

commit 35e23b7a99b662f29a7ebcdbbc98176bb46d1150
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: add arena fault recovery tests

This commit adds two BPF selftests and a supporting test kernel module to
verify arena page fault recovery when accessing an unbacked arena page from
a program with no arena or a program with a different arena map.

> diff --git a/tools/testing/selftests/bpf/progs/arena_fault.c b/tools/test=
ing/selftests/bpf/progs/arena_fault.c
> new file mode 100644
> index 0000000000000..1967b128fdf69
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_fault.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +#include "../test_kmods/bpf_test_arena_fault.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 2);
> +} arena SEC(".maps");
> +
> +u64 __arena arena_pad;
> +volatile u64 observed;
> +
> +SEC("syscall")
> +int stash_and_free(void *ctx)
> +{
> +	u64 __arena *val;
> +
> +	val =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!val)
> +		return 1;
> +
> +	*val =3D 42;
> +	bpf_test_arena_fault_stash((u64 *)val);
> +	bpf_arena_free_pages(&arena, val, 1);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int fault_stashed_wrong_arena(void *ctx)
> +{
> +	u64 __arena *val;
> +
> +	val =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!val)
> +		return 1;
> +
> +	*val =3D 1;

[Severity: Medium]
Will stash_and_free() and fault_stashed_wrong_arena() fail BPF verification
under test_progs-no_alu32 and test_progs-bpf_gcc when __BPF_FEATURE_ADDR_SP=
ACE_CAST
is not defined?

In tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h, __arena
only includes __attribute__((address_space(1))) when
__BPF_FEATURE_ADDR_SPACE_CAST is defined:

#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
#define __arena __attribute__((address_space(1))) __attribute__((btf_type_t=
ag("arena")))
...
#else
#define __arena __attribute__((btf_type_tag("arena")))

When tools/testing/selftests/bpf/Makefile builds test_progs-no_alu32 (with
-mcpu=3Dv2) or test_progs-bpf_gcc, __BPF_FEATURE_ADDR_SPACE_CAST is not
defined. Without __attribute__((address_space(1))), the compiler does not
emit a BPF_ADDR_SPACE_CAST instruction before dereferencing val in
*val =3D 42 and *val =3D 1.

Because bpf_arena_alloc_pages() returns void * in kernel BTF,
check_kfunc_call() in kernel/bpf/verifier.c leaves R0 typed as SCALAR_VALUE
until BPF_ADDR_SPACE_CAST converts it to PTR_TO_ARENA in check_alu_op().
Without that cast, check_mem_access() rejects the stores to *val as invalid
scalar memory accesses, causing arena_fault__open_and_load() in
test_wrong_arena() and test_no_arena() in
tools/testing/selftests/bpf/prog_tests/arena_fault.c to fail instead of
skipping.

Should the arena pointer dereferences in progs/arena_fault.c be guarded by
#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) (with the runner skipping when
unsupported), similar to other arena selftests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028015141.1071=
0-1-emil@etsalapatis.com?part=3D2
