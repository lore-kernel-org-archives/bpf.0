Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31064335555
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794803; cv=none; b=OUHO8GpuJCkRTuvG+seV+Z7i6/hlpJTSP4EVDhzG/xuyZk2izd8KDSxMLmJh+fWV/jINLYINBrhaJQDv7uE9jp+g2FxMRr1pEPkpGjj6kS0rXncymxv97udz4zOj9jmkRmCoxz1eMl4/Ad0Hdae370zbJC73ZMUG//jip52zp64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794803; c=relaxed/simple;
	bh=S18JnJi/l3K5CaCchti+tDxcMJjP09W6o4DOsrvO5BY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jRQMWqN7KusIuBvgCYFMphQ0mY04XMC3KnknbYIFHuXgbwZ57QqQ/9SLUlpjn5xY8Xavzqc+SpyCoa58gb7ItEkKZEDbWgvN8uK34+upK+P8UN8zcDppegx0H+m84DGBVBi2aTkilYUuvxwHRnC/kt7kFELQKEHBFjTMJ64VPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euVdEhKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euVdEhKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9687BC2BCB0;
	Tue, 21 Apr 2026 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794802;
	bh=S18JnJi/l3K5CaCchti+tDxcMJjP09W6o4DOsrvO5BY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=euVdEhKD0fqOMfU8D42bIhzlG1Csab7KOrPbjVShmCwMQJirBMc08IS+iVnyVa7Mi
	 Z7HCmJgncHozZg1w9BLXfWU5l38T8fsWW3gRUQ70w5AJ9hKsdFXnUD7NNTE+apGkiF
	 kZ4mIX7+AMVSxmEwWfpRJqyv0zZifEMXzDGt+/hUQg39RP0fDwLDutnPWwZZ6LlCu5
	 rDFmH4nLPT61BEOxSJLKjWTP68MyXpyYBVtxm3qkq46wVdLb3TgMxjk+zZZkVoG9O4
	 j5iw4oxtj8/cG4sVDyzec8qrO71cXq6Dmel8lwGvDJcFxpaYWFREtrK7VIe9Odq+nh
	 OP3Nob/kUMzHA==
Content-Type: multipart/mixed; boundary="===============6414921442221134341=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <154d4ed659716997501257309218648961b1f25de606e411a8f84cf16b95cc5a@mail.kernel.org>
In-Reply-To: <20260421171937.3508679-1-yonghong.song@linux.dev>
References: <20260421171937.3508679-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/9] bpf: Fix tail_call_reachable leak
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 18:06:42 +0000 (UTC)

--===============6414921442221134341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 697f215251be114235dcf2ec469f425797a26a51
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Fix tail_call_reachable leak

This commit fixes a leak of the local tail_call_reachable flag across
sibling subprogs during the DFS traversal in
check_max_stack_depth_subprog(), which caused the JIT to emit
unnecessary tail call counter preservation code for subprogs that
could not be reached via a tail call path.

Should this commit carry a Fixes: tag? The buggy pattern (set
tail_call_reachable to true on push, never reset on pop, then mark all
currently-on-stack frames) appears to have been introduced by commit
ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in
JIT") which originally added tail_call_reachable tracking to the
stack-depth DFS.

Something like:

    Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24736686700
--===============6414921442221134341==--
