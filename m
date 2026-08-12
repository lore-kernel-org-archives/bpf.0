Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F82175A79
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576495; cv=none; b=BvABiDheAQb2+uzJGLHmFbfOaLX4GaOtWbGXsCG+wL4uXRswNVQaz8ra6QlPXjPsYcH2KZp6Am/jQsFvWRon8mJPGkldHDk5VE1yyNC1X55TrcT+5RCucgtSUC3ESJknvPUKjMjwiBzg6B5iFemQ3g85+nug4zdxf1g5Um2JXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576495; c=relaxed/simple;
	bh=8vyf4x/AGJkdMNj9Juyra9Wda4KsOwAZLUbZUiRmav0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XamYfS+AruKDLngXfuiOVc3SNLjqVRFyhkVMjmSh/EgWTQlOJSs3tzSEIBC6cQhcyyPVMtOGH/Jtyj0EbJN4IAHvkeZGQJ90uZmHVBiNx7skw5FFAayc0OYpwAX5InDMGCJbtBJsJ/3CnJyUwqCgv2Nu887e63stC09FEElF/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPtLv0og; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPtLv0og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484891F000E9;
	Wed, 12 Aug 2026 23:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576493;
	bh=8vyf4x/AGJkdMNj9Juyra9Wda4KsOwAZLUbZUiRmav0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BPtLv0ogXbKfiPApKQbYB3Sx4929jGzzI6fSMOkwuKvBECYugrnk+Oz/hUW2RA85n
	 UVNo8rSEeKBmUZX/ajO6GkfeuH1Ob76RLXaG3lEOU1/9B+LBlSRYCVr3yvksCvDeom
	 N50mAzChuvNk7Y/8dccfh3leT54zhI31D9meAqAN3Pjj3+cp2VPsduVclaAtxJNBQA
	 wcYFmNRxR+C7+jfUxkrdasHUsatz0eYwV7U6JCoLZZ2b/GZsix8zppFD3H/67Q9VFe
	 EDizmXX+SIVINWWYAwbUA/Lksf6KGITeAGK+YLdXqKBd4fuuUoE4rHr+7hRDmEchqR
	 mKFxq4KfZaPzA==
Content-Type: multipart/mixed; boundary="===============7853177006825531859=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e88af617b57773c42855b600d4bb8c5ab4f4935c6d857b904283c954e35bb95@mail.kernel.org>
In-Reply-To: <20260812221925.3358041-4-memxor@gmail.com>
References: <20260812221925.3358041-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v8 3/6] bpf: Show more useful info in stack depth stats
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 23:14:53 +0000 (UTC)

--===============7853177006825531859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Stack depth statistics list captured depths in subprogram-number order,
> while per-verification instruction counts are reported separately. Since
> libbpf determines subprogram numbers, it is hard to associate either
> statistic with its subprogram name or see where verifier work is spent.
>
> Now that self and inclusive instruction counts are available for every
> subprogram, keep the combined maximum stack depth on its own line and print
> one uniform record for each subprogram. Represent the main program as
> subprog 0, then classify each record as main, global, or static before
> reporting insns_self, insns_total, and stack depth.
>
> The aggregate processed count is the sum of all self counts, while each
> total shows verifier work rooted at that subprogram.
>
> When no subprogram name is available, print <unknown>. Keep the existing
> aggregate "processed ... insns" record unchanged for compatibility.

This isn't a bug, but does the middle paragraph add information beyond what
the diff shows? It walks through the implementation (keep the max on its own
line, represent main as subprog 0, classify each record), which is visible
in the code. Would it help to show the new log format verbatim instead -
perhaps one example record - and note which consumers had to change for the
format update?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31647029137
--===============7853177006825531859==--
