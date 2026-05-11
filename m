Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40D3BED32
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489645; cv=none; b=hFDqS50Ph14ke4lasl/R6hIr6Clr8v5nVcwJHQduTHi+LriwuwhBPOsLYigenjPO4haeaGyrN8IUkO6h5c5n0nwfoM3jDocMejVMsl4cXP71c3jgriU1ZGG5iaqUadOonTq36RofeYPDRNZHmFxXmVgkWBhT3JHe37G4h5q0oUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489645; c=relaxed/simple;
	bh=ZlCylw6AtlO5/HnzC05Ww8PfKrw0MpZQH1w4LqUgCm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWdzYBDNA4RDFMBTeF2IT8xfdzSIETrvpRKj90Rh/kO4gidSW2wcBEX3c8CfQbcpAu/sJa6qh1a8MYB3ZV+WaPZbq4pTzTAOjIETjKBEiruYZfzrptnI2VcUln2Tz8oA3csGdno82BJ6DBm8x10WyZvyxSG/x7LUPo6yqAkSOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+3Xb3Y8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+3Xb3Y8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-459bf19e87bso232642f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489642; x=1779094442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbpdNkZtBh3lho4HVKBSl4XJuyTVjox0WRA0Zouwj70=;
        b=H+3Xb3Y8RpdJnPO++NtMDGri86gOSDsjK00cB0LmC0VnTPHfzUVgGvZ6qq89hzDd82
         H+cuIIsxkW4JqZ0uSe8TZCQKR8aulfmpM2vsO1bK6lQ5bHFn+bVzh/3oGAhT8udZrxoE
         w+Hd3Z2WCmN2bnZiUIqj8veHrDPATsIjxsu7ggyzKFvT+2+dtrCZXFtfe0dl4GgW2fzq
         A+Bvdz1XhMfcUrmM0tXBLxZ6SywRxAsgAZzslU+PidjCr9WFQW4YGBZseNosNkQkpE7s
         X4GJiAdF4DltL8FGxf5akHtY2zkhBNOB8GpjFRhgdCcsCTwP01WdB7EEv9ZGj7oXq0mL
         DEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489642; x=1779094442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbpdNkZtBh3lho4HVKBSl4XJuyTVjox0WRA0Zouwj70=;
        b=JTuKSJm/iIMLThPTMarlI/Aoy/v3iR6ayTrbrsZwfHFpq07kpRUk+Uyb3FUPNFJlm+
         IdQP8Wj6nuFNiPJegQcDAFx1GlHQeaAqj+pDXs7UBMFfnGCo+fjBVMJUimbQPQl+iz5c
         XE/PutbJoKLi/s6ktQs192OIChuCXiKhCoAvHJJn25Oonl+PuAul+iBsIpWY1843e7YG
         N+w+N3H/C92Xttnbly/R8q/sxYnkYFe6tVZNbiRY2wvPWb8gSsYdNCdsgD1PYBANAwY/
         MiUaLOyjD1IkTJuDXPB4LdDT78Htp0MBKfQBkRhKe1saWycWcHpZra4YXEyf9R0BsKMU
         EvlA==
X-Gm-Message-State: AOJu0YytKYiXEeWfgAKtBp4niysU73B8LaKG19wGpUIBWNrFueQpAgGW
	+0KcBuVae3oWX7b4IYD7WP5bkiZRPtsDflVmdjtUoXh6W97KFHgx3NXDVRfoiDubd48=
X-Gm-Gg: Acq92OGXT6vSUuqyeMannzE8C1co/EnAz0mZ5vrOA03UBrW3nZ9aYCWCpJVzP4JGVOv
	3TbmiCg6zdEpcBOHzqc3NvKmhjBg6xBoAYdxwGDWINR9mO4KBdCLyiklzjGv/n1Vq96Edy6Ww6K
	uDGA8vAhCU6Ck1ADIXAh70wRleSKTPtu2wBuf6kgEGbRtGtTSnuso8zASQpIeMM0eAEDiQW+M92
	DIn/vkt9gZu0mmToyKnRLgGrPchX4DuDpCcxEO6nNJjVnGioeZ3tzQMbeExJEZGQhasVI6esTYE
	SXaF0SzeGTjN3dFvLU6+EWqp/n5w/ChGFUchtncp0zzSJ575SCekpDSgvYoh1bDSOmdEyilaDBm
	/FZbashdjTIsX37kf0kE9oMw7S0gD6fAz8Wowh8XHDV+IpmYc2VQu0OzrVUx0ULXKw4ZnsdMV+c
	CdmscH45wy0IIAc0D8LjDl6v27Dv0=
X-Received: by 2002:a05:6000:4304:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-45462c35512mr22926843f8f.23.1778489641644;
        Mon, 11 May 2026 01:54:01 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23817156f8f.27.2026.05.11.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:01 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	liamwisehart@meta.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH v1 2/4] selftests/bpf: Add netpoll kfunc sanity test
Date: Mon, 11 May 2026 08:53:42 +0000
Message-Id: <20260511085344.3302-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511085344.3302-1-mahe.tardy@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
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

