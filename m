Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515208;
	b=O7bY35n8nQuupr60MqalZDKR/FfeGX2t3LRCqh4ZNedx26a+3hIBwmLFyEGAEfns04P2
	 uRIKlUa3s/zp+6gpFSr8ZrWPESDZGCEuvBtxvV8AOPkq/tVzeDVc0E4o3IIuV0VvE0xBx
	 WYk/laMHEb67FVlSUlvVrR9xIAubJuyWGP2x+p+XWQZvkfH0LAL/rcVEFBQp6gw6Xarco
	 CtTvGKEh4pZKwtQjWEbhfsvEJRxgl6AeCZXvqkMSWJBkjyFmaEaLiva9HmmZAwUBQtuRI
	 c/WFQsuMIKVt85mOKfxme0MXz2WxZr4vGhLwooes+JqqlSwyM5bjqtpA5pM7mHXt2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515208;
	h=Received:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date;
	bh=yRCTc12rF2cbB54pOhxGdZ+hQohl83LOurc/J73gcVQ=;
	b=ZZmeEZJrkvIlrWGB8ZjVzFULB5GimuZd0MVDExjWCqtfyJXuyQa5bnPmom3m1hgKf4w4
	 2UGr+ybdC5XqPJ7Ls9d9rF3dkH4fyRJXioEROw1TITCRGg77GGm8ciVsswaMhrPJPq9yj
	 4+ER22fLN8EmanJJrJsODOZZqkX/93xZUtIPkzee05fvZUUXqskKxH6/o0Lvwc7W/J6x6
	 Ie6EzS3Vx9yIObr/kKqX1egogDnY22p16PHlHkv/KncGurfZeVnsoD20SBvzz85vDLmj5
	 CiQ0uJE2OZd6TFwhJAIvEAwjgi0Z3vEtARS1uU560Z3YIhrkohmy2e7cX6+68leiWuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE173606A339;
	Tue, 20 Oct 2026 16:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344171F000CA;
	Tue, 20 Oct 2026 16:53:27 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============5436744253090291661=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3e177386ed0ff37815ee705fb2cb8195952b4301858e4ff4e2b4638d14d94c3d@mail.kernel.org>
In-Reply-To: <20261020161907.2115379-6-vineet.gupta@linux.dev>
References: <20261020161907.2115379-6-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v3 05/12] selftests/bpf: Cover the low-32 link for zero-extending movs
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 16:53:27 +0000 (UTC)

--===============5436744253090291661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover the low-32 link for zero-extending movs

TL;DR:
- Selftest comment calls the mixed-kind no-sync case unsound, but the program
  is safe; it is only lost precision
- Commit message says "Twelve" programs, but there are thirteen

>     selftests/bpf: Cover the low-32 link for zero-extending movs
>
>     Twelve programs, one per decision the previous patch makes:
>
>      - zext_mov_narrow_src: narrowing the source reaches the destination
>      - zext_sync_makes_member_const: and over all 64 bits, since the member
>        is the zero-extension
>      - zext_narrow_dst_keeps_base: the reverse must not happen
>      - zext_u32_src_is_full_link: a provably-u32 source still propagates
>      - zext_self_mov_no_link: a self-mov mints no id
>      - zext_chain_drops_link: a second 32-bit mov drops the link
>      - zext_no_sync_between_mixed_kinds: differing kinds do not reach each
>        other, in either direction
>      - zext_no_sync_from_subreg_base: nor does a member reach a base whose
>        high half it knows nothing about
>      - zext_sync_between_two_subregs: two low-32 links on one base do
>      - zext_unlinked_path_stays_reachable: one unlinked path keeps the
>        guarded div reachable
>      - zext_mov_breaks_linked_src: forming the link drops the source's own
>      - zext_sync_keeps_narrower_member: narrowing the base does not widen a
>        member that already proved itself tighter
>      - zext_contradiction_keeps_range_sane: a contradiction leaves no empty
>        range behind, under BPF_F_TEST_REG_INVARIANTS so the violation is a
>        load failure rather than something only dmesg sees
>
>     Written in asm so the bytecode is the same whichever compiler built the
>     suite.
>
>     Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

The changelog says "Twelve programs", but the list below it has thirteen
bullets, and the patch adds thirteen programs:

zext_mov_narrow_src, zext_sync_makes_member_const,
zext_contradiction_keeps_range_sane, zext_narrow_dst_keeps_base,
zext_u32_src_is_full_link, zext_self_mov_no_link, zext_chain_drops_link,
zext_no_sync_between_mixed_kinds, zext_no_sync_from_subreg_base,
zext_sync_between_two_subregs, zext_sync_keeps_narrower_member,
zext_unlinked_path_stays_reachable and zext_mov_breaks_linked_src.

The count looks like it was not updated when
zext_contradiction_keeps_range_sane was added.  It is the last bullet, but the
third program in the file.  Should "Twelve" be "Thirteen"?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> @@ -710,4 +710,352 @@ l_exit_%=:							\

[ ... ]

> +/*
> + * Two members of one id set carrying different link kinds do not propagate
> + * to each other: r7 is (u32)base and r8 is base + 3, and the deltas were
> + * added at different ALU widths, so narrowing r8 says nothing about r7.
> + * sync_linked_regs() declines the pair on the kinds before the deltas are
> + * ever consulted. Note neither register is the base -- that is r6.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__naked void zext_no_sync_between_mixed_kinds(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	w7 = w6;		/* forms the link */		\
> +	r8 = r6;						\
> +	r8 += 3;		/* r8 is BPF_REG_LINK_FULL, r7 is BPF_REG_LINK_ZEXT */	\
> +	if r8 != 3 goto 1f;	/* must not propagate to r7 */	\
> +	if w7 == 0 goto 1f;					\
> +	r0 /= 0;						\
> +1:								\
> +	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
                ^^^^

This isn't a bug, but is the comment accurate for this direction?  It says
narrowing r8 "says nothing about r7", and the asm comment says the narrowing
"must not propagate to r7".

r8 is a BPF_REG_LINK_FULL member, so r8 == r6 + 3 over all 64 bits.  That
relation inverts exactly, so knowing r8 pins the base, and r7 == (u32)(r8 - 3)
follows.

In this program the fall-through of "if r8 != 3 goto 1f" forces r6 == 0, so
r7 == 0, "if w7 == 0 goto 1f" is always taken, and "r0 /= 0" cannot be reached
at runtime.  The program is safe.  The verifier rejects it only because
sync_linked_regs() skips every pair with differing kinds:

    if (reg->link_kind && known_reg->link_kind &&
        reg->link_kind != known_reg->link_kind)
            continue;

That check exists for the other direction, a ZEXT known_reg against a FULL
member (scalars_alu32_alu64_cross_type), where the 32-bit wrap really does
break the relation.  If the differencing arm ran for known=r8 (FULL, delta 3)
and reg=r7 (ZEXT, delta 0), it would compute r8 + (0 - 3) and then
zext_32_to_64(), which gives exactly (u32)(r8 - 3).  That is sound.

So this test pins a deliberate loss of precision, not a soundness requirement,
but the comment presents it as unsound.  The text is unchanged at the tip of
the series.  Someone who later makes the verifier propagate FULL -> ZEXT will
see this test fail, and the comment will suggest the improvement is wrong.

zext_chain_drops_link and zext_mov_breaks_linked_src also reject runtime-safe
programs, but their comments say the link is dropped by rule.  Could this one
be worded the same way, for example "sync_linked_regs() declines mixed kinds
even where, as here, the relation would hold"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836
--===============5436744253090291661==--
