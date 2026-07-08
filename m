Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96223BB4A
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480982; cv=none; b=W7QNp47EffyUsHyQDbYfAopLpbmpbz8d9BhzGpIIg8/l01kXiloEmmLV9bwJ3edgQ+pksTSlAKVmsPhT3NGc9yGyS+Rcohn5RtYjqlG2rR0W43qFObWU4wllZBnezU42KikF3zp6uhTfo/A3ffyIPUuH8JWIPU4XlgupAfV9LUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480982; c=relaxed/simple;
	bh=LR8ZkF3VK3DQ+1b3NahwIArIM/D2QpLWCJHiyLBsbcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNZVTu7x5qRYwxnxCKjmD8TE5+nfNOyCixqNQQ9CXmZploIxOvPKZkaI9k5W9eHkbSsWFtrzJszf7MvXhzh4UcPnJRwAc7oGnx4IRxcV08qdulwKzV3fp/otKMBQZI1uXGZoHtZmQ2V/lb8fri1zysBIIrGIFhkciKgWvPonbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lOC67acm; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lOC67acm"
Message-ID: <2ea29553-b0bd-4d12-9ff9-9b6f99267fc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783480976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1a2UG4qiDNeOYHH404Fpdk2UN9XF1jE5+XaJZ48Ojg=;
	b=lOC67acmeaf3tcUhfAAiGGXM1A7NuahPyQs2Iqpm2I9o709r5Bl+5AZJILRy7VASo9jNQy
	nyBP76d6/n3pXWbVAXKatcYwgjSGewR+JmrUKwd0R7iKokj12CJUrnQHJht7Ijm98t6fTi
	TWpMHY8r43iaQweeu8Ho5Gb8XNUDr5Q=
Date: Wed, 8 Jul 2026 11:22:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add XDP dispatcher FineIBT
 regression test
Content-Language: en-US
To: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
 <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/7/26 10:57, David Windsor wrote:
> Add a regression test for the x86 BPF dispatcher's indirect-jump fallback
> under FineIBT.
> 
> This test can crash the kernel on an unfixed FineIBT build and so should
> be run in a VM.
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  .../bpf/prog_tests/xdp_dispatcher_fineibt.c   | 47 +++++++++++++++++++
>  .../bpf/progs/xdp_dispatcher_fineibt.c        | 18 +++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
> new file mode 100644
> index 000000000000..2d3fc4034eb9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 David Windsor */
> +
> +/*
> + * Regression test for the x86 BPF dispatcher's indirect-jump fallback
> + * under FineIBT.
> + *
> + * WARNING
> + * -------
> + *  This test can crash the kernel, thus should be run in a VM.
> + */
> +#include <uapi/linux/if_link.h>
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "xdp_dispatcher_fineibt.skel.h"
> +
> +#define IFINDEX_LO		1
> +
> +void test_xdp_dispatcher_fineibt(void)
> +{
> +	struct xdp_dispatcher_fineibt *skel;
> +	int err, attached_fd, unattached_fd;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +	);
> +
> +	skel = xdp_dispatcher_fineibt__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	attached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_attached);
> +	unattached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_unattached);
> +
> +	err = bpf_xdp_attach(IFINDEX_LO, attached_fd, XDP_FLAGS_SKB_MODE, NULL);
> +	if (!ASSERT_OK(err, "attach_prog"))
> +		goto out;
> +
> +	err = bpf_prog_test_run_opts(unattached_fd, &topts);
> +	ASSERT_OK(err, "unattached_test_run");
> +	ASSERT_EQ(topts.retval, XDP_PASS, "unattached_retval");
> +
> +	bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> +out:
> +	xdp_dispatcher_fineibt__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
> new file mode 100644
> index 000000000000..b49b84f01c8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 David Windsor */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("xdp")
> +int xdp_dispatcher_attached(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp")
> +int xdp_dispatcher_unattached(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";


Instead of creating xdp_dispatcher_fineibt.c, better to reuse
xdp_dummy.c. Then, in xdp_dispatcher_fineibt.c, you can create two
xdp_dummy skels, one for attaching, one for running.

And, add the test to xdp_attach.c instead of new file
prog_tests/xdp_dispatcher_fineibt.c?

Thanks,
Leon

