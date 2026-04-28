Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4B4A35
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413899; cv=none; b=aO9Qlr6+OIAqA4AI70XoZgFctAoFhnPev/LBOMGIHmjySLVEbTUfW402Cg+HZKmsSO6blegFGC+pidKpGhbSWv5arJ5i20XzNqIblhLgHFbvRK5hFjf4ZJtCe6ajDAOxcc/Isrh1ZIkeU+Y/cQ08oIbscjgQNFHSUARmoMdzGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413899; c=relaxed/simple;
	bh=fGU8Tp8dIooqXY50KJbztb3z5WB/kdXhqSmAfHlGZQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HK5dh49dDWuaIq8iNaPLiyGk9jEZ9z+w4XfI3TKCAlRvmpeJeHeid6DDHJvehBq6XXtJbwbAMOJAFL/qKnMA7AfdhMt2claLOcs6xMwRZPbTiuvh0lDWgzrrXWYQr5ZClMTNhBT0PI9KJJUvLVrE7vcRUDCsJQM8dBPe38s5g5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjMVXwpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjMVXwpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A84C2BCAF;
	Tue, 28 Apr 2026 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777413899;
	bh=fGU8Tp8dIooqXY50KJbztb3z5WB/kdXhqSmAfHlGZQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rjMVXwpUIBQhHqsXGtQTQq67jzry1Y3kemlUhXS0kzU8htLqb3kzzCqM53Mdrwj09
	 OBGHSkXGSfqtW21Y5HjNI3qj13aWMoJPNvnwyZGwB6R9Ht4FisnJI5jsT9MmpaiFfL
	 IB+83VLlOLxRej2ry96aOqMj+D6PkJ676kWniADxdoGhI4S8kOlxM01iitxFFGrUiv
	 YBLbP/DWwe3QdL+u9NseUWOhxyhWC87QUyMwimRLNA2eD0Og4f7eNhz5sg23yQsN+c
	 yx1BP4kXW4GWGMyrGr51qlLv5jbm0RkOS5fuhHU2bPgeTAmxNhAB8nhQu3otjATAwH
	 ip6raL5zG4mEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/3] selftests/bpf: Test jited inline of
 bpf_get_smp_processor_id()
Reply-To: sashiko@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428080051.20938-4-yangtiezhu@loongson.cn>
References: <20260428080051.20938-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 22:04:58 +0000
Message-Id: <20260428220459.07A84C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The expected JIT assembly uses an incorrect struct offset (8 inste=
ad of 24), which dictates a memory-corrupting JIT implementation.
- [Medium] Adding a known-failing test breaks BPF CI and git bisection.
--

commit c320ef8cc6d3d14ed32f2590ea486674717257d9
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Test jited inline of bpf_get_smp_processor_id()

Add the testcase for the jited inline of bpf_get_smp_processor_id(),
only for LoongArch currently.

>     Note that this test will pass only after the JIT inline support for
>     bpf_get_smp_processor_id is merged. While the JIT inlining is still
>     in the pipeline, adding the changes now will not introduce any build
>     regressions. It serves to define the expected JIT output for future
>     validation.

Is it expected that this breaks BPF CI and git bisection?

Introducing a test for a feature that is not yet implemented causes the
test_progs suite to fail on LoongArch, because the BPF test framework's
__jited tag will fail the test when it does not find the expected JIT
instructions.

Tests for new features are typically submitted and merged in the same patch
series as the feature itself to ensure the tree remains fully testable at
every commit.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> index 913a1699e42b..e4d683c8cb06 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -19,4 +19,15 @@ int inline_bpf_get_current_task(void)
>  	return 0;
>  }
> =20
> +SEC("fentry/bpf_fentry_test2")
> +__success __retval(0)
> +__arch_loongarch
> +__jited("	ld.w	$a5, $tp, 8")

Does this expect an incorrect struct offset?

On LoongArch, $tp holds __current_thread_info (a pointer to struct
thread_info). In the kernel, struct thread_info places the cpu field at
offset 24. Reading from offset 8 will erroneously load the flags field
instead of the cpu ID.

If the BPF JIT implementation matches this test, returning flags instead of
the CPU ID could cause out-of-bounds memory accesses and kernel memory
corruption when bpf_get_smp_processor_id() is used to index per-CPU maps.

> +int inline_bpf_get_smp_processor_id(void)
> +{
> +	bpf_get_smp_processor_id();
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428080051.2093=
8-1-yangtiezhu@loongson.cn?part=3D3
