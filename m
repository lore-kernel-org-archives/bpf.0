Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E94266B9;
	Fri, 27 Feb 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212591; cv=none; b=oUo6W+QDdd0mNvmz+be381GGBbXETL9N8cQY5vS8O//cwvcl0Z8UL2QV89Yv4W6Hyb3IG5yXRuJ1aemjLsmrPAcxqGTDJjkPCEj4r3+2Y7SnHvWAIkIw8G7nw+8pAQI8VpwwkQeRHtKimZAZ3aOgAOCc3ETT9QdoTZhUAGac1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212591; c=relaxed/simple;
	bh=zr3MEFsHmpOaOrCh9U8H6TaDxykfvb1qUFnmMAwRus4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Csb9901BaMma5hMh89HMbyHM9Mx4yuUOE5VOaK3gLzjMzBM/FHfowrwR50Tw8MYCnNvQLZcxU9vEeZemKWG6gS6r9Rl2adNorQ9l7GfIOamC47H9jstqC6HN1mSF8yGjub2EV1bKmOtSMJHm7zZkUKRZhhr1zAE3mzgEh8r5K4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwkDfxak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwkDfxak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A0C2BC86;
	Fri, 27 Feb 2026 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212590;
	bh=zr3MEFsHmpOaOrCh9U8H6TaDxykfvb1qUFnmMAwRus4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PwkDfxakGijozrS/FMG7tzuRZLR70UdMHMTAzHA0xunyAM8jPioYjULLXZYTxNplw
	 zb6VyUqYQhoZ/cfgqvk+EPu4RQ8dcKQgpcspWDAEwxEvyC/7W+U7ghC6pWNQEm/5YY
	 oJmoqVsdN4SVe9A3OArEwovwdJEXw0EU7uIk2AiXlqOqgac0dHGs2UsY9hWjKGl4WI
	 Z8iBwV8ZsATlWglkHBBLOGxuGi15ggrMMLMSqv5lwg11oCoVz++eOx2SMuowJLks6j
	 2sdv5jK4RDn7K8b0qbVU13lQm+XS2vdcHoqyYMtVyr+G3XwtLnsCPLyiRwVBHBl3FC
	 IOO0Cpl90AA9A==
Content-Type: multipart/mixed; boundary="===============2114275162068233192=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61beeb55df97b37a0512ef24fcd44a184d241bbd66e33d636adcc2b05b75fa8f@mail.kernel.org>
In-Reply-To: <20260227164037.84110-3-sun.jian.kdev@gmail.com>
References: <20260227164037.84110-3-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: bpf_cookie: make perf_event subtest trigger reliably
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,andrii@kernel.org,shuah@kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 17:16:29 +0000 (UTC)

--===============2114275162068233192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Make burn_cpu() take a loop count and use a longer burn only for the
> perf_event subtest. Also scope perf_event_open() to the current task to
> avoid wasting samples on unrelated activity.

The second sentence here doesn't appear to match this commit's diff.
The perf_event_open() argument change from (attr, -1, 0, -1, flags)
to (attr, 0, -1, -1, flags) was made in the previous commit
e93098f90837 ("selftests/bpf: bpf_cookie: skip kprobe_multi tests
without bpf_testmod"), not in this one.

Should this sentence be dropped from the commit message, or moved
to the commit that actually makes the change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22495307331

AI-authorship-score: low
AI-authorship-explanation: Focused, minimal fix with idiomatic kernel patterns and natural commit message style consistent with human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Commit message claims a perf_event_open() scoping change that was actually made in the previous commit, not this one.

--===============2114275162068233192==--
