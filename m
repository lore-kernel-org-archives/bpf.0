Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7900412265
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934721; cv=none; b=nJD8of/x8MSRXeL9LIQBgW57hQ8ALf3I5NGNYP3Ng6XQtKmLTWX7w6Sec+0ucXTY0T7offz3m7l4cGWZtkBa/B8/f7LIQXCXBi9fKNLjyUcSc2tvPpQb7TW0rk2NUeqJOblPOtB/fJP279t27jyRjqzDbdBwXZ2KPxU9b13XcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934721; c=relaxed/simple;
	bh=/rbyr+f41ZZk49yKmeqLJhBQlPhY5MIOJbcdI0In9mY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T3AjrUH1GF3Vv6QzuPKXmdzm5xgvquvYYKKC4NoqAZLcsbgStkyjppOef1U2eAZ70yfZBBvzwMs4vGuSxroXMVyaw9fbVvDgQN4wDjFewjgzGt/d9MdveLMrlE94iJXqwsAERtxhdSmukQRw/cbRXNwiJepZ7AlUD+GbGysTyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTwVfD0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTwVfD0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF5B1F00A3A;
	Wed,  1 Jul 2026 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934720;
	bh=5zIbOORH2A8+a3iuJ+5cZ3zW6+JNEpGg4Xz3u9B1ZDk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DTwVfD0CeJz2L9JNrJ1YxMSjBva2HGyEn6VI4V8hjrVrEahem1+VibO4qFlrhgl4p
	 0aWnQNRXmq4fyNeBASrXdxgGu81cvP7fALkGxUKT4pDL+OO9pBrwSmL0nQ8vvwHis5
	 y5pfg65bMIpksnsYN8I/InqJNKqmc6v9++xwPORs34AQQ9Ta7ZovKYWIROiWRxjl9R
	 y/8Puj0ksJ+W/OJm71mT9lR7ClHx9TfUzD1c1bynEva5bfU4/Z6tJLzHUg+X5gbukk
	 4Ip+41fuPfUAjpO8xENPzRaSCjVE83jyJz/00Ywni3Gzd/2ga7Au9EfHhpGXnhzGaM
	 aDndnMkSqDR+Q==
Content-Type: multipart/mixed; boundary="===============0567606514854086329=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c4b56704d686ce2c0a944b0726914b06a593620812d129573855a7d89c9ce646@mail.kernel.org>
In-Reply-To: <20260701185235.4516-6-emil@etsalapatis.com>
References: <20260701185235.4516-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: libarena: Add parallel bitmap selftest
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 19:38:40 +0000 (UTC)

--===============0567606514854086329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
> new file mode 100644
> index 000000000000..5381deeb8d37
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +
> +#include <bpf_atomic.h>
> +
> +#include <libarena/common.h>
> +
> +#include <libarena/asan.h>
> +#include <libarena/bitmap.h>
> +
> +#define TEST_BITMAP_THREADS	2
> +#define TEST_BITMAP_BITS	(2 * BITS_PER_LONG_LONG)
> +#define TEST_BITMAP_WORDS	BITS_TO_LONG_LONGS(TEST_BITMAP_BITS)

This isn't a bug, but TEST_BITMAP_WORDS does not appear to be used
anywhere in this file - could it be dropped, or is a use intended?

The sibling serial test (test_bitmap.bpf.c) defines the analogous
TEST_WORDS macro and does use it as a loop bound.

> +#define TEST_BITMAP_SYNC_SPINS	BPF_MAX_LOOPS

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28541348016
--===============0567606514854086329==--
