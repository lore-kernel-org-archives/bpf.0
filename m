Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE983C3C0B
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489644; cv=none; b=aY9fdfszxEDlaZZY4lj6K/2bgnhv/7wOheQNhgo8VPrrWYKdYtbbuvtR+JUl2mPeMvBviT6XVraq4nxCKJtW3VHI2LROZQVsRo99+oOlDkXFOolCnu5/e8aqJVeCn3pkNaNAVwSMHdenNaQlwse5PJFL2IYJ/5XkL9XpJK5i0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489644; c=relaxed/simple;
	bh=KaVvP7Fku3ZBQFJjvan0PbxGj5HzZrIs7BJKp6tZKb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkfSusOfwUStDUlvlfRK1RAfrXXZFW4UeGGqKznairucJ6YYNZ08q0OWcxksm7lPiDs63CYuJMTa4kIa2gZulJTTNWubYKx9BwCjJ1kEB6LSAz01gjGtdgNGeJXNM/5awAM8A8Fi+3UfkBHmxYmo3gBt45HjTuSMo5DmOxkolEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEC29L2Q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEC29L2Q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45562c41ec7so1167418f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489641; x=1779094441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKuMf21IOd9M0Ywzoug7NeLqXYWH4QJ3jExgQ6XGwH8=;
        b=LEC29L2QEXwcOKVh5Zg9H+vNbTYgqOxnSBwtcBR1MbJrfpU2s95tLZXm7EAUgtmVq4
         fVJKXZabS/pBs15+s65tVoZSQPnUtM/PQOXmRe2rsSRXO/8PycwYAp8llz7foeqPaB/R
         2mPfFbAwhpUFBPAWVEzLfU1+XZM5JElTWg0zoXQKlkqyoTf5UbJX4P266CbOz4J6QH7I
         U5FixLGJEeCNhqSd2/TYUI0G71EvCQjTgWOkXICT9d2onZn3HZ1Hr3BWFTrsFY5pWEz7
         R5e/IfNsXYQbmnphrXTXAWKKu0bfNOJJ8RFWhOIJfRDGN57xEwLoCYNfr1V7RxFt4bWY
         Spxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489641; x=1779094441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKuMf21IOd9M0Ywzoug7NeLqXYWH4QJ3jExgQ6XGwH8=;
        b=oQEQav6OBd7l8sXL6c6zj6mwWwqvI4UB4fC7/2HS+PeHzbkmnpfoWR/2yI0eooseQV
         rvyMudFPwxzh/3S+m0gvkwKR4opVNZpbKklxvQ5L3Dnj26/zbBGAPnol9c/u/2aZu9p5
         VRtdbFCRn6Rcr8vNj4WpY4PT//DzX5PGSQAPtDfx+LM1WEj4TYwRVrdHuaOl48MREinn
         OalFDn687gE5Enc/tLnrl8k80vybHk9/8/9eA+KvSrQmjOZthMsowIe23U+oE7Ztjjlf
         90KiR16u6EjKPQU/6BfZFGAKa24OwAO0H26icrPk4CBNZAj7N3tkqTZsI802qccQEd4e
         diBg==
X-Gm-Message-State: AOJu0YxhrnsUI/xv6RH7lzSRSCcY0qJebhVIASAlQRpuOizrTIZPNkRk
	tDVsXXTvEH0OaxAchOeXlMbhBfVJwFLmmBLxUPJGlbLYSn+cHNgJD3J8u0CNKHTI
X-Gm-Gg: Acq92OHagNVFGsKBQHS6MreBoEj1Ra8ad/Kd/buzevGqwciA7tOGZjpeReRQRkkhQ/P
	sO+HMG8yzxt6DLFUrRnAUMw103IWfVqLTRsQMmvKWzYDJzoLXoR9KGvEAI5bU+pcDuWn/1KhAso
	CQJtOPqEIo5MpfZtzZWcDF6SLN09KJLObV95fPeAMwfSZEJda/V932zlP4lJd7/eD9JNfeJOlbE
	TdKgiikzMjJilXTU58PX+BHIDAJHtepHnBFV4/2K8gzSUB6vziJMsHKEGsBybmXQD4S5YgsXGiS
	H714GKeZUQu0UFA+YobkZwOgD7DABSDm8YnOzFg+TulsSANPc273w3eHT1tUn/FOp4F9Aze3ZIz
	YNrk+IUZ/6nPggW3I91N/Vh9hCNl6mYqzZFM2/NJdwkRCiC1K0qgmGa8QwXdXQyRPsj6zbVCPxR
	IAQjWk5/SmFPZpi4AjudYMz7BcINY=
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr37402360f8f.27.1778489640957;
        Mon, 11 May 2026 01:54:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23817156f8f.27.2026.05.11.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:00 -0700 (PDT)
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
Subject: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Date: Mon, 11 May 2026 08:53:41 +0000
Message-Id: <20260511085344.3302-2-mahe.tardy@gmail.com>
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
index edaab759dc50..8d94c9d58f32 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -364,6 +364,17 @@ config NETCONSOLE_PREPEND_RELEASE
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
index 185210b73385..2dc8d2fb4a01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4641,6 +4641,9 @@ BTF_ID(struct, task_struct)
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
index 000000000000..05f4dcbd95f3
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
+	bnp = kzalloc_obj(*bnp);
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
+ * Return: 0 on success, 1 (NET_XMIT_DROP) on drop, negative errno on error.
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
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &netpoll_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_netpoll_dtors,
+						  ARRAY_SIZE(bpf_netpoll_dtors),
+						  THIS_MODULE);
+}
+
+late_initcall(bpf_netpoll_kfunc_init);
--
2.34.1

