Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9CB47425A;
	Thu, 13 Aug 2026 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623217; cv=none; b=XDEFmYuKDRJhhgNFMbRQz9V9McR+IZPyVPO05yqI1F7lp4Z1k3Z+LYiKu1IPXxkt6UzF2Cxqh4jjqNRne4Yjb8DRgPpXl1UguYTTG/gNPHck+nvPM3egeszNz2UUs1vV8r8if11DgSlNuR4u6ziwHR0sdi7OJgqpu7jTXUxEjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623217; c=relaxed/simple;
	bh=OkYntXdjpq2GZpUJ6pZWPs4eNVQn8Rkx9l/GLVtrRZU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ilCIQKPS4ATvuGgPHlh9tVngKeYkmoUpxEU3h73qqzaiOJ5oYMg5ZlTNIfT4A4jI8aK8xQG1L5tjuZIhy99+fXnnIr+XjDsRK9dIOJ59+qutv1ML3XGLn+JB2iHDkcD0pCiUmaPMQ+bYF7svjoOZlxnrQBu4AA0Kmqgoo1RmHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9kvXIJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9kvXIJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512E91F00A3A;
	Thu, 13 Aug 2026 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786623215;
	bh=O9XNllzRWHFY6BLUVkQoy2RzuaRzCZh1Z8KvWCUMR70=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=L9kvXIJL/5LnAEjHUyT2ux1hbu2aqWILXs3HMBYW04FOwc1Y+8okhJzvzSVHpGyW9
	 TKYd7HEbydL2tN0aUc7UspZjYDWV79THT3u6ZD0Bo91djhhTz9pRFWJ2bGgJ/68avn
	 kprIkWntVpUoEIDY0nyEEr7FgQ439R7eUnarNIk2FBOVJsZyin6NHZ2h6MEiMbzBmR
	 8qdZll6w0lo8qUfR/NdNMiEuDVAIlPhzxV3vzwt+racwzBv884gU9KQVnTviyeF08B
	 3k5gnJSHCpBSNUBibs4McE1yfvzxtgP4VDEvVVBoCwSsRoDj6iB26Oj0kaeP65VYXY
	 kAQFcsT2OxMjw==
Content-Type: multipart/mixed; boundary="===============3497903013311219548=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0f93b51174ba64b1ce220ea0ef67b1eced238efdd66ed4a5960f3b2966a70e9@mail.kernel.org>
In-Reply-To: <20260813110540.103550-4-mahe.tardy@gmail.com>
References: <20260813110540.103550-4-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] selftests/bpf: Add ksock kfunc test
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 12:13:34 +0000 (UTC)

--===============3497903013311219548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
> new file mode 100644
> index 0000000000000..05d7b7424aee3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include <arpa/inet.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "ksock_lsm.skel.h"
> +
> +#define NS_TEST "ksock_lsm_ns"
> +#define RECV_PORT 7777
> +#define RECV_TIMEOUT_SEC 5

[ ... ]

> +static bool ksock_test_env_setup(struct ksock_test_env *env)
> +{
> +	struct sockaddr_in addr = {
> +		.sin_family = AF_INET,
> +		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> +		.sin_port = htons(RECV_PORT),
> +	};
> +	struct timeval tv = { .tv_sec = RECV_TIMEOUT_SEC };
> +	int err;
> +
> +	memset(env, 0, sizeof(*env));
> +	env->rfd = -1;
> +
> +	if (!ASSERT_OK(make_netns(NS_TEST), "make_netns"))
> +		goto fail;
> +
> +	env->nstoken = open_netns(NS_TEST);
> +	if (!ASSERT_OK_PTR(env->nstoken, "open_netns"))
> +		goto fail;
> +
> +	env->rfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +	if (!ASSERT_OK_FD(env->rfd, "receiver socket"))
> +		goto fail;
> +
> +	err = bind(env->rfd, (struct sockaddr *)&addr, sizeof(addr));
> +	if (!ASSERT_OK(err, "bind receiver"))
> +		goto fail;
> +
> +	err = setsockopt(env->rfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
> +	if (!ASSERT_OK(err, "set rcvtimeo"))
> +		goto fail;

A subsystem pattern flags this socket setup sequence as potentially
worth simplifying. The network_helpers.h header already provides
start_server(family, type, addr, port, timeout_ms) which performs
socket() + bind() + settimeo() for SOCK_DGRAM.

Other SOCK_DGRAM tests in prog_tests/ use start_server() for this:
cg_storage_multi.c, connect_force_port.c, cgroup_getset_retval.c,
sock_destroy.c, and tc_redirect.c. Could this be written as:

    env->rfd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1",
                            RECV_PORT, RECV_TIMEOUT_SEC * 1000);

to drop the addr and tv locals and use the shared error logging?

That said, there is also precedent for the hand-rolled form in the same
directory (cgroup_storage.c, udp_limit.c, xdp_metadata.c, and others),
so this may just be a style choice.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31694719067
--===============3497903013311219548==--
