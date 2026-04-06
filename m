Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633A31196F
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516543; cv=none; b=Y7M3wSZHuXmlmKTX4TdAzb9OXkYjn+pyjNVCGXrYy0FxMh/3ElbxOr8XK6eA/kHT2jaPiv64ZLYwMIubfc0ZLOQw13RBevHbxYSv7OlFEOjdeZ+JUgMMJK8gNywTyKmzz0K1fmHzM2HVUZZPRTfL3Ig9KOUPLdBp9s70jMB91p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516543; c=relaxed/simple;
	bh=Q5zRmNCGgjmb+k1Ko/d6Ib9Ro3BF12D/TVnqoD65jV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acvJ8ZVn9Ntncc2748NYsftJzYT0J+4xoUY3ek29PvXTDmObl3yllcJx7DOswB7LuS6+/3o0Y+twywMNzv3YtzT7um48swxL2cfcJY6WMplfujxeAjIZe84ad/4WeKTX5XHAoUJi4qeUZfWwPs5VrM+P12EzH1aupjojsg7GGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZBzCB14q; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZBzCB14q"
Date: Mon, 6 Apr 2026 16:01:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775516538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpuNbGzT5QRjxkn9LQ1+Gyc83mOaDfValyGOkjAk9Ww=;
	b=ZBzCB14q4snVlgWtOHXvPmVWA0BfWt6xES9HKjlqUkvHFuipvdatHY0cZSCnxcoZuwhVZ6
	F5Kb8WwBmwjlirTkets3IikXoMt7kqxAioBsDFxzMQ5mLRoCW0hhau9vldJC7cNsZ+ubh0
	YzaMAuDNv3K4O44NEDNve6i27tEXhxw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add tests for sock_ops ctx
 access with same src/dst register
Message-ID: <20264622473.hwTx.martin.lau@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
 <20260406031330.187630-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406031330.187630-2-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 06, 2026 at 11:12:51AM +0800, Jiayuan Chen wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
> new file mode 100644
> index 0000000000000..e086f7abb197e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +#include "sock_ops_get_sk.skel.h"
> +
> +/* See progs/sock_ops_get_sk.c for the bug description. */
> +static void run_sock_ops_test(struct sock_ops_get_sk *skel, int cgroup_fd,

skel is not used. sashiko has flagged it also.

pw-bot: cr

> +			      int prog_fd)
> +{
> +	int server_fd, client_fd, err;
> +
> +	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> +	if (!ASSERT_OK(err, "prog_attach"))
> +		return;
> +
> +	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server"))
> +		goto detach;
> +
> +	/* Trigger TCP handshake which causes TCP_NEW_SYN_RECV state where
> +	 * is_fullsock == 0 and is_locked_tcp_sock == 0.
> +	 */
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +		goto close_server;
> +
> +	close(client_fd);
> +
> +close_server:
> +	close(server_fd);
> +detach:
> +	bpf_prog_detach(cgroup_fd, BPF_CGROUP_SOCK_OPS);
> +}
> +
> +void test_sock_ops_get_sk(void)

Add a "ns" in the naming so that test_progs will start a new netns.

Like 'void test_ns_sock_ops_get_sk(void)'.

> +{
> +	struct sock_ops_get_sk *skel;
> +	int cgroup_fd;
> +
> +	cgroup_fd = test__join_cgroup("/sock_ops_get_sk");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))

nit. Use ASSERT_OK_FD check. Same for the other fd checks in this file.
