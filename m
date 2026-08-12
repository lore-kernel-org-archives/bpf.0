Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC247F770;
	Wed, 12 Aug 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555546; cv=none; b=WKyy4bvqw234SkCsaAjh2+CNqBNoKwqYnv9J2TDVdk7n2HY5LX4Gyo53WUBaGJTiB5bEiND1Nx0fRN++56VgpAfaDg1jJQC2RhXuq1+tFptXrfF5gbuTVqdxuxWQH/59ZuPc3t6Ay9/eMzyC10wvE5a84FWzRFJLTtDdLWrd0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555546; c=relaxed/simple;
	bh=FA89+iKBYQt9dZncUt8lufNigmkPn/p5EQ/lC+OxbhA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qgbI2ThtMLXjy3nvxbgEXhZCkXf8rC9t9+z1ZtdcW65KCyp2eYVHFj1AvwLwvg2L5SuvBKycRRjRPjqIrHivDmdKX7+eFgjAXM/AfYPZi+mzD/nrAIWE5s3L0I26xvLgE4udRest1ITc3jBu9OoVNXzHegT2Ix+2vv3y5fj8liU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZZbKoVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZZbKoVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB61E1F000E9;
	Wed, 12 Aug 2026 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555544;
	bh=LK8BouBE1I5Wtujxzh30Ly8+nAGvdWZKTata8FYCpMg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aZZbKoVATYttvq4mH6EQ7myH/W9VQQmi4SyWneVydbeEMiu0KxYpmktQBPkridiaE
	 j4OcuHBmkKSdEUiAQTx/GD8y+f7WnZy9aauFzjLodUxZXSrquATVizYqcIgciKNF02
	 fpxLPWjLI2skgug5MHVI3aF5OiKNt8k79NqeHACxrj1zw5BAAsTG+RvV0eif5NOmun
	 M8JVgeOO2bE5vnGT2dPDbDP7WQb95if5afgSlSwRGh1lRQM0MGOdGcNP3i9yMxjO9s
	 gjMa1+VwqWuON1lJeDVZoKrMDgqFEUME3MX+T7zmV+nwUUPOyeBhFd7+8tdv6mV05D
	 UaLBTIy4EbgMw==
Content-Type: multipart/mixed; boundary="===============7994205562494664655=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <389d7d5984e3995303dc4ac505c8629e5d486bef420ffa47d5ee2edf3761cec6@mail.kernel.org>
In-Reply-To: <20260812154328.72834-4-mahe.tardy@gmail.com>
References: <20260812154328.72834-4-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] selftests/bpf: Add ksock kfunc test
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 17:25:42 +0000 (UTC)

--===============7994205562494664655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
> bpf setup program creates a ksock context and connects the socket.
> Another LSM sleepable bpf program looks up the context and send test
> data. The userspace harness creates a network namespace and a new socket
> on loopback, run the setup and send syscall bpf progs then check that
> the userspace socket received the data from bpf.

The description says "run the setup and send syscall bpf progs" but the
test adds only one SEC("syscall") program, ksock_setup:

tools/testing/selftests/bpf/progs/ksock_lsm.c:
    SEC("syscall")
    int ksock_setup(void *ctx)
    { ... }

which the harness runs once:

    err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup), &opts);

The send doesn't happen in a syscall program at all. It happens in the
sleepable LSM program ksock_socket_bind (SEC("lsm.s/socket_bind")), which
the harness triggers indirectly:

    skel->links.ksock_socket_bind = bpf_program__attach_lsm(skel->progs.ksock_socket_bind);
    ...
    skel->bss->target_pid = getpid();
    err = bind(tfd, (struct sockaddr *)&trigger_addr, sizeof(trigger_addr));

This also contradicts the preceding sentence which correctly states the
sender is "Another LSM sleepable bpf program". Should this say "run the
setup syscall bpf prog and trigger the LSM send hook" or similar?

Also in the same sentences: "looks up the context and send test data"
(sends) and "The userspace harness ... run the setup" (runs).

> diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
> new file mode 100644
> index 0000000000000..30e89d34d388f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
> @@ -0,0 +1,127 @@
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
> +
> +struct ksock_test_env {
> +	bool netns_created;
> +	struct nstoken *nstoken;
> +	int rfd;
> +};
> +
> +static bool ksock_test_env_setup(struct ksock_test_env *env)
> +{

[ ... ]

> +	memset(env, 0, sizeof(*env));
> +	env->rfd = -1;
> +
> +	SYS(fail, "ip netns add %s", NS_TEST);
> +	env->netns_created = true;
> +	SYS(fail, "ip -net %s link set lo up", NS_TEST);

This isn't a bug, but the test hand-rolls network namespace setup that
network_helpers.h (already included at the top) provides verbatim. Could
ksock_test_env_setup() use make_netns() here?

make_netns() in tools/testing/selftests/bpf/network_helpers.c runs exactly
those two commands:

    r = asprintf(&cmd, "ip netns add %s", name);
    ...
    r = asprintf(&cmd, "ip -n %s link set lo up", name);

and it also unwinds the namespace if bringing lo up fails, which the
open-coded version does not do. The current path leaves the netns to be
cleaned up by the caller's fail: label instead.

The teardown at the end of test_ksock_lsm():

    SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", NS_TEST);

is also what remove_netns() does, and SYS_NOFAIL() already appends
" >/dev/null 2>&1" (test_progs.h), so the explicit redirection is applied
twice and the command ends up as
"ip netns del ksock_lsm_ns >/dev/null 2>&1 >/dev/null 2>&1".

Using make_netns()/remove_netns() would remove the duplicated redirection,
drop the env->netns_created bookkeeping field, and inherit the shared
helper's teardown-on-partial-failure behaviour.

> +
> +	env->nstoken = open_netns(NS_TEST);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886
--===============7994205562494664655==--
