Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D92225397
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147310; cv=none; b=LLWY+8u1jKKv7qbcMjfPYfoQuF/y4/k1kJ4rHOs4sqrq2CHUzR3Ll2Pv2NMmXW0zQNJX8kyoqsipl47qY1icmf+Ha+bkufBwijvIXc5duR8+mZPJlq5D4lPDr+sZI93pEfQsJ//KWui+YDM3mdkVgDNKD4o29dpnb32sqPe58sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147310; c=relaxed/simple;
	bh=7J7Qj6xxNzxEQLc6WdKblFQOeLn47uXfkrqW+thk9Ck=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LUrYviZc5gFKUW7MrC+SYJ+ynz6yZr0Opopa/OFJX8a3oge414Y/XO1baAPX7GGsBrqQ39zt0UK1GQZNQ+ZcMLINMroB6U3MEMtAhFckjqKjr6hWM+nZl4anpg9LWocueb+KitCwbhuW7fwsFEaYJFzpt8kadPQOaGvJAUGeCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amL7qwWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amL7qwWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174D6C116C6;
	Thu,  2 Apr 2026 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147310;
	bh=7J7Qj6xxNzxEQLc6WdKblFQOeLn47uXfkrqW+thk9Ck=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=amL7qwWMYYOrxqDKLx3XYJPL6sx5AYoTI3dbI61+rG4tGKGRUyrq8It5eMI1ghaKV
	 SrjJaN9O38StkVK8M06sOci5dmZC8x97zusvOH8MOlZJKgEzZbAtpGX8EdqFV99Jl8
	 CpWcio5FeZzFB85Vc+5EcVZH1Kd8BSxU7EtAtX9eJ5Y4tky7D6JDlWCgSt8gnWa834
	 89J4b0jh6zg7XPctZTvQlpNCLvONiaRHgZM5qU9TKdEjH8iQ+AO+68eurSUgfWIFtm
	 wyvyim/ja2+PoUAPgNqieOLEdipcTmQWQL6WRqxjIGiJ7FSZJNC+KG+QKWE9W+11yZ
	 ikzznZCFNFtvw==
Content-Type: multipart/mixed; boundary="===============4026262281768227299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3f23feac390f144ec5e47178bcc0ca5cb774e093d2d1ce6675b0b31fb4c9c95e@mail.kernel.org>
In-Reply-To: <a166b54a3cbbbdbcdf8a87f53045f1097176218b.1775142354.git.paul.chaignon@gmail.com>
References: <a166b54a3cbbbdbcdf8a87f53045f1097176218b.1775142354.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Simulate branches to prune based on range violations
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: harishankar.vishwanathan@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,shung-hsi.yu@suse.com,srinivas.narayana@rutgers.edu,santosh.nagarakatte@rutgers.edu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Apr 2026 16:28:30 +0000 (UTC)

--===============4026262281768227299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5

This is a bug fix addressing verifier invariant violations (e.g.
umax < umin) triggered by syzbot. The v1 of this patch included a
Fixes: tag pointing to 5f99f312bd3b ("bpf: add register bounds sanity
checks and sanitization"), which was dropped after discussion about
whether it pointed to the root cause or the detection mechanism.

Would it make sense to include a Fixes: tag here? Even if 5f99f312bd3b
only surfaced the issue, having a tag helps stable backport tooling
identify where the fix is needed. Without it, automated stable processes
may not pick this up.

https://lore.kernel.org/bpf/swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23908257980
--===============4026262281768227299==--
