Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16262308F15
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339792; cv=none; b=Oz16PxhiSr6UBcNAfPbYf16g2soWBFG3rgCYIks9Y1+84dIbd/5SAZBWjWsSYD8xt82GklGKjrozAciQ771qg9H3WbE9MDRtgy2uPo37jn655C9QaMclEBwMdQAlrNbBLEtK6DLEaVbB7ppYvyQhnB7IHE6ndiyhCO9KpGBYEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339792; c=relaxed/simple;
	bh=g6YRGDjYxBKu8MGO9lQLASK4R3cQW72fIQHlz3OkUDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1C66HBfxnggQQs3pycj62vpCrU0uveQNYXal77gi4hjxjtdaTUnhVP8dmtfUvPVZhKR5aO4J+MV9R+FAl083XCP2EIRQeykCqNiJ2Rb4EuLdi5xiUrxkTIxMf+zIKYNY/uTdoNtpfviaiKX/ZnF4kXwjARLGKoodGSspWkKRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sxCAVJVd; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sxCAVJVd"
Message-ID: <02e68ebf-5782-4632-aed8-0026a3aab96b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773339779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5m9WLRDks/gQ0io//zmrr+zH79F0yxD0HjSLUsTqJM=;
	b=sxCAVJVdvT34lmdReeK/lCrmdVGsle2U9eRfsfXmr67kbZHbtOlbAk3zrcN4CrLwNHIdzc
	e3cRHCln3ULrYHEfQ4pBfdBvbS2LYMZu0Bk7vyEgX2c/tHv9/s6ORS1HlLZYYqx7p+hd+M
	UKPGmYHuM56TW46aQ1oJx9rNhbpyHnw=
Date: Thu, 12 Mar 2026 11:22:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: improve test coverage for
 kfunc call
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20260312080113.843408-1-hbathini@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260312080113.843408-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/12/26 1:01 AM, Hari Bathini wrote:
> On powerpc, immediate load instructions are sign extended. In case
> of unsigned types, arguments should be explicitly zero-extended by
> the caller. For kfunc call, this needs to be handled in the JIT code.
> In bpf_kfunc_call_test4(), that tests for sign-extension of signed
> argument types in kfunc calls, add some additional failure checks.
> And add bpf_kfunc_call_test5() to test zero-extension of unsigned
> argument types in kfunc calls.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>
> Changes in v2:
> - Added asm version of the selftest for consistent testing across
>    different BPF ISA versions.
> - Added comments clearly stating the intent of the test cases.
> - Updated sign-extension selftest to have additional failure checks.
>
>
>   .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
>   .../selftests/bpf/progs/kfunc_call_test.c     | 98 +++++++++++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.c    | 54 +++++++++-
>   .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
>   4 files changed, 154 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> index f79c8e53cb3e..62f3fb79f5d1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> @@ -74,6 +74,8 @@ static struct kfunc_test_params kfunc_tests[] = {
>   	TC_TEST(kfunc_call_test1, 12),
>   	TC_TEST(kfunc_call_test2, 3),
>   	TC_TEST(kfunc_call_test4, -1234),
> +	TC_TEST(kfunc_call_test5, 0),
> +	TC_TEST(kfunc_call_test5_asm, 0),
>   	TC_TEST(kfunc_call_test_ref_btf_id, 0),
>   	TC_TEST(kfunc_call_test_get_mem, 42),
>   	SYSCALL_TEST(kfunc_syscall_test, 0),
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> index 8b86113a0126..5edc51564f71 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> @@ -2,8 +2,106 @@
>   /* Copyright (c) 2021 Facebook */
>   #include <vmlinux.h>
>   #include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
>   #include "../test_kmods/bpf_testmod_kfunc.h"
>   
> +SEC("tc")
> +int kfunc_call_test5(struct __sk_buff *skb)
> +{
> +	struct bpf_sock *sk = skb->sk;
> +	int ret;
> +	u32 val32;
> +	u16 val16;
> +	u8 val8;
> +
> +	if (!sk)
> +		return -1;
> +
> +	sk = bpf_sk_fullsock(sk);
> +	if (!sk)
> +		return -1;
> +
> +	/*
> +	 * Test with constant values to verify zero-extension.
> +	 * ISA-dependent BPF asm:
> +	 *   With ALU32:    w1 = 0xFF; w2 = 0xFFFF; w3 = 0xFFFFffff
> +	 *   Without ALU32: r1 = 0xFF; r2 = 0xFFFF; r3 = 0xFFFFffff
> +	 * Both zero-extend to 64-bit before the kfunc call.
> +	 */
> +	ret = bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFffffULL);

Can we just use 0xFFFFffff instead of 0xFFFFffffULL?

> +	if (ret)
> +		return ret;
> +
> +	val32 = bpf_get_prandom_u32();
> +	val16 = val32 & 0xFFFF;
> +	val8 = val32 & 0xFF;
> +	ret = bpf_kfunc_call_test5(val8, val16, val32);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Test multiplication with different operand sizes:
> +	 *
> +	 * val8 * 0xFF:
> +	 *   - Both operands promote to int (32-bit signed)
> +	 *   - Result: 32-bit multiplication, truncated to u8, then zero-extended
> +	 *
> +	 * val16 * 0xFFFF:
> +	 *   - Both operands promote to int (32-bit signed)
> +	 *   - Result: 32-bit multiplication, truncated to u16, then zero-extended
> +	 *
> +	 * val32 * 0xFFFFffffULL:
> +	 *   - val32 (u32) promotes to unsigned long long (due to ULL suffix)
> +	 *   - Result: 64-bit unsigned multiplication, truncated to u32, then zero-extended
> +	 */
> +	ret = bpf_kfunc_call_test5(val8 * 0xFF, val16 * 0xFFFF, val32 * 0xFFFFffffULL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[...]

