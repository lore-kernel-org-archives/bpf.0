Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70D202C48
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087200; cv=none; b=UHzyKowL25C/A/aZAAfcIkBtv6Tf8GIHBS1DHE4u6WhGLK8Xg0xBx7XL8I4TUG9OBpNRIut63jL2IulvqyQs6T/NuuXFIaCyOxE7kNVWMR8E9TvSHNx1q5P4vrebJOoOKWLKczftcbj/xs3x7doj6Y0RJnaIV4qHKt2hPsRrcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087200; c=relaxed/simple;
	bh=XXF9DLd5a+krxXwP35a86yLprhO3WaSOO2JonoXQRqA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FKT3oinjEqtmUhnKcJat3o53nU8ilwZ3d/wPNbSFAIz9r85/XB5GzyBTbY/0abXF7+EqDNtBkFnVE9WWtsp/iKw1kxWqWr9Y7+qr8mL3a+oYhK+CJC/8H1bN8OacDBzQ/c+zqOp24l3pBmOkGEmv4TzKX9iiBTRcFFILzIjIr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq/CtdJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq/CtdJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27ABC116C6;
	Tue,  3 Feb 2026 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770087200;
	bh=XXF9DLd5a+krxXwP35a86yLprhO3WaSOO2JonoXQRqA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Iq/CtdJd0k14d2DZkk5XtH3Ga04O5/d8mkW3kVB/n2p+8aEU5wticudxDn59Nz8Bx
	 8kIRSmCh12adaXhOaJgG88Y/MT5J23u0LEpEn55UQrdww1+NoGWxowKgxK+6U7PP2y
	 0Z7J6A4C0KInnSn7UI0rjzRs99+92EA55DoiUHUBjvCoquDBedDEr8dtkem9e+s55T
	 N90CgM81Gj3HwqW0L0dmwqRY84KBtbSIc2j9+0Pw/9ou8roX02ETJRPOWgA3wX0H4N
	 yIfWVx7SdhfKJ9Re2oAhViN3fmtZ7FSoCQVXkibtkkqDqR/FRg5CkL0eU3H8c/LY3d
	 4TgCEimL+IkXA==
Content-Type: multipart/mixed; boundary="===============2529373190127614346=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f51a3352fe19af3680d04e95ad373f74c3ec890cb165492d4f806f527c856a8@mail.kernel.org>
In-Reply-To: <20260203022229.1630849-5-puranjay@kernel.org>
References: <20260203022229.1630849-5-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: verifier: Relax scalar id equivalence for state pruning
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 02:53:19 +0000 (UTC)

--===============2529373190127614346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit caefa48534e902ffcecf6479615965779dd6ec93
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: verifier: Relax scalar id equivalence for state pruning

This commit relaxes scalar ID equivalence checking for state pruning in the
BPF verifier. When the old state has id=0 (independent register), any ID in
the current state is now accepted since it only adds constraints.

>     For example in the selftest added in the next commit, two registers - r6
>     and r7 are not linked to any other registers and get cached with id=0,
>     in the current state, they are both linked to each other with id=A.
>     Before this commit, check_scalar_ids, would give temperory ids to r6 and
>     r6 (say tid1 and tid2) and then check_ids() would map tid1->A, and when

This isn't a bug, but there are two typos in this paragraph: "temperory"
should be "temporary", and "r6 and r6" should be "r6 and r7".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21614542865

AI-authorship-score: low
AI-authorship-explanation: The commit contains minor typos and shows domain expertise typical of human kernel developers rather than AI-generated content.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor typos in commit message do not affect code functionality or system behavior.

--===============2529373190127614346==--
