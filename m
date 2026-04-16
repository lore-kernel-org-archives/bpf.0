Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBD33CEBB
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364797; cv=none; b=idazV+dGhlwOLhKx0KlkKqRxObvXMZ227SlXDkW6LqS6tFwEBVhEB/l5rowPrkcCSxWV0o+maOPtEiMIkPuvoqROnVaIpAcDeCjyi8oeWUOqyLwwTQpAvDuKDqC9rnoyCVAGXpTJv2bkaVGQqkGsCEAzYaT1N37a0MztOlECVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364797; c=relaxed/simple;
	bh=9a7cxZJecZKONkuJBzE/YZF372Udpp5zC9cnCGonXXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XC2qOCvZhvQ+daE6ji8QzRGO1TxTpHbN6Ps24S8riL9gLLrn+Vm64v1Ws10CEcgzXrYXxl7xEPAmqcnJiWdd3JlgiWqR6uxtzHjZM/SvwRxAlymjUpA2gHpYK/jVpcCxs1IU6WByHvrigPC/DSZTl9/Du6bzjiv1HDhmUZwiMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHC0otFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHC0otFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DEBC2BCAF;
	Thu, 16 Apr 2026 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364797;
	bh=9a7cxZJecZKONkuJBzE/YZF372Udpp5zC9cnCGonXXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PHC0otFreb/mf5k0pWDXIaZyTOsr+8qGp0NFQmE2H5SSqimSnT4GusBMF8tdWt6CB
	 8C1yxKq0wR8nDYoVfoFtk+gywNgfbjxGAw7Y+1nxYaIGJ1CJz1vJ7G6rg8bUu3x2TU
	 69EpOOKwEBkZo05kS6KZe1oCxcwtbtdJ4WHErFbJRRoLQ7lQeqXDcmGTcqzMBJAoyV
	 HXsRjgkg7EPWrZnF7kvOXr0h56vkXH++qw7fYu0DCzc67cpzDTU9f8GFLAzSCppu9K
	 sshmcVv03CNaGE7CdHyRm2HpO9M6pbWRirTufPbZUspOVOwQ0sTdmvd2gSW4+3tbuD
	 rftxAMKWUJVbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/7] bpf/verifier: Use intersection checks
 when simulating to detect dead branches
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <681fc6e748330e6a765a89f7193c17b33d4ea26f.1776344897.git.paul.chaignon@gmail.com>
References: <681fc6e748330e6a765a89f7193c17b33d4ea26f.1776344897.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:39:56 +0000
Message-Id: <20260416183957.24DEBC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Returning early from `reg_bounds_sync` on `!reg_bounds_interse=
ct(reg)` masks verifier soundness bugs and turns them into exploitable bran=
ch-pruning vulnerabilities.
--

commit 6f55ebe5b292297be4b3fa774e1c6b87de6d0862
Author: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

bpf/verifier: Use intersection checks when simulating to detect dead branch=
es

This commit introduces a new check to detect if register bounds across
domains (u64, s64, u32, s32, tnum) have an intersection. It uses this new
check to prune dead branches and to exit early during register bounds
synchronization.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e4980128151b..1d5d2b7e5140b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2345,12 +2345,15 @@ static void __reg_bound_offset(struct bpf_reg_sta=
te *reg)
>  static void reg_bounds_sync(struct bpf_reg_state *reg)
>  {
> -	/* If the input reg_state is invalid, we can exit early */
> -	if (range_bounds_violation(reg))
> +	/* If the input reg_state has no intersection between abstract values, =
it is
> +	 * invalid. We can exit early, ensuring that subsequent operations don't
> +	 * inadvertently fix the reg_state.
> +	 */
> +	if (!reg_bounds_intersect(reg))
>  		return;

Does returning early from reg_bounds_sync() here mask verifier soundness
bugs and potentially turn them into exploitable branch-pruning regressions?

If a buggy arithmetic operation produces a register state with disjoint
domains (e.g., conflicting u32 and u64 bounds) but does not immediately
have a min > max within a single domain, reg_bounds_intersect() will
return false.

This causes reg_bounds_sync() to exit early, explicitly skipping
__update_reg_bounds() and __reg_deduce_bounds().

Before this patch, running those deduction functions on disjoint domains
would cross-constrain the bounds and naturally produce a state with
min > max (range_bounds_violation). This explicit violation would
subsequently trigger a verifier panic in reg_bounds_sanity_check(),
safely rejecting the broken program.

By skipping the deduction, the state retains its logically impossible
disjoint domains but avoids generating a range_bounds_violation. Because
reg_bounds_sanity_check() was not updated to also fail when
!reg_bounds_intersect() is true, the broken state silently passes all
verifier sanity checks.

When this disjoint register is later evaluated at a conditional jump,
simulate_both_branches_taken() will see !reg_bounds_intersect() and
conclude that the branches are dead, pruning them from verification.
This could allow out-of-bounds memory accesses in the unverified branches,
which the verifier assumes are dead but the kernel will still execute at
runtime.

Should reg_bounds_sanity_check() be updated to also fail if
!reg_bounds_intersect(reg) is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1776344897.gi=
t.paul.chaignon@gmail.com?part=3D1
