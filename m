Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6E383981
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473703; cv=none; b=hqtf6cOrpD1gAqYLL+I85WkbVvTkbAOBM8dfRYvS0h3tOPAUEa3sOeq0npRkpevxRvPCaGio+IYlSfI58jOfjZ2KcS8MDF/cPJQACF2O22MopAaaLlx6tQkbw5GP9bBhI6KGl4ve9ObAhjUOHX94aHnWf81P5dsjbZ+EXRHwJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473703; c=relaxed/simple;
	bh=Ti5ASdp9a0hYH5FTW6VqjMdTUqkDqr38c4wrTDv8G1o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QsRZiB4cx5f54SlMjwigvyN7ZXYNrm6prhiI/XFffaNRq4NM59h0avAhDbeLjPqdFF4i43wc52628ajK5HsGr/eh89OJcfJ/eBvV/BIvaNyun98mBrdxE3dM0HotxLjrslb310yLrkYsyu4qfWTeyAicuJ6NVfZaiZzqwd7uNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXKgqCXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXKgqCXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4871F00A3A;
	Tue, 11 Aug 2026 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786473701;
	bh=oARnr8oapWqRb/GZTZnGS7BX4+3SkOt7RGOwWp9Ehtg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nXKgqCXDknYVblcD4MaeOWg77gV7dj47j3Q8CvK5UdvwkUFTBIL6vt24fMpOuLCHi
	 RNfGSPeuf+ckr9CQy2okn9gJ5wETFutRZsoedJf4te+6lEZY+sFvoTTd3u5QAHXBjz
	 0RZPChTdn/RUg9cYMafHa2dhNAt6oupgwANSgBbtI6qhxdeyXcKb8BqsHYtLbdxPwh
	 yids4VXj4ZbdwKTIaJD6xqd0MuQOFm+1gX0D4shdqknQD1UEBeZUVM72qaAZU4/+bT
	 OdAxFRB8A0Lplg56LPViukne0gnNdCGTVtBLR/5nPXmryj8NxAvWfDJrQqTVyKhJAI
	 zlGE6aWM7Ve7Q==
Content-Type: multipart/mixed; boundary="===============7677525394951880637=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b98af79fa5ac4a50f74eb67b30fecba06a9990d9483fdead77176412536fda0@mail.kernel.org>
In-Reply-To: <20260811-veristat-filter-fix-v1-1-b5b43c431550@gmail.com>
References: <20260811-veristat-filter-fix-v1-1-b5b43c431550@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: fix for veristat file/prog filters processing
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 18:41:41 +0000 (UTC)

--===============7677525394951880637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: fix for veristat file/prog filters processing
>
>     At the moment veristat filtering behaves unexpectedly for the
>     following filter expression:
>
>       -f !file/prog
>
>     The expression rejects all programs with name 'prog', and all programs
>     in a file with name 'file'. This commit fixes the expression to
>     exclude only a program 'prog' from a file 'file'. Additionally,
>     the commit makes empty filters like '-f ""' or '-f "/"' and error.
>     Here is the filtering behaviour compared old versus new:
>
>     | filter   | file | prog | old verdict | new verdict |
>     |----------+------+------+-------------+-------------|
>     | !foo     | foo  | bar  | skipped     | skipped     |
>     | !foo     | bar  | foo  | skipped     | skipped     |
>     | !foo/bar | foo  | bar  | skipped     | skipped     |
>     | !foo/bar | foo  | buz  | skipped     | processed   | (!)
>     | !foo/bar | bar  | bar  | skipped     | processed   | (!)
>     | !foo/    | foo  | bar  | skipped     | skipped     |
>     | !foo/    | bar  | bar  | processed   | processed   |
>     | !/bar    | foo  | bar  | skipped     | skipped     |
>     | !/bar    | foo  | foo  | processed   | processed   |
>     | !/       | foo  | bar  | processed   | error       | (!)
>     | !        | foo  | bar  | processed   | error       | (!)
>     |----------+------+------+-------------+-------------|
>     | foo      | foo  | bar  | processed   | processed   |
>     | foo      | bar  | foo  | processed   | processed   |
>     | foo/bar  | foo  | bar  | processed   | processed   |
>     | foo/bar  | foo  | buz  | skipped     | skipped     |
>     | foo/bar  | bar  | bar  | skipped     | skipped     |
>     | foo/     | foo  | bar  | processed   | processed   |
>     | foo/     | bar  | bar  | skipped     | skipped     |
>     | /bar     | foo  | bar  | processed   | processed   |
>     | /bar     | foo  | foo  | skipped     | skipped     |
>     | /        | foo  | bar  | processed   | error       | (!)
>     |          | foo  | bar  | skipped     | error       | (!)
>
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This looks like a bug fix for existing tooling. The changelog table marks
four behavior rows with '(!)', showing the OR-matching bug being fixed and
empty filters now being rejected. Should this include a Fixes: tag?

The broken semantics - deny filter matching on file OR prog independently,
and empty filters being silently accepted - were introduced when the separate
should_process_file() and should_process_prog() helpers were merged into
should_process_file_prog():

  Fixes: 10b1b3f3e56a ("selftests/bpf: consolidate and improve file/prog filtering in veristat")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31521742364
--===============7677525394951880637==--
