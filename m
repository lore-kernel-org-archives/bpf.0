Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2B47F3DF
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204726; cv=none; b=Pzj1EiFmWpkiyVM0PUR0n0wXqABMsj9FkhAnUiJKyP+2zoCjxH0s+q3c/0dV4jBGIkN1UgKz5j8h68d97iyTBoous9J7nwAetYm+nqSlqmRteEkpVfYPWGf6I9uxNcgPIDnRTKECmY4XF02UUJ9WDikXfTonXNwjTzf50oSPwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204726; c=relaxed/simple;
	bh=X93ROUWFTb4N9QW/X8xXIWfWOhJ49YyI7u07cBdHW+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AckGwphUomiLYfzo0qxzuZMQqi5xqVaupjPzjyjKKNH2MBln9RFkfxapuPZbKZHcicSDBpMkerIsNXdbauZAigtSxZKuIksc/Wf1+zMJXHzZqk2YpRlhrcuwaeSZpRmHCawLWcm2KuC/1oocfiEYuxuI+79q67xCizNP3N93PHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv9CwWI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv9CwWI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339091F00893;
	Wed, 23 Sep 2026 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790204724;
	bh=iKZFGarh3uYa2+Cp2f4UZBSequXt6W/hB8Lq8lnWiJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rv9CwWI0wCR8Cr5ryOCBuyeMB8Ow+WRfzI158nDJVFhtXF6SMCxxzC0uT2K30Z7m+
	 ERc9B2JilxoAOL7iUejjpck83HtOwvRSm5G+nhF8dWZouID5q1OuCOziRTgVurJldC
	 +T0IBZai/fpKKR9H5zZjevktIm3imwLb+5w59nBdextJ8EbmI7YhRt7SLvt0I2on4W
	 CPPxwlbklJwTyW1CvFZe5T3I6QK5EHLKr2e3tPmGY36otKDnRb5s5Xk7XLk5CQDfaQ
	 Dx3nBMDRHvIrDbFJ0WswmnUPSbAEgIVxurPKTwgrFMYYrqxwunJS02dfoBq8ZU4u/K
	 bfazpBePKJKXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: Mark loop heads in check_cfg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923223554.562379-3-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
 <20260923223554.562379-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:05:23 +0000
Message-Id: <20260923230524.339091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: stale CFG backedge metadata causes incorrect loop detection
--

commit de7e162d2062bfebc2e588cb33048e1edec24938
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Mark loop heads in check_cfg()

check_cfg() finds back-edges while it walks the control flow graph.
Remember their targets as loop heads and which edge of the insn is
the back-edge. The main pass needs it to tell the state that enters
the loop from the state that went around it.
No functional change.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 92f528c456052..5a08f079a4896 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -709,6 +709,9 @@ struct bpf_insn_aux_data {
>  	u32 non_stack_access:1; /* instruction can access non-stack memory */
>  	/* true if some jump or call instruction targets this instruction */
>  	u32 jump_target:1;
> +	u32 loop_head:1; /* target of a back-edge */
> +	u32 backedge_ft:1; /* the edge to the next insn is a back-edge */
> +	u32 backedge_br:1; /* the jump is a back-edge */

[Severity: High]
Does this new CFG metadata need to be cleared when dead conditional jumps a=
re
rewritten?

When bpf_prune_dead_branches() in kernel/bpf/const_fold.c rewrites dead
conditional jumps into unconditional BPF_JA jumps:

kernel/bpf/const_fold.c:bpf_prune_dead_branches()
    *insn =3D BPF_JMP_A(taken ? insn->off : 0);
    changed =3D true;

it does not seem to clear the newly added backedge_br or backedge_ft metada=
ta.

If a pruned branch was a back-edge but the actually taken branch is a forwa=
rd
edge, and a later function like is_backedge() assumes unconditional jumps h=
ave
only a single edge:

kernel/bpf/states.c:is_backedge()
    if ((BPF_CLASS(insn->code) =3D=3D BPF_JMP || BPF_CLASS(insn->code) =3D=
=3D BPF_JMP32) &&
        BPF_OP(insn->code) =3D=3D BPF_JA)
        return aux->backedge_ft || aux->backedge_br;

could this stale metadata cause forward edges to be incorrectly classified =
as
loop back-edges? This might lead to spurious state widening and the addition
of unnecessary may_goto loop guards.

>  	/*
>  	 * CFG strongly connected component this instruction belongs to,
>  	 * zero if it is a singleton SCC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923223554.5623=
79-1-alexei.starovoitov@gmail.com?part=3D2
