Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B244236C;
	Tue, 29 Sep 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670952; cv=none; b=Px+rFWj342asUVrR+weBFHYi2qpuvLY4RtPaNDuEhlPNPSIEFhPVUG7KpAAF3tha93SvkXmbZEQI9HvYNR2U8CLZknSgkV9htBEJk/SOb+8G/6qji95YAHRovFaxJ1hXuV6SFPd65iTKEOdw+fK3tq+xGyl/wL9OIj+H8wv3JiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670952; c=relaxed/simple;
	bh=Na12jjbDxKgPFPFpuK8FD4sIseQY/ttArxvtTDG43xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYOUnT/6WCYW5/7ZnZsErVg/y7uBfGXtrLv+NiUGvbN/TdQAAmE08LT+F2al3PR2N0JKXDdeASoppH/1czQvJ8xdP101g1010dAs6nlBK0KGg60RNXkzY/DhUdJ1f3nrZ5t50d+24ED/pETU0aqdQY8QB0MH7cvBRv2LXDCUa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WsOflKQJ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WsOflKQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GP
	zWZH/zqwiGRVeLTBbrrkn6LvMjLad3++e9As7NjY4=; b=WsOflKQJsjPm4Kuhjr
	Xq9hd0CCxfxt4Hzp1BgKbaZZwIKPp81PRtHeqftx8KHS09eYxxOXq5f9lWG5BMoy
	64ec6jYAmJlDB5xxFmE8qIftx4RVXdxASQyj5IXwbstRORtEJhcoo0+XMsqDQVNJ
	UAnFdQjdwrJymHNkSh60a/0z8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3vx8seLtq177cBQ--.12081S4;
	Tue, 29 Sep 2026 16:34:56 +0800 (CST)
From: chenyuan_fl@163.com
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	daniel@iogearbox.net,
	ast@kernel.org,
	cong.wang@bytedance.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test for udp_bpf_recvmsg() with a stuck backlog
Date: Tue, 29 Sep 2026 16:34:47 +0800
Message-ID: <20260929083447.558818-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929083447.558818-1-chenyuan_fl@163.com>
References: <20260929083447.558818-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vx8seLtq177cBQ--.12081S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gry7GFykAr13tFW5XFWkJFb_yoWxGF4fpa
	yFkF18GrWvqa15Wrs3XF47KF1S9a18AF1fJr48WF1jkr4xtrn3tF97KFWYqFnrXrZa93yr
	ZFnIgFW5AF48Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIlksUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RGzcWq7eDFsSgAA3I

From: Yuan Chen <chenyuan@kylinos.cn>

A sk_skb verdict program that redirects every skb back to the socket
itself keeps psock->ingress_skb populated: the backlog work re-sends
the skb out of that same socket, so it keeps coming back through the
receive path, and ingress_msg never receives anything.

Redirect targets must be in TCP_ESTABLISHED for non-TCP sockets
(sock_map_redirect_allowed()), so the test connects the UDP socket to
its own address; without that bpf_sk_redirect_map() turns every
redirect into SK_DROP and the backlog never fills up.

Reading on such a socket must fall back to the plain UDP receive path,
honor SO_RCVTIMEO and return -EAGAIN instead of spinning.  A re-sent
copy may still win the race against the verdict and be delivered; the
test accepts either outcome.

Run the scenario in a fork()ed child supervised by the parent, since
the spinning reader holds the socket lock and even SIGKILL cannot
reclaim it on an unfixed kernel.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../bpf/prog_tests/sockmap_udp_backlog.c      | 141 ++++++++++++++++++
 .../bpf/progs/test_sockmap_udp_backlog.c      |  21 +++
 2 files changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_udp_backlog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c b/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
new file mode 100644
index 000000000000..bbfe2623bd9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <arpa/inet.h>
+#include <errno.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "test_sockmap_udp_backlog.skel.h"
+
+#define RCV_TIMEOUT_MS	1000
+#define HANG_LIMIT_MS	5000
+
+static int run_child(void)
+{
+	struct test_sockmap_udp_backlog *skel;
+	struct timeval tv = { .tv_sec = RCV_TIMEOUT_MS / 1000 };
+	struct sockaddr_in addr = {};
+	struct timespec t0, t1;
+	socklen_t addrlen = sizeof(addr);
+	int zero = 0, sfd, ret, err, exit_code = 1;
+	double elapsed_ms;
+	char byte = 0;
+
+	skel = test_sockmap_udp_backlog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return 1;
+
+	sfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(sfd, 0, "socket"))
+		goto out;
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = 0;
+	if (!ASSERT_OK(bind(sfd, (struct sockaddr *)&addr, sizeof(addr)), "bind"))
+		goto close;
+	addrlen = sizeof(addr);
+	if (!ASSERT_OK(getsockname(sfd, (struct sockaddr *)&addr, &addrlen),
+		       "getsockname"))
+		goto close;
+
+	/* Non-TCP redirect targets need TCP_ESTABLISHED: connect to self. */
+	if (!ASSERT_OK(connect(sfd, (struct sockaddr *)&addr, sizeof(addr)),
+		       "connect"))
+		goto close;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.redir_to_self),
+			      bpf_map__fd(skel->maps.sock_map),
+			      BPF_SK_SKB_VERDICT, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto close;
+
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
+				  &zero, &sfd, BPF_ANY);
+	if (!ASSERT_OK(err, "map_update"))
+		goto close;
+
+	if (!ASSERT_EQ(send(sfd, &byte, 1, 0), 1, "send"))
+		goto close;
+
+	/* Let the backlog pick the skb up. */
+	usleep(100 * 1000);
+
+	err = setsockopt(sfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (!ASSERT_OK(err, "set_rcvtimeo"))
+		goto close;
+
+	/* A re-sent copy may be read back; the reader must not spin. */
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	errno = 0;
+	ret = recv(sfd, &byte, 1, 0);
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	elapsed_ms = (t1.tv_sec - t0.tv_sec) * 1000.0 +
+		     (t1.tv_nsec - t0.tv_nsec) / 1000000.0;
+
+	if (ret != 1) {
+		if (!ASSERT_EQ(ret, -1, "recv"))
+			goto close;
+		if (!ASSERT_EQ(errno, EAGAIN, "recv_errno"))
+			goto close;
+		if (!ASSERT_GE(elapsed_ms, RCV_TIMEOUT_MS * 0.9, "recv_blocked"))
+			goto close;
+		if (!ASSERT_LT(elapsed_ms, HANG_LIMIT_MS, "recv_timely"))
+			goto close;
+	}
+
+	exit_code = 0;
+close:
+	close(sfd);
+out:
+	test_sockmap_udp_backlog__destroy(skel);
+	return exit_code;
+}
+
+void serial_test_sockmap_udp_backlog(void)
+{
+	pid_t pid;
+	int status = 0;
+	int i;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		return;
+
+	if (pid == 0)
+		_exit(run_child());
+
+	/* The child may survive SIGKILL: only a bounded wait is safe. */
+	for (i = 0; i < HANG_LIMIT_MS / 100; i++) {
+		if (waitpid(pid, &status, WNOHANG) == pid)
+			break;
+		usleep(100 * 1000);
+	}
+
+	if (i == HANG_LIMIT_MS / 100) {
+		kill(pid, SIGKILL);
+		for (i = 0; i < 10; i++) {
+			if (waitpid(pid, &status, WNOHANG) == pid)
+				break;
+			usleep(100 * 1000);
+		}
+		fprintf(stderr,
+			"udp_bpf_recvmsg() spins on backlog-only ingress (timeout %dms)\n",
+			HANG_LIMIT_MS);
+		test__fail();
+		return;
+	}
+
+	if (WIFEXITED(status)) {
+		ASSERT_EQ(WEXITSTATUS(status), 0, "child_exit_code");
+	} else {
+		fprintf(stderr, "child terminated abnormally (status=%d)\n", status);
+		test__fail();
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_udp_backlog.c b/tools/testing/selftests/bpf/progs/test_sockmap_udp_backlog.c
new file mode 100644
index 000000000000..3459a66da3ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_udp_backlog.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_map SEC(".maps");
+
+/* Self-redirect: the backlog work keeps re-sending the skb. */
+SEC("sk_skb/verdict")
+int redir_to_self(struct __sk_buff *skb)
+{
+	return bpf_sk_redirect_map(skb, &sock_map, 0, 0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0

