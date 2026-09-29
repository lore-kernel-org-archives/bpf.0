Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48C4BC003;
	Tue, 29 Sep 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674003; cv=none; b=ftAzmE3iAUo6k+F2PnjkyzkTi5B3kfmvJDLZhPhobPub31yJU5KS2f0+ioTIf8ud7dxDONnmqpRJ0YS0O5LiRQEJxUi3v6wVJcJ8V9Iq4F4QR2A8p8SQCtNPDtrHrnE1aCsrCyGLAXygRX5PccqRcc/N0WeZ7xzlqqm6RGt4oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674003; c=relaxed/simple;
	bh=cltga6RH/ol21mlzUZmEpLYtblEq58rkXhe1w04j9gc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SNlZsdiaOa9hRJFRfB3Ow5wI4YpPz9PadqNWtUxJfDx8hYI3JFWC4a/kybQcZOt1HXJ/MnpxYsZeemtJb62lUyaEC2N2ZUNknQXQVfPRgqKUvPx2JvdCJHEUCMcZnMWmOrfYTIr/vwHlAP2RsD0y9Fpqp8xPmT+QWBwuKaYo47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XssZ0mCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XssZ0mCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9141F000FF;
	Tue, 29 Sep 2026 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790673995;
	bh=DJTxf5PAiRURAXhySgqOS+Aj3flHVqQz6tf1/FXsfOk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XssZ0mCOgH1dSVMrNC4nf8SuW0QTXIN0DI16+LAfdz4VdIz0uvymLNrlqxgg3Fk7/
	 OQat6CL8IQXo8DV2biTlYtmVJfjNu/0gGi9FIBASFc4Zi1D3l0LanqthO+XRz0Van1
	 Q1nEaiidn7scNKEX3EYMA3mjGrJam0CbLAVQiq+kOCW9p2YO3TCJVDCo65oOoOoiGI
	 1NHb3j3aY4G+yXD/Ro9BbSKr8JVptBDYXsVT27aBzusdn7B4jX1M4JegNGOHlM/AxN
	 qMni27s7xOK0UuyCvZmfYkQIdUOruGyy1y13Aq+qNFgKXc01HOvJQz2/8GHN5MKKVF
	 n+DgFtaCvNp9g==
Content-Type: multipart/mixed; boundary="===============8678725211081073155=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <195e87010d3c27469fbebac9aded96ec0232aa4eb047bbc2c35136ac54a24146@mail.kernel.org>
In-Reply-To: <20260929083447.558818-3-chenyuan_fl@163.com>
References: <20260929083447.558818-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for udp_bpf_recvmsg() with a stuck backlog
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,netdev@vger.kernel.org,bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,daniel@iogearbox.net,ast@kernel.org,cong.wang@bytedance.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 09:26:34 +0000 (UTC)

--===============8678725211081073155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c b/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
> new file mode 100644
> index 000000000000..bbfe2623bd9e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 KylinSoft */
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/wait.h>
> +#include <arpa/inet.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include "test_progs.h"
> +#include "test_sockmap_udp_backlog.skel.h"
> +
> +#define RCV_TIMEOUT_MS	1000
> +#define HANG_LIMIT_MS	5000
> +
> +static int run_child(void)
> +{
> +	struct test_sockmap_udp_backlog *skel;
> +	struct timeval tv = { .tv_sec = RCV_TIMEOUT_MS / 1000 };
> +	struct sockaddr_in addr = {};
> +	struct timespec t0, t1;
> +	socklen_t addrlen = sizeof(addr);
> +	int zero = 0, sfd, ret, err, exit_code = 1;
> +	double elapsed_ms;
> +	char byte = 0;
> +
> +	skel = test_sockmap_udp_backlog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return 1;
> +
> +	sfd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (!ASSERT_GE(sfd, 0, "socket"))
> +		goto out;
> +
> +	addr.sin_family = AF_INET;
> +	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +	addr.sin_port = 0;
> +	if (!ASSERT_OK(bind(sfd, (struct sockaddr *)&addr, sizeof(addr)), "bind"))
> +		goto close;
> +	addrlen = sizeof(addr);
> +	if (!ASSERT_OK(getsockname(sfd, (struct sockaddr *)&addr, &addrlen),
> +		       "getsockname"))
> +		goto close;
> +
> +	/* Non-TCP redirect targets need TCP_ESTABLISHED: connect to self. */
> +	if (!ASSERT_OK(connect(sfd, (struct sockaddr *)&addr, sizeof(addr)),
> +		       "connect"))
> +		goto close;
> +
> +	err = bpf_prog_attach(bpf_program__fd(skel->progs.redir_to_self),
> +			      bpf_map__fd(skel->maps.sock_map),
> +			      BPF_SK_SKB_VERDICT, 0);
> +	if (!ASSERT_OK(err, "prog_attach"))
> +		goto close;
> +
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &sfd, BPF_ANY);
> +	if (!ASSERT_OK(err, "map_update"))
> +		goto close;
> +
> +	if (!ASSERT_EQ(send(sfd, &byte, 1, 0), 1, "send"))
> +		goto close;
> +
> +	/* Let the backlog pick the skb up. */
> +	usleep(100 * 1000);
> +
> +	err = setsockopt(sfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
> +	if (!ASSERT_OK(err, "set_rcvtimeo"))
> +		goto close;
> +
> +	/* A re-sent copy may be read back; the reader must not spin. */
> +	clock_gettime(CLOCK_MONOTONIC, &t0);
> +	errno = 0;
> +	ret = recv(sfd, &byte, 1, 0);
> +	clock_gettime(CLOCK_MONOTONIC, &t1);
> +	elapsed_ms = (t1.tv_sec - t0.tv_sec) * 1000.0 +
> +		     (t1.tv_nsec - t0.tv_nsec) / 1000000.0;
> +
> +	if (ret != 1) {
> +		if (!ASSERT_EQ(ret, -1, "recv"))
> +			goto close;
> +		if (!ASSERT_EQ(errno, EAGAIN, "recv_errno"))
> +			goto close;
> +		if (!ASSERT_GE(elapsed_ms, RCV_TIMEOUT_MS * 0.9, "recv_blocked"))
> +			goto close;
> +		if (!ASSERT_LT(elapsed_ms, HANG_LIMIT_MS, "recv_timely"))
> +			goto close;
> +	}
> +
> +	exit_code = 0;
> +close:
> +	close(sfd);
> +out:
> +	test_sockmap_udp_backlog__destroy(skel);
> +	return exit_code;
> +}
> +
> +void serial_test_sockmap_udp_backlog(void)
> +{

A subsystem pattern flags this as potentially concerning: this adds a new
standalone prog_tests file plus a new BPF object for one narrow internal
code path (udp_bpf_recvmsg() re-arming its loop when only
psock->ingress_skb is populated).

tools/testing/selftests/bpf/prog_tests/sockmap_basic.c already covers
sockmap UDP receive behavior, for example the "sockmap udp multi
channels" subtest and the SOCK_DGRAM FIONREAD subtest, both built on
test_sockmap_pass_prog.

Would it be better to add this as a new case in the existing test instead
of a new file?

There is a plausible reason for a separate file: on an unfixed kernel the
reader spins, holding lock_sock with no signal check, so the scenario has
to run in a fork()ed child with a bounded wait from the parent. It also
should not run as a parallel test, because the unkillable child pins a
CPU. test_sockmap_basic() is a parallel (non-serial_) test, so a separate
serial_ entry point is defensible.

> +	pid_t pid;
> +	int status = 0;
> +	int i;
> +
> +	pid = fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		return;
> +
> +	if (pid == 0)
> +		_exit(run_child());
> +
> +	/* The child may survive SIGKILL: only a bounded wait is safe. */
> +	for (i = 0; i < HANG_LIMIT_MS / 100; i++) {
> +		if (waitpid(pid, &status, WNOHANG) == pid)
> +			break;
> +		usleep(100 * 1000);
> +	}
> +
> +	if (i == HANG_LIMIT_MS / 100) {
> +		kill(pid, SIGKILL);
> +		for (i = 0; i < 10; i++) {
> +			if (waitpid(pid, &status, WNOHANG) == pid)
> +				break;
> +			usleep(100 * 1000);
> +		}
> +		fprintf(stderr,
> +			"udp_bpf_recvmsg() spins on backlog-only ingress (timeout %dms)\n",
> +			HANG_LIMIT_MS);
> +		test__fail();
> +		return;
> +	}
> +
> +	if (WIFEXITED(status)) {
> +		ASSERT_EQ(WEXITSTATUS(status), 0, "child_exit_code");
> +	} else {
> +		fprintf(stderr, "child terminated abnormally (status=%d)\n", status);
> +		test__fail();
> +	}
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36545669306
--===============8678725211081073155==--
