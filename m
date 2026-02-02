Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5672627;
	Mon,  2 Feb 2026 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013346; cv=none; b=i6Ev1CMk0g7D+fnox0cJU3sLU4SVMXkMHxaPY1qBnl5CN+8RljXnXrU6XZC3pYRYcIgRRN6c/YyrahGTqS5K8UGZJbXxKoCfgWEZ++C3ZzbwfKtvSckGYfG+wLyyeuVx/jrOWspwHe2DbXibpU7JADENuOwGSYXrHzoHFnX6prY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013346; c=relaxed/simple;
	bh=zwMzfhHJGAKw2cmAd7pvV1ENYIncGKQYAdK74gEzNd0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=imTjXNdVpWmqAAXfrNyRU2XfoqROeheXCY+S3ldxpiTeoaoUwTyMBav3go/B3X4MPt/dcTcyplB7k2dINngMnEXJ4Sk4AZPq2vRVkU+5qZAY3z3N/JzVQ8WOCp6P7hpLE5nNckk5FNEs3TB+gw0EnjAMkz+WmWQtgSrfgabKakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UETQpXrP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UETQpXrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487C1C19421;
	Mon,  2 Feb 2026 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770013345;
	bh=zwMzfhHJGAKw2cmAd7pvV1ENYIncGKQYAdK74gEzNd0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UETQpXrP+C1QlF5X3NICnn/8eE1ghfvqOPf9L/lG6aD87VBz7aqMfTtPWSLMcr/2P
	 JUL9XvvvmFgLsrcLLK9NKgFPKxk1oYeQs46S6c0rHNiBC4d86gRCqZuGhTjua2+blY
	 9fQ5TqtGXt85esHUeVrBGMifIc8Dde54yTpIBR2ql0inpkctV8SEShihrbvD6KIYIk
	 w53X54Mi0DFeXG/QQ2UlSLT+wkwo6DeHEniowsq76Wju2bDf9V61CPXJ+5M+SIdD+U
	 ozbI8uUQgs4kUlu+NJbk82xhgK0rWjFx4SKn/yyq50jUfiVD1DKDHwoy/l+pxjePTN
	 Z54mPXT8QyXbQ==
Content-Type: multipart/mixed; boundary="===============4295231827347043963=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11436036837ea0930ac6e15165aab32d6d44bc29ac234b468fafa676fc02e864@mail.kernel.org>
In-Reply-To: <20260202055818.78231-4-pilgrimtao@gmail.com>
References: <20260202055818.78231-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH RESEND v3 3/3] selftests/bpf: Add supplementary tests for bpf_kptr_xchg
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Feb 2026 06:22:25 +0000 (UTC)

--===============4295231827347043963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c b/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c
> new file mode 100644
> index 0000000000..1345c7f441
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c

[ ... ]

> +	bpf_spin_unlock(&lock);
> +
> +	rb_n = NULL;
> +	while (rb_n && can_loop) {

rb_n is set to NULL on the line above, so the while condition
(rb_n && can_loop) is immediately false and the loop body is skipped.

Should this be something like:

	rb_n = (void *)1;
	while (rb_n && can_loop) {
		bpf_spin_lock(&lock);
		rb_n = bpf_rbtree_first(&root);

to ensure the cleanup loop actually runs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21579259592

AI-authorship-score: low
AI-authorship-explanation: The code contains a simple human error (dead loop due to typo) that an AI would be unlikely to produce; the pattern and style match existing human-written selftests in the same directory.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Dead code in cleanup loop prevents node removal in a selftest; test passes but does not perform the cleanup described in the commit message.

--===============4295231827347043963==--
