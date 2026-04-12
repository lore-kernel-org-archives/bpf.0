Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34566BFCE
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009233; cv=none; b=nT+t/wUqCjygwTehOqsouoCcQgR5EhUYCHGb4ez9eHWNJiV/vG9xuSEbL94xS3CSt0SvA5o4tlt10FY4ws3icccnk6MEnvS/XuNLXZxYsh9X+nZGiMjQC21i0/8UIMdfGOv6p9XbnYS7GL9mbkewcCGj4CJpIrK8Iaiam6pkzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009233; c=relaxed/simple;
	bh=eWYgXwr/xgbRuTyzFTGiDZ0qZW+6vP2FTdoDlKbMBfw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BACifUwrJdU+nPA/wFWlcg2O7d1dNjIegq1/La8/EukcMyX+I+CyieVsmYkTiiG4yLLxjp2Kf29Ayeu8G6gryHTBqCJ8UCZoXu2F1HCzygnRpd27taooZVyG5jfPGcVIj8XTpkkqP5Z+Iu/6x0rpjIwfMR84iU23OHAo6UMzkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyR5xSTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyR5xSTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A893C19424;
	Sun, 12 Apr 2026 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009233;
	bh=eWYgXwr/xgbRuTyzFTGiDZ0qZW+6vP2FTdoDlKbMBfw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oyR5xSTwW2709wObVqpezcCxpxSaoKWLXRjjWdbM2so7L5OK6fPmeta8bQiA9lA01
	 JAyAD6fsooUVptInRQw1omtPi44hXF5iNm0LxxiMmuwu+zDadIFC1bvH2yV7mjBBCs
	 2MY/4j7Ift7IifBQ/IlONMtvvKqWias9H45LjK2+R+N9XIaQ7hr1mW+az33wrvGv1H
	 McRcxdtYuDtJbBmj9lbEd2octvk9f5I34CjmZa7Ha7QJlPZAaI6CP/kl0uFKWdcb92
	 iuNmRDutxWHZ73g1xmtr3/YFGAvL1f9MXsTKlP7Kiq7ajK63FeGko2Ln28l5GPXDk1
	 d9fonraW+segA==
Content-Type: multipart/mixed; boundary="===============4365001066776047599=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c34cc7d340a6b6b356193c62095deaca0aefee52934722148a8d4499b5d9bc21@mail.kernel.org>
In-Reply-To: <20260412152936.54262-3-alexei.starovoitov@gmail.com>
References: <20260412152936.54262-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/6] bpf: Move compute_insn_live_regs() into liveness.c
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 15:53:53 +0000 (UTC)

--===============4365001066776047599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 31e03aa6b070..11f0c5a050b3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -24247,7 +23999,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  	if (ret < 0)
>  		goto skip_full_check;
>
> -	ret = compute_live_registers(env);
> +	ret = bpf_compute_live_registers(env);

The rename from compute_live_registers() to bpf_compute_live_registers()
looks correct here, but there is a stale reference to the old name in
kernel/bpf/const_fold.c:

kernel/bpf/const_fold.c:bpf_prune_dead_branches() {
    /*
     * Rewrite conditional branches with constant outcomes into unconditional
     * jumps using register values resolved by bpf_compute_const_regs() pass.
     * This eliminates dead edges from the CFG so that compute_live_registers()
     * doesn't propagate liveness through dead code.
     */

Should this reference be updated to bpf_compute_live_registers() to
match the rename?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24310126918
--===============4365001066776047599==--
