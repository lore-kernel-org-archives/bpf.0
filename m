Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532F22759C;
	Sun,  1 Feb 2026 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970170; cv=none; b=OOrY7YXCfl1ZU9YCKf6A3wH7iIKP4a9rou6AA/HOkbMpjKoxrFxmqg7QP9YPM7IBwIbhe60qCxMX6OMng59Itez2xeMLvB19g8PxQiNq5nzB/Rwfi3xz84B8vBB+iikCVF7Pjnu7jV60kp3ikHm8c1tfP7QtBnc4tD53o0sIkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970170; c=relaxed/simple;
	bh=grlXjdm8xmThX3zhXh4qR9eXyekhcJ8bFV4lxhv8hKM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EYLxW9diqXWh0X6kSFcIvjjL4AGqG0BhdAC/vMvpg17+M1a6Fgrhr/N8GB7akZ0yZJerO6yCaxiZA8wir3ljR4DhTSF786KL4CWj8xpRhE696DhouKCXy2XeLMrtJWHKZLh8bxmP61fOoRXOLQcNaWhU2nxU3Y7yPHzOHh198wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8+fFDWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8+fFDWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7443AC4CEF7;
	Sun,  1 Feb 2026 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769970169;
	bh=grlXjdm8xmThX3zhXh4qR9eXyekhcJ8bFV4lxhv8hKM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=X8+fFDWGKvmGL/kZL1a4RmRCl5FZ4L1eJsOUy16c+f9p/XvE5lgwFYLlVJYDEnn/F
	 jiR6NAa5bgJNSQozAjx205p1yaBerkmfPh/+E9Z0m6acTezM/w44gkC58KjNNrZ9ii
	 bkJi6VHBPy7uwRdiSb7cx6uofduFTfEPIqwoHbqPf1n8qJn3+jjoIJiNRVS6hX/U6D
	 Gt9WFjVNX1+2EFfLXk/Oa9/Q30ZX51gdC0uM0Ad0JjeEHLQm3e3QY0OnO54k3SoM6l
	 3JxlS+KHaiADCB//hGkGlpBzAwzpDz6ek9kIYVMxp4rkfNpu4BgTzxBFRhPnPvFV4e
	 F/6759iIg5X4A==
Content-Type: multipart/mixed; boundary="===============5808050125888543634=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <805211652ab5a5433408cf5070e41ea289611a908c1f1f3c2584ba0c334a9560@mail.kernel.org>
In-Reply-To: <20260201175050.468601-11-ameryhung@gmail.com>
References: <20260201175050.468601-11-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Support lockless unlink when freeing map or local storage
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  1 Feb 2026 18:22:49 +0000 (UTC)

--===============5808050125888543634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 5ca113c57e19a4ef0ccfc390cc9274cc9ff66abc
Author: Amery Hung <ameryhung@gmail.com>

bpf: Support lockless unlink when freeing map or local storage

This commit introduces bpf_selem_unlink_nofail() to handle errors from
rqspinlock during map or local storage freeing. It uses a link_cnt refcount
to coordinate between map_free() and destroy() when lock acquisition fails.

> Under normal circumstances, bpf_selem_unlink_nofail() will be able to
> grab locks and unlink a selem from map and local storage in sequeunce,

This isn't a bug, but there is a typo: "sequeunce" should be "sequence".

> Then, only when both map and
> local storage are gone, an selem can be free by the last caller that

This isn't a bug, but there is a grammar issue: "can be free by" should be
"can be freed by".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21567682421

AI-authorship-score: low
AI-authorship-explanation: The commit shows deep understanding of kernel synchronization primitives and BPF local storage internals with natural technical writing style typical of experienced kernel developers.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Minor typo and grammar errors in commit message only, no code issues found.

--===============5808050125888543634==--
