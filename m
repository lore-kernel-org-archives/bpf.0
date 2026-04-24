Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07784225397
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053646; cv=none; b=QVRGXU/a5bBbycj4cCzWb7fUbyORMymosKlfJIoHVmIQYfJwuvOWBiZLCcnEynzL7fL79zHcCny3m7YmcbC7s0ayQLtQXGcD9JM59ou5NjKl9Iz9S2p1yvAUqSUcVsSWPk9kbs9RGAiF0o/RrgkeC1kSMGAX2oWYXzftRgrAPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053646; c=relaxed/simple;
	bh=Ahb4/sc+xhBKtNPIn/AjnySQMgj1MvlN8Y0EjUXjqj8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hVgruYS3MhfyqE07IWoGEmXR9dAkXa5Kdp0lrILfPO1CJbntmHBhpQ9oYFvb4DM/vQa/Kv1zZiB4DoeIOsaTokyxUP+qA10WhWCP8fyrwwkLWGCi+oetlfseuGXbIHV/G7zTkOaNAFTgIHba5ntUG38naG9L/QWT97tqe+6/d7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJudU2am; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJudU2am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE510C2BCB0;
	Fri, 24 Apr 2026 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053645;
	bh=Ahb4/sc+xhBKtNPIn/AjnySQMgj1MvlN8Y0EjUXjqj8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nJudU2amxrk/wYe0npooEibLmOI0PvYz1yo6vKKfo5SHbI//vzc21Zj/oWAHP4bCX
	 vD+h/GGjhgZTXIO7UZG8GxVkYi2cSpngr3nku9pWuDKJPC+b4bKzCLfmpIcEsbuaBH
	 tU2sOXvQ0JCyJZlQ3K9oJO8S2TTkUsKzxw1lTRyjVNyzWM7GWSnHctWfZGfPAftcw1
	 j4hcl61Kmu6I2opCJL7HLOS+U8gL4JGOg0r/8p0d2xQYY5pPiTaKNDvBOchlZep0+j
	 Ulo8qvMNxPR1uQDGXj2/ht/v3pzoCg3zWikR674CgLSuLk7KFhBtpatXTiv2sNTZuk
	 5ep6nX6yIEMrg==
Content-Type: multipart/mixed; boundary="===============2154306459596568017=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21545d85b7307fb5c8e05c70a9b302af95bea55e79e749cd379a2c053ff08c75@mail.kernel.org>
In-Reply-To: <20260424171443.2034958-1-yonghong.song@linux.dev>
References: <20260424171443.2034958-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 02/18] bpf: Add precision marking and backtracking for stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 18:00:45 +0000 (UTC)

--===============2154306459596568017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add precision marking and backtracking for stack argument slots
>
> Extend the precision marking and backtracking infrastructure to
> support stack argument slots (r11-based accesses). Without this,
> precision demands for scalar values passed through stack arguments
> are silently dropped, which could allow the verifier to incorrectly
> prune states with different constant values in stack arg slots.

This commit appears to be fixing a bug introduced by commit 8ade62ae1543
("bpf: Support stack arguments for bpf functions"). Should this commit include
a Fixes: tag?

Suggested: Fixes: 8ade62ae1543 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============2154306459596568017==--
