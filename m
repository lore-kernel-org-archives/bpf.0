Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128083;
	b=1VSTXvfF7NlhPaXxzayMYmrrLn5+VoNEAC1Z2tFlVi37iTbCpMELjuSdqnfeyjMopY+B
	 AVvsyYhyF1VqE1gL2TRcni8ybvQ4A0m4trcneo0YDH7pVjvLD9BRa/d/j6fRHglkNoaq5
	 5thBoa7iye2aAtKsi9S+O0ARqkBRTIuVJoqZlzAB1QMMlmE/cZf2F8rhq/4Tm0iswa630
	 Im+PI1DQJ+ljaZa48PmSy8KiBrCboOQqU7Upurdn02coDZGBF5bCWFARPENlpH93UZZQa
	 2dLZTOqro/MzHiuc2znDddqb0wOaOJclMGR2PVO8VOZ8UETLkbswYCV/6OInYxQtOVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128083;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Tmzlha5fHxoDIGVYVlwZw1+tTWaUkGxF0ENAmaUq798=;
	b=ZIAGbc5V21ZgN5Ex5y12f6xPxFcIiMJnhfCyekrqPl48cP/3XZg/2Eu7OHZ+K1wDbolZ
	 9jx7Z0YyHPFIykoy4va3dP14k3w1mbV6sRcq3nQpgDvozf16kS0YOiYTkIPC5Ue3meQG7
	 Kminpfz0jTOYL7Of83F3VwAAP8+1czX0GHfAdV7fspQ1cznlkPOCsSI+YzzKX+j79OTaT
	 xyKlFmyrEUZgYTDwcGw7b6lKhla2qLwKPnxNAyyQIu8lsZclE90AVKn6dgTH8Yny54CAw
	 XPCME87dwb0V6WnsGeKIVC73nhQKuFDInBs6GAcrCLcuyDcXBTWhXfvZorMNAJBN5HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3MS+3zG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D913606A320
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3MS+3zG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B881F01829;
	Tue, 27 Oct 2026 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128083;
	bh=Tmzlha5fHxoDIGVYVlwZw1+tTWaUkGxF0ENAmaUq798=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=k3MS+3zGsknDWvneZo+TkO8ENwC0rT63PryDYK+to6NKr5X3bjYe5unX5rhzE3Uez
	 Dt8L0m4aKPVUv2yKVWG0L+32/J9f4tyfYSRUSafjqVioc6/ZmFVE+f0h671c9LPP1I
	 WJSBOZl2RPLuQJ4yrjSXot+NeCbdsw7oCavAQ6rj7qCalfzVfSwMVwYpQrEP0VEdFj
	 mdlRjLdKnoPj1FCrin9peyqnDUIMlWyVsVhmtoZfetv0FtNbQ1ITr7PiDF6pU5YOa5
	 DpQkaa5s3567IA+5LGueeBdvViXnNinpNO9kMysi16AZmhRCVunwxpcsiuj8yx9sQH
	 skTTqlKM2nh+w==
Content-Type: multipart/mixed; boundary="===============2665052125987649329=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9832ca99bb2aed8262e1986075a6bab1b7c84ebc69ef5cc3a73bb63da06e4306@mail.kernel.org>
In-Reply-To: <20261027182445.1156335-22-daniel@iogearbox.net>
References: <20261027182445.1156335-22-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 21/21] selftests/bpf: Extend the JIT instruction tests for arm64 encodings
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,puranjay@kernel.org
Cc: memxor@gmail.com,ast@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 19:08:03 +0000 (UTC)

--===============2665052125987649329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Extend the JIT instruction tests for arm64 encodings

TL;DR: Nit only, not a bug: the hand-packed INSN()/ATOMIC() macros for
load-acquire/store-release in jit_insns_arena.c could use struct bpf_insn with
__imm_insn(), dropping the byte-order variants.

> diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
> --- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
> +++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c

[ ... ]

> @@ -32,6 +32,65 @@ struct {
>  #define VAL_SUM	0x11224578aaccef10
>  #endif
>
> +/*
> + * The load-acquire and store-release, which clang has syntax for only with
> + * __BPF_FEATURE_LOAD_ACQ_STORE_REL, as the 64-bit word of their fields for
> + * .8byte, in the byte order of the target: the two register nibbles share a
> + * byte, which the first bitfield of struct bpf_insn takes from the low end
> + * on little endian and from the high end on big endian.
> + */
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +#define INSN(CODE, DST, SRC, OFF, IMM)						\
> +	((__u64)(__u8)(CODE) | ((__u64)(DST) << 8) | ((__u64)(SRC) << 12) |	\
> +	 ((__u64)(__u16)(OFF) << 16) | ((__u64)(__u32)(IMM) << 32))
> +#else
> +#define INSN(CODE, DST, SRC, OFF, IMM)						\
> +	(((__u64)(__u8)(CODE) << 56) | ((__u64)(DST) << 52) | ((__u64)(SRC) << 48) | \
> +	 ((__u64)(__u16)(OFF) << 32) | (__u64)(__u32)(IMM))
> +#endif
> +#define ATOMIC(SIZE, OP, DST, SRC, OFF)	INSN(BPF_STX | BPF_ATOMIC | (SIZE), DST, SRC, OFF, OP)

this isn't a bug, but could ATOMIC() build a struct bpf_insn compound
literal and pass it through the existing __imm_insn() from bpf_misc.h, as
progs/stream.c does for its arena load-acquire?

That would let the two byte-order variants of INSN() and most of the comment
above them go away, since __imm_insn() already gets the target byte order
from struct bpf_insn.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40562673614
--===============2665052125987649329==--
