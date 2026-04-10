Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA71F0991
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857445; cv=none; b=Erwlk8RgRA7eHRJKpf5f0rxOQML/UXPQVD7GkhYpUpq2vEmS7E7ebVqrSrOrQbxlzd4Zw6h9MJxmahs6Htmw7bfnKPkBYCDLK+FqTFgxTNbwFRTZw8y1NqciV3938/v5xUN06B2Wi9dKM2S/gOlb9NOYZktlJzsO5P6pgp0hhyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857445; c=relaxed/simple;
	bh=/hsbmTWmoL6lqQ+Dpp+HDOXWQP+wyBYOjmcU8pNIUn0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S4h+h0kyI+dJzJDh1MgVNvf+mEFIptRVjen9Wlm8Wt4d8MH6wmTxnFAfiNzcVf9proucXJPvnm2RZEB1Sc0QAb8D0uZa7abUR/TT8s+aGLdgA3heS2/kHxwUiiH946dE3g0F0Wfi3RGiY9Njf1EVqMdvWSV4p7/k4bKVHv6C9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q45T4/w7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q45T4/w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35663C19421;
	Fri, 10 Apr 2026 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775857445;
	bh=/hsbmTWmoL6lqQ+Dpp+HDOXWQP+wyBYOjmcU8pNIUn0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Q45T4/w7efHib170dte11LZTzmRKcusWxF0vclMNrWtAUOyAoGu2KFU1MKKztf6I6
	 Hvx2yjXiEqdWcAaP0SyCqDmmjJ/QjyKHjQQnzE6tZrjliymCaIaC/HnkH0NsHZ29TV
	 gZAPi3Jx32Zsynnd/1ULIdP0kEMDlh7SNZutDDI3wnoNbXwuUhm1d7MoIIepWOtfFR
	 7JkX6NkROBPADco6LGd+ERrKp8OXiljCv66M+yq+qPwQisMPoUQCPu8Z8roYP584BE
	 QbsWEQP3x0EUTykUt4kLidU2wzxzaOlrH1dJ7uzKHJiJaQH6q5WB6hiSu2DGZ9DNOC
	 xjwAXTHSH5Cvg==
Content-Type: multipart/mixed; boundary="===============1993883002693524989=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9421f5915a5ccbbc40eb6efe298476e5de06de5f86393b54c6ac769e34996366@mail.kernel.org>
In-Reply-To: <20260410-patch-set-v4-9-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-9-5d4eecb343db@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/14] bpf: simplify liveness to use (callsite, depth) keyed func_instances
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 21:44:05 +0000 (UTC)

--===============1993883002693524989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 2729ed965f62..1c8477069a43 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -85,158 +71,111 @@
>  * - A hash table mapping call chains to function instances.
>  */

The file header comment block still describes the old
callchain-based architecture, but this commit removes
struct callchain and replaces it with (callsite, depth) keying.

For example, the data structure summary near the end of the
block says:

 * - Call chain: for given verifier state, the call chain is
 *   a tuple of call instruction indexes leading to the current
 *   subprogram plus the subprogram entry point index.
 * - Function instance: for a given call chain, ...
 * - A hash table mapping call chains to function instances.

But the struct comment and the hash table inline comment were
updated to reflect the new design:

 * A function instance keyed by (callsite, depth).

  DECLARE_HASHTABLE(func_instances, 8); /* maps (depth, callsite) to func_instance */

Should the file header comment be updated to match the new
(callsite, depth) keying, or is leaving the "call chain"
terminology intentional?

>
> -struct callchain {
> -	u32 callsites[MAX_CALL_FRAMES];
> -	u32 sp_starts[MAX_CALL_FRAMES];
> -	u32 curframe;
> -};
> -
>  struct per_frame_masks {

[ ... ]

> +/*
> + * A function instance keyed by (callsite, depth).
> + * Encapsulates read and write marks for each instruction in the function.
> + * Marks are tracked for each frame up to @depth.
> + */
>  struct func_instance {
>  	struct hlist_node hl_node;
> -	struct callchain callchain;
> +	u32 callsite;
> +	u32 depth;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24264407165
--===============1993883002693524989==--
