Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11093BFE44
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830354; cv=none; b=hCI7ia6ABGQfojehd9xj75OChdYtqtkDuNSpXqJUxDA6G7hRvhtJ9+SwZYgiUXkOBmGvaomynStSJsOpSU5awzfdXhvEKRaPjcOyu0SezTWmFJ/tO3aRNMJgNcwUnksJJjM87tFknKL9pnrPHwH76GuNScxLKt1hwLA01d/BSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830354; c=relaxed/simple;
	bh=XhYcHXNFsf+ixdSMcn9o7pqkcmTAd93BD0ahpMLqJqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rA77DHyMD3GvbR64xK5KRoTGf0Vl85X+Pz/vIi7/jqv1QFyy849x5psE5iXjq2eLQz7rxbrD/U8y+WNZ9qWswwI1JioIkdZRiClGdClsZn4Fhp/3x2+R/LnWY+1pIsguqT/vK/G7Ajy8J2viPUZIGWuXQ3Q0ujpNzkFoqrg5ifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBXIaXh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBXIaXh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759B01F00A3C;
	Tue, 26 May 2026 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830352;
	bh=pRbq6cJYftBBb+ju1DByGDqD9kqe9BD6GTXHoYPxvPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBXIaXh0m2GRj/gK9Q7cde4YMRqLpZMoUiEevMCO+C6WtFBckYGNBH0bSLl8G+LJX
	 ed9UJJY9TqMYD/QeVUvEgdErEIWa3y1rI5QfZN4nOmFag5Mu5WG7TvZX7XHTazTXwf
	 g7SkD8RPx7B8J3HMD1fjMXxkUOJTBMnAXqNfq5VKVSLGnixGJd8la/01MTjpRcHqdt
	 L00gzfk1ATOZj1n4bkvIVg9xraSzVUkZ/44iwOTu/e+bPSwSX5Yh7J/Bf+DFpKDAKn
	 UNoiqRyNYnOLVUHhqHpz3WyURHo6jwY1s/v8vMllMM8+iXE4JOQ+leO8f4FnZLmhkR
	 bBc+m8YrPnXzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 08/13] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526205840.173790-9-jolsa@kernel.org>
References: <20260526205840.173790-9-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:19:12 +0000
Message-Id: <20260526211912.759B01F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Changing the default `USDT_NOP` to an 11-byte `nop,nop10` sequen=
ce breaks `prog_tests/usdt.c` and introduces an unsupported instruction seq=
uence for libbpf and the kernel.
- [Low] The commit message contains an unfilled `[1] TBD` placeholder.
--

commit 7b65abd3a4116a7fb1cc328d784f515175461d44
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch

This commit updates the default USDT_NOP instruction sequence for the x86_64
architecture. It replaces the 6-byte nop,nop5 combination with an 11-byte
nop,nop10 sequence to utilize nop10 optimization support.

>     Now that we have nop10 optimization support in kernel, let's emit
>     nop,nop10 for usdt probe. We leave it up to the library to use
>     desirable nop instruction.
>    =20
>     [1] TBD

[Severity: Low]
This isn't a bug, but there is an unfilled placeholder "[1] TBD" left in the
commit message.

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
> index c71e21df38b32..75687f50f4e21 100644
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h
[ ... ]
> @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP			nop 0
>  #elif defined(__x86_64__)
> -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x0=
0, 0x0 /* nop, nop5 */
> +#define USDT_NOP                       .byte 0x90, 0x66, 0x2e, 0x0f, 0x1=
f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */

[Severity: Medium]
Will this 11-byte sequence break the USDT selftests?

It looks like subtest_optimized_attach() in prog_tests/usdt.c explicitly
searches for the 6-byte nop1_nop5_combo and might fail the ASSERT_OK_PTR
check when usdt_2.c emits this new 11-byte nop,nop10 sequence instead.

Additionally, does libbpf's has_nop_combo() or the kernel's can_optimize()
in arch/x86/kernel/uprobes.c currently support optimizing this 10-byte NOP?
If not, this might result in a loss of the intended optimization rather than
an improvement.

>  #else
>  #define USDT_NOP			nop
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526205840.1737=
90-9-jolsa@kernel.org?part=3D1
