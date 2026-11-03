Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749327;
	b=Pt2kvSmi5BRBblclc0M6hn9HPiQmPrLA5g3SIQagsp3TTazOlYf+WoQVS0gM0Q2BOB8v
	 ycpaop5iOf3MW14LlcyOPq7EYC0oCdYBH8hSUQWL9St5Kw7oR3Z9rYA5Cz59UecDV22Qw
	 Hkbg2N7wz0tgZMBKOxd2XM0uF8GOwroZEErnIQJtviPDJp5Q8+ruPMMwssE6qRAzMt/o/
	 dmlg9qmT7kZk/WHbVLeYQHYB7FZmhVZgUOI6kFJSVXn4n/j2RCU4xAaUKsDP664C3pewt
	 rB3v2ES4c7gNER9kikLl+Pvj4oZ8x4DD97AHFv4XT17kQno6Zij3U7wzNm0I6BnJu6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kjNtHfENLhN8j55D29hFtXks1l/c+bLf6udUiW5oZBI=;
	b=H5WrGGaCV3ZAr+47wQ+Qu+VI/2qBVZj1rj8B0gnSLlv2YmPxlapEyRNKfzBjIKgfON5X
	 aZRBcwgqlOazsZONs7dFBeDuIjrxECA0VfeaJULUniFSu+eSQbDmz/SdDT/FytPvBNKjf
	 c9EbdcQzO2FSfRszPuC+1rvulxGisJmmYueUaerKNb8o7wcli+kXoISbvpuRLlzdc0V7j
	 maBimuf370XwsBv1DbCR5eVVfH22VZlaRRGpMq3s8Pfl4nHX1p2WGV2JOyKsLuidifM3d
	 E8E8aWoJDnoiqCOPlNCi1wJk/qiOVg/M+bvAnEhwvPgeNzmQFnmNj/qv+yjVfm++3JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vp48r+pt;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC136606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC136606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vp48r+pt
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so22268a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749326; x=1794354126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjNtHfENLhN8j55D29hFtXks1l/c+bLf6udUiW5oZBI=;
        b=Vp48r+ptIiC1cy5O0eTCbS3xOUp0lj6/i6CIS9kQTsJpV9FuJy28mDtK0m7cukynZk
         sdSX3WNKWT6fvOrimDiymgvKWWOTC/MzJRwwHm44N0uJ3gwG4ttxaq++AEgUzxfif3b/
         TtovQChTG6pjjhEpRZXIjPtRUhVebGok7UK/kjcVXn9UbuhWch+ZeUWacQrDgV/UPTUX
         uIuL7h1gkesij/q5hewMKtNT3nSBZNmTcNKJ+3aaQ8QZB7l+4y9eVlBgrG9oYNlpilP3
         qe7Kc3FCOga6pOfOL5T2VQYTkftOQlkdGQe7ZkK/nwlpU3sVROMj1un0Z8Lhp4eUDXns
         53Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749326; x=1794354126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kjNtHfENLhN8j55D29hFtXks1l/c+bLf6udUiW5oZBI=;
        b=DYklLigvslnlLBUiUgeFVO16GAI7JcRWB3p9RhxtT9pF6em+3nO4z2fVcsdaXo8CE3
         mLwp2Kam490IspoYUQ165+QbHuF0j8SRRqwiYfTTgKcvigzLW4G44XTCQt4O4OnKrXCf
         3a16kbdmKUkdr0iJi3baB3udhXraonPwSYK39uYHjML7L+7JI2Y+TmblcJCoUhVv82Of
         vyxd74dDCF2AOnrZvxz5P6Y1yU1U0w4BjJd5JG8/xqxmaB7dh9+WIiK2LsE0ReKgRblO
         V4s9lRHI38oneI0s/VcPbto/sJG2B65D7ARBniGUgL+LZCCq2FMKKeJ5aMOme8IwdEom
         1vLg==
X-Gm-Message-State: APuU4Z/omjghfJHJ559kCYYVbeJ9CT7K5GdMKeekr3TaePfSy5KNpuEj
	sXQpO/iY3802abmnzH1bafAJtFFrn4+4GJJEx/AMM1MpYkCFfnQBpNOzeOJy1g==
X-Gm-Gg: AYBFou04UpYbs+vA5P1IURu4B7neM2LnFmnMfrgKjJtOi+ddUf/X4mzew3X6ZgGRVgV
	5MDXRZ9za6z6BEPFjnYx3mgRANiu5ZmP/KtFh1rfpj4phjF1SS8IxLImx7XCLPfE7C6hC/qFlhE
	NjA3ydqWcuzUbQTlW5BM57K6OSqCp95G0YzibGxAijfoIM6w7l4fSJiA0b1linm9yK4a/zKj3x7
	JXRxFMmQHMvwqTrhBx0fsVnIworH0Tc9pWw8Gth6k8uM2vFWepaourWQNMvOSwropVQEKfdUjhN
	HNw2fY1JgVUuOcLl/wOAgrEdPGBmNZB+ORwY4TbZSDwFRJVeYubgKoO/JDjOMmPLSHlnejixWzr
	J8Na5q8yD06gwdCTkNZpiX3MkStNWSRz5wnZMNS21wYV2n4zOD40CwJGv3ARee8FISac1clCwVu
	yCiDYoDjxpIWoBVApc3TJlnP205Uh2AhxlVhpqMtd0lX4eeQtP7MsNpsA3TbK0tMEb+uhwYD3R8
	iTzxrCTedgvXZDm9icPCVh81CFlUVuI4GB/bhY8eIn5hn/ukt66fFOagk+3x0GTZP24ydnp5oVQ
	cEMRgq3cNUFIQ2GFbo5stegZga1PTM4s0CEnHi7sZ8z88ZuMmSW+TVAdcOnjd/dlql77TfWxhRo
	dsXYgjcM1uvg8lh7vir2S1CeGGpU32mOgGnqAslJS9l5Ko2lhLVGJQB1VsTx5+2tngso7B4/3Ub
	Q=
X-Received: by 2002:a17:90b:3c44:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3ae89559f53mr7194970a91.1.1793749326195;
        Tue, 03 Nov 2026 15:42:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1043820a91.5.2026.11.03.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 10/37] bpf: Let scalar evolution see loads from read-only maps
Date: Tue,  3 Nov 2026 23:40:35 +0000
Message-ID: <20261103234104.208239-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

User space often sets the bound of a loop in .rodata before it loads the
prog. The variable is volatile, thus the prog loads it in each iteration:

  const volatile int nr_cpus;
  for (i = 0; i < nr_cpus; i++)

Scalar evolution calculates how many times a loop runs. Then the verifier
does not have to verify the loop one iteration at a time. But scalar
evolution does not examine maps. For it the result of the load is unknown,
and it cannot calculate the number of iterations:

  loop header at 3, non-linear latch at 5

The map is read-only, thus the load always gives the same constant.
bpf_compute_const_regs() runs before scalar evolution and already knows
this constant. Use it. insn_aux_data of an insn describes the registers
before this insn. Thus the result of the load is in insn_aux_data of the
next insn.

  loop header at 3, header_count is 10

A loop with a large bound in .rodata reached the limit of 1M insns. Now it
loads, as it does with the same bound in a register.

A counted loop is verified with ranges, and there is no way back to one
iteration at a time: a prog that needs the exact counter in each iteration
(an offset into ctx, two counters with a constant sum) is rejected now, as
it is with the same bound in the insn.

7 loops of scx_cake get a count. Each of them changes one more register
that has no formula, thus the verifier still unrolls them. No prog of
Cilium, scx, the selftests or the public progs of Meta changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 0f46a85f7648..8521c34899b0 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -770,6 +770,15 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 		switch (mode) {
 		case BPF_MEM:
 		case BPF_MEMSX:
+			/*
+			 * for (i = 0; i < nr_cpus; i++) with "const volatile int nr_cpus":
+			 * bpf_compute_const_regs() knows what is loaded from a read-only map.
+			 */
+			if (insn->src_reg != BPF_REG_FP && idx + 1 < env->prog->len &&
+			    (env->insn_aux_data[idx + 1].const_reg_mask & BIT(dst))) {
+				imm = env->insn_aux_data[idx + 1].const_reg_vals[dst];
+				return replace_reg(scev, e, dst, imm_expr(scev, imm));
+			}
 			return maybe_load_fp(scev, e, insn);
 		default:
 			goto mark_dst_unknown;
-- 
2.55.0

