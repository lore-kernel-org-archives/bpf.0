Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CD4963BA
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547660; cv=none; b=EPm9RdGDTEofmFs7J7MX2UM6yqfENBePJlCVy4KyAOnjZyvV2DBqZo2cX1si2azKDfRU3UAM5XdIcwlQ5284VL0+KSgoYN8A06h/0vwjrpNqP1wTC80DEhp9FLvYY/el4RFAsRfpfnBGicgrPKkYNKpbw5/NIwDD+Uxr6quAlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547660; c=relaxed/simple;
	bh=Ija+x2+9/04ij24lxWWPCVY0WG29/ZBlXmEa7EE5VSo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cDOMi8ZUvKAbvQt5jNOo34kwI3Ow16OYOjhIugqXfFEwjk4IJj7yqtaM/LIPLMVlc64/vGALkZ2ZXtNWq4hQa66jidq2FBNANCNuJ5fpQdnnV+fuo+AbD60i4Hgl6OFCVBw+ktG3gOiEtPacCxJEJ5DNk8kAsBvEkL6In+lIB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBcajnPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBcajnPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2320D1F00898;
	Fri,  9 Oct 2026 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547655;
	bh=KzecLxjIsif+1Ju/I2n4EkSW/UlaJFQFmRUHOlw7od4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oBcajnPxc1ZRzsS09/CATnk1EY1aQbQ0HHqFjHG6UzWSTRzPtXNzHulwIL+UwtbR2
	 E70No+N6odaSNL5RKRnsls7b0WaDMKcvaWwZkhjTVOymd+yzKkNvWYTTWuls/J7zGT
	 Wf4d0TcWN8UpcSjhlY0oVHI/foTRi2axEdHKWZQ3zijNFeHJ8rMtYBR4GTZgeQ1qaJ
	 hrv3I/9WWOtCrfSaX+g1OxR3rmWmdZmY+qqhSnjeRxWaxA6MWH6G/qvTD7xiBZ58aj
	 KB4eTRF93/r5X4jNjSzwPLLSsya0R9+KfX31Mcru9gzDm3JysFpLL2LHzz7u7t+TvF
	 9461jfNXBeCSw==
Content-Type: multipart/mixed; boundary="===============5968056736597149628=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f50c90c981387ec8a1dc3e39ed271189360de0f156d6b61962c015eb97ef591@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-36-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-36-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 36/51] bpf: bpf_func_state size optimization
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:34 +0000 (UTC)

--===============5968056736597149628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: bpf_func_state size optimization

TL;DR: The narrower memcmp prefix in states_maybe_looping() may stop comparing
id, parent_id and map_uid, so a terminating program accepted before could be
wrongly rejected as an "infinite loop"; the commit message doesn't mention it.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index c62ea992967b..953700822fa7 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -1171,7 +1171,7 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
>  	fcur = cur->frame[fr];
>  	for (i = 0; i < MAX_BPF_REG; i++)
>  		if (memcmp(&fold->regs[i], &fcur->regs[i],
> -			   offsetof(struct bpf_reg_state, precise)))
> +			   offsetofend(struct bpf_reg_state, step)))
>  			return false;
>  	return true;
>  }

Does this narrower prefix drop id, parent_id and map_uid from the
comparison?

The old length, offsetof(struct bpf_reg_state, precise), was 80 bytes and
covered the raw id, parent_id and map_uid.  The new
offsetofend(struct bpf_reg_state, step) is 68 bytes, and id, parent_id and
map_uid are all declared after step in the struct, so none of them are
compared any more.  offsetof() cannot name the precise bitfield, but
offsetofend(struct bpf_reg_state, parent_id) would have kept id and
parent_id in the comparison.

Commit 8901cee9316d said this prefix comparison "continues to cover the
complete value state", and this commit message does not mention that the
comparison is being narrowed.

Before this change, the current frame's registers had to carry identical
raw ids before infinite-loop detection could fire.  Now the decision rests
on states_equal(env, &sl->state, cur, EXACT).  In EXACT mode regs_exact()
compares ids only with plain check_ids():

    return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
           check_ids(rold->id, rcur->id, idmap) && ...

That skips the extra checks that regsafe()/check_scalar_ids() do for
scalars: the ADD_CONST flags must match, and the base id (with the flag
stripped) must map consistently.  The comment above check_scalar_ids()
describes this exact gap: "Without the base check, idmap gets two
independent entries A->B and A|flag->C|flag, missing that A->C conflicts
with A->B."

Can a program that terminates, and was accepted before, now be rejected
with "infinite loop detected"?  For example (privileged, so ADD_CONST
linking is active):

  r6 = rand&7; r7 = r6          (r6,r7 id A)
  r8 = rand&7; r9 = r8; r9 += 1 (r8 id C, r9 id C|ADD64, delta 1)
 L: if r6 > 3 goto out
    if r9 <= 4 goto out          (on entry r9 is tied to r8, so both
                                  branches are possible)
    r6 = rand&7; r7 = r6; r9 = r6; r9 += 1
                                 (r9 is now tied to r6: id B|ADD64)
    r8 = rand&7                  (id D)
    goto L
 out: use r6..r9; exit

On the second visit to L the register values match the checkpoint exactly,
and only the ids differ (A->B, C|ADD->B|ADD, C->D).  check_ids() accepts
this mapping even though r9 now depends on r6 instead of r8.

The old raw-id prefilter rejected the match (r6 id A != B), so exploration
went on: r6 <= 3 forces r9 <= 4 through sync_linked_regs(), every path from
the second visit reaches exit, and the program was accepted.

With this patch, states_maybe_looping() returns true, states_equal(EXACT)
succeeds, and bpf_is_state_visited() returns -EINVAL.

The same weakness could already be reached before this patch through ids
in stack spills or caller frames, which the prefilter never covered.  This
patch extends it to registers in the current frame.

Should this compare up to offsetofend(struct bpf_reg_state, parent_id) and
compare map_uid separately?  Alternatively, if dropping the ids is
intended, could the commit message say so, and could regs_exact() check
ids the way check_scalar_ids() does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============5968056736597149628==--
