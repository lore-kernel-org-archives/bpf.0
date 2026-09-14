Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A436D4F1
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396235; cv=none; b=LFMY8i6QRuKCd3TQ06hR9ySsbXg1S4cGlkzLxrzEIWBcg6YsPK3/4X+jgK7WgDb2LHVuZ8D58U//ewtmbxgNQ6ELrdsObDXI89JyE+yDJioYx8XpTQdEoEWVCV5lDMa11Re1uZ7ixeCv735hCjrJczFOm4V4fLiAH/WQu2JSG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396235; c=relaxed/simple;
	bh=XmB0qYEggkUprkGz9+MdwbvYa5JbZAKDKxaKPYjl+hI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DOIOOzcSwA2opuH3ezqRu6ABFf/pmiSCGyHzwHa6Yr1wgJZedQp28Vqvd8T7vUZ9qADwXYlgij2pAIR/+2nXwwRN2E7jU3DOBbgqnqDXZAclDUk/KGf0Y/LKmVFRiKcG/XBu8skGKZA8Fwrvs21zzrvf0ufEUyxmP0NpD+Obut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfhqPiBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfhqPiBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2B91F000FF;
	Mon, 14 Sep 2026 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396234;
	bh=Rkhm+DEZcToILiNsXmSAMpRuU4hjEFIuDsucTiLIAOQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PfhqPiBiH57JZuzs7W4iPTF0oUiejciO+T0+xG4R9zLH7x8/O5G9tFZj/4SUKUSTP
	 LiyoE6OsSdQ0Wt5/sbdRS0Fz1phKT7UVTdgKnkPZLUVTg32JwKWnGpxhs8EA3p0wrX
	 Elf2JQStfscJyKCxw8uAAuX6VZfaczJwLcNXqgxqudMAcS69rpnH1Ibcvw393Zs46h
	 XoIc78N0zmiD/T0vaYU4MmsKCu7mA9snfygt7D+1k/5PSN8tjAC1ffiyLP24r78fvv
	 jmofLolG/ho0xEYLgvLJ9dTd9IOKeV0e1waMrKldSHMhLSRddZ2v9Ne8rxANeM/Q+p
	 D89PnjyFxfsbg==
Content-Type: multipart/mixed; boundary="===============4675015103150100593=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4399ec45f23a77745735774abe833c28163b74c8605980f82ea142aa545bec02@mail.kernel.org>
In-Reply-To: <20260914131701.2529725-3-memxor@gmail.com>
References: <20260914131701.2529725-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 2/7] bpf: Preserve packet pointer class displacement in regsafe()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:30:33 +0000 (UTC)

--===============4675015103150100593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a76..6c88ad95b63b7 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -635,6 +635,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		/* id relations must be preserved */
>  		if (!check_ids(rold->id, rcur->id, idmap))
>  			return false;
> +		/* Preserve displacements between pointers sharing an ID. */
> +		if (rold->id && rold->r64.base != rcur->r64.base)
> +			return false;
>  		/* new val must satisfy old val knowledge */
>  		return range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off);

Is this check stricter than what 022ac0750883 removed?  That commit
removed the .off equality check from regsafe() to make pointer
widening and loop convergence easier. The new rold->r64.base !=
rcur->r64.base comparison preserves displacement, which is what
safety requires, but it also pins the absolute base of the variable
part. Consider:

  explored:  r2 = {base 0,  size 15}, r3 = {base 8,  size 15}
  current:   r2 = {base 4,  size 3},  r3 = {base 12, size 3}

The displacement is 8 in both states, and range_within()/tnum_in()
pass for both registers, so pruning is sound. But rold->r64.base !=
rcur->r64.base (0 != 4 for r2, 8 != 12 for r3) rejects it.

Before 022ac0750883 this pair pruned because the removed check
compared only the constant part (rold->off vs rcur->off). Any path
that narrows a packet pointer's variable offset from below now fails
to prune, so those states are re-explored. For programs already near
the state limit this can turn a previously accepted program into a
load failure.

The minimal condition would compare the base difference within a class
rather than the absolute base, which the commit message rules out
("without adding per-ID state"). But it doesn't mention that the
resulting check is stronger than the removed .off check, or that
pruning of packet pointers with variable offsets is affected. Would it
be worth either relaxing the check (per-ID base delta) or documenting
the pruning impact in the changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34849913056
--===============4675015103150100593==--
