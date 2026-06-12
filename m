Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85F314A6F
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226925; cv=none; b=aYJoxBqhQZMXRexrlScPl3CQcn3/Nmm3iU+GvD7R9hH6y2NdL522BFe1yELQ6IhW5nWd2nvmp4mhnodOEtxet3DO5jl5J9bLkeklqyzcEJAjX4HnZixXY49BxcGtbt07AlyoAI/BeM5CU5WhnK3FNcGmDNHoNL/y/X22E0yxAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226925; c=relaxed/simple;
	bh=COHCbV0CvcM7bELFtI/sihawmLxEBJAqATrSzh46ujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvjW5D8Mq5KSyIiebuj1hSbE5vUqeX8OxRD0unsMo4DvtdYxF+ZTjDN/xRx4HzVGbj5Hkz7yJwAseA1S72qf2qGriYuDUnbrjZdb09yk02urQse1sHq6jluAYYT7aZju7xnR+IDE+0EEaPKAITKc/VoBbtm99IAE6h4MI5yBID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZpvwbW/; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZpvwbW/"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13817614cd3so852546c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226923; x=1781831723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2bXgl76ARckVx8v2O8eskzZpGAm4pEf6DbV38TBgpY=;
        b=JZpvwbW/Pb+Po0QPzyea8zDrBgB4BuDTXxhc4I8lX5nLbdWWo7J0zhGaHFuwcsqfLM
         5h6yFZoQhlQBYnpkgYbv2jucux1roEmL2zTSN9XPvSM5HfMeDBlmUijDE1VRlhhBn+/3
         uaPrABN5SK64XSHhkOd9NtXF+/Sag+8fB+oJbok9jBlbj/erzLRx6POUVNs33mdF1biZ
         LfFFoE1hFmOFFGkdbom8f4JPmsdzEEVpLZYvlm7E1m6Njm0YbXzSv/NgBxQPWR0uItlx
         kYPFXalPRc1fmRO7Wsg+IR07Qpjs2SiQPRx+GGkzZmcCv5wSIXmCIMjbAAeuC5qOS1Br
         svhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226923; x=1781831723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2bXgl76ARckVx8v2O8eskzZpGAm4pEf6DbV38TBgpY=;
        b=egyAiufZbWE9bCzxrhLfFnOcoYR4YO0kdnxxEF9NdFSyZKR+S+4fO3B+O5ovVtEjUt
         7ebTEmCjM1JSLJ7+2WGXFERyHqexhSNK9V/UCbbv8MVE9dJF9MDmv9cOiiJGIdloYFRc
         RUpuwpZlsGY3+hMHCKjvUK8RqGnOSktG8tSXY+4usNhl+wGeithwnW/yj9UlkF3jB3Ti
         TKf0IgF5XTGwQddU41xhWq/5NfmMleksFKip4jb8GlaZ5TIyi8V4gqPdoZ4os43tGQoz
         Vg8aYu4rwlmWt7OpAMY6AOsV67LOgdFPQcO8XpQnbOLkEYRkpIoT5rVp9n38qjIQxExS
         E5qg==
X-Gm-Message-State: AOJu0YyiKtja8LdkXDD7dTVCHJnU21SfA3qxQXAL/GFdSQUkBUGQdotd
	/E7Cy3GDwAPKzoUJcY13PT6YfzzDnoIQKFd+Z75aDBxuB2vC8mtGsjO1
X-Gm-Gg: Acq92OEsG9IQLf8C4SokXPVe6xo7hd9aBwA2FazYgwW0RitE/EPX6DBmkOBUfxXbaF0
	AoSzeWr5JCFsGQp8uLmirBNg4hqDdtcIPxSy216SQe6u8WA6ETukSI04LxXtO6tavhUm6mD4Q8r
	9aveoF73/dh7CKvGQf5+Goa8RtRvaAb2lFvH3XHdyunv/HzFA4mGncniw8+vFWWLQmTAoAKAbXx
	47L0jd5UiLo8vblYQb6aRnjlbQLj/G4rYqVg4FZSO5nY08KmKMmIcyo4ZPu2oG8eR8NXyO3Uhlw
	h39bOvgmtcyNgUxMo+aSLCL5ALnsrnufRmrxlIce3Hd0+3ovSmLhUcYlGQ/JlUpZs7+EYeEKge3
	myQgLVtUIDeZBmr8SAuDvrLFs/Ov+W/e+iRd4CO0efsQrJk4cpze68jTAhWD1vHu2jHhI0AqQC0
	u9eYK+Az2z2GL4bmveDPPmI5CDzmcjOm/wr75UeoCOwwJdT46Y7ojrFnS4mHchLRa6Kw==
X-Received: by 2002:a05:7022:497:b0:12d:b66f:35d7 with SMTP id a92af1059eb24-1384bb4a215mr309056c88.10.1781226922819;
        Thu, 11 Jun 2026 18:15:22 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:22 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 3/5] selftests/bpf: add tcp_splice basic round-trip test
Date: Thu, 11 Jun 2026 18:14:50 -0700
Message-ID: <20260612011452.134466-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loads a sock_ops BPF program that, on each ESTABLISHED callback,
inserts self into a sockhash keyed by the local 4-tuple, looks up
the peer using the swapped 4-tuple, and calls the new
bpf_sock_splice_pair kfunc on whichever peer it finds. Counters track
how many calls returned 0 (winner) vs -EEXIST (race loser) vs other
errors.

Userspace creates a loopback TCP pair, waits for both ESTABLISHED
callbacks to land, then verifies pair_ok >= 1 and pair_other_err == 0.
A receiver thread blocks in recv() before the main thread sends; the
test asserts the bytes round-trip through the rendezvous data plane.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 .../selftests/bpf/prog_tests/tcp_splice.c     | 206 ++++++++++++++++++
 .../selftests/bpf/progs/test_tcp_splice.c     | 101 +++++++++
 2 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_splice.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_splice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_splice.c b/tools/testing/selftests/bpf/prog_tests/tcp_splice.c
new file mode 100644
index 000000000000..b80a1129c6aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_splice.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "test_tcp_splice.skel.h"
+
+#include <pthread.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define MSG "hello rendezvous"
+#define CLIENT_BANNER "client-banner"
+#define SERVER_BANNER "server-banner"
+
+struct recv_arg {
+	int fd;
+	char buf[64];
+	int n;
+	int err;
+};
+
+static void *recv_thread(void *p)
+{
+	struct recv_arg *a = p;
+
+	a->n = recv(a->fd, a->buf, sizeof(a->buf) - 1, 0);
+	a->err = errno;
+	return NULL;
+}
+
+struct send_arg {
+	int fd;
+	const char *buf;
+	size_t len;
+	int n;
+	int err;
+};
+
+static void *send_thread(void *p)
+{
+	struct send_arg *a = p;
+
+	a->n = send(a->fd, a->buf, a->len, 0);
+	a->err = errno;
+	return NULL;
+}
+
+static int run_basic(int cgroup_fd, struct test_tcp_splice *skel)
+{
+	pthread_t tid;
+	struct recv_arg a = {};
+	int sfd = -1, cfd = -1, lfd = -1;
+	int n, err = -1;
+
+	lfd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(lfd, 0, "start_server"))
+		return -1;
+
+	cfd = connect_to_fd(lfd, 0);
+	if (!ASSERT_GE(cfd, 0, "connect_to_fd"))
+		goto out;
+
+	sfd = accept(lfd, NULL, NULL);
+	if (!ASSERT_GE(sfd, 0, "accept"))
+		goto out;
+
+	/* Give both ESTABLISHED sock_ops callbacks a moment to run. */
+	usleep(50 * 1000);
+
+	if (!ASSERT_GE(skel->bss->pair_ok, 1, "splice paired"))
+		goto out;
+	ASSERT_EQ(skel->bss->pair_other_err, 0, "no unexpected pair errors");
+
+	/* Drive the splice fast path: receiver enters recv() and publishes
+	 * its bvec, sender then writes directly into it.
+	 */
+	a.fd = sfd;
+	if (!ASSERT_OK(pthread_create(&tid, NULL, recv_thread, &a),
+		       "pthread_create"))
+		goto out;
+	usleep(20 * 1000); /* let recv block */
+
+	n = send(cfd, MSG, strlen(MSG), 0);
+	ASSERT_EQ(n, (int)strlen(MSG), "send length");
+
+	pthread_join(tid, NULL);
+	ASSERT_EQ(a.n, (int)strlen(MSG), "recv length");
+	a.buf[a.n > 0 ? a.n : 0] = 0;
+	ASSERT_STREQ(a.buf, MSG, "recv contents");
+
+	err = 0;
+out:
+	if (cfd >= 0)
+		close(cfd);
+	if (sfd >= 0)
+		close(sfd);
+	if (lfd >= 0)
+		close(lfd);
+	return err;
+}
+
+/* Bidirectional-write deadlock-avoidance test.
+ *
+ * Both sides issue send() before either calls recv(), the classic
+ * pattern that used to deadlock under synchronous rendezvous (and
+ * the actual cause of "kex_exchange_identification: write: Broken
+ * pipe" with SSH on loopback). The bounded-wait fallback in
+ * tcp_bpf_splice_sendmsg() must let both writes complete via the
+ * normal TCP path within ~1 ms, and the banners must arrive intact
+ * on the other side when recv() is called next.
+ */
+static int run_bidir_write(int cgroup_fd, struct test_tcp_splice *skel)
+{
+	pthread_t client_send_tid, server_send_tid;
+	struct send_arg cs = { .buf = CLIENT_BANNER,
+			       .len = sizeof(CLIENT_BANNER) - 1 };
+	struct send_arg ss = { .buf = SERVER_BANNER,
+			       .len = sizeof(SERVER_BANNER) - 1 };
+	struct recv_arg cr = {}, sr = {};
+	int sfd = -1, cfd = -1, lfd = -1;
+	int err = -1;
+
+	lfd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(lfd, 0, "start_server"))
+		return -1;
+	cfd = connect_to_fd(lfd, 0);
+	if (!ASSERT_GE(cfd, 0, "connect_to_fd"))
+		goto out;
+	sfd = accept(lfd, NULL, NULL);
+	if (!ASSERT_GE(sfd, 0, "accept"))
+		goto out;
+
+	usleep(50 * 1000); /* let pair complete */
+
+	/* Both sides write first, neither reads yet. Both must return
+	 * within bounded time (no deadlock).
+	 */
+	cs.fd = cfd;
+	ss.fd = sfd;
+	if (!ASSERT_OK(pthread_create(&client_send_tid, NULL, send_thread, &cs),
+		       "client send thread"))
+		goto out;
+	if (!ASSERT_OK(pthread_create(&server_send_tid, NULL, send_thread, &ss),
+		       "server send thread"))
+		goto out;
+
+	pthread_join(client_send_tid, NULL);
+	pthread_join(server_send_tid, NULL);
+	ASSERT_EQ(cs.n, (int)cs.len, "client send length");
+	ASSERT_EQ(ss.n, (int)ss.len, "server send length");
+
+	/* Now read on each side - the bytes the peer wrote should have
+	 * landed via the TCP fallback path.
+	 */
+	cr.fd = cfd;
+	cr.n = recv(cr.fd, cr.buf, sizeof(cr.buf) - 1, 0);
+	ASSERT_EQ(cr.n, (int)ss.len, "client recv length");
+	cr.buf[cr.n > 0 ? cr.n : 0] = 0;
+	ASSERT_STREQ(cr.buf, SERVER_BANNER, "client got server banner");
+
+	sr.fd = sfd;
+	sr.n = recv(sr.fd, sr.buf, sizeof(sr.buf) - 1, 0);
+	ASSERT_EQ(sr.n, (int)cs.len, "server recv length");
+	sr.buf[sr.n > 0 ? sr.n : 0] = 0;
+	ASSERT_STREQ(sr.buf, CLIENT_BANNER, "server got client banner");
+
+	err = 0;
+out:
+	if (cfd >= 0)
+		close(cfd);
+	if (sfd >= 0)
+		close(sfd);
+	if (lfd >= 0)
+		close(lfd);
+	return err;
+}
+
+void test_tcp_splice(void)
+{
+	struct test_tcp_splice *skel;
+	int cgroup_fd, prog_fd;
+
+	cgroup_fd = test__join_cgroup("/tcp_splice");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = test_tcp_splice__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto close_cgroup;
+
+	prog_fd = bpf_program__fd(skel->progs.sockops_splice);
+	if (!ASSERT_OK(bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0),
+		       "attach sockops"))
+		goto destroy_skel;
+
+	if (test__start_subtest("basic"))
+		run_basic(cgroup_fd, skel);
+	if (test__start_subtest("bidir_write"))
+		run_bidir_write(cgroup_fd, skel);
+
+destroy_skel:
+	test_tcp_splice__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_splice.c b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
new file mode 100644
index 000000000000..09c7f0f9e311
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Sock_ops BPF program that pairs locally-connected TCP sockets via the
+ * bpf_sock_splice_pair kfunc. Each side of an established loopback
+ * connection inserts itself into a sockhash keyed by its 4-tuple and
+ * looks up the peer using the swapped tuple. Whichever side finds the
+ * peer attempts to splice; the race loser sees -EEXIST.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+struct flow_key {
+	__u32	saddr;
+	__u32	daddr;
+	__u16	sport;
+	__u16	dport;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 16);
+	__type(key, struct flow_key);
+	__type(value, __u64);
+} rendezvous SEC(".maps");
+
+int bpf_sock_splice_pair(struct sock *peer, struct bpf_sock_ops_kern *skops) __ksym;
+void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
+__u32 pair_ok;
+__u32 pair_other_err;
+
+/* IPv4 only: the verifier doesn't accept memcpy from sock_ops ctx
+ * because it lowers to "ctx + reg" pointer arithmetic. IPv6 support
+ * would need explicit field-by-field reads of local_ip6[i] /
+ * remote_ip6[i] at constant indices.
+ */
+static __always_inline void mk_key(struct bpf_sock_ops *s,
+				   struct flow_key *k, int swap)
+{
+	/* skops->local_port is already in host byte order. skops->remote_port
+	 * is laid out as the network-order 16-bit port in the upper half of
+	 * a u32 (see sock_ops_convert_ctx_access); bpf_ntohl produces the
+	 * host-order port directly - no further shift.
+	 */
+	__u16 lport = (__u16)s->local_port;
+	__u16 rport = bpf_ntohl(s->remote_port);
+
+	if (!swap) {
+		k->saddr = s->local_ip4;
+		k->daddr = s->remote_ip4;
+		k->sport = lport;
+		k->dport = rport;
+	} else {
+		k->saddr = s->remote_ip4;
+		k->daddr = s->local_ip4;
+		k->sport = rport;
+		k->dport = lport;
+	}
+}
+
+SEC("sockops")
+int sockops_splice(struct bpf_sock_ops *skops)
+{
+	struct flow_key self_key, peer_key;
+	struct bpf_sock *peer;
+	int ret;
+
+	if (skops->op != BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB &&
+	    skops->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		return 0;
+	if (skops->family != 2 /* AF_INET */)
+		return 0;
+
+	mk_key(skops, &self_key, 0);
+	mk_key(skops, &peer_key, 1);
+
+	/* BPF_ANY: a reused 4-tuple after close (e.g. fast reconnect) must
+	 * overwrite the stale entry rather than silently fail.
+	 */
+	bpf_sock_hash_update(skops, &rendezvous, &self_key, BPF_ANY);
+
+	peer = bpf_map_lookup_elem(&rendezvous, &peer_key);
+	if (!peer)
+		return 0;
+
+	/* The sockhash bpf_map_lookup_elem above is an acquire, so @peer
+	 * carries a reference. A sock_ops program cannot call
+	 * bpf_sk_release, so the reference is handed to bpf_sock_splice_pair
+	 * which is KF_RELEASE and consumes it - no explicit release here,
+	 * and none is possible from this program type.
+	 */
+	ret = bpf_sock_splice_pair((struct sock *)peer,
+				   bpf_cast_to_kern_ctx(skops));
+	if (ret == 0)
+		__sync_fetch_and_add(&pair_ok, 1);
+	else if (ret != -17 /* -EEXIST: race loser, expected */)
+		__sync_fetch_and_add(&pair_other_err, 1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

