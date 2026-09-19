Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351D3438A6;
	Sat, 19 Sep 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814597; cv=none; b=R3WHOBWosRJKpmh0kAzrgly5jhRWAlJXwIVfqQn2z6xRkTZrWvS/QtH76tYRdGuVl/56MgcoK7+nJ+GNsOqgHSq1YkgldCy83/MjC2jL2/zobltOMLnHfshezLerpYQRRvMCb5eKFnq+qucfE9Wd8kZaeuLIVXTqAi/tUebJ5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814597; c=relaxed/simple;
	bh=dgTgQZuSGCt27GrZO7/eEniEK2PyqEnXZfYU3IL/qEo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R9+8vhMrsJIhSri0nZtOP0BTC1kIAschw9emprTro93KK7FRiAml/QsaeGgfDhvkyBWiezzV6LhHpbyUQBkoAbeqx3znRynbEqwRPcch9g1IkikJv2LchbYkMU7SK2gG+REsMv/ImcW0HlXaeA1Tf/hMTTg80Ie9JoLAIOkODWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4iTkmF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4iTkmF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B41F000FF;
	Sat, 19 Sep 2026 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789814595;
	bh=YAy6E09Huafs1BZ4r2dxcmdePbcD9YhFn5TJZuZlx+Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H4iTkmF5UUeeBWjmDatsKh7TuoBwNov25RxC8MFK22p3PesTLquthBspiQxwqy8iU
	 wBU9DMAgLNRGjC3Nj0rp486ZdU9k8o1X5hl0R4uqfzQPu2iH44CL9wJOoq6QWNQAAG
	 AnpXGQG8iSij6edThgr/gKE6KUJGhvECtUclguf8iZRHQAFKqj6q3zsu5C70nurq9p
	 J5MwgvUTraf5+AtTcTpaPRPHKSpcqNtGb7/4mf27WZqbpeyAG/NnTegyL/XCiZSCKK
	 S9zJ4DXK2YcrhHbrL16PBEJZnBRCkKkcbRg3Wwjk2IiDA9xOHXPMRmS7jJgvTZ/w2Q
	 2CqpwloVkQgEQ==
Content-Type: multipart/mixed; boundary="===============0490980660097680328=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f45c182798066473dcd807ce86590d80bddab5d5790b711f48ff2f4e1fb55d9a@mail.kernel.org>
In-Reply-To: <20260919094400.600585-3-sh_def@163.com>
References: <20260919094400.600585-3-sh_def@163.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,qmo@kernel.org,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 19 Sep 2026 10:43:13 +0000 (UTC)

--===============0490980660097680328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
>
> Extend cgroup_mprog_opts selftests to verify that BPF_PROG_QUERY reports
> BPF_F_PREORDER in prog_attach_flags for both direct program and link
> attachments.
>
> Specifically, add assert_preorder_query_flags() and use it from
> test_preorder_prog_attach_detach() and
> test_preorder_link_attach_detach() to verify that:
> - Programs attached with BPF_F_PREORDER report
>   BPF_F_ALLOW_MULTI | BPF_F_PREORDER (0x42) in prog_attach_flags.
> - Programs attached without BPF_F_PREORDER report BPF_F_ALLOW_MULTI (0x2).
> - Transient flags such as BPF_F_AFTER or BPF_F_LINK are not present in
>   prog_attach_flags.
> - Per-program attach flags are validated by matching each attached prog_id
>   via a query helper, avoiding fragile assumptions on the internal slot
>   order of the direct query list.
> - Failures during prog_id lookup are guarded so uninitialized flag values
>   do not trigger secondary assertion failures.
>
> Signed-off-by: Hui Su <sh_def@163.com>

This isn't a bug, but could the last two bullets be dropped so the
changelog stays on what behaviour is now covered, rather than describing
how the test helper is written?

The first three bullets state which behaviour the new test covers, which
is the useful part. The last two bullets describe how the test code is
written (a lookup helper instead of indexing, and guarding the lookup
return before reading the flags variable) rather than what kernel
behaviour is being pinned down; that detail is visible in the diff
itself.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35436378806
--===============0490980660097680328==--
