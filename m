Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10E43B6E2;
	Mon, 24 Aug 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582124; cv=none; b=A82I8pHyHdubXNCUBo8NV5pYcoI0F1oAH3wzLh4i+OOVoGsWhava4KsM42zTUWkXOsDu6PN8/IszFTCRPF+8dd6LAj2phIUmjHgitqE9KOaLyMwkg20gTIEP7GfhLOJPUVphj80/szXvrZ5ZTJ9BBcfDP6plHZ6Fxido/kSZT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582124; c=relaxed/simple;
	bh=wGZnLwWhU47TMt4sekHSovBjxndO2rkfX0vrerJB2jI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rMMMeHQs6rNZqGjA4QqKJR6J98QjK5guE3jMoEAaON3czc3nOJTAe4m9BdO5MYDwwHGP30RrmAbwiQ+hWrXt+G1n8RhTO6Gs9IDAbbxZNIjTx5Oox8AVfSDVkQdw9Rz8hQFwwcF/7bI/U9gg6tObwsxGxHyvgAljBWEMbv1rYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po9gSKlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po9gSKlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3241F00A3A;
	Mon, 24 Aug 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787582122;
	bh=nRsKb375L85ZfrkQvToxwFbfdM1QBVfBK2sFwXXTmTk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Po9gSKlKbu8DWAp9Vcp0zuym5nfOW8Y6+NA7FhTDAdejwtCxkLf6ngXoBQWgQ/Fah
	 +s0nakP4tm1qzmLngOOSlwCWqu8faiKG9mszkfkEXd78/dnLTUMWuiOmL7FLMH6Wd7
	 6KqnGUQcCq3ApVvwpvShdogjRo9iHMFF8cL8bwwiD070KL6isYVUgRdObDa7TGkd+f
	 RdgNUaQftpPE5ksXYMhzfjtOc5D92sf85B1kcPtTq0ckyMCk94FvWNk4Zl4T6gFJZU
	 AZtnGg1We2qlkPNiRdmSFrXM+N6+hP2WkcPTn8WmnjJ/clhRpq2pE/tCHBQg8ih4/7
	 xRyJJAJebSwew==
Content-Type: multipart/mixed; boundary="===============0418816406230417369=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae761350e6870487e47b1089ea3d77c62ae732a2fe6f34bbb79cd8d620f14e85@mail.kernel.org>
In-Reply-To: <20260824134016.2006188-3-chenyuan_fl@163.com>
References: <20260824134016.2006188-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 14:35:22 +0000 (UTC)

--===============0418816406230417369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
>
> range_tree_set() pre-allocates the node needed for a brand-new range
> before calling range_tree_clear(), so an allocation failure returns
> -ENOMEM without having modified the tree (previously the overlapping
> nodes were already removed by range_tree_clear() before the allocation
> was attempted, permanently losing the cleared sub-ranges).
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This isn't a bug, but would it be worth adding a Fixes: tag for the commit
that introduced the clear-then-allocate ordering, so the stable backport
scope is clear? The introducing commit could not be determined from this
checkout.

Also, could the body be split into two sentences so the "previously ..."
rationale is not buried in a parenthetical? For example:

  range_tree_set() pre-allocates the node needed for a brand-new range
  before calling range_tree_clear(), so an allocation failure returns
  -ENOMEM without having modified the tree. Previously the overlapping
  nodes were already removed by range_tree_clear() before the allocation
  was attempted, permanently losing the cleared sub-ranges.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32736729475
--===============0418816406230417369==--
