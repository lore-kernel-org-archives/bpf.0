Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B223C0604
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540824; cv=none; b=SZQqXz1LnhneYdITsrEUn9H4ESXSnyTXT3twB0EumduWas5abowKkJM9Ed6ONWHywLm+0pvuBpjlNmzon40n9e0knsP8siJHJVfYEt1KtcE8NYC2AYV/LIkuCZvqIi535N5SWjdaI0sle2Jx/mMFAV82Avdot3LQ1ks+dC/n2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540824; c=relaxed/simple;
	bh=f8wO982hwgN6COQIAu0awM0gb/+gsK7TKG2sOHefwgk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QFr4M0oquBEsXWX0JB6/kX0gEbl2LwEno5N9a3QDFZ+ZpNZWLwismWhQMCJ2PlF1z6bYo9YDga/LHtv7JcsOUi4Zks/I+A/GQqP+3PhQ3sASC4GZp+NQjNTjoQcsfvGfOkUZu0JEgHHU81tbUItuAeUTRejirtnsS4tu7PMVlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgu+HhGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgu+HhGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2341F000FF;
	Sun, 27 Sep 2026 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540822;
	bh=7Xg4kAB8BVDtLAn1wX8P1TNQl526rjnaxnA4IOzlyUo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Jgu+HhGuvyvgaVUWHjqNBYHZTJ3yBBQa2yCYfUGGXl5Z1pNraNjuA0BGsTtlxsmKF
	 e0aKnmTXdnaXPhKVuXYk85RVz3aiRmjbb874r2xUnL/UHv9XAJo3HLMM+pYgP0CWOK
	 M76hMmYFKVFAZ/xfg/udI5FmQezetNo84iFwI6MFsNkqxmMLt3SrO5zq8w1xNPC0Mu
	 56LBcCfa5RLRtv42drpuSNtMJHIleBWVWfcEGANH+UarApJ1AcY1VoGGEmWbifI2kL
	 +cX6FzSgYgTEu7YeTq2e5EKEYNN7bnaO7pvk9W4IYynC6F/KymGJ8UCBwAIW9Bb9ZN
	 FKKxeukT5+2wA==
Content-Type: multipart/mixed; boundary="===============2145718720286897707=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <26e8e872df8217f1a4ccf776e162ba00cd7eb157ef910cc88bfeb742750976bb@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-23-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-23-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 23/36] bpf: allow precision backtracking between overlapping checkpoints
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:27:01 +0000 (UTC)

--===============2145718720286897707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 76833c2ad452..08e0b49841df 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -502,7 +502,9 @@ struct bpf_verifier_state {
>  	bool speculative;
>  	bool in_sleepable;
>
> -	/* first and last insn idx of this verifier state */
> +	/* First and last insn idx of this verifier state.
> +	 * last_insn_idx is -1 if no instructions have been executed yet.
> +	 */

This isn't a bug, but should the multi-line comment format follow the BPF
subsystem style for include/linux/bpf*.h files?  The opening /* should be
on a line by itself:

	/*
	 * First and last insn idx of this verifier state.
	 * last_insn_idx is -1 if no instructions have been executed yet.
	 */

>  	u32 first_insn_idx;
>  	u32 last_insn_idx;
>  	/* if this state is a backedge state then equal_state

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============2145718720286897707==--
