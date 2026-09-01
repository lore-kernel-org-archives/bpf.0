Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC01376BF2;
	Tue,  1 Sep 2026 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234846; cv=none; b=NvPeKqeRqqDAWV5ibjRVciTAZf3CXRM3h/VD9BV2AYFk4OdNnkHkaMcBaNOVY6TZShcuBEDbjpXtwBzvMLu3AJx5FFk8gTrW3khU0M+u0DxgULI0l/Xm/VJr9Z+QgEo8s1ZR9JUn1rBqAY4oYPjs/9i1yxhkxtovGkUUhIRXkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234846; c=relaxed/simple;
	bh=/uxmxuNW7ubkuJFiuo78NaWw1A1Sedf0WeMPwM+xSXQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UKw3VuivMlAq+yWNPSuae8L7ax6Iv0AWKVZEwgivKSng672bo6v6I05Tj4SDMH3wuzHvNh3Qp+aN7Aoewz0MRAStNICJu5JyQ0vsbMaTFpccOHGSdq9gbIK9R4qBb+zVlXpLjEcC3LiRapIr5hP06sdUk+SGsXK++ZRUNRvl6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc7WPqlu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc7WPqlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A4A1F000E9;
	Tue,  1 Sep 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788234845;
	bh=ntS0fZGAsm6fdN0hTsYejHV1IT4J1Uj9379eTHdJqi8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Pc7WPqlu6rermf8Ip7fEVTJcOkyrnErbbfWVHbZJXHxhN3gE7YFtEqpWU61XLgbKl
	 mMCFXXtGTc6NnWPV/A2slkTV/ycrB01kuxjUIcj7cyERfoddYWFs2mVPB8ZrtIdN+i
	 Q+buDZxhzhj9Kk1rPF1Bn2JlQnmXdpRtdeJcqV0+h/sDgrRLYyXDj1vCfaa3fETFzn
	 lH/HLPPnEscmpcjV4Mvkr+FH7d/lNZ44IAef+tNUJff8cAiX3Dt5mdM1A+dQlhjRDb
	 z3hx9lua6tpc9mcORBf9sC0ac7lq751poc3UjPzxDbLrtGrg1UaZg+wVTpaBsJpexQ
	 1ELFnFvwLV3iA==
Content-Type: multipart/mixed; boundary="===============3705014121917840339=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac57ae5abecf982961cd6baf346e19884a44be78430b563b781940b625559684@mail.kernel.org>
In-Reply-To: <20260901024038.730424-3-cui.tao@linux.dev>
References: <20260901024038.730424-3-cui.tao@linux.dev>
Subject: Re: [PATCH 2/2] sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe
From: bot+bpf-ci@kernel.org
To: cui.tao@linux.dev,tj@kernel.org,void@manifault.com
Cc: arighi@nvidia.com,changwoo@igalia.com,michalblk@google.com,liwanwu@kylinos.cn,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,cui.tao@linux.dev,cuitao@kylinos.cn,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 03:54:04 +0000 (UTC)

--===============3705014121917840339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> cgv_node_less() compares cvtimes with a plain <, which breaks once
> cvtime wraps. A weight-1 cgroup in a hierarchy summing to 10000
> advances cvtime at up to 10000x wall time, so 2^64 ns of cvtime is
> weeks of continuous saturation away -- unlikely but reachable on a
> long-running host. At the wrap instant the plain comparison puts the
> wrapped node behind everything else permanently.
>
> Compare with (s64)(a - b) < 0 instead, as CFS does for vruntime. A
> cyclic comparison is valid as an rbtree comparator only because
> cgrp_cap_budget() clamps every node to within max_budget behind
> cvtime_now, so any two nodes are far less than 2^63 apart and the
> cyclic order agrees with the true order.
>
> Compile-tested and smoke-tested in a VM: weight distribution and
> dispatch unaffected.
>
> Fixes: 7b742aa2c2c9 ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.dev
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Is the Fixes: tag correct? The tag references commit 7b742aa2c2c9, which
does not exist in this repository. The bug was actually introduced by
commit a4103eacc2ab4 ("sched_ext: Add a cgroup scheduler which uses
flattened hierarchy"), which added the buggy plain comparison
'cgc_a->cvtime < cgc_b->cvtime' that this commit fixes. Should the tag
be:

  Fixes: a4103eacc2ab4 ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33465241568
--===============3705014121917840339==--
