Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811946;
	b=UEmnn57P2EAcWrl1fuWU+tvW0GCDs7hah8oJc5l0tEGIuAbWjPpwHuYILlHJE8exNSwV
	 n8D6xa0CYd/L7sxNGRVWsfUt6qDxxaS9IQSBqGd63FxSWJr/lH9qab9A2K/dRzFFMYnSW
	 7F9/UCgSj0WwGEQVaU7IFhjl60RaM9B3ewETG5l7Hp1wVKaS2UoQk4Tl9tWp633YPEO/f
	 d562tgwqxdNPp6S7ERQ1Te+bjhf18mEYuEjAjPzYJJvQcR38HkzocyT5CD997pHhe6Dkd
	 5umqhQD1GMtfMOdYvqInrbTncFy6KmFH8vjmR/2vF3cOsSamtGaycbk7Zlb8Vwco3OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811946;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=FPqqu9XU8w0LvYNwsknyQ+lUEZw9t875ZNSJjnFWcbY=;
	b=jSGGW5CevMdgjaPqBNBxeY89TuH/cNPY0IvntxhiK0QS5Ia2R7vnTHtUEehKlC6zNqzc
	 0p4laQNkSlC4sXqoERcrrHcuJz9SJ/6r54euVFn7E8NPPXjjwcO8BSMiB6bqsFLbvpzEF
	 Ni9tZM/fSEhHGJih7PTk48UIOQ+xMLhi3DjneoLFq8RhE0myPwHLfPq/yP4ONbwQhVjUM
	 Axs5v9Iv5jORyeod5JnKUaYlM3hBa5PEyVWnyWw7UbzvFEu1SWGSZ5PnAMQ9L0i/CmJr1
	 mKRBIdcc0Vo8ReBHKMiui46f8jDIEjqOAwjGgMBRYx2wlTHnzYxRSOmBoK+sOWEizUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmzWqZBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AD606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmzWqZBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783DA1F000C4;
	Mon, 16 Nov 2026 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811946;
	bh=FPqqu9XU8w0LvYNwsknyQ+lUEZw9t875ZNSJjnFWcbY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OmzWqZBBI52tI69zE9ijihgqfpwVkPaPcObQEdnEDz130G+rbV+XhgUPo2gMKX1xz
	 Rx1so9YQeysVbOfPpA6SqJq2hKr4PNALb9x9tVDSrtunr+KxefJoG0KnvaQs00FeiS
	 2iwlxppx6HzVCpw8vcjcmPdlp96rDl8W2kxGdFGRJ5hWgxg1UCgOidvjB90G9Fl6JS
	 4uFdQMRrQYljoSKwDcBoZRGnYiEG5AoOvHt/H6GcSYOqk0HFB5Dq2UBy0fq/6l7WBt
	 +ASscLAsOtK4+0QiE04MuBF9NSNLkVjwXkr+VjC3JHKyfQSOckBTzmbsI9Vf4qRtR4
	 8yxs4vOnDfD8Q==
Content-Type: multipart/mixed; boundary="===============6720613513868525539=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a3a1ca28288ea76b09a3bb234a67d2093f25590310741d66c1f67b2fd6f498f4@mail.kernel.org>
In-Reply-To: <20261116055638.4171529-13-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 12/21] bpf: Relax jumps that patches push out of range
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 06:52:25 +0000 (UTC)

--===============6720613513868525539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Relax jumps that patches push out of range

TL;DR:
- Selftest "far jump over a far jump" likely doesn't exercise the cascading
  relaxation it claims; both offsets equal S16_MAX, and there is no __xlated
  check
- Nit: "last" variable and comments in patch_list_adj_aux() are stale

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -255,20 +262,24 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
>  			       const struct bpf_insn_aux_data *old,
>  			       struct bpf_insn_aux_data *slot)
>  {
> -	struct bpf_insn_aux_data *last = slot + p->len - 1;
> +	struct bpf_insn_aux_data *last = slot + p->self;
>  	struct bpf_insn *orig = &p->orig;
>  	u32 i;
>
> +	memset(slot, 0, sizeof(*slot) * p->len);
>  	*last = *old;
>  	/* Recompute zext_dst: the last insn of the patch need not be the patched one. */
> -	last->zext_dst = bpf_insn_def32(prog, &patch[p->len - 1]) >= 0;
> -	memset(slot, 0, sizeof(*slot) * (p->len - 1));
> +	last->zext_dst = bpf_insn_def32(prog, &patch[p->self]) >= 0;

this isn't a bug, but now that bpf_patch_list_append() exists, p->self is no
longer the last insn of the patch, so the variable name "last" and the
comment "the last insn of the patch need not be the patched one" read
oddly.

For example, bpf_insert_loop_guards() calls:

    bpf_patch_list_append(env, i - 1, leave, n)

which gives [last insn of the subprog, r0 = 0, (r2 = 0), exit] with self = 0,
so "last" here points at the first insn of the patch, not the last one.

The same applies to add_hidden_subprog(), which gives
[last insn, r0 = r1, exit] with self = 0.

The same wording remains in the comment further down in this function:

    The last insn could be a newly generated BPF_ST/BPF_LDX/BPF_STX, ...

Could "last" be renamed (for example to "self") and these comments reworded
to cover appended insns?

The comment "Expand the seen count of the patched insn to the patch" also
does not explain the new "?: i > p->self" case, where appended insns behind
a dead insn are marked seen.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
> --- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c

[ ... ]

> +/* The first jump is in range until the second one gets two more insns. */
> +SEC("tc")
> +__description("patch list: far jump over a far jump")
> +__success __retval(1)
> +__naked void patch_list_far_jump_over_far_jump(void)
>  {
> +	asm volatile (
> +	"r6 = *(u32 *)(r1 + %[mark]);"
> +	"r7 = 1;"
> +	"r0 = 1;"
> +	"if r6 == 0 goto 0f;"
> +	"if r6 == 1 goto 1f;"
> +	".rept 8191; r7 /= r6; .endr;"
> +	"r0 = 2;"
> +	"r0 = 2;"
> +"0:	exit;"
> +"1:	r0 = 3;"
> +	"exit;"

Does this test exercise the case its comment describes, where relaxing one
jump pushes a second jump out of range?

The jump "if r6 == 0 goto 0f" starts at old index 3 and the jump
"if r6 == 1 goto 1f" at index 4.  Each skips 8194 old insns, 8191 of which
are "r7 /= r6".  bpf_do_misc_fixups() replaces each division with a 4-insn
guard, which adds 3 insns, so both offsets come out the same:

    8194 + 3 * 8191 = 32767

Both equal S16_MAX, so in bpf_patch_list_build() this never becomes true:

    far |= is_short_jump(&src[n]) && rel != (s16)rel;

and patch_image_relax() is not called.  The second jump starts one insn
after the first and lands one insn after the first one's target, so the two
offsets are always equal and the second can never be far while the first is
in range.

On JITs that need zext, the zext after each "w7 ^= w7" raises both offsets
to 40958, so both are far on their own and the cascade is still not
exercised.

The only check is __retval(1), with no __xlated, so the test passes whether
or not the relaxation works.  As far as I can tell no other test in this
series builds a jump that becomes far only because a jump it skips was
relaxed.

Could one more reachable insn be placed between the two jump targets so that
the first offset is 32766 or 32767 and the second is at least 32768, and an
__xlated check added for the relaxed first jump?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43815411838
--===============6720613513868525539==--
