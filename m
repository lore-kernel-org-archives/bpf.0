Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B11F936
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769915753; cv=none; b=igJMiDfWf3Oyqqmd9rFmOEpKhRGGj0f5rhC6MgsaMHJUJfr+fCgDR9n2oj9aAwWBIYg4wal6dX7vl/ccM1FhtihPeYk0AgzNhWqksGFSeVQ5t5mgBTKxNf8q7mgqNs7QQX8qrCU9I+LhPqRux/jnBYix3TUQCXMapvXZXIk7NTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769915753; c=relaxed/simple;
	bh=1j8dU1uZSpaRJswlUu14zVOSUottz6REZ/Q35EJLPvY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RYYuiTv+2k9uELxB/YfCyySgaIGmxhXL308DDKNJPArOnmWQvJ48CgwwKEUvgbxtx/itCWru8Sot1nFeFQ/lFSUKKissKmSbk5+Fr1himHSSGDRL671ei9O0o4Wfw8tvW4K+IBbpOGdCThYvaUFNBiiogvU5uojyTcCC3OftpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4gJ50s9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4gJ50s9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64399C4CEF7;
	Sun,  1 Feb 2026 03:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769915752;
	bh=1j8dU1uZSpaRJswlUu14zVOSUottz6REZ/Q35EJLPvY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=f4gJ50s9nalgXIV+q280pfYbi+z3mAhDqEc0QVeccOi8pzNuUljFK0qT2dOXnXOwH
	 8OM+iBqUVSvZMbXzvHmh2wSuiOBmMQ46/MpCebWQIjVk99PDAqVCpHnlxEXokaMzls
	 YXcJ0JSU7jBTutkkEhl/kn0sKJYlL9r0TUY1er6gdiCflKVzrf9QFtVZ0G1OVpr4hr
	 5Z9PeatlDW0Zwcoc/5iJazgQSOx48VKYUM1kpGF1fPyt9R5xrPh4IdoJWjge5g5jS8
	 ekRXWGhyb9lSv+P+TBTZK7d4sH8a9kWPXxM6RsCU++QeCeiQrX0lycDKGGqF55sjba
	 +/YiKQnNlLjrg==
Content-Type: multipart/mixed; boundary="===============3249749971315742781=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c4d5e47fcb6f3146bcee4590b3227f5d937060535b8e9a7f14a3208100b9c7b@mail.kernel.org>
In-Reply-To: <20260201025403.66625-10-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-10-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v9 bpf-next 9/9] selftests/bpf: Add a test to stress bpf_timer_start and map_delete race
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  1 Feb 2026 03:15:52 +0000 (UTC)

--===============3249749971315742781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/timer_start_delete_race.c b/tools/testing/selftests/bpf/progs/timer_start_delete_race.c
> new file mode 100644
> index 000000000..2ff6357f3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/timer_start_delete_race.c

[ ... ]

> +SEC("syscall")
> +int start_timer(void *ctx)
> +{
> +	struct map_value *value;
> +	int i;
> +
> +	for (i = 0; i < ITER_CNT; i++) {
> +		int key = 0;
> +
> +		value = bpf_map_lookup_elem(&timer_map, &key);
> +		/* hey claude, no if (!value) here. The verifier got smarter */
> +
> +		bpf_timer_init(&value->timer, &timer_map, CLOCK_MONOTONIC);

Will this program load?  bpf_map_lookup_elem() returns PTR_TO_MAP_VALUE_OR_NULL
(defined in bpf_map_lookup_elem_proto in kernel/bpf/helpers.c), which requires
a NULL check before dereferencing.

The comment claims "the verifier got smarter", but I don't see any verifier
changes in this series that would eliminate the NULL check requirement for
bpf_map_lookup_elem().  All other timer tests in this series maintain the
NULL check:

    timer = bpf_map_lookup_elem(&race_array, &key);
    if (!timer)
        return 0;

Without the NULL check, the verifier should reject this program with an
error about dereferencing PTR_TO_MAP_VALUE_OR_NULL.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21555452257

AI-authorship-score: low
AI-authorship-explanation: The code follows standard kernel test patterns with typical C style; the unusual 'hey claude' comment is more likely a developer joke than AI-generated content.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: BPF program will fail to load due to missing NULL check after bpf_map_lookup_elem(), causing the test to fail silently or with a verifier rejection error.

--===============3249749971315742781==--
