Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1B345EA9
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795695; cv=none; b=nMv2qI2tE0ROv8kYrZiRvKO65Z5g91qj1EzaD4NNWzzyCN+fCw0MChK8jNMqHg8BfjKtMhiWD6JrYyHvxvE+1Vva49ImJj81sxgoz0bkkMbJAWQEmQUzPe37BQopFykUv/rzP7ctWNhZy9t6pmq5n9BEhYJGc40cLZLr7CIj55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795695; c=relaxed/simple;
	bh=ikUfal6QsD4tK7JHlmgFwBJlxOhfXxmLqXfCSZVuKlI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SXscRucFSm9Y09IdYMhIYFKV9HPVHsrFC+xgM6SiVLCRxZ9yQSZiHVQJQL8y1CYeh1iPSDc2gyj8x/91bLCVUHIGhp2tauCvhbPGbocasWFtL/06UuMuYqcnMJQm6LgaKRa4cO07r4KILViU/iwuvmEUE71ERMgJUkksz5mL5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjGEFLNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjGEFLNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26131F000E9;
	Mon,  3 Aug 2026 22:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795693;
	bh=C5NDQFax9WzqsKXRHCKnU7Fs0lIS/3Bf7GSzvwx6yZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZjGEFLNLKkhOYRzcuQf8zWRj7LQeZtmCywLHdbVZPp9jm2EhckL8Vvj/rCZD5jUVZ
	 HgnzcgDSXGva30UKFGVJfJA4AbnYDhVORvqcD2yGYu7Ahz44lkwn8nkD+OY6xuP8vx
	 2BWu3SY3ak9CZtuS+subgVc2ooFJELsPQxs39KH4y4riHZ2xXTCwcX7GNnMrLtiTtN
	 8Crak1E9f5xvbcQdMtz4aHkQM4dXUTqn4wfskaT21xABrH7K4j1xEyAt25ACv3x+f5
	 I+2TXG+0Ku7Od2QEX3Qq/z9Yksxh3fxWXEOYKnDaUN9JUD38zeFEMZyik54W2qaTRl
	 Fe7akSXm7sDRA==
Content-Type: multipart/mixed; boundary="===============0379802954471312065=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac7360c2468b48b0eb1884b422a919e0a2d99dbeb203f749aaecac2e0c9d71fe@mail.kernel.org>
In-Reply-To: <20260803210149.296496-3-jolsa@kernel.org>
References: <20260803210149.296496-3-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 02/12] bpf: Factor stackid_fastpath function from __bpf_get_stackid
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 22:21:32 +0000 (UTC)

--===============0379802954471312065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Factor stackid_fastpath function from __bpf_get_stackid
>
> The new stackid_fastpath does the fast stack hash and trace check, that
> does not need new bucket allocation. It covers both just-ip and buildid
> code paths.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This isn't a bug, but would it help to note in the changelog that -ENOENT
is the 'fall through to the slow path' return, and that hash_matches moves
into struct stackid so the slow path can still see it?

The caller depends on exactly that in:

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> @@ -556,57 +575,45 @@ static long __bpf_get_stackid
>
> -	err = stackid_init(stackid, map, trace, flags);
> -	if (err)
> +	err = stackid_fastpath(stackid, map, trace, flags);
> +	if (err != -ENOENT)
>  		return err;

and the new bool hash_matches field exists so the predicate survives across
the function boundary. A 'no functional change intended' line would also
make the refactor easier to review.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30854471987
--===============0379802954471312065==--
