Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9D3BCD26
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540811; cv=none; b=RhxxH/B2YbuY3GT0zAY9c9WdOgoJGdOVwIzwk0pbrMIRfR8fLRVbC5qqm9DNWMp9LsZS5Sg63x3e37ivmOzU6+YkuZUxEeYOuGx+ZcKge+gIPCTJjwQtBCxWX+TIFk8ECGGgG95eVuArfFTj6Ldu9Gi7CK4FAtERAtLZkTxw0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540811; c=relaxed/simple;
	bh=c0YIekzFo7ZwgmTlXGOPL+JroO3dCm4VV1DovpRVKUQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fj3DUlsLox9qQ8ITm1iGcecPQkbYabNfnkJCa4rXUVXaXn8pfZtpV1F1mOj4XND4HznPry8g61fwO7VKa65dBQ26IIsAymaqkaAdTP1G/sBfV2ICiumEBu1frLgL+QFl+GrRtAzn79P5CQ+oxDaa+vjqnbtaQI7nq0OPYRsqPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duJ2wMSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duJ2wMSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A031F000FF;
	Sun, 27 Sep 2026 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540809;
	bh=S39wT3E8hXKKkRlYezLH06sH3TSg8xkWnzdDQBDhP0s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=duJ2wMSAvUzSAcF2t58fMFtxdYSY5ukwHWemmX3sZrLaKPaPCib3N9s8qhpn0CPHT
	 5TT/dGSQaRAQt01OE3na9PCg4+vdHaIutCoc7FWxFfrUDEmnFA3qgltG2y/CPVKQFw
	 iX8lCCrEynOmCXhtvZE+lkotJWkGMMTC3JWIKP8yGI5BGm/RV8FDlLMP4Okdq7iN1X
	 KWfRc/I1GHBVnrbTpjvXylvf+JwYIHAODxtR/CmS47x09tWjRC+lf7pf7iWgLW4JuN
	 xxyZS0uRnLfIncjjSUMqQYujPLIeH0OBcr8i7l4NaJ4q6/gs/gLblEu+GCNAUVX12r
	 bSu+SPy5XVtxQ==
Content-Type: multipart/mixed; boundary="===============2984305067641037335=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf07c6457e025fa7a97916fda6d238385eab6c9f5515d88a563b4e2af1cb6c5a@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-21-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-21-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 21/36] bpf: record basic-block ends in insn_aux_data
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ezingerman@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:26:49 +0000 (UTC)

--===============2984305067641037335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: record basic-block ends in insn_aux_data
>
>     SCEV needs information about the program's basic-block structure.
>     Piggyback on compute_predecessors() and set
>     insn_aux_data->bb_end for an instruction if:
>     - it has multiple successors, or
>     - it has multiple predecessors, or
>     - it is a jump instruction.
>
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

The commit message says bb_end is set for an instruction if "it has
multiple predecessors", but the code does something different:

kernel/bpf/loops.c:compute_predecessors() {
    ...
    if (succ->cnt > 1 ||
        (succ->cnt == 1 && num_preds[succ->items[0]] > 1) ||
        is_cfg_jump(insn))
        aux[i].bb_end = true;
    ...
}

The second condition marks instruction i when i's single *successor* has
more than one predecessor. It does not look at num_preds[i].

An instruction with several predecessors is a join point, so it starts a
basic block rather than ending one. The code gets this right: the
instruction just before a join point is marked as the block end, and the
SCEV walker added later in the series depends on that, because it stops
at aux[idx].bb_end and sends the state through join_successor().

If the rule were implemented the way the changelog words it, the join
point would get bb_end instead, and the walker would enter the join
block from one predecessor without merging state from the others.

Could the wording be "its only successor has multiple predecessors"?

The new struct field bool bb_end in struct bpf_insn_aux_data has no
comment, so the changelog is currently the only description of what
bb_end means. A one-line comment on the field would also help.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============2984305067641037335==--
