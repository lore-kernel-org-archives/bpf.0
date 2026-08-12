Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A17471D03
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549426; cv=none; b=nm4vWFNGqe/081Ui5zjfA9Beif1HuNlY+x/z7Fd1ZaH7ClkHultzS9zc/mEU8aoBVS4C2QqFCXSvyxuoFZ+uV6qEkcbOZQROUw4VdhR13cML+BIxSjdVk0yC/2Xr2DnkbBfa8r2yiwlGzphOVPaYRPMF551+Syu77/s5EaQlIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549426; c=relaxed/simple;
	bh=8MwCNco6G1Fw3gS6epF8/8+wKurIrBvd8xopdl3fmHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n71WtIv/knJkOgUz6NfB16aqIKqHEmjzi9h4UnJHPI+w5JlMmo1eErEluj/UBHthxUzorvC+mPkIfWRvz/yGFYdPrLRpZziev+mwvKqqZZedRWRISyKBaOFQvqDOc9PlUyZLjFwCucqIu2w0KnpygkE6+0tBOsCynDboCyPohAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMgXNzDL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMgXNzDL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980dc26022so11734615e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549422; x=1787154222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rG2PBcZE8LHychHX3YTu392ojsBizDf2oN6Er6mMuOY=;
        b=kMgXNzDL7VdAlNA0+41PdEKgMBBmMFRb9VpE3ZRIF8e4aziCp7xLmbUQ/oV3+vsXSw
         yo6IZBI4YeKH7p0Ip54VHAnKdETcusWt7L4TtoJwU6JgquVQIvHv2QZxsYmVS2/jWbO6
         v7IR6w5E2de0tRsO332K7DhbtkNBop/oaes6Vg/sTJv7g3fxGIdMCWyAygeSDDc8+Xu+
         epS4yuL4Abg/60A6PDSs/8VIR9x4GL9MPkmrKE6UvKaGQWZ+kTK5eKqG2jUMZ0fKjz7O
         7bBT0X4R3q9k6cJxDUj1p2oeg9+tRi/Mqvi2A9WXjeJw4bWMEXbt76WwRAJdWwnFZTnt
         Lo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549422; x=1787154222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rG2PBcZE8LHychHX3YTu392ojsBizDf2oN6Er6mMuOY=;
        b=p5A4YLCzU9JWRihxFqotPXjGw2iBlPmQRmMNO4zpVXoWvh7FGOVcZuZqNfj3IPdKU7
         bbN+eFMvk1LVtvG0j6wQJV9FhHDtgdjzu+7ioMrMcF4xjiKz65yvh7cCoeQIVkQfAb0w
         nIAGrvnBvPL1+cYZjUUnESaWHji3v16WOhBxjVYtZj02kpL2GpjpdvYG83YUBxSD7FZF
         JGtTWIiDFPqIs1TBy0RofCF+xUu3UIRMa4KJbpEslWPU4GMUDZHNe3JaVmVMIld0DygA
         P6sefL2Esj41KqiYw9wQAOF/Ij1VWiW0+b4HJIuShivxMBM3F9abx6l7ssI9tKm7xBQp
         9HWg==
X-Gm-Message-State: AOJu0Yyur06oB/Y5XkGjoH117D4l/wfKjoX5IgnBSeE5YCnbBndkyne4
	dF5t1fXp6H9Xeiwl1DtvNSf/2k8DH3wFttu5wV87WUxZS59iwri+qLc8tyB2FX/6BRPUfQ==
X-Gm-Gg: AR+sD13Pbd4Xk9mw2OXVP9P4Botp3Doupl4uukUWjKjliTg3pUQrXyBkXLjzTwpqK3g
	pruAzmL5WUKDReywRSli3xmhCwoH5h4x4wd94osbSMT9/t7+1oaPcWOLYblPlrYTqNYfnBuXq03
	AqqksLq/GAg/VnpikbJ4fH92zI/QXIcfrV0CteyZNdle8+F3FkvpzTWYsh/nhi9lB+Jn84+/SzE
	DGzyIbmnNWoWMcclNa2rqKf7aClqSG60TrKmEDU4MtAjmeuo+JRpkHsuQGdPYfSOQAKT4iLqiGp
	Aww9xxuRPsy7Hi5KrwjYkKAjgllYXp0U8p9fpXdZCRSpDh9jZkSKgPgsgPxYQFi3Qtvpzd07Hvt
	eySIXjq91lpLHDSyM8LhSwGpDH0KQZH6RhSLfj6eQD62k2WP9tpwfqNlpqyejkdfAYdYam9Mc2z
	j3efNQjh7zz6SzNbcKzojFj9zpOpfkHCRpeuA+qObxjw37IWylHL4PJhdwXZEN1/+U+hnewRzRB
	cKP0lSKBFxl1bSyl0/7/9k2sYcmjyNupA==
X-Received: by 2002:a05:600c:35c5:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-4997bf7c39fmr92960405e9.0.1786549422166;
        Wed, 12 Aug 2026 08:43:42 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c939574sm51584985e9.1.2026.08.12.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:43:41 -0700 (PDT)
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
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v6 2/5] bpf: Add ksock kfuncs
Date: Wed, 12 Aug 2026 15:43:25 +0000
Message-Id: <20260812154328.72834-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154328.72834-1-mahe.tardy@gmail.com>
References: <20260812154328.72834-1-mahe.tardy@gmail.com>
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

The API consists of five kfuncs:

  bpf_ksock_create()   - Create a socket (sleepable)
  bpf_ksock_connect()  - Connect socket to remote address (sleepable)
  bpf_ksock_send()     - Send data through the socket (sleepable)
  bpf_ksock_acquire()  - Acquire a reference to a socket context
  bpf_ksock_release()  - Release a reference (cleanup via
                         queue_rcu_work since sock_release sleeps)

The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
bpf_ksock_send can be called from SYSCALL and LSM programs.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration). The kernel socket is wrapped in a refcounted bpf_ksock
struct. Cleanup is deferred via queue_rcu_work() because sock_release()
may sleep.

The kfuncs are only compiled when CONFIG_INET is enabled, as they
specifically support AF_INET and AF_INET6 sockets.

The socket operations go through the expected LSM hooks instead of
by-passing them like many kernel sockets since those are created by BPF
programs and thus system users. Thus, the bpf_ksock_send() kfunc, which
is exposed to LSM progs has a verifier filter protection to avoid
recursion so that the whole bpf_kfunc_set kfunc set cannot be called in
a program attached to security_socket_sendmsg(). Also, because of the
LSM checks, we prevent the use of the kfuncs from asynchronous workqueue
as the current value would then be invalid.

In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
since the kfunc can sleep and the arg values could be stored in a map
that could be re-written by BPF progs or even userspace programs if the
map is mmaped.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/linux/bpf_ksock.h |  36 ++++
 kernel/bpf/verifier.c     |   3 +
 net/core/Makefile         |   3 +
 net/core/bpf_ksock.c      | 335 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c

diff --git a/include/linux/bpf_ksock.h b/include/linux/bpf_ksock.h
new file mode 100644
index 000000000000..cb387fb75e43
--- /dev/null
+++ b/include/linux/bpf_ksock.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _BPF_KSOCK_H
+#define _BPF_KSOCK_H
+
+#include <linux/types.h>
+#include <linux/in.h>
+#include <linux/in6.h>
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
+ * union bpf_ksock_addr - IPv4 or IPv6 socket address
+ * @sin: IPv4 socket address.
+ * @sin6: IPv6 socket address.
+ */
+union bpf_ksock_addr {
+	struct sockaddr_in sin;
+	struct sockaddr_in6 sin6;
+};
+
+#endif /* _BPF_KSOCK_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..4f3de0a4b0c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4445,6 +4445,9 @@ BTF_ID(struct, task_struct)
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
index 000000000000..d65200679b65
--- /dev/null
+++ b/net/core/bpf_ksock.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Isovalent */
+
+#include <linux/bpf.h>
+#include <linux/bpf_ksock.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/net.h>
+#include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+#include <linux/ip.h>
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
+static void ksock_release_work_fn(struct work_struct *work)
+{
+	struct bpf_ksock *ks;
+
+	ks = container_of(to_rcu_work(work), struct bpf_ksock, rwork);
+	sock_release(ks->sock);
+	kfree(ks);
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
+	/*
+	 * Use the normal current-task socket path so LSM/cgroup policy,
+	 * socket labels, and the active netns reference match a socket(2)
+	 * created by the BPF program's caller.
+	 */
+	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
+			  &ks->sock);
+	if (err)
+		goto err_free;
+
+	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
+	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
+
+	refcount_set(&ks->usage, 1);
+	put_unaligned(0, err__uninit);
+	return ks;
+
+err_free:
+	kfree(ks);
+err_out:
+	put_unaligned(err, err__uninit);
+	return NULL;
+}
+
+/**
+ * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
+ * @ks:		The BPF kernel socket context.
+ * @addr:	Pointer to an IPv4 or IPv6 socket address.
+ * @addr__sz:	Size of the address union.
+ *
+ * Connects the socket to the specified remote address and port.
+ *
+ * This function may sleep while connecting the socket, so it can only be used
+ * in sleepable BPF programs (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
+				  const union bpf_ksock_addr *addr,
+				  u32 addr__sz)
+{
+	struct sockaddr_storage sa;
+	int addrlen;
+
+	if (!bpf_ksock_has_user_task_context())
+		return -EOPNOTSUPP;
+
+	if (!addr || addr__sz != sizeof(*addr))
+		return -EINVAL;
+
+	/* Kfunc memory arguments may be unaligned. */
+	memcpy(&sa, addr, sizeof(*addr));
+
+	switch (sa.ss_family) {
+	case AF_INET:
+		addrlen = sizeof(struct sockaddr_in);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		addrlen = sizeof(struct sockaddr_in6);
+		break;
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	return connect_socket(ks->sock, &sa, addrlen, 0);
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
+	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
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
+#ifdef CONFIG_BPF_LSM
+BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendmsg)
+#endif
+
+static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_SYSCALL)
+		return 0;
+
+#ifdef CONFIG_BPF_LSM
+	if (prog->type == BPF_PROG_TYPE_LSM &&
+	    prog->aux->attach_btf_id != bpf_lsm_socket_sendmsg_id[0])
+		return 0;
+#endif
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
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&ksock_init_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					       &ksock_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					       &ksock_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
+						  ARRAY_SIZE(bpf_ksock_dtors),
+						  THIS_MODULE);
+}
+
+late_initcall(bpf_ksock_kfunc_init);
--
2.34.1

