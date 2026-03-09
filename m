Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AA3BED06
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062231; cv=none; b=L7Idq9v2wWgAUZ5Kr/BwbieEAYhZfnGT9XP2ZWEaYbA8j8mfNwR+bjX+9xNPRXPIhX6itXwmW5ChAbs7M+F4hrPSQCRntfwijgNRXlFosjZcJ8EA9y9+U+rTG4HPuYRRlw8CuirBGqQQJ5E680YSNOvrbu4ytYDfHjx7LDFMOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062231; c=relaxed/simple;
	bh=U7qs3pJPi50IIefjxBx4ShSRUKAh9miyx1yacOnYk6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmMMNaEiUz4kFQS9qitVXshWYiRIgK4HpgMzCz2UneA1V9YTWp9Gp8xq/XDM7auAJs3mmczc0Tm3mK7Vo1fyUUyoOPmJ7WvTsHN7OmU3F0vC71HATeAWaEa5CQJ3AREVrDoo2eFh2OFTtwVDjmIfE4+H51gR+rtaRaR/V9bHOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFuVgakJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFuVgakJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-485409ab264so2455065e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062228; x=1773667028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVmAxn96vaVij5OcgLRdgbgTTvNn4s8rPlJH1JjZrQg=;
        b=FFuVgakJKx69Yj8/O+c2l4HWOAi7FgwbYVc/PzHvoiWHePCS4A1MnD4TrSBRYlxPFv
         V2F4a2vcvqHjLfLDsHdJsUF3mQMSJtl0/hvHoqNdf16O3T/AX3aedbJUg5kpRj6Tmu9O
         x3mhnh+rPj2Be61RdWaxvp1/dsFftcLEbn+vU4+A9ODy9TplEo/hhDTitAQCOVojO6IP
         PWF1sBN2vXoP8VYPTpq0hb0I2H72lfXfLBGdP+yPm9zKnX9/8MKYYSHreVrprC/3f/Fk
         7FbWT5c1ZhRnB0Wn8vxpYgDLHHfEjFpE8lZ0qq7i71xeX3QthCMzTml3ayUy5T5EhYNm
         zQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062228; x=1773667028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVmAxn96vaVij5OcgLRdgbgTTvNn4s8rPlJH1JjZrQg=;
        b=G2ZUzIipVEV9ehVTw7yuV+5WHLX9sdtAF62D0+gRe/ktkWIfZ+i7jYSlCnBCkxfSjX
         +4nzi7J4zrSnh9GIWw6o9kgfRNDE+gT3HbGk0efwcyrGJdZj3OiKTdnyxqiT3Zny62md
         P/jfh1IX2xXXsL0IBh01e4oYsqv7V0RLtdDcYXipMEPtlzAtPCEdQ5B0MmR5/mWIIy7M
         PDOYbs3ZVSJ2WUhz1tAanMwKz2xGXB4zCrSo3Xa5CopONLilZImt0PB4Am7xA29/16MV
         Ull9Jk9odJIsj720/bSZP7ZS8iakBhjiqxh0WXNl9vH3qEJ3xRCYiT+QKvgodZPh1It2
         ZiwQ==
X-Gm-Message-State: AOJu0Yyg3EYq4zuldKXTNHm/Z6qHPcPo7lexJvnlFJbZO8easv6trE0Q
	/4XDCOGAEQ3cz1ofUSZOf+rWThhKXhBUsygTHLwEdvN0muj3rW4tFeA3cv8u5ZzKAE8=
X-Gm-Gg: ATEYQzwRUBKR4iwpHK+/UKqpR77+LKIEyFqlpVOaFBisNOxJFS7JqDmaWq4oAltMgxS
	o401BjJXvHoB2jSa2lpFLjk79KEkGb6JxpAdPdYL8MzOBgWCJy7R1eeOcg2fx9nX8oJfVkHgH+1
	LhQfByFIBqu6XG6xvE8QxIeqxorAvxlKNAFftg40c4EyRLL6VVZidAy+AT9i2pyxIgofPFKqu94
	d53xy3EaW0UKcH7xx7blLjyWAJ13RJHvFtaGS/rxw22dRwY0TBC4RGrf27rVUmjuqT0a/+55yJH
	WIqZflNETd28nJUK8cqo/aVbfTUxFgYhFvCFWbeodls8EXDNdKO62hWD+dE1W5IZgTmTDSkJJ3D
	Dn+VzMbq8n0zodO3ctmomm6LsAjfvD2UHOn6JRgBXJq4r3uGiaq9ug5aH2bLiF7gJCFXnq8KhMs
	x1jRY5vQqzkIOAcW8hUr956EgipAE=
X-Received: by 2002:a05:600c:37cc:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-4853f580fd9mr22834575e9.16.1773062227535;
        Mon, 09 Mar 2026 06:17:07 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-485246ece8bsm128506395e9.4.2026.03.09.06.17.06
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
Subject: [RFC PATCH bpf-next 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Date: Mon,  9 Mar 2026 13:16:32 +0000
Message-Id: <20260309131635.302424-2-mahe.tardy@gmail.com>
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

Add BPF kfuncs that allow BPF programs to send UDP packets via the
netpoll infrastructure. This provides a mechanism for BPF programs
(e.g., LSM hooks) to emit telemetry over UDP without depending on
the regular networking stack.

The API consists of four kfuncs:

  bpf_netpoll_create()   - Allocate and set up a netpoll context
                           (sleepable, SYSCALL prog type only)
  bpf_netpoll_acquire()  - Acquire a reference to a netpoll context
  bpf_netpoll_release()  - Release a reference (cleanup via
                           queue_rcu_work since netpoll_cleanup sleeps)
  bpf_netpoll_send_udp() - Send a UDP packet (any context, LSM prog
                           type only for now)

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration). The netpoll context is wrapped in a refcounted
bpf_netpoll struct. Cleanup is deferred via queue_rcu_work() because
netpoll_cleanup() takes rtnl_lock.

AI was used to generate the code and each line was manually reviewed.

Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 drivers/net/Kconfig         |  11 ++
 include/linux/bpf_netpoll.h |  38 +++++++
 kernel/bpf/verifier.c       |   3 +
 net/core/Makefile           |   1 +
 net/core/bpf_netpoll.c      | 209 ++++++++++++++++++++++++++++++++++++
 5 files changed, 262 insertions(+)
 create mode 100644 include/linux/bpf_netpoll.h
 create mode 100644 net/core/bpf_netpoll.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 17108c359216..1d7bcd07f60a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -371,6 +371,17 @@ config NETCONSOLE_PREPEND_RELEASE
 	  message.  See <file:Documentation/networking/netconsole.rst> for
 	  details.
 
+config BPF_NETPOLL
+	bool "BPF netpoll UDP support"
+	depends on BPF_SYSCALL && NET
+	select NETPOLL
+	help
+	  Enable BPF kfuncs for sending UDP packets via netpoll.
+	  This allows BPF programs to send UDP packets from any
+	  context using the netpoll infrastructure.
+
+	  If unsure, say N.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/include/linux/bpf_netpoll.h b/include/linux/bpf_netpoll.h
new file mode 100644
index 000000000000..b738032548c7
--- /dev/null
+++ b/include/linux/bpf_netpoll.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _BPF_NETPOLL_H
+#define _BPF_NETPOLL_H
+
+#include <linux/types.h>
+
+#define BPF_NETPOLL_DEV_NAME_LEN 16	/* IFNAMSIZ */
+
+/**
+ * struct bpf_netpoll_opts - BPF netpoll initialization parameters
+ * @dev_name:	Network device name (e.g. "eth0"), null-terminated.
+ * @local_ip:	Local IPv4 address in network byte order. 0 = auto-detect.
+ * @remote_ip:	Remote IPv4 address in network byte order.
+ * @local_port:	Local UDP port in host byte order.
+ * @remote_port: Remote UDP port in host byte order.
+ * @remote_mac:	Remote MAC address (6 bytes).
+ * @ipv6:	Set to 1 for IPv6, 0 for IPv4.
+ * @reserved:	Must be zero. Reserved for future use.
+ * @local_ip6:	Local IPv6 address (16 bytes). Used when ipv6=1.
+ *		Zero = auto-detect.
+ * @remote_ip6:	Remote IPv6 address (16 bytes). Used when ipv6=1.
+ */
+struct bpf_netpoll_opts {
+	char dev_name[BPF_NETPOLL_DEV_NAME_LEN];
+	__be32 local_ip;
+	__be32 remote_ip;
+	__u16 local_port;
+	__u16 remote_port;
+	__u8 remote_mac[6];
+	__u8 ipv6;
+	__u8 reserved;
+	__u8 local_ip6[16];
+	__u8 remote_ip6[16];
+};
+
+#endif /* _BPF_NETPOLL_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..07cfb69e3946 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6037,6 +6037,9 @@ BTF_ID(struct, task_struct)
 #ifdef CONFIG_CRYPTO
 BTF_ID(struct, bpf_crypto_ctx)
 #endif
+#ifdef CONFIG_BPF_NETPOLL
+BTF_ID(struct, bpf_netpoll)
+#endif
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
diff --git a/net/core/Makefile b/net/core/Makefile
index dc17c5a61e9a..6484eb595698 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_NETPOLL) += netpoll.o
+obj-$(CONFIG_BPF_NETPOLL) += bpf_netpoll.o
 obj-$(CONFIG_FIB_RULES) += fib_rules.o
 obj-$(CONFIG_TRACEPOINTS) += net-traces.o
 obj-$(CONFIG_NET_DROP_MONITOR) += drop_monitor.o
diff --git a/net/core/bpf_netpoll.c b/net/core/bpf_netpoll.c
new file mode 100644
index 000000000000..1d01d5f43ee1
--- /dev/null
+++ b/net/core/bpf_netpoll.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <linux/bpf_netpoll.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/netpoll.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#define BPF_NETPOLL_MAX_UDP_CHUNK 1460
+
+/**
+ * struct bpf_netpoll - refcounted BPF netpoll context
+ * @np:		The underlying netpoll structure.
+ * @usage:	Reference counter.
+ * @rwork:	RCU work for deferred cleanup (netpoll_cleanup sleeps).
+ */
+struct bpf_netpoll {
+	struct netpoll np;
+	refcount_t usage;
+	struct rcu_work rwork;
+};
+
+static void netpoll_release_work_fn(struct work_struct *work)
+{
+	struct bpf_netpoll *bnp = container_of(to_rcu_work(work),
+					       struct bpf_netpoll, rwork);
+
+	netpoll_cleanup(&bnp->np);
+	kfree(bnp);
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_netpoll_create() - Create a BPF netpoll context for sending UDP.
+ *
+ * Allocates and sets up a netpoll context that can be used to send UDP
+ * packets from BPF programs. The returned context must either be stored
+ * in a map as a kptr, or freed with bpf_netpoll_release().
+ *
+ * This function calls netpoll_setup() which takes rtnl_lock and may
+ * sleep, so it can only be used in sleepable BPF programs (SYSCALL).
+ *
+ * @opts:	Pointer to struct bpf_netpoll_opts with connection parameters.
+ * @opts__sz:	Size of the opts struct.
+ * @err:	Integer to store error code when NULL is returned.
+ */
+__bpf_kfunc struct bpf_netpoll *
+bpf_netpoll_create(const struct bpf_netpoll_opts *opts, u32 opts__sz, int *err)
+{
+	struct bpf_netpoll *bnp;
+
+	if (!opts || opts__sz != sizeof(struct bpf_netpoll_opts)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (opts->reserved) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	bnp = kzalloc(sizeof(*bnp), GFP_KERNEL);
+	if (!bnp) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	bnp->np.name = "bpf_netpoll";
+	strscpy(bnp->np.dev_name, opts->dev_name, IFNAMSIZ);
+	bnp->np.local_port = opts->local_port;
+	bnp->np.remote_port = opts->remote_port;
+	memcpy(bnp->np.remote_mac, opts->remote_mac, ETH_ALEN);
+
+	bnp->np.ipv6 = !!opts->ipv6;
+	if (opts->ipv6) {
+		memcpy(&bnp->np.local_ip.in6, opts->local_ip6,
+		       sizeof(struct in6_addr));
+		memcpy(&bnp->np.remote_ip.in6, opts->remote_ip6,
+		       sizeof(struct in6_addr));
+	} else {
+		bnp->np.local_ip.ip = opts->local_ip;
+		bnp->np.remote_ip.ip = opts->remote_ip;
+	}
+
+	*err = netpoll_setup(&bnp->np);
+	if (*err) {
+		kfree(bnp);
+		return NULL;
+	}
+
+	refcount_set(&bnp->usage, 1);
+	return bnp;
+}
+
+/**
+ * bpf_netpoll_acquire() - Acquire a reference to a BPF netpoll context.
+ * @bnp:	The BPF netpoll context to acquire. Must be a trusted pointer.
+ *
+ * The acquired context must either be stored in a map as a kptr, or
+ * freed with bpf_netpoll_release().
+ */
+__bpf_kfunc struct bpf_netpoll *
+bpf_netpoll_acquire(struct bpf_netpoll *bnp)
+{
+	if (!refcount_inc_not_zero(&bnp->usage))
+		return NULL;
+	return bnp;
+}
+
+/**
+ * bpf_netpoll_release() - Release a BPF netpoll context.
+ * @bnp:	The BPF netpoll context to release.
+ *
+ * When the final reference is released, the netpoll context is cleaned
+ * up via queue_rcu_work() (since netpoll_cleanup takes rtnl_lock and
+ * must run in process context).
+ */
+__bpf_kfunc void bpf_netpoll_release(struct bpf_netpoll *bnp)
+{
+	if (refcount_dec_and_test(&bnp->usage)) {
+		INIT_RCU_WORK(&bnp->rwork, netpoll_release_work_fn);
+		queue_rcu_work(system_wq, &bnp->rwork);
+	}
+}
+
+__bpf_kfunc void bpf_netpoll_release_dtor(void *bnp)
+{
+	bpf_netpoll_release(bnp);
+}
+CFI_NOSEAL(bpf_netpoll_release_dtor);
+
+/**
+ * bpf_netpoll_send_udp() - Send a UDP packet via netpoll.
+ * @bnp:	The BPF netpoll context. Must be an RCU-protected pointer.
+ * @data:	Pointer to the data to send.
+ * @data__sz:	Size of the data to send (max 1460 bytes).
+ *
+ * Sends a UDP packet using the netpoll infrastructure. Can be called
+ * from any context (process, softirq, hardirq).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_netpoll_send_udp(struct bpf_netpoll *bnp,
+				     const void *data, u32 data__sz)
+{
+	unsigned long flags;
+	int ret;
+
+	if (data__sz > BPF_NETPOLL_MAX_UDP_CHUNK)
+		return -E2BIG;
+
+	local_irq_save(flags);
+	ret = netpoll_send_udp(&bnp->np, data, data__sz);
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(netpoll_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_netpoll_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_netpoll_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_netpoll_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_KFUNCS_END(netpoll_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set netpoll_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &netpoll_init_kfunc_btf_ids,
+};
+
+BTF_KFUNCS_START(netpoll_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_netpoll_send_udp, KF_RCU)
+BTF_KFUNCS_END(netpoll_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set netpoll_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &netpoll_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(bpf_netpoll_dtor_ids)
+BTF_ID(struct, bpf_netpoll)
+BTF_ID(func, bpf_netpoll_release_dtor)
+
+static int __init bpf_netpoll_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc bpf_netpoll_dtors[] = {
+		{
+			.btf_id       = bpf_netpoll_dtor_ids[0],
+			.kfunc_btf_id = bpf_netpoll_dtor_ids[1],
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&netpoll_init_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					       &netpoll_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_netpoll_dtors,
+						  ARRAY_SIZE(bpf_netpoll_dtors),
+						  THIS_MODULE);
+}
+
+late_initcall(bpf_netpoll_kfunc_init);
-- 
2.34.1

