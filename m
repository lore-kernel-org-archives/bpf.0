Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2F3D4123
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484467; cv=none; b=dkD/Blngy/9GH+Xv2xU8YuHpyrhDDCf41+g/oydIA2WLSyLl8BhbCwha2L9ir4YqSqh+uoZ+6rEtf3Q6HhN6qLmk9nYc/g/PxVVTHtF6w1MkMWJLuMRRicKrnjoA84Gu5FW+0qrNcDRrvb5Wb6qM3sBV9qHPurz3k43BAaRT67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484467; c=relaxed/simple;
	bh=gnwII//VX18raRRz7rdqopizTgONNiDq34NjZkmXzJA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h99yubLCoUg0a6hqtrcPb35GF0LcGfhs20LTs5rTPaZoyb2LUDwK3pNel8+YIVRh5Y/TayTf27l21mtDDmUJBbOUVtMKVWpIYTjhVbiY41JVeCahHzEyA9WM5KkS15sRsMGDYnSkYgm6rM2SOzC9feTxqUHHwnKBDKToU7+IcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnpnEXdS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnpnEXdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177031F00893;
	Tue, 15 Sep 2026 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484465;
	bh=DwYuDY+YFsPEt1IfWmdoXM/4OiwJ0F/FjtGLHRLm+44=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OnpnEXdSwjkvFa+rUSlkmhmskc9k243L4o8m3Zc665FBsVW6SutWO6iPrQCMq/VUm
	 B7uGeLG0TwujXs+DBSlzXB43Qf3v+H1i2yWskvcyMY3LnqHTLruZKt+uFr2+5olWNc
	 R5EtM+63Ow6+Ta+HlVCCAnVtwfX9zFISPKNZpt4tzTA64VAyPVgclwHuH/nJsbgg5v
	 KMjFV6IQrLCBs4/7ZKc4uQWZvn9h4M8TcQc7rFWfxnkpdgQnTlU5zOtRueeM/qiAvI
	 +41c5iQ7m75bdVkXBJTkNj/zCBAqzMBagIXTqV3Dtl6Cf5X+SsWn/A4EjkjM9lFyLA
	 9T5CXZR8So4TA==
Content-Type: multipart/mixed; boundary="===============4951051002895161353=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b515a4ae677b6d4fd069d8103b528ff709a710fd6d285465cb72a0486b3ae61@mail.kernel.org>
In-Reply-To: <20260915141004.1196460-4-memxor@gmail.com>
References: <20260915141004.1196460-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Cover generic __uninit kfunc output buffers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 15:01:05 +0000 (UTC)

--===============4951051002895161353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Cover multiple outputs, an independent output next to a variable-size
> buffer, variable offsets, and write-only maps. Check that read-only maps,
> out-of-bounds outputs, uninitialized aliased inputs, and reads beyond the
> initialized range retain their expected rejection.

Does the commit message accurately describe the read-only map case?

The description states all four cases "retain their expected rejection",
but read_only_map_output() tests a rejection that is newly introduced by
the preceding fix 877a8f574a04, not one that is retained.

Before 877a8f574a04, check_func_arg() computed the access type for a
generic memory argument as:

  if (...)
      access_type = BPF_READ | BPF_WRITE;

and 877a8f574a04 changed it to:

  access_type = arg_type & MEM_UNINIT ? BPF_WRITE : BPF_READ | BPF_WRITE;

check_map_access_type() in kernel/bpf/verifier.c tests with strict equality:

  if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
      verbose(env, "write into map forbidden, ...");

With the pre-fix value BPF_READ|BPF_WRITE (== 3) neither branch fires, so
passing a pointer into a BPF_F_RDONLY_PROG map (the .rodata map holding
'static const int read_only_output') as an __uninit output was accepted
before the fix.

The __failure __msg("write into map forbidden") expectation therefore only
holds after the fix; describing it as "retained" misstates what the new
test covers (it is a new-behaviour test, arguably the most interesting
user-visible tightening in the series).

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
> new file mode 100644
> index 000000000000..99c0ee562ea0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c

[ ... ]

> +SEC("tc")
> +__success __retval(7)
> +__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
> +__prepare_priv
> +__success_unpriv
> +__naked void initialized_input_alias(void)
> +{
> +	asm volatile (
> +		"*(u64 *)(r10 - 8) = 7;"
> +		"r1 = r10;"
> +		"r1 += -8;"
> +		"r2 = r1;"
> +		"call %[bpf_kfunc_test_uninit_alias];"
> +		"exit;"
> +		: : __imm(bpf_kfunc_test_uninit_alias) : __clobber_all);
> +}

Will this test pass on big-endian targets?

initialized_input_alias() is the only test in this file whose expected
return value depends on host endianness, so it will fail on big-endian
targets (s390x, which is a supported BPF selftest arch - see
tools/testing/selftests/bpf/DENYLIST.s390x, and whose JIT supports kfunc
calls via arch/s390/net/bpf_jit_comp.c bpf_jit_supports_kfunc_call()).

The program stores an 8-byte value and then has the kfunc read only 4 bytes
from the low address of that store:

  "*(u64 *)(r10 - 8) = 7;"   /* 8-byte store */
  "r1 = r10;" "r1 += -8;"    /* out__uninit = r10-8 */
  "r2 = r1;"                 /* in          = r10-8 (aliases out) */
  "call %[bpf_kfunc_test_uninit_alias];"
  "exit;"

The kfunc in tools/testing/selftests/bpf/test_kmods/bpf_testmod.c is:

  __bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
  {
      int value = get_unaligned(in);
      put_unaligned(42, out__uninit);
      return value;
  }

so it does a native-endian 4-byte load at r10-8 and returns it in r0, which
is the program's return value.

On little-endian the bytes at r10-8..r10-5 are 07 00 00 00, so value == 7,
matching __retval(7). On big-endian the u64 7 is laid out as
00 00 00 00 00 00 00 07, so the 4 bytes at r10-8 are 00 00 00 00, value == 0,
and __retval(7) fails.

Every other executed test in the file is endian-neutral because it reads
back exactly the int-sized/byte-pattern values the kfunc wrote. Only this
test relies on the layout of a wider store.

The existing convention in this directory is to guard exactly this pattern,
e.g. tools/testing/selftests/bpf/progs/verifier_spill_fill.c:

  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
      "r4 = *(u16*)(r10 - 8);"
  #else
      "r4 = *(u16*)(r10 - 6);"
  #endif

Since the kfunc's 'in' argument is a const int * (4-byte fixed-size
ARG_PTR_TO_MEM), the simplest endian-neutral fix is to initialize the input
with a 4-byte store instead: "*(u32 *)(r10 - 8) = 7;". That still satisfies
the input read check at r10-8..r10-5 and keeps the input/output aliasing
that the test is designed to exercise.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34981336633
--===============4951051002895161353==--
