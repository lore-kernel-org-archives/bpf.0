Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697B3F44FC;
	Thu, 17 Sep 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635628; cv=none; b=NakrexF0V1oVqBs6f3j6rjfGnCFpb1PFTt4ZcMxFprU9RU8Rr64iLFN0Mrm6pY7bH0VlgZBt4e+y2KOZ4+pIr0UdeVWOnp5LW+ZNFr/iF003GKkuiaKV6pEd7N3E1VWZGUmnXBKuBfThPWDYQXc8s/FcKsCzLJVfHk/v6Jo6NQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635628; c=relaxed/simple;
	bh=Y5bSJVysvr9ddQz4rfopfu0hHQ1wIqTnyODV0L3nxM0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RpkVyKmJn13aUq7pxBpgvtRVpVgdvuzFCzZ92jBIBc4iMjrC17Vn6XQNdTqE2mX2B/6MxN2ZgoL4XI5paW2wcxEGADzNJ2I9vKMPKbDH6EobkNcOYpXPw/6U7DPjrkWpy1YfHx3LEHQYq6TVsxcq7sj7Udvai8TI2t8CP6jAf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg1bdiFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg1bdiFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB3C1F000FF;
	Thu, 17 Sep 2026 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789635627;
	bh=G3cWCrQW8tliOjWvk/U88u+h7FNtLXaFA7KtU9Vk1E0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Xg1bdiFO3MxUqftaFIxMcl2cc5az3in6IBLWAl2tn1XvzSZa3qZN59HJAB45B1ZRW
	 xU6UOENwYGWC2SRiyFk1+q0fxSaYbgT2D3T+5rYmiKPK7bTuLcFEAvKgRQj8v8lkvf
	 njOQA2IrD2zjkiyoboWOe/mGJqt+Kbm6ternkZ/oEJ5KDLb03kK/hAcjVvpanZ8UjN
	 JrtXSILtFMeMu5Oe2IurTA0JY5vJNR6l2fzwlsgfmAKaAg4dcqbIr/92fVyLVZ8eMn
	 AEup1d+Ofbjsu26cK3TzxhVB8PAZB/UdPRWpS7JrGhS9ZylO4dgGF6mm8HDBtJ5B7p
	 bYXHVjkOapazg==
Content-Type: multipart/mixed; boundary="===============2675516372883015014=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80c4a1ad857e4007c54a10110ff85897791545942a2cb3be4d9f5e69cd17de82@mail.kernel.org>
In-Reply-To: <20260917080839.462038-2-luyun_611@163.com>
References: <20260917080839.462038-2-luyun_611@163.com>
Subject: Re: [PATCH bpf 1/2] selftests/bpf: Fix timing-dependent assertions in task work stress test
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 09:00:26 +0000 (UTC)

--===============2675516372883015014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> task_work_run() assumes every stress run observes both scheduler
> contention and, when the delete thread is enabled, cancellation of at
> least one pending callback.
>
> Neither outcome is guaranteed. Contention is observed only when another
> scheduler selects the same one of 128 map values while its task work is
> outstanding. A valid run can therefore have no scheduling errors. This
> was reproduced with a single scheduler: more than one million callbacks
> were scheduled and completed while schedule_error remained zero.

This isn't a bug, but would it read more clearly to say something like 'the
task_work_stress test helper' (or name the file) instead of the bare
task_work_run() in the opening sentence?  There are three functions with
that name in the tree: kernel/task_work.c, prog_tests/test_task_work.c, and
the static helper being changed here in prog_tests/task_work_stress.c, so
the bare name could be mistaken for the kernel function on first reading.

This isn't a bug, but was nthreads reduced locally to get the
single-scheduler run quoted here? The test hardcodes 'int nthreads = 16;'
(prog_tests/task_work_stress.c:50) and the only environment knob is
BPF_TASK_WORK_TEST_TIME for the duration. A reader trying to reproduce the
quoted numbers has no way to get there without editing the file. It might
help to say so explicitly, or give the 16-thread numbers, since the test
has no knob for the thread count.

> Likewise, a successful map deletion may remove a value after its
> callback has completed. delete_success can therefore be nonzero without
> callback_success being smaller than callback_scheduled.
>
> Drop the assertion that schedule_error is nonzero. Keep requiring exact
> callback accounting when deletion is disabled. With deletion enabled,
> allow equal counts but still reject callback_success greater than
> callback_scheduled.
>
> Fixes: c6ae18e0af5e ("selftests/bpf: add bpf task work stress tests")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35199472874
--===============2675516372883015014==--
