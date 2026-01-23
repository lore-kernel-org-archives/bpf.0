Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E930DEB7;
	Fri, 23 Jan 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188170; cv=none; b=Z0Wjmy2TbWMLYWrSC6cRwOo5sZIYz7UT30CSwUD2AmGlOMYOzDKL4Rj20mssnWnfVRcO7Ai2beBcN+2a22nUculOKkqH1owagZAb/iUe0dE5dv9dhU4d+oNz+vSNM+Aa5oLUcp3r5Crq6S9WRtNvVyMt+ryI7+fwCiHfV2pCQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188170; c=relaxed/simple;
	bh=CeNHOSkJEdn6xvj+Hw0timIRReycFapyLFz3DHpdds0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UYhqx+ZzFd03gLMXfN89T2WEcJw/HY2bZ06DnIisyCCIUZBqu9+cS/qIm0WjLtes93nS94izaGQYs2ZSpCycTrmCOsQBOapza34zyupVEvgEEahpMoPhwK0LmqdWMlaQT11XJbjvBgQjMV4V2SU5MUqH5lWs9SjgHoEKgNxhgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxsSx0+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxsSx0+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56037C19421;
	Fri, 23 Jan 2026 17:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188169;
	bh=CeNHOSkJEdn6xvj+Hw0timIRReycFapyLFz3DHpdds0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SxsSx0+n7xFHrUo+/nHJiNZAvHx8biTivOYcfBLp/lH4ogI4S2BrWqsgj914uaLMw
	 JbI/0nlENNqWUF+454DkmZZfJ9TALo0zg4XFDWrHkjgI5KWRX3M4663AhzQFlrJvUz
	 0MRee9svnvGHnUDhdYb9BvG4DVPbI4p+PgqH/gurByQ/Gjj/B/TjuLvjGA6jymnoy3
	 B8WDknHqfWbuMOUJgYKXLItF1N7vcZNdJEiOpA8MM+4gkLyHZCOl3ZPRdXlrPLYPSh
	 F0QG7mbtn9pLD8k3CCDmzxZr7tMhxps8EtQx2lTjmxW7CSutCDkKeKHGjLk2OT2isr
	 szKGewJwhyuWA==
Content-Type: multipart/mixed; boundary="===============1026584712408285938=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45de7914fd90da6c4940d1c299282eb40d5921ab1f3b9953a120e59a7a9f907c@mail.kernel.org>
In-Reply-To: <20260123-selftest-signal-on-connect-v1-2-b0256e7025b6@rbox.co>
References: <20260123-selftest-signal-on-connect-v1-2-b0256e7025b6@rbox.co>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for connect() racing sockmap update and signal
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,kuniyu@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,mhal@rbox.co,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 17:09:29 +0000 (UTC)

--===============1026584712408285938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c b/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c
> new file mode 100644
> index 000000000000..aa48ae483dab
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +#include "sockmap_helpers.h"

[ ... ]

> +void serial_test_sockmap_interrupted_connect(void)
> +{
> +	sighandler_t orig_handler;
> +	struct context ctx = {0};
> +	pthread_t tid;
> +
> +	orig_handler = signal(SIGUSR1, handler);
> +	if (!ASSERT_NEQ(orig_handler, SIG_ERR, "signal"))
> +		return;
> +
> +	if (xpthread_create(&tid, NULL, racer, &ctx))
> +		goto restore;
> +
> +	test_map(&ctx, BPF_MAP_TYPE_SOCKMAP);
> +
> +	if (!xpthread_cancel(tid))
              ^^^^^^^^^^^^^^^^

Is xpthread_cancel() defined somewhere? I see sockmap_helpers.h defines
xpthread_create() and xpthread_join(), but there does not appear to be a
definition for xpthread_cancel(). This would cause a compilation failure.

> +		xpthread_join(tid, NULL);
> +restore:
> +	ASSERT_NEQ(signal(SIGUSR1, orig_handler), SIG_ERR, "handler restore");
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21294285592

--===============1026584712408285938==--
