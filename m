Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505574;
	b=PIOWZRgDXndtXx+tyxKilHI6AzMP/H6U8w952wpiZmf2oUHjQmO6xuhKIhm9x+sdBJZo
	 GNGX99F8ROJz8VhULYcLySBm4aHZXE+EYYxMQnSZ1KZyHRq6c4ZufvEw1zsnD1elvtoAR
	 /qStkv+b4ZWufWyMhnKV+orNbaOJHW4Klz9D/E0ROv92GyXwRyy4gsF8vh5aBBaLsT4QC
	 oaINbMRlVFicjhCOhj8+9xEv1uW65wgacvtJ+q6Hm4C4eUblnMol9NttCqs8JT2UpSEmu
	 9wTeryEyJgOdkMG0H7j5a/mBBA1BKCfs1pdQIyeispeOqyo5sTJ73IysuD2lRQOR6IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MwOeW89lQ65+WUWrkke0YgzcewxmuJACDAnj3RCGBTw=;
	b=JFydu1UXDvX7BqPCydPKT/DTjGolYNLuiHCnLH/BLHkMAuGjtvBo/DNFAJYjinG0d1s4
	 9/oZaDhsC6nqrjwa7GTlzLHi42HVeUjf5kw/avyp4WOxeJG0IF/HMLfKJjsyzjITr7vPy
	 CDi7rX1nw1e5P0aJqs0PMBzKnLWNgFGS9dLY0CxIbalw4R6rE9q8CL58IhSdrzHlgif41
	 OxOXSc0D8CECTDk03UgP4MEkc6m4QyppA9fvr2Cm1qpdp/lsikHURXISCGvRjyl/5zr9N
	 ilIZWZIb7t9GXYvT74Y2hDkiwfD47cJj4KRoT5QwCTbt79Gm9LL3JMfUg5D681ZC0Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lim5kEyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89570606A31E
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lim5kEyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D231F000C4;
	Tue, 20 Oct 2026 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505574;
	bh=MwOeW89lQ65+WUWrkke0YgzcewxmuJACDAnj3RCGBTw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lim5kEyfXVEJj4734txsPvjnHAcrQcRbkp6NdE4hxv8N5PKZSRwGtDEWOqekL6RUD
	 4Poe4t2z0z3IORINzV0Rrzth/1gDo86ToFmhnynSnecFAD/Htoknpta0F2Fs95EVNs
	 oAJ1Y3wQBWF6YtC8i4b7+UF5GYUtlI3qz8Mjm6lPtkOmmMZeKX0M1gjal51VRTs+PZ
	 vPyeJsef5jwbkpk+Napf/H9LuVlV/da7zRTK6nKvPYYOJCSoNNQrs/qVnGH1JQeyoT
	 agqHZSt3YCzy6jKw+rIcvg2PHC9x/RjPCPf+4I7606XsdDD1apvfn4Uhzc6UTeVm3X
	 fo6z0aN2iYNBg==
Message-ID: <sashiko-outbox-179095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 14/16] selftests/bpf: Add test for arena
 percpu-only object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <f7f725d0057be520ec5fb417f3f7d3a1e2c765fe.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <f7f725d0057be520ec5fb417f3f7d3a1e2c765fe.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:12:52 +0000
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
- [High] selftests/bpf: mismatch between __arena_percpu addr_space_cast and=
 verifier
--

commit 978ace4d7c1590716d35b8badc4a0e110474bd79
Author: Xu Kuohai <xukuohai@huawei.com>

selftests/bpf: Add test for arena percpu-only object

This commit adds the __arena_percpu macro to bpf_arena_common.h along with a
selftest for an object containing only an arena per-cpu variable.

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_commo=
n.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
> index 82aafe879fae2..7cdee141764e7 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
> @@ -35,11 +35,13 @@
>  #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_A=
SM)
>  #define __arena __attribute__((address_space(1))) __attribute__((btf_typ=
e_tag("arena")))
>  #define __arena_global __attribute__((address_space(1)))
> +#define __arena_percpu __attribute__((address_space(1))) __attribute__((=
section(".arena.percpu")))
>  #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
>  #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
>  #else
>  #define __arena __attribute__((btf_type_tag("arena")))
>  #define __arena_global SEC(".addr_space.1")
> +#define __arena_percpu SEC(".arena.percpu")
>  #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
>  #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
>  #endif

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_percpu_only.c b/tool=
s/testing/selftests/bpf/progs/arena_percpu_only.c
> new file mode 100644
> index 0000000000000..35e4ff983e65d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_percpu_only.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Huawei Technologies Inc. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +} arena SEC(".maps");
> +
> +__u64 __arena_percpu counter =3D 0x123456;
> +
> +SEC("syscall")
> +int arena_percpu_only_write(void *ctx)
> +{
> +	counter =3D bpf_get_smp_processor_id();
> +	return 0;
> +}

[Severity: High]
How does __arena_percpu interact with the verifier and JITs across the two
branches in tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h?

First, when compiled without __BPF_FEATURE_ADDR_SPACE_CAST (such as under
test_progs-bpf_gcc or when BPF_ARENA_FORCE_ASM is defined), __arena_percpu =
is
defined without address_space(1), and arena_percpu_only_write() assigns to
counter unconditionally without #ifdef __BPF_FEATURE_ADDR_SPACE_CAST or
cast_kern().

In that configuration, the compiler emits a BPF_LD | BPF_IMM | BPF_DW
instruction (relocated by libbpf to BPF_PSEUDO_ARENA_PERCPU) followed direc=
tly
by BPF_STX | BPF_MEM | BPF_DW without an rX =3D addr_space_cast(rX, 0, 1)
instruction. Unlike BPF_PSEUDO_MAP_VALUE on an arena map (which check_ld_im=
m()
marks as SCALAR_VALUE so the verifier rejects uncast dereferences),
check_ld_imm() in kernel/bpf/verifier.c marks BPF_PSEUDO_ARENA_PERCPU direc=
tly
as PTR_TO_ARENA, and bpf_convert_ctx_accesses() rewrites the store to
BPF_STX | BPF_PROBE_MEM32 | BPF_DW.

However, check_and_resolve_insns() resolves the 64-bit immediate of
BPF_PSEUDO_ARENA_PERCPU to the full 64-bit arena->user_vm_start + off (with
insn[1].imm =3D addr >> 32), and the x86 and arm64 JITs load this full 64-b=
it
immediate and add smp_processor_id() * chunk_sz using 64-bit addition witho=
ut
clearing the upper 32 bits. Without addr_space_cast(rX, 0, 1) (which
bpf_do_misc_fixups() rewrites to a 32-bit wX =3D wY move to zero the upper =
32
bits), the upper 32 bits of the PTR_TO_ARENA register remain
user_vm_start >> 32. When test_arena_percpu_only() in
tools/testing/selftests/bpf/prog_tests/arena_percpu.c runs
arena_percpu_only_write(), BPF_PROBE_MEM32 adds the 64-bit kern_vm_start to
this 64-bit register, targeting kern_vm_start + user_vm_start + off +
cpu * chunk_sz outside the arena's 4 GiB kernel vmalloc area.

Second, when __BPF_FEATURE_ADDR_SPACE_CAST is defined, __arena_percpu has
__attribute__((address_space(1))), which causes Clang to emit
rX =3D addr_space_cast(rX, 0, 1) immediately after BPF_PSEUDO_ARENA_PERCPU.=
 In
check_alu_op() in kernel/bpf/verifier.c, addr_space_cast calls
mark_reg_unknown() on dst_reg, which zeroes dst_reg->mem_size and resets the
chunk offset pos set by check_ld_imm():

kernel/bpf/verifier.c:check_alu_op() {
    ...
	if (bpf_insn_is_addr_space_cast(insn)) {
		...
		/* convert from ptr_to_arena to scalar or vice versa */
		mark_reg_unknown(env, regs, insn->dst_reg);
    ...
}

Doesn't this wipe out dst_reg->mem_size and bypass the per-cpu chunk bounds
check in check_mem_access()?

> +
> +char LICENSE[] SEC("license") =3D "GPL";

[ ... ]

>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D14
