Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496143;
	b=vhpO/NRZpLQsYRs8vJgqt96dSagPHWPIjX1+z5tSKZJgapOGv5rT7xhS8OvDxoj4fV2u
	 n/CGWSyPoWNq4kQhM1+13b6Y/PTZSkj1ClOB9Y9em2TqqSTgiqIF2saBOm9YFvnUuXSk3
	 gk6OSlZLTzQEnVTfbCV9cb4dk13oXmviC96kOfoDX0fUFDeWtxuPOSt9wl5Po3w1FDza7
	 6OcDw4DThu2Kok9i8AskR/Rj3CYUdfRzxJJTDNjIivtKTTcOANcPNle+P9JI5Weegf2h6
	 riEpWPX17JHtSPUNPSSU427vfyxjsAp55p6T01trelY1Lw5GrS7xx9b4rCWr8SDP4QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496143;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=R5QWvypi0aCvk9HJ7VyW3IR6/L+qkp4okDtESBu6pbE=;
	b=R4aB3i+gSVH+9SprX07B6CcWFFJ2CpzeD3XKGqFaTNOXitOBzb5rzyTVFYxlVWV3gcrQ
	 ViHMRw144l629OEYHjEVrrgq4jJZWV74yF9ZP8osaB9T8A3QRu8pniiLTZMY8yeZzfgjw
	 QMeOeungENJ0BQi9wrSHGhQ9FIxNad7QgqltDtaswIVlseKvdgqjslXd5gg99fpGiuYJM
	 X+EQuMdKb/2/N6Qyyqn59Ul+S4qEQdslzLnKdecUzwiBoxQILitGxfaChL0ra8w8tv0U+
	 etiUlcdoxDqRIUQx3CthJfH+pNhg5bXMMNSrKquiP5+ZxifEei7NyotU4bMegk9H4YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DplavEqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737D606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DplavEqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342421F000C4;
	Tue, 20 Oct 2026 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792496142;
	bh=R5QWvypi0aCvk9HJ7VyW3IR6/L+qkp4okDtESBu6pbE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DplavEqD6M/upk2d8HR4N/lWPzZw3SId0htsBFWQ6N+4bv7zZKQMkZ8PFfO8Sudq7
	 dAa+lqs533/0EASOeM8wXWJNNOgGqZUaQrg2roMEtQ6BsiFiRCK5k+LOIsWCV39Zzf
	 CWwMQvWQ39dJI2zhX6rz/QT8uAhH7cublqUPDsoWIOsoGunUAlAd2lot4nAiOq09hM
	 5Agng36YZO5VDdvLrxTF8+nD8A6o+V0UsuXcgR2hT/Erq3sPzkkNLWdBdxO7FaVWe6
	 7RbaGLNMO+VJRh7IEUXWU9bSjfmp4xudIjDM8JU69lMpGPqkuPArE9EhEFXSseVQKh
	 VtcNkbLP2RRnA==
Content-Type: multipart/mixed; boundary="===============1154259022663780996=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <99c94e5f0c7cb68d9e87f7675ef85fde147bc6f71e59003559f0f01cc3eb4f2a@mail.kernel.org>
In-Reply-To: <20261020-scev-32bit-v1-2-838f34f9f0cd@gmail.com>
References: <20261020-scev-32bit-v1-2-838f34f9f0cd@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: tests for 32-bit scalar evolution bounds computation
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 11:35:42 +0000 (UTC)

--===============1154259022663780996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for 32-bit scalar evolution bounds computation

TL;DR: The post_cond_jne_neg_step log expectation update belongs in the
earlier "support 32-bit linear scalar evolution" patch; as is, that selftest
would fail at that commit, breaking bisectability.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> @@ -1549,7 +1592,7 @@ __msg_next("  r0=(+ r0 -1) / (linear (+ r0 -1) -1)")
>  __msg("loop header at 1, header_count is 3 ")
>  __msg("loop header at 1, widening r0 to 1..3 step 1")
>  __msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) loop_stack=1")
> -__msg("loop header at 1, clamping r0 to 1..2 step 1")
> +__msg("loop header at 1, clamping r0 to 1..2 (s32 1..2) step 1")
>  __msg("processed 5 insns")
>  __naked void post_cond_jne_neg_step(void)

This expectation update is only needed because of the log format change in
the preceding commit 7c8f85ad75e9 ("bpf: support 32-bit linear scalar
evolution").  That commit added log_bounds(), which appends an s32 range
whenever bounds->r32.size < U32_MAX:

    if (bounds->r32.size < U32_MAX) {
            bpf_log(log, " (s32 ");
            ...

In bpf_clamp_scev_regs() the 32-bit bounds are always intersected with the
register's current r32:

    bounds.r32 = cnum32_intersect(reg->r32, bounds.r32)

For the 64-bit post_cond_jne_neg_step loop this gives 1..2, so the clamp
line becomes "loop header at 1, clamping r0 to 1..2 (s32 1..2) step 1".

At 7c8f85ad75e9, verifier_scev.c still expects:

    "loop header at 1, clamping r0 to 1..2 step 1"

That string is not a substring of the new output, so
verifier_scev/post_cond_jne_neg_step would fail at that commit.  The same
commit already updated the matching expectation in verifier_stack_ptr.c
(stack_ptr_subrange_in_loop: "clamping r7 to -64..-16 (s32 -64..-8) step 8")
but not this one.

Should this one-line hunk move into 7c8f85ad75e9 so test_progs passes at
every commit in the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39413885357
--===============1154259022663780996==--
