Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C13AA1B2;
	Fri, 25 Sep 2026 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313519; cv=none; b=Hqx+Hcg38SQlhRVVQdjnykv6npyTz560m3HvcHTzgMpbwEGeRDhWXG9LYaBddA2O8xdY7Yyr6IQndWjID1nFecfch+GENd6JtB9BZlvOcUPRP1Xd7rDTZWObZy+i18F3cKBMdtsKeVXauZk1Ke/TUp5rem1IFsSM8B7rsc0/CbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313519; c=relaxed/simple;
	bh=4tgQuZtvFvYmrCGvpV8Li1XnoYoO8E2OePyf12fDu6I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DnDHhOkfcwALNilPHMHHywYV9g0xJzXdFvaoMYydkmKyZQbZaDgWsRrxHiKJuxk5G5GcJHQ2F/2UgOJ5Iehl0aEHHgOH64eiSZi9R6YH1T+2UYX8UFIZWQHdRb4+pqn6at47P/fwu10GZT8hfYmY3YcXhL4Wtp2vT0q1tlHf9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko6ezE2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko6ezE2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2041F000FF;
	Fri, 25 Sep 2026 05:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790313515;
	bh=wtafwFBKw3a4xkVV4mXoQy8qgUQ6SHG54uNE/7HLvYI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ko6ezE2S3wnXJZbewBcVv/A49XlxpvajiSEckazUVXPQr6lkFg4QRxiwiTFwFvWR1
	 w76lNW3fpGnbc6obxytrO34rfUtoQXK2ZjfTHySnOWcymKZdULbtqdri4hvK887Tsq
	 0Uwtb+k6jQByrp6/vLH8Wbs2BiBpjLEpj14vv49fTXIZy2NIZLKG1Vc6EiYASX1MB2
	 HvEHCPRa8Je09iO9A8N/7i3g8bwHpoVcll4eDV7Nox7vuoYfT6Aqb0o4dY2F/A3arT
	 1h3Y9OjtC58UhWjc7/ybnnp309nmsjCgQAsAN11cnkzp227fUmRQ7o+kyGEEV9w3mN
	 mS4JSpI/YzP/w==
Content-Type: multipart/mixed; boundary="===============6297641911423328375=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <716ef77710da60eceb070e3841926aea609a175a43ff2a7c6888130e107de307@mail.kernel.org>
In-Reply-To: <20260925043500.28030-1-chenyuan_fl@163.com>
References: <20260925043500.28030-1-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next] bpf: Roll back freplace link state when bpf_arch_text_poke() fails
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 05:18:34 +0000 (UTC)

--===============6297641911423328375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Roll back freplace link state when bpf_arch_text_poke() fails
>
> A freplace attach claims the target prog by bumping
> tgt_prog->aux->freplace_link_cnt and setting tr->extension_prog.
> bpf_arch_text_poke() then makes the extension take effect.  If the
> poke fails, the claims are never released: the attach unwinds
> through bpf_link_cleanup(), which clears link->prog, so
> bpf_trampoline_unlink_prog() never runs.
>
> Drop the link count under ext_mutex on the error path, and set
> tr->extension_prog only after the poke succeeded.  The count is
> still bumped before the poke: it blocks prog_array updates while
> the entry is patched.
>
> Fixes: d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

The Fixes: tag points to d6083f040d5d, but should this be commit
c43c348a8446 instead?

Looking at the commit history, c43c348a8446 ("bpf: Keep target extended
until its last freplace link detaches") introduced the freplace_link_cnt
field and the bpf_freplace_link_tgt_prog() function that increments it.

The bug being fixed here is that when bpf_freplace_link_tgt_prog() succeeds
but bpf_arch_text_poke() subsequently fails, the incremented count is not
rolled back. This exact code pattern was introduced by c43c348a8446, not
d6083f040d5d.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36096074687
--===============6297641911423328375==--
