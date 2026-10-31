Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793485574;
	b=tydDB3XDVwXsdbxKXeDXnjuJrcF6YzfSg79YxpPE9j6Krkbt79qNjsFwGV2PRIVzSgDV
	 y4KDLRq37YkQCB9uWBG96lM0Tg3jqIjwbYQbgcq7R0m9IrUjDPSREjBs626n52hzRCboL
	 bWvaL7SH9x1fmLubBvURmn9W3smUM+KqONvIhJIAXrqXncQkB3PVPTgoAGT+v4MmHkxm4
	 iM0JCkA2EjWyI4cFhzffNxx34E0s9uLn/LFdEuM2aErqmT/+Y4jPBDZOvfrwos/zVtlzl
	 5anwuGg4RBwlxH3GcLBiHe+/DLOZxbIDnGjv4HbdAAU7HTAfzWuc9J0y9CMEDn2Hz+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485574;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=lsLxC3t/MyOxqICIs0Ax2hHa8787i5yWpJIpnLslTco=;
	b=COc+0jJ8RjqWZmNykNQ1hQ/FJfsyVHsLeZjbMXmvEnJJx69uMXBVoWUGD8g7UvrXyUW2
	 0UYc48h3AkhpXdALJ56WQgvjNKP6BNowCIvPRWl6aJGNzouCxYJg+Md49JH7v8ZYPwt6y
	 XvFm9UIZyYe/ZASAz01+JhZF7kwrcPZ7+XfjRtCnJa9Qs5f48Z7fmHKtkhJYy6A+deLXx
	 B7Mj6/+ZkouA5l0d5z/CDBvaQZdjsD6h/iie/tQDQHIGW4B1WoHJR5POJzCZbTuzeHCS+
	 qHqHngF6l3yAo1xfBEjlEhLBbUiE573R69CMiui25Fc8smwWZn0ZjaKB66pGr+kTI/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcyGNUOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC193606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcyGNUOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB881F000C1;
	Sat, 31 Oct 2026 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793485573;
	bh=lsLxC3t/MyOxqICIs0Ax2hHa8787i5yWpJIpnLslTco=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VcyGNUOkeWypCutBdTiAEUB8udzZuNXsUzEfRawhEIqcdGY2RICJgllHaHqAn00OT
	 TiTwYKZKDpRHWiwoKY9mDF2N99kEizpf/sXnMRWWmdC/gI0f0penRi3inE1nRvwGjW
	 NQXOhmtmux5zCZdSMFSkuHGplFaeKEWnFRGvzKGBHph9EXR+RjAreCwev1QYlLmLcc
	 f3HfN78UnBdrCp22t7FvHWIBOjPgfRQpKyH4Nula4a2cEY0NC/q3CAdYbgfCL3RAOv
	 XKS3aQM4ulauLsFbpS4Yc9L/o0wk2v3PhomkbwV10PUz4+P1z6rKKy6paF5F+GksRF
	 U1Nk9VOHm8BXQ==
Content-Type: multipart/mixed; boundary="===============3994189834896186541=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <10bdb0d234c2da5419b68f9b2a0f516ffe847714a8475917565b66174c4ec2a1@mail.kernel.org>
In-Reply-To: <20261031215543.682284-6-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf v2 5/9] s390/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 22:26:12 +0000 (UTC)

--===============3994189834896186541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> s390/bpf: Support internal-only MOV instruction to resolve per-CPU addrs

TL;DR: Commit message only, not a bug: the "Patch 7" reference will be
meaningless once the series is applied; suggest naming the commit that needs
this insn for timed may_goto.

>     s390/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
>
>     The verifier emits BPF_MOV64_PERCPU_REG to turn the address of a per-cpu
>     variable into the address of the copy of this cpu. s390 keeps the per-cpu
>     offset of the cpu in the lowcore. Add it to the register with one insn, the
>     way the JIT reads cpu_nr and current_task for the helpers that it inlines.
>
>     With bpf_jit_supports_percpu_insn() the verifier inlines the lookup in
>     per-cpu array and per-cpu hash maps, and resolves the address of a value in
>     a per-cpu array. Patch 7 needs the insn for may_goto.
>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

this isn't a bug, but could the "Patch 7" reference be reworded to say which
change needs this insn, for example "a following commit uses it for timed
may_goto"?

The patch numbers are lost once the series is applied.  The change being
referred to appears to be "bpf: One may_goto time slice per prog invocation",
which emits BPF_MOV64_PERCPU_REG for the shared may_goto count, so that commit
could also be named directly.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41246505049
--===============3994189834896186541==--
