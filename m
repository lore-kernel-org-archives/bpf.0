Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658749D5A1
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547670; cv=none; b=c7e5+BjwtyxkbjdPYbJmWKf6mTewyULKQ/ij97RGjCoIa9X5nxNSrZdhqioo0b5NAxExSkBagtcAtDiNcKbNe2roxc1KVjgrr7Ey73kRSN+PACr3sy3zDA8Tpp3a68dRmtFtLFqGqcoGsHyBpRNbiQQPPd0ezk2cg/gHbV3St8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547670; c=relaxed/simple;
	bh=yPM4UETri5l0XqRFdFmlmqEhySjORI/AzzBpzQpWPpA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZqEr6hEYwqehAfLxvJ0WPui7R3vQ2jMCs15R4KXxxNcMWj2MlaTCLP3WPT1uTb3qtK25mzYkLikjGDhg6eX8D8hFEnQQx8VUSVZziMhDBM1XtgMcRgYHMMCYJqrfTtb8nxpXyBbkGlumFJ2scrKhC+9woBSdImBehCtmRUSrCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfWXSpUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfWXSpUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6352F1F00893;
	Fri,  9 Oct 2026 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547665;
	bh=W8Uc9k3ZVAhNAZz4nwmsebWof5DenPkLjAVN+V4YrcU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RfWXSpUErBfb+4QsOFM45YEPpgzjXFWMvNssSof1w6Nic0qyQPEaC1YWhkMW8mgCM
	 HHIeEumom5hRC2kTu162dSh4u8wt4y5b8X1PiuzOdqwU0UT+7pOniSFUZPOaEfM7gN
	 7402Iyhbd8U9fEnmWEy0zdhyBr/apNhPHgpJ/GKAiUvqjKnINtAfaRrY+fFNVin1oq
	 q7ugAmqXbtH5p2JOR0zrCx2+UobBPPz5dbGcwPZNDb6kdUAqoMqfop92cEOnjaC2wg
	 AsYv3LLZauwCpuRu+sq0RUUytg47OMLvi4m0XLW4sSNfUr0QjRottZ8CZeIZIERFEo
	 XID6facb7Krfg==
Content-Type: multipart/mixed; boundary="===============0397426489508500162=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbad54c9472341301483678b9ec9ee126a9f70cd1e944a266a5b190c27b18226@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-35-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-35-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 35/51] bpf: avoid widening registers that hinder exact stack-slot tracking
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:44 +0000 (UTC)

--===============0397426489508500162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: avoid widening registers that hinder exact stack-slot tracking

TL;DR: Nit only: BPF_SCEV_REGS_NUM in bpf_verifier.h appears to be defined
twice, identically, with a duplicate comment; it compiles, but the copies
could diverge, so the new one could be dropped.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -708,6 +708,9 @@ struct bpf_loop_exit {
>  	int to; /* instruction outside the loop */
>  };
>
> +/* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
> +#define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
> +
>  struct bpf_loop {
>  	struct bpf_backedge backedges[MAX_BACKEDGES];
>  	/* edges exiting from this loop, includes edges from nested loops */

Isn't this a second definition of BPF_SCEV_REGS_NUM, comment included?

The same header already has it, added earlier in the series by "bpf: use
SCEV to widen bounded loops" for struct bpf_loop_iters::precise_regs:

  /* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
  #define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)

That earlier definition sits above struct bpf_loop, so
store_base_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)] can use it directly.  The
two definitions are token-identical, so it compiles cleanly, but a later
edit to one copy could silently diverge from the other.

Could the new #define and its comment be dropped from this hunk?  The
duplicate is still present at the end of the series (726d0559f576).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============0397426489508500162==--
