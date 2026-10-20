Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515176;
	b=JCHxb8HjhVRA7R1XXB4FOxolZrmk0Odzag5RYGNa5oW8ngLm3FM/lLACd+7yUaBErq6R
	 bYzQF6TP1Z3UDVD+SvVS0ds5zSqmuK9Tze4I8tdYBP8Pot2LK2P0kQeQh3R4MdRqXQ8uW
	 +e1Iso8qN1F5HfZNL6C1hSGqKXE4WAz6w2hylOClCc4bITyLDwaTIXIPhUs13/UZecb69
	 boK4Ybhrcno7JcnOFnTlDt2nr3DuUdTSu/hVXykGMY8in5xfXAGU+76HAYnYgAlrjNaqJ
	 f3aAg/7j2eHoGx+ka0Iqs2Qja97mHo1892V5rSK3tQQVDENI/U5QcoTttMrbyPhYWtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515176;
	h=Received:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date;
	bh=XM6QUhiAHMte//ZApppucvlSVjaxJ4gVEpSACq7TeeE=;
	b=y5k+fWIgWt8N0ZSXZHC1elsupYlbVdOh9RmyfML8xJd+DsIDsJflhlf2kWJWc2YYhUEY
	 89E2Z5w3JKl83jQGx64yVLfzjrGe4Ete7THab1DhY/Ts3/+AVWvKsJ/PWDwifhp3EaLHF
	 gCdsFmSe5QZd9cnTOL9+8MMEeUWVfx8Y2GAk6zY8U8vzf6xZcMTyb/UNe33TwIrLSwsIv
	 Ftx3TtcKWrcdfovHb0t7lmrUFFklY6GJi/XY+o7Eqt1cakKywO6uyVNj3CPYB9N+3StAN
	 3AmX5qas0hk2ciPdTOcSK/xN/c+7oMX8jnZvsTdzm6gs4oYsx3wOBxASNrVzmAoghcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FCA60A2614;
	Tue, 20 Oct 2026 16:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6183B1F000CD;
	Tue, 20 Oct 2026 16:52:55 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============1187056397503495093=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fb6e1da8e20593510ea7dbfc1527db1aaf4682c22968a209dbf2ed771646a6fd@mail.kernel.org>
In-Reply-To: <20261020161907.2115379-11-vineet.gupta@linux.dev>
References: <20261020161907.2115379-11-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v3 10/12] selftests/bpf: Cover the low-32 link for narrowing stack fills
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 16:52:55 +0000 (UTC)

--===============1187056397503495093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover the low-32 link for narrowing stack fills

TL;DR: Test issue: sext_fill_does_not_inherit_zext_link appears never to put a
zero-extending link on the stack slot, so it can't distinguish the new
check_mem_access() condition from the old one; its comment and commit message
look inaccurate.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index 69efe1381eca..ab78285153fb 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> @@ -1494,6 +1591,215 @@ __naked void sext_drops_stale_step(void)

[ ... ]

> +/*
> + * A sign-extending fill must not come away with a zero-extending link. The
> + * slot below already fits 32 bits, so the fill is not narrowing and assigns
> + * no link kind of its own, and "state->regs[dst] = *reg" copies the slot's
> + * verbatim; check_mem_access() is what has to drop it, since it would leave
> + * r2 recording a zero-extension of a value it has just sign-extended.
> + * Asserted on the register dump rather than on a guarded branch, so it pins
> + * the rule itself and not a downstream effect.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +/* a copied link would print as R2=scalar(id=N+0,smin=... */
> +__msg("(81) r2 = *(s32 *)(r10 {{.*}} R2=scalar(smin=")
> +__naked void sext_fill_does_not_inherit_zext_link(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
> +	w7 = w6;		/* r7 = zext32(r6), fits 32 bits */ \
> +	*(u64 *)(r10 - 8) = r7;					\

Does this test ever put a zero-extending link on the slot?

The w7 = w6 above does give r7 BPF_REG_LINK_ZEXT, but the spill that follows
clears it.  In check_stack_write_fixed_off(), r7 fits in 32 bits, so
assign_scalar_id_before_mov() runs before save_register_state():

    if (src_reg->link_kind && src_reg->link_kind != BPF_REG_LINK_SEXT)
        bpf_clear_scalar_id(src_reg);
    ...
    if (!src_reg->id && !tnum_is_const(src_reg->var_off))
        src_reg->id = ++env->id_gen;

The slot ends up with a fresh id and link_kind == BPF_REG_LINK_NONE.  The
4-byte ldsx is not narrowing, so the fill copies a plain id, and
check_mem_access() drops it through the existing !no_sext clear.  The
link_kind == BPF_REG_LINK_SEXT part of the new condition never sees a ZEXT
kind here.

This leaves two problems.

First, the in-test comment looks wrong:

    /* a copied link would print as R2=scalar(id=N+0,smin=... */

print_reg_state() prints +delta only when link_kind is set, so a surviving
plain id would print as R2=scalar(id=N,smin=...

Second, the commit message says "The last two pin the link-kind checks in
check_mem_access()", but this test cannot tell the new check from the old
one.  It passes with the pre-series:

    if (!no_sext)
        bpf_clear_scalar_id(...)

It also passes with a relaxed condition such as:

    !(size == 4 && regs[value_regno].link_kind != BPF_REG_LINK_NONE)

which would let a ZEXT link survive a sign-extending fill.

At this commit no spill/fill sequence appears able to bring a
BPF_REG_LINK_ZEXT kind into the ldsx arm at all.  Spills strip every non-SEXT
kind via assign_scalar_id_before_mov(), and a 4-byte fill of a 4-byte slot
does the same on the slot.  A narrower fill goes through the narrowing arm
instead.

That holds even after 3649346488fc ("bpf: Track low-32 scalar equality across
narrowing stack spills"), because the fill-side
assign_scalar_id_before_mov(reg) clears the slot's new ZEXT kind before the
copy.  No later commit in the range (3649346488fc, 73fbac05c8bd) changes this
test.

Should the comment, the test name and the commit message describe what is
actually pinned here (a plain id dropped across a range-changing 4-byte
ldsx)?  Or should the test be reworked once a ZEXT-carrying slot is
reachable?

> +"
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +"	r2 = *(s32 *)(r10 - 8);	/* sign-extending, not narrowing */ \
> +"
> +#else
> +"	r2 = *(s32 *)(r10 - 4);					\
> +"

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836
--===============1187056397503495093==--
