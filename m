Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6483D5236
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788600338; cv=none; b=f/JSx6FukAaMOcfQqGjbg47DrxIWa2BmJaBVY0Ojul6ZfEZFB8BiIb5cTkcAvJoSDrzloLM7lPnND9sDG5MHZOZruDZ+8e/T6aLthOCn5NwA3gn3BnyRJJo0oacWIx3OsuFJR1JbmmMu+whxgXjo1FyqnIBRH3N9iUjFd23IobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788600338; c=relaxed/simple;
	bh=mv0T3D2e0AvJn4DeHxREUAA0C6owrisDzLpK4biREe0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LA6riUkINalPlGwoF3uLQzzOZvaBRnjig/Dm8fsf20S4ne52/rWoHXUWZ0opP9DwKkNlGO57Tgzewlpp9i1XEmPClLoWQfJk7HZR6XpKImWOmP9XqoOl61z4A2lIfLAp2+jg4kQKkylDHpVrRMqb5pZBGKaPJE14tUiVX01drlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqkxsfb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqkxsfb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B141F00A3E;
	Sat,  5 Sep 2026 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788600337;
	bh=vQWi+ftIY6iiIzKcuQC3NO5bAyOJyK8IHyxjhAad2oY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Cqkxsfb/5dsC2/KdLEcHXxa2UEga48arllEK3FvBU+CcwNnXFYezVU4SSVRemYPLH
	 dq6H3c+3qV0cXO7MS84Q7H/7P2k7Xv06n9bu2QQWw8qcOgzBxn+mhVYcyL4eHrppUA
	 VNXPbq3porJkluF4HEg7unPD1eavuu9O8BqoZ17mSUgxFHpApBQaooTPPZHUWgzf3n
	 NSinhCeR2syakK7w1MlGXbIZPCrO+ylVrdNJfkd6ozWE0jO0ZPMTBO2aZjk4a561ko
	 YPLTFMK+BcaI/SaE7FCh/ghVauQ2XsJO2swCUpYg17nUOLF+n4xDU+TUImsDJb1NO3
	 bQvM3NxMfzfpw==
Content-Type: multipart/mixed; boundary="===============7474914815246753722=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8c7bd485131b9093ab2c09d929574955b299c52f23a351991ed4519b64b4872@mail.kernel.org>
In-Reply-To: <20260905083418.3723623-3-memxor@gmail.com>
References: <20260905083418.3723623-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Preserve packet pointer class displacement in regsafe()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 09:25:36 +0000 (UTC)

--===============7474914815246753722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d..5cf92ce18520 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -854,6 +854,8 @@ struct backtrack_state {
>  struct bpf_id_pair {
>  	u32 old;
>  	u32 cur;
> +	s32 pkt_ptr_delta;
> +	bool pkt_ptr_delta_set;
>  };

Adding both s32 pkt_ptr_delta and bool pkt_ptr_delta_set doubles
sizeof(struct bpf_id_pair) from 8 to 16 bytes (4 + 4 + 4 + 1 = 13,
rounded up to 16 by alignment). With BPF_ID_MAP_SIZE = 1312, this grows
idmap_scratch from ~10 KiB to ~21 KiB on every bpf_verifier_env.

Could a sentinel value (e.g., S32_MIN) encode the 'unset' state without
needing the separate flag? The code already bounds useful deltas to
(-2^30, 2^30) via BPF_MAX_VAR_OFF and check_reg_sane_offset_ptr(), and
rejects anything outside [S32_MIN, S32_MAX]. This would keep the struct
at 12 bytes and save approximately 5 KiB per verifier environment.

As a design note: struct bpf_id_pair is the generic old->cur id map
shared by scalar linking, reference/lock/irq ids, dynptrs and iterators
(check_ids() is called from check_scalar_ids(), regs_exact(), refsafe(),
stacksafe() and regsafe()). Carrying packet-pointer-specific state in it
means every one of those users pays the memory cost.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a7..2f8f3fe164b0 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -339,6 +339,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>  	if (idmap->cnt < BPF_ID_MAP_SIZE) {
>  		map[idmap->cnt].old = old_id;
>  		map[idmap->cnt].cur = cur_id;
> +		map[idmap->cnt].pkt_ptr_delta_set = false;
>  		idmap->cnt++;
>  		return true;
>  	}
> @@ -352,6 +353,43 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>  	return false;
>  }
>
> +static bool check_pkt_ptr_ids(const struct bpf_reg_state *old,
> +			      const struct bpf_reg_state *cur,
> +			      struct bpf_idmap *idmap)
> +{
> +	struct bpf_id_pair *map = idmap->map;
> +	s64 delta;
> +	unsigned int i;
> +
> +	if (!check_ids(old->id, cur->id, idmap))
> +		return false;
> +	if (!old->id)
> +		return true;
> +
> +	/*
> +	 * Packet range is shared by all pointers with the same ID. Preserve
> +	 * their relative displacement, while allowing the whole class to move.
> +	 * Packet pointer offsets are bounded by BPF_MAX_VAR_OFF, so the delta
> +	 * between two valid offsets fits in s32.
> +	 */
> +	delta = (s64)(cur->r64.base - old->r64.base);
> +	if (delta < S32_MIN || delta > S32_MAX)
> +		return false;
> +
> +	for (i = 0; i < idmap->cnt; i++) {
> +		if (map[i].old != old->id)
> +			continue;
> +		if (!map[i].pkt_ptr_delta_set) {
> +			map[i].pkt_ptr_delta = delta;
> +			map[i].pkt_ptr_delta_set = true;
> +			return true;
> +		}
> +		return map[i].pkt_ptr_delta == delta;
> +	}
> +
> +	return false;
> +}

Is the trailing return false reachable? check_pkt_ptr_ids() only reaches
the loop after check_ids(old->id, cur->id, idmap) returned true AND
old->id != 0. Looking at check_ids() in states.c, it has exactly two
true-returning paths for a non-zero old_id:

  for (i = 0; i < idmap->cnt; i++) {
          if (map[i].old == old_id)
                  return map[i].cur == cur_id;
          if (map[i].cur == cur_id)
                  return false;
  }
  if (idmap->cnt < BPF_ID_MAP_SIZE) {
          map[idmap->cnt].old = old_id;
          ...
          return true;
  }
  return false;

So on every path that reaches check_pkt_ptr_ids()'s loop there is
guaranteed to be an i < idmap->cnt with map[i].old == old->id, and
check_ids() never creates two entries with the same .old (it only
appends after failing to find a match).

The loop therefore always returns from inside its body and control never
falls through to the trailing return false. This is cosmetic (the
fallback returns the safe/conservative value), but it is unreachable
code in a new function.

The BPF verifier convention for a provably impossible state is
verifier_bug()/WARN_ONCE() rather than a silent return, so either
dropping the statement or making it a verifier_bug() would document the
invariant instead of hiding it. As written, a future change that lets
duplicate or foreign entries into idmap->map would silently degrade to
'never prune' with no diagnostic.

> @@ -632,8 +670,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		} else if (rold->range > rcur->range) {
>  			return false;
>  		}
> -		/* id relations must be preserved */
> -		if (!check_ids(rold->id, rcur->id, idmap))
> +		/* id relations and intra-class displacement must be preserved */
> +		if (!check_pkt_ptr_ids(rold, rcur, idmap))
>  			return false;
>  		/* new val must satisfy old val knowledge */
>  		return range_within(rold, rcur) &&


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33955969043
--===============7474914815246753722==--
