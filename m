Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2C281530;
	Sat, 19 Sep 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815482; cv=none; b=r274ONpHQaKa9lZ9rz8ZfL8eJXfBe1C5LWz+gVfzhNXiTdm1VsJXZ50RxmZpMm9uakUcob/eDO8UT32oAn6PcWD8K4ZXncCobMo8ZWUcyNP6jdagek7qNcWDZt7wpACDhCsnzfNSevLkgNrEAiqpMsoBc2qNgosH1Sxzew7+ZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815482; c=relaxed/simple;
	bh=O66Ddnin0NrYLgPf6080/FEMaa+pY5dOraiZFngezSw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=avsH9biK/r8N1RDkO17k5cvu76NhhABI76Cy66Adt9cqQCJTTqI2K1SEDiQLD/myAEVCHtTRzEdytwy9n6+MXHJsqKgTGa/8MVZn8ObIO5x14YMMzCUhcicY0S+QIZIyN+Bo34WM4JPerUZgXrAnj1WAWTKvK3vho45xMCmdfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/wfIR8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/wfIR8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA081F000FF;
	Sat, 19 Sep 2026 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789815481;
	bh=hlPNWe+iWajzl3rpQqt1V1/AK44NKXbxvA6HMwoeyiA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y/wfIR8Zrmv3Zsz8QJZkdC66EVeqzYXV/pAnaWacKBiE69n/Q/PQ/LO9XJNniV+VA
	 pyFkhoqLB/j90m9Uhh5wQjvHHVYgR8lphN5ra+DS0gIFuB+hDrOXMY+3OiO7JITfTO
	 hBsi8JxGeTtSY/uNqeqnCqbP6I3ncc+YAey/5iMHMcjAI5dAnyDOyOueIdrnPvmaX9
	 dfCOHc2lzE4jh+Tc1Hy2YTE2nd5fc+X9AECshbC0+4CWe7yGzlhWejGNhpwjbvXglp
	 BJZZo55Ji8GnRwLkl/PO/ngJlqhEOM1dSRyMlyWfMf+7yBh8n63pD+V8/cXTMIxLg1
	 Juw+Oa45byxtw==
Content-Type: multipart/mixed; boundary="===============5809020601564181977=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37ab572f42c2abce9da0be55593f6b3f81596e4e06d6a8597e71c18d88ffb3c3@mail.kernel.org>
In-Reply-To: <20260919094400.600585-2-sh_def@163.com>
References: <20260919094400.600585-2-sh_def@163.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Report BPF_F_PREORDER in cgroup program queries
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,qmo@kernel.org,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 19 Sep 2026 10:57:58 +0000 (UTC)

--===============5809020601564181977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit a51463b14defa13db013ab6b988af5e53ffa136f
> Author: Hui Su <sh_def@163.com>
>
>     bpf: Report BPF_F_PREORDER in cgroup program queries
>
>     Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
>     introduced BPF_F_PREORDER to request pre-order execution across the
>     cgroup hierarchy, altering the effective prog array ordering.
>
>     While pl->flags stores BPF_F_PREORDER for each attached program,
>     __cgroup_bpf_query() currently does not report it. When querying
>     attached programs (!effective_query), __cgroup_bpf_query() fills
>     prog_attach_flags[] with cgrp->bpf.flags[atype] for all entries,
>     omitting the per-program BPF_F_PREORDER attribute.
>
>     Extend direct cgroup program queries to merge (pl->flags & BPF_F_PREORDER)
>     with the cgroup-wide flags when copying prog_attach_flags to user space.
>     Only BPF_F_PREORDER is extracted from pl->flags to ensure transient
>     positioning flags (such as BPF_F_BEFORE, BPF_F_AFTER, BPF_F_ID, or
>     BPF_F_REPLACE) are not leaked to user space. Also perform both ID and
>     attach flags copies within the same hlist iteration.
>
>     This extends prog_attach_flags[] with the per-program BPF_F_PREORDER bit.

This isn't a bug, but could the changelog drop the duplicated sentence?
The paragraph starting with "Extend direct cgroup program queries to
merge (pl->flags & BPF_F_PREORDER) with the cgroup-wide flags..." and
the following sentence "This extends prog_attach_flags[] with the
per-program BPF_F_PREORDER bit." say the same thing.

Also, does the line "Also perform both ID and attach flags copies within
the same hlist iteration." add information that isn't already visible in
the diff?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35436378806
--===============5809020601564181977==--
