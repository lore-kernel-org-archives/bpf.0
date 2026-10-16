Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA529B20A
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110511; cv=none; b=WgdiOgV5vWeNsfXLQbr8pUq6HXWPPqgOGowMwC7LGFxDtYCEU0hX4CQGHI4OvJH7/+Vr2pP+QADtVt1/+CyQLVTm5OR9M/NPeke8JuYr9/XeEmCQ+XR1WpThnqipWdRRBaLSxtEGmmEhMW/1jQBPTB/URyO0dXflIJZ8UV7EG24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110511; c=relaxed/simple;
	bh=4Km7bpvPTgsUVURMOKi1XAIM42zeErfWNEK1EzVrG34=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kC/UTnE4pa5N1+x2jl6251lO1SqGm7Qvp1YhSMMV8VAiR+2S+E1HQFxaRxbR5wNHhdX3yBSnnbx6Gf2/3EuibiKlvXt+lfX8M++L1ngqbNUFYYZuK1ytzaHhu2HH9pnlMVS6ZPCn1h5Wq12Cb7uOJfGfilx+/7luV34IXkrcnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIq/cQut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIq/cQut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5EF1F000C4;
	Fri, 16 Oct 2026 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110510;
	bh=hq4IzmZKS4aOy/k/zGlgVzeyNCD9mlEyRaQ5AxiFkA8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eIq/cQutmXTflrBQyNOsf4BGQDf4aPV0vIMuNIHkhiNrMOQSAphSs3m3g4BTQ1xTA
	 91eBZavyxDfmJe0lpShYjAD9PE7ppKZjp3/2MyY+RcdyPGq+ChAqTpxRTHstsFLYoC
	 qeXY7ov628jC2rIWRcDCOW4643gG76aM6D0vSH3V3cifjTYQi5bXjiBOKBPsKXxEz6
	 lq67KiuzDORuuTbgKVywKLN6fIqikFx9V3yaOkq5we66WbJdgQKnhap956GApZZQ9E
	 JNRBBb524c7xf3ogXbClOPdOCVKMWTjal57sUVqspeT3t4lePyEynCs+ySLJZMp1ak
	 XZvBbCWv0mXkA==
Content-Type: multipart/mixed; boundary="===============9100725291623905389=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7684ce5e6a2e64826c4bac6d84b4001610e88e4bd9587560e654be9f3b0361bb@mail.kernel.org>
In-Reply-To: <20261015234125.3152346-12-memxor@gmail.com>
References: <20261015234125.3152346-12-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] selftests/bpf: Test arena binding by libbpf
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 00:28:28 +0000 (UTC)

--===============9100725291623905389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test arena binding by libbpf

TL;DR: Commit message only: it says the object's programs never refer to the
arena, but the trigger program in struct_ops_arena_autobind.c uses it; only
the callback and unrelated program avoid it.

>     selftests/bpf: Test arena binding by libbpf
>
>     Attach a struct_ops callback with an __arena argument from an object
>     whose programs never refer to the arena and drive it through the kernel,
>     and check that an unrelated program of the object got the arena among
>     its maps as well. Load the same object through bpf_object__prepare()
>     and bpf_program__clone() too, the way veristat loads programs.
>     Two existing programs expected to fail for want of an arena while living
>     next to an arena map, the kfunc argument case in arena_kfunc.c and the
>     scalar access case in verifier_arena_scalar.c. They load now, so move
>     them to an object without an arena map, where the kernel checks still
>     apply.
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The commit message says the struct_ops callback is attached "from an object
whose programs never refer to the arena", but is that accurate for every
program in the object?

In progs/struct_ops_arena_autobind.c, the trigger program uses the arena
directly:

    val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
    ...
    bpf_arena_free_pages(&arena, (void __arena *)val, 1);

The comment in the source file describes this correctly: "Neither the
callback nor the unrelated program refers to the arena".  Only test_arena_cb
and unrelated avoid the arena, and those are the two programs whose binding
the test checks.

Could the changelog say that the callback (and the unrelated program) never
refer to the arena, rather than all of the object's programs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38826834739
--===============9100725291623905389==--
