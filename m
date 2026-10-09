Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F34071DE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525464; cv=none; b=oI9h0cN/6YOtU8/EsL1newXKb8gj6V+cO+RerDgJKRqbqPBpXqZsYx8i1jc6Ltk+HoF0+fhlG8siGGvlud9rKTT1U6hcWa7p5EtOhul0bf3A8REuWr3cRDPWFzBrQX7E4p4RcSatXxNK7qdSx6dAW2qprIbKxTwJYT6iRQGT86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525464; c=relaxed/simple;
	bh=pzSWlkxr+IBJ714I+HsRgIBaBJSNpWEaRy7q792BUsA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fwJOD/9i4ABbV5kIZDlX3F5mtzROTv2TxAENX4+NwNpPGA4CNl9s3SAir37VqUlF+9uxfqxi13CAuNktjT5eL+7IBsR2ZrmeMzC6tnZt93qcuHORHQ6Y8x37DrJXjnCLxJpiDYXbkQvicxbUCz2d5jAEYuUvh8DLy6G3zw5gXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf3V4f+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf3V4f+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F41F00893;
	Fri,  9 Oct 2026 05:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791525462;
	bh=yNWVHIZVCtQdRZW7s1GCtUXD0dTOnpqx6TkEnelDACQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Yf3V4f+Pb8kgFf0C5dBaQ+nYDKFRuUd8jFFG2oUdzDSQgG96r4AAUMJnLsCK11pEd
	 Bq7L/RWbFtZNTK37NKatFdBAqWhyU9aXy9wCQRCdrQiUtKsfk0J7tkheBqxNaHzjHB
	 xsvDxWONqjlTY0KmjRQbRHVvek1d1oZVPsTrXfHCLZnhNO82yhDjiJocxK6it9t1UL
	 86d/zIaQUJfgkMHmZrV4in+nsObFlTq9YdlacESZ5P+r8LwTNAOSMdUpj6Ygdgjn4C
	 DSVWm4ldqs9zbGz2JQQ07DgCKgG7+J+9DmpMGxO6TNByh0LgMxpZyVluCTFpCfiXsg
	 iLXXpPJxYp/GQ==
Content-Type: multipart/mixed; boundary="===============6888835219003920083=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0280b36e7167eeb1789de6086d94607e6ba53918fe9bdd4c712c1ef628af488@mail.kernel.org>
In-Reply-To: <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
References: <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
From: bot+bpf-ci@kernel.org
To: rahadbhuiya2021@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,rahadbhuiya2021@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 05:57:41 +0000 (UTC)

--===============6888835219003920083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()

TL;DR: Commit message only: it doesn't name a real program or compiler output
that produces the zero-in-dst register NULL check, which clang doesn't seem to
emit, plus two minor wording nits.

> bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
>
> check_cond_jmp_op() propagates PTR_MAYBE_NULL nullness through
> mark_ptr_or_null_regs() when it detects a BPF_JEQ / BPF_JNE
> comparison against zero.  The existing code handles only the
> 'forward' operand order:
>
>   dst_reg = nullable pointer,  src_reg = known-zero scalar
>   (e.g. 'if r0 == 0')
>
> The symmetric case is left unhandled:
>
>   dst_reg = known-zero scalar,  src_reg = nullable pointer
>   (e.g. 'if r6 == r0' where r6 has been proven zero)
>
> When the symmetric case occurs:
>  - type_may_be_null(dst_reg->type) is false (dst is scalar zero)
>  - The null-check block is skipped entirely
>  - mark_ptr_or_null_regs() is never called for src_reg
>  - src_reg retains PTR_MAYBE_NULL in both branches
>
> Additionally, the early unprivileged-mode pointer-comparison guard
> (line 18058) rejected any conditional jump where src_reg is a pointer
> type, which would have made the new block unreachable for unprivileged
> programs.  Comparing a nullable pointer against a register proven to
> be zero is not a pointer leak -- it is semantically identical to the
> already-permitted forward form 'if (r_nullable == 0)'.  Exempt the
> symmetric null check from that guard.
>
> Fix: add an 'else if' branch that mirrors the forward logic for the
> symmetric operand order and extend the early guard to permit it.
> Add corresponding symmetric JEQ, JNE, and negative non-zero dst test
> cases into verifier_jeq_infer_not_null.c with __success_unpriv to
> exercise both privileged and unprivileged paths.
>
> Commit 6aed0134d3cd ('bpf: Mark the zero register precise for a
> register-form NULL check') introduced the precision marking for the
> forward case; the symmetric case was overlooked there.
>
> Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

This isn't a bug, but the changelog mostly walks through the code paths and
doesn't name a program or compiler output that produces the symmetric form.

Clang emits 'if rX == 0' for both 'p == 0' and '0 == p', so the zero-in-dst
register compare doesn't appear to come from ordinary C source.

Could the changelog say what real-world program or toolchain output hits
the 'if rZero == rNullable' form?

Two smaller points on the same text.  The '(line ...)' reference in the
paragraph about the early guard is a source line number that will go stale,
so could it be dropped?

Also, the forward-case example 'if r0 == 0' is the BPF_K form rather than
the register-form check this message is about.  Would an example using
'if r0 == rN' read more clearly there?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37887809131
--===============6888835219003920083==--
