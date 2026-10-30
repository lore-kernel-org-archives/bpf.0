Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364299;
	b=QtPfFTlzjJdU5tHFsQkRu+UpLAuYuvGuypyUxCzouVjkmMa3B8YMkpbeQ9OKBhMlJDXX
	 MAmUoi0cTJw5IT26cbPFcc+6dJqMjJSvX2WJfk0A8UOr0/1OAPZ1Hs3CIxGsBX5Bm3g7J
	 O0msWHsTm8zizGV+hBAO5kFppoYW2S6fYvMumX24bbTYM9b9GEQ9TqoXDkKKqMFFDt3n6
	 R5H5fBGw8VpTVnLTXDKc+jwaWH1oN0v/VM+eXDQDVxJEZst4EmPn+TbGIBaF99n3AR/fT
	 Iqc2lDlEqmDPjW+3KRzewP8QxPCtnWajjVcp436TIYzJwjkopLrCpqkAD5cp0iCkx8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364299;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=BUhfoOFmriVfIxcOgWDjI5rW2ot5WJ51LVERBP74L2w=;
	b=VkS6FsNrTmKy6GAVXl8qfwd9NPkEgHo3rG7HqS55kkd5eLgM4JGC+U0jnnyjayRZwKCy
	 G9YOkOIOtrKN0i4/fyRSB794GKSucJATArOcF8dk7suiOR2XAnUB5KwN443lZILKnatCI
	 Qnwwols1IT8keo4TjmIN1BUDkvPIBlEXRQ4PFw2l7c9llPJv9ThfH21zldj9u/h9ckEAq
	 X9v0IuLEsLHuyUFkpweMNeJCOHqwlVldOCNT1pYJId6hUKSU7QHdO0g++S5INk0QPVOMu
	 SSIJXHGzG8DeOKru6iN8np1LPgIL9tDLmQanAAYouUsew+tsKmvp+IDNG3n3BpM3q9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z58Ay7fr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA36606A324;
	Fri, 30 Oct 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z58Ay7fr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81DE1F000C1;
	Fri, 30 Oct 2026 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364298;
	bh=BUhfoOFmriVfIxcOgWDjI5rW2ot5WJ51LVERBP74L2w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z58Ay7fr7oX9V/YIVbrJnSDL9OtRg6wL8D7V7MT8ISJuaG9AvCHpC9Kl8Xnv92WZL
	 m7kf2mAW6LkkY1PAiEdN9nMsxymwFopYuMoEAv6YWuaowzyC7yN2BtwB/Ak/R+FSgR
	 iVnGFbyrbqDbNCEGNrT+ZFu3Pttkc0Whgi07legNEP5EfJEPSU1ThsnVXu50KA3sUU
	 d2Ko6d+mwAQjZDh965QaC1Z1GRC6eLZQiQbf+4gYNuJX99WRaN8pnSsg+YNfGsRunl
	 w40brEHIlnUiQE+HslUQbbeqOhSY4zajAvTDEBF8uH2YvejMGLVVOFYmMvt/BM+pt5
	 wHOYB6Cc9snEA==
Content-Type: multipart/mixed; boundary="===============3236567005608012151=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <069cbe00bc6babf6b2e1585b0b945d21b001ebfe35a6367d53603d5ad8ddc981@mail.kernel.org>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-2-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-2-55cd43439f7c@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/22] bpf: Remap the verifier state through the patch list
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 12:44:57 +0000 (UTC)

--===============3236567005608012151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remap the verifier state through the patch list

TL;DR: patch_list_adj_aux() may clear indirect_target for single-instruction
patches, so a gotox target could lose its ENDBR/BTI landing pad on IBT/BTI
kernels. Latent for now, as there are no callers yet; the comment and
changelog are also inaccurate.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f062ef7dd943..0697f66b1ffc 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -380,6 +380,157 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,

[ ... ]

> +/*
> + * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
> + * of the insn they replace, the same way as adjust_insn_aux_data() does.
> + */
> +static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
> +			       struct bpf_insn *patch,
> +			       const struct bpf_insn_aux_data *old,
> +			       struct bpf_insn_aux_data *slot)
> +{
> +	struct bpf_insn_aux_data *last = slot + p->len - 1;
> +	struct bpf_insn *orig = &p->orig;
> +	u32 i;
> +
> +	*last = *old;

[ ... ]

> +	/* indirect jumps to the replaced insn land on the first new one */
> +	if (last->indirect_target) {
> +		slot[0].indirect_target = 1;
> +		last->indirect_target = 0;
> +	}
> +}

For a single-instruction patch (p->len == 1), 'last' is 'slot + p->len - 1',
which is 'slot'.  Can this block clear the flag it just set?

    slot[0].indirect_target = 1;
    last->indirect_target = 0;     /* last == &slot[0] */

bpf_patch_list_add() only rejects !len, so len == 1 patches are accepted.
An instruction that is the target of an indirect jump (gotox) would lose
its indirect_target flag when it is replaced one-for-one.

adjust_insn_aux_data() does not behave this way.  For cnt == 1 it takes the
early return and leaves indirect_target alone.

bpf_insn_is_indirect_target() hands this flag to the JITs, and x86 do_jit()
emits ENDBR and arm64 build_insn() emits 'BTI J' only for flagged
instructions.  An indirect jump to an unflagged instruction would then hit
a missing landing pad on IBT/BTI-enabled kernels.

The len == 1 path also treats non_stack_access differently.  It keeps the
old marking, while adjust_insn_aux_data() recomputes it with
bpf_is_mem_insn(insn + off).

So the comment above patch_list_adj_aux() ("the same way as
adjust_insn_aux_data() does") and the commit message line "filling in the
aux data of patched instructions the way adjust_insn_aux_data() does" do
not hold for single-instruction patches.

This looks latent in this commit.  bpf_patch_list_add() and
bpf_patch_list_commit() have no callers here, and in the series the next
commit a3a12f55a1ad ("bpf: Apply single-instruction patches of the verifier
in place") applies len == 1 patches in place before any caller exists.  The
first callers arrive in a9b03b9b8596 ("bpf: Queue the rewrites of
bpf_do_misc_fixups()"), and 3c859182c47c ("bpf: Teach the patch list to
insert in front of an instruction") later adds a 'p->target != p->len - 1'
guard to this block.

Would it make sense to fold a3a12f55a1ad into this commit, so the helper is
correct on its own and its comment and the changelog are accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41053659762
--===============3236567005608012151==--
