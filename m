Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7F33AD8C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962868; cv=none; b=bgO43Lnlv5pD9JbE8WEMQBT19P2Unmf20X3C9639yPK8OjcVOUmn1whnUTyzokvDw0vsYife3Ebv/tSBe6xVMmo+U9Jo/nvZ5wN2hrZsyy49lZg4o93w3iEbcGetLQhRF+KAmkN/uHYHx4IB6cUJNHBLHGJ/kcdTiIUd5b+/OTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962868; c=relaxed/simple;
	bh=Lq/vGMC5vYRJUVwNz2P9DI4Ph0wLDgUIcefoBtUJhhY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V66rrMZrGnsDuSZcdUEfKPS1VhhEb6x+2y0atrv0rSNcfH9LOji/e9/QIejO+ylmTSp7Bm3gyMJVifQT+AySsynqUDHoYu3JSAbshTUxWxZjvuMhzbCg3tk/eFhxek0TGbwTb+63LJWwzW6nA4oaCrIN/dqu4CPfKJR3NOJOe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBmUhwSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBmUhwSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330E41F000FF;
	Mon, 21 Sep 2026 03:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962866;
	bh=S6m23BxRrrkr26/6RX2Wr6RAbmLoOVORANkqDKZSc1U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fBmUhwSPjThgY5cyqcHRuY/Tjy/P8eCU8KNPUXVLpABtJPYuDy+T8d9TC4vsqQ2RY
	 iM5c0bcdm8N5c9D8GpxVEjZVnkZiknGLGT+otqRZ5PIVhT+mXm4Qsrfvgn3XuzFF0/
	 WuxmFYFoM5Ig8bQymBY6gbOOWSlD9BNloGe1bMwAqSXpBznkFpSemCmlRgiVfjKxId
	 wi0+3xx77uKNVROioFkMEDkTyQbEtF0hVkO81tyWi57g/k3W1F4fWiOCOsdRQSN5N7
	 W0rNzyD4LFsaAHjCb2GBSII/wSTGChIfeixWEauksKNgtNgcRJi+v7CoVBb1ppvS05
	 LGZEfBD08/cgQ==
Content-Type: multipart/mixed; boundary="===============5075610289014533556=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e60da957ecfe21d6e8219580531a2c158002bb7d2d303056421440569f0c5cbe@mail.kernel.org>
In-Reply-To: <20260921023843.411943-10-memxor@gmail.com>
References: <20260921023843.411943-10-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 09/11] selftests/bpf: Cover generic output stack initialization
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 03:54:25 +0000 (UTC)

--===============5075610289014533556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover generic output stack initialization
>
> Exercise generic output buffers with and without CAP_PERFMON, using both
> helpers and __uninit kfuncs. Check that initialized bytes stay readable
> and lose stale value information, while invalid bytes remain unreadable
> without permission to read uninitialized stack memory. Cover constant and
> variable sizes, scalar spills, pointer spills, special stack objects, and
> privileged variable offsets.

The changelog says the tests cover "scalar spills", but does the commit
actually add a scalar spill test?

Looking through all seven files, the only register spill added is the
pointer spill in sysctl_partial_spilled_pointer():

    *(u64 *)(r10 - 8) = r1;   /* r1 == PTR_TO_CTX */

Every other added stack store is an immediate write (*(u32 *)(r10 - 16) = 0;,
*(u8 *)(r10 - 1) = 1;, etc.), which the verifier records as STACK_ZERO or
STACK_MISC, not STACK_SPILL.

The other four items in that sentence each have a matching test: constant
sizes (sysctl_partial_initialized_bytes, sysctl_partial_invalid_bytes),
variable sizes (sysctl_partial_variable_size, sysctl_partial_variable_size
_invalid), special stack objects (sysctl_partial_dynptr), and privileged
variable offsets (sysctl_partial_variable_offset). The missing "scalar
spills" case stands out.

The scalar-spill arm in check_stack_range_initialized() is a distinct
branch:

    if (bpf_is_spilled_reg(&state->stack[spi]) &&
        (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
         env->allow_ptr_leaks)) {
            if (clobber) {
                    __mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
                    for (j = 0; j < BPF_REG_SIZE; j++)
                            scrub_spilled_slot(&state->stack[spi].slot_type[j]);
            }
            goto mark;
    }

A SCALAR_VALUE spill is accepted even without CAP_PERFMON and is scrubbed
to an unknown scalar, so the readback-after-scalar-spill behaviour is not
pinned by any test in this series.

Could you add a test that spills a scalar register into the output buffer
(for example, r1 = 1; *(u64 *)(r10 - 8) = r1; before the call, then read
the slot back in both the priv and unpriv arms), or drop "scalar spills"
from the changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35555832550
--===============5075610289014533556==--
