Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711192;
	b=JLqsmA3+3BFDqijaKrA+fg9b1bvABnxg6sBgZeLl7wEs7E4tiCHQ74khn9V5ejgo00b8
	 6+hcU/Y6NmcVwnjPFntYP7zgw9R7DU9eWctwyqLqpq9wM3cW9483sZxa1EsP94AHNqneb
	 p5pSwxVLERE2XiLuNEfDO8rF0utkiBx9Sv6xfi9YWJxQU3umb8bHNskp/qPJCZ3rFMvnw
	 t12SqMRgPR90+4Ws/IycQo3+ElHwPcCvGSBy1pFkWbW7x/5eELP+oe9+PbPSMaHyh8yXO
	 1D7/rQnZB4ZgUgfonpb10WgU74rgzAo8XyriUdrV72n7zKbJdNO0c4OrjjA0GR3/GPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711192;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qZZsN3xAzkTC7OGuBpzyWxZ/z29NDl3IrjdD01KMVzk=;
	b=fAKyU8coTBoN/8WKb4WXmt8znHU7VgRjaqvJs6bf+L4kJN3D8b0rHQAOzxlWVWnQlsfk
	 HOJkkfQuN8vhk3CbUlJHEfn5smKD9Gg2tYoOgAJhz3UF+84vUoHRf/BaAkatIel8u2HLJ
	 XL7OSO/nSC/3Vk4yWjzs/q6VLmh4yH5eJ2pmgY3QFN15xY/D/FpWR1b0fd2oPpuc4JqfS
	 R+llCDSsC6Di7XiZtHKWY4RIZn0k0XEFI2NyAMzd8k2aSNoyfhzcHVWakAj1UWiSljQkQ
	 YBKEiKmBPoEqdGGToN247mIQrWzH9a7Tgzb5jtdFpRs4x84o5A+inuy93yhTtUrqr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmgfLQMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA96085097
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmgfLQMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1751F00A16;
	Tue,  3 Nov 2026 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711191;
	bh=qZZsN3xAzkTC7OGuBpzyWxZ/z29NDl3IrjdD01KMVzk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cmgfLQMY+hwuOGBlF1hYKhvcP/kBbgxUT/B9A8ap6wiSQdSkRTc+Q+/v7dsc7Tbzz
	 wqCbEOH66mXqqS07Xw8XYGGL4l4Dj1jeEuhLhiYP0oJ/Tw79JIeYoXiZK6ZB5UTDOq
	 FADUxwcHzdxqUH/bnFIjRGgC5YbAstWBQmXdFvgJ9aGKa8EE16nEHDgQNPQt6TwRa6
	 qrgUZ/jZf4dZIZRno/Cr+dilG55gW3Nl5s0aGW7+3mSKyZeKDZvDuifDTdmNrdCbHH
	 FGymNTlgpncsOO8Cj+sA/jXb/+kROH2smyd8HExFRKkw5nxTUar/qnJLF/lVPx+c5P
	 Z51DuBU9LhGYw==
Content-Type: multipart/mixed; boundary="===============7635132256929784795=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b4a1c11984ae56b20c040a1c3de141850a2267fb93b71025927fab27cb2449b5@mail.kernel.org>
In-Reply-To: <20261103122733.1383002-13-daniel@iogearbox.net>
References: <20261103122733.1383002-13-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 12/20] bpf, arm64: Adjust compares with unencodable immediates by one
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: puranjay@kernel.org,memxor@gmail.com,xukuohai@huaweicloud.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 13:06:31 +0000 (UTC)

--===============7635132256929784795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Adjust compares with unencodable immediates by one

TL;DR: Nit only: the adjust_cmp_imm() comment in the arm64 JIT may be
inaccurate about how mask compares reach it (via x >= C to x > C - 1, not x <=
C); suggests rewording.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -477,6 +477,76 @@ static void emit_arena_ldst(const u8 code, const u8 rt, const u8 reg, const s32
> +/*
> + * A compare against an immediate neither cmp nor cmn can encode is one
> + * against its neighbor with the adjusted condition when that one fits:
> + * x < C is x <= C - 1 and x > C is x >= C + 1, for the unsigned as for the
> + * signed conditions, as long as C - 1 or C + 1 does not wrap. LLVM
> + * canonicalizes x <= C to x < C + 1, so the compares against a power of
> + * two or a mask plus one arrive here.
> + */
> +static bool adjust_cmp_imm(u8 *op, s32 *imm)

this isn't a bug, but is this comment accurate for the mask case?

A mask such as 0xffff does not reach adjust_cmp_imm() through x <= C
becoming x < C + 1.  With x <= 0xffff turned into x < 0x10000,
is_addsub_imm(0x10000) is true, so build_insn() emits
"cmp x, #0x10, lsl #12" directly and never calls adjust_cmp_imm().

Masks arrive through the other canonicalization, x >= C becoming x > C - 1:
x >= 0x10000 becomes x > 0xffff, which is the "if r1 > 65535" example in
the commit message.

The commit message names both canonicalizations, but the comment keeps only
the first.  Could the comment also mention x >= C to x > C - 1, for example
"LLVM canonicalizes x <= C to x < C + 1 and x >= C to x > C - 1, so
compares against a power of two plus one or a mask arrive here"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41637976292
--===============7635132256929784795==--
