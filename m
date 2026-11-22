Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795360666;
	b=RJsCWG10wxOxHjgJjPkwcHcqLWuU4JSTMsfahcaP/3D3qPkK8e9E3gpRHSRDZAhIsY9x
	 S9QWmf8ClWW1mxXfcF/l4Smy+BlAQf9DYjZEu4sJcYAdgAKFDRK0u+nDt8Pyo+OSKP2uv
	 k8+28FlwzVxSTEnuRkEjNFU3MqpJtgROGJnoOjoAQJRRhaGCcE3M47w13H/sr3hvxqte4
	 i65Pw2gGK2eoAW6b9aNE+8Svx3sSSGEtnX6IHhUxRfSBSB2gp+boe31h3MXoS4Nkdb6B6
	 b+j0CdeR1FmWPAEM9aX2h4fAMSUxRM/++qr93PEgob25IKkYu2rWHUk86+U9YyyJTOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360666;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NtvXI6vYfBRTqUkXQYpyeM4Je25T7mielr8L8HLatFA=;
	b=qd4Wx72j5HOKggWUk8KTQ/dd9EcMQBIHGGLfQHFcYbXZg25bN/nHtUDahk4XF6yLdUO4
	 eADUzD3/jnAsusoJYpc+7VxqsRzuM9ZYRJqlxULFiIGhwPtd1gYJrHbeo0v9Pm6xgnKR8
	 CSbRbNMS54YwooqrpJ4YCT//0HTj45wiVkWB4MCfCmzODcsmVaZhq1IUd8UGOX8drh/E6
	 ew9Giny4fcTNVRNAfy0v80NKgq/oopBF0IlOo8Xkf7o+o4dzBjSARBbQtnKrF7ZXuqZMa
	 Ms2nHTRYzk3HcBLPxvblXFDAKe3til+WDR4mb9Fy0f9H2qgeMYsI6wrDCGs3p346TlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqpfChhP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B9606A320;
	Sun, 22 Nov 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqpfChhP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E972E1F000CA;
	Sun, 22 Nov 2026 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795360666;
	bh=NtvXI6vYfBRTqUkXQYpyeM4Je25T7mielr8L8HLatFA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KqpfChhPoDAxC0uxE6C/lHV+lCjWDNttI6cbcJ/peFjO82ShXm71ajwLRPmuKmqqc
	 jYJi+/nL1tXVYx68HAzcyDKtjlmwvAIY7LgLNPoWtO9KWlVoPeH3wKAmd5t94OegYN
	 9TBo4ac3EROS6/nMl1GI5k2dqoapAOkSd32JOUb8KOs92tcqu3/VmABiBMKdr+jSOG
	 jRBLOIVq8u5aAKaAjBYBpM8rLMX+gCe6FYy6FIgb6ljzDda5RKYO3uJFVUfQJ8mY5w
	 U2byyxB4z3nSq/LOW/2qjEL5IFCtwyFrD3Lu9hUylyEJPBTLPoghZ7MBnDsHymQJxA
	 qEY2TEB6RRc9g==
Content-Type: multipart/mixed; boundary="===============8772191801967708506=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <00d4f3d6c4a48f6cdef5b15b131de77f6e6864494604e8c894358a10bcebc13a@mail.kernel.org>
In-Reply-To: <20261122143815.330528-3-abhishekkhade69@gmail.com>
References: <20261122143815.330528-3-abhishekkhade69@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs
From: bot+bpf-ci@kernel.org
To: abhishekkhade69@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,abhishekkhade69@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 15:17:44 +0000 (UTC)

--===============8772191801967708506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs

TL;DR:
- Test issue: the "periodic" needle "ababac" appears to take the non-periodic
  branch, so the periodic memory/shift logic goes untested
- Commit message overstates cases 16 and 17 (no timing or budget check)

> selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs
>
> Add automated BPF selftests validating in-kernel binary byte sequence
> matching for bpf_memmem() and bpf_dynptr_memmem().
> Covered test cases:
[ ... ]
> 16. Periodic needle patterns validating Two-Way critical factorization.
> 17. Pathological repetitive prefix patterns validating linear-time immunity
>     without premature budget aborts.
> Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>

This isn't a bug, but the list describes two cases as covering more than
the tests can show.

For item 16, the needle is periodic_needle = "ababac".  Its shortest
period is its full length, 6.  In __bpf_memmem(), bpf_max_suffix() returns
split 5 with period 1, and bpf_max_suffix_rev() returns split 0, so
split_idx = 5 and period = 1.  memcmp("ababa", "babac", 5) is nonzero, so
the search takes the "Case 2: Non-periodic needle" branch.  The expected
__retval(2) is what any correct substring search returns.  The periodic
branch is actually reached by test_memmem_embedded_null, whose needle
{ 0x00, 0xff, 0x00 } has period 2.

For item 17, test_memmem_repetitive_prefix searches a 31-byte buffer for a
7-byte needle and checks only the offset (24).  It does not measure time,
so a quadratic search would pass as well.  The kfunc has no comparison
budget, so "without premature budget aborts" describes something this
series does not have.

Would it be more accurate to describe items 16 and 17 as correctness checks
on those inputs?  Or could the periodic case use a needle that really is
periodic, for example "abab" or "aaa"?  Could the changelog also say why
the cases were chosen instead of only listing them?

> diff --git a/tools/testing/selftests/bpf/progs/memmem_kfunc.c b/tools/testing/selftests/bpf/progs/memmem_kfunc.c
> new file mode 100644
> index 000000000000..eb895906811a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memmem_kfunc.c
> @@ -0,0 +1,299 @@

[ ... ]

> +static char periodic_buf[] = "abababac";
> +static char periodic_needle[] = "ababac";

[ ... ]

> +SEC("syscall")
> +__success __retval(2)
> +int test_memmem_periodic_pattern(void *ctx)
> +{
> +	return bpf_memmem(periodic_buf, sizeof(periodic_buf) - 1,
> +			  periodic_needle, sizeof(periodic_needle) - 1, 0);
> +}

This isn't a bug, but is test_memmem_periodic_pattern() (and likewise
test_dynptr_memmem_periodic_pattern()) meant to exercise the periodic
branch of __bpf_memmem()?

As written, "ababac" takes the non-periodic branch: bpf_max_suffix() gives
split_idx = 5 with local period 1, and memcmp(n, n + 1, 5) ("ababa"
against "babac") differs, so the search returns 2 from the "Case 2:
Non-periodic needle" loop.  Only needle_null ({0x00, 0xff, 0x00}: split 1,
period 2) reaches "Case 1: Periodic needle", and it matches on its first
full right-half comparison.  So no test runs the
"h_idx += period; memory = needle_sz - period;" step or the
"n_idx = max(split_idx, memory)" restart with a nonzero memory.

Would a truly periodic needle that also forces a period shift, for example
"abab" searched in "bbababab" (expected 2), cover the memory logic of that
branch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45034767598
--===============8772191801967708506==--
