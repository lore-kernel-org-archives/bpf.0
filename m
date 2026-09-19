Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4F547043
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789786537; cv=none; b=uPluguSWG661PN03wtYoDQfdxdBats7RWwXpsWm6bqyF9d00Ak1yM/8sO6lOvJ/z8GkCbxYQjzk2lVd9qmgsSjLtMe1KEHUDxpPlwnzbRtbDAHJmvaiwPGIxmPRM56TaTeV1CeEx8qIsGdTTeEAVWCYAZtTsVgPPGvdno8gFQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789786537; c=relaxed/simple;
	bh=EEZErsLXhurlNCf5T0+1zUqQuW3ot044ylEPpeG7yFY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RRumoalXlvvFs/Gt7WlMxE843RMuuxCEkgry8dqdaG68NPviGwupdVe3fjwjlaoTAxSCnQbGgd3IQP+gdW2eS960u97hLQn6D0HpNWZaoBvRRN8Y6Xfhy03dgTxe12oXG4cZMQI/4TbfK+LOAmWa4T+ViMtPiF0k4sQ6J0CBuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtsjzwDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtsjzwDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BD71F00898;
	Sat, 19 Sep 2026 02:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789786536;
	bh=2fZWZVigHDcdyT6JAmvpiy69iVic4jvBDmw2n2AbhRU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OtsjzwDBwySCwyKGSZfuyP3MGoEHA04Q+do8iS0NoKAN757T3DvVGEKNu+3uZ2rkR
	 rjPwhT1RUY4loe4k+NdPifiHSFW1k2h92GtuqGOhJrk6QJFw7u6Bgy9nzmFaR5vK39
	 cCfgDbblYxGF9UzrYF2q2+NUW4hGUB89h9UY5RPwTrVcrZF+SBtjXNCHBx9M99yMXF
	 p27I1isN9S4rRSdliukY4q1EPRRYRwVjl/BBZIXax+SLdw+oLCeFFPZuTYuDXFrlQO
	 cfSOhCgGkBjJrZYa4bKwbZAIJlmotcmuP73U2oJwUFU8Db+8EqtXckalME4vf0ZwTp
	 PJi5ElLtpYTow==
Content-Type: multipart/mixed; boundary="===============7904192411865128313=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd08a67fa998c4e7d2ed1455eaa65d9001145e6ad9fc1a881cfe31548740935d@mail.kernel.org>
In-Reply-To: <20260919014213.1840880-2-memxor@gmail.com>
References: <20260919014213.1840880-2-memxor@gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Compare stack frames in regs_exact()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 19 Sep 2026 02:55:34 +0000 (UTC)

--===============7904192411865128313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index e4ec007f7fa61..012b82513a3bc 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -644,10 +644,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		return range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off);
>  	case PTR_TO_STACK:
> -		/* two stack pointers are equal only if they're pointing to
> -		 * the same stack frame, since fp-8 in foo != fp-8 in bar
> -		 */
> -		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
> +		return regs_exact(rold, rcur, idmap);

This isn't a bug, but now that the PTR_TO_STACK case returns exactly
what the default case returns (both just 'return regs_exact(rold, rcur,
idmap);'), is the explicit case statement kept deliberately to document
that stack pointers still need exact comparison, or could it be dropped
to avoid carrying what looks like a silent duplicate?

The rationale mentioned in the deleted comment (fp-8 in foo != fp-8 in
bar) is preserved in the relocated frameno comment in
include/linux/bpf_verifier.h, but the case arm itself no longer conveys
anything distinct.

>  	case PTR_TO_ARENA:
>  		return true;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35414429846
--===============7904192411865128313==--
