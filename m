Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BC371CF4
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429384; cv=none; b=dbV68CStELFYIFtZAA/UakgRFVM/X5QOss0CBdOsAS7Bn/u3RQ1iA05tmyw5y7yVO1upXvpj+t6VuR+kkT21h3hpQem/E6zN6uMXAJ+uZS9+pLFHgPCgEletvFlZwrqGIxjt4sxO1muAMAMeSXTb3bjf5D+TxJoQLfJWq3wYqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429384; c=relaxed/simple;
	bh=BqrdUhpX8p9h7PxnLOSeyqYDBn+FXowdFqdch1OpQIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TSFRyJTyTWXZYZM0AbcK2Z5Lj11owoasMgYNSfIv/ANiMtPGyIZuHI+Fiwos0Y3zkmJmPtm71fM+77zOx1MiQTofvzjSbau3UZdjum6MQYL8w9mNBHZrr/sTKacX60KwYMUtaBT4vps4lD74WNPV2cKsDBimzD6+vkqjz9fTy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpND3fii; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpND3fii"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so49130765ad.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429377; x=1792034177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtwhT83ye2QA4NSO+lP/kSrqtguUizhSwmlMJpYZtU8=;
        b=bpND3fiicI5d3w9gjST+pO/uxe7HWvlC8WeqqCUfdjTkVIBxYcL0APtm3QU8gslVM4
         2bxKEzalunq/8NEyU77bPtC3cFCq7fr4P2rm2aZ6nhXNfHKcfxNN5iID5nkZBQM7Av7F
         x1VzKR7+R8MVhKFCAy8vTxQNXWOm/350rptMQHBIAEGDATO+VM2LJGySvN3gtyGg04Uz
         GI1AGINhkMjS3ns+3VPlfu6Mh6vFoOOtJs4cCfWkDruoMd6nPAHv9Rg850DLASwqPq/E
         8fe2ayrx1VD3ey8pogBSl6GjaBUfbU6wWklfDgtt93hMum+352nT1tCs50+Ol5Vtk6lX
         5UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429377; x=1792034177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MtwhT83ye2QA4NSO+lP/kSrqtguUizhSwmlMJpYZtU8=;
        b=QlIE8TGG5FoF4p9W9J0yJXshUGEQlJ/uYVgm2SAK49iR87Ld4w1l3Cq+UMD/20+16A
         2ZWpNeCQXi43IpcDnPwghVBTT73RoEuEFcPYN4nETpLuuCbpbugqszVOas2++fs9FOkr
         mFp/u0kLJy8ImySI9m7uslTn9XcMJVUFZL14lRnK3dayqO6MzNrMzeMH/Um2+5ix7s7N
         2TWXWmTDToHBR9U3O5QDeqm8gw2edZFn40RTUySi2eNXLPhKuJdGLHT8FfjLAPm9byeW
         UP63eCzqpSPK9uggZgOCLscCfHAFAtTdKkFCbmvn9+smQP1qoMe3mLQLIxcj+oqgfwjC
         w4jg==
X-Forwarded-Encrypted: i=1; AKwUvBw9Dc2wC20puSF12bERiNRSQICg1tnTkeLJ+5RMT1OXAofmF+H/0RbEsJTi9mb60Jw5hFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz0RWbxt74wnkd4zkBIIhtlXYILQYCDHF3BNLcB7lS5s3a68t5
	BYGs+YLjV/hSdoOmki5h2eaA0oa9dIgtwgIuGfAqB0a+BJXNZuigDdDQa/F+SI/DBuKN5Zkfac7
	wDXEwmQ==
X-Received: from plry16.prod.google.com ([2002:a17:902:b490:b0:2e4:b5ea:194d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4b:b0:2dd:ad74:ac29
 with SMTP id d9443c01a7336-2e6004e31d4mr35125815ad.27.1791429376419; Wed, 07
 Oct 2026 20:16:16 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:30 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-11-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 10/10] selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test is roughly divided into two stages, and the sequence
is as follows:

  I) Setup

    1. Attach two BPF programs to a cgroup
    2. Establish a TCP connection (@client <-> @child) within the cgroup
    3. Enable BPF_TCP_OPS_FLAG_RCVQ on @child via setsockopt()

 II) RPC frame exchange in various patterns

    4. Send a partial RPC descriptor from @client to @child
    5. Verify that epoll does NOT wake up @child
    6. Send the remaining data of the RPC frame
    7. Verify that epoll finally wakes up @child

During setup, two BPF programs are attached to simulate
a real-world scenario; one is bpf_tcp_ops and the other is
CGROUP_SOCKOPT.

While the bpf_tcp_ops prog handles the dynamic adjustment of
sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
the TCP AutoLOWAT feature via userspace setsockopt() using
pseudo options:

  #define SOL_BPF               0xdeadbeef
  #define BPF_TCP_AUTOLOWAT     0x8badf00d

  setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));

This reflects a common production use case where an application
decides to start parsing RPC frames only at a certain point in
the stream (e.g., after HTTP Upgrade), rather than immediately
after TCP 3WHS (->passive_established(), etc).

When BPF_TCP_AUTOLOWAT is enabled, the BPF prog sets
BPF_TCP_OPS_FLAG_RCVQ and initializes sk_local_storage
for two sequence numbers to manage its state.

Then, for the RPC frame exchange, this test uses a simple format
defined as follows:

  0        8       16      24       32
  +--------+--------+-------+--------+ `.
  |            header size           |  |
  +--------+--------+-------+--------+   > RPC descriptor (8 bytes)
  |            payload size          |  |
  +--------+--------+-------+--------+ .'
  ~               header             ~
  +--------+--------+-------+--------+
  ~               payload            ~
  +--------+--------+-------+--------+

Every time a new skb is enqueued to sk->sk_receive_queue, the
bpf_tcp_ops prog parses it and updates these sequence numbers:

  rpc_desc_seq : the SEQ # of the start of the RPC descriptor
  rpc_end_seq  : the SEQ # of the end of the RPC frame
                 => rpc_desc_seq + 8 + header size + payload size

Assume we receive two RPC descriptors in the following pattern:

  1. When we receive skb-1, only part of the RPC descriptor is parsed.
     rpc_desc_seq is set to the first byte while rpc_end_seq is
     unknown.  Thus, sk->sk_rcvlowat is set to the size of the RPC
     descriptor (8 bytes).

   <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
  +-----------+.................+....................+......
  |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
  +-----------+.................+....................+......
  ^              ^-.
  `- rpc_desc_seq   `- sk->sk_rcvlowat

  2. Next, we receive skb-2, which completes the first RPC descriptor.
     Now rpc_end_seq is known, so sk->sk_rcvlowat is advanced to it.

   <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
  +-----------+-----------------+....................+......
  |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
  +-----------+-----------------+....................+......
  ^                                   ^
  '- rpc_desc_seq                     '- rpc_end_seq
                                           & sk->sk_rcvlowat

  3. Once we receive skb-3, which contains the next full RPC descriptor,
     rpc_desc_seq is advanced and rpc_end_seq is updated according
     to the size of RPC frame 2.

     Note that sk->sk_rcvlowat is NOT updated to the new rpc_end_seq
     yet.  This ensures that the application is woken up to read the
     already complete RPC frame 1.

   <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
  +-----------+-----------------+--------------------+......
  |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...   |
  +-----------+-----------------+--------------------+......
                                      ^                      ^
              rpc_desc_seq -----------'  rpc_end_seq ----...-'
                & sk->sk_rcvlowat

This sequence corresponds to the 4th test case in rpc_test_cases[],
and we can see helpful output if we "#define DEBUG":

  # cat /sys/kernel/tracing/trace_pipe | \
    awk '{ if ($0 ~ /AF_/) sub(/^.*AF_/, "AF_"); print $0 }' & \
    BGPID=$!; ./test_progs -t tcp_autolowat; kill -9 -$BGPID
  ...
  AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 0, end_seq: 1, len: 1, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 0
  AF_INET6 rpc_test_cases[3]: Copied 1 bytes: rpc_desc_buff_len: 1
  AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_desc_buff_len: 1
  AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 8, actual: 8

  AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 1, end_seq: 8, len: 7, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 1
  AF_INET6 rpc_test_cases[3]: Copied full descriptor: rpc_desc_seq: 0, rpc_end_seq: 258, header_len: 100, payload_len: 150
  AF_INET6 rpc_test_cases[3]: No more descriptor: rpc_end_seq: 258, end_seq: 8
  AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 258, rpc_desc_buff_len: 8
  AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 258, actual: 258
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v3:
  * Use bpf_tcp_ops_set_flags()

v2:
  * Avoid address comparison for a specific version of gcc.
  * Make rpc_test_cases[] static.
  * Update comment in rpc_test_case[].
---
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 294 +++++++++++++++
 3 files changed, 646 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
new file mode 100644
index 000000000000..337f9d34a39c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+#include <sys/epoll.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+#include "tcp_autolowat.skel.h"
+
+#define SOL_BPF			0xdeadbeef
+#define BPF_TCP_AUTOLOWAT	0x8badf00d
+
+struct rpc_descriptor {
+	u32 header_len;
+	u32 payload_len;
+};
+
+enum rpc_event_type {
+	RPC_EVENT_END,
+	RPC_EVENT_AUTOLOWAT,
+	RPC_EVENT_SEND,
+	RPC_EVENT_RECV,
+	RPC_EVENT_EPOLL,
+	RPC_EVENT_RCVLOWAT,
+};
+
+struct rpc_event {
+	enum rpc_event_type type;
+	union {
+		int len;
+		int nfds;
+		int val;
+		int rcvlowat;
+	};
+};
+
+#define RPC_DESC_SIZE (sizeof(struct rpc_descriptor))
+
+static struct rpc_test_case {
+	char data[4096];
+	struct rpc_descriptor desc[32];
+	struct rpc_event event[32];
+} rpc_test_cases[] = {
+	{
+		.desc = {
+			{ .header_len = 100, .payload_len = 150 },
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* Single full RPC message in skb. */
+			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE + 100 + 150},
+			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 100 + 150},
+		},
+	},
+	{
+		.desc = {
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* Two full RPC messages in skb. */
+			{.type = RPC_EVENT_SEND,	.len = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
+			/* Single full RPC message in skb. */
+			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE + 100 + 150},
+			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 3},
+		},
+	},
+	{
+		.desc = {
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* Two full RPC messages in skb. */
+			{.type = RPC_EVENT_SEND,	.len = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
+			/* Only the next descriptor in skb. */
+			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE},
+			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
+		},
+	},
+	{
+		.desc = {
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 200, .payload_len = 500},
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* The first descriptor is partial. */
+			{.type = RPC_EVENT_SEND,	.len = 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE},
+			/* The first descriptor is available. */
+			{.type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE - 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
+			/* The first header is ready. */
+			{.type = RPC_EVENT_SEND,	.len = 100},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
+			/* skb has the first payload and 1 byte of the next descriptor. */
+			{.type = RPC_EVENT_SEND,	.len = 150 + 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
+			/* After reading the first RPC message, SO_RCVLOWAT should be RPC_DESC_SIZE. */
+			{.type = RPC_EVENT_RECV,	.len = RPC_DESC_SIZE + 150 + 100},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE},
+			/* The second descriptor is available. */
+			{.type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE - 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 200 + 500},
+		},
+	},
+};
+
+struct tcp_autolowat_test_cb {
+	int saved_netns;
+	union {
+		int fd[4];
+		struct {
+			int server, client, child;
+			int epoll;
+		};
+	};
+};
+
+static void tcp_autolowat_teardown_cb(struct tcp_autolowat_test_cb *cb)
+{
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(cb->fd); i++) {
+		if (cb->fd[i] != -1)
+			close(cb->fd[i]);
+	}
+
+	if (cb->saved_netns != -1) {
+		err = setns(cb->saved_netns, CLONE_NEWNET);
+		ASSERT_OK(err, "restore netns");
+
+		close(cb->saved_netns);
+	}
+}
+
+static int tcp_autolowat_setup_cb(struct tcp_autolowat_test_cb *cb, int family)
+{
+	struct epoll_event ev = {};
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cb->fd); i++)
+		cb->fd[i] = -1;
+
+	cb->saved_netns = open("/proc/self/ns/net", O_RDONLY);
+	if (!ASSERT_OK_FD(cb->saved_netns, "save netns"))
+		goto err;
+
+	err = unshare(CLONE_NEWNET);
+	if (!ASSERT_OK(err, "unshare"))
+		goto err;
+
+	err = system("ip link set dev lo up");
+	if (!ASSERT_OK(err, "set up lo"))
+		goto err;
+
+	cb->server = start_server(family, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_OK_FD(cb->server, "start_server"))
+		goto err;
+
+	cb->client = connect_to_fd(cb->server, 0);
+	if (!ASSERT_OK_FD(cb->client, "connect_to_fd"))
+		goto err;
+
+	cb->child = accept(cb->server, NULL, NULL);
+	if (!ASSERT_OK_FD(cb->child, "accept"))
+		goto err;
+
+	cb->epoll = epoll_create1(0);
+	if (!ASSERT_OK_FD(cb->epoll, "epoll_create"))
+		goto err;
+
+	ev.events = EPOLLIN;
+	ev.data.fd = cb->child;
+
+	err = epoll_ctl(cb->epoll, EPOLL_CTL_ADD, cb->child, &ev);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto err;
+
+	return 0;
+
+err:
+	tcp_autolowat_teardown_cb(cb);
+	return -1;
+}
+
+static int tcp_autolowat_build_data(struct rpc_test_case *test_case)
+{
+	struct rpc_descriptor *desc = test_case->desc;
+	char *ptr = test_case->data;
+	int rpc_size;
+
+	memset(ptr, 0, sizeof(test_case->data));
+
+	while (desc->header_len + desc->payload_len) {
+		rpc_size = sizeof(*desc) + desc->header_len + desc->payload_len;
+
+		if (!ASSERT_LE(ptr + rpc_size - test_case->data,
+			       sizeof(test_case->data), "data overflow"))
+			return 1;
+
+		memcpy(ptr, desc, sizeof(*desc));
+		ptr += rpc_size;
+		desc++;
+	}
+
+	if (!ASSERT_GT(ptr - test_case->data, 0, "no data"))
+		return 1;
+
+	return 0;
+}
+
+static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *cb,
+				       struct rpc_test_case *test_case)
+{
+	struct rpc_event *event = test_case->event;
+	char *ptr = test_case->data;
+	struct epoll_event ev;
+	socklen_t optlen;
+	int err, optval;
+	char buf[4096];
+
+	if (tcp_autolowat_build_data(test_case))
+		return;
+
+	while (1) {
+		switch (event->type) {
+		case RPC_EVENT_END:
+			return;
+		case RPC_EVENT_AUTOLOWAT:
+			err = setsockopt(cb->child, SOL_BPF, BPF_TCP_AUTOLOWAT,
+					 &event->val, sizeof(event->val));
+			if (!ASSERT_OK(err, "setsockopt"))
+				return;
+			break;
+		case RPC_EVENT_SEND:
+			err = send(cb->client, ptr, event->len, 0);
+			if (!ASSERT_EQ(err, event->len, "send"))
+				return;
+
+			ptr += event->len;
+			break;
+		case RPC_EVENT_RECV:
+			err = recv(cb->child, buf, event->len, 0);
+			if (!ASSERT_EQ(err, event->len, "recv"))
+				return;
+			break;
+		case RPC_EVENT_EPOLL:
+			err = epoll_wait(cb->epoll, &ev, 1, 100);
+			if (!ASSERT_EQ(err, event->nfds, "epoll_wait"))
+				return;
+			break;
+		case RPC_EVENT_RCVLOWAT:
+			optval = 0;
+			optlen = sizeof(optval);
+
+			err = getsockopt(cb->child, SOL_SOCKET, SO_RCVLOWAT, &optval, &optlen);
+			if (!ASSERT_OK(err, "getsockopt") ||
+			    !ASSERT_EQ(optval, event->rcvlowat, "rcvlowat"))
+				return;
+			break;
+		}
+
+		event++;
+	}
+}
+
+static void tcp_autolowat_run_rpc_tests(struct tcp_autolowat *skel, int family)
+{
+	struct tcp_autolowat_test_cb cb;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rpc_test_cases); i++) {
+		memset(skel->bss->test_name, 0, sizeof(skel->bss->test_name));
+
+		snprintf(skel->bss->test_name, sizeof(skel->bss->test_name),
+			 "AF_INET%c rpc_test_cases[%d]",
+			 family == AF_INET ? ' ' : '6', i);
+
+		if (!test__start_subtest(skel->bss->test_name))
+			continue;
+
+		err = tcp_autolowat_setup_cb(&cb, family);
+		if (err)
+			continue;
+
+		tcp_autolowat_run_rpc_test(&cb, &rpc_test_cases[i]);
+		tcp_autolowat_teardown_cb(&cb);
+	}
+}
+
+static void tcp_autolowat_run_tests(struct tcp_autolowat *skel)
+{
+	tcp_autolowat_run_rpc_tests(skel, AF_INET);
+	tcp_autolowat_run_rpc_tests(skel, AF_INET6);
+}
+
+void test_tcp_autolowat(void)
+{
+	struct tcp_autolowat *skel;
+	struct bpf_link *link[2];
+	int cgroup;
+
+	skel = tcp_autolowat__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	cgroup = test__join_cgroup("/tcp_autolowat");
+	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
+		goto destroy_skel;
+
+	link[0] = bpf_map__attach_cgroup_opts(skel->maps.tcp_autolowat_ops, cgroup, NULL);
+	if (!ASSERT_OK_PTR(link[0], "attach_cgroup(tcp_autolowat_ops)"))
+		goto close_cgroup;
+
+	link[1] = bpf_program__attach_cgroup(skel->progs.tcp_autolowat_setsockopt, cgroup);
+	if (!ASSERT_OK_PTR(link[1], "attach_cgroup(SETSOCKOPT)"))
+		goto destroy_sockops;
+
+	tcp_autolowat_run_tests(skel);
+
+	bpf_link__destroy(link[1]);
+destroy_sockops:
+	bpf_link__destroy(link[0]);
+close_cgroup:
+	close(cgroup);
+destroy_skel:
+	tcp_autolowat__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 593b38f90417..4c999d59cbbc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -79,6 +79,8 @@
 
 #define NEXTHDR_TCP		6
 
+#define TCPHDR_FIN		0x01
+
 #define TCPOPT_NOP		1
 #define TCPOPT_EOL		0
 #define TCPOPT_MSS		2
diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
new file mode 100644
index 000000000000..8a55f3cee260
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+#include "vmlinux.h"
+
+#include <string.h>
+#include <limits.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_tracing_net.h"
+
+#define SOL_BPF			0xdeadbeef
+#define BPF_TCP_AUTOLOWAT	0x8badf00d
+
+//#define DEBUG /* For verbose output. */
+
+struct rpc_descriptor {
+	u32 header_len;
+	u32 payload_len;
+};
+
+#define RPC_DESC_SIZE		(sizeof(struct rpc_descriptor))
+#define MAX_RPC_DESC_PER_SKB	100
+
+struct tcp_autolowat_cb {
+	/* Don't put this field at the end; BPF verifier complains. */
+	char rpc_desc_buf[RPC_DESC_SIZE];
+	u32 rpc_desc_seq;
+	u32 rpc_end_seq;
+#ifdef DEBUG
+	u32 isn;
+#endif
+	u8 rpc_desc_buff_len;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct tcp_autolowat_cb);
+} tcp_autolowat_map SEC(".maps");
+
+char test_name[64];
+
+#ifdef DEBUG
+#define LOG(str, ...)							\
+	bpf_printk("%s: " str, test_name, ##__VA_ARGS__)
+#else
+#define LOG(...)
+#endif
+
+#define SEQ(val)				\
+	(val - cb->isn)
+#define TP_SEQ(field)				\
+	(tp->field - cb->isn)
+#define CB_SEQ(field)				\
+	(cb->field - cb->isn)
+
+static int tcp_parse_descriptor(struct tcp_autolowat_cb *cb,
+				struct bpf_dynptr *dptr,
+				u32 seq, u32 end_seq)
+{
+	struct rpc_descriptor *rpc_desc;
+	u32 rpc_copied_seq;
+	u64 copy_len; /* u32 should work, but not for no_alu32 :/ */
+	u64 rpc_len;
+	int err;
+
+	rpc_copied_seq = cb->rpc_desc_seq + cb->rpc_desc_buff_len;
+
+	if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
+		copy_len = RPC_DESC_SIZE - cb->rpc_desc_buff_len;
+	else
+		copy_len = end_seq - rpc_copied_seq;
+
+	if (copy_len == 0)
+		goto disable; /* FIN. */
+	if (copy_len > RPC_DESC_SIZE)
+		goto disable; /* always false, only for verifier. */
+	if (cb->rpc_desc_buff_len >= RPC_DESC_SIZE)
+		goto disable; /* always false, only for verifier. */
+
+	err = bpf_dynptr_read(cb->rpc_desc_buf + cb->rpc_desc_buff_len,
+			      copy_len, dptr, rpc_copied_seq - seq, 0);
+	if (err)
+		goto disable;
+
+	cb->rpc_desc_buff_len += copy_len;
+
+	if (cb->rpc_desc_buff_len != RPC_DESC_SIZE) {
+		LOG("Copied %d bytes: rpc_desc_buff_len: %u", copy_len, cb->rpc_desc_buff_len);
+		goto partial;
+	}
+
+	rpc_desc = (struct rpc_descriptor *)cb->rpc_desc_buf;
+	rpc_len = RPC_DESC_SIZE + rpc_desc->header_len + rpc_desc->payload_len;
+
+	if (rpc_len > INT_MAX)
+		goto disable;
+
+	cb->rpc_end_seq = cb->rpc_desc_seq + rpc_len;
+
+	LOG("Copied full descriptor: rpc_desc_seq: %u, rpc_end_seq: %u, header_len: %u, payload_len: %u",
+	    CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq),
+	    rpc_desc->header_len, rpc_desc->payload_len);
+
+	return 0;
+disable:
+	return -1;
+partial:
+	return 1;
+}
+
+static void tcp_set_autolowat(struct tcp_autolowat_cb *cb,
+			      struct sock *sk)
+{
+	struct tcp_sock *tp = (struct tcp_sock *)sk;
+	u32 val; /* To handle wraparound. */
+
+	LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_end_seq: %u, rpc_desc_buff_len: %u",
+	    TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq),
+	    CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
+
+	if (before(tp->copied_seq, cb->rpc_desc_seq))
+		val = cb->rpc_desc_seq - tp->copied_seq;
+	else if (cb->rpc_desc_buff_len != RPC_DESC_SIZE)
+		val = RPC_DESC_SIZE;
+	else
+		val = cb->rpc_end_seq - tp->copied_seq;
+
+	if (val != tp->inet_conn.icsk_inet.sk.sk_rcvlowat) {
+		bpf_tcp_ops_set_rcvlowat(sk, val);
+
+		LOG("Set rcvlowat: expected: %u, actual: %d\n",
+		    val, tp->inet_conn.icsk_inet.sk.sk_rcvlowat);
+	} else {
+		LOG("No need to set rcvlowat: %u\n", val);
+	}
+}
+
+static void tcp_disable_autolowat(struct sock *sk)
+{
+	bpf_tcp_ops_set_flags((struct tcp_sock *)sk, 0, BPF_TCP_OPS_FLAG_RCVQ);
+
+	bpf_tcp_ops_set_rcvlowat(sk, 1);
+
+	LOG("Disabled autolowat");
+}
+
+static void tcp_do_autolowat(struct tcp_autolowat_cb *cb,
+			     struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_dynptr dptr;
+	struct tcp_skb_cb *tcb;
+	u32 seq, end_seq;
+	int ret = 0, i;
+
+	if (bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &dptr)) {
+		ret = -1;
+		goto update;
+	}
+
+	tcb = bpf_core_cast(skb->cb, struct tcp_skb_cb);
+	seq = tcb->seq;
+	end_seq = tcb->end_seq - !!(tcb->tcp_flags & TCPHDR_FIN);
+
+	LOG("Start parsing skb: seq: %u, end_seq: %u, len: %u, rpc_desc_seq: %u, rpc_end_seq: %u, rpc_buff_len: %u",
+	    SEQ(seq), SEQ(end_seq), end_seq - seq,
+	    CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
+
+	if (cb->rpc_desc_buff_len != RPC_DESC_SIZE) {
+		ret = tcp_parse_descriptor(cb, &dptr, seq, end_seq);
+		if (ret)
+			goto update;
+	}
+
+	i = 0;
+
+	while (1) {
+		if (i++ > MAX_RPC_DESC_PER_SKB) {
+			ret = -1;
+			break;
+		}
+
+		if (after(cb->rpc_end_seq, end_seq)) {
+			LOG("No more descriptor: rpc_end_seq: %u, end_seq: %u",
+			    CB_SEQ(rpc_end_seq), SEQ(end_seq));
+			break;
+		}
+
+		cb->rpc_desc_seq = cb->rpc_end_seq;
+		cb->rpc_desc_buff_len = 0;
+
+		if (cb->rpc_end_seq == end_seq)
+			break;
+
+		LOG("Found next descriptor: rpc_end_seq: %u, end_seq: %u, len: %u",
+		    CB_SEQ(rpc_end_seq), SEQ(end_seq), end_seq - cb->rpc_end_seq);
+
+		ret = tcp_parse_descriptor(cb, &dptr, seq, end_seq);
+		if (ret)
+			break;
+	}
+
+update:
+	if (ret >= 0)
+		tcp_set_autolowat(cb, sk);
+	else
+		tcp_disable_autolowat(sk);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_autolowat_enqueue_rcvq, struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_autolowat_cb *cb;
+
+	cb = bpf_sk_storage_get(&tcp_autolowat_map, sk, 0, 0);
+	if (!cb)
+		return;
+
+	tcp_do_autolowat(cb, sk, skb);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_autolowat_dequeue_rcvq, struct sock *sk)
+{
+	struct tcp_autolowat_cb *cb;
+
+	cb = bpf_sk_storage_get(&tcp_autolowat_map, sk, 0, 0);
+	if (!cb)
+		return;
+
+	tcp_set_autolowat(cb, sk);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_autolowat_ops = {
+	.enqueue_rcvq = (void *)tcp_autolowat_enqueue_rcvq,
+	.dequeue_rcvq = (void *)tcp_autolowat_dequeue_rcvq,
+};
+
+static int tcp_init_autolowat_cb(struct bpf_tcp_sock *btp)
+{
+	struct tcp_autolowat_cb *cb;
+	struct tcp_sock *tp;
+
+	cb = bpf_sk_storage_get(&tcp_autolowat_map, btp, 0,
+				BPF_SK_STORAGE_GET_F_CREATE);
+	if (!cb)
+		return -1;
+
+	tp = bpf_core_cast(btp, struct tcp_sock);
+
+	cb->rpc_desc_seq = tp->copied_seq;
+	cb->rpc_end_seq = tp->copied_seq;
+#ifdef DEBUG
+	cb->isn = tp->copied_seq;
+#endif
+
+	return bpf_tcp_ops_set_flags((struct tcp_sock *)btp,
+				     BPF_TCP_OPS_FLAG_RCVQ, 0);
+}
+
+SEC("cgroup/setsockopt")
+int tcp_autolowat_setsockopt(struct bpf_sockopt *ctx)
+{
+	void *optval_end = ctx->optval_end;
+	int *optval = ctx->optval;
+	struct bpf_tcp_sock *btp;
+
+	if (ctx->level != SOL_BPF || ctx->optname != BPF_TCP_AUTOLOWAT)
+		goto out;
+
+	if (optval + 1 > optval_end)
+		return 0; /* -EPERM */
+
+	btp = bpf_tcp_sock(ctx->sk);
+	if (!btp)
+		goto out;
+
+	if (*optval && tcp_init_autolowat_cb(btp))
+		return 0; /* -EPERM */
+
+	/*
+	 * BPF has consumed this option, don't call kernel
+	 * setsockopt handler.
+	 */
+	ctx->optlen = -1;
+out:
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0.360.g66cac248cb-goog

