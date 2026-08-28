Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B6413796;
	Fri, 28 Aug 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913036; cv=none; b=SWE0VliWauPfPJZt5YHN0lIZaO3GoDPhK6i3bdoSpjCnJ8Yh/4XGuF8utQkqQpAxyM3hj9tAyjoTUVTGgwrbqVhqGpQaXNBs+oNxllL9rM0JAD6W7fgJMtQc9+acnXEQkz4XxJA24ti93UIgOYmgG3o8D5UY8QjqRhazOw9TIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913036; c=relaxed/simple;
	bh=Zof5dtRLyjmy0sQWXJccB8YR9oMd/6f0D2yOaxjeZ+o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UeIP4wBJuUhofrqelrezUDN7rHK5gDbK39YErFa3WSOK0ea7TEUuDx9O3G9D6IAo1ODscZNrx+3jvrmDCWZ9jyIqw6DzsM1ay+QOZ4w+tz6wJms8UTBz4JXFnlh5ep/NYlZO4Wz1AVQ3ObUqT19g1L+qGmQnjiyCchwbaMcmfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQW+wp+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQW+wp+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868541F00A3A;
	Fri, 28 Aug 2026 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787913035;
	bh=THTcv7Ki4vlBcrk31n8OosBnbdouHVBLUEE4e2fqUhU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RQW+wp+LjsJWtuAWx9y4fgsNwBv8/l8K917MQ5yIpNx1YKqHXRyhyKkey2c2gS71s
	 jThAvsRz/lAKEWkzJMEiRP+Pj6JhvnznXlsPWmQMocHUMyPFRk/xQFj52v0tNRUrNG
	 WFWqQFif0pOlP/iiFNew00sJGv19yLm4nJBPiHjJvCkrxW/yK9Cx7H1bj2cMa+p93I
	 MP6yuo0iXvElb9ef2MZ4505weG2cCGjyM+oZLqPQJHHWpJV1dGN/criEV7RtFctAkr
	 WFdIg2qd2TSQov3s8q68G+Dv6uKq8na+lHxQnTzu4AUXj6cR6qKvnYYoaN0EkztF4G
	 L7ARld1VuUogA==
Content-Type: multipart/mixed; boundary="===============6291589632793087374=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45923d9ec2441312cfd8f12fd02a19d717dad306fd636614c83d02c864340ebe@mail.kernel.org>
In-Reply-To: <20260828-kasan-v8-8-7c1c0fdb9d7f@bootlin.com>
References: <20260828-kasan-v8-8-7c1c0fdb9d7f@bootlin.com>
Subject: Re: [PATCH bpf-next v8 8/8] selftests/bpf: add tests to validate KASAN on JIT programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 10:30:34 +0000 (UTC)

--===============6291589632793087374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/selftests/bpf/progs/kasan.c
> new file mode 100644
> index 0000000000000..fe8e0dd228a09
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan.c

[ ... ]

> +SEC("tcx/ingress")
> +int simple_atomic_fetch_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_test_val val;
> +
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_test_val));
> +	__sync_fetch_and_or(&val.data_8, 8);
> +	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_test_val));
> +	return 0;
> +}
> +
> +SEC("tcx/ingress")
> +int simple_atomic_fetch_not_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_test_val *val;
> +	__u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&test_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
> +	__sync_fetch_and_or(&val->data_8, 8);
> +	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
> +	return 0;
> +}

Can these two programs build with the no_alu32 flavor? Looking at
Documentation/bpf/clang-notes.rst, __sync_fetch_and_or() needs -mcpu=v3
for the BPF_OR atomic instruction, but the no_alu32 build uses plain
-mcpu=v2 (tools/testing/selftests/bpf/Makefile:497-501). Clang at v2 can
only generate BPF_ADD atomics without BPF_FETCH, so BPF_OR should be an
instruction-selection error.

The sibling programs simple_atomic_on_stack and simple_atomic_not_on_stack
use __sync_fetch_and_add(), which lowers to BPF_ADD without BPF_FETCH when
the return value is unused, so those build fine. Every other prog in
selftests/bpf/progs/ that uses a non-ADD or fetching atomic guards it with
#ifdef ENABLE_ATOMICS_TESTS (progs/atomics.c, progs/arena_atomics.c,
progs/atomic_bounds.c, progs/tcp_ca_write_sk_pacing.c), and
-DENABLE_ATOMICS_TESTS is only passed to the default and cpuv4 runners, not
to no_alu32.

Would it make sense to guard both simple_atomic_fetch functions with
#ifdef ENABLE_ATOMICS_TESTS, or to verify whether test_progs-no_alu32
actually builds?

Also, since the return value of __sync_fetch_and_or() is discarded here,
does clang emit BPF_ATOMIC | BPF_OR without the BPF_FETCH flag? That would
make these identical to simple_atomic_*, just with OR instead of ADD, and
the JIT path for is_atomic_fetch (the CMPXCHG loop in
arch/x86/net/bpf_jit_comp.c added by bc9fb0ddd5f3b, where the KASAN check
is emitted before branch_target assignment) would not be exercised by
kasan/simple_atomic_fetch_on_stack or kasan/simple_atomic_fetch_not_on_stack.

The commit message shows #175/29 and #175/30 as :OK, but
progs/atomics.c:or64 uses or64_result = __sync_fetch_and_or(...) to force
the fetch variant (checked in prog_tests/atomics.c:98), and keeps a
separate or_noreturn_value program for the discarded-result form. Would
consuming the result here test the intended path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33160000533
--===============6291589632793087374==--
