Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8B432BF4;
	Sun, 18 Oct 2026 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299316; cv=none; b=hnKgy/hDC5cW1BfTUlcG5cPNyoAHavpHPzO+c8UV4hxUdWAUltBgQWlOmK33Vpho6Gy8lSsLBwfhokVDpaKnonXZ6M/6SJIc4SnnxPhrxka/Y4ZcCSpyATjun24kppaViFL2LehUbkJhA2VUdtADkNQ/RDM1GpgfeiF5hnVmpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299316; c=relaxed/simple;
	bh=uY37keR15hCZ2NLqQgZMyoz8h/m2NMO6d32AwZcRbM0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bz6y/x0fJx91knfJAsVqcmEk8M9WSA6dGgEw4WUzOpmZExnLzZqH+Pv+7r0yFYIYpJh+DEmDjpCIyjGQeT46JAp/ZMV+0a69cgsZaj6DxGZorzAtS44TbJhfr+jpuakKVdEnEkl8tIxD/vMXE7gMJgducvpLMdpUNwnjWBXQ0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYoPb0SB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYoPb0SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5311D1F000C4;
	Sun, 18 Oct 2026 04:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792299314;
	bh=J4NypSWRQi4Sq1iRUPgtnqhT59QrLECQ+cytxmaxnhE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JYoPb0SBkYK15Y4hdUXcEbiQLQtawJZbMQk+t36Pucv+e1Z8vm+mnsDqtSuEv9s9r
	 W5ehUnkbPpoSzzLlYowZEY0m+oCVocmDg8sLgNh+qXiIrtQY+7XNbo1ZULSASIx6jx
	 +K/5EgecPk1oy0Ej23WE4Oxv6a+HrjPxa0OmIItwj8l4Xk+X1WnQptzxJfTNCWTPEr
	 Hso8YYJ8KmszRRM1QII3xCRCumPdwAJ8+keOXfYVeWw/xK6sY1KwQowZ1yLBUpVYel
	 bKBbt4oUIFty/s66ZqzIhlkOU4oQMF58hNacf6YVxf3onlRmsaloRRCv2Qde6PztZM
	 COp+wRD1T7+NQ==
Content-Type: multipart/mixed; boundary="===============2514161971178131042=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0413b3f51a48a8f318fd0923859cee1cf2837f1ffd431fa76f594dde6169d89f@mail.kernel.org>
In-Reply-To: <20261018-get-func-arg-v2-1-048848b3eddf@gmail.com>
References: <20261018-get-func-arg-v2-1-048848b3eddf@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Zero-extend the index in inlined bpf_get_func_arg()
From: bot+bpf-ci@kernel.org
To: random6.xyz@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,random6.xyz@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 18 Oct 2026 04:55:12 +0000 (UTC)

--===============2514161971178131042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Zero-extend the index in inlined bpf_get_func_arg()

TL;DR: Commit message only: the code looks correct, but the claim that the
raw_tp argument count is capped at MAX_BPF_FUNC_ARGS appears inaccurate; the
real bound is the 24-bit BTF vlen.

>     bpf: Zero-extend the index in inlined bpf_get_func_arg()
>
>     bpf_get_func_arg() takes a u32 index, but the inlined expansion compared
>     only the low 32 bits of R2 with the argument count and then shifted the
>     full 64-bit register to compute the context address. R2 is ARG_ANYTHING,
>     so nothing guarantees that its upper bits are zero: an index of
>     1ULL << 32 passes the bounds check as index zero while the load is
>     performed at ctx + (1ULL << 35).
>
>     Shift the index as a 32-bit value. When the 32-bit bounds check passes,
>     the low 32 bits of R2 are below R0, and R0 is at most 255: the trampoline
>     arm masks the argument count with 0xFF and the raw_tp arm uses the BTF
>     argument count minus one, which the verifier caps at MAX_BPF_FUNC_ARGS.
>     The 3-bit shift therefore cannot overflow and it clears the upper bits of
>     the register. Widening the comparison instead would reject indices whose
>     low 32 bits are valid. The check itself is unchanged, so this cannot
>     change which programs are accepted, only the address that is computed.
>
>     Fixes: f92c1e183604 ("bpf: Add get_func_[arg|ret|arg_cnt] helpers")
>     Assisted-by: LLM
>     Signed-off-by: Woojin Ji <random6.xyz@gmail.com>

This isn't a bug in the code, but is the commit message accurate about the
raw_tp arm?  It says R0 is at most 255 because the raw_tp arm uses "the BTF
argument count minus one, which the verifier caps at MAX_BPF_FUNC_ARGS".

For BPF_TRACE_RAW_TP, bpf_check_attach_target() only checks that the
typedef's target is a func_proto and then leaves the switch.  Unlike the
fentry/fexit/iter arms, it never calls btf_distill_func_proto(), which is
the only place nargs > MAX_BPF_FUNC_ARGS is rejected.

btf_ctx_access() only does:

    nr_args = btf_type_vlen(t);
    if (attach_btf_trace)
        nr_args--;

and compares the ctx argument index against it.  The MAX_BPF_FUNC_ARGS limit
that does exist for tracing programs is in bpf_tracing_ctx_access(), which
bounds ctx load offsets rather than the value that
BPF_MOV64_IMM(BPF_REG_0, nr_args - 1) places in R0.

The generated code itself looks correct, since btf_type_vlen() is a 24-bit
field (BTF_MAX_VLEN is 0x00ffffff), so (nr_args - 1) << 3 stays below 2^27
and cannot overflow a 32-bit shift.

Could the changelog either drop the "caps at MAX_BPF_FUNC_ARGS" claim for the
raw_tp arm, or state the real bound (the BTF vlen is 24 bits, so the shifted
value always fits in 32 bits)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39097593630
--===============2514161971178131042==--
