Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF942588A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138812; cv=none; b=D16GKvKmv0G6ia7e8mnRma3JyLPmq5fAajieZFkBrzT2d9YiopTBSee7rQ39QSFg6TQNk6mPomO64z7XhV7FEqjEl8ESLca49lhBP5qUf1k6PibsebiTp0+Jnsa0BWH8cjkfu/r6ORguvglRyRsYYldvyzvRiOO/ElDDxpOiN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138812; c=relaxed/simple;
	bh=D2adfgaG2jNrgdw99QhEx5eBLI1fPru+xT5lFZUj3/o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WjsaZDujAHmgpALudQWKKyRXhcGOVC/+STc4wzdrmxKQPROVR9z8o+y16orWZQl/xQcoT16n1WroU/vVtOX82FTiPmS1bemh8MFofI1bErWVVhzvGldyeh5hUZYduOulL7OsOQp654uXSlohZpoe09WFcYb8YcW/3czpGif75p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYUi7qHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYUi7qHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A75E1F00A3D;
	Wed, 15 Jul 2026 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138805;
	bh=sf7sp8M0Q4uvzE4JnPzCHhgb8sIG7WzwruWfiEjgNt0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BYUi7qHgVz1GH8+LFsxCaHbXJwfOnaf5U3j/15iOIILqL7XKhzDOOKZkB8afgMWyB
	 O1F0rQjWdzcqPwYBk5aBFtey+ZkmNc/JUoIXDlNJuIN6iUXUCB/I5OuUuAUCIsjTpB
	 dg3MRCyn4pOr4/mr4BGVO/gumIr6fmlr5LNUb9wOQCocZIkxyZ9r875sZAobRGZN2G
	 Cs0V1o1VE08kwAJCkQXOUxmCML7gJUMbKXBTNMuHY1h/MmvJ7UN+53oy2SGB+YTuiK
	 ONS78827JlHYuRzgnwFbNffrYsKkghIC/qeVIV33PVVoUx1zebpLuNRqaUSz2uT+bf
	 YjUU5A4MO1AfQ==
Content-Type: multipart/mixed; boundary="===============7053188643893630975=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4de40ae6ece9361c31cc7bfc3fca7c18ef49961e0f70beb9fb8c2e8fe457697a@mail.kernel.org>
In-Reply-To: <20260715172127.2416388-2-ameryhung@gmail.com>
References: <20260715172127.2416388-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom filter map_peek
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 18:06:45 +0000 (UTC)

--===============7053188643893630975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 54799fbcec7677972df927e8da6804b0cd39495d
> Author: Amery Hung <ameryhung@gmail.com>
>
>     bpf: Disable raw mdoe for bloom filter map_peek
>
>     For a bloom filter, the value argument of bpf_map_peek_elem() is always
>     an input. Therefore, the verifier should not allow passing uninitialized
>     stack memory to it to avoid information leak.
>
>     bpf_map_peek_elem() tags its value argument ARG_PTR_TO_MAP_VALUE |
>     MEM_UNINIT, telling the verifier the callee fills the buffer. This holds
>     for queue/stack maps, but not for a bloom filter, which reads the buffer
>     as an input to test set membership and never writes it.
>
>     As a result, a program can pass an uninitialized stack buffer to
>     bpf_map_peek_elem() on a bloom filter. The verifier accepts it and marks
>     the buffer initialized on return, letting the program read back leftover
>     kernel stack memory. Bloom maps require CAP_BPF to create, so this is a
>     CAP_BPF-gated stack infoleak that bypasses the boundary CAP_BPF is meant
>     to enforce (arbitrary kernel reads are gated behind CAP_PERFMON).
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix for the raw mode handling introduced in commit
92ec8b1b6b24. Should this include:

  Fixes: 92ec8b1b6b24 ("bpf: Factor out raw_mode-related fields in bpf_call_arg_meta")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29436864141
--===============7053188643893630975==--
