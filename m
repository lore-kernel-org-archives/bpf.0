Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A5371D06
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786416; cv=none; b=T+2Y3Nxz/9Wn9wRgJYpELlC20tN45RwJhfXO6DKuUw6p2Bl2Z8YqrKqt1YN32FCMAbwSMJEYp1JMPNe/v1GJClvXDkdr78K86tdqVFoznypURU27v2ittm4My6Yv/rNqhhGqlD5SXRNfAnKLe/kyQt0cEFcpRbsfS+P59Coyp24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786416; c=relaxed/simple;
	bh=/p/8S7gY1VQhpIjTTMzWy5SuYGttx5AJ+PdKaznU648=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PJPuc+z59J04tKZF3uecuDsx420wdSJlqY1aW3ViJV7SJ4NeYa/i4qBVcfm5il2yWoHfmYhXbIkdui8VP8PDbE3T2m5sFWczUp7H2AcAkN72YgLSsi74gBRCnzZf34KauB1QEmozEbSe38hhkjRjFhrdbhVJovn5T8uM2xEooR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSOSmb9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSOSmb9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A5C4CEF7;
	Tue, 17 Mar 2026 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773786416;
	bh=/p/8S7gY1VQhpIjTTMzWy5SuYGttx5AJ+PdKaznU648=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SSOSmb9kKJFCuvtqV7PnKw0uAVdFTVBZND/CmxeAZ+RcVWKs470lfk85b8rkdBm7T
	 IWwJY7xEcCY9WJR4kQJgiLmV8IFXhWIDYAVXlRIllR3g/r+yo+SvmQXG7/hl+bDoN4
	 C7XXcG6ShWL6DBPxseS4xN8MMQNJu5XKbI00Vqs/Lus1pGsNADd8JmbaTcsYEsx+C7
	 7mnyaqrss9CqSeKxkIaPzgEPZNlXqEoHCSAFmFxxDYkQ6NO+4yJQkk5OUZvU/lsDs3
	 C2ghoUrGrEfxM/LdrilE5sOnx5kequvPzeK6G4eb9j3CpCCFgM6p0SXeBy8JvMN6u7
	 yBeSGS7JHPd4Q==
Content-Type: multipart/mixed; boundary="===============1452827063329279768=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4d7dce5ba4106773e4c7bb165eab3ba668e13e618e7ed3b42e2c7181fd15bd6@mail.kernel.org>
In-Reply-To: <20260317214342.1729449-1-ZeroXJacks@gmail.com>
References: <20260317214342.1729449-1-ZeroXJacks@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
From: bot+bpf-ci@kernel.org
To: zeroxjacks@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,gregkh@linuxfoundation.org,ZeroXJacks@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Mar 2026 22:26:56 +0000 (UTC)

--===============1452827063329279768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..2f18cc3e1a78 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17055,22 +17055,30 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>  			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
>  			 * below.
>  			 */
> -			if (reg1->u32_min_value == (u32)val)
> +			if (reg1->u32_min_value == (u32)val &&
> +			    reg1->u32_min_value != U32_MAX)
>  				reg1->u32_min_value++;

The comment above this code (not shown in the diff hunk) says:

  /* u32_min_value is not equal to 0xffffffff at this point,
   * because otherwise u32_max_value is 0xffffffff as well,
   * in such a case both reg1 and reg2 would be constants,
   * jump would be predicted and reg_set_min_max() won't
   * be called.

This reasoning assumes that umin == umax implies the register
is constant, but is_reg_const() checks tnum_is_const() which
requires mask == 0. As the commit message itself demonstrates,
tnum can disagree with bounds (tnum non-const while
umin == umax == U64_MAX), so the comment's claim is incorrect.

Should this comment be updated or removed? As written, it says
the boundary condition handled by the new guards is impossible,
which directly contradicts the guards and could mislead a future
reader into removing them.

[ ... ]

This commit appears to fix a verifier bounds tracking bug that
could allow BPF programs to bypass safety checks. Should it
carry a Fixes: tag? The wrap-around issue was introduced in:

Fixes: d028f87517d6 ("bpf: make the verifier tracks the "not equal" for regs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23218241458
--===============1452827063329279768==--
