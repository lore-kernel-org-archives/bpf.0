Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A273BED0C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062231; cv=none; b=AVvBHY61NEDbrlydHEYwXOiJLPS62TKHvJJJy1hULGfnJhM1P/itk/S6oXsy+DqXnHI5L3zLmeUALaJpvD5jc7jgHaVghjwzomiMI271hMhuuRwQqIHyS6ANaeC2ePvOVM5ieI+0fOQxEAhTYyLAG4HS9Uoi2Rwuh7b3T0E28VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062231; c=relaxed/simple;
	bh=p6P2upvDYrxrm8Ve9VCzGqbWFNdhD/gVn/cBZDzidVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJmOOB+Y9j/FvF44jiRkEkk3VpFx6zieGCl4AV+8GTZE+aDT1qCqrdwr0Qxbbc8uizmatKR4SnrNZsJCedHM7qBAxHw4siJGVw7pfC9z+1u/ixor5ISXx8wVqH/ehlNseOGe1RVzkU8gdKcKOM87ceWDaVqfycSLnvfCdiVwH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQS8kPPK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQS8kPPK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso7159275e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062228; x=1773667028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbpdNkZtBh3lho4HVKBSl4XJuyTVjox0WRA0Zouwj70=;
        b=ZQS8kPPKbnPkR5W2EA+0DoLyg7NvS19w51UCPHaBysZr4aJQZiCdO4Nl3SQD7g57IA
         7FpoNwoj4Zn7bdvqiuQtO+gxPGefBVtsSA3sRK5tjvX/y4yM5dt1wXqCE8/R0sRYX0f0
         EzGkwD7TyU5kf3v3t6a0JOl2FOui5fNN9M85jFe66yEdAzcCALhMFGwbftiVL1JZInct
         vXOTHGehj+nfPBHWQvL8iBeyRRzcyg71eJGG9nKkCi+0VjyJMV8Rn9AoQJzaB9i8wG0U
         Tu9DbCmR2AcP1eMQ+avz28mhD1FuryBPeYdabR1dbtI+jZNmpzhdTlFjSRGl+NG2Do8b
         Ekfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062228; x=1773667028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbpdNkZtBh3lho4HVKBSl4XJuyTVjox0WRA0Zouwj70=;
        b=ONHyj20UcR+khfw5WFurvc9qq+i4A4iJ6iMCGSIEqSOxlKNNUTW3DIsxeLfXwhhTXV
         NaznSrCVz0vYbDAEF83Us/UIfvt6a+cK9KotigBNJCLnYkkDRDgb21+h209cZwNyLfEG
         Qfd83NdbBbCKZWvnXXe8jP1dVa+rF70Lc3vpXmy3CP8+xUFgMonDgNFx4KwM3ZrR8O7X
         ajx2K3p/fAVPNs++8nN+KnVKDTohEu2OqKiyQR4Dpe8pEDo0dVpCFGMakdAMqcPPuh1p
         Qf2FnZ3/oO2wkr9RHCHnBJzsh0bA/N74G6U5yoVOfmbF3t+qHArnwqsDiuB4dfotGE4e
         Pj1w==
X-Gm-Message-State: AOJu0YxI7dU3ym5Rs/WMhzN1hPhfV+8Lkzv5abgst750fUVPbVvefSk0
	kctQz6xWQl5SvU1gV5gToSEEfq3NcFGPAyytZouQk6ombvrMb6papEiiz5jE4l5nNew=
X-Gm-Gg: ATEYQzynN1G6uwrIK34XEUI8Tu0ps6tg7R2FBu76MBonDdWJbVyg0MX3FyGgFmfWBPv
	fbpVGLGEWk2Z7FRfse9KdoQuvzFQs3kbe6X1r5BgYuHIpwsPzGeVLRS1GtSDpv/IuNdVPvUOHZt
	QpCXJjewppQijBauRLRJJW25EaLjuE8NBWRVzm2T+UCppmFTfa9ThGTpB+4yRQobr7v8pco+9U0
	AIRuKZVkaWbHh7s4tx16VR/E3OOK2PbkvndzFi8MgaLf687uxq+TTzK8g7OxjgO+/qk1vDyDuh2
	aT0nVe6abY7UwHdD1Hz/xRSA3MsPQeRMbolXhuZK+K/hlHwVGoXMlj9BpamNs1UGWkHejjOAJ01
	bon8BC7z3Re0BGIPlk23uF/xOzUyti/oDlZFqt1VUKhwOyuso+wOJPoNdnaOcKFqjQRf90g4iEJ
	/JBxX/MGyLof5CKzVDr9NOuyM9w6ecioHccViKBg==
X-Received: by 2002:a05:600c:c16d:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-4853f306de9mr25696935e9.20.1773062228250;
        Mon, 09 Mar 2026 06:17:08 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-485246ece8bsm128506395e9.4.2026.03.09.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:17:07 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [RFC PATCH bpf-next 2/4] selftests/bpf: Add netpoll kfunc sanity test
Date: Mon,  9 Mar 2026 13:16:33 +0000
Message-Id: <20260309131635.302424-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309131635.302424-1-mahe.tardy@gmail.com>
References: <20260309131635.302424-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

Add a selftest that exercises the bpf_netpoll kfuncs end-to-end:

  1. A SYSCALL BPF program creates a netpoll context on a dummy
     network device and stores it in a kptr map.
  2. A fentry program is attached to dummy_xmit, the driver function
     that will receive the netpoll sent packet.
  3. An LSM program attached to security_file_open retrieves the
     context from the map and calls bpf_netpoll_send_udp().

The userspace harness creates a network namespace with a dummy device,
runs the setup program, attach the fentry hook then triggers the LSM
hook by opening /dev/null. The dummy device accepts all packets, so
send_status == 0 confirms success and the packet content is verified by
reading the skb from the dummy driver xmit function.

The code was partially generated by AI and each line was manually
reviewed.

Signed-off-by: Song Liu <song@kernel.org>
Co-developed-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/netpoll.c        |  92 ++++++++++++++
 .../selftests/bpf/progs/netpoll_common.h      |  64 ++++++++++
 .../selftests/bpf/progs/netpoll_sanity.c      | 118 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netpoll.c
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_sanity.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 24855381290d..bd6d0a4e5239 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,6 +7,7 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
+CONFIG_BPF_NETPOLL=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
diff --git a/tools/testing/selftests/bpf/prog_tests/netpoll.c b/tools/testing/selftests/bpf/prog_tests/netpoll.c
new file mode 100644
index 000000000000..1cfac4b13e7d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/netpoll.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <arpa/inet.h>
+#include <net/if.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "netpoll_sanity.skel.h"
+
+#define NS_TEST "netpoll_sanity_ns"
+#define DUMMY_DEV "dummy0"
+#define DUMMY_IP "10.0.0.1"
+#define REMOTE_IP "10.0.0.2"
+
+void test_netpoll_sanity(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct nstoken *nstoken = NULL;
+	struct netpoll_sanity *skel;
+	int err, pfd, fd;
+
+	skel = netpoll_sanity__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	/* Create a network namespace with a dummy device */
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link add %s type dummy", NS_TEST, DUMMY_DEV);
+	SYS(fail, "ip -net %s addr add %s/24 dev %s", NS_TEST, DUMMY_IP, DUMMY_DEV);
+	SYS(fail, "ip -net %s link set %s up", NS_TEST, DUMMY_DEV);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	/* Configure the BPF program globals */
+	snprintf(skel->bss->dev_name, sizeof(skel->bss->dev_name), "%s", DUMMY_DEV);
+	skel->bss->remote_ip = inet_addr(REMOTE_IP);
+	skel->bss->local_port = 5555;
+	skel->bss->remote_port = 6666;
+	skel->bss->remote_mac[0] = 0xaa;
+	skel->bss->remote_mac[1] = 0xbb;
+	skel->bss->remote_mac[2] = 0xcc;
+	skel->bss->remote_mac[3] = 0xdd;
+	skel->bss->remote_mac[4] = 0xee;
+	skel->bss->remote_mac[5] = 0xff;
+
+	/* Step 1: Run the setup SYSCALL prog */
+	pfd = bpf_program__fd(skel->progs.netpoll_setup_test);
+	if (!ASSERT_GT(pfd, 0, "netpoll_setup_test fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "netpoll_setup_test run"))
+		goto fail;
+
+	if (!ASSERT_OK(skel->bss->status, "netpoll_setup_test status"))
+		goto fail;
+
+	/* Step 2: Attach the dummy xmit hook */
+	skel->links.netpoll_dummy_xmit = bpf_program__attach(skel->progs.netpoll_dummy_xmit);
+	if (!ASSERT_OK_PTR(skel->links.netpoll_dummy_xmit, "attach netpoll_dummy_xmit"))
+		goto fail;
+
+	/* Step 3: Attach the LSM prog and trigger via file_open */
+	skel->links.netpoll_send_test = bpf_program__attach(skel->progs.netpoll_send_test);
+	if (!ASSERT_OK_PTR(skel->links.netpoll_send_test, "attach netpoll_send_test"))
+		goto fail;
+
+	skel->bss->trigger_send = 1;
+
+	fd = open("/dev/null", O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open /dev/null"))
+		goto fail;
+	close(fd);
+
+	/* send_status should be 0 (NETDEV_TX_OK) -- dummy device accepts
+	 * all packets.
+	 */
+	ASSERT_OK(skel->bss->send_status, "netpoll_send_udp status");
+	/* dummy_xmit hooks the dummy driver ndo_start_xmit method called by
+	 * netpoll and fetches the UDP payload.
+	 */
+	ASSERT_STREQ(skel->bss->driver_xmit, skel->data->send_data, "dummy_xmit received");
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	netpoll_sanity__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/netpoll_common.h b/tools/testing/selftests/bpf/progs/netpoll_common.h
new file mode 100644
index 000000000000..d1e4b2a58adb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/netpoll_common.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _NETPOLL_COMMON_H
+#define _NETPOLL_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+struct bpf_netpoll *bpf_netpoll_create(const struct bpf_netpoll_opts *opts,
+				       u32 opts__sz, int *err) __ksym;
+struct bpf_netpoll *bpf_netpoll_acquire(struct bpf_netpoll *bnp) __ksym;
+void bpf_netpoll_release(struct bpf_netpoll *bnp) __ksym;
+int bpf_netpoll_send_udp(struct bpf_netpoll *bnp,
+			 const void *data, u32 data__sz) __ksym;
+
+struct __netpoll_ctx_value {
+	struct bpf_netpoll __kptr * ctx;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __netpoll_ctx_value);
+	__uint(max_entries, 1);
+} __netpoll_ctx_map SEC(".maps");
+
+static inline struct __netpoll_ctx_value *netpoll_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__netpoll_ctx_map, &key);
+}
+
+static inline int netpoll_ctx_insert(struct bpf_netpoll *ctx)
+{
+	struct __netpoll_ctx_value local, *v;
+	struct bpf_netpoll *old;
+	u32 key = 0;
+	int err;
+
+	local.ctx = NULL;
+	err = bpf_map_update_elem(&__netpoll_ctx_map, &key, &local, 0);
+	if (err) {
+		bpf_netpoll_release(ctx);
+		return err;
+	}
+
+	v = bpf_map_lookup_elem(&__netpoll_ctx_map, &key);
+	if (!v) {
+		bpf_netpoll_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_netpoll_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _NETPOLL_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/netpoll_sanity.c b/tools/testing/selftests/bpf/progs/netpoll_sanity.c
new file mode 100644
index 000000000000..9e1e595eff2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/netpoll_sanity.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/* Copyright (c) 2026 Isovalent. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+#include "netpoll_common.h"
+
+/* Globals for passing config from userspace */
+char dev_name[16] = {};
+__be32 remote_ip;
+__u16 local_port;
+__u16 remote_port;
+__u8 remote_mac[6] = {};
+
+/* Results */
+int status;
+int send_status;
+int trigger_send;
+char driver_xmit[64];
+
+char send_data[64] = "hello from bpf netpoll";
+
+/* SYSCALL prog: set up the netpoll context */
+SEC("syscall")
+int netpoll_setup_test(void *ctx)
+{
+	struct bpf_netpoll_opts opts = {};
+	struct bpf_netpoll *bnp;
+	int err = 0;
+
+	status = 0;
+
+	__builtin_memcpy(opts.dev_name, dev_name, 16);
+	opts.remote_ip = remote_ip;
+	opts.local_port = local_port;
+	opts.remote_port = remote_port;
+	__builtin_memcpy(opts.remote_mac, remote_mac, 6);
+
+	bnp = bpf_netpoll_create(&opts, sizeof(opts), &err);
+	if (!bnp) {
+		status = err;
+		return 0;
+	}
+
+	err = netpoll_ctx_insert(bnp);
+	if (err && err != -EEXIST)
+		status = err;
+	return 0;
+}
+
+/* LSM prog: send UDP via the stored netpoll context */
+SEC("lsm/file_open")
+int BPF_PROG(netpoll_send_test, struct file *file)
+{
+	struct __netpoll_ctx_value *v;
+	struct bpf_netpoll *bnp;
+
+	if (!trigger_send)
+		return 0;
+
+	trigger_send = 0;
+	send_status = -ENOENT;
+
+	v = netpoll_ctx_value_lookup();
+	if (!v)
+		return 0;
+
+	bpf_rcu_read_lock();
+	bnp = v->ctx;
+	if (!bnp) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	send_status = bpf_netpoll_send_udp(bnp, send_data, sizeof(send_data));
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+/* Fentry prog: hook the dummy driver xmit */
+SEC("fentry/dummy_xmit")
+int BPF_PROG(netpoll_dummy_xmit, struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned char *data;
+	struct ethhdr eth;
+	struct iphdr ip;
+	struct udphdr udp;
+
+	if (bpf_probe_read_kernel(&data, sizeof(data), &skb->data) < 0)
+		return 0;
+	if (!data)
+		return 0;
+
+	if (bpf_probe_read_kernel(&eth, sizeof(eth), data) < 0)
+		return 0;
+	if (eth.h_proto != bpf_htons(ETH_P_IP))
+		return 0;
+
+	if (bpf_probe_read_kernel(&ip, sizeof(ip), data + sizeof(struct ethhdr)) < 0)
+		return 0;
+	if (ip.protocol != IPPROTO_UDP)
+		return 0;
+
+	if (bpf_probe_read_kernel(&udp, sizeof(udp), data + sizeof(struct ethhdr) + (ip.ihl * 4)) < 0)
+		return 0;
+	if (udp.dest != bpf_htons(remote_port))
+		return 0;
+	if (bpf_probe_read_kernel(&driver_xmit, sizeof(driver_xmit), data + sizeof(struct ethhdr) + (ip.ihl * 4) + sizeof(struct udphdr)) < 0)
+		return 0;
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.34.1

