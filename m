Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8034F46D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808661; cv=none; b=jrS/ObyXyoeqTIrXYrGLjms5AAJZ3LXatsAapIXa+hqW45Jim/5lkwmkMmhXJMV/ztQkkZ6uokEO5nZvi3/Qn05lv687e0ehXnXD9CpgrC3Slu05lnj8uyJqM/9q8nVAUfcejXmYNa8uhB1B24wzzGwIlzDZC4hpc6MgP9iHsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808661; c=relaxed/simple;
	bh=mwJ/MQhwZC+UTV0VZpggJk/KlAarn/fwJDvrU06MNm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jx+IOhK6bch9B+YrzSGs6fK4ofOq6dT7fMfsCxjShLsgN06ZfUyQYxhD1F7Oxt9UrVEPoG5hlohTAI+vnBKwzrhZ0MrvpCqGgLvDJgKIYlpp4kX2cLyFlehmbnnRJ6LP4HW9wm4Os/Bc/mCIHt24m6Q4dt27fkE5Y3DLEZ6vsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txR+Rsho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txR+Rsho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB3C2BCB0;
	Tue, 21 Apr 2026 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776808660;
	bh=mwJ/MQhwZC+UTV0VZpggJk/KlAarn/fwJDvrU06MNm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=txR+Rshoze41wdGMtvnl1nmSYZWyDzshjW+6hhqoBMsG3eSrITfLzlkSaAH3eB6Td
	 Tb3iBTzo798HNWSjkbW6+4DdCJ3KTPvSnm8mraeH8k2hUnoF0IS0f1ueJo4a7ouXDN
	 HruUIC7l6kh0B0TLJe67QDKCIlQCk9pZOuSyEIdrKpFjOki0Wg39PWizXKxQM3xn7+
	 2wpd3Uu5Hu9OrCwdy6TSaSPp+6HhaXZgSGMjz2O+O8dfqKVCczAtIYpZ3QHZSgfNUH
	 q2JS5aC3xdmN17pDYMf/2NWUeP91IlSYs+/DwfBbkBgHV0j4F/XBVdzzB0xkKRSFn+
	 7xI4h69hCo3rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 7/8] selftests/bpf: Add selftests for
 libarena buddy allocator
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421165037.4736-8-emil@etsalapatis.com>
References: <20260421165037.4736-8-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 21:57:39 +0000
Message-Id: <20260421215740.B3DB3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Using the `%lx` format specifier for a pointer type without a cast =
causes a compiler warning in BPF selftests.
--

commit 5722468489c153ff642e633e17b799603b516db1
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add selftests for libarena buddy allocator
   =20
Introduce selftests for the buddy allocator with and without ASAN. Add the
libarena selftests both to the libarena test runner and to test_progs,
and add logic in the Makefile to only compile the ASAN variant if the
compiler supports it.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.=
c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
> new file mode 100644
> index 0000000000000..b12d18790fa53
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
[ ... ]
> +SEC("syscall")
> +__weak int test_buddy_alloc_multiple(void)
> +{
[ ... ]
> +	for (i =3D 10; i < SEGARRLEN && can_loop; i++) {
> +		idx =3D (i * 17) % SEGARRLEN;
> +
> +		mem =3D segarr[idx].block;
> +		sz =3D segarr[idx].sz;
> +		poison =3D segarr[idx].poison;
> +
> +		for (j =3D zero; j < sz && can_loop; j++) {
> +			if (mem[j] !=3D poison) {
> +				buddy_destroy(&buddy);
> +				arena_stdout("%s:%d %lx %u vs %u", __func__,
> +					   __LINE__, &mem[j], mem[j], poison);

Does passing a pointer to the %lx format specifier cause a compiler warning
here?

Since &mem[j] is a pointer type (u8 __arena *), passing it to %lx without a
cast usually triggers a format warning. Because BPF selftests are compiled
with -Werror, this can break the build.

Should it be cast to an integer type like (unsigned long), similar to how
it is handled later on in test_buddy_alignment()?

> +				return -EINVAL;
> +			}
> +		}
> +
> +		buddy_free(&buddy, mem);
> +	}
> +
> +	buddy_destroy(&buddy);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421165037.4736=
-1-emil@etsalapatis.com?part=3D7
