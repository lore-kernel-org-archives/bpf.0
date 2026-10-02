Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837A499F0D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948979; cv=none; b=r1UjZV/BAW7ZDKWcICVbYFDfA+i8HonQP8yHYeHiRJPcQi+ret8ZXGhaQ8+rnubemlXbL41oWYjnE4mwAoJrlgLTvD/XDDCt74Y6cUJxwe4gPmaJtQbHmWfg/Y87nujSQ2jl565AAfWb7ZFc3qtkf2imOopBiTebJAL8AxK7GY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948979; c=relaxed/simple;
	bh=J6+RriLlhWZrMhcVMk7nihX0swA3kRtd71iMvXgxjdc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hf1+mtzNrXYW1af0rI1oycoSsPBe7l9hl7apclVN2Omm4+NqN6OE5bWvZ31EBx+BJgpA386ygnDqMwP3p8xzra1xJBC5aSxA3heTHk41LA1ZFj2cEgCv8LJNqYh6uCxNCQOFJIh6jqhMdBsmI9rF79PlySlG77b5QiY7HbxReRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgd1pe5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgd1pe5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A5A1F000FF;
	Fri,  2 Oct 2026 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790948976;
	bh=dgxkBojIxTdKGJ1fMpqbcpSuLqbmZn7nz1Hfy9Tn8BM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fgd1pe5v7curngNLgkqLW9Cgk70Mp/o9yu+uG1w+PZw3AgyIT2EiyI4c9LAt9KxoW
	 qnxvsZ6gZYXvZD10BoN5R4oq9nmYrU5aaD+yKJL51ZEBE3f6iWZsr5ZaF7X2wYPS1i
	 W5pZjVVZDhOzeOEpIM488DLWMcG/ea4OqNnpPVWpr3sFTJgqoYxmGjxfW3SC8OUZpv
	 nSSe8CBUEaDIl4atiunr8xY6AEYteMrGTNU1OLLCAKIGDseU1FCnt3mDvn0gc1CgmT
	 QqhKKiUeLzc/L86hVk9dN1U8K5lREyUFvvEtuC4BK1T409KCUVfC6O46Hhei2TPazY
	 QnlzvzRyQwIOQ==
Content-Type: multipart/mixed; boundary="===============4634634824108158343=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9e6420fb8c2589dfa34149c62cdf300959e7ad1b7379877c7f73b14a2c5499c@mail.kernel.org>
In-Reply-To: <20261002124714.180012-2-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/15] bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 13:49:36 +0000 (UTC)

--===============4634634824108158343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON

TL;DR: Commit message only: the quoted verifier log (r0 &= 8, R0) comes from
an existing selftest, not the Rust snippet above it, which would fail at r3 &=
1 naming R3. Not a bug.

> bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON
>
> Rust's core::fmt keeps a flag in the low bit of a pointer:
>
>   r2 = *(u64 *)(r1 + 0)
>   r3 = r2
>   r3 &= 1
>   r2 >>= 1
>
> The verifier rejects it:
>
>   r0 &= 8
>   R0 bitwise operator &= on pointer prohibited
>
> Negation and byte swap of a pointer already produce a number when
> allow_ptr_leaks is set. Do the same for bitwise ops, shifts, *=, /= and
> %=, 64-bit and 32-bit. The result is an unknown number. With CAP_PERFMON
> the program can store the pointer and load it back as a number already.
>
> += and -= are not changed: they keep the pointer, 32-bit += is rejected.
> Pointers that allow no arithmetic and pointers that may be NULL are
> still rejected.
>
> Two tests in verifier_value_illegal_alu store through the result of
> &= and /=. They are rejected at the store now. Update expected messages.
>
> Assisted-by: 11 bots, 0 humans
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This isn't a bug, but the verifier log quoted under "The verifier rejects
it:" doesn't match the Rust snippet above it.

The "r0 &= 8" / "R0 bitwise operator &= on pointer prohibited" lines are
the log of the existing selftest value_illegal_alu_op_1 in
verifier_value_illegal_alu.c.  The Rust sequence would instead be rejected
at "r3 &= 1", with a message naming R3, since R3 is the dst register in
adjust_ptr_min_max_vals().

Could the commit message either quote the log that the Rust sequence really
produces, or say that the log is from the existing selftest?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37011822731
--===============4634634824108158343==--
