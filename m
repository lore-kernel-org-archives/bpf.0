Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09044102D
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386276; cv=none; b=jFnYWBbz+0dcFcbfDs9UqwGDEW+fLd3ivenYlp+HWuaTvzDrYOe52u6xL+Ct2QYcEKO4aUkDei6U9K3lorLK/mb5ksuk934r5Yqj+Ar2f7QI6a9oOcV3Yy2mEmKnD2hsOeDtMhlhYEflfuqdPpmNuljPh6l5yCBbfMU9LcII0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386276; c=relaxed/simple;
	bh=RLp3F7yCu+vHt02wVOh0wUqLOmzz/aHwemftYjCBESs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EpZJQUVNj+IRp3r2s0LhyzEXt+0S/JTfhqAEW+CBPaQZAFq0LGWQJTVB1QZKlKMbNzkMGlR864HNc8OK2QbwChXsC4UIp0L8LklOdDHG5gq8WVJmkXSfYO3pGKcWByqrGIj8sLTa3bz2ofQM3q2WOudz7DpwpRj3IORYGubOzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU/yhCGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU/yhCGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDB8C2BCAF;
	Tue, 28 Apr 2026 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777386275;
	bh=RLp3F7yCu+vHt02wVOh0wUqLOmzz/aHwemftYjCBESs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sU/yhCGYThKzyAZHe5ph2vCWMTZqwFzF4C9wsPRBCJbuxroNJebP+aOMsmksev7ua
	 +jsBIr0qz8dFW1AeBbs0llwI8ZUNloPzmveWyumc2BWtPP/o2ZlBLTXURWfDTJ83D5
	 1wCh4JGDSHlsRUPhlaEn833ls57xqJszlLQuaWbjK93xNZfQJhZAf+Pbya8XZZfQR7
	 pJ0xw0onB17mqd74YjQXFEbPOTD4DvZBY18sle7g7DpJHP5rujib+80JOGqR13db9s
	 u1mKvQyvmNNEUSzkA63w7g0JMknu0jk0X5Ne4mF4OkG1R40VIJtFCNsSqueioE4gY+
	 AX04Kixp3m82A==
Content-Type: multipart/mixed; boundary="===============6765498557505165830=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86d961168c3a9c24a06d8d3cb281f740bb97a0e2de78be0e057cc733966d1423@mail.kernel.org>
In-Reply-To: <20260428134252.2783519-1-etsal@meta.com>
References: <20260428134252.2783519-1-etsal@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Rename libarena malloc/free methods
From: bot+bpf-ci@kernel.org
To: etsal@meta.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,etsal@meta.com,ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 14:24:35 +0000 (UTC)

--===============6765498557505165830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: 7c8d208d816d0504aa916138ae097d9cb4ed4e56 ("Introduce arena library and runtime)

The Fixes: tag points to a merge commit, but kernel convention prefers
pointing to the specific commit that introduced the problematic code.

The malloc/free function definitions that conflict with s390 architecture
were directly introduced by commit 86426a28c52d ("selftests/bpf: Add buddy
allocator for libarena").

Should the Fixes: tag point to commit 86426a28c52d instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25057261385
--===============6765498557505165830==--
