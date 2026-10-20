Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505850;
	b=D2V3LGlhpj1xU+dEb0PwNAVCl+62N6hLjDPP2nyePLHxaF2E2RNfrzRzQZkegDEAKZKF
	 BNgu6IQShRO6ct6wJdGZEZToqoyIUeP3vZp8g8xCSKtzPOJPv8/3XfoOPuD0BjaonxT3Z
	 +y+lmBaaLasYBpHuwDYPdnTKsFADF3Lh/oejwlt03r8wgsOQuMqa0c3MnAYxmVAH6kWdP
	 7rpB5eTK0aVpzIRGgjCyCfy/ARyIgApO9TEybgcTVtIuF3lxKVeb/lfB4IbfLdlBi51z8
	 jKe3oixBMAEc4/EBaIaeqYF10VLTqbI4pe1b3UjMb07TxAkfOy8CB6K77sC1/N2KmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505850;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=FIuwE2PGaY92yYLJg1ozwjEZ5BPB6OWvqekeMNIQNfI=;
	b=4Ybui8Qtb29ovfAsyiSryVMHVMVnaRT9A5eisAEKe2ZHcKBntk40b9342yLv8AmIKkZk
	 rTp82uwpD0OCTgdKMUGWep24f0HZQAfmyBpbhyAwhRURsgqWJ8g9uTcyiy14xpyR6AoxH
	 vB3tUJfNs8V3zBjvsVFylEHfXsbaNwgZhPU+BaNgZoFup+alO4JOSREim4nYQAup+b7fu
	 P1dpBRwcc2FO4HLW0w+4Nt20Wed5SGPMBg1/COotiq5ELEhvoJ79bw5vMYKw33D8r8onk
	 VpCjPg1Hi3+tQbRjPUZbek+Zw+sFKrXujrhqIS1BNo8FFSSGmPhKMbFaCt8E6L2Ybww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJ7w9Mqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69640606C210;
	Tue, 20 Oct 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJ7w9Mqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E31F000C4;
	Tue, 20 Oct 2026 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505845;
	bh=FIuwE2PGaY92yYLJg1ozwjEZ5BPB6OWvqekeMNIQNfI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iJ7w9MqrjN4iDtwKyL25IdnCbxJKvf/vyntFItkmZiejHO/sP9RNQpuZixRA/QSog
	 NRohsavOcXGItTBv5W/Qkyn9pECDGfC8XEwmEP6b8yV7HlD/TbKYRMbsFZfnIleSOx
	 g2dhr61kliGvJXYMEQmUf2Z8Vvea3KIKJHfr0Q+CqY7Cvy1qNIKlBH8jiLvBa1usS6
	 LHl7C8d1p1kKz7ykACsdI3eVxKjeQ+8N1ysu6heJW8rwd0fnQ2t/zOgF6sgjrD1Gyv
	 CC52sF/pssoA85IqWI2jUrhYI8GdJjBQkoaasM5PtgrMmXr5yYO5geUSakFRCum/kZ
	 NymKoYtGsRFpQ==
Content-Type: multipart/mixed; boundary="===============2483452175354941989=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b3d8bb8499c3546d31a08e162fcca31042c7eac583c454d49db1d38fa42bc3fd@mail.kernel.org>
In-Reply-To: <f7f725d0057be520ec5fb417f3f7d3a1e2c765fe.1792503001.git.xukuohai@huawei.com>
References: <f7f725d0057be520ec5fb417f3f7d3a1e2c765fe.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 14/16] selftests/bpf: Add test for arena percpu-only object
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:25 +0000 (UTC)

--===============2483452175354941989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for arena percpu-only object

TL;DR:
- arena_percpu_only.c lacks an addr_space_cast gate, so in the fallback config
  the store may hit a user address and oops the kernel
- test skips silently without a reason (minor)

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
> index 82aafe879fae..7cdee141764e 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
> @@ -35,11 +35,13 @@
>  #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)

[ ... ]

>  #else
>  #define __arena __attribute__((btf_type_tag("arena")))
>  #define __arena_global SEC(".addr_space.1")
> +#define __arena_percpu SEC(".arena.percpu")
>  #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
>  #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
>  #endif

In this fallback branch (clang without __BPF_FEATURE_ADDR_SPACE_CAST, or
with BPF_ARENA_FORCE_ASM), __arena_percpu only selects the section, so no
addr_space_cast is emitted for accesses to the variable.  Can the access in
arena_percpu_only.c work in this configuration?

    __u64 __arena_percpu counter = 0x123456;
    ...
    counter = bpf_get_smp_processor_id();

This compiles to roughly:

    r1 = counter ll
    *(u64 *)(r1 + 0) = r0

with no cast_kern() between the two instructions.  libbpf turns the ld_imm64
into BPF_PSEUDO_ARENA_PERCPU, and resolve_pseudo_ldimm64() fills in the full
64-bit value from arena_map_direct_value_addr(), i.e. user_vm_start + off.
check_ld_imm() still types the register as PTR_TO_ARENA:

    __mark_reg_known(dst_reg, pos);
    dst_reg->type = PTR_TO_ARENA;
    dst_reg->mem_size = bpf_arena_percpu_chunk_sz(map);

so the verifier accepts the store, and the fixups turn it into
BPF_PROBE_MEM32.  The x86 jit emits PROBE_MEM32 as [reg + r12 + off] using
the whole 64-bit register, while the arena layout in kernel/bpf/arena.c
assumes that register holds only the lower 32 bits of the user pointer.

Using the example values from the comment in arena.c, user_vm_start
0x7f7d26200000 and kern_vm_start 0xffffc90001e69000, the store targets
0x0000487d28069000.  That is a user-space address and not in the arena.

On x86 with supervisor-mode access prevention enabled, a supervisor access
to a user address goes through do_user_addr_fault() -> page_fault_oops()
without consulting the bpf extable, so running this test would oops the
kernel.  Without it, the store lands on whatever the current process has
mapped at that address, and other user_vm_start values can make the sum land
in kernel space.

Every other arena selftest that touches arena globals directly
(arena_atomics.c, linked_arena1.c, data_in_arena_decl.c, arena_htab.c, ...)
gates that code on __BPF_FEATURE_ADDR_SPACE_CAST and skips otherwise.  In
the same fallback branch, __arena_global variables need an explicit
cast_kern().  arena_percpu_only.c has no such gate.  Should it have one?

The underlying problem appears to be on the kernel side of this series.
Commit 2e94f202e80e ("bpf: Teach verifier about arena percpu instructions")
types an uncast 64-bit user address as PTR_TO_ARENA, and the jit commits
a27c971d206b ("bpf, x86: Add support for arena percpu") and 0c3a9efd447d
("bpf, arm64: Add support for arena percpu") do not truncate it.

Commit 08224ba2de19 ("selftests/bpf: Add test for arena percpu bounds")
loads exactly this uncast ld_imm64 + ldx pattern but never runs it.  No fix
for this was found later in the series (searched e06485c3c3fb..08224ba2de19).

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
> new file mode 100644
> index 000000000000..27d4721c7ae9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
> @@ -0,0 +1,148 @@

[ ... ]

> +void test_arena_percpu(void)
> +{
> +	if (!feat_supported(NULL, FEAT_ARENA_PERCPU_DATA)) {
> +		test__skip();
> +		return;
> +	}
> +	if (test__start_subtest("percpu_only"))
> +		test_arena_percpu_only();
> +}

A subsystem pattern flags this as potentially concerning: a test that skips
silently, with no message.  When the kernel lacks arena percpu support,
test__skip() is called without printing a reason, and feat_supported() is
also silent when the probe returns 0.  The output only shows the test as
skipped and never says that FEAT_ARENA_PERCPU_DATA (kernel, jit, or arena
percpu chunk support) was missing.

test__skip() does mark the test as skipped in the test_progs output, and
many bpf selftests call it without a message, so this may be acceptable as
is.  The skip condition itself looks correct, since the probe loads a
BPF_PSEUDO_ARENA_PERCPU program and therefore also covers jits without
bpf_jit_supports_arena_percpu_insn().

Would it be worth printing a short reason before test__skip(), for example
that arena percpu data is not supported?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============2483452175354941989==--
