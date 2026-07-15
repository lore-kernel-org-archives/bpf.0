Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475AC239E60
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156704; cv=none; b=Eeo7mm/PWvUgKdZcbrcoTzUqXxUsjtY006RyIXU2dZkJIuTHOCTO3qZ4GiUnB3Zw7EPz7Rxgih1FpF/ErPq8gH+IVI8CwnO4tbdLOdOh6aRHSDI4h80qySi/7DjiMbUtgeFPD8oBB+lyoqwvGpCCTlmeP/GdTHLWXI1CAZOy48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156704; c=relaxed/simple;
	bh=zGPyOUXSvgG403v+cKmK7a/yfGCYXJ5sxC+J2Gp03mg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r0+lFiXuDFHi1AIQKOLCDCFy9m295Fra3b2hgnCMg9I7HVJN5Gd8U/RPE+ejqP69qvn8thONo/OkXnGa/zXqESHOQqSYocm2NZ0UbVVPhFxJtCo+zkeKaD+ivoEzitJeduLcljBlDxn8SD0bZogK6XI66dXnaPpIP/x8vZgYTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZSJWPf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZSJWPf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4831F000E9;
	Wed, 15 Jul 2026 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784156702;
	bh=OMCb5ofoCI+BrKKsXn/nbElVgPhRPfonVm+3c959hHY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BZSJWPf/OGao6bgd+fnfNIOwFtWUpdrKtC4GOPixbhLLjkTZz8QdjXD7pE8ZJiyF/
	 9t0VCGFxfnvbtcJip+d8lInF2hWcEEXeOISiD9pw1WoRr/Bd0Au9S7fLUGnLZt+CbI
	 Q0l4ayDy6xTFBBMPPRKlIkB1dwYtpk0A9409xwkgC+1t+wzcIhitXI7Km0BDrIwXU3
	 MVUbqjZ4rMJY+MZYN1zhy63Y4vj89BQjZhz7fUW7Cix8fRBeHRL5z5lhiNSGa7xxDk
	 R8QuSyg/EcmzOmP/aWzTCiP1LhVFuzODTuB2TCR4aGqGopb50eR7DUmdkSUT48YbMr
	 Rc7ENWMEvlB8g==
Content-Type: multipart/mixed; boundary="===============4998555685911242422=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af44252e506d749246d5f7593468acd22dc8e9968f99566e43476f4136869259@mail.kernel.org>
In-Reply-To: <20260715220052.1590783-2-memxor@gmail.com>
References: <20260715220052.1590783-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Support __arena and __arena_nullable kfunc argument suffixes
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 23:05:02 +0000 (UTC)

--===============4998555685911242422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index c801a330aece..a980266ec788 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -250,6 +250,33 @@ Or::
>                  ...
>          }
>
> +2.3.7 __arena and __arena_nullable Annotations
> +----------------------------------------------
> +
> +Both annotations indicate that the pointer argument points into the
> +calling program's arena. The JIT rebases the value at the call site so
> +the kfunc receives a directly dereferenceable kernel address, subject to
> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access).
> +
> +With ``__arena`` the rebase is unconditional and the argument is never
> +NULL: a value whose lower 32 bits are zero arrives as the arena base
> +address (arena offset 0). The kfunc must not check the argument for NULL.
> +With ``__arena_nullable`` such a value arrives as NULL instead and the
> +kfunc must check before dereferencing.
> +
> +An example is given below::
> +
> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
> +        {
> +        ...
> +        }
> +
> +Calling such a kfunc requires the program to use an arena map and a JIT
> +with arena argument support (currently x86-64 and arm64); verification
> +fails otherwise. The program can pass any value without compromising the
> +kernel. A value that does not point into the arena is a program bug.

The documentation says arena argument support is available on "currently
x86-64 and arm64", but does arm64 actually support it here?

bpf_jit_supports_arena_args() is only defined to return true in the
x86-64 JIT. The arm64 JIT is not touched, so on arm64
bpf_jit_supports_arena_args() falls through to the __weak stub added in
this commit:

kernel/bpf/core.c:
bool __weak bpf_jit_supports_arena_args(void)

which returns false.

On arm64, check_kfunc_args() would then reject any __arena or
__arena_nullable argument with -ENOTSUPP. Should the documentation drop
arm64 from the list of supported architectures until the arm64 JIT gains
support?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29454748905
--===============4998555685911242422==--
