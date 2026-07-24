Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E4390219;
	Fri, 24 Jul 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922755; cv=none; b=VISLzCT6M/cnUgUDVb7aYdz9OsBTFS7R7xpgMjhFsKOtHy5GtwulyRVLZJ6rB1R81YqRZczwtVK5UqFKzSQmjFuIETZO/qxEkobm9BUBspvMS2ETbK9e99rZXKFhBmTppBBdAB/BY1b4Dy/ELY2/JAA/wT8dFUQGkJNI8uqVVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922755; c=relaxed/simple;
	bh=BvkOFAgW7KVB9mqXAbR0plG+x6ThYtwEmmSS6Tc6Ayk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1Sa+BGyIBTxybSrhLW4s5fpscn8DHKEgM5DF1m8S1j+Rm5tHOcV43FMkJ/z0AEl033hpLPIax9Su0Yn8YDBmoAJwQu/5Iyqu3lM7XjW36d7rVq5ePQPnl2Io45rFh13ksLHBYUZDrewZR7YNk8OqzxKDukw3uywNaN89sszj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPNT8J6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPNT8J6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263391F000E9;
	Fri, 24 Jul 2026 19:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784922753;
	bh=BvkOFAgW7KVB9mqXAbR0plG+x6ThYtwEmmSS6Tc6Ayk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LPNT8J6PKD17BwukgbJI2D1uGD7aOUu+vQ4fWZFDJs6QfjqpH9zrup9FGB4G8f7px
	 7/urGY2EC1v8w/e0eM0YwQQsxJWfKqO6v/N/7mv3NcUuprJxwLWY4lomqC6C8tWD5D
	 0lXmQf0C6bMobWbHWL5t0BAIGWz7OzTc/IrEBoss/YPv9dML7WeanAGJSg4AluOFC5
	 n+PTr8y1XRv3JSSwMclepxapnmJ8p8vw/u62hWEGCrLnj7hosoKvFXQXZUhHB6W8I9
	 YyCTmjfRE1kNxhmBuq8mvDPxUGGjAthsW3EINjNIUtCZpTagh+AFhx7+/fhUzmqOuR
	 tGgTTsTU29ygA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan
 <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Feng Jiang
 <jiangfeng@kylinos.cn>
Subject: Re: [PATCH bpf-next v5 0/3] bpf, riscv: add timed may_goto support
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
Date: Fri, 24 Jul 2026 21:52:31 +0200
Message-ID: <8733x8qi68.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Feng Jiang <jiangfeng@kylinos.cn> writes:

> This series adds RISC-V JIT support for the timed may_goto loop bound.
>
> Patch 1 implements arch_bpf_timed_may_goto() and enables
> bpf_jit_supports_timed_may_goto() so the verifier uses the timed
> expansion path.
>
> Patch 2 adds a test that checks R0-R5 are preserved across
> arch_bpf_timed_may_goto() calls.
>
> Patch 3 enables the verifier_may_goto_1, stream_cond_break, and
> may_goto_interaction fastcall tests on riscv64.
>
> Tested on riscv64 QEMU (rva23s64): may_goto programs load and JIT
> correctly, and the 250ms timeout path works as expected.
>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
