Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15F42E8DD;
	Mon,  3 Aug 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780954; cv=none; b=D1gnOXxm1BE0JacjwioOz0cdBmyEuzEpPk5D0Gy7eZr+HcVCzENChvXqk7F0R6IH07M4kh8wa/PpWPmuwAvaVW8ESQc7epZsRlhmi3MgMjplZdHZg9jid8UWSAVZ1lnJ33/mrNyUuu+gnkzbiiQRytgRJiMVJZzvHC1REXSX7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780954; c=relaxed/simple;
	bh=elu1s7vvW+yiXfGfDjfArqk3RwrEH1vvWa3P1kl4Z4U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SLYYUUGM9Taq/w7D1Xk3eAlFjNwm8MrJA2FyZ1qwE25Av63Yt/TdsdZBNECTcYAwGCITvffdNoj5mulUbxhOnDleDDEG1V36FYMofDA6XHWKRizyoSYiTv7EZQ3Km1Yr7IG0XkUINkL7BS/+RwNtN/aRXWAagl9ccexuyGg/ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UErrz7Tf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UErrz7Tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0936E1F000E9;
	Mon,  3 Aug 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780952;
	bh=eSzHunHQS6m9lXVlqQRETGUzvCWPCioDjw6tcWMfIl0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UErrz7TfKbIi/yCNiNZo+YVoimPj4aJNIN9gUoaQGTwoyO7/GnThxxV9MIMamrGfd
	 V+Sr58KE58mq2qbnPn/YX4GDvqQXfmKvksqfI0w7eXZUml8euB3J+ihZRQy1fY3IsW
	 TO08nIX8Der+gH2ijw4PUJSlvK4PHQJubiKmZN42c3tC4bgdBvGdjV93wRGvAmW/s0
	 GPtvHtGqVq+ekcPLxN/CupQ7C3JuoOjSSnDdhwKQL/gdbVYzaRpJObstixhphwBA7u
	 y1lYhJ2pPRY9FekiaVlRJ4pBDAhxR49WkIAuDkoSdtX+UXTacKRjfjwucpiaMpqatR
	 LOtGZNC5Bs6hA==
Content-Type: multipart/mixed; boundary="===============6064087784089355037=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3942d6763816245bb6610aa892f1251aa5ba08a9a698a6646e3ebdb097df33b@mail.kernel.org>
In-Reply-To: <20260803170251.1898102-3-vineet.gupta@linux.dev>
References: <20260803170251.1898102-3-vineet.gupta@linux.dev>
Subject: Re: [bpf-next 2/4] selftests/bpf: add --no-error-summary to skip end-of-run error log dump
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com,andrii@kernel.org,ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 18:15:51 +0000 (UTC)

--===============6064087784089355037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index aa06bab309665..8ee46745e2e85 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c

[ ... ]

> @@ -1686,9 +1696,12 @@ static void calculate_summary_and_print_errors(struct test_env *env)
>  	 * We only print error logs summary when there are failed tests and
>  	 * verbose mode is not enabled. Otherwise, results may be inconsistent.
>  	 *
> +	 * --no-error-summary only elides the human readable dump: the walk
> +	 * still happens so the JSON report keeps its per-test results.
>  	 */
> -	if (!verbose() && fail_cnt) {
> -		printf("\nAll error logs:\n");
> +	if (!verbose() && fail_cnt && (env->error_summary || w)) {
> +		if (env->error_summary)
> +			printf("\nAll error logs:\n");

Does the comment match what the code does?  The comment says "the walk
still happens", but the guard now requires either env->error_summary or w
to be non-NULL.

When --no-error-summary is passed without --json-summary, both
env->error_summary and w are false/NULL, so the entire for loop at the
bottom of this function gets skipped, not just the human readable output.

The walk does happen with --no-error-summary --json-summary FILE (where
w != NULL), but not in the no-JSON case. Could the comment be more
specific, maybe "the walk still happens when a JSON report was requested,
so the JSON report keeps its per-test results"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30836252778
--===============6064087784089355037==--
