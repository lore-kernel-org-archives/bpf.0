Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEF38E5E9
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489124; cv=none; b=hu96s3DJFpSat7+4cRCQ/xD7SkPpx4bh9sn8rrBI3Y/hQUOc+TiXiAUFxseP+8YWJvpeEncxXnzNCw5QmvrJDCQjtnYjvv52KA1FxdozahoreuN4XHweXc9h5EIC79v3dTKTg6ECOGI//Recf+gl2KCc0/HT7fFxbz3Af2I54RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489124; c=relaxed/simple;
	bh=W8Fmm/xts0FCjAd2BrRE/Q8//IuOTq3ahkcsAgoWxtk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VHhcBvMICiDR65GdAICRGocHNeJTsMc3FATyv2E4Gvpy5trXVrLd763E5+pogoiOrizWV5O+r5ehiPHDCTkGzhClsSqvBjRzv3Rb2Qc/Dq7cAjDzkUhmOpqfEmySjmguQTb9q7VtRuvk+10iGEiH/E7Xm3zyAJ5SQ/oqkLe1Cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPoTiPZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPoTiPZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0101F000FF;
	Thu,  8 Oct 2026 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791489122;
	bh=Y9HMb1cJndkfabftDI6BPGHMSnAmjuF7bpHuCNbJhmE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HPoTiPZuKYbMKvaW1AuaTMzD7GV/VNtjuSBf68bWIbdV2wknxUsh9zewOjV0bfRXA
	 m93LFBZVRwrfq8ZXdDCYPiiYf8gQ9984EcGMqI9MZ7NsYX/HWP2DwFYFSiUi4pfCIM
	 wVXU38FuEBTS55DBGivYzsCo5DCLqkw92lL79NMCFpCeT7BULnWz9lFguO/Ow4S2uG
	 +nGC0oeuxCdGj0/R+RZMJRHodEWodGpFJZlWDc3UDgXBxIDZ9AIEGhSZLdr0pO19jb
	 pJleHQXx5flvYCJDKDGi/RuX+ZpHcgoWMu7/TXfFRtiaPwzPxrIcnRqOoHeVkiRzLy
	 cfXXVvRJSE79Q==
Content-Type: multipart/mixed; boundary="===============4319941955989698344=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e19ccb59d8c0ee79f0aff8675b516a595388a0ec2279b684904125e7be60f5e7@mail.kernel.org>
In-Reply-To: <20261008185349.494-1-rahadbhuiya2021@gmail.com>
References: <20261008185349.494-1-rahadbhuiya2021@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
From: bot+bpf-ci@kernel.org
To: rahadbhuiya2021@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,rahadbhuiya2021@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 19:52:01 +0000 (UTC)

--===============4319941955989698344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()

TL;DR:
- Test issue: new selftest file may belong in verifier_jeq_infer_not_null.c,
  which already covers this path
- No unpriv test tags, so the relaxed unprivileged pointer-comparison guard
  may go untested

> diff --git a/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
> new file mode 100644
> index 000000000000..e49e9918a651
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Verifier selftests for symmetric register-form NULL-pointer checks.
> + *
> + * The BPF verifier's check_cond_jmp_op() handles "if R == 0" NULL checks by

[ ... ]

> +/* ---- Forward case (already worked before the fix) ---- */
> +
> +/*
> + * "if (map_val == 0)" -- dst_reg holds the nullable pointer,
> + * src_reg is the literal-zero immediate (BPF_K).  Should be accepted.
> + */
> +SEC("socket")
> +__description("null check: forward form (dst nullable, imm 0) accepted")
> +__success __retval(0)
> +__naked void null_check_forward_imm(void)

[ ... ]

> +/* ---- Symmetric case (required the new fix) ---- */
> +
> +/*
> + * "if (0 == map_val)" -- src_reg holds the nullable pointer,
> + * dst_reg is a register that the verifier has proven equals zero.
> + * Should be accepted; before the fix it was rejected because nullness
> + * was never propagated for src_reg.
> + */
> +SEC("socket")
> +__description("null check: symmetric form (src nullable, dst zero reg) accepted")
> +__success __retval(0)
> +__naked void null_check_symmetric_reg(void)

[ ... ]

A subsystem pattern flags this as potentially concerning, and it is not a
bug in the verifier change itself:  should these cases be added to an existing
test file instead of a new standalone file?

The same directory already has verifier_jeq_infer_not_null.c, which covers
this code path.  It contains jeq_reg_reg_null_check() ("r1 = 0; if r0 == r1
goto 1f;") and jne_reg_reg_null_check().  It also holds the precision
regression test from 6b31560c6bc1 ("selftests/bpf: No non-NULL inference from
an imprecise zero register") for the 6aed0134d3cd logic that this patch
mirrors.

The symmetric JEQ, JNE and negative cases would fit naturally as extra cases
in verifier_jeq_infer_not_null.c, next to their forward counterparts.  The
null_check_forward_imm case ("if r0 == 0") only re-tests long-standing
behavior that many existing tests already cover.

On its own terms the new file looks functionally correct.  The three
__success programs load in privileged mode, __retval(0) holds because the
empty hash map returns NULL, and the negative case still matches the "R0
invalid mem access 'map_value_or_null'" text.

Separately, none of the new cases has a __success_unpriv or __failure_unpriv
tag.  Does that mean test_loader only runs them in privileged mode, so the
relaxed unprivileged "pointer comparison prohibited" guard that this patch
also changes is not exercised?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37828996894
--===============4319941955989698344==--
