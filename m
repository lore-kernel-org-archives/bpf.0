Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D4569F0D;
	Thu, 10 Sep 2026 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062752; cv=none; b=MY4HtrVgRiCz/mELqAPQG67npbSpXF9lKskyxIBUjMsXUyFUthVYKeNPZmVWD5enwIzyJTaYdsmZIqYidbcEYkSTYdhF6Cn2kXDvBOOTDLCAmb9JQQzfgpezCRmg6/lLpolnVEn7LmxyUTSTwx0Pc6VDZ175USHwBrNXHSFFkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062752; c=relaxed/simple;
	bh=MOPbC9/TM0L/il6+yN2NgUWeu2QozNMvz/+pQ8olNtQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QVl9lpPaPwZIHQzztZPW5/yWSq0kAtNsgdg6e4NKnJjQF9j3AkaEXmBWYvaRHTcCesyw210RnDwIokQnifXSsobYKUbCSsAJV8ZFRN/rPrhR5br/frsvI4cdh0epjpkD2y5YP4NMnSCYZlJ5986fcnnANmu/GwDKAZt3ziif/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obvxioOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obvxioOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8011F00899;
	Thu, 10 Sep 2026 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062737;
	bh=4V4iQfn8TzPY39W/R2NquBCS3jTB0DVC42D0ENZGGa8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=obvxioOZNFpe0cro9pq+88nmU217cj2OhHxVMwFWWk0jU2jcgKa6x1k8eh4BgJIQx
	 P2KoqcMw5vStGWp11lax13tU5MCqC/VEXkkCY+0cguf72WFSmkUo+PII7UPnS95u7y
	 1IxVWxlKyKLSkxoVr+fnnzmFT7NGNBmtuZyAidB4C2qekJG4/QxpnM2ZP4TxWOJLua
	 FjBr8YpCcrBkl7aLwJtPRaBXjxKB75f8zBDLgRjJ9S6dgkBVY9iegSvvTBYBPLfZMD
	 uzWuopNVbu3QFZMPRVjLE9yAJxd9ViHYlBZA5UJZtetxacyswl29TgxAQUjfuNs8Ee
	 HnTkmW4zJdq0w==
Content-Type: multipart/mixed; boundary="===============5691876850880909347=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad011852b5532901853fbc1c16d5a27d50231065dad9b1e4bbfee1c02b4735e5@mail.kernel.org>
In-Reply-To: <20260910164635.459558-4-vineet.gupta@linux.dev>
References: <20260910164635.459558-4-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality across zero-extending movs
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 17:52:16 +0000 (UTC)

--===============5691876850880909347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index afb1e5628698..f1b01059c5da 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0ca229f6e7ac..58e788f53ae5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17115,6 +17126,23 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
>  	}
>  }
>
> +/*
> + * Set @reg to the zero-extension of @known_reg's low 32 bits: it shares those
> + * bits and its high half is zero. Copy the base to keep its precise low-32
> + * tnum, then re-apply the zext_32_to_64() the 32-bit mov itself used.
> + * @reg->id and ->delta already equal @known_reg's; only ->subreg is its own.
> + */
> +static void reconstruct_zext32(struct bpf_reg_state *reg,
> +			       struct bpf_reg_state *known_reg)
> +{
> +	enum bpf_subreg subreg = reg->subreg;
> +
> +	*reg = *known_reg;
> +	reg->subreg = subreg;
> +	zext_32_to_64(reg);
> +	reg_bounds_sync(reg);
> +}
> +
>  /* For all R in linked_regs, copy known_reg range into R
>   * if R->id == known_reg->id.
>   */
> @@ -17134,6 +17162,27 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>  			continue;
>  		if (reg->id != known_reg->id)
>  			continue;
> +		/*
> +		 * A ->subreg register shares only the base's low 32 bits, so it
> +		 * is rebuilt rather than copied. Not modelled together with a
> +		 * delta, so skip if either side has one (sound, less precise).
> +		 */
> +		if (reg->subreg) {
> +			if (reg->add_const || known_reg->add_const)
> +				continue;
> +			reconstruct_zext32(reg, known_reg);
> +			if (e->is_reg)
> +				mark_reg_scratched(env, e->regno);
> +			else
> +				mark_stack_slot_scratched(env, e->spi);
> +			continue;
> +		}
> +		/*
> +		 * The reverse: known_reg knows only its low 32 bits, which say
> +		 * nothing about reg's high half.
> +		 */
> +		if (known_reg->subreg)
> +			continue;
>  		/*
>  		 * Skip mixed 32/64-bit links: the delta relationship doesn't
>  		 * hold across different ALU widths.

Can reconstruct_zext32() lose bounds that reg already learned on its own?

Looking at the code, reconstruct_zext32() does:

    *reg = *known_reg;
    reg->subreg = subreg;
    zext_32_to_64(reg);

This overwrites reg's state wholesale without intersecting it with what reg
already knew.

For pre-existing full-64-bit links, sync_linked_regs() propagates changes
in both directions, so the base is always at least as narrow as every
member and the overwrite can only narrow. But the new low-32 link skips
the member->base direction:

    if (known_reg->subreg)
        continue;

so the base can end up strictly wider than the ->subreg member.

Consider this sequence:

  call bpf_get_prandom_u32;    /* r0 -> 64-bit unknown */
  r6 = r0;                     /* r6 is 64-bit unknown */
  w7 = w6;                     /* r7->id = r6->id, r7->subreg = SUBREG_ZEXT */
  if w7 > 7 goto out;          /* fall-through: r7 u32 range [0,7]
                                * sync_linked_regs(known_reg=r7) skips r6 due
                                * to `if (known_reg->subreg) continue;`
                                * so r6 stays fully unknown */
  if r6 > 100 goto out;        /* fall-through: r6 narrows to [0,100]
                                * sync_linked_regs(known_reg=r6) reaches r7
                                * via reconstruct_zext32(r7, r6) which does
                                * *r7 = *r6 then zext_32_to_64() */

After the second jump, does r7 become [0,100] instead of staying [0,7]?

If so, a jump on an unrelated wide register would widen the bounds of a
narrow copy that the verifier had already proved tighter, on a
straight-line path. That would reject programs that narrowed the 32-bit
copy first and the wide original second, then relied on the copy's
narrower bound for a memory access or helper argument.

The changelog acknowledges the other precision loss this patch introduces
("forming one costs the source its delta ... That loses tracking a wide
source used to keep") and the follow-up selftest commit 36b84852a200 pins
it down with zext_mov_breaks_add_const_src. But neither the changelog nor
reconstruct_zext32()'s comment ("Copy the base to keep its precise low-32
tnum"), nor any of the 10 new tests in 36b84852a200, mentions or covers
this path. The only test that checks the member's fate is
zext_narrow_dst_keeps_base, which verifies the base is not narrowed but
does not check what happens to the member afterwards.

Would intersecting the rebuilt state with the member's existing one, or
narrowing the base's low half on the member->base direction instead of
skipping it, prevent the member from ever being wider than what it already
proved?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282
--===============5691876850880909347==--
