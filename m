Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AE43B6FD
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330554; cv=none; b=HAsjp5Zu14hi7quxaM4y6nwvQ7Zwv398rgGFf+y1+NrRMhMJnKzzOh/u4T7VFXsqa5Jo/AiK8xXITmmNENj7fJw8cGx4EGUfs1HyOswgilWnMHCFTd3flUBYv4Y3tzkbgm4SIzWgQEvhDUQZ1sPkcNY7/ceVqPhKv5nStLmd0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330554; c=relaxed/simple;
	bh=nyas/0Yu2LIf40OzFZ18h4JYjm86XGvWt1TFLoIK3Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGJl6BnlyKWIWc9X7tfuJzyohRBcm3c39Y/vssofIdxcZ+5R11el1QiM69Wijd+/CT0/ptMwPZTuAmJ0Lu8ggQX4+dKrHewCX1CntehzoBT1v6ty4lWHgSARD5QQ3hg3uyVME6Bt08woarJ6D1Bg1kSMiDBUAVkTLwuV2lCfix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhurkM+B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhurkM+B"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de0093c42so866727f8f.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330544; x=1783935344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lZhos02CMb6Wf4ki9y7o61ijsWwP5G68CxJfx4vyD0=;
        b=HhurkM+BQbI/n9CTSzhZ0iSO8FJ1LaZtbPTG6OZmRh890MpiAY9c5W01R18ekx7Gww
         fMcuRCsEKWcM6HlOBN0yhris4ajf2vuqcpx2UK0NICsY6abJmI+0ICQ60+y4RtzZHf0C
         lXCi7MOMGn62CO4+fW/ZZRotl5FSBDJbkHAHg9Rbl4dAS71hmLnD9bvTX6XFdoeC3OY9
         wIxqykHI1WZHI7J8PBhwqK1itSUhFPHXJS39jRgEkgmeXdFo+taTFXJR+A1zyNDEc+l9
         ayCAydvJ0IV/G60axC1c3zkIlQ0RqTykW9J9QKRFEMVmL/RL/8NUjNlA+dz3KKaUyAkn
         g/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330544; x=1783935344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lZhos02CMb6Wf4ki9y7o61ijsWwP5G68CxJfx4vyD0=;
        b=tHHhISu6uu/X6NgSnLW+pj8PGumQYWDJsUhE1EbqsSx7DDRET4/zr0p8RgUPxUjF2h
         BHGRN8SG2UdyjqT60nc/2TlBzAMv99ozWEcoEY+RG8hpF+uh+4LoN3olwjH/ZID63S+N
         o/SFHuinD0JMwFEKnz8qgPZFCP6n9rPSCCvippFVJlvuBLK/X8GcPERKnqZCwtwR2bXv
         hPwk7cszEBBtiFsnaJZt3SebZL/+uIA99i6aySp+/QjgZp8RQ4GUHNaKjYJZT+40v8Yy
         E6dknqhd2gZrDkXye570Q8trOwIPqtt45bjShxrxW9hVxD45cJAljJ+vs/HwwKCKZ4yE
         Uieg==
X-Gm-Message-State: AOJu0Yzb/sfAYe0RBZyKXBSDsXD4RrNQhaIP0a+2HsNNJQ2iFC5FVLNR
	IveAQ54QQnUfH1kLqgLdGS+gga+Kb8POmu4xe9kvnAkm8sMU2O4YEcct9GFfAiuerRTOSQ==
X-Gm-Gg: AfdE7ckTqGx94T3PlxJqtkrhH2PUnksFntYQb0sHFzvybN8t9JxqhrcnbimOi4T6S60
	FXIpnosLvd1Y+UzLzFBuZbDVcRjM/Xb9XJ4m673NXERHlYsmey/vEMjoHheIPVbO35LaUgN+4+y
	N6vkgnRMOr30nRK5BCz00HEwfTbRGSFULcwolSghBae+7vTuhDPOWjdM17gWyLN0L851HoZ0HL6
	8dT7KGGYkEFIXuYHhpBSmwBEpI0MYeu4pNEhtH/Zlvgd+VtW7tDB48QrG8EiBkGO+R3C1FzF1/m
	GmJads0w2OhUPVPAHOsMpPWkpu5DzE9leo1w5F/KWaw+e1z0eFOqTVSBOUnhGKoVk17P5zvlfOs
	Ai//uDClIOrkCClQh6rIkv1yFAsfxkoMetctkHAvBjxrChLyts4nvThIQrLsQm+V5vnXbW90HUz
	qj0KHXbAOFY0IvooFL
X-Received: by 2002:a05:6000:4805:b0:474:9991:60d0 with SMTP id ffacd0b85a97d-47aaa516fcfmr12717342f8f.12.1783330543689;
        Mon, 06 Jul 2026 02:35:43 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:43 -0700 (PDT)
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
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Date: Mon,  6 Jul 2026 09:35:21 +0000
Message-Id: <20260706093525.13030-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
sending data. This provides a mechanism for BPF programs to emit
telemetry. For this first patch set, it's restricted to SOCK_DGRAM
socket types with IPPROTO_UDP protocol but could be easily extended to
SOCK_STREAM and IPPROTO_TCP in the future.

The API consists of six kfuncs:

  bpf_ksock_create()   - Create a socket (sleepable)
  bpf_ksock_bind()     - Bind socket to local address (sleepable)
  bpf_ksock_connect()  - Connect socket to remote address (sleepable)
  bpf_ksock_send()     - Send data through the socket (sleepable)
  bpf_ksock_acquire()  - Acquire a reference to a socket context
  bpf_ksock_release()  - Release a reference (cleanup via
                         queue_rcu_work since sock_release sleeps)

The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
can be called from SYSCALL programs only. While bpf_ksock_acquire,
bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
programs.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration). The kernel socket is wrapped in a refcounted bpf_ksock
struct. Cleanup is deferred via queue_rcu_work() because sock_release()
may sleep.

The kfuncs are only compiled when CONFIG_INET is enabled, as they
specifically support AF_INET and AF_INET6 sockets.

The socket operations go through the expected LSM hooks instead of
by-passing them like many kernel sockets since those are created by BPF
programs and thus system users. Thus bpf_ksock_send() kfunc, which is
exposed to LSM progs, has a re-entering protection to avoid recursion.
Also, because of the LSM checks, we prevent the use of the kfuncs from
asynchronous workqueue as the current value would then be invalid.

A bpf_ksock_max sysctl is added to limit the maximum number of BPF
kernel sockets that may exist in each network namespace. Out of
simplicity for now, the settings is host wide but the counters are per
network namespace.

In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
since the kfunc can sleep and the arg values could be stored in a map
that could be re-written by BPF progs or even userspace programs if the
map is mmaped.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst |  12 +
 include/linux/bpf_ksock.h                |  50 +++
 kernel/bpf/verifier.c                    |   3 +
 net/core/Makefile                        |   3 +
 net/core/bpf_ksock.c                     | 516 +++++++++++++++++++++++
 net/core/sysctl_net_core.c               |  11 +
 6 files changed, 595 insertions(+)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index e586e17fc7a5..8bcdc1bfd711 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -128,6 +128,18 @@ compiler in order to reject unprivileged JIT requests once it has
 been surpassed. bpf_jit_limit contains the value of the global limit
 in bytes.

+bpf_ksock_max
+-------------
+
+Maximum number of BPF kernel sockets that may exist in each network namespace.
+This host-wide setting is exposed in the initial network namespace and applies
+the same limit independently to every network namespace. Sockets awaiting
+deferred RCU and workqueue cleanup remain counted until the underlying socket
+has been released. A value of 0 disables creation of BPF kernel sockets in
+every network namespace.
+
+Default: 1024
+
 dev_weight
 ----------

diff --git a/include/linux/bpf_ksock.h b/include/linux/bpf_ksock.h
new file mode 100644
index 000000000000..0485b8eddc1f
--- /dev/null
+++ b/include/linux/bpf_ksock.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _BPF_KSOCK_H
+#define _BPF_KSOCK_H
+
+#include <linux/types.h>
+
+#define BPF_KSOCK_MAX_DEFAULT 1024
+
+extern int sysctl_bpf_ksock_max;
+
+/**
+ * struct bpf_ksock_create_opts - BPF kernel socket creation parameters
+ * @family:	Address family: AF_INET or AF_INET6.
+ * @type:	Socket type: only SOCK_DGRAM supported for now.
+ * @protocol:	Protocol number (e.g. IPPROTO_UDP), or 0 for the default protocol
+ *		of the given type.
+ * @reserved:	Must be zero. Reserved for future use.
+ */
+struct bpf_ksock_create_opts {
+	__u8 family;
+	__u8 type;
+	__u8 protocol;
+	__u8 reserved;
+};
+
+/**
+ * struct bpf_ksock_addr_opts - BPF kernel socket address parameters
+ * @family:	Address family: AF_INET or AF_INET6.
+ * @reserved:	Must be zero. Reserved for future use.
+ * @port:	Port in host byte order.
+ * @scope_id:	IPv6 scope ID for scoped AF_INET6 addresses, or zero.
+ *		Must be zero when family=AF_INET.
+ * @ipv4_addr:	IPv4 address in network byte order. Used when family=AF_INET.
+ * @ipv6_addr:	IPv6 address (16 bytes, network byte order). Used when family=AF_INET6.
+ */
+struct bpf_ksock_addr_opts {
+	__u8 family;
+	__u8 reserved;
+	__u16 port;
+	__u32 scope_id;
+
+	union {
+		__be32 ipv4_addr;
+		__u32 ipv6_addr[4]; /* in6_addr; network order */
+	};
+};
+
+#endif /* _BPF_KSOCK_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..52f6a89546e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4424,6 +4424,9 @@ BTF_ID(struct, task_struct)
 #ifdef CONFIG_CRYPTO
 BTF_ID(struct, bpf_crypto_ctx)
 #endif
+#ifdef CONFIG_INET
+BTF_ID(struct, bpf_ksock)
+#endif
 BTF_SET_END(rcu_protected_types)

 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
diff --git a/net/core/Makefile b/net/core/Makefile
index b3fdcb4e355f..a9295b785901 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -44,6 +44,9 @@ obj-$(CONFIG_FAILOVER) += failover.o
 obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
+ifneq ($(CONFIG_INET),)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_ksock.o
+endif
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
new file mode 100644
index 000000000000..8bde734bc917
--- /dev/null
+++ b/net/core/bpf_ksock.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Isovalent */
+
+#include <linux/bpf.h>
+#include <linux/bpf_ksock.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/cache.h>
+#include <linux/hash.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/list_bl.h>
+#include <linux/net.h>
+#include <linux/refcount.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+#include <linux/ip.h>
+#include <net/ipv6.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <net/sock.h>
+
+/**
+ * struct bpf_ksock - refcounted BPF kernel socket context
+ * @sock:	The underlying kernel socket.
+ * @usage:	Reference counter.
+ * @rwork:	RCU work for deferred cleanup (sock_release may sleep).
+ */
+struct bpf_ksock {
+	struct socket *sock;
+	refcount_t usage;
+	struct rcu_work rwork;
+};
+
+struct bpf_ksock_send_guard {
+	struct hlist_bl_node node;
+	struct task_struct *task;
+};
+
+#define BPF_KSOCK_SEND_GUARD_HASH_BITS 6
+
+struct bpf_ksock_send_bucket {
+	struct hlist_bl_head head;
+} ____cacheline_aligned_in_smp;
+
+static struct bpf_ksock_send_bucket
+	bpf_ksock_send_buckets[1 << BPF_KSOCK_SEND_GUARD_HASH_BITS];
+
+static struct bpf_ksock_send_bucket *
+bpf_ksock_send_bucket(const struct task_struct *task)
+{
+	u32 bucket_idx = hash_ptr(task, BPF_KSOCK_SEND_GUARD_HASH_BITS);
+
+	return &bpf_ksock_send_buckets[bucket_idx];
+}
+
+static bool bpf_ksock_send_enter(struct bpf_ksock_send_guard *guard)
+{
+	struct bpf_ksock_send_guard *entry;
+	struct hlist_bl_node *pos;
+	struct bpf_ksock_send_bucket *bucket;
+
+	bucket = bpf_ksock_send_bucket(current);
+	hlist_bl_lock(&bucket->head);
+	hlist_bl_for_each_entry(entry, pos, &bucket->head, node) {
+		if (entry->task == current) {
+			hlist_bl_unlock(&bucket->head);
+			return false;
+		}
+	}
+
+	guard->task = current;
+	INIT_HLIST_BL_NODE(&guard->node);
+	hlist_bl_add_head(&guard->node, &bucket->head);
+	hlist_bl_unlock(&bucket->head);
+	return true;
+}
+
+static void bpf_ksock_send_exit(struct bpf_ksock_send_guard *guard)
+{
+	struct bpf_ksock_send_bucket *bucket;
+
+	bucket = bpf_ksock_send_bucket(guard->task);
+	hlist_bl_lock(&bucket->head);
+	hlist_bl_del(&guard->node);
+	hlist_bl_unlock(&bucket->head);
+}
+
+struct bpf_ksock_net {
+	atomic_t count;
+};
+
+static unsigned int bpf_ksock_net_id;
+int sysctl_bpf_ksock_max __read_mostly = BPF_KSOCK_MAX_DEFAULT;
+
+static struct bpf_ksock_net *bpf_ksock_pernet(const struct net *net)
+{
+	return net_generic(net, bpf_ksock_net_id);
+}
+
+static struct pernet_operations bpf_ksock_net_ops = {
+	.id = &bpf_ksock_net_id,
+	.size = sizeof(struct bpf_ksock_net),
+};
+
+static bool bpf_ksock_net_try_charge(struct net *net)
+{
+	struct bpf_ksock_net *kn = bpf_ksock_pernet(net);
+	int count = atomic_read(&kn->count);
+	int max;
+
+	do {
+		max = READ_ONCE(sysctl_bpf_ksock_max);
+		if (count >= max)
+			return false;
+	} while (!atomic_try_cmpxchg(&kn->count, &count, count + 1));
+
+	return true;
+}
+
+static void bpf_ksock_net_uncharge(struct net *net)
+{
+	struct bpf_ksock_net *kn = bpf_ksock_pernet(net);
+
+	WARN_ON_ONCE(atomic_dec_return(&kn->count) < 0);
+}
+
+static void ksock_release_work_fn(struct work_struct *work)
+{
+	struct bpf_ksock *ks =
+		container_of(to_rcu_work(work), struct bpf_ksock, rwork);
+	struct net *net = get_net(sock_net(ks->sock->sk));
+
+	sock_release(ks->sock);
+	bpf_ksock_net_uncharge(net);
+	put_net(net);
+	kfree(ks);
+}
+
+static int bpf_ksock_get_addr(const struct bpf_ksock_addr_opts *opts,
+			      u32 opts__sz, struct sockaddr_storage *addr)
+{
+	struct bpf_ksock_addr_opts opts_copy;
+
+	if (!opts || opts__sz != sizeof(*opts))
+		return -EINVAL;
+
+	/* Kfunc memory arguments are not guaranteed to be naturally aligned. */
+	memcpy(&opts_copy, opts, sizeof(opts_copy));
+
+	if (opts_copy.reserved)
+		return -EINVAL;
+
+	switch (opts_copy.family) {
+	case AF_INET: {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
+
+		if (opts_copy.scope_id)
+			return -EINVAL;
+
+		*addr4 = (struct sockaddr_in){
+			.sin_family = AF_INET,
+			.sin_port = htons(opts_copy.port),
+			.sin_addr.s_addr = opts_copy.ipv4_addr,
+		};
+		return sizeof(*addr4);
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6: {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
+
+		*addr6 = (struct sockaddr_in6){
+			.sin6_family = AF_INET6,
+			.sin6_port = htons(opts_copy.port),
+			.sin6_scope_id = opts_copy.scope_id,
+		};
+		memcpy(&addr6->sin6_addr, opts_copy.ipv6_addr,
+		       sizeof(struct in6_addr));
+		return sizeof(*addr6);
+	}
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+}
+
+static bool bpf_ksock_has_user_task_context(void)
+{
+	/*
+	 * Task work can run from do_exit() after exit_nsproxy_namespaces()
+	 * cleared current->nsproxy, while current is still not a kthread.
+	 */
+	return !(current->flags & PF_KTHREAD) && current->nsproxy;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_ksock_create() - Create a BPF kernel socket.
+ *
+ * Allocates and creates a kernel socket.
+ * The socket is charged against the active network namespace's BPF kernel
+ * socket quota.
+ *
+ * The returned context must either be stored in a map as a kptr, or
+ * freed with bpf_ksock_release().
+ *
+ * This function may sleep (sock_create), so it can only be used
+ * in sleepable BPF programs (SYSCALL).
+ * It cannot be called from a BPF workqueue callback because that callback
+ * does not retain the invoking task's namespace or security context.
+ *
+ * @opts:	Pointer to struct bpf_ksock_create_opts with socket parameters.
+ * @opts__sz:	Size of the opts struct.
+ * @err__uninit:	Integer to store error code when NULL is returned.
+ */
+__bpf_kfunc struct bpf_ksock *
+bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
+		 int *err__uninit)
+{
+	struct bpf_ksock_create_opts opts_copy;
+	struct bpf_ksock *ks;
+	struct net *net;
+	int err;
+
+	/*
+	 * sock_create() derives the network namespace, credentials, and cgroup
+	 * from current. Kernel threads, including BPF workqueue callbacks, do
+	 * not carry the context of the task that invoked the BPF program.
+	 */
+	if (!bpf_ksock_has_user_task_context()) {
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
+	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	opts_copy = (struct bpf_ksock_create_opts){
+		.family = READ_ONCE(opts->family),
+		.type = READ_ONCE(opts->type),
+		.protocol = READ_ONCE(opts->protocol),
+		.reserved = READ_ONCE(opts->reserved),
+	};
+
+	if (opts_copy.reserved) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	if (opts_copy.family != AF_INET && opts_copy.family != AF_INET6) {
+		err = -EAFNOSUPPORT;
+		goto err_out;
+	}
+
+	if (opts_copy.type != SOCK_DGRAM) {
+		err = -EPROTONOSUPPORT;
+		goto err_out;
+	}
+
+	if (opts_copy.protocol != IPPROTO_UDP && opts_copy.protocol != 0) {
+		err = -EPROTONOSUPPORT;
+		goto err_out;
+	}
+
+	ks = kzalloc_obj(*ks);
+	if (!ks) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	net = current->nsproxy->net_ns;
+	if (!bpf_ksock_net_try_charge(net)) {
+		err = -ENOSPC;
+		goto err_free;
+	}
+
+	/*
+	 * Use the normal current-task socket path so LSM/cgroup policy,
+	 * socket labels, and the active netns reference match a socket(2)
+	 * created by the BPF program's caller.
+	 */
+	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
+			  &ks->sock);
+	if (err)
+		goto err_uncharge;
+
+	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
+	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
+
+	refcount_set(&ks->usage, 1);
+	put_unaligned(0, err__uninit);
+	return ks;
+
+err_uncharge:
+	bpf_ksock_net_uncharge(net);
+err_free:
+	kfree(ks);
+err_out:
+	put_unaligned(err, err__uninit);
+	return NULL;
+}
+
+/**
+ * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
+ * @ks:		The BPF kernel socket context.
+ * @opts:	Pointer to struct bpf_ksock_addr_opts with local address.
+ * @opts__sz:	Size of the opts struct.
+ *
+ * Binds the socket to the specified local address and port.
+ * This is optional; if not called, the kernel will auto-assign.
+ *
+ * This function may sleep while binding the socket, so it can only be used in
+ * sleepable BPF programs (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
+			       const struct bpf_ksock_addr_opts *opts,
+			       u32 opts__sz)
+{
+	struct sockaddr_storage addr = {};
+	int addrlen;
+
+	if (!bpf_ksock_has_user_task_context())
+		return -EOPNOTSUPP;
+
+	addrlen = bpf_ksock_get_addr(opts, opts__sz, &addr);
+	if (addrlen < 0)
+		return addrlen;
+
+	return __sys_bind_socket(ks->sock, &addr, addrlen);
+}
+
+/**
+ * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
+ * @ks:		The BPF kernel socket context.
+ * @opts:	Pointer to struct bpf_ksock_addr_opts with remote address.
+ * @opts__sz:	Size of the opts struct.
+ *
+ * Connects the socket to the specified remote address and port.
+ *
+ * This function may sleep while connecting the socket, so it can only be used
+ * in sleepable BPF programs (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
+				  const struct bpf_ksock_addr_opts *opts,
+				  u32 opts__sz)
+{
+	struct sockaddr_storage addr = {};
+	int addrlen;
+
+	if (!bpf_ksock_has_user_task_context())
+		return -EOPNOTSUPP;
+
+	addrlen = bpf_ksock_get_addr(opts, opts__sz, &addr);
+	if (addrlen < 0)
+		return addrlen;
+
+	return __sys_connect_socket(ks->sock, &addr, addrlen, 0);
+}
+
+/**
+ * bpf_ksock_acquire() - Acquire a reference to a BPF kernel socket.
+ * @ks:	The BPF kernel socket context to acquire. Must be a
+ *	trusted pointer (e.g. RCU-protected kptr from a map).
+ *
+ * The acquired context must either be stored in a map as a kptr, or
+ * freed with bpf_ksock_release().
+ */
+__bpf_kfunc struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks)
+{
+	if (!refcount_inc_not_zero(&ks->usage))
+		return NULL;
+	return ks;
+}
+
+/**
+ * bpf_ksock_release() - Release a BPF kernel socket.
+ * @ks:	The BPF kernel socket context to release.
+ *
+ * When the final reference is released, the socket is cleaned up via
+ * queue_rcu_work() (since sock_release may sleep).
+ */
+__bpf_kfunc void bpf_ksock_release(struct bpf_ksock *ks)
+{
+	if (refcount_dec_and_test(&ks->usage)) {
+		INIT_RCU_WORK(&ks->rwork, ksock_release_work_fn);
+		queue_rcu_work(system_dfl_wq, &ks->rwork);
+	}
+}
+
+__bpf_kfunc void bpf_ksock_release_dtor(void *ks)
+{
+	bpf_ksock_release(ks);
+}
+CFI_NOSEAL(bpf_ksock_release_dtor);
+
+/**
+ * bpf_ksock_send() - Send data through a BPF kernel socket.
+ * @ks:		The BPF kernel socket context. Must be an acquired reference.
+ * @data:	Pointer to the data to send.
+ * @data__sz:	Size of the data to send (max 65535 bytes).
+ *
+ * Sends data on a connected socket, best-effort and nonblocking. This may sleep
+ * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
+ *
+ * Return: Number of bytes sent on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
+			       u32 data__sz)
+{
+	struct bpf_ksock_send_guard guard;
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT,
+	};
+	struct kvec iov = {
+		.iov_base = (void *)data,
+		.iov_len = data__sz,
+	};
+	int ret;
+
+	if (!bpf_ksock_has_user_task_context())
+		return -EOPNOTSUPP;
+
+	/* Early check for UDP. Exact limits enforced by kernel_sendmsg(). */
+	if (data__sz > IP_MAX_MTU)
+		return -EMSGSIZE;
+
+	if (!bpf_ksock_send_enter(&guard))
+		return -EBUSY;
+
+	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+	bpf_ksock_send_exit(&guard);
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_bind, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
+BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &ksock_init_kfunc_btf_ids,
+};
+
+BTF_KFUNCS_START(ksock_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
+BTF_KFUNCS_END(ksock_kfunc_btf_ids)
+
+static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id) ||
+	    prog->type == BPF_PROG_TYPE_SYSCALL ||
+	    prog->type == BPF_PROG_TYPE_LSM)
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set ksock_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &ksock_kfunc_btf_ids,
+	.filter = bpf_ksock_kfunc_filter,
+};
+
+BTF_ID_LIST(bpf_ksock_dtor_ids)
+BTF_ID(struct, bpf_ksock)
+BTF_ID(func, bpf_ksock_release_dtor)
+
+static int __init bpf_ksock_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] = {
+		{
+			.btf_id = bpf_ksock_dtor_ids[0],
+			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
+		},
+	};
+
+	ret = register_pernet_subsys(&bpf_ksock_net_ops);
+	if (ret)
+		return ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&ksock_init_kfunc_set);
+	if (ret) {
+		unregister_pernet_subsys(&bpf_ksock_net_ops);
+		return ret;
+	}
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&ksock_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					       &ksock_kfunc_set);
+	return ret = ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
+						 ARRAY_SIZE(bpf_ksock_dtors),
+						 THIS_MODULE);
+}
+
+late_initcall(bpf_ksock_kfunc_init);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..d221a180c877 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -7,6 +7,7 @@
  */

 #include <linux/filter.h>
+#include <linux/bpf_ksock.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
 #include <linux/module.h>
@@ -525,6 +526,16 @@ static struct ctl_table net_core_table[] = {
 		.extra1		= SYSCTL_LONG_ONE,
 		.extra2		= &bpf_jit_limit_max,
 	},
+#endif
+#if IS_ENABLED(CONFIG_BPF_SYSCALL) && IS_ENABLED(CONFIG_INET)
+	{
+		.procname	= "bpf_ksock_max",
+		.data		= &sysctl_bpf_ksock_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 #endif
 	{
 		.procname	= "netdev_tstamp_prequeue",
--
2.34.1

