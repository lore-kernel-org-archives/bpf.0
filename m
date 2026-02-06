Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C053451B0
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364247; cv=none; b=gPzDsheaM0eXFjOafL0zDI+BVQhpVGGsB8GQXIpuKWnBvJ8aoyHRjdYvcExdyxUYJcr1uNywZ6HRA0RJELmCzXW9ugVLdLhx0jzDgpdF8T6d1EJ7P8VY/N2v2kppmcXw/vrLysC26uzl0N2zHKSk1P6Bwb1ARhZWnk7qLw32Vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364247; c=relaxed/simple;
	bh=SFP4sJHwnl1DbYhn2aZFRVOheIiitofgoOm27F7yVMI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NTDcjxe7vM+fJ47xttZ84xxxmE1tTrJKPcZ0CJPVnruDVB0bRjkIAhJZwJRo+GNY+vqbUdrdtHmlt5Hj/42rk+BnPn/zJ3v3CmIgqfbOB8LcsK09tRH1L+fUTyFEC/yWzlTO2wGV1h1Zc+h6qBqHGwF8an6WpXgKJ5n9dkMPKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6KsvTcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6KsvTcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631AFC116C6;
	Fri,  6 Feb 2026 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770364246;
	bh=SFP4sJHwnl1DbYhn2aZFRVOheIiitofgoOm27F7yVMI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=E6KsvTcrWqXw3CXyaxg+X+1HG+w7NSTvIhP/Wy65LBt0GT95yomu1464y5Mu9eAft
	 58bXqjFmh80SXBXmuUI3RWGMuN+nUzv3JJYYXvtCcn/YTBH7+Oiau+9ok6fBGreETG
	 nanVJOetjBEAAwFwBsJzZ/jQ4qbKbucNC8ukDTSHTVDP0/wGQLBGiPHS0FZ/dOd4zV
	 ozHAtvvfiNCMlnFgtbBRPoUR2iMOaWBwQWDKlHwhSLfZSl5orhHamRCODW2yR6VJk8
	 5DgK5DFDVg3Gai73t/s7pe7KzLK7BfJbusVFvHM57j0eFRFEDRU1/4/c1YjVGqMiMh
	 Cfm3aocXuCqAQ==
Content-Type: multipart/mixed; boundary="===============6488421621599741996=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ddebc81fe2a7d80441d6cf3d27bf6973a4d0a233d6fdbb332d09700775d7f86@mail.kernel.org>
In-Reply-To: <68AC3CE38AB1BD07+20260206071357.4075301-1-xulang@uniontech.com>
References: <68AC3CE38AB1BD07+20260206071357.4075301-1-xulang@uniontech.com>
Subject: Re: [PATCH] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
From: bot+bpf-ci@kernel.org
To: xulang@uniontech.com,martin.lau@linux.dev
Cc: ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,dddddd@hust.edu.cn,dzm91@hust.edu.cn,hust-os-kernel-patches@googlegroups.com,kaiyanm@hust.edu.cn,sdf@fomichev.me,xulang@uniontech.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  6 Feb 2026 07:50:46 +0000 (UTC)

--===============6488421621599741996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 55b1614b50eb05449d35281100cacc591d1aca3a
Author: xulang <xulang@uniontech.com>

bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim

This commit fixes a use-after-free race in the BPF cgroup shim handling.
When bpf_link_put() reduces the refcount to zero but before the deferred
cleanup runs, another thread can find the shim via cgroup_shim_find() and
attempt to increment its refcount. The fix uses atomic64_inc_not_zero()
to detect and handle this race.

This commit appears to fix a bug introduced by commit 69fd337a975c
("bpf: per-cgroup lsm flavor"), which added the bpf_link_inc() call that
could resurrect a zero-refcount link. Should this patch include a Fixes:
tag?

Suggested:
Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21742563414

AI-authorship-score: medium
AI-authorship-explanation: The commit message uses markdown-style formatting (backticks) and has a structured, verbose explanatory style that is atypical of kernel patches, though the technical content is sound.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing Fixes: tag for a major bug fix; the fix itself is technically correct.

--===============6488421621599741996==--
