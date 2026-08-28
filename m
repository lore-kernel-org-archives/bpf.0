Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE6135A53
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924981; cv=none; b=LQnpagxRGQsU2O3TJ5+VzmzB7vQq9sXWWqReTwLPtZ0GDZzIXA2hCrWHNze2dVkdbRUFurezngW76WE8jy11m9CSCOAlIo8JwRLIYwqbWmJz+7Y72WT3G0Pa69K47xqjEzwdGbQBaheGrkm61XxYttjpRsiEyuBgsm5x3neu0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924981; c=relaxed/simple;
	bh=yM4daaz5EGYsnOT02SS39XlhFRk0UH5e4rF7tLOYAqQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=OP7SvoaYpluFMeQojUts71UCKgU1u6sFw2zVopc70jQWegbsN6jHBjgabsnuHSFQnPLnxlFgD+amIHrlWdzFFjb7DKZk/IGjmEcopWnpdeANp71er9UEmOauKtni3t/cugb6xvVw/aphIbHtRW5AFYqGhlnj4bhNvB8PXSJmN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=luToD1c7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="luToD1c7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EB41E1A18A3;
	Fri, 28 Aug 2026 13:49:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A551060537;
	Fri, 28 Aug 2026 13:49:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D41411C78212;
	Fri, 28 Aug 2026 15:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787924974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=69exiOAVHdIVW9goACtvVSF9zJavgJQ+ojNwMsZPEro=;
	b=luToD1c7hijfLRa8kWHEBKEP9XRU6yMf3qwN/ks0Y+O1kI/mG9dU+fBjddu0sif0laqLAi
	Dt0zw4vbvBQZ2t7n1c8WGxiV4J6cQkKG58dnz+kMJgJcZ+5Aafg0Pue7kHz/a08snAVLRP
	UiAsZRy2CDCpDjUPQwM2XB5zddnTBZdXvBynO66FTeeFcc/XS9mTZKaSj4LLmMvbVOGkXm
	/8kK68hmA1j2GMe42cuiPneYKhI9sRLQ36hQ4GJW41jcDqP5//SnFrhY8e7VTlHCtcG8cp
	HVJWSFwKHXp7DKyGGvfDdZv7Vs3UEK0IkBHs0eGjPN6hO2CQmyqyOILKu4FPzw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 15:49:24 +0200
Message-Id: <DL0MI5O31J44.1W5BV6GJMJTT7@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, <hpa@zytor.com>, <shuah@kernel.org>, <mingo@redhat.com>,
 <andreyknvl@gmail.com>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next v8 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-kasan-v8-8-7c1c0fdb9d7f@bootlin.com>
 <45923d9ec2441312cfd8f12fd02a19d717dad306fd636614c83d02c864340ebe@mail.kernel.org>
In-Reply-To: <45923d9ec2441312cfd8f12fd02a19d717dad306fd636614c83d02c864340ebe@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Aug 28, 2026 at 12:30 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/s=
elftests/bpf/progs/kasan.c
>> new file mode 100644
>> index 0000000000000..fe8e0dd228a09
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/kasan.c
>
> [ ... ]
>
>> +SEC("tcx/ingress")
>> +int simple_atomic_fetch_on_stack(struct __sk_buff *skb)
>> +{
>> +	struct kasan_test_val val;
>> +
>> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_test_val));
>> +	__sync_fetch_and_or(&val.data_8, 8);
>> +	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_test_val));
>> +	return 0;
>> +}
>> +
>> +SEC("tcx/ingress")
>> +int simple_atomic_fetch_not_on_stack(struct __sk_buff *skb)
>> +{
>> +	struct kasan_test_val *val;
>> +	__u32 key =3D 0;
>> +
>> +	val =3D bpf_map_lookup_elem(&test_map, &key);
>> +	if (!val)
>> +		return 0;
>> +
>> +	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
>> +	__sync_fetch_and_or(&val->data_8, 8);
>> +	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
>> +	return 0;
>> +}
>
> Can these two programs build with the no_alu32 flavor? Looking at
> Documentation/bpf/clang-notes.rst, __sync_fetch_and_or() needs -mcpu=3Dv3
> for the BPF_OR atomic instruction, but the no_alu32 build uses plain
> -mcpu=3Dv2 (tools/testing/selftests/bpf/Makefile:497-501). Clang at v2 ca=
n
> only generate BPF_ADD atomics without BPF_FETCH, so BPF_OR should be an
> instruction-selection error.
>
> The sibling programs simple_atomic_on_stack and simple_atomic_not_on_stac=
k
> use __sync_fetch_and_add(), which lowers to BPF_ADD without BPF_FETCH whe=
n
> the return value is unused, so those build fine. Every other prog in
> selftests/bpf/progs/ that uses a non-ADD or fetching atomic guards it wit=
h
> #ifdef ENABLE_ATOMICS_TESTS (progs/atomics.c, progs/arena_atomics.c,
> progs/atomic_bounds.c, progs/tcp_ca_write_sk_pacing.c), and
> -DENABLE_ATOMICS_TESTS is only passed to the default and cpuv4 runners, n=
ot
> to no_alu32.
>
> Would it make sense to guard both simple_atomic_fetch functions with
> #ifdef ENABLE_ATOMICS_TESTS, or to verify whether test_progs-no_alu32
> actually builds?
>
> Also, since the return value of __sync_fetch_and_or() is discarded here,
> does clang emit BPF_ATOMIC | BPF_OR without the BPF_FETCH flag? That woul=
d
> make these identical to simple_atomic_*, just with OR instead of ADD, and
> the JIT path for is_atomic_fetch (the CMPXCHG loop in
> arch/x86/net/bpf_jit_comp.c added by bc9fb0ddd5f3b, where the KASAN check
> is emitted before branch_target assignment) would not be exercised by
> kasan/simple_atomic_fetch_on_stack or kasan/simple_atomic_fetch_not_on_st=
ack.
>
> The commit message shows #175/29 and #175/30 as :OK, but
> progs/atomics.c:or64 uses or64_result =3D __sync_fetch_and_or(...) to for=
ce
> the fetch variant (checked in prog_tests/atomics.c:98), and keeps a
> separate or_noreturn_value program for the discarded-result form. Would
> consuming the result here test the intended path?

Even for no_alu32, the __sync_fetch_and_or is properly generated:

  $ llvm-objdump --disassemble-symbols=3Dsimple_atomic_fetch_on_stack tools=
/testing/selftests/bpf/no_alu32/kasan.bpf.o
 =20
  tools/testing/selftests/bpf/no_alu32/kasan.bpf.o:       file format elf64=
-bpf
 =20
  Disassembly of section tcx/ingress:
 =20
  00000000000006d0 <simple_atomic_fetch_on_stack>:
       218:       bf a6 00 00 00 00 00 00 r6 =3D r10
       219:       07 06 00 00 f0 ff ff ff r6 +=3D -0x10
       220:       bf 61 00 00 00 00 00 00 r1 =3D r6
       221:       b7 02 00 00 10 00 00 00 r2 =3D 0x10
       222:       85 10 00 00 ff ff ff ff call -0x1
       223:       b7 01 00 00 08 00 00 00 r1 =3D 0x8
       224:       db 1a f8 ff 41 00 00 00 r1 =3D atomic_fetch_or((u64 *)(r1=
0 - 0x8), r1)
       225:       bf 61 00 00 00 00 00 00 r1 =3D r6
       226:       b7 02 00 00 10 00 00 00 r2 =3D 0x10
       227:       85 10 00 00 ff ff ff ff call -0x1
       228:       b7 00 00 00 00 00 00 00 r0 =3D 0x0
       229:       95 00 00 00 00 00 00 00 exit


My understanding is that _32 bits_ atomics aren't available with
-mcpu=3Dv2, but 64 bits atomic fetch operations are, so that's why I stuck
with a DW operation for the simple_atomic_fetch(_not)_on_stack tests.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/331600=
00533




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

